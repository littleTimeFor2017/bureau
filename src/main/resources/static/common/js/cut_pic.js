var pic_path = ""; 		//已上传图片或默认图片路径
var pic_url = ""; 		//AJAX提交页面
var access_path = ""; 	//图片访问路径
var pic = ""; 			//已上传图片文件
var pic_default = ""; 	//默认图片路径
var dfw = 480; 	//图片保存的宽度
var dfh = 270; 	//图片保存的高度
var imgh = 270;	//页面图片高度 默认为 270;
var sw = 400;	//选择框的初始宽度
var sh = 225;	//选择框的初始高度
var minw = 320;	//选择框的最小宽度
var minh = 180;	//选择框的最小高度
var ar = '5:3';	//选择框的比例
var upload_path = "";
var isArea = true;
//上传图片
function uploadImage() {
    var idx = layer.load(300);
    $.ajaxFileUpload( { url : pic_url,fileElementId : 'fileToUpload',dataType : 'json', data : {"operation":1}, async: false,
        success : function(data) {
            layer.close(idx);
            $("#pic_file").hide();
            if (data['result'] == 1) {
                imgareaselect(data);
            }else{
                var errMsg = "错误！";
                if(data['result'] == 3){
                    errMsg = "图片大小超过设定最大值 "+ data["maxsize"] +" KB，请重新选择图片！";
                }else if(data['result'] == 4){
                    errMsg = "图片类型不符合，应该为 "+ data["fileType"] +"，请重新选择图片！";
                }else if(data['result'] == 2){
                    errMsg = "用户登录超时，请重新登录后再执行此操作！";
                }else{
                    errMsg = "图片预览错误，请重新选择图片！";
                }
                try{
                    layer.msg(errMsg,{icon:2})
                }catch(e){
                    layer.alert(errMsg,{icon: 5});
                }
            }
        }, error : function(data) {layer.close(idx);}
    });
}
/*图片裁剪，图片压缩*/
function cutImage() {

    var idx = layer.load(300);

    var x1 = $('input[name="x1"]').val();
    var x2 = $('input[name="x2"]').val();
    var y1 = $('input[name="y1"]').val();
    var y2 = $('input[name="y2"]').val();
    var width = $('input[name="width"]').val();
    var height = $('input[name="height"]').val();
    //alert(upload_path);
    if(upload_path != null && upload_path != ""){
        $.ajax( { type: "POST", url: pic_url, dateType: "json", async: true, cache: false,
            data:{"operation":2,"x1":x1,"x2":x2, "y1":y1,"y2":y2,
                "path":pic_path, "new_width":dfw, "new_height": dfh,"width":width,"height":height},
            success : function(data) {
                layer.close(idx);
                upload_path = "";
                var obj = eval( "(" + data + ")" );
                if(obj.result == 1){

                    //设置上传的图片显示
                    clearnImgAreaSelect();
                    $("#source_img").attr("src",access_path+obj.pic);
                    //自定义保存信息的方法
                    savePic(obj.pic);
                }else{
                    try{
                        layer.msg('图片保存错误，请重新保存！',{icon:2});
                    }catch(e){
                        layer.alert("图片保存错误，请重新保存！",{icon: 5});
                    }
                }
            },
            error:function(data) { layer.close(idx);}
        });
    }else{
        try {
            layer.msg("没有上传新的图片，请选择图片后再执行此操作！",{icon: 2});
        }catch (e){
            layer.alert("没有上传新的图片，请选择图片后再执行此操作！",{icon: 5});
        }
        layer.close(idx);
    }
}
/**
 * 选择图片区域
 * 参数说明：data上传图片返回的图片信息
 */
function imgareaselect(data){
    $("#reUploadBtn").show();
    var bl = data['height'] / imgh;

    $("#preview_main").css({"display":"block"});
    $("#source_img").attr("src",access_path + data['path']);
    $('input[name="x2"]').val(Math.round(sw * bl));
    $('input[name="y2"]').val(Math.round(sh * bl));
    //alert(data['width'] + " / " + data['height']/270);
    pic_path = access_path + data['path'];
    pic = data['path'];
    upload_path = data['path'];
    $('#source_img').imgAreaSelect({
        instance: true, handles: true, aspectRatio: ar,
        minWidth: minw, minHeight:minh,
        onSelectEnd: function (img, selection) {
            $('input[name="x1"]').val(Math.round(selection.x1 * bl));
            $('input[name="y1"]').val(Math.round(selection.y1 * bl));
            $('input[name="x2"]').val(Math.round(selection.x2 * bl));
            $('input[name="y2"]').val(Math.round(selection.y2 * bl));
            $('input[name="width"]').val(Math.round(selection.width * bl));
            $('input[name="height"]').val(Math.round(selection.height * bl));

        }
    });
}
function clearnImgAreaSelect(){
    if($('#source_img').data('imgAreaSelect')){
        $('#source_img').data('imgAreaSelect').remove();
        $('#source_img').removeData('imgAreaSelect');
    }

    $('input[name="x1"]').val(0);
    $('input[name="y1"]').val(0);
    $('input[name="x2"]').val(0);
    $('input[name="y2"]').val(0);
    $('input[name="width"]').val(0);
    $('input[name="height"]').val(0);
}