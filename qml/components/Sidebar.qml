import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: sidebarRoot
    color: "#fafafa"

    property int activeIndex: 0

    function getTitleForIndex(index) {
        var titles = ["Agent管理", "模型管理", "插件管理", "RAG知识库", "流程管理", "任务管理", "配置"]
        return titles[index] || "面板"
    }

    function getSubtitleForIndex(index) {
        var subtitles = ["Agents", "Models", "Plugins", "Knowledge", "Workflows", "Tasks", "Settings"]
        return subtitles[index] || ""
    }

    Rectangle {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 1
        color: "#e4e4e7"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Header
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 56
            color: "transparent"

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: "#ececef"
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 16
                anchors.rightMargin: 10
                spacing: 8

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 1

                    Text {
                        text: sidebarRoot.getTitleForIndex(sidebarRoot.activeIndex)
                        font.pixelSize: 13
                        font.bold: true
                        color: "#18181b"
                    }
                    Text {
                        text: sidebarRoot.getSubtitleForIndex(sidebarRoot.activeIndex)
                        font.pixelSize: 10
                        color: "#a1a1aa"
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 26
                    Layout.preferredHeight: 26
                    radius: 6
                    color: addMouse.containsMouse ? "#ececef" : "transparent"
                    Behavior on color { ColorAnimation { duration: 120 } }

                    Text {
                        anchors.centerIn: parent
                        text: "+"
                        font.pixelSize: 16
                        color: "#52525b"
                    }

                    MouseArea {
                        id: addMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }

        // Search bar
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 44
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                anchors.topMargin: 8
                anchors.bottomMargin: 4
                radius: 8
                color: "#ffffff"
                border.color: searchField.activeFocus ? "#a78bfa" : "#e4e4e7"
                border.width: 1
                Behavior on border.color { ColorAnimation { duration: 140 } }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 6

                    Text {
                        text: "⌕"
                        font.pixelSize: 13
                        color: "#a1a1aa"
                    }

                    TextField {
                        id: searchField
                        Layout.fillWidth: true
                        placeholderText: "搜索…"
                        color: "#18181b"
                        placeholderTextColor: "#a1a1aa"
                        font.pixelSize: 12
                        background: null
                        selectByMouse: true
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"

            StackLayout {
                anchors.fill: parent
                currentIndex: sidebarRoot.activeIndex

                SidebarPanel { items: ["客服Agent", "数据分析Agent", "代码生成Agent", "翻译Agent", "搜索Agent"] }
                SidebarPanel { items: ["GPT-4-Turbo", "Claude-3-Opus", "Gemini-Pro", "LLaMA-2-Chat", "Qwen-Plus"] }
                SidebarPanel { items: ["浏览器驱动", "数据处理器", "自然语言", "自定义插件", "日志处理器"] }
                SidebarPanel { items: ["用户文档库", "API文档", "代码示例", "最佳实践", "常见问题"] }
                SidebarPanel { items: ["数据入库流程", "处理流程", "导出流程", "归档流程", "清理流程"] }
                SidebarPanel { items: ["数据同步任务", "日志备份任务", "配置更新任务", "性能分析任务"] }
                SidebarPanel { items: ["通用设置", "外观主题", "快捷键绑定", "插件市场", "关于系统"] }
            }
        }

        // Footer / status
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            color: "transparent"

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                height: 1
                color: "#ececef"
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 14
                anchors.rightMargin: 12
                spacing: 8

                Rectangle {
                    Layout.preferredWidth: 8
                    Layout.preferredHeight: 8
                    radius: 4
                    color: "#16a34a"

                    SequentialAnimation on opacity {
                        loops: Animation.Infinite
                        NumberAnimation { from: 1.0; to: 0.4; duration: 1000 }
                        NumberAnimation { from: 0.4; to: 1.0; duration: 1000 }
                    }
                }

                Text {
                    text: "运行正常"
                    font.pixelSize: 11
                    color: "#52525b"
                    Layout.fillWidth: true
                }

                Text {
                    text: "v0.1"
                    font.pixelSize: 10
                    color: "#a1a1aa"
                }
            }
        }
    }
}
