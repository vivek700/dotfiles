import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

Item {
    id: root
    width: row.implicitWidth
    height: row.implicitHeight

    property var sink: Pipewire.defaultAudioSink
    property var source: Pipewire.defaultAudioSource
    property bool headphones: false

    PwObjectTracker {
        objects: [sink, source].filter(x => x != null)
    }

    function safeVolume(node) {
        if (!node?.ready)
            return 0;
        const vol = node.audio?.volume;
        return isNaN(vol) ? 0 : Math.round(vol * 100);
    }

    function safeMuted(node) {
        if (!node?.ready)
            return false;
        return node.audio?.muted ?? false;
    }

    Process {
        id: portProc
        command: ["sh", "-c", "pactl list sinks | grep 'Active Port'"]
        stdout: SplitParser {
            onRead: line => {
                if (!line)
                    return;
                root.headphones = line.includes("headphone");
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            portProc.running = false;
            portProc.running = true;
        }
    }

    Process {
        id: pavucontrolProc
        command: ["pavucontrol"]
    }

    RowLayout {
        id: row
        spacing: 8

        Text {
            text: {
                const vol = safeVolume(sink);
                const muted = safeMuted(sink);
                const icon = muted ? "\uf466" : root.headphones ? "\uf025" : vol < 33 ? "\uf027" : "\uF028";
                return icon + " " + vol + "%";
            }
            color: safeMuted(sink) ? Theme.muted : Theme.text
            font.pixelSize: Theme.fontSize
            font.family: Theme.font

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton) {
                        if (sink?.ready)
                            sink.audio.muted = !sink.audio.muted;
                    } else {
                        pavucontrolProc.running = false;
                        pavucontrolProc.running = true;
                    }
                }
                onWheel: event => {
                    if (!sink?.ready)
                        return;
                    const vol = sink.audio.volume;
                    if (isNaN(vol))
                        return;
                    sink.audio.volume = event.angleDelta.y > 0 ? Math.min(1.0, vol + 0.05) : Math.max(0.0, vol - 0.05);
                }
            }
        }

        Text {
            text: {
                const vol = safeVolume(source);
                const muted = safeMuted(source);
                return (muted ? "\uf131" : "\uf130") + " " + vol + "%";
            }
            color: safeMuted(source) ? Theme.muted : Theme.text
            font.pixelSize: Theme.fontSize
            font.family: Theme.font

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton) {
                        if (source?.ready)
                            source.audio.muted = !source.audio.muted;
                    } else {
                        pavucontrolProc.running = false;
                        pavucontrolProc.running = true;
                    }
                }
                onWheel: event => {
                    if (!source?.ready)
                        return;
                    const vol = source.audio.volume;
                    if (isNaN(vol))
                        return;
                    source.audio.volume = event.angleDelta.y > 0 ? Math.min(1.0, vol + 0.05) : Math.max(0.0, vol - 0.05);
                }
            }
        }
    }
}
