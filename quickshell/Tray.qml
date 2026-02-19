import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

RowLayout {
    spacing: 6

    property var panelWindow

    Repeater {
        model: SystemTray.items
        delegate: Image {
            id: trayIcon
            required property SystemTrayItem modelData
            width: 16
            height: 16
            sourceSize.width: 16
            sourceSize.height: 16
            source: modelData.icon

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: mouse => {
                    if (mouse.button === Qt.RightButton || modelData.onlyMenu) {
                        const pos = trayIcon.mapToItem(null, 0, trayIcon.height);
                        modelData.display(panelWindow, pos.x, pos.y);
                    } else
                        modelData.activate();
                }
            }
        }
    }
}
