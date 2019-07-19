var pRate = function(box,callBack){
	this.Index = null;
	var B = $("#"+box),
		rate = B.children("i"),
		w = rate.width(),
		n = rate.length,
		me = this;
	for(var i=0;i<n;i++){
		rate.eq(i).css({
			'width':w*(i+1),
			'z-index':n-i
		});
	}	
	rate.hover(function(){
		var S = B.children("i.select");
		$(this).addClass("hover").siblings().removeClass("hover");
		if($(this).index()>S.index()){
			S.addClass("hover");
		}
	},function(){
		rate.removeClass("hover");
	})
	rate.click(function(){
		rate.removeClass("select hover");
		$(this).addClass("select");
		me.Index = $(this).index() + 1;
		if(callBack){callBack();}
	})
}
/*

<span class="p_rate" id="p_rate">
	<i title="1分"></i> 
 	<i title="2分"></i> 
 	<i title="3分"></i> 
 	<i title="4分"></i> 
 	<i title="5分"></i> 
</span>
<script> 
	var Rate = new pRate("p_rate",function(){
		alert(Rate.Index+'分')
	});
</script>

*/