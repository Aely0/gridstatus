import QtQuick
import QtQuick.Layouts
import org.kde.ksysguard.sensors as Sensors

// model: ["cpu/cpu0/usage", "cpu/cpu1/usage", "cpu/cpu2/usage", "cpu/cpu3/usage", "memory/physical/usedPercent", "memory/swap/usedPercent"]

GridLayout {
    id: compactRepresentation

    rowSpacing: 0
    columnSpacing: Math.floor(textMetrics.width * 0.1)

    readonly property var colorGradient: [
        "#8ca0d4", "#8da0d4", "#8f9fd5", "#909fd5", "#929ed6", "#939ed6", "#959dd7", "#969dd7", "#979cd7", "#999cd8",
        "#9a9bd8", "#9b9bd9", "#9d9ad9", "#9e9ada", "#9f99da", "#a199da", "#a298db", "#a398db", "#a597dc", "#a697dc",
        "#a796dd", "#a896dd", "#aa95dd", "#ab95de", "#ac94de", "#ad93df", "#af93df", "#b092e0", "#b192e0", "#b291e0",
        "#b391e1", "#b590e1", "#b68fe2", "#b78fe2", "#b88ee3", "#b98ee3", "#bb8de3", "#bc8ce4", "#bd8ce4", "#be8be5",
        "#bf8ae5", "#c08ae6", "#c289e6", "#c389e6", "#c488e7", "#c587e7", "#c687e8", "#c786e8", "#c885e9", "#c984e9",
        "#cb84e9", "#cc83ea", "#cd82ea", "#ce82eb", "#cf81eb", "#d080ec", "#d17fec", "#d27fec", "#d37eed", "#d57ded",
        "#d67cee", "#d77cee", "#d87bef", "#d97aef", "#da79ef", "#db78f0", "#dc77f0", "#dd77f1", "#de76f1", "#df75f2",
        "#e074f2", "#e173f2", "#e272f3", "#e371f3", "#e470f4", "#e66ff4", "#e76ef5", "#e86df5", "#e96df5", "#ea6cf6",
        "#eb6bf6", "#ec69f7", "#ed68f7", "#ee67f8", "#ef66f8", "#f065f9", "#f164f9", "#f263f9", "#f362fa", "#f461fa",
        "#f55ffb", "#f65efb", "#f75dfc", "#f85cfc", "#f95afc", "#fa59fd", "#fb58fd", "#fc56fe", "#fd55fe", "#fe53ff",
        "#ff52ff"]

    readonly property int fontSize: root.inPanel ? Math.ceil(height * 0.4) : 20
    readonly property string fontFamily: "Consolas"

    function leftPad(reading) {
        if (reading < 10) {
            return textMetrics.width * 0.3333
        }
        if (reading < 100) {
            return textMetrics.width * 0.1666
        }
        if (reading == 100) {
            return 0
        }
    }

    TextMetrics {
        id: textMetrics
        font.family: fontFamily
        font.pixelSize: fontSize
        text: "100"
    }

    Repeater {
        model: 4
        ColumnLayout {
            spacing: rowSpacing
            Layout.minimumWidth: textMetrics.width
            Layout.maximumWidth: textMetrics.width
            required property int index
            Text {
                property int reading: Math.floor(sensorUsage.value)
                // property int reading: 100

                leftPadding: leftPad(reading)
                font.pixelSize: fontSize
                font.family: fontFamily
                text: reading
                color: colorGradient[reading]

                Sensors.Sensor {
                    id: sensorUsage
                    sensorId: "cpu/cpu" + index + "/usage"
                }
            }
            Text {
                property int reading: Math.floor(sensorTemp.value)

                leftPadding: leftPad(reading)
                font.pixelSize: fontSize
                font.family: fontFamily
                text: reading
                color: colorGradient[reading]

                Sensors.Sensor {
                    id: sensorTemp
                    sensorId: "cpu/cpu" + index + "/temperature"
                }
            }
        }
    }

    ColumnLayout {
        spacing: rowSpacing
        Layout.minimumWidth: textMetrics.width
        Layout.maximumWidth: textMetrics.width
        Text {
            property int reading: Math.floor(sensorPhysical.value)

            leftPadding: leftPad(reading)
            font.pixelSize: fontSize
            font.family: fontFamily
            text: reading
            color: colorGradient[reading]

            Sensors.Sensor {
                id: sensorPhysical
                sensorId: "memory/physical/usedPercent"
            }
        }

        Text {
            property int reading: Math.floor(sensorSwap.value)

            leftPadding: leftPad(reading)
            font.pixelSize: fontSize
            font.family: fontFamily
            text: reading
            color: colorGradient[reading]

            Sensors.Sensor {
                id: sensorSwap
                sensorId: "memory/swap/usedPercent"
            }
        }
    }
}
