import QtQuick
import Quickshell

Item {
    id: root
    property var panelWindow
    property bool displayDate: false
    width: clockText.width
    height: clockText.height
    Text {
        id: clockText
        color: Theme.accent
        font.family: Theme.font
        font.pixelSize: Theme.fontSize
        text: root.displayDate ? Time.date : Time.time
    }

    HoverHandler {
        id: hover
        onHoveredChanged: {
            if (hover.hovered) {
                delayTimer.start();
            } else {
                delayTimer.stop();
                calendarPopup.visible = false;
                calWidget.opacity = 0;
                calWidget.scale = 0.9;
                calWidget.currentMonth = new Date().getMonth();
                calWidget.currentYear = new Date().getFullYear();
            }
        }
    }
    Timer {
        id: delayTimer
        interval: 500  // ms delay
        onTriggered: {
            calendarPopup.visible = true;
            calWidget.scale = 0.9;
            showAnim.start();
        }
    }

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        onWheel: event => {
            if (event.angleDelta.y < 0) {
                if (calWidget.currentMonth === 11) {
                    calWidget.currentMonth = 0;
                    calWidget.currentYear++;
                } else {
                    calWidget.currentMonth++;
                }
            } else {
                if (calWidget.currentMonth === 0) {
                    calWidget.currentMonth = 11;
                    calWidget.currentYear--;
                } else {
                    calWidget.currentMonth--;
                }
            }
        }
        onClicked: mouse => {
            root.displayDate = !root.displayDate;
        }
    }

    PopupWindow {
        id: calendarPopup
        visible: false
        anchor.margins.top: 22
        anchor.window: root.panelWindow
        anchor.item: clockText
        anchor.edges: Edges.Bottom
        anchor.gravity: Edges.Bottom
        implicitWidth: 300
        implicitHeight: 230
        color: "transparent"

        CalendarWidget {
            id: calWidget
            anchors.fill: parent
            opacity: 0
            transformOrigin: Item.Top

            NumberAnimation {
                id: showAnim
                target: calWidget
                properties: "opacity,scale"
                from: 0
                to: 1
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
    }
}
