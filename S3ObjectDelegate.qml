import QtQuick 2.0

Rectangle {
    id:delegate
    width: view.width
    height:34
    Row {
        anchors.fill: parent
        Image {
            id: icon
            width: delegate.height - 2
            height:width
            source: "image://iconProvider/"+filePath
        }
        Text {
            id: i_fileName
            text: fileName
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    MouseArea {
        id:mouseArea
        anchors.fill: parent
        onClicked: {
            view.currentIndex = index
        }

        onDoubleClicked:  {
            s3Model.getObjects(i_fileName.text)
            path = s3Model.getS3Path()
            view.forceLayout()
        }
    }
}