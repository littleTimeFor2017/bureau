var lpath = '';
var vserverpath = '';
var v_code = '';
var tt = "1";
var prvstudtime = -1;
//last player before jump
var lastTime = 0;
var v_minute = 0;
var v_second = 0;
var points = '';
var tips = '';
var point_list = '';
var play = false;
var flag = 0;
var aid = "0";
var swidth = "0";
var sheight = "0";
var pauto = true;
var i_logo = "";
var l_location = "";
var p_status = "";
var pause_time = null;
var terminal = "P";
var player;
var timeAdjustMode=1;
var isM = "N";

!function () {
    var haveCkjs = false;
    var scriptList = document.scripts;
    for (var i = 0; i < scriptList.length; i++) {
        if (scriptList[i].src.indexOf("/common/player/outplayer.js") > -1) {
            t_url = scriptList[i].src;
            var whole_url = t_url.split("//");
            t_url = whole_url[1].split("/");
            vserverpath = whole_url[0] + "//" + t_url[0] + "/" + t_url[1];
            if (lpath == '') lpath = vserverpath;
        }
        if (scriptList[i].src.indexOf("/common/player/ckplayer.js") > -1) haveCkjs = true;
    }
    if (!haveCkjs) {
        var script = document.createElement("script");
        script.type = "text/javascript";
        if (script.readyState) { //IE
            script.onreadystatechange = function () {
                if (script.readyState == "loaded" || script.readyState == "complete") {
                    script.onreadystatechange = null;
                    //console.log(ckurl);
                    loadPlay(vid);
                }
            };
        } else {
            script.onload = function () {
                //console.log(ckurl);
                loadPlay(vid);
            };
        }
        var ckurl = vserverpath + '/common/player/ckplayer.js?v='+Math.random();
        script.src = ckurl;
        document.getElementsByTagName("HEAD")[0].appendChild(script);
    }
}();

function initPlay(v_code) {
    $("#a1").width("100%");
    $("#a1").height(document.documentElement.clientHeight - 10);
    loadPlay(v_code);
}

function loadPlay(video_code) {
    if (video_code == "I") {
        $("#a1").html("<div class='zmts'>视频正在转码中，请稍候...</div>");
        return;
    }

    getLoginAddress();
    try {
        var xmlhttp = new XMLHttpRequest();

        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var v_src = "";
                var v_url_base = "";
                var v_url_l = "";
                var v_url_s = "";
                var v_url_h = "";
                var t_video = decodeURIComponent(xmlhttp.responseText);
                t_video = t_video.replace(/<\/?[^>]*>/g, '');
                t_video = t_video.replace(/[\r\n]/g, "");
                var v_info = new Array();
                v_info = t_video.split("||");
                v_url_l = encodeURIComponent(v_info[0]);
                v_url_s = encodeURIComponent(v_info[1]);
                v_url_h = encodeURIComponent(v_info[2]);
                if (v_info[3] == "1") v_src = v_url_l;
                else if (v_info[3] == "2") v_src = v_url_s;
                else if (v_info[3] == "3") v_src = v_url_h;
                aid = v_info[4];
                swidth = v_info[5];
                sheight = v_info[6];
                pauto = v_info[7];
                i_logo = v_info[8];
                terminal = v_info[9];
                v_url_base = encodeURIComponent(v_info[10]);
//	    	console.log(aid+"  "+v_src+"  "+pauto+"  "+i_logo);
                if (v_url_l == "noright") {
                    $("#a1").html("<img src='" + vserverpath + "/common/player/noprv.png'>");
                    return;
                }
                else if (v_url_l == "I") {
                    $("#a1").html("提示，视频正在转码中，请稍候......");
                    return;
                }
                if (terminal == "P") formalPlay(v_url_base);
                else formalPlayHtml5(v_url_base);
            }
        };
        xmlhttp.open("get", vserverpath + "/ondemand/ckplayer/geturl.jsp?v_code=" + video_code + "&location=" + l_location, false);
        xmlhttp.send();
    } catch (error) {
        ;//console.log(error.message);
    }

}

function formalPlay(v_src) {
	 if(pauto=="1" )	 pauto=true;  else  pauto=false; 	
    var videoObject = {
        container: '#a1',
        variable: 'player',
        loaded: 'loadedHandler',//监听播放器加载成功
        autoplay: pauto,
        html5m3u8: true,
        promptspot: tips,
        promptspottime: points,
        schedule: timeAdjustMode,
        timeScheduleAdjust: timeAdjustMode,
        poster: i_logo,
        video: (v_src)
    };
    if (sheight == '0') sheight = document.documentElement.clientHeight - 10;
    else if (sheight < 0) sheight = "98%";
    else sheight=sheight+"px";
    if (swidth == '0') swidth = "100%";
    else swidth=swidth+"px";    
    if (document.getElementById("a1")) {
        document.getElementById("a1").style.height = sheight;
        document.getElementById("a1").style.width = swidth;
    }
    player = new ckplayer(videoObject);
    pause_time = new Date();
    //console.log(videoObject);
    if (prvstudtime > 0) {max_point=prvstudtime; videoSeek(prvstudtime);}
}


