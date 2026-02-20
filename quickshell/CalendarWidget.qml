import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: Theme.surface
    radius: 8
    border.color: Theme.accent
    border.width: 2
    width: 230
    height: 230

    property int currentMonth: new Date().getMonth()
    property int currentYear: new Date().getFullYear()

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 4

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: Qt.formatDate(new Date(root.currentYear, root.currentMonth, 1), "MMMM yyyy")
            color: "#f1668b"
            font.pixelSize: 15
            font.bold: true
            font.family: Theme.font
        }

        DayOfWeekRow {
            Layout.fillWidth: true
            locale: Qt.locale()
            delegate: Text {
                required property string shortName
                text: shortName
                color: "#f1668b"
                font.pixelSize: 12
                font.family: Theme.font
                horizontalAlignment: Text.AlignHCenter
            }
        }

        MonthGrid {
            id: grid
            month: root.currentMonth
            year: root.currentYear
            Layout.fillWidth: true
            Layout.fillHeight: true
            delegate: Item {
                id: item
                required property var model
                Text {
                    anchors.centerIn: parent
                    text: item.model.day
                    color: model.today ? Theme.accent : model.month === grid.month ? Theme.text : Theme.muted
                    font.pixelSize: 12
                    font.bold: item.model.today
                    font.family: Theme.font
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }
}
