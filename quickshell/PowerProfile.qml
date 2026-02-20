import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    width: label.width
    height: label.height

    property string profile: "balanced"

    readonly property var profiles: ["power-saver", "balanced", "performance"]
    readonly property var icons: ({
            "power-saver": "\uf583",
            "balanced": "\udb85\udc0b",
            "performance": "\uf4bc"
        })

    Process {
        id: getProc
        command: ["sh", "-c", "powerprofilesctl get"]
        stdout: SplitParser {
            onRead: line => {
                if (!line)
                    return;
                root.profile = line.trim();
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: setProc
        property string nextProfile: "balanced"
        command: ["sh", "-c", "powerprofilesctl set " + nextProfile]
        onExited: {
            getProc.running = false;
            getProc.running = true;
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            getProc.running = false;
            getProc.running = true;
        }
    }

    Text {
        id: label
        text: (root.icons[root.profile] ?? "\uf242")
        color: root.profile === "performance" ? Theme.accent : root.profile === "power-saver" ? Theme.muted : Theme.text
        font.pixelSize: Theme.fontSize
        font.family: Theme.font

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                const idx = root.profiles.indexOf(root.profile);
                const next = root.profiles[(idx + 1) % root.profiles.length];
                setProc.nextProfile = next;
                setProc.running = false;
                setProc.running = true;
            }
        }
    }
}
