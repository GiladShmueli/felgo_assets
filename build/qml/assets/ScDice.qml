import QtQuick
import Felgo

Item {

    id:                     rootId
    width:                  30
    height:                 30

    property int sidesNum:  6
    property int upside:    1
    property bool locked:   false
    property int minValue:  1
    property int maxValue:  6

    Image {
        id:                 diceImageId
        source:             ""
    }

    MouseArea {
        id:                 diceMouseAreaId
        anchors.fill:       parent
        onClicked:          upside = getRandomInt(minValue, maxValue)
    }

    Text {
        text: "value: " + upside
    }

    // Generate a random integer between min and max (inclusive)
    function getRandomInt(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }
}
