import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    property string icon: ""
    property string tooltip: ""

    implicitWidth: 44
    implicitHeight: 44
    padding: 0

    background: Rectangle {
        color: mouseArea.containsMouse ? "#E8E8E8" : "transparent"
        radius: 4
        border.color: mouseArea.pressed ? "#D0D0D0" : "transparent"
        border.width: 1
        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }

    contentItem: Text {
        text: icon
        font.pixelSize: 24
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: parent.clicked()
    }

    signal clicked()

    ToolTip.visible: mouseArea.containsMouse && tooltip !== ""
    ToolTip.text: tooltip
    ToolTip.delay: 500
}
