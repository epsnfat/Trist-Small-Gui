import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: panelRoot
    property var items: []
    property int currentIndex: 0
    color: "transparent"

    ScrollView {
        anchors.fill: parent
        clip: true

        ColumnLayout {
            width: panelRoot.width
            spacing: 2

            Item { Layout.preferredHeight: 6 }

            Repeater {
                model: panelRoot.items

                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 36
                    Layout.leftMargin: 8
                    Layout.rightMargin: 8

                    Rectangle {
                        anchors.fill: parent
                        radius: 7
                        color: panelRoot.currentIndex === index
                               ? "#f3efff"
                               : (mouseArea.containsMouse ? "#ffffff" : "transparent")
                        border.color: panelRoot.currentIndex === index
                                      ? "#e0d4ff"
                                      : (mouseArea.containsMouse ? "#e4e4e7" : "transparent")
                        border.width: 1
                        Behavior on color { ColorAnimation { duration: 100 } }
                        Behavior on border.color { ColorAnimation { duration: 100 } }

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 12
                            anchors.rightMargin: 12
                            spacing: 10

                            Rectangle {
                                Layout.preferredWidth: 6
                                Layout.preferredHeight: 6
                                radius: 3
                                color: panelRoot.currentIndex === index ? "#7c3aed" : "#d4d4d8"
                                Behavior on color { ColorAnimation { duration: 100 } }
                            }

                            Text {
                                text: modelData
                                font.pixelSize: 12
                                font.weight: panelRoot.currentIndex === index ? Font.Medium : Font.Normal
                                color: panelRoot.currentIndex === index ? "#5b21b6" : "#3f3f46"
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                Behavior on color { ColorAnimation { duration: 100 } }
                            }

                            Text {
                                visible: panelRoot.currentIndex === index
                                text: "›"
                                font.pixelSize: 14
                                color: "#7c3aed"
                            }
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: panelRoot.currentIndex = index
                        }
                    }
                }
            }

            Item { Layout.fillHeight: true }
        }
    }
}
