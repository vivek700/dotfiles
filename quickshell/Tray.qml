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
            width: 18
            height: 18
            sourceSize.width: 18
            sourceSize.height: 18
            source: modelData.icon

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: mouse => {
                    if (mouse.button === Qt.RightButton || trayIcon.modelData.onlyMenu) {
                        const pos = trayIcon.mapToItem(null, 0, trayIcon.height);
                        trayIcon.modelData.display(panelWindow, pos.x, pos.y);
                    } else
                        trayIcon.modelData.activate();
                }
            }
        }
    }
}
