import QtQuick 2.0
import Box2D 1.0

Body {
    id: ball

    fixedRotation: false
    sleepingAllowed: false

    fixtures: Circle {
        id: circle
        radius: 12
        anchors.fill: parent
        density: 2;
        friction: 0;
        restitution: 1.005;
    }
    Image {
        id: circleImage
        source: "./images/ball.png"
        anchors.centerIn: parent
        width: circle.radius * 2
        height: width
        smooth: true
    }
}
