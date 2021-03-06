/*
# Copyright (C) 2018  Artur Fogiel
# This file is part of qtS3Browser.
#
# qtS3Browser is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# qtS3Browser is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with qtS3Browser.  If not, see <http://www.gnu.org/licenses/>.
*/
import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

Item {
    id: man_boomarks_win
    width: parent.width
    height: parent.height

    onVisibleChanged: {
        addBookmarks()
    }

    function addBookmarks() {
        var bookmarksLen = bookModel.getBookmarksNumQML();

        for(var i = bookmarks_list.children.length; i > 0 ; i--) {
          bookmarks_list.children[i-1].destroy()
        }

        var emptyObject = null;

        if(bookmarksLen > 0) {
            var keys = bookModel.getBookmarksKeysQML()
            var values = bookModel.getBookmarksLinksQML()
            for(i = 0; i < bookmarksLen; i++){
                var color = "#dbdbdb"
                if((i  % 2) == 0) {
                    color = "transparent"
                }

                var newObject = Qt.createQmlObject('
import QtQuick 2.5;
import QtQuick.Controls 2.2;

Rectangle {
 x: 5
 width: parent.width - 10;
 height: 60
 color: "' + color + '"

 Row {
  width: parent.width;
  height: 40
  anchors.verticalCenter: parent.verticalCenter
  id: bookmarks_item
  x: 10

  Image {
    source: "qrc:icons/32_amazon_icon.png"
  }

  Rectangle {
    width: 10
    height: 10
    color: "transparent"
  }

  Column {
    width: parent.width - 390;
    Text {
      font.pointSize: getMediumFontSize()
      text: "' + keys[i] +'"
     }

     Text {
       font.pointSize: getSmallFontSize()
       text: \'<a href="' + values[i] +'">' + values[i] + '</a>\'
     }
  }

  Row {
      Button {
        id:o' + i + '
        text:"' + qsTr("Open") + tsMgr.emptyString + '"
        font.pointSize: getSmallFontSize()
        icon.source: "qrc:icons/32_go_icon.png"
        icon.color: "transparent"
        onClicked: {
            s3Model.gotoQML("' + values[i] +'")
            mainPanel.s3_panel.path = s3Model.getS3PathQML()
            mainPanel.s3_panel.connected = s3Model.isConnectedQML()
            mainPanel.file_panel.connected = s3Model.isConnectedQML()
            switchPanel(fm_btn, mainPanel)
        }
                    background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 40
                            opacity: enabled ? 1 : 0.3
                            color: o' + i + '.down ? "#dddedf" : "#eeeeee"

                            Rectangle {
                                width: parent.width
                                height: 1
                                color: o' + i + '.down ? "#17a81a" : "#21be2b"
                                anchors.bottom: parent.bottom
                            }
                        }
      }

      Rectangle {
        width: 5
        height: 10
        color: "transparent"
      }

      Button {
        id:e' + i + '
        text:"' +  qsTr("Edit") + tsMgr.emptyString + '"
        font.pointSize: getSmallFontSize()
        icon.source: "qrc:icons/32_edit_icon.png"
        icon.color: "transparent"
        onClicked: {
                  createBookmarkWindow.x = app_window.x + (app_window.width / 2) - (createBookmarkWindow.width / 2)
                  createBookmarkWindow.y = app_window.y + (app_window.height / 2) - (createBookmarkWindow.height / 2)
                  createBookmarkWindow.book_name = "' + keys[i] +'"
                  createBookmarkWindow.book_path = "' + values[i] +'"
                  createBookmarkWindow.win_title = qsTr("Edit bookmark")
                  createBookmarkWindow.visible = true;
        }
                    background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 40
                            opacity: enabled ? 1 : 0.3
                            color: e' + i + '.down ? "#dddedf" : "#eeeeee"

                            Rectangle {
                                width: parent.width
                                height: 1
                                color: e' + i + '.down ? "#17a81a" : "#21be2b"
                                anchors.bottom: parent.bottom
                            }
                        }
      }

      Rectangle {
        width: 5
        height: 10
        color: "transparent"
      }

      Button {
        id:d' + i + '
        text:"' + qsTr("Remove") + tsMgr.emptyString + '"
        font.pointSize: getSmallFontSize()
        icon.source: "qrc:icons/32_delete_icon.png"
        icon.color: "transparent"
        onClicked: {
          bookModel.removeBookmarkQML("' + keys[i] + '")
          addBookmarks()
        }
                    background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 40
                            opacity: enabled ? 1 : 0.3
                            color: d' + i + '.down ? "#dddedf" : "#eeeeee"

                            Rectangle {
                                width: parent.width
                                height: 1
                                color: d' + i + '.down ? "#17a81a" : "#21be2b"
                                anchors.bottom: parent.bottom
                            }
                        }
      }
    }
  }

Rectangle {
    width: parent.width
    color: "gray"
    height: 1
}

}
',
                bookmarks_list, "dynamicBookmarks");
            }
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height
        clip: true

        Rectangle {
            color: "#3367d6"
            width: parent.width
            height: 50

            Row {
                x:10
                height: parent.height
                width: parent.width

                Image {
                    source: "qrc:icons/32_bookmark2.png"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle {
                    width: 5
                    height: parent.height
                    color: "transparent"
                }

                Text {
                    color: "white"
                    text: qsTr("Manage bookmarks") + tsMgr.emptyString
                    font.bold: true
                    font.pointSize: getLargeFontSize()
                    height: parent.height
                    width: parent.width - 280;
                    verticalAlignment: Text.AlignVCenter
                }

                Rectangle {
                    width: 5
                    height: parent.height
                    color: "transparent"
                }

                Button {
                    id: add
                    text: qsTr("Add bookmark") + tsMgr.emptyString
                    icon.source: "qrc:icons/32_add_bookmark.png"
                    icon.color: "transparent"
                    font.pointSize: getSmallFontSize()
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: {
                      createBookmarkWindow.x = app_window.x + (app_window.width / 2) - (createBookmarkWindow.width / 2)
                      createBookmarkWindow.y = app_window.y + (app_window.height / 2) - (createBookmarkWindow.height / 2)
                      createBookmarkWindow.win_title = qsTr("Add bookmark") + tsMgr.emptyString
                      createBookmarkWindow.book_name = ""
                      createBookmarkWindow.book_path = "s3://"
                      createBookmarkWindow.visible = true;
                    }

                    background: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 40
                            opacity: enabled ? 1 : 0.3
                            color: add.down ? "#dddedf" : "#eeeeee"

                            Rectangle {
                                width: parent.width
                                height: 1
                                color: add.down ? "#17a81a" : "#21be2b"
                                anchors.bottom: parent.bottom
                            }
                        }
                }
            }
        }

        Rectangle {
            id: manage_bookmark_rect
            y: 60
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            width: parent.width - 50
            height: parent.height - 80
            border.color: "lightgray"
            border.width: 2
            radius: 5

            onVisibleChanged: {
                bookmarks_list.update()
            }

            Rectangle
            {
                id: frame
                x: 0
                y: 10
                width: parent.width
                height: parent.height - 30
                color: "transparent"
                clip: true

                MouseArea {
                    parent: manage_bookmark_rect      // specify the `visual parent`
                    height: parent.height
                    width: parent.width - 360;
                    onWheel:
                    {
                        if(frame.height < bookmarks_list.height)
                        {
                            if (wheel.angleDelta.y > 0)
                            {
                                vbar.decrease()

                            }
                            else
                            {
                                vbar.increase()
                            }
                        }
                    }
                }

                ScrollBar {
                        id: vbar
                        hoverEnabled: true
                        active: true
                        orientation: Qt.Vertical
                        size: frame.height / bookmarks_list.height
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                }


                Column
                {
                    id: bookmarks_list
                    width: parent.width
                    y: -vbar.position * height
                }
            }
        }
    }
}
