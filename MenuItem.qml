// MenuItem.qml
// this is dynamically created in MenuList.qml
// in Column { id: items_list }



import QtQuick 2.0
//import SddmComponents 2.0

// MAIN MENU ITEM RECTANGLE
Rectangle {
    id: menuitemroot
    width: item_width
    height: item_height
    // it is fully transparent (alpha: 00)
    color: "#006ab3ff"
    border.width: 0





// PUBLIC PROPERTIES
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // index of a menu item in a list
    // it's a number needed for mouse/keyboard actions
    // and for login procedure
    property int index: 0

    // menu item label text
    property string menu_item_label: ""



    // menu item icon
    property url icon_source: "icons/arrow_right_white.png"
    // menu item prelight icon
    property url icon_prelight_source: "icons/arrow_right_blue.png"
    // icon size
    property int icon_size: 24 //is_icon_avatar ? 64 : 0
    // icon visibility
    property bool is_icon_avatar: false





// INNER PROPERTIES
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // menu item width
    readonly property int item_width: 400
    // menu item height
    readonly property int item_height: icon_size > 24 ? icon_size + 8 : 24 + 8

    // normal state of a text label
    readonly property color label_color: "white"
    // hover state of a text label
    readonly property color hover_label_color: "#6ab3ff"

    // opacity of a menu background
    readonly property int menu_bg_opacity: 0.00
    // highlihted bg opacity while hovering mouse above menu item
    readonly property int hover_bg_opacity: 1.00





    // changes the visibility of the icon according to whether the icon is avatar
    onIs_icon_avatarChanged: {
        // show the avatar if the icon is avatar
        icon.visible = is_icon_avatar;
    }



    // last selected menu item
    // true = item is last selected; false = item isn't last selected
    property bool last_selected: false

    // set the last selected menu item
    onLast_selectedChanged: {
        // is this item the last selected item?
        if (last_selected) {
            // set the last selected item
            label.font.underline = true;
            // icon is visible
            icon.visible = true;
        } else {
            // unset the last selected item
            label.font.underline = false;
            // isn't the icon avatar?
            if (!is_icon_avatar) {
                // icon is invisible
                icon.visible = false;
            }
        }
    }


    // changes of this will change the item bg image
    // 0 = normal; 1 = prelight; 2 = pressed (clicked)
    property int item_state

    // this will invoke when "item_state" changes
    // 0 = normal; 1 = prelight; 2 = pressed (clicked)
    onItem_stateChanged: {
        switch (item_state) {
        // 0 = normal
        case 0 :
            handleExited();
            break;
        // 1 = prelight
        case 1 :
            handleEntered();
            break;
        // 2 = pressed (clicked)
        case 2 :
            handleClicked();
            break;
        }
    }





// PUBLIC PROPERTIES HODLING A FUNCTION
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // this variable holds setItem(index) function from MenuList.qml,
    // which starts when mouse has been clicked on an item and
    // response animation finishes
    property var setItem

    // this variable holds a function setHoveredItem(index) from "MenuList.qml",
    // which starts when a mouse hover over an item
    property var setHoveredItem





// INNER FUNCTION
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // on entered action
    // starts when mouse hover over an item
    function handleEntered() {
        // has clicked animation stopped?
        if (clickanim.running == false) {
            // makes label text the menu bg color (blue)
            label.color = hover_label_color;
            // makes hover bg visible
            hoverbg.visible = true;

            // is icon visible?
            if (icon.visible) {
                // change the icon source
                icon.source = icon_prelight_source;
            }
        }

    }



    // on exited action
    // starts when mouse exits an item
    function handleExited() {
        // has clicked animation stopped?
        if (clickanim.running == false) {
            // change label color to its default (white)
            label.color = label_color;
            // makes hover bg hidden
            hoverbg.visible = false;

            // is icon visible?
            if (icon.visible) {
                // change the icon source
                icon.source = icon_source;
            }
        }
    }



    // on clicked action
    // starts when mouse click on an item
    function handleClicked() {
        clickanim.start();
    }





// ANIMATIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // animation on mouse click
    // animating blinking
    SequentialAnimation {
        id: clickanim
        loops: 3
        // opacity to transparent
        PropertyAnimation {
            target: hoverbg
            property: "opacity"
            to: menu_bg_opacity
            duration: 45
        }
        // opacity to visible
        PropertyAnimation {
            target: hoverbg
            property: "opacity"
            to: hover_bg_opacity
            duration: 45
        }
        // the animation is finished
        onStopped: {
            // makes label text the default color (white)
            label.color = label_color;
            // makes hover bg hidden
            hoverbg.visible = false;

            // is icon visible?
            if (icon.visible) {
                // change the icon source
                icon.source = icon_source;
            }

            // the menu item was chosen
            // (look at the "setItem" property declared above)
            setItem(menuitemroot.index);
        }
    }





// HOVERING BACKGROUND IMAGES
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    // hovering background (image)
    Item {
        id: hoverbg
        width: menuitemroot.width
        height: menuitemroot.height

        anchors.centerIn: menuitemroot

        // this will change on mouse action
        opacity: hover_bg_opacity
        // visibility: true = hovering ; false = not hovering
        visible: false

        // left image part
        Image {
            //id:bgleft
            width: 48
            height: item_height
            source: "images/menu_item_bg_left.png"
            anchors.right: bgmiddle.left
        }
        // middle image part
        Image {
            id: bgmiddle
            width: menuitemroot.width - 32 //label_text.width + 32
            height: item_height
            source: "images/menu_item_bg_center.png"
            anchors.centerIn: parent
        }
        // right image part
        Image {
            //id: bgright
            width: 48
            height: item_height
            source: "images/menu_item_bg_right.png"
            anchors.left: bgmiddle.right
        }
    } // hoverbg END





// ICON AND LABEL
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






    // adds an icon to the menu
    Image {
        id: icon
        // icon image source
        source: icon_source
        // icon size
        width: icon_size
        height: icon_size

        // icon visibility
        visible: false

        // place the icon by the left side of the parent (menuitemroot)
        anchors.left: parent.left
        anchors.verticalCenter: menuitemroot.verticalCenter
    }



    // menu item label
    Text {
        id: label
        // changes dynamically on mouse (keyoboard) action
        color: label_color
        // changes on dynamic creation from MenuList.qml
        text: menu_item_label

        // changes when item is selected
        font.underline: false

        // set the font size etc.
        font.bold: true
        font.pixelSize: 20
        font.family: "Sans"

        // place it by the right side of an icon, vertically centered
        anchors.left: icon.right
        anchors.leftMargin: icon_size / 2
        anchors.verticalCenter: icon.verticalCenter
    }





// MOUSE INTERACTIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






    // mouse interactions
    MouseArea {
        //id: mousearea
        // active over a whole menu item rectangle
        anchors.fill: parent

        // enable the hover function to perform
        // without a mouse button pressed
        hoverEnabled: true

        // entering item with a mouse pointer
        onEntered: {
            // set the hovered item
            // (look at the "setHoveredItem" property declared above)
            // THIS LINE MUST PRECEDE THE "item_state = 1;" LINE
            // FOR LEAVING MENU AND REENTER MENU WITH MOUSE POINTER (BUG)
            setHoveredItem(index);
            // turn ON the menu item highlight
            item_state = 1;
        }
        // exiting button with a mouse pointer
        onExited: {
            // turn OFF the menu item highlight
            item_state = 0;
        }
        // clicked the menu item
        onClicked:
            // start an animation and additionaly
            // call setItem(menu_item.index) onStopped
            // look at the animation declared above

            //handleClicked();
            item_state = 2;
    } // MouseArea END

} // menuitemroot END
