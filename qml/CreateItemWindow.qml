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
import QtQuick 2.11
import QtQuick.Window 2.3
import QtQml.Models 2.3
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Window {
    id: create_item_win
    x: 100; y: 100; width: 300; height: 130
    minimumHeight: 130; maximumHeight: 130
    minimumWidth: 250

    property var win_title: String
    property var create_action: Number

    title: win_title

    onVisibilityChanged: {
        itemName.text = ""
    }

    Column {
        x:5
        y:5
        width: parent.width
        height: parent.height
        Row {
            width: parent.width
            Image {
                source: {
                    if(create_action === 0) {
                        "qrc:icons/32_bucket_icon.png"
                    } else {
                        "qrc:icons/32_new_folder_icon.png"
                    }
                }
            }

            Text {
                text: {
                    if(create_action === 0) {
                        "Bucket name"
                    } else {
                        "Folder name"
                    }
                }
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 12
            }
        }

        Rectangle {
            width: parent.width
            height: 5
        }

        Row {
            width: parent.width

            Rectangle {
                width: parent.width - x - 10
                height: 34
                border.color: "black"
                color: "white"
                border.width: 1

                TextInput {
                    id: itemName
                    x: 5
                    width: parent.width - x - 10
                    anchors.verticalCenter: parent.verticalCenter
                    maximumLength: 128
                }
            }
        }

        Rectangle {
            width: parent.width
            height: 5
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Button {
                id: cw_cb
                text: qsTr("Create")
                onClicked: {
                    if (create_action === 0) {
                        s3Model.createBucketQML(itemName.text)
                    } else {
                        s3Model.createFolderQML(itemName.text)
                    }
                    s3Model.refreshQML()
                    close()
                }
            }

            Rectangle {
                width: 5
                height: parent.height
            }


            Button {
                text: qsTr("Cancel")
                onClicked: {
                    close()
                }
            }
        }
    }
}

