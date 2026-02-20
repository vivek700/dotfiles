pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string time: Qt.formatDateTime(clock.date, "ddd, d MMM | hh:mm:ss AP")

    readonly property string date: Qt.formatDate(clock.date, "d-MM-yyyy")

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
