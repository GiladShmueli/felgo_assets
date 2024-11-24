import QtQuick
import Felgo
import QtMultimedia

Item {

    id: rootId

    property string value:  "hello world"
    property string code:   ".... . .-.. .-.. --- /.-- --- .-. .-.. -.."

    property int index:             0

    readonly property var charToMorseMap: {
        'a':        '.-',
        'b':        '-...',
        'c':        '-.-.',
        'd':        '-..',
        'e':        '.',
        'f':        '..-.',
        'g':        '--.',
        'h':        '....',
        'i':        '..',
        'j':        '.---',
        'k':        '-.-',
        'l':        '.-..',
        'm':        '--',
        'n':        '-.',
        'o':        '---',
        'p':        '.--.',
        'q':        '--.-',
        'r':        '.-.',
        's':        '...',
        't':        '-',
        'u':        '..-',
        'v':        '...-',
        'w':        '.--',
        'x':        '-..-',
        'y':        '-.--',
        'z':        '--..',
        '1':        '.----',
        '2':        '..---',
        '3':        '...--',
        '4':        '....-',
        '5':        '.....',
        '6':        '-....',
        '7':        '--...',
        '8':        '---..',
        '9':        '----.',
        '0':        '-----',
        ' ':        '/'
    }

    readonly property var morseToCharMap: {
        '.-':       'a',
        '-...':     'b',
        '-.-.':     'c',
        '-..':      'd',
        '.':        'e',
        '..-.':     'f',
        '--.':      'g',
        '....':     'h',
        '..':       'i',
        '.---':     'j',
        '-.-':      'k',
        '.-..':     'l',
        '--':       'm',
        '-.':       'n',
        '---':      'o',
        '.--.':     'p',
        '--.-':     'q',
        '.-.':      'r',
        '...':      's',
        '-':        't',
        '..-':      'u',
        '...-':     'v',
        '.--':      'w',
        '-..-':     'x',
        '-.--':     'y',
        '--..':     'z',
        '.----':    '1',
        '..---':    '2',
        '...--':    '3',
        '....-':    '4',
        '.....':    '5',
        '-....':    '6',
        '--...':    '7',
        '---..':    '8',
        '----.':    '9',
        '-----':    '0',
        '/':        ' '
    }

    readonly property int unitTime:        350
    readonly property int dotTime:         1*unitTime
    readonly property int dashTime:        3*unitTime
    readonly property int spaceTime:       5*unitTime
    readonly property int seperatorTime:   1*unitTime

    MediaPlayer {
        id: morseMPId
        audioOutput: AudioOutput {}
        source: "./../../assets/sounds/bleep.mp3"
    }

    GameButton {
        text: "|>"
        onClicked: {
            playMorseCode()
        }
    }

    Timer {
        id:                             morseTimerId

        onTriggered: {
            morseMPId.stop()
            if(index >= code.length) {
                index = 0
            }
            else
                playMorseCode()
        }
    }

    function playMorseCode() {

        switch(code[index++]) {
        case '.':
            runPulse(dotTime, true)
            break;
        case '-':
            runPulse(dashTime, true)
            break;
        case ' ':
            runPulse(seperatorTime, false)
            break;
        case '/':
            runPulse(spaceTime, false)
            break;
        }
    }

    function runPulse(pulseTime, soundFlag) {
        morseTimerId.interval = pulseTime

        if(soundFlag)
            morseMPId.play()

        morseTimerId.start()
    }

    function encode(text) {
        let retval = ""

        for(let i = 0; i < text.length; i++) {
            let segment = charToMorseMap[i]
            retval += segment
            if(i < text.length - 1 || segment !== '/')
            retval += " "
        }

        return retval
    }

    function decode(morse) {
        let retval = ""
        let segment = ""

        for(pulse in morse) {
            if(pulse === ' ') {
                retval += morseToCharMap[segment]
                segment = ""
            }
            else if (pulse === '/') {
                retval += " "
                segment = ""
            }
            else {
                segment += pulse
            }
        }

        return retval
    }
}
