import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "#f4f4f5"

    property int activeIndex: 0
    signal activitySelected(int index)

    Rectangle {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 1
        color: "#e4e4e7"
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 14
        anchors.bottomMargin: 14
        spacing: 0

        // App logo / brand mark
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 32
            Layout.preferredHeight: 32
            Layout.bottomMargin: 16
            radius: 8
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: "#a78bfa" }
                GradientStop { position: 1.0; color: "#7c3aed" }
            }

            Text {
                anchors.centerIn: parent
                text: "T"
                font.pixelSize: 16
                font.bold: true
                color: "#ffffff"
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 4

            Repeater {
                model: [
                    { icon: "🤖", tooltip: "Agent管理" },
                    { icon: "🧠", tooltip: "模型管理" },
                    { icon: "🧩", tooltip: "插件管理" },
                    { icon: "📚", tooltip: "RAG" },
                    { icon: "🔀", tooltip: "流程管理" },
                    { icon: "📋", tooltip: "任务管理" }
                ]

                ActivityBarItem {
                    icon: modelData.icon
                    tooltip: modelData.tooltip
                    isActive: root.activeIndex === index
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40

                    onClicked: root.activitySelected(index)
                }
            }
        }

        Item { Layout.fillHeight: true }

        ActivityBarItem {
            icon: "⚙"
            tooltip: "配置"
            isActive: root.activeIndex === 6
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 40
            Layout.preferredHeight: 40

            onClicked: root.activitySelected(6)
        }
    }
}
