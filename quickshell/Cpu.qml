import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    width: label.width
    height: label.height

    property var prevIdle: 0
    property var prevTotal: 0
    property int usage: 0
    Process {
        id: proc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: line => {
                if (!line)
                    return;
                const parts = line.trim().split(/\s+/);
                const idle = parseInt(parts[4]) + parseInt(parts[5]);
                const total = parts.slice(1, 8).reduce((a, b) => a + parseInt(b), 0);
                const diffIdle = idle - root.prevIdle;
                const diffTotal = total - root.prevTotal;
                if (diffTotal > 0)
                    root.usage = Math.round((1 - diffIdle / diffTotal) * 100);
                root.prevIdle = idle;
                root.prevTotal = total;
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            proc.running = false;
            proc.running = true;
        }
    }
    Text {
        id: label
        text: "\uf4bc " + root.usage + "%"
        font.family: Theme.font
        font.pixelSize: Theme.fontSize
        color: Theme.accent
    }
}
