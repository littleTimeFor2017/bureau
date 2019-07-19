//by:xcl @2012.8  qq:80213876
;(function ($) { 
    $.extend({
        XCLTableList:function(options){
            options = $.extend({},funs.Defaults, options);
            funs.Init(options);
            $(options.tableClass).each(function(){
                $trs=null;
                if($(this).children("tbody").length>0){//浏览器会自动加tbody标签
                    $trs=options.trNoHoverClass==""?$(this).children().children():$(this).children().children().not(options.trNoHoverClass);
                }else{
                    $trs=options.trNoHoverClass==""?$(this).children():$(this).children().not(options.trNoHoverClass);
                }
                //滑过行颜色
                if(options.trHoverColor!=""){
                    $trs.hover(function(){
                        $(this).addClass("XCLTableList_trHover");
                    },function(){
                        $(this).removeClass("XCLTableList_trHover");
                    });
                }
                //单击行颜色
                if(options.trClickColor!=""){
                    $trs.click(function(){
                        $trs.removeClass("XCLTableList_trClick");
                        $(this).addClass("XCLTableList_trClick");
                    });
                }
                //奇偶行颜色
                if(options.trEvenColor!=""){
                    $trs.each(function(i){
                        if(i%2==0){
                            $(this).addClass("XCLTableList_trEven");
                        }
                    });
                }
                if(options.trOddColor!=""){
                   $trs.each(function(i){
                        if(i%2==1){
                            $(this).addClass("XCLTableList_trOdd");
                        }
                    });
                }
                /******表格样式相关结束****/


                /******全选相关开始*****/
                //单击全选时
                $(options.checkAllClass).click(function(){
                    $ckAll=$(this).closest(options.tableClass).find(options.checkAllClass);
                    $ckItem=$(this).closest(options.tableClass).find(options.checkItemClass);
                    
                    if(this.checked){
                    	$ckItem.each(function(){
                    		this.checked = true;
                        });
                        $ckItem.attr({"checked":true});
                    }else{
                    	$ckItem.each(function(){
                    		this.checked = false;
                        });
                        $ckItem.attr({"checked":false});
                    }
                    funs.GetCheckBoxIDs($ckAll,$ckItem);
                    setCheckboxValues('check');
                });
                //单击列表中的checkbox时
                $(options.checkItemClass).click(function(){
                    $ckAll=$(this).closest(options.tableClass).find(options.checkAllClass);
                    $ckItem=$(this).closest(options.tableClass).find(options.checkItemClass);
                    var flag=1;
                    $ckItem.each(function(){
                        if(!this.checked){
                            flag=0;
                            return false;
                        }
                    });
                    if(flag==1){
                        $ckAll.attr({"checked":true});
                    }else{
                        $ckAll.attr({"checked":false});
                    }
                    funs.GetCheckBoxIDs($ckAll,$ckItem);
                    setCheckboxValues('check');
                });
                /******全选相关结束*****/
            });
        }
    });
    var funs={
        Defaults:{
            tableClass:".tab",//table的class
            trHoverColor:"#eee",//行滑过时的颜色
            trClickColor:"",//单击行后的颜色
            trNoHoverClass:".noHover",//无需设置颜色的行class
            trEvenColor:"#FFF",//偶数行的颜色0开始
            trOddColor:"#F7F7F7",//奇数行的颜色
            checkAllClass:".checkAll",//全选按钮class
            checkItemClass:".checkItem",//选择框的class
            checkedTrColor:"#FFFEC9"//选中行的颜色
        },
        Init:function(options){
            //样式
            $("head").append("<style type='text/css'>.XCLTableList_trHover{background:"+options.trHoverColor+"!important;} "+
                                    ".XCLTableList_trClick{background:"+options.trClickColor+"!important;} "+
                                    ".XCLTableList_trEven{background:"+options.trEvenColor+";} "+
                                    ".XCLTableList_trOdd{background:"+options.trOddColor+";}"+
                                    ".XCLTableList_trChecked{background:"+options.checkedTrColor+"!important;}"+
                                    "</style>");
            //当子项都为选中时，此时选中全选项
            $(options.tableClass).each(function(){
                    $ckAll=$(this).closest(options.tableClass).find(options.checkAllClass);
                    $ckItem=$(this).closest(options.tableClass).find(options.checkItemClass);
                    var isAllChecked=1;
                    $ckItem.each(function(){
                        if(!this.checked){
                            isAllChecked=0;return false;
                        }
                    });
                    if(isAllChecked==1){
                        $ckAll.attr({"checked":true});
                    }
            });
        },
        //将列表中的checkbox的value的数组形式存到全选的checkbox的value中
        GetCheckBoxIDs:function(ckAll,ckItem){
            var v=[];
            ckItem.each(function(){
            	if(this.className == "checkItem"){
	                if(this.checked){
	                    $(this).closest("tr").addClass("XCLTableList_trChecked");
	                    v.push(this.value);
	                }else{
	                    $(this).closest("tr").removeClass("XCLTableList_trChecked");
	                }
            	}
            });
            ckAll.val(v.toString());
        }
    }
})(jQuery);