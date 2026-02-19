import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
    spacing: 6

    property int maxWorkspace: Math.max(3, ...Hyprland.workspaces.values.map(ws => ws.id))

    Repeater {
        model: parent.maxWorkspace
        delegate: Rectangle {
            id: root
            required property int index
            readonly property int wsNumber: index + 1
            readonly property bool isActive: Hyprland.focusedMonitor.activeWorkspace.id === wsNumber

            width: 24
            height: 24
            radius: 6
            color: isActive ? Theme.accent : "transparent"
            border.color: Theme.accent
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: root.wsNumber
                color: parent.isActive ? Theme.surface : Theme.accent
                font.pixelSize: Theme.fontSize
                font.bold: parent.isActive
                font.family: Theme.font
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + root.wsNumber)
            }
        }
    }
}
