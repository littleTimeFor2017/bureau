var gbForm = {
	/**
	 * 判断字符串是否为空
	 */
    isNullOrEmpty:function(str){   
        if(typeof(str)=="undefined") return true;   
        if(str==null) return true;  
        if(str=="") return true;  
        return false;  
    },
    /**
     * 获得单选框的值
     */
    getRadioValue:function(radioName){  
        var radios = document.getElementsByName(radioName);  
        for(var i = 0 ; i< radios.length; i++){  
            var radio = radios.item(i);  
            if(radio.checked){  
                if(gbForm.isNullOrEmpty(radio.value)) return undefined;  
                return radio.value;  
            }  
        }  
        return undefined;  
    },
    /**
     * 设置单选框的值
     */
    setRadioValue:function(radioName,val){  
        var radios = document.getElementsByName(radioName);  
        for(var i = 0 ; i< radios.length; i++){  
            var radio = radios.item(i);  
           	if(radio.value == val){
           		radio.checked = true;
           	}
        }  
    },
    /**
     * 设置单选框的值
     */
    setRadioValueTF:function(radioName,val){  
        var radios = document.getElementsByName(radioName);  
        for(var i = 0 ; i< radios.length; i++){  
            var radio = radios.item(i);  
           	if(radio.value == val){
           		radio.focus();
           		if(radio.checked){
           			radio.checked = false;
           		}else{
           			radio.checked = true;
           		}
           	}
        }  
    },
    /**
     * 获得复选框的值
     */
    getCheckboxValue:function(checkboxName)  {
        var checkboxs = document.getElementsByName(checkboxName);
        var ck = new Array();
        var j  =  0;
        for(var i = 0 ; i< checkboxs.length; i++){
            var checkbox = checkboxs[i];
            if(checkbox.checked){
                if(gbForm.isNullOrEmpty(checkbox.value)) return undefined;
                ck[j] = checkbox.value;
                j++;
            }
        }
        return j == 0 ? undefined : ck.join();
    },
    getCheckboxValueNoDisabled:function(checkboxName)  {
        var checkboxs = document.getElementsByName(checkboxName);  
        var ck = new Array();  
        var j  =  0;  
        for(var i = 0 ; i< checkboxs.length; i++){  
            var checkbox = checkboxs[i];  
            if(checkbox.checked && !checkbox.disabled){  
                if(gbForm.isNullOrEmpty(checkbox.value)) return undefined;  
                ck[j] = checkbox.value;  
                j++;  
            }  
        }  
        return j == 0 ? undefined : ck.join();  
    },
    /**
     * 设置复选框的值选中
     */
    setCheckboxValue:function(checkboxName, val)  {  
        var checkboxs = document.getElementsByName(checkboxName);  
        for(var i = 0 ; i< checkboxs.length; i++){  
            var checkbox = checkboxs[i];  
            if(checkbox.value == val){  
            	checkbox.checked = true;  
            }  
        }  
    },
    /**
     * 判断一个复选框是否选中
     */
    getCheckboxValueTF:function(checkboxName)  {
    	var flag = false;
        var checkboxs = document.getElementsByName(checkboxName);
        if(checkboxs){
        	if(checkboxs[0].checked){flag = true;}
        }
        return flag;
    },
    /**
     * 获得单选下拉列表的值
     */
    getSelectValue:function(selectId){  
        var select = document.getElementById(selectId);  
        var options = select.options;  
        for(var i = 0 ; i<options.length ;i++){  
            var option = options[i];  
            if(option.selected){  
                if(gbForm.isNullOrEmpty(option.value)) return undefined;  
                return option.value;  
            }  
        }  
        return undefined;  
    },
    /**
     * 获得多选下拉列表值
     */
    getMuSelectValue:function(objname){  
        var obj = document.getElementById(objname);
        var val="";
        for(var i=0;i<obj.length;i++){
            if(obj.options[i].selected){
            	if(val == ""){
            		val = obj.options[i].value;
            	}else{
            		val += "," + obj.options[i].value;
            	}
            }
        }
        return val;
    }
}
function setCheckboxCkd(objName, vals){
	if(vals != null && vals != ""){
		var tmarry = vals.split(",");
		if(tmarry != null && tmarry.length > 0){
			for(var i=0;i<tmarry.length;i++){
				gbForm.setCheckboxValue(objName,tmarry[i]);
			}
		}
	}
}