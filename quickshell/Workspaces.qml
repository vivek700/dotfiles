import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

RowLayout {
    id: root
    spacing: 8 // Gap between workspace dots

    Repeater {
        model: 3 


        Text {
          text: index + 1
        }
    }
}