function formalPlayHtml5(v_src) {
	 if(pauto=="1" )	 pauto=true;  else  pauto=false; 	
    var videoObject = {
        container: '#a1',
        variable: 'player',
        loaded: 'loadedHandler',//监听播放器加载成功
        autoplay: pauto,
        promptspot: tips,
        promptspottime: points,
        schedule: timeAdjustMode,
        timeScheduleAdjust: timeAdjustMode,
        poster: i_logo,
        video: (v_src)
    };

    if (sheight == '0') sheight = document.documentElement.clientHeight - 10;
    else if (sheight < 0) sheight = "98%";
    else sheight=sheight+"px";
    if (swidth == '0') swidth = "100%";
    else swidth=swidth+"px";  
    if (document.getElementById("a1")) {
        document.getElementById("a1").style.height = sheight;
        document.getElementById("a1").style.width = swidth;
    }
    player = new ckplayer(videoObject);
    pause_time = new Date();
    if (prvstudtime > 0)  {max_point=prvstudtime; videoSeek(prvstudtime);}
}


function initLive(video_code) {
    getLoginAddress();
    try {
        var xmlhttp = new XMLHttpRequest();
        var v_src = "";
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var t_video = decodeURIComponent(xmlhttp.responseText);
                v_src = t_video.replace(/<\/?[^>]*>/g, '');
                v_src = t_video.replace(/[\r\n]/g, "");

                if (v_src == "noright") {
                    $("#livearea").html("<img src='" + vserverpath + "/common/player/noprv.png'>");
                    return;
                }
                var scriptList = document.scripts, thisPath = scriptList[scriptList.length - 1].src;
                javascriptPath = thisPath.substring(0, thisPath.lastIndexOf('/') + 1);

                for (var i = 0; i < scriptList.length; i++) {
                    if (scriptList[i].src.indexOf("/ckplayer.js") > -1) {
                        thisPath = scriptList[i].src;
                        javascriptPath = thisPath.substring(0, thisPath.lastIndexOf('/') + 1);
                    }
                }

                if (terminal == "P") livePlay(v_src);
                else livePlay(v_src);
            }
        };
        xmlhttp.open("get", vserverpath + "/livecast/channel/geturl.jsp?v_code=" + video_code + "&location=" + l_location, false);
        xmlhttp.send();
    } catch (error) {
        ;//console.log(error.message);
    }

}

function livePlay(v_src) {
    var videoObject = {
        container: '#livearea',
        variable: 'player',
        autoplay: true,
        live: true,
        video: v_src
    };
    player = new ckplayer(videoObject);
    if (sheight == '0') sheight = "400";
    if (swidth == '0') swidth = "600";
    pause_time = new Date();
}

function getLoginAddress() {
    try {
        $.getScript('https://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js', function (_result) {
            if (remote_ip_info.ret == '1') {
                l_location = encodeURIComponent(encodeURIComponent(remote_ip_info.country + "%" + remote_ip_info.province + "%" + remote_ip_info.city));
                //console.info(remote_ip_info.country+"%"+remote_ip_info.province+"%"+remote_ip_info.city);
            }
        });
    } catch (e) {
        ;
    }
}

function savePlaytime(ltime) {
    var pause_now = new Date();
    var ptime = Math.round((pause_now.getTime() - pause_time.getTime()) / 1000);

    if (ptime < 2) {
        return;
    }
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open("post", vserverpath + "/ondemand/ckplayer/saveurl.jsp?aid=" + aid + "&ltime=" + ltime + "&ptime=" + ptime + "&location=" + l_location, true);
    xmlhttp.send();
}

//监听播放器事件
function ckplayer_status(str) {
    //监听文字广告关闭事件，保持非关闭状态
    //console.log(str+ " :  "+lastTime);
    if (str == "marqueeClose") {
        player.marqueeLoad(true);
    }
    if (str == "pause") { //ended
        p_status = "STOP";
        savePlaytime(lastTime);
    }
    if (str == "play") {
        if (p_status == "STOP") {
            player.videoPlay();
            pause_time = new Date();
            p_status = "PLAY";
        }
    }
    if (str == "ended") { //ended
        p_status = "STOP";
        status = 'C';
        saveStudy('R');
    }
    //监听播放时间
    if (str == 'time') {
        if (prvstudtime > 0) {
        	max_point=prvstudtime;
        	videoSeek(prvstudtime);
            prvstudtime = -1;
        }
        if (p_status == "STOP") {
            pause_time = new Date();
            p_status = "PLAY";
        }
        checkPointTime(lastTime);
    }
    var f = Math.abs(flag - lastTime);
    if (f >= 1) {
        play = false;
        flag = 0;
    }

}

