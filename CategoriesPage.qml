import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Components.Popups 0.1

Page {
    id: categoriesPage
    property string name
    property int pos

    Header {
        id: header
        title: i18n.tr("Categories")
    }

    tools : ToolbarItems {
        ToolbarButton {
            action: Action {
                id: addCategoryAction
                objectName: "addCategoryAction"

                text: i18n.tr("Add")
                iconSource: Qt.resolvedUrl("images/add.svg")

                onTriggered: {
                    categoriesPage.name = ""
                    PopupUtils.open(editCategoriesComponent)
                }
            }
        }
    }

    ListView {
        id: categoriesView
        height: parent.height - header.height
        width: parent.width
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            margins: units.gu(2)
        }

        model: categoriesModel
        delegate: ListItem.Standard {
            text: categoryName

            onClicked: {
                categoriesPage.name = categoryName
                pos = categoriesView.currentIndex
                PopupUtils.open(editCategoriesComponent)
            }
        }
    }


    Component {
        id: editCategoriesComponent

        Dialog {
            id: editCategoriesDialog
            title: i18n.tr("Edit ") + name

            TextField {
                id: editCategoryName
                text: categoriesPage.name
            }

            Button {
                text: i18n.tr("Close")
                onClicked: {
                    if (categoriesModel.count != 0)
                        categoriesModel.remove(pos)
                    categoriesModel.insert(pos, {categoryName: editCategoryName.text})
                    PopupUtils.close(editCategoriesDialog)
                }
            }

            Button {
                text: i18n.tr("Delete")
                onClicked: {
                    if (categoriesModel.count != 0)
                        categoriesModel.remove(pos)
                    PopupUtils.close(editCategoriesDialog)
                }
            }
        }
    }
}