import QtQuick
import Felgo
import QtMultimedia

Item {

    id: rootId

    property string value:  "hello world"
    property var code:      ".... . .-.. .-.. --- / .-- --- .-. .-.. -.."

    readonly property var morseMap: {
        'a': '.-',
        'b': '-...',
        'c': '-.-.',
        'd': '-..',
        'e': '.',
        'f': '..-.',
        'g': '--.',
        'h': '....',
        'i': '..',
        'j': '.---',
        'k': '-.-',
        'l': '.-..',
        'm': '--',
        'n': '-.',
        'o': '---',
        'p': '.--.',
        'q': '--.-',
        'r': '.-.',
        's': '...',
        't': '-',
        'u': '..-',
        'v': '...-',
        'w': '.--',
        'x': '-..-',
        'y': '-.--',
        'z': '--..',
        '1': '.----',
        '2': '..---',
        '3': '...--',
        '4': '....-',
        '5': '.....',
        '6': '-....',
        '7': '--...',
        '8': '---..',
        '9': '----.',
        '0': '-----',
        ' ': '/'
    }

    readonly property int unitTime:        300
    readonly property int dotTime:         1*unitTime
    readonly property int dashTime:        3*unitTime
    readonly property int spaceTime:       6*unitTime
    readonly property int seperatorTime:   1*unitTime

    MediaPlayer {
        id: morseMPId
        audioOutput: AudioOutput {}
        source: "./../../assets/sounds/bleep.mp3"
    }

    GameButton {
        text: "|>"
        onClicked: {
            morseTimerId.start()
        }
    }

    Timer {
        id:                             morseTimerId
        property int index:             0
        onTriggered: {
            morseMPId.stop()
            print(index + " " + interval)
            if(index >= code.length) {
                index = 0
                return
            }
            switch(code[index++]) {
            case '.':
                runPulse(dotTime, true)
                break;
            case '_':
                runPulse(dashTime, true)
                break;
            case ' ':
                runPulse(spaceTime, false)
                break;
            }
            runPulse(seperatorTime, false)
        }
    }

    function playMorse() {
        for(let pulse of code) {
            print("pulse " + pulse)
                switch(pulse) {

                }

            }
    }

    function runPulse(pulseTime, soundFlag) {
        morseTimerId.interval = pulseTime
        if(soundFlag)
            morseMPId.play()
        morseTimerId.start()
    }
}