//检查播放时间是否到了视频点处
function checkPointTime(t) {
    $(point_list).each(function () {
        var point = $(this)[0];
        if (point.time_point == t && point.que_count > 0 && play == false) {
            play = true;
            flag = t;
            player.videoPause();   //暂停播放
            //初始化试题界面
            initExam(point.id);
        }
    });
}

//初始化试题界面
function initExam(point_id) {
    $("#bg").show();
    if(isM == "Y") {
        $("#ckplayer_a1").hide();
    }
    var height = $("#a1").height();
    var width = $("#a1").width();
    if(width >= 1024){
        height = height - 200;
        width = width - 600;
        $("#exam").width(width).height(height + 20);
        $("#exam").css("top", "100px");
        $("#exam").css("left", "300px");
    }else {
        height = height - 50;
        width = width - 100;
        $("#exam").width(width).height(height + 20);
        $("#exam").css("top", "25px");
        $("#exam").css("left", "50px");
    }
    $("#exam").removeClass("hide");
    var idx = layer.load(300);
    var url = lpath + "/point/goVideoPointExam.action";
    var data = {
        "videoPointQueMapping.point_id": point_id,
        "videoPointQueMapping.curPage": 1,
        "videoPointQueMapping.pageSize": 999
    };
    $("#exam").load(url, data, function (res) {
        layer.close(idx);
    });
}

//完成弹题测试，恢复视频播放
function completeExam() {
    $("#bg").hide();
    $("#exam").addClass("hide");
    $("#a1").fadeIn("slow");
    $("#ckplayer_a1").show();
    videoPlay();
}

function loadedHandler() {
    $("#ckplayer_a1").attr("x-webkit-airplay","true");
    $("#ckplayer_a1").attr("x5-video-player-type","h5");
    $("#ckplayer_a1").attr("x5-video-orientation","h5");
    $("#ckplayer_a1").attr("x5-video-player-fullscreen","true");
    $("#ckplayer_a1").attr("x5-playsinline","true");
    $("#ckplayer_a1").attr("playsinline","true");
    player.addListener('time', timeHandler);
    player.addListener('pause', pauseHandler);
    player.addListener('ended', endedHandler);
    //     player.addListener('seeked', seekedHandler);
    if (typeof newAnimate != 'undefined' && newAnimate instanceof Function) {
        newAnimate(10, 50);
    }
}

function rmTimeHander() {
    player.removeListener('time', timeHandler);
    player.removeListener('pause', pauseHandler);
    player.removeListener('ended', endedHandler);
    //   player.removeListener('seeked', seekedHandler);
    // $("#a1").html("");
}

function seekTimeHandler(ttx) {
    //if(ttx > time){
    //console.log(time+"   time-2   "+ttx);
    rmTimeHander();
    player.videoSeek(10);
    loadedHandler();
    //   player.addListener('seekTime', seekTimeHandler);
    //	}
}

function seekHandler(ttx) {
    if (time < 1) return;
    //if(ttx > time){
    //console.log(time+"   time-1  "+ttx);
// player.removeListener('seek', seekHandler);
    rmTimeHander();
    player.videoSeek(30);
    loadedHandler();
    //player.addListener('seek', seekHandler);
    //}
}

function timeHandler(t) {
    if (t < 1) return;
    lastTime = Math.floor(t);
    ckplayer_status("time");
    var from = '';
    if (from.equals("NL")) {
        player._K_('nowTime').innerHTML = '已经预览：' + parseInt(t) + " 秒 可预览：" + (parseInt(tt) * 60) + "秒，之后将停止播放。";
        if (t >= parseInt(tt) * 60) {
            //$("#dModal").modal('hide');
            player.videoPause();
            layer.confirm('预览已结束，断续观看需要参加此课程！', {icon: 3, title: '温馨提示'}, function () {
                window.location.href = window.location.href;
            }, function () {
                rmTimeHander();
                $('#dModal').modal('hide');
                layer.msg('正在关闭预览...', {icon: 1});
            })
        }
    }
}

function playingHandler() {
    ckplayer_status("play");
}

function pauseHandler() {
    ckplayer_status("pause");
}


//暂停视频播放,返回正在播放的时间点
function videoPause() {
    ckplayer_status("pause");
}

//暂停视频播放,返回正在播放的时间点
function endedHandler() {
    ckplayer_status("ended");
}

//继续播放视频
function videoPlay() {
    ckplayer_status("play");
}

//获取视频分钟数
function getVideoMinute() {
    return v_minute;
}

//获取视频秒数
function getVideoSecond() {
    return v_second;
}

//获取视频总时长
function getVideoTime() {
    return v_minute * 60 + v_second;
}

//跳转视频播放位置
function videoSeek(p_time) {
    player.videoSeek(p_time);
}