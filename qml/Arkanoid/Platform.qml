import QtQuick 2.0
import Box2D 1.0

Body {
    id: platform
    width: 98
    height: 18
    x: parent.width/2 - width/2

    bodyType: Body.Static
    fixtures: Box {
        id: platformBox
        anchors.fill: parent
        friction: 100
        density: 3000;
    }

    Rectangle{
        id: platformBg
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        drag.target: platform
        drag.axis: Drag.XAxis
        drag.minimumX: 0
        drag.maximumX: screen.width - platform.width
    }
}
