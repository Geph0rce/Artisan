cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/org.apache.cordova.inappbrowser/www/InAppBrowser.js",
        "id": "org.apache.cordova.inappbrowser.InAppBrowser",
        "clobbers": [
            "window.open"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.statusbar/www/statusbar.js",
        "id": "org.apache.cordova.statusbar.statusbar",
        "clobbers": [
            "window.StatusBar"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.dialogs/www/notification.js",
        "id": "org.apache.cordova.dialogs.notification",
        "merges": [
            "navigator.notification"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.dialogs/www/android/notification.js",
        "id": "org.apache.cordova.dialogs.notification_android",
        "merges": [
            "navigator.notification"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.media/www/MediaError.js",
        "id": "org.apache.cordova.media.MediaError",
        "clobbers": [
             "window.MediaError"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.media/www/Media.js",
        "id": "org.apache.cordova.media.Media",
        "clobbers": [
             "window.Media"
        ]
    },
    {
        "file": "plugins/com.douban.cordova.statusbarnotification/www/android/statusbarnotification.js",
        "id": "com.douban.cordova.statusbarnotification",
        "clobbers": [
            "window.plugins.StatusBarNotification"
        ]
    },
    {
        "file": "plugins/com.douban.cordova.socialsharing/www/socialsharing.js",
        "id": "com.douban.cordova.socialsharing",
        "clobbers": [
            "plugins.SocialSharing"
        ]
    },
    {
        "file": "plugins/com.douban.cordova.softkeyboard/www/android/softkeyboard.js",
        "id": "com.douban.cordova.softkeyboard",
        "clobbers": [
            "plugins.SoftKeyBoard"
        ]
    },
    {
        "file": "plugins/com.douban.cordova.feedback/www/feedback.js",
        "id": "com.douban.cordova.feedback",
        "clobbers": [
            "plugins.Feedback"
        ]
    },
    {
        "file": "plugins/com.douban.cordova.redirect/www/redirect.js",
        "id": "com.douban.cordova.redirect",
        "clobbers": [
            "plugins.Redirect"
        ]
    },
    {
        "file": "plugins/com.douban.cordova.pushnotification/www/pushnotification.js",
        "id": "com.douban.cordova.pushnotification",
        "clobbers": [
            "plugins.pushNotification"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "org.apache.cordova.inappbrowser": "0.5.2",
    "org.apache.cordova.statusbar": "0.1.8",
    "org.apache.cordova.dialogs": "0.2.10",
    "org.apache.cordova.media": "0.2.13"
}
// BOTTOM OF METADATA
});