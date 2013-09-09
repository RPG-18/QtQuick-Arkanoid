import QtQuick 2.0
import Box2D 1.0

Body {
    id: wall

    signal beginContact(variant other)

    bodyType: Body.Static
    fixtures: Box {
        anchors.fill: parent
        friction: 1.0

        onBeginContact: {
            wall.beginContact(other)
        }
    }
}
