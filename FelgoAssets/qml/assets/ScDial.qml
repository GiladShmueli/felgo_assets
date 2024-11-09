import QtQuick
import Felgo

Item {
    id: rootId

    property real joystickRadius:           60
    property real knobRectRadius:           15
    property real joystickDiameter:         joystickRadius * 2
    property real knobRectDiameter:         knobRectRadius * 2
    property real knobRectCenterX:          joystickRadius - knobRectRadius
    property real knobRectCenterY:          joystickRadius - knobRectRadius

    property real trValue:                  0.00
    property real elValue:                  0.00
    property real minTrValue:               -1.00
    property real minElValue:               -1.00
    property real maxTrValue:               1.00
    property real maxElValue:               1.00

    property point lastMousePos: Qt.point(0, 0)

    width:      joystickDiameter
    height:     childrenRect.height

    Rectangle {
        id: baseRectId
        width:                      joystickDiameter
        height:                     joystickDiameter
        radius:                     joystickRadius
        anchors.top:                rootId.top
        anchors.horizontalCenter:   rootId.horizontalCenter
        color:                      "blue"

        Rectangle {
            id:         knobRectId
            width:      knobRectDiameter
            height:     knobRectDiameter
            color:      "darkgrey"
            radius:     knobRectRadius
            x:          knobRectCenterX
            y:          20
        }


    }


    MouseArea {
        anchors.fill:       baseRectId
        anchors.centerIn:   baseRectId
        hoverEnabled: true

        onPressed: {
            getDialAngle()
        }

        onPositionChanged: {
            if(pressed && containsMouse) {
                getDialAngle()
            }
        }

        function getDialAngle() {
            var centerX = 75
            var centerY = 75
            var angle;
            //if(mouseY < centerY)
            {
                angle = Math.atan2((mouseX - centerX), -(mouseY - centerY)) * 180 / Math.PI
                //angle = (angle < -80 || angle > 80) ? baseRectId.rotation : angle
                baseRectId.rotation = angle
                //baseRectId.rotation = Math.round(angle / 40) * 40
                print("angle: ", angle)
            }
        }
    }
}



