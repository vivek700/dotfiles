import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
    id: root
    width: btn.width
    height: btn.height

    property bool open: false
    property var panelWindow

    Process {
        id: logoutProc
        command: ["sh", "-c", "hyprctl dispatch exec hyprshutdown"]
    }
    Process {
        id: poweroffProc
        command: ["sh", "-c", "hyprctl dispatch exec 'hyprshutdown --post-cmd \"shutdown now\"'"]
    }
    Process {
        id: rebootProc
        command: ["sh", "-c", "hyprctl dispatch exec 'hyprshutdown --post-cmd reboot'"]
    }
    Process {
        id: suspendProc
        command: ["sh", "-c", "systemctl suspend"]
    }

    Text {
        id: btn
        text: "\uf011"
        color: Theme.accent
        font.pixelSize: Theme.fontSize
        font.family: Theme.font

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.open = !root.open
        }
    }

    PopupWindow {
        id: popup
        anchor.window: PanelWindow
        visible: root.open
        anchor.item: btn
        anchor.edges: Edges.Bottom
        anchor.gravity: Edges.Bottom
        implicitWidth: menuRow.implicitWidth + 20
        implicitHeight: 50
        color: "transparent"

        Rectangle {
            anchors.topMargin: 8
            anchors.fill: parent
            color: Theme.surface
            radius: 8
            border.color: Theme.accent
            border.width: 2

            RowLayout {
                id: menuRow
                anchors.centerIn: parent
                spacing: 16

                Repeater {
                    model: [
                        {
                            icon: "\uf011",
                            label: "Shutdown",
                            proc: poweroffProc
                        },
                        {
                            icon: "\uf017",
                            label: "Reboot",
                            proc: rebootProc
                        },
                        {
                            icon: "\uf186",
                            label: "Suspend",
                            proc: suspendProc
                        },
                        {
                            icon: "\uf2f5",
                            label: "Logout",
                            proc: logoutProc
                        }
                    ]

                    delegate: Text {
                        id: delegateItem
                        required property var modelData
                        text: modelData.icon
                        color: Theme.text
                        font.pixelSize: Theme.fontSizeLg
                        font.family: Theme.font

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root.open = false;
                                delegateItem.modelData.proc.running = false;
                                delegateItem.modelData.proc.running = true;
                            }
                        }
                    }
                }
            }
        }
    }
}
