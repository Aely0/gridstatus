import QtQuick
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore

PlasmoidItem {
    id: root

    readonly property bool inPanel: [PlasmaCore.Types.TopEdge, PlasmaCore.Types.RightEdge, PlasmaCore.Types.BottomEdge, PlasmaCore.Types.LeftEdge].includes(
        Plasmoid.location)

    preferredRepresentation: compactRepresentation
    compactRepresentation: CompactRepresentation {}
    fullRepresentation: Item {}

    Plasmoid.backgroundHints: PlasmaCore.Types.ShadowBackground
}
