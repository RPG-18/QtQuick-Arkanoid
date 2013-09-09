import QtQuick 2.0
import Box2D 1.0
import Arkanoid 1.0
import "./constants.js" as Constants

Item {
    id: screen
    width: 320
    height: 580

    signal gameOver();

    property int score:0;
    property int lives: 4;
    property int startBrickX : 0
    property int startBrickY : 80

    World {
        id: world
        width: parent.width
        height: parent.height
        property int bricks: 0

        gravity.x: 0
        gravity.y: 0

        Wall {
            id: wallLeft

            width: 10
            anchors {
                bottom: parent.bottom
                left: parent.left
                leftMargin: -width
                top: parent.top
            }
        }

        Wall {
            id: wallRight

            width: 10
            anchors {
                bottom: parent.bottom
                right: parent.right
                rightMargin: -width
                top: parent.top
            }
        }

        Wall {
            id: wallTop
            x: 0
            y: 0
            width: 320

            height: 50
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }
            Rectangle{
                height: 2;
                width: 2
                anchors{
                    left:parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
            }
            Text {
                text: qsTr("score")+" : "+score;

                visible: true
                color: "white"
                font{
                    family: "Verdana"
                    pixelSize: 18
                }

                anchors {
                    verticalCenter: parent.verticalCenter;
                    left:parent.left
                    margins: 10
                }
            }
            Row{
                anchors{
                    right: parent.right
                    verticalCenter: parent.verticalCenter;
                    margins: 10
                }

                spacing: 4
                Repeater{
                    model: screen.lives

                    Rectangle{
                        width: 10
                        height: 10
                        radius: 5
                        color:"red"
                    }
                }
            }
        }

        Wall {
            id: wallBottom

            height: 10
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                bottomMargin: -height
            }
            onBeginContact: {
                if(screen.lives>0){
                    --screen.lives;
                }else{
                    screen.endGame ();
                }
            }
        }

        Ball {
            id: ball
            x: parent.width/2
            y: parent.height/2
            active: true

            function toStartPosition (){
                ball.x = world.width/2;
                ball.y = world.height/2;
            }
        }


        MapInfo{
            id: mapInfo
            source: "qml/Arkanoid/maps/level1.txt"
        }

        Item{
            anchors.fill: parent
            id:brickContainer
        }

        Platform{
            y:screen.height-80
        }
        Timer{
            interval: 100
            running: true
            onTriggered: screen.loadMap ()
        }
    }
    MouseArea{
        width: parent.width
        height: parent.height/2
        onClicked: {
            ball.applyLinearImpulse(Qt.point(50, 300), Qt.point(ball.x, ball.y))
            if(!ball.active){
                ball.active = true
            }
        }
    }

    function newGame (){
        clearMap ();
        loadMap ();
        ball.toStartPosition ();
        screen.lives = 4;
        screen.score = 0;
    }

    function clearMap (){
        var children = world.data;
        for(var item = 0; item< children.length; ++item){
            if(children[item].objectName === "brick"){
                children[item].destroy();
            }
        }
    }

    function incrementScore(value){
        screen.score += value;
    }

    function decrementBricks (){
        --world.bricks;
        if(world.bricks <1){
            endGame ();
        }
    }

    function endGame (){
        ball.active = false;
        ball.applyLinearImpulse(Qt.point(0,0), Qt.point(ball.x, ball.y))
        screen.gameOver();
    }

    function loadMap (){
        var brickWidth = world.width/mapInfo.columns
        var bricks = 0;

        for(var row=0; row<mapInfo.rows; ++row){
            for (var col = 0; col<mapInfo.columns; ++col){
                if(mapInfo.get(row, col) ===0 ){
                    continue;
                }
                ++bricks;

                var component = Qt.createComponent("Brick.qml");
                if (component.status == Component.Ready){
                    var x = startBrickX + col*brickWidth;
                    var y = startBrickY + row*Constants.brickHeight;
                    component.createObject(world, {
                                               "x": x,
                                               "y": y,
                                               "width":brickWidth,
                                               "objectName":"brick",
                                               "contacts":mapInfo.get(row,col)});

                }else{
                    console.log("not ready")
                }
            }
        }

        world.bricks = bricks;
    }
}
