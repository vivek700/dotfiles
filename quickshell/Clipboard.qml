import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    width: label.width
    height: label.height

    Process {
        id: clipProc
        command: ["sh", "-c", "cliphist list | wofi --dmenu --width 500 --height 300 --cache-file /dev/null | cliphist decode | wl-copy"]
    }

    Process {
        id: clearProc
        command: ["sh", "-c", "rm ~/.cache/cliphist/db && notify-send 'Clipboard Cleared'"]
    }

    Text {
        id: label
        text: "\udb84\ude68"
        color: Theme.text
        font.pixelSize: Theme.fontSize
        font.family: Theme.font

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: mouse => {
                if (mouse.button === Qt.LeftButton) {
                    clipProc.running = false;
                    clipProc.running = true;
                } else {
                    clearProc.running = false;
                    clearProc.running = true;
                }
            }
        }
    }
}
