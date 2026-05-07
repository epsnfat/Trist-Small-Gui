import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: mainRoot
    color: "#ffffff"

    property bool rightPanelVisible: false
    property int currentTab: 0
    signal toggleRightPanel()

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Management module
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 4
            color: "transparent"

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                // Top toolbar with tabs
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 52
                    color: "#ffffff"

                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        height: 1
                        color: "#ececef"
                    }

                    // Centered segmented tabs
                    Rectangle {
                        anchors.centerIn: parent
                        width: tabRow.implicitWidth + 8
                        height: 34
                        radius: 9
                        color: "#f4f4f5"
                        border.color: "#e4e4e7"
                        border.width: 1

                        Row {
                            id: tabRow
                            anchors.centerIn: parent
                            spacing: 2

                            Repeater {
                                model: ["概览", "详情", "监控"]

                                Item {
                                    width: 88
                                    height: 30

                                    Rectangle {
                                        anchors.fill: parent
                                        anchors.margins: 2
                                        radius: 7
                                        color: mainRoot.currentTab === index
                                               ? "#ffffff"
                                               : (tabMouse.containsMouse ? "#ececef" : "transparent")
                                        border.color: mainRoot.currentTab === index ? "#e0d4ff" : "transparent"
                                        border.width: 1
                                        Behavior on color { ColorAnimation { duration: 140 } }
                                        Behavior on border.color { ColorAnimation { duration: 140 } }

                                        Text {
                                            anchors.centerIn: parent
                                            text: modelData
                                            font.pixelSize: 12
                                            font.weight: mainRoot.currentTab === index ? Font.Medium : Font.Normal
                                            color: mainRoot.currentTab === index ? "#5b21b6" : "#52525b"
                                            Behavior on color { ColorAnimation { duration: 140 } }
                                        }

                                        MouseArea {
                                            id: tabMouse
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: mainRoot.currentTab = index
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Toggle button on top-right
                    Rectangle {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 14
                        width: 34
                        height: 30
                        radius: 7
                        color: mainRoot.rightPanelVisible
                               ? "#f3efff"
                               : (toggleMouse.containsMouse ? "#ececef" : "transparent")
                        border.color: mainRoot.rightPanelVisible ? "#e0d4ff" : "transparent"
                        border.width: 1
                        Behavior on color { ColorAnimation { duration: 140 } }

                        Text {
                            anchors.centerIn: parent
                            text: "▦"
                            font.pixelSize: 14
                            color: mainRoot.rightPanelVisible ? "#7c3aed" : "#52525b"
                        }

                        MouseArea {
                            id: toggleMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: mainRoot.toggleRightPanel()
                        }

                        ToolTip.visible: toggleMouse.containsMouse
                        ToolTip.text: mainRoot.rightPanelVisible ? "隐藏右侧面板" : "显示右侧面板"
                        ToolTip.delay: 400
                    }
                }

                // Tab content area
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#fafafa"

                    ScrollView {
                        anchors.fill: parent
                        clip: true

                        ColumnLayout {
                            width: mainRoot.width
                            spacing: 14

                            Item { Layout.preferredHeight: 4 }

                            // Stats card
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.leftMargin: 18
                                Layout.rightMargin: 18
                                Layout.preferredHeight: 250
                                color: "#ffffff"
                                radius: 12
                                border.color: "#e4e4e7"
                                border.width: 1

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 20
                                    spacing: 18

                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 10

                                        Rectangle {
                                            Layout.preferredWidth: 28
                                            Layout.preferredHeight: 28
                                            radius: 7
                                            color: "#f3efff"
                                            border.color: "#e0d4ff"
                                            border.width: 1

                                            Text {
                                                anchors.centerIn: parent
                                                text: "📊"
                                                font.pixelSize: 13
                                            }
                                        }

                                        ColumnLayout {
                                            spacing: 1

                                            Text {
                                                text: "操作概览"
                                                font.pixelSize: 14
                                                font.bold: true
                                                color: "#18181b"
                                            }
                                            Text {
                                                text: "实时性能与运行指标"
                                                font.pixelSize: 10
                                                color: "#a1a1aa"
                                            }
                                        }

                                        Item { Layout.fillWidth: true }

                                        Rectangle {
                                            Layout.preferredWidth: 70
                                            Layout.preferredHeight: 24
                                            color: "#dcfce7"
                                            radius: 12
                                            border.color: "#86efac"
                                            border.width: 1

                                            RowLayout {
                                                anchors.centerIn: parent
                                                spacing: 5

                                                Rectangle {
                                                    width: 6
                                                    height: 6
                                                    radius: 3
                                                    color: "#16a34a"
                                                }

                                                Text {
                                                    text: "已启用"
                                                    font.pixelSize: 10
                                                    font.bold: true
                                                    color: "#15803d"
                                                }
                                            }
                                        }
                                    }

                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 12

                                        Repeater {
                                            model: [
                                                { value: "14", label: "操作次数", color: "#18181b", accent: "#7c3aed" },
                                                { value: "98.7%", label: "成功率", color: "#15803d", accent: "#16a34a" },
                                                { value: "12 ms", label: "平均耗时", color: "#18181b", accent: "#2563eb" },
                                                { value: "3", label: "失败次数", color: "#dc2626", accent: "#dc2626" }
                                            ]

                                            Rectangle {
                                                Layout.fillWidth: true
                                                Layout.preferredHeight: 78
                                                color: "#fafafa"
                                                radius: 9
                                                border.color: "#e4e4e7"
                                                border.width: 1

                                                Rectangle {
                                                    anchors.left: parent.left
                                                    anchors.top: parent.top
                                                    anchors.bottom: parent.bottom
                                                    anchors.margins: 1
                                                    width: 3
                                                    radius: 2
                                                    color: modelData.accent
                                                    opacity: 0.85
                                                }

                                                ColumnLayout {
                                                    anchors.fill: parent
                                                    anchors.leftMargin: 14
                                                    anchors.rightMargin: 12
                                                    anchors.topMargin: 12
                                                    anchors.bottomMargin: 12
                                                    spacing: 4

                                                    Text {
                                                        text: modelData.value
                                                        font.pixelSize: 22
                                                        font.bold: true
                                                        color: modelData.color
                                                    }

                                                    Text {
                                                        text: modelData.label
                                                        font.pixelSize: 10
                                                        color: "#71717a"
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 10

                                        Repeater {
                                            model: [
                                                { name: "数据库连接", progress: 0.85, color: "#7c3aed" },
                                                { name: "日志记录", progress: 0.92, color: "#16a34a" },
                                                { name: "缓存更新", progress: 0.65, color: "#2563eb" }
                                            ]

                                            RowLayout {
                                                Layout.fillWidth: true
                                                spacing: 12

                                                Text {
                                                    text: modelData.name
                                                    font.pixelSize: 11
                                                    color: "#52525b"
                                                    Layout.preferredWidth: 80
                                                }

                                                Rectangle {
                                                    Layout.fillWidth: true
                                                    Layout.preferredHeight: 5
                                                    color: "#ececef"
                                                    radius: 2.5

                                                    Rectangle {
                                                        height: parent.height
                                                        width: parent.width * modelData.progress
                                                        radius: 2.5
                                                        gradient: Gradient {
                                                            orientation: Gradient.Horizontal
                                                            GradientStop { position: 0.0; color: Qt.lighter(modelData.color, 1.15) }
                                                            GradientStop { position: 1.0; color: modelData.color }
                                                        }
                                                        Behavior on width { NumberAnimation { duration: 600; easing.type: Easing.OutCubic } }
                                                    }
                                                }

                                                Text {
                                                    text: Math.round(modelData.progress * 100) + "%"
                                                    font.pixelSize: 11
                                                    color: "#18181b"
                                                    font.bold: true
                                                    Layout.preferredWidth: 36
                                                    horizontalAlignment: Text.AlignRight
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            // Quick action card
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.leftMargin: 18
                                Layout.rightMargin: 18
                                Layout.preferredHeight: 150
                                color: "#ffffff"
                                radius: 12
                                border.color: "#e4e4e7"
                                border.width: 1

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 18
                                    spacing: 12

                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 8

                                        Text {
                                            text: "快捷操作"
                                            font.pixelSize: 13
                                            font.bold: true
                                            color: "#18181b"
                                        }

                                        Item { Layout.fillWidth: true }

                                        Text {
                                            text: "查看全部 ›"
                                            font.pixelSize: 11
                                            color: "#7c3aed"
                                        }
                                    }

                                    RowLayout {
                                        Layout.fillWidth: true
                                        spacing: 10

                                        Repeater {
                                            model: [
                                                { icon: "▶", label: "启动服务" },
                                                { icon: "↻", label: "刷新状态" },
                                                { icon: "↧", label: "导出日志" },
                                                { icon: "⚙", label: "高级设置" }
                                            ]

                                            Rectangle {
                                                Layout.fillWidth: true
                                                Layout.preferredHeight: 64
                                                color: actionMouse.containsMouse ? "#f3efff" : "#fafafa"
                                                radius: 9
                                                border.color: actionMouse.containsMouse ? "#e0d4ff" : "#e4e4e7"
                                                border.width: 1
                                                Behavior on color { ColorAnimation { duration: 140 } }
                                                Behavior on border.color { ColorAnimation { duration: 140 } }

                                                ColumnLayout {
                                                    anchors.centerIn: parent
                                                    spacing: 4

                                                    Text {
                                                        Layout.alignment: Qt.AlignHCenter
                                                        text: modelData.icon
                                                        font.pixelSize: 16
                                                        color: "#7c3aed"
                                                    }

                                                    Text {
                                                        Layout.alignment: Qt.AlignHCenter
                                                        text: modelData.label
                                                        font.pixelSize: 11
                                                        color: "#52525b"
                                                    }
                                                }

                                                MouseArea {
                                                    id: actionMouse
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    cursorShape: Qt.PointingHandCursor
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            Item { Layout.preferredHeight: 8 }
                        }
                    }
                }
            }
        }

        // Log module
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 1
            color: "#ffffff"

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                height: 1
                color: "#ececef"
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 38
                    color: "#fafafa"

                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        height: 1
                        color: "#ececef"
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 18
                        anchors.rightMargin: 12
                        spacing: 10

                        Rectangle {
                            Layout.preferredWidth: 6
                            Layout.preferredHeight: 6
                            radius: 3
                            color: "#16a34a"

                            SequentialAnimation on opacity {
                                loops: Animation.Infinite
                                NumberAnimation { from: 1.0; to: 0.3; duration: 900 }
                                NumberAnimation { from: 0.3; to: 1.0; duration: 900 }
                            }
                        }

                        Text {
                            text: "实时日志"
                            font.bold: true
                            font.pixelSize: 12
                            color: "#18181b"
                        }

                        Rectangle {
                            Layout.preferredWidth: 36
                            Layout.preferredHeight: 18
                            radius: 4
                            color: "#ececef"

                            Text {
                                anchors.centerIn: parent
                                text: "LIVE"
                                font.pixelSize: 9
                                font.bold: true
                                color: "#52525b"
                            }
                        }

                        Item { Layout.fillWidth: true }

                        Rectangle {
                            Layout.preferredWidth: 50
                            Layout.preferredHeight: 24
                            radius: 6
                            color: clearMouse.containsMouse ? "#ececef" : "#ffffff"
                            border.color: "#e4e4e7"
                            border.width: 1
                            Behavior on color { ColorAnimation { duration: 120 } }

                            Text {
                                anchors.centerIn: parent
                                text: "清空"
                                font.pixelSize: 11
                                color: "#52525b"
                            }

                            MouseArea {
                                id: clearMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                            }
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#ffffff"

                    ScrollView {
                        anchors.fill: parent
                        anchors.margins: 8
                        clip: true

                        ColumnLayout {
                            width: parent.width
                            spacing: 2

                            Repeater {
                                model: [
                                    { time: "2026-04-30 14:32:10", level: "ERROR", message: "数据库连接超时 - 连接池已满 timeout:5000ms" },
                                    { time: "2026-04-30 14:32:09", level: "INFO", message: "查询操作成功完成 (耗时 12ms)" },
                                    { time: "2026-04-30 14:32:08", level: "INFO", message: "会话建立完成 (连接ID: 10086)" },
                                    { time: "2026-04-30 14:32:07", level: "WARN", message: "缓存命中率低于阈值 (62%)" },
                                    { time: "2026-04-30 14:32:06", level: "INFO", message: "已启动处理: 队列中的任务" }
                                ]

                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 26
                                    color: logMouse.containsMouse ? "#fafafa" : "transparent"
                                    radius: 4
                                    Behavior on color { ColorAnimation { duration: 100 } }

                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.leftMargin: 8
                                        anchors.rightMargin: 8
                                        spacing: 12

                                        Text {
                                            text: modelData.time
                                            font.pixelSize: 11
                                            color: "#a1a1aa"
                                            font.family: "Menlo"
                                            Layout.preferredWidth: 140
                                        }

                                        Rectangle {
                                            Layout.preferredWidth: 50
                                            Layout.preferredHeight: 18
                                            radius: 4
                                            color: {
                                                switch(modelData.level) {
                                                    case "ERROR": return "#fee2e2"
                                                    case "WARN": return "#fef3c7"
                                                    case "INFO": return "#dcfce7"
                                                    default: return "#ececef"
                                                }
                                            }
                                            border.width: 1
                                            border.color: {
                                                switch(modelData.level) {
                                                    case "ERROR": return "#fca5a5"
                                                    case "WARN": return "#fcd34d"
                                                    case "INFO": return "#86efac"
                                                    default: return "#e4e4e7"
                                                }
                                            }

                                            Text {
                                                anchors.centerIn: parent
                                                text: modelData.level
                                                font.pixelSize: 9
                                                font.bold: true
                                                color: {
                                                    switch(modelData.level) {
                                                        case "ERROR": return "#b91c1c"
                                                        case "WARN": return "#a16207"
                                                        case "INFO": return "#15803d"
                                                        default: return "#52525b"
                                                    }
                                                }
                                            }
                                        }

                                        Text {
                                            text: modelData.message
                                            font.pixelSize: 11
                                            color: "#3f3f46"
                                            Layout.fillWidth: true
                                            elide: Text.ElideRight
                                            font.family: "Menlo"
                                        }
                                    }

                                    MouseArea {
                                        id: logMouse
                                        anchors.fill: parent
                                        hoverEnabled: true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
