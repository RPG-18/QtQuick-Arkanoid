import QtQuick 2.0

Item  {
    id: main
    width: 320
    height: 580
    Image{
        anchors.fill: parent
        source: "./images/carbon.png"
        fillMode: Image.Tile
    }

    Title{
        id: title
        anchors.fill: parent
        onNewGame: {
            game.newGame ();
            main.state = "Play";
        }
    }

    Game{
        id: game
        visible: false
        anchors.fill: parent

        onGameOver: {
            main.state = "EndGame";
        }
    }
    GameOver{
        id:gameOver
        visible: false
        anchors.fill: parent
        onNewGame: {
            game.newGame ();
            main.state = "Play";
        }
    }

    states: [
        State {
            name: "Play"
            PropertyChanges{
                target: gameOver
                visible: false
            }
            PropertyChanges{
                target: title
                visible: false
            }
            PropertyChanges{
                target: game
                visible: true
            }
        },
        State {
            name: "EndGame"
            PropertyChanges{
                target: gameOver
                visible: true
            }
            PropertyChanges{
                target: title
                visible: false
            }
            PropertyChanges{
                target: game
                visible: false
            }
        }
    ]
}
