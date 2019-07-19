/*
 * trim() , ltrim() , rtrim() , trimAll()
 * @author Chan Lewis
 * @version 2013-09-23
 * @throws Error
 * @see MicrosoftAjax.debug.js
 */

/**
 * 去除两头空格:(TimeSheet用过 arg0=arg0.replace(/\s+$|^\s+/g,"") /^\s+|\s+$/g 或
 * /\s+$|^\s+/g 或 /(^\s*)|(\s*$)/g
 * 
 * @returns
 */
String.prototype.trim = function() {
	if (arguments.length !== 0)
		throw Error.parameterCount();
	return this.replace(/^\s+|\s+$/g, "");
}
/**
 * 去除左空格: /(^\s*)/g 或
 * 
 * @returns
 */
String.prototype.ltrim = function() {
	if (arguments.length !== 0)
		throw Error.parameterCount();
	return this.replace(/^\s*/, "");
}
/**
 * 去除右空格: /(\s*$)/g
 * 
 * @returns
 */
String.prototype.rtrim = function() {
	if (arguments.length !== 0)
		throw Error.parameterCount();
	return this.replace(/(\s*$)/g, "");
}
/**
 * 去除所有空格: /\s+/g
 * 
 * @returns
 */
String.prototype.trimAll = function() {
	if (arguments.length !== 0)
		throw Error.parameterCount();
	return this.replace(/\s+/g, "");
}

/**
 * 返回val的字节长度
 * 
 * @param val
 * @param size
 */
function getByteLen(val, size) {
	var len = 0;
	var zhSize = new Number(size);
	for ( var i = 0; i < val.length; i++) {
		var c = val.charAt(i);
		if (c.match(/[^\x00-\xff]/ig) != null) {
			len += zhSize;
		} else {
			len += 1;
		}
	}
	return len;
}
/**
function getByteLen(str,size) {
	var bytesCount = 0;
	var zhSize = new Number(size);
	if (str != null) {
		for ( var i = 0; i < str.length; i++) {
			var c = str.charAt(i);
			if (/^[\u0000-\u00ff]$/.test(c)) {
				bytesCount += 1;
			} else {
				bytesCount += zhSize;
			}
		}
	}
	return bytesCount;
}
 */
/**
 * 返回val在规定字节长度max内的值
 */
function getByteVal(val, max, size) {
	var returnValue = '';
	var byteValLen = 0;
	var zhSize = new Number(size);
	for ( var i = 0; i < val.length; i++) {
		var c = val.charAt(i);
		if (c.match(/[^\x00-\xff]/ig) != null)
			byteValLen += zhSize;
		else
			byteValLen += 1;
		if (byteValLen > max)
			break;
		returnValue += c;
	}
	return returnValue;
}

// 对Date的扩展，将 Date 转化为指定格式的String 
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function(fmt) 
{ //author: yangran 
  var o = { 
    "M+" : this.getMonth()+1,                 //月份 
    "d+" : this.getDate(),                    //日 
    "h+" : this.getHours(),                   //小时 
    "m+" : this.getMinutes(),                 //分 
    "s+" : this.getSeconds(),                 //秒 
    "q+" : Math.floor((this.getMonth()+3)/3), //季度 
    "S"  : this.getMilliseconds()             //毫秒 
  }; 
  if(/(y+)/.test(fmt)) 
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
  for(var k in o) 
    if(new RegExp("("+ k +")").test(fmt)) 
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
  return fmt; 
}

/**
*验证字符串是否是日期格式
*/
function isDate (value) {
	var dateRegEx = new RegExp(/^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(?:(?:0?[1-9]|1[0-2])(\/|-)(?:0?[1-9]|1\d|2[0-8]))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(0?2(\/|-)29)(\/|-)(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\d\d)?(?:0[48]|[2468][048]|[13579][26]))$/);
	return dateRegEx.test(value);
}
