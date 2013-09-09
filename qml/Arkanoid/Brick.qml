import QtQuick 2.0
import Box2D 1.0
import "./constants.js" as Constants

Body {
    id: brick
    height: Constants.brickHeight
    width: 50

    signal disappear()
    property int contacts:1;
    property int gamePoints:0

    bodyType: Body.Static
    fixtures: Box {
        anchors.fill: parent
        friction: 1.0
        density: 2;

        onBeginContact: {
            --brick.contacts;
            brick.gamePoints+=Constants.onePoint
        }

        onEndContact: {
            if(brick.contacts<1){
                destroyItem();
            }
        }
    }

    Rectangle {
        id: brickRect
        anchors{
            fill: parent
            margins: 1
        }
        color:brick.getColor(brick.contacts)
    }

    function getColor (number){
        if(brick.contacts!=0){
            return Constants.brickColors[brick.contacts]
        }else{
            return "black"
        }
    }
    function destroyItem(){
        brick.disappear();
        brick.destroy();
        incrementScore(brick.gamePoints);
        decrementBricks ();
    }
}
