import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
    spacing: 6

    // Image {
    //     width: 14
    //     height: 14
    //     sourceSize.width: 20
    //     sourceSize.height: 20
    //     fillMode: Image.PreserveAspectFit
    //     source: "image://icon/" + (Hyprland.activeToplevel?.lastIpcObject.class ?? "application-x-executable")
    //     clip: true
    // }

    Text {
        Layout.maximumWidth: 150
        text: Hyprland.activeToplevel?.title ?? ""
        color: Theme.text
        font.pixelSize: Theme.fontSize
        font.family: Theme.font
        maximumLineCount: 1
        elide: Text.ElideRight
    }
}
