if (isIDevice || isWebOS || (!isAndroid && /Chrome\/\d/.test(navigator.userAgent))){

window.player = new (function(){
    var audio,
        now_order,
        started = false,
        dura = 0,
        /* { src: title: icon: link } */
        playlist = [];

    this.init = function(target){
        var self = this;
        audio = target;
        audio.addEventListener('ended', function(){
            $.event.trigger('playComplete');
            self.record_log(self.ACTION_COMPLETE, playlist[now_order],
                            audio.currentTime);
            self.play_next();
        });
        audio.addEventListener('loadedmetadata', function(){
            if (audio.duration) {
                dura = audio.duration;
                //tr('loadedmetadata, dura:' + dura);
            }
        });
        audio.addEventListener('error', function(){
            tr('audio error');
            $.event.trigger('playError');
            $.event.trigger('playComplete');
            setTimeout( function(){
                self.play_next();
            }, 2000);
        });
        audio.addEventListener('timeupdate', function(){
            var progress = {
                now: audio.currentTime,
                /* if no duration is available, use fake */
                all: dura || 300
            };
            if(progress.now > 0) {
                $.event.trigger('playTimeUpdate', progress);
                if(started === false){
                    started = true;
                    $.event.trigger('ajaxComplete');
                }
            }
        })
    };

    this.play_next = function(do_record){
        if (do_record !== undefined) {
            this.record_log(this.ACTION_SKIP, playlist[now_order],
                            audio.currentTime);
        }
        this.play(now_order + 1 < playlist.length ? now_order + 1 : 0);
        if ((new Date()).getTime() - playlist[now_order].utime > 60000 * 30) {
            Playlist.refresh_list();
        }
    }

    this.set_playlist = function(pl){
        playlist = pl;
    }

    this.play_id = function(id){
        for (var i=0; i<playlist.length; i++) {
            if (playlist[i].id === id) {
                this.play(i);
                break;
            }
        }
    }

    this.play = function(order){
        var self = this;
        if (typeof order == 'string' && !parseInt(order)){
            audio.src = order;
            audio.load();
            audio.play();
        }

        order = order || 0;
        if (playlist.length > order) {
            now_order = order;
            var song = playlist[order];
            audio.src = song.src;
            audio.load();
            audio.play();
            started = false;
            itr(song);
            //tr("html5, now play " + song.duration);
            var t = song.duration.split(':');
            dura = t.length == 2 ? ((Number(t[0]) || 0) * 60 + (Number(t[1]) || 0)) : 0;
            //tr("html5 " + song.duration + ", t:" + t + ", dura:" + dura);
            $.event.trigger('ajaxSend');
            $.event.trigger('startPlay', song);
            self.record_log(self.ACTION_LAUNCH, song);
        }
    };

    this.pause = function(){
        audio.pause();
        $.event.trigger('ajaxComplete');
        $.event.trigger('stopPlay');
    };
    this.resume = function(){
        audio.play();
        started = false;
        $.event.trigger('ajaxSend');
        $.event.trigger('startPlay', playlist[now_order]);
    };
    this.stop = function(){
        audio.pause();
        $.event.trigger('ajaxComplete');
        $.event.trigger('stopPlay');
    }
})();


} // use html5
else
{ // use phonegap api


window.player = new (function(){
    var audio,
        audio_timer,
        now_order,
        started = false,
        currentTime = 0,
        /* playlist: { src: title: icon: link } */
        playlist = [];

    this.init = function(target){
    };

    this.play_next = function(do_record){
        if (do_record !== undefined) {
            this.record_log(this.ACTION_SKIP, playlist[now_order], currentTime);
        }
        this.play(now_order + 1 < playlist.length ? now_order + 1 : 0);
        //tr('play next with id=', now_order+1);
    }

    this.set_playlist = function(pl){
        playlist = pl;
    }

    this.play_id = function(id){
        for (var i=0; i<playlist.length; i++) {
            if (playlist[i].id === id) {
                //tr('now play id :'+id+' with order: '+ i);
                this.play(i);
                break;
            }
        }
    }

    this.play = function(order){
        if (typeof order == 'string' && !parseInt(order)){
            tr("order must be a number");
            return;
        }
        var self = this;
        order = order || 0;
        if (playlist.length > order) {
            now_order = order;
            var onSuccess = function(order){
                return function() {
                    if (order == now_order) {
                        if (playlist.length === 1) {
                            var duration = parseInt(audio.getDuration());
                            if (currentTime >= duration) {
                                self.record_log(self.ACTION_COMPLETE, playlist[now_order],
                                currentTime);
                            }
                        } else {
                            self.record_log(self.ACTION_COMPLETE, playlist[now_order],
                                currentTime);
                        }
                        player.play_next();
                    }
                }
            },
            onError = function(e){
                //tr("Error getting pos=" + e);
            },
            onStatus = function(e) {
            };

            if (audio) {
                try {
                    audio.stop();
                    audio.release();
                } catch(e) {
                    tr('release error');
                }
            }
            var song = playlist[order];
            tr('now play: ' + song.src);
            //tr("cordova " + song.duration);
            audio = new Media(song.src, onSuccess(order), onError, onStatus);
            audio.play();
            self.record_log(self.ACTION_LAUNCH, song);
            started = false;
            $.event.trigger('ajaxSend');
            $.event.trigger('startPlay', song);

            if (audio_timer) {
                try {
                    clearInterval(audio_timer);
                } catch(e) {
                    tr('clear interval error');
                }
            }
            audio_timer = setInterval(function(){
                audio.getCurrentPosition(
                    function(pos) {
                        if (pos > -1 && audio.getDuration() > 0) {
                            currentTime = pos;
                            var progress = {
                                now: Number(pos),
                                all: Number(audio.getDuration())
                            };
                            $.event.trigger('playTimeUpdate', progress);
                            if(started === false){
                                started = true;
                                $.event.trigger('ajaxComplete');
                            }
                        }
                    }
                )
            }, 700);
        }
    };

    this.pause = function(){
        if (audio) {
            audio.pause();
            $.event.trigger('ajaxComplete');
            $.event.trigger('stopPlay');
        }
    };
    this.resume = function(){
        audio.play();
        started = false;
        $.event.trigger('ajaxSend');
        $.event.trigger('startPlay', playlist[now_order]);
    };
    this.stop = function(){
        audio.stop();
        $.event.trigger('ajaxComplete');
        $.event.trigger('stopPlay');
    }
})();

}

player.record_log = function(action, song, play_length) {
    play_length = play_length ? parseInt(play_length) : 0;
    var payload = {
        art_song_id: song.id,
        play_mode: "default",
        play_length: play_length,
        action: action,
        source: isIDevice ? "ios" : isAndroid ? "android" : "webapp",
        datetime: (new Date()).getTime()
    },
    records = JSON.stringify([{type: "play", payload: payload}]);
    $.getp(API + "/player_action_log", {records: records}, true, function(r) {
        //tr("report returns", r.r);
    }, true);
}

player.ACTION_COMPLETE = 'c';
player.ACTION_LAUNCH = 'l';
player.ACTION_SKIP = 's';
