import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import apptristsmallgui
import apptristsmallgui.qml.components

Window {
    id: window
    width: 1280
    height: 800
    visible: true
    title: "智能体管理平台"
    color: "#ffffff"

    property bool showRightPanel: false
    property int activeActivityIndex: 0

    RowLayout {
        anchors.fill: parent
        spacing: 0

        ActivityBar {
            Layout.preferredWidth: 56
            Layout.fillHeight: true
            activeIndex: window.activeActivityIndex
            onActivitySelected: function(index) {
                window.activeActivityIndex = index
            }
        }

        Sidebar {
            Layout.preferredWidth: 240
            Layout.fillHeight: true
            activeIndex: window.activeActivityIndex
        }

        MainContent {
            Layout.fillWidth: true
            Layout.fillHeight: true
            rightPanelVisible: window.showRightPanel
            onToggleRightPanel: {
                window.showRightPanel = !window.showRightPanel
            }
        }

        RightPanel {
            Layout.preferredWidth: window.showRightPanel ? 340 : 0
            Layout.fillHeight: true
            visible: window.showRightPanel
        }
    }
}
