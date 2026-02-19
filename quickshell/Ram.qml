import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    width: label.width
    height: label.height

    property int usage: 0

    Process {
        id: proc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: line => {
                if (!line)
                    return;
                const parts = line.trim().split(/\s+/);
                const used = parseInt(parts[2]) || 0;
                const total = parseInt(parts[1]);
                root.usage = Math.round((used / total) * 100);
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            proc.running = false;
            proc.running = true;
        }
    }

    Text {
        id: label
        text: "\uefc5 " + root.usage + "%"
        font.family: Theme.font
        font.pixelSize: Theme.fontSize
        color: Theme.accent
    }
}
