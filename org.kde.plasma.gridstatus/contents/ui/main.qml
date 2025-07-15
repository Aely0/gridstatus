import QtQuick
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.private.timer as Exec

PlasmoidItem {
    id: root

    readonly property bool inPanel: [PlasmaCore.Types.TopEdge, PlasmaCore.Types.RightEdge, PlasmaCore.Types.BottomEdge, PlasmaCore.Types.LeftEdge].includes(
        Plasmoid.location)

    preferredRepresentation: compactRepresentation
    compactRepresentation: CompactRepresentation {}
    fullRepresentation: Item {}

    Plasmoid.backgroundHints: PlasmaCore.Types.ShadowBackground

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.MiddleButton
        onClicked: Exec.Timer.runCommand("plasma-systemmonitor")
    }

    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: "Open System Monitor"
            icon.name: "utilities-system-monitor"
            onTriggered: Exec.Timer.runCommand("plasma-systemmonitor")
        }
    ]
}
