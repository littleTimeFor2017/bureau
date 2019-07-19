var lpath='';	
var vserverpath=''; 
var v_code='';	
var tt = "1";
var time = 0;
var v_minute =0;
var v_second =0;
var points ='';
var tips ='';
var point_list = '';
var play = false;
var flag = 0;
var aid="0";
var swidth="0";
var sheight="0";
var pauto=true;
var i_logo="";		
var l_location="";
var p_status="";
var pause_time=null;
var terminal="P";
var player ;

function initPlay(v_code)
{
	$("#a1").width("100%");
	$("#a1").height(document.documentElement.clientHeight-10);
	loadPlay(v_code);
}


    function loadPlay(video_code)
    {
    	getLoginAddress();
    	try{
    	var xmlhttp = new XMLHttpRequest();
    	
	    xmlhttp.onreadystatechange=function()
	    {
	    if (xmlhttp.readyState==4 && xmlhttp.status==200)
	     {
	    	var v_src="";
	        var v_url_base="";
	    	var v_url_l="";
	    	var v_url_s="";
	    	var v_url_h="";		    	
	    	var t_video=decodeURIComponent(xmlhttp.responseText);
	    	t_video=t_video.replace(/<\/?[^>]*>/g,'');
	    	t_video=t_video.replace(/[\r\n]/g,"");
	    	var v_info=new Array();
	    	v_info=t_video.split("||");
	    	v_url_l = encodeURIComponent(v_info[0]);
	    	v_url_s = encodeURIComponent(v_info[1]);
	    	v_url_h = encodeURIComponent(v_info[2]);	    	
	    	if(v_info[3]=="1") 	v_src=v_url_l;
	    	else if(v_info[3]=="2") 	v_src=v_url_s;
	    	else if(v_info[3]=="3") 	v_src=v_url_h;	    	
	    	aid=v_info[4];
	    	swidth=v_info[5];
	    	sheight=v_info[6];
	    	pauto=v_info[7];
	    	i_logo=v_info[8];
	    	terminal=v_info[9];
	    	v_url_base=encodeURIComponent(v_info[10]);	    	
//	    	console.debug(aid+"  "+v_src+"  "+pauto+"  "+i_logo);
	    	if(v_url_l=="noright")
	    	{	
	    	$("#a1").html("<img src='"+vserverpath+"/common/player/noprv.png'>");
	    	return;
	    	}
            else if (v_url_l == "I") {
                $("#a1").html("提示，视频正在转码中，请稍候......");
                return;
            }	    	
	    	if(terminal =="P") formalPlay(v_url_base);
	    	else formalPlayHtml5(v_url_base);

	      }
	    };
	    xmlhttp.open("get",vserverpath +"/ondemand/ckplayer/geturl.jsp?v_code="+video_code+"&location="+l_location,false);
	    xmlhttp.send();
    	} catch (error){
    		;//console.debug(error.message);
	      }

    }

    function formalPlay(v_src)
    {
    	var videoObject = {
    			container: '#a1',
    			variable: 'player',
    			loaded:'loadedHandler',//监听播放器加载成功			
    			autoplay:true,
    			promptspot:tips,
    			promptspottime:points,    			
    			schedule: 1,
    			timeScheduleAdjust:1,
    			poster: i_logo,
    			video:  (v_src)
    	};
        if(sheight=='0') sheight = document.documentElement.clientHeight-10;
        if(sheight<0)    sheight="98%";
        if(swidth =='0') swidth ="98%";
        if (document.getElementById("a1")){
            document.getElementById("a1").style.height = sheight;
            document.getElementById("a1").style.width = swidth;
        }
        player = new ckplayer(videoObject);
    	pause_time= new Date();
    }

    
    function formalPlayHtml5(v_src)
    {
    	var videoObject = {
    			container: '#a1',
    			variable: 'player',
    			loaded:'loadedHandler',//监听播放器加载成功			
    			autoplay:true,
    			promptspot:tips,
    			promptspottime:points,     			
    			//mobileCkControls: true,
    			schedule: 5,
    			timeScheduleAdjust:5,
    			poster: i_logo,
    			video:  (v_src)
    		};
    	
        if(sheight=='0') sheight = $("body").height()-10;
        if(swidth =='0') swidth = "99%";
        if (document.getElementById("a1")){
            document.getElementById("a1").style.height = sheight;
            document.getElementById("a1").style.width = swidth;
        }
        player = new ckplayer(videoObject);
	    pause_time= new Date();
    }
    
    
    function initLive(video_code)
    {
    	//getLoginAddress();
    	try{
    	var xmlhttp = new XMLHttpRequest();
    	var v_src="";
	    xmlhttp.onreadystatechange=function()
	    {
	    if (xmlhttp.readyState==4 && xmlhttp.status==200)
	     {
	    	var t_video=decodeURIComponent(xmlhttp.responseText);
	    	v_src=t_video.replace(/<\/?[^>]*>/g,'');
	    	v_src=t_video.replace(/[\r\n]/g,"");

//	    	console.debug(aid+"  "+v_src+"  "+pauto+"  "+i_logo);
	    	if(v_src=="noright")
	    	{	
	    	$("#livearea").html("<img src='"+vserverpath+"/common/player/noprv.png'>");
	    	return;
	    	}
			var scriptList = document.scripts,	thisPath = scriptList[scriptList.length - 1].src;
			javascriptPath = thisPath.substring(0, thisPath.lastIndexOf('/') + 1);
			
			for (var i = 0; i < scriptList.length; i++)
			{
			if(scriptList[i].src.indexOf("/ckplayer.js")>-1) 
			{thisPath = scriptList[i].src;
				javascriptPath = thisPath.substring(0, thisPath.lastIndexOf('/') + 1);
			}
			}	    	
	    	
	    	if(terminal =="P") livePlay(v_src);
	    	else livePlay(v_src);
	      }
	    };
	    xmlhttp.open("get",vserverpath +"/livecast/channel/geturl.jsp?v_code="+video_code+"&location="+l_location,false);
	    xmlhttp.send();
    	} catch (error){
    		;//console.debug(error.message);
	      }

    }
    function livePlay(v_src)
    {
    	//v_src= "http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8";
		var videoObject = {
				container: '#livearea',
				variable: 'player',
				autoplay:true,
				live:true,
				video:v_src
			};
		player=new ckplayer(videoObject);	    
        if(sheight=='0') sheight = "400";
        if(swidth =='0') swidth ="600";
	    pause_time= new Date();             
    }

    function getLoginAddress(){
    	try{
   		$.getScript('https://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js',function(_result)
   		{
   			if(remote_ip_info.ret=='1')
   			{
   				l_location=encodeURIComponent(encodeURIComponent(remote_ip_info.country+"%"+remote_ip_info.province+"%"+remote_ip_info.city));
   				//console.info(remote_ip_info.country+"%"+remote_ip_info.province+"%"+remote_ip_info.city);
   			}
   		});
    }catch(e){;}
   }
    
    function savePlaytime(ltime)
    {
    	var pause_now = new Date();
    	var ptime = Math.round((pause_now.getTime() - pause_time.getTime())/1000);

    	if(ptime<2) {return;}
    	var xmlhttp = new XMLHttpRequest();
//	    console.debug(aid+" paused save time:"+pause_now+"   "+pause_time);
	    //xmlhttp.open("post",vserverpath +"/ondemand/ckplayer/saveurl.jsp?aid="+aid+"&ltime="+ltime+"&ptime="+ptime+"&location="+l_location,true);
	    //xmlhttp.send();
    }
    
    //监听播放器事件
    function ckplayer_status(str){
        //监听文字广告关闭事件，保持非关闭状态
    	//console.log(str+ " :  "+time);	
        if(str=="marqueeClose"){
        	 player.marqueeLoad(true);
        }
		if(str=="pause"){ //ended
			p_status="STOP";
			savePlaytime(time);
		}
		if(str=="play"){
		  	if(p_status =="STOP")
		  	{
			pause_time = new Date();
			p_status="PLAY";
		  	}
		}		
		if(str=="ended"){ //ended
			p_status="STOP";
			//savePlaytime(time);
		}		
        //监听播放时间
        if(str.indexOf('time') >=0 ){
            //var strs=str.split(':');
           // time=parseInt(strs[1]);
		  	if(p_status =="STOP")
		  	{
			pause_time = new Date();
			p_status="PLAY";
		  	}
            checkPointTime(time);
        }
        var f = Math.abs(flag-time);
        if( f >=1 ){
            play = false;
            flag = 0;
        }

    }
    
    //检查播放时间是否到了视频点处
    function checkPointTime(t){
        $(point_list).each(function(){
            var point=$(this)[0];
            if(point.time_point == t && point.que_count > 0 && play==false){
                play = true;
                flag = t;
                player.videoPause();    //暂停播放
                //初始化试题界面
                initExam(point.id);
            }
        });
    }    

    //初始化试题界面
    function initExam(point_id){
        var height = $("#a1").height();
        var width = $("#a1").width();
        $("#exam").width(width).height(height+20);
        $("#exam").removeClass("hide");
        var idx = layer.load(300);
        var url = lpath + "/point/goVideoPointExamPreview.action";
        var data = {"videoPointQueMapping.point_id" : point_id, "videoPointQueMapping.curPage" : 1,"videoPointQueMapping.pageSize" : 999};
        $("#exam").load(url,data,function(res){
            layer.close(idx);
        });
    }

    //完成弹题测试，恢复视频播放
    function completeExam(){
        $("#exam").addClass("hide");
        $("#a1").fadeIn("slow");
        videoPlay();
    }

	function loadedHandler(){
		  // player.addListener('loadedmetadata', loadedMetaDataHandler);
	       //player.removeListener('duration', durationHandler); 		       
	       player.addListener('time', timeHandler);
	       player.addListener('pause', pauseHandler);
	       player.addListener('ended', endedHandler);
	       //player.addListener('seekTime', seekTimeHandler);
	 }
	function rmTimeHander(){
	    player.removeListener('time',timeHandler);
		player.removeListener('pause', pauseHandler);
		player.removeListener('ended', endedHandler);
		//player.removeListener('seekTime', seekTimeHandler);
		//player.removeListener('seek', seekHandler);
	    // $("#a1").html("");
	}

    function seekTimeHandler(ttx){
    	if(ttx > time){
       // 	console.log(time+"   time-2   "+ttx);    		
        	rmTimeHander();
    		player.videoSeek(10);
    		loadedHandler();    		
 	    //   player.addListener('seekTime', seekTimeHandler);    		
    	}
    }
    
    function seekHandler(ttx){
    	if(time<1) return;
    	//if(ttx > time){
        	//console.log(time+"   time-1  "+ttx);    		
// player.removeListener('seek', seekHandler);
        	rmTimeHander();  		
 	 player.videoSeek(1);
 	loadedHandler();
   	 //player.addListener('seek', seekHandler);  		
    	//}
    }   	
	function timeHandler(t){
		    if(t>0){
		    	var from='';
		            if(from.equals("NL")){
		            player._K_('nowTime').innerHTML='已经预览：'+ parseInt(t)+" 秒 可预览："+(parseInt(tt) * 60)+"秒，之后将停止播放。";
		            if(t >= parseInt(tt) * 60){
		                //$("#dModal").modal('hide');
		                player.videoPause();
		                layer.confirm("预览已结束，断续观看需要参加此课程！",{icon:3,title:"温馨提示"},function (index) {
							layer.close(index);
                            window.location.href = window.location.href;
                        },function (idx) {
		                	layer.close(idx)
                            rmTimeHander();
                            $('#dModal').modal('hide');
                            layer.msg('正在关闭预览...', {icon:7});
                        });
		            }
		    	time=Math.floor(t); 
		    	if( Math.abs(flag-time) >=1 ){
		    		play = false;
		    		flag = 0;
		    	}
		     checkPointTime(time);      
		     }
	}	     
	}    	
	    	
	function playingHandler() {
		ckplayer_status("play");
	}		    	
    function pauseHandler() {
    	ckplayer_status("pause");
    }		    
    function timeHandler(t){
        if(t>0){
        	time=ltime=Math.floor(t);
        	ckplayer_status("time");
        }
    }
 
    
  //暂停视频播放,返回正在播放的时间点
    function videoPause(){
		ckplayer_status("pause");
        return time;
    }
    //暂停视频播放,返回正在播放的时间点
    function endedHandler(){
    	ckplayer_status("ended");
    }    

    //继续播放视频
    function videoPlay(){
    	player.videoPlay();
    }

    //获取视频分钟数
    function getVideoMinute(){
        return v_minute;
    }

    //获取视频秒数
    function getVideoSecond(){
        return v_second;
    }

    //获取视频总时长
    function getVideoTime(){
        return v_minute * 60 + v_second;
    }

    //跳转视频播放位置
    function videoSeek(p_time){
        player.videoSeek(p_time);
    }
