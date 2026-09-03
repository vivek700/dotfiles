import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

RowLayout {
    id: root
    spacing: 6
    visible: !!root.player

    readonly property var player: Mpris.players.values.find(p => p.isPlaying) ?? Mpris.players.values.find(p => p.playbackState !== MprisPlaybackState.Stopped)

    Text {
        text: root.player?.isPlaying ? "" : ""
        color: Theme.accent
        font.pixelSize: Theme.fontSize
        font.family: Theme.font

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.player?.togglePlaying()
        }
    }

    Text {
        Layout.maximumWidth: 180
        text: root.player ? (root.player.trackArtist ? root.player.trackArtist + " - " + root.player.trackTitle : root.player.trackTitle) : ""
        color: Theme.text
        font.pixelSize: Theme.fontSize
        font.family: Theme.font
        maximumLineCount: 1
        elide: Text.ElideRight
    }
}
