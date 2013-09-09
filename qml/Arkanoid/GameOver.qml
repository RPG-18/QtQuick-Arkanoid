import QtQuick 2.0

Item  {
    id: page
    width: 320
    height: 580

    signal newGame();

    FontLoader{
        id: anarchy
        source: "./fonts/digitalanarchy-Regular.ttf"
    }

    Text {
        y: 79
        width: 304
        height: 178
        text: qsTr("Game Over")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font{
            pixelSize: 35
            family: anarchy.name
        }
        anchors{
            horizontalCenter: parent.horizontalCenter
        }

        color: "#f70c0c"
    }

    Button {
        y: 350
        width: 198
        height: 62
        text: "New Game"
        textColor: "#000000"
        background: "#e6f3e6"

        font{
            pixelSize: 25
            family: "Vardana"
        }

        anchors{
            horizontalCenter: parent.horizontalCenter
        }

        onClicked: page.newGame ();
    }

    Button {
        y: 451
        width: 198
        height: 62
        text: "Quit"
        textColor: "#000000"
        background: "#e6f3e6"

        font{
            pixelSize: 25
            family: "Vardana"
        }

        anchors{
            horizontalCenter: parent.horizontalCenter
        }

        onClicked: Qt.quit();
    }
}
