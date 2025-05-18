// Datetime.qml

import QtQuick 2.0
//import QtQuick.Controls 2.0
//import QtGraphicalEffects 1.0
import SddmComponents 2.0


//import org.kde.plasma.core 2.0 as PlasmaCore
//import org.kde.plasma.components 2.0 as PlasmaComponents
//import org.kde.plasma.extras 2.0 as PlasmaExtras


Row {
    id: datetimeroot

    // set the date and time property
    property date dateTime: new Date()

    // the color of the date and time
    readonly property color dt_color: "white"
    // the font family of the date and time
    readonly property string dt_font_family: "Sans"
    // the font size in pixels
    readonly property int dt_font_size: 22





    // timer is triggered in a certain interval
    Timer {
        // set the interval (in miliseconds); set timer to run; set that timer will repeat
        interval: 1000; running: true; repeat: true;
        // refresh the date time
        onTriggered: dateTime = new Date()
    }





    // hostname
    Text {
        // set the text font family, size and color
        font.family: dt_font_family
        font.pixelSize: dt_font_size
        color: dt_color

        //text: textConstants.welcomeText.arg(sddm.hostName)
        text: sddm.hostName
    }

    // this is the separator between hostname and datetime
    Text {
        // set the text font family, size and color
        font.family: dt_font_family
        font.pixelSize: dt_font_size
        color: dt_color

        // the separator
        text: " // "
    }





    // the date text
    Text {
        // set the text font family, size and color
        font.family: dt_font_family
        font.pixelSize: dt_font_size
        color: dt_color

        // set the date text
        text : Qt.formatDate(dateTime, Qt.DefaultLocaleLongDate)

    }

    // this is the separator between the date and time
    Text {
        // set the text font family, size and color
        font.family: dt_font_family
        font.pixelSize: dt_font_size
        color: dt_color

        // separator text
        text: ", "
    }

    // the time text
    Text {
        // set the text font family, size and color
        font.family: dt_font_family
        font.pixelSize: dt_font_size
        color: dt_color

        // set the text
        text : Qt.formatTime(dateTime, "hh:mm:ss")
    }
}
