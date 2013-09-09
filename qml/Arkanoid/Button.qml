import QtQuick 2.0

Item {
    id: button
    property alias background:rect.color;
    property alias textColor: label.color
    property alias text: label.text
    property alias font: label.font

    property alias pressed: mouseArea.pressed

    signal clicked ()

    width: 100
    height: 62

    Rectangle {
        id: rect
        anchors.fill: parent
        opacity: 0.70
    }

    Text{
        anchors.centerIn: parent
        id: label

        color: "white"
        font{
            pixelSize: parent.height*0.75
            family: "Verdana"
            bold: true
        }
    }

    MouseArea{
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent
        onClicked: button.clicked ()
        onEntered:  button.state = "hover"
        onExited: button.state = ""
    }
    states: [
        State {
            name: "hover"
            PropertyChanges {
                target: rect
                opacity:0.9
            }
        }
    ]
    Transition {
            NumberAnimation { target: target;properties: "opacity";  duration: 200 }
        }
}
