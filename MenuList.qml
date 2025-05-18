// MenuList.qml

import QtQuick 2.0
//import SddmComponents 2.0



Item { // this was Rectangle
    id: menuroot
    width: itemslist.width
    height: itemslist.height + itemslist.height % 2





// PUBLIC PROPERTIES, PUBLIC PROPERTIES HOLDING A FUNCTION AND PUBLIC FUNCTIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // the index of selected menu item (from menu)
    // default index is last used index
    // this property is needed for login procedure
    property int item_index



    // this property holds function which closes the menu and make centralpanel visible
    property var closeMenu



    // get the item index function
    function getItemIndex() {
        // returns the index of a choden item
        return item_index;
    }



    // initialize after opening menu
    function init() {
        // set the hovered_item to item_index
        hovered_item = item_index;

        // set the visual state of last selected item
        itemslist.children[hovered_item].last_selected = true;
        // set focus to "items_list" (for keyboard actions reason)
        itemslist.focus = true;
    }





// INNER PROPERTIES AND FUNCTIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // item which is hovered with keyboard or mouse
    // it's a prelight menu item
    property int hovered_item



    // the count of all available menu items
    property int items_count: 0

    // menu type (session, layout, userlist)
    property string menu_type: ""



    // function to set hovered item
    // it's started when mouse enters the menu item
    function setHoveredItem(index) {
        // turn OFF the prelight of hovered item
        itemslist.children[hovered_item].item_state = 0;
        // set the hovered item index
        hovered_item = index;
        // turn ON the prelight of hovered item
        itemslist.children[hovered_item].item_state = 1;
    }



    // set the menu item index chosen from menu
    function setItem(index) {
        // has been some choice made?
        if (index >= 0) {
            // unset the last selected item
            itemslist.children[item_index].last_selected = false;

            // set selected item
            item_index = index;

            // set the new last selected item
            itemslist.children[item_index].last_selected = true;
        }

        // this will hide menu and show login panel in "Main.qml"
        closeMenu();
    }





    // creates the menu
    function loadMenuList() {
        // assembling a component of a "MenuItem.qml"
        var component = Qt.createComponent("MenuItem.qml");

        // is the component ready to create (is assembled)?
        if (component.status == Component.Ready) {
            // create all menu items
            for (var i = 0; i < items_count; i++) {
                // creates an instance of menu item component
                // and place it in "items_list"
                var btn = component.createObject(itemslist);
                // assigning index to a menu item component
                // it's a number needed for mouse/keyboard actions
                // and for login procedure
                btn.index = i;
                // btn.setItem is a variable in MenuItem.qml,
                // which starts when mouse clicks on an item
                // = setItem -> is a fuction "setItem(index)" declared below
                btn.setItem = setItem;
                // bt.setHoveredItem is a variable in MenuItem.qml,
                // which starts when mouse hover above an item
                // = setHoveredItem -> is a function "setHoveredItem(index)" declared below
                btn.setHoveredItem = menuroot.setHoveredItem;

                // assigning a label to a menu item
                switch (menu_type) {
                    // for session menu
                    case "session" :
                        // Qt.UserRole + 4 is SDDM.NameRole (from src/greeter/SessionModel.h)
                        //sessionModel.data(sessionModel.index(sessionModel.rowCount()-1, 0), Qt.UserRole + 4)
                        btn.menu_item_label = sessionModel.data(sessionModel.index(i, 0), Qt.UserRole + 4);
                        //btn.icon_source = "icons/arrow_right_white.png";
                        // set the icon size
                        //btn.icon_size = 24;
                        break;
                    // for keyboard (layout) menu
                    case "layout":
                        btn.menu_item_label = keyboard.layouts[i].longName;
                        //btn.icon_source = "icons/arrow_right_white.png";
                        // set the icon size
                        //btn.icon_size = 24;
                        break;
                    // for userlist menu
                    case "userlist":
                        // Qt.UserRole + 1 is SDDM.NameRole (from src/greeter/UserModel.h)
                        btn.menu_item_label =  userModel.data(userModel.index(i, 0), Qt.UserRole + 1);

                        // set the icon source
                        // Qt.UserRole + 4 is SDDM.IconRole (from src/greeter/UserModel.h)
                        btn.icon_source = userModel.data(userModel.index(i, 0), Qt.UserRole + 4);
                        // set the prelight icon source
                        btn.icon_prelight_source = userModel.data(userModel.index(i, 0), Qt.UserRole + 4);
                        // set the icon size
                        btn.icon_size = 48;
                        // show the icon
                        btn.is_icon_avatar = true;
                        break;
                }
            }
        }
    }





// INITITALIZE FUNCTIONS ETC.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // loads menu list when parent component has completed
    Component.onCompleted: {
        // load all menu items
        loadMenuList();
        // initialize the menu
        init();
    }





// MENU BORDER IMAGES
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // top left border
    Image {
        source: "images/menu_panel_top-left.png"
        anchors.bottom: parent.top
        anchors.right: parent.left
    }
    // top right border
    Image {
        source: "images/menu_panel_top-right.png"
        anchors.bottom: parent.top
        anchors.left: parent.right
    }
    // bottom left border
    Image {
        source: "images/menu_panel_bottom-left.png"
        anchors.top: parent.bottom
        anchors.right: parent.left
    }
    // bottom right border
    Image {
        source: "images/menu_panel_bottom-right.png"
        anchors.top: parent.bottom
        anchors.left: parent.right
    }

    // top border
    Image {
        width: menuroot.width
        source: "images/menu_panel_top.png"
        anchors.bottom: parent.top
    }
    // bottom border
    Image {
        width: menuroot.width
        source: "images/menu_panel_bottom.png"
        anchors.top: parent.bottom
    }
    // left border
    Image {
        height: menuroot.height
        fillMode: Image.TileVertically
        source: "images/menu_panel_left.png"
        anchors.right: parent.left
    }
    // right border
    Image {
        height: menuroot.height
        fillMode: Image.TileVertically
        source: "images/menu_panel_right.png"
        anchors.left: parent.right
    }

    // center of a menu
    Image {
        width: menuroot.width
        height: menuroot.height
        fillMode: Image.Tile
        source: "images/menu_panel_center.png"
    }





// CONTAINER FOR MENU ITEMS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // list of all menu items
    Column {
        id: itemslist
        anchors.centerIn: parent
        // here will be placed MenuItem.qml objects created dynamically
    }





// KEYBOARD ACTIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // keyboard actions on menu
    Keys.onPressed: {
        // key UP pressed on the keyboard
        if (event.key === Qt.Key_Up && hovered_item >= 0) {
            // turn OFF the prelight of unhovered item
            itemslist.children[hovered_item].item_state = 0;

            // is there a previous menu item?
            if (hovered_item > 0) {
                // change to previous menu item
                hovered_item = hovered_item - 1;
            } else {
                hovered_item = items_count - 1;
            }

            // turn ON the prelight of hovered item
            itemslist.children[hovered_item].item_state = 1;
            // stop propagate the event up the hierarchy
            event.accepted = true;

        // key DOWN pressed on the keyboard
        } else if (event.key === Qt.Key_Down && hovered_item <= (items_count - 1)) {
            // turn OFF the prelight of unhovered item
            itemslist.children[hovered_item].item_state = 0;

            // is there a next menu item?
            if (hovered_item < items_count - 1) {
                // change to the next menu item
                hovered_item = hovered_item + 1;
            } else {
                hovered_item = 0;
            }

            // turn ON the prelight of hovered item
            itemslist.children[hovered_item].item_state = 1;
            // stop propagate the event up the hierarchy
            event.accepted = true;

        // keys ENTER or RETURN or SPACE pressed on the keyboard
        } else if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
            // change "item_state" to 2 = pressed (clicked)
            // it will start the menu choosing procedure
            // for more information look at "item_state" property in "MenuItem.qml"
            itemslist.children[hovered_item].item_state = 2;

        // key ESCAPE pressed on the keyboard
        } else if (event.key === Qt.Key_Escape) {
            // set the hovered item state to OFF
            itemslist.children[hovered_item].item_state = 0;
            // -1 = no choice has been made; escaping menu
            setItem(-1);
        }
    }
}
