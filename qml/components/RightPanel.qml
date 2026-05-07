import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: rightRoot
    color: "#fafafa"

    Rectangle {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 1
        color: "#e4e4e7"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // Visualization
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 1
            color: "transparent"

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 42
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
                        anchors.rightMargin: 12
                        spacing: 8

                        Text {
                            text: "📈"
                            font.pixelSize: 13
                        }

                        Text {
                            text: "趋势图表"
                            font.bold: true
                            font.pixelSize: 12
                            color: "#18181b"
                        }

                        Item { Layout.fillWidth: true }

                        Text {
                            text: "1H"
                            font.pixelSize: 10
                            font.bold: true
                            color: "#7c3aed"
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#ffffff"

                    Canvas {
                        id: trendCanvas
                        anchors.fill: parent
                        anchors.margins: 14

                        onPaint: {
                            var ctx = getContext("2d")
                            ctx.reset()
                            var w = width
                            var h = height
                            var points = [0.3, 0.5, 0.2, 0.7, 0.4, 0.6, 0.8, 0.55, 0.65, 0.45]

                            // grid
                            ctx.strokeStyle = "#ececef"
                            ctx.lineWidth = 1
                            for (var g = 0; g <= 4; g++) {
                                var gy = (h / 4) * g
                                ctx.beginPath()
                                ctx.moveTo(0, gy)
                                ctx.lineTo(w, gy)
                                ctx.stroke()
                            }

                            // gradient fill
                            var grad = ctx.createLinearGradient(0, 0, 0, h)
                            grad.addColorStop(0, "rgba(124, 58, 237, 0.22)")
                            grad.addColorStop(1, "rgba(124, 58, 237, 0.0)")

                            ctx.beginPath()
                            for (var i = 0; i < points.length; i++) {
                                var x = (w / (points.length - 1)) * i
                                var y = h * (1 - points[i])
                                if (i === 0) ctx.moveTo(x, y)
                                else ctx.lineTo(x, y)
                            }
                            ctx.lineTo(w, h)
                            ctx.lineTo(0, h)
                            ctx.closePath()
                            ctx.fillStyle = grad
                            ctx.fill()

                            // line
                            ctx.strokeStyle = "#7c3aed"
                            ctx.lineWidth = 2
                            ctx.beginPath()
                            for (var j = 0; j < points.length; j++) {
                                var lx = (w / (points.length - 1)) * j
                                var ly = h * (1 - points[j])
                                if (j === 0) ctx.moveTo(lx, ly)
                                else ctx.lineTo(lx, ly)
                            }
                            ctx.stroke()

                            // dots
                            ctx.fillStyle = "#7c3aed"
                            for (var k = 0; k < points.length; k++) {
                                var dx = (w / (points.length - 1)) * k
                                var dy = h * (1 - points[k])
                                ctx.beginPath()
                                ctx.arc(dx, dy, 2.5, 0, Math.PI * 2)
                                ctx.fill()
                            }
                        }

                        Connections {
                            target: trendCanvas
                            function onWidthChanged() { trendCanvas.requestPaint() }
                            function onHeightChanged() { trendCanvas.requestPaint() }
                        }
                    }
                }
            }
        }

        // Status (3 parts) — visualization:status = 1:3
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 3
            color: "transparent"

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
                    Layout.preferredHeight: 42
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
                        anchors.rightMargin: 12
                        spacing: 8

                        Text {
                            text: "⚡"
                            font.pixelSize: 13
                        }

                        Text {
                            text: "实时状态"
                            font.bold: true
                            font.pixelSize: 12
                            color: "#18181b"
                        }

                        Item { Layout.fillWidth: true }

                        Text {
                            text: "5"
                            font.pixelSize: 10
                            color: "#a1a1aa"
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"

                    ScrollView {
                        anchors.fill: parent
                        clip: true

                        ColumnLayout {
                            width: rightRoot.width
                            spacing: 8

                            Item { Layout.preferredHeight: 6 }

                            Repeater {
                                model: [
                                    { name: "数据库连接", status: "Running", statusColor: "#15803d", bgColor: "#dcfce7", borderColor: "#86efac", value: "连接正常", load: 0.65 },
                                    { name: "消息队列", status: "Success", statusColor: "#15803d", bgColor: "#dcfce7", borderColor: "#86efac", value: "已就绪", load: 0.4 },
                                    { name: "缓存服务", status: "Failed", statusColor: "#b91c1c", bgColor: "#fee2e2", borderColor: "#fca5a5", value: "连接超时", load: 0.0 },
                                    { name: "任务调度", status: "Paused", statusColor: "#a16207", bgColor: "#fef3c7", borderColor: "#fcd34d", value: "已暂停", load: 0.2 },
                                    { name: "API网关", status: "Running", statusColor: "#15803d", bgColor: "#dcfce7", borderColor: "#86efac", value: "流量正常", load: 0.78 }
                                ]

                                Rectangle {
                                    Layout.fillWidth: true
                                    Layout.leftMargin: 12
                                    Layout.rightMargin: 12
                                    Layout.preferredHeight: 78
                                    color: "#ffffff"
                                    radius: 10
                                    border.color: cardMouse.containsMouse ? "#e0d4ff" : "#e4e4e7"
                                    border.width: 1
                                    Behavior on border.color { ColorAnimation { duration: 140 } }

                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 8

                                        RowLayout {
                                            Layout.fillWidth: true
                                            spacing: 10

                                            Rectangle {
                                                Layout.preferredWidth: 8
                                                Layout.preferredHeight: 8
                                                radius: 4
                                                color: modelData.statusColor

                                                SequentialAnimation on opacity {
                                                    running: modelData.status === "Running"
                                                    loops: Animation.Infinite
                                                    NumberAnimation { from: 1.0; to: 0.4; duration: 1000 }
                                                    NumberAnimation { from: 0.4; to: 1.0; duration: 1000 }
                                                }
                                            }

                                            ColumnLayout {
                                                Layout.fillWidth: true
                                                spacing: 2

                                                Text {
                                                    text: modelData.name
                                                    font.pixelSize: 12
                                                    font.bold: true
                                                    color: "#18181b"
                                                }

                                                Text {
                                                    text: modelData.value
                                                    font.pixelSize: 10
                                                    color: "#71717a"
                                                }
                                            }

                                            Rectangle {
                                                Layout.preferredWidth: 60
                                                Layout.preferredHeight: 22
                                                color: modelData.bgColor
                                                radius: 11
                                                border.color: modelData.borderColor
                                                border.width: 1

                                                Text {
                                                    anchors.centerIn: parent
                                                    text: modelData.status
                                                    font.pixelSize: 10
                                                    font.bold: true
                                                    color: modelData.statusColor
                                                }
                                            }
                                        }

                                        RowLayout {
                                            Layout.fillWidth: true
                                            spacing: 8

                                            Text {
                                                text: "负载"
                                                font.pixelSize: 10
                                                color: "#71717a"
                                            }

                                            Rectangle {
                                                Layout.fillWidth: true
                                                Layout.preferredHeight: 4
                                                color: "#ececef"
                                                radius: 2

                                                Rectangle {
                                                    width: parent.width * modelData.load
                                                    height: parent.height
                                                    radius: 2
                                                    gradient: Gradient {
                                                        orientation: Gradient.Horizontal
                                                        GradientStop { position: 0.0; color: "#a78bfa" }
                                                        GradientStop { position: 1.0; color: "#7c3aed" }
                                                    }
                                                    Behavior on width { NumberAnimation { duration: 600; easing.type: Easing.OutCubic } }
                                                }
                                            }

                                            Text {
                                                text: Math.round(modelData.load * 100) + "%"
                                                font.pixelSize: 10
                                                font.bold: true
                                                color: "#52525b"
                                                Layout.preferredWidth: 32
                                                horizontalAlignment: Text.AlignRight
                                            }
                                        }
                                    }

                                    MouseArea {
                                        id: cardMouse
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                    }
                                }
                            }

                            Item { Layout.preferredHeight: 8 }
                            Item { Layout.fillHeight: true }
                        }
                    }
                }
            }
        }
    }
}
