import Quickshell
import QtQuick.Layouts
import QtQuick

Scope {
    PanelWindow {
        id: bar
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: 34
        color: workspaces.currentHasWindows ? Theme.background : "transparent"

        Behavior on color {
            ColorAnimation {
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }

        //left side
        RowLayout {
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            spacing: 12

            Text {
                text: "\uf303" // Arch Icon
                font.family: Theme.font
                color: Theme.text
                font.pixelSize: 18
            }

            Workspaces {
                id: workspaces
            }
            WindowTitle {}
        }
        //center
        ClockWidget {
            anchors.centerIn: parent
            panelWindow: bar
        }
        // right side
        RowLayout {
            anchors.right: parent.right
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            spacing: 17

            Clipboard {}
            PipewireAudio {}
            Cpu {}
            Ram {}
            CpuTemp {}
            Notifications {}
            PowerProfile {}
            Tray {
                panelWindow: bar
            }
            PowerMenu {
                panelWindow: bar
            }
        }
    }
}
