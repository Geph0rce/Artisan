cordova.define("com.douban.cordova.socialsharing", function(require, exports, module) {
/*
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
*/
var exec = require('cordova/exec');

module.exports = {
    setupAccount: function(userID, userName, token, expire) {
        exec(null, null, "SocialSharing", "setupAccount", [userID, userName, token, expire]);
    },

    getShareAuthInfo: function(callback) {
        exec(callback, null, "SocialSharing", "getShareAuthInfo", []);
    },

    shareArtist: function(artistID, artistName, artistURL, coverURL, failCallback) {
        if (!artistID) {
            return;
        }
        exec(null, failCallback, "SocialSharing", "shareArtist", [
            artistID, artistName, artistURL, coverURL
        ]);
    },

    shareSong: function(songID, songTitle, songURL, artistID, artistName, coverURL, failCallback) {
        if (!songID) {
            return;
        }
        exec(null, failCallback, "SocialSharing", "shareSong", [
            songID, songTitle, songURL, artistID, artistName, coverURL
        ]);
    },

    logoutDoubanAccount: function() {
        exec(null, null, 'SocialSharing', 'logoutDoubanAccount', []);
    },

    authorizeByVendor: function(vendorType, callback) {
        exec(callback, null, 'SocialSharing', 'authorizeByVender', [vendorType]);
    },

    deAuthorizeByVendor: function(vendorType, callback) {
        exec(callback, null, 'SocialSharing', 'deAuthorizeByVender', [vendorType]);
    }
}
});
