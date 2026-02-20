import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
    id: root
    spacing: 6

    property bool currentHasWindows: {
        const ws = Hyprland.workspaces?.values?.find(w => w.id === Hyprland?.focusedMonitor?.activeWorkspace?.id);
        return ws ? ws.toplevels.values.length > 0 : false;
    }

    property int maxWorkspace: Math.max(3, ...Hyprland.workspaces.values.map(ws => ws.id))

    Repeater {
        model: root.maxWorkspace
        delegate: Rectangle {
            id: delegateRec
            required property int index
            readonly property int wsNumber: index + 1
            readonly property bool isActive: Hyprland.focusedWorkspace?.id === wsNumber
            readonly property bool hasWindow: Hyprland.workspaces.values.some(ws => ws.id === wsNumber)

            width: 21
            height: 23
            radius: 4
            color: delegateRec.isActive ? Theme.accent : 'transparent'

            Text {
                anchors.centerIn: parent
                text: delegateRec.wsNumber
                color: delegateRec.isActive ? Theme.surface : delegateRec.hasWindow ? Theme.accent : Theme.muted
                font.pixelSize: Theme.fontSize
                font.bold: delegateRec.isActive
                font.family: Theme.font
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + delegateRec.wsNumber)
            }
        }
    }
}
