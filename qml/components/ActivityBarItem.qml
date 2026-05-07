import QtQuick
import QtQuick.Controls

Item {
    id: root
    property string icon: ""
    property string tooltip: ""
    property bool isActive: false

    signal clicked()

    // Active indicator on the left
    Rectangle {
        anchors.left: parent.left
        anchors.leftMargin: -10
        anchors.verticalCenter: parent.verticalCenter
        width: 3
        height: root.isActive ? 22 : 0
        radius: 2
        color: "#7c3aed"
        Behavior on height { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }
    }

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: root.isActive
               ? "#f3efff"
               : (mouseArea.containsMouse ? "#ececef" : "transparent")
        border.color: root.isActive ? "#e0d4ff" : "transparent"
        border.width: 1
        Behavior on color { ColorAnimation { duration: 140 } }
        Behavior on border.color { ColorAnimation { duration: 140 } }

        Text {
            anchors.centerIn: parent
            text: root.icon
            font.pixelSize: 17
            opacity: root.isActive ? 1.0 : (mouseArea.containsMouse ? 0.95 : 0.7)
            Behavior on opacity { NumberAnimation { duration: 140 } }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
        cursorShape: Qt.PointingHandCursor
    }

    ToolTip.visible: mouseArea.containsMouse && root.tooltip !== ""
    ToolTip.text: root.tooltip
    ToolTip.delay: 400
}
