import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3

Window {
    visible: true
    width: 1920
    height: 1000
    title: qsTr("2D Button")

    Rectangle {
        anchors.fill: parent
        color: "#001031"
    }

    //TODO: Separate this component into few smaller components
    FancyButton25D {
        scale: 1.5
        y: 120
        isAnimated: true
        anchors.left: parent.left
        anchors.leftMargin: 100
    }

//    SimpleButton25D {
//        scale: 1.5
//        anchors.left: parent.left
//        anchors.leftMargin: 100
//        y: 660

//        sourceFrontLayer: "qrc:/cover01.png"
//    }
}
