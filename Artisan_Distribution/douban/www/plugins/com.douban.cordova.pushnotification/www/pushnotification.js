cordova.define("com.douban.cordova.pushnotification", function(require, exports, module) {
//
//  PushNotification.js
//
// Created by Olivier Louvignes on  2012-05-06.
// Inspired by Urban Airship Inc orphaned PushNotification phonegap plugin.
//
// Copyright 2012 Olivier Louvignes. All rights reserved.
// MIT Licensed

var exec = require('cordova/exec');

module.exports = {
    // Call this to register for push notifications and retreive a deviceToken
    registerDevice: function(config, callback) {
        exec(callback, callback, "PushNotification", "registerDevice", config ? [config] : []);
    },

    // Call this to retreive pending notification received while the application is in background or at launch
    getPendingNotifications: function(callback) {
    	exec(callback, callback, "PushNotification", "getPendingNotifications", []);
    },

    // Call this to get a detailed status of remoteNotifications
    getRemoteNotificationStatus: function(callback) {
       exec(callback, callback, "PushNotification", "getRemoteNotificationStatus", []);
    },

    // Call this to get the current value of the application badge number
    getApplicationIconBadgeNumber: function(callback) {
        exec(callback, callback, "PushNotification", "getApplicationIconBadgeNumber", []);
    },

    // Call this to set the application icon badge
    setApplicationIconBadgeNumber: function(badge, callback) {
        exec(callback, callback, "PushNotification", "setApplicationIconBadgeNumber", [badge]);
    },

    // Call this to clear all notifications from the notification center
    cancelAllLocalNotifications: function(callback) {
    	exec(callback, callback, "PushNotification", "cancelAllLocalNotifications", []);
    },

    // Call this to retreive the original device unique id
    // @warning As of today, usage is deprecated and requires explicit consent from the user
    getDeviceUniqueIdentifier: function(callback) {
    	exec(callback, callback, "PushNotification", "getDeviceUniqueIdentifier", []);
    },

    // Event spawned when a notification is received while the application is active
    notificationCallback: function(notification) {
    	var ev = document.createEvent('HTMLEvents');
    	ev.notification = notification;
    	ev.initEvent('push-notification', true, true, arguments);
    	document.dispatchEvent(ev);
    }
}
});
