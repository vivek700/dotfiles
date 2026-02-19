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
            readonly property bool isActive: Hyprland.focusedWorkspace?.id === wsNumber
            readonly property bool hasWindow: Hyprland.workspaces.values.some(ws => ws.id === wsNumber)

            width: 22
            height: 24
            radius: 4
            color: isActive ? Theme.accent : 'transparent'

            Text {
                anchors.centerIn: parent
                text: root.wsNumber
                color: isActive ? Theme.surface : hasWindow ? Theme.accent : Theme.muted
                font.pixelSize: Theme.fontSize
                font.bold: root.isActive
                font.family: Theme.font
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + root.wsNumber)
            }
        }
    }
}
