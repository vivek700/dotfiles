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
        implicitHeight: 30
        color: Theme.background

        //left side
        RowLayout {
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            spacing: 12

            Text {
                text: "\uf303" // Arch Icon
                font.family: "JetBrainsMono Nerd Font"
                color: Theme.text
                font.pixelSize: 18
            }

            Workspaces {}
        }
        ClockWidget {
            anchors.centerIn: parent
            panelWindow: bar
        }
    }
}
