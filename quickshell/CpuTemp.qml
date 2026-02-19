import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    width: label.width
    height: label.height

    property int temp: 0

    Process {
        id: proc
        command: ["sh", "-c", "cat /sys/class/thermal/thermal_zone1/temp"]
        stdout: SplitParser {
            onRead: line => {
                if (!line)
                    return;
                root.temp = Math.round(parseInt(line) / 1000);
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
        text: "\uf2c9 " + root.temp + "°C"
        font.family: Theme.font
        font.pixelSize: Theme.fontSize
        color: Theme.accent
    }
}
