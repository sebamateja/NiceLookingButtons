import QtQuick 2.0
import QtGraphicalEffects 1.13

Item {
    id: root
    width: frontLayer.sourceSize.width + root.mouseAreaOffset
    height: frontLayer.sourceSize.height + root.mouseAreaOffset

    //Properties for images source
    property var sourceFrontLayer : "qrc:/card.png"
    property var sourceBackLayer1 : "qrc:/hole.png"
    property var sourceBackLayer2 : "qrc:/gear_bigger.png"
    property var sourceBackLayer3 : "qrc:/gear_smaller.png"
    property var sourceShadow : "qrc:/shadow.png"
    property var sourceSpecular : "qrc:/specular.png"
    property var sourceGlow : "qrc:/glow.png"

    property real maxAngleBackLayer1: 3+-0
    property real maxAngleBackLayer2: 16
    property real maxAngleBackLayer3: 12
    property real maxAngleFrontLayer: 30

    property real maxTranslateBackLayer1: 20
    property real maxTranslateBackLayer2: 16
    property real maxTranslateBackLayer3: 12

    property real scaleOnPressed: 0.9

    property real mouseAreaOffset: 20

    property real behaviorDuration: 170

    property bool isAnimated: false
    property bool isPressed: false

    property real mouseXPosition: centerX
    property real mouseYPosition: centerY

    readonly property real centerX: frontLayer.sourceSize.width / 2 + mouseAreaOffset/2
    readonly property real centerY: frontLayer.sourceSize.height / 2 + mouseAreaOffset/2

    MouseArea {
        id: mouseArea
        width: frontLayer.width + root.mouseAreaOffset
        height: frontLayer.height + root.mouseAreaOffset

        onPositionChanged: {
            if (mouseX < mouseArea.width && mouseY < mouseArea.height
                    && mouseX > 0 && mouseY > 0) {
                root.mouseXPosition = mouseX
                root.mouseYPosition = mouseY
            } else {
                root.mouseXPosition = root.centerX
                root.mouseYPosition = root.centerY
            }
        }

        onReleased: {
            console.log("OnReleased")
            root.mouseXPosition = centerX
            root.mouseYPosition = centerY
            isPressed = false
        }

        onEntered: {
            console.log("OnEntered")
            root.mouseXPosition = mouseX
            root.mouseYPosition = mouseY
        }

        onExited: {
            console.log("OnExited")
            root.mouseXPosition = centerX
            root.mouseYPosition = centerY
        }

        onCanceled: {
            console.log("OnCanceled")
            root.mouseXPosition = centerX
            root.mouseYPosition = centerY
        }

        onPressed: {
            console.log("OnPressed")
            isPressed = true
            root.mouseXPosition = mouseX
            root.mouseYPosition = mouseY
        }
    }

    Image {
        id: shadow
        antialiasing: true
        source:root.sourceShadow
        smooth: true
        anchors.top: frontLayer.top
        anchors.horizontalCenter: frontLayer.horizontalCenter
        scale: isPressed == true ? scaleOnPressed : 1

        transform: [
            Rotation {
                origin.x: root.centerX
                origin.y: root.centerY
                axis {x: 0; y: 1; z: 0}
                angle: (root.mouseXPosition - root.centerX)/root.centerX * maxAngleFrontLayer

                Behavior on angle {
                    NumberAnimation { duration: behaviorDuration }
                }
            },
            Rotation {
                origin.x: root.centerX
                origin.y: root.centerY
                axis {x: 1; y: 0; z: 0}
                angle: (root.centerY - root.mouseYPosition)/root.centerY * maxAngleFrontLayer

                Behavior on angle {
                    NumberAnimation { duration: behaviorDuration }
                }
            }
        ]
    }

    Image {
        id: glowLayer
        anchors.centerIn: mouseArea
        antialiasing: true
        source: root.sourceGlow
        scale: isPressed == true ? scaleOnPressed : 1

        Behavior on scale {
            NumberAnimation { duration: behaviorDuration }
        }

        visible: root.isPressed

        transform: [
            Rotation {
                origin.x: root.centerX
                origin.y: root.centerY
                axis {x: 0; y: 1; z: 0}
                angle: (root.mouseXPosition - root.centerX)/root.centerX * maxAngleFrontLayer

                Behavior on angle {
                    NumberAnimation { duration: behaviorDuration }
                }
            },
            Rotation {
                origin.x: root.centerX
                origin.y: root.centerY
                axis {x: 1; y: 0; z: 0}
                angle: (root.centerY - root.mouseYPosition)/root.centerY * maxAngleFrontLayer

                Behavior on angle {
                    NumberAnimation { duration: behaviorDuration }
                }
            }
        ]
    }

    Image {
        id: frontLayer
        anchors.centerIn: mouseArea
        antialiasing: true
        smooth: true
        source: root.sourceFrontLayer
        scale: isPressed == true ? scaleOnPressed : 1

        transform: [
            Rotation {
                origin.x: root.centerX
                origin.y: root.centerY
                axis {x: 0; y: 1; z: 0}
                angle: (root.mouseXPosition - root.centerX)/root.centerX * maxAngleFrontLayer

                Behavior on angle {
                    NumberAnimation { duration: behaviorDuration }
                }
            },
            Rotation {
                origin.x: root.centerX
                origin.y: root.centerY
                axis {x: 1; y: 0; z: 0}
                angle: (root.centerY - root.mouseYPosition)/root.centerY * maxAngleFrontLayer

                Behavior on angle {
                    NumberAnimation { duration: behaviorDuration }
                }
            }
        ]
    }

    Image {
        id: backLayer1
        antialiasing: true
        source:root.sourceBackLayer1
        anchors.centerIn: frontLayer
        smooth: true
        scale: isPressed == true ? scaleOnPressed : 1

        transform: [
            Rotation {
                origin.x: root.centerX
                origin.y: root.centerY
                axis {x: 0; y: 1; z: 0}
                angle: (root.mouseXPosition - root.centerX)/root.centerX * maxAngleBackLayer1

                Behavior on angle {
                    NumberAnimation { duration: behaviorDuration }
                }
            },
            Rotation {
                origin.x: root.centerX
                origin.y: root.centerY
                axis {x: 1; y: 0; z: 0}
                angle: (root.centerY - root.mouseYPosition)/root.centerY * maxAngleBackLayer1

                Behavior on angle {
                    NumberAnimation { duration: behaviorDuration }
                }
            },
            Translate {
                x: (root.mouseXPosition - root.centerX)/root.centerX * maxTranslateBackLayer1
                y: (root.mouseYPosition - root.centerY)/root.centerY * maxTranslateBackLayer1

                Behavior on x {
                    NumberAnimation { duration: behaviorDuration }
                }

                Behavior on y {
                    NumberAnimation { duration: behaviorDuration }
                }
            }
        ]
    }

    Image {
        id: backLayer2
        antialiasing: true
        source:root.sourceBackLayer2
        anchors.centerIn: frontLayer
        smooth: true
        scale: isPressed == true ? scaleOnPressed : 1

        transform: [
            Rotation {
                origin.x: root.centerX
                origin.y: root.centerY
                axis {x: 0; y: 1; z: 0}
                angle: (root.mouseXPosition - root.centerX)/root.centerX * maxAngleBackLayer2

                Behavior on angle {
                    NumberAnimation { duration: behaviorDuration }
                }
            },
            Rotation {
                origin.x: root.centerX
                origin.y: root.centerY
                axis {x: 1; y: 0; z: 0}
                angle: (root.centerY - root.mouseYPosition)/root.centerY * maxAngleBackLayer2

                Behavior on angle {
                    NumberAnimation { duration: behaviorDuration }
                }
            },
            Translate {
                x: (root.mouseXPosition - root.centerX)/root.centerX * maxTranslateBackLayer2
                y: (root.mouseYPosition - root.centerY)/root.centerY * maxTranslateBackLayer2

                Behavior on x {
                    NumberAnimation { duration: behaviorDuration }
                }

                Behavior on y {
                    NumberAnimation { duration: behaviorDuration }
                }
            }
        ]
    }

    Image {
        id: backLayer3
        antialiasing: true
        source:root.sourceBackLayer3
        anchors.centerIn: frontLayer
        smooth: true
        scale: isPressed == true ? scaleOnPressed : 1

        transform: [
            Rotation {
                origin.x: root.centerX
                origin.y: root.centerY
                axis {x: 0; y: 1; z: 0}
                angle: (root.mouseXPosition - root.centerX)/root.centerX * maxAngleBackLayer3

                Behavior on angle {
                    NumberAnimation { duration: behaviorDuration }
                }
            },
            Rotation {
                origin.x: root.centerX
                origin.y: root.centerY
                axis {x: 1; y: 0; z: 0}
                angle: (root.centerY - root.mouseYPosition)/root.centerY * maxAngleBackLayer3

                Behavior on angle {
                    NumberAnimation { duration: behaviorDuration }
                }
            },
            Translate {
                x: (root.mouseXPosition - root.centerX)/root.centerX * maxTranslateBackLayer3
                y: (root.mouseYPosition - root.centerY)/root.centerY * maxTranslateBackLayer3

                Behavior on x {
                    NumberAnimation { duration: behaviorDuration }
                }

                Behavior on y {
                    NumberAnimation { duration: behaviorDuration }
                }
            }
        ]
    }

    Rectangle {
        antialiasing: true
        width: frontLayer.sourceSize.width
        height: frontLayer.sourceSize.height
        anchors.centerIn: mouseArea
        radius: 20
        scale: isPressed == true ? scaleOnPressed : 1
        color: "transparent"

        layer.enabled: true

        transform: [
            Rotation {
                origin.x: root.centerX
                origin.y: root.centerY
                axis {x: 0; y: 1; z: 0}
                angle: (root.mouseXPosition - root.centerX)/root.centerX * maxAngleFrontLayer

                Behavior on angle {
                    NumberAnimation { duration: behaviorDuration }
                }
            },
            Rotation {
                origin.x: root.centerX
                origin.y: root.centerY
                axis {x: 1; y: 0; z: 0}
                angle: (root.centerY - root.mouseYPosition)/root.centerY * maxAngleFrontLayer

                Behavior on angle {
                    NumberAnimation { duration: behaviorDuration }
                }
            }
        ]

        Behavior on scale {
            NumberAnimation { duration: behaviorDuration }
        }

        Behavior on x {
            NumberAnimation { duration: behaviorDuration }
        }

        Behavior on y {
            NumberAnimation { duration: behaviorDuration }
        }

        layer.samplerName: "maskSource"
        layer.effect: ShaderEffect {
            property var colorSource: specular;
            fragmentShader: "
                            uniform lowp sampler2D colorSource;
                            uniform lowp sampler2D maskSource;
                            uniform lowp float qt_Opacity;
                            varying highp vec2 qt_TexCoord0;
                            void main() {
                                gl_FragColor =
                                    texture2D(colorSource, qt_TexCoord0)
                                    * texture2D(maskSource, qt_TexCoord0).a
                                    * qt_Opacity;
                            }
                        "
        }

        Image {
            id: specular
            antialiasing: true
            source:root.sourceSpecular
            visible: isPressed

            layer.enabled: true

            x: mouseArea.width - root.mouseXPosition - specular.sourceSize.width/2
            y: mouseArea.height - root.mouseYPosition - specular.sourceSize.height/2

            Behavior on x {
                NumberAnimation { duration: behaviorDuration }
            }

            Behavior on y {
                NumberAnimation { duration: behaviorDuration }
            }
        }
    }

    Timer {
        interval: 33
        repeat: true
        running: isAnimated
        onTriggered: {
            backLayer2.rotation += 1;
            backLayer3.rotation -= 1;
        }
    }
}
