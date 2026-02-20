import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    width: label.width
    height: label.height

    property int count: 0

    Process {
        id: countProc
        command: ["sh", "-c", "dunstctl count waiting"]
        stdout: SplitParser {
            onRead: line => {
                if (!line)
                    return;
                const n = parseInt(line.trim());
                root.count = isNaN(n) ? 0 : n;
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: historyProc
        command: ["sh", "-c", "dunstctl history-pop"]
    }

    Process {
        id: closeAllProc
        command: ["sh", "-c", "dunstctl close-all"]
        onExited: {
            countProc.running = false;
            countProc.running = true;
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            countProc.running = false;
            countProc.running = true;
        }
    }

    Text {
        id: label
        leftPadding: 2
        text: "\uf0f3" + (root.count > 0 ? " " + root.count : "")
        color: root.count > 0 ? Theme.accent : Theme.muted
        font.pixelSize: Theme.fontSize
        font.family: Theme.font

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: mouse => {
                if (mouse.button === Qt.LeftButton) {
                    historyProc.running = false;
                    historyProc.running = true;
                } else {
                    closeAllProc.running = false;
                    closeAllProc.running = true;
                }
            }
        }
    }
}
