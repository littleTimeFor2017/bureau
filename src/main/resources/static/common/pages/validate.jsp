<%@page import="freemarker.template.utility.StringUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         import="cn.kindee.moudle.ucenter.authentication.utils.ValidateUtil,
         		cn.kindee.common.core.utils.StringUtilsExt,
         		cn.kindee.common.core.utils.EncryptUtils,
         		cn.kindee.common.core.support.Constants"
         pageEncoding="UTF-8" %>
<%@ page import="oracle.ila.common.util.servlet.UserToken" %>
<%
    String path = request.getContextPath();
    String user_id = StringUtilsExt.isNullToEmpty(request.getParameter("user_id"));
    String mod = StringUtilsExt.isNullToEmpty(request.getParameter("mod"));
    String object_id = StringUtilsExt.isNullToEmpty(request.getParameter("object_id"));
    String object_type = StringUtilsExt.isNullToEmpty(request.getParameter("object_type"));
    String cw_id = StringUtilsExt.isNullToEmpty(request.getParameter("cw_id"));
    String target_id = StringUtilsExt.isNullToEmpty(request.getParameter("target_id"));
    String access_way = StringUtilsExt.isNullToEmpty(request.getParameter("access_way"));//访问方式：ios/app
    String lh_id = StringUtilsExt.isNullToEmpty(request.getParameter("lh_id"));
    String c_id = StringUtilsExt.isNullToEmpty(request.getParameter("c_id"));
    String l_id = StringUtilsExt.isNullToEmpty(request.getParameter("l_id"));
    String from = StringUtilsExt.isNullToEmpty(request.getParameter("from"));
    String type = StringUtilsExt.isNullToEmpty(request.getParameter("type"));
    ValidateUtil vu = new ValidateUtil();
//boolean flag = vu.memcachedValidte(request, emp_id);
    boolean flag = vu.emp_validate(request, user_id);
    if (flag) {
        if ("CTOPIC".equals(mod)) {
            response.sendRedirect(path + "/portal/index.action?mod=");
        } else if ("GROUP".equals(mod)) {//圈子
            response.sendRedirect(path + "/group/getGroupHome.action?group.id=" + object_id + "&access_way=" + access_way);
        } else if ("TOPIC".equals(mod)) {//话题详情
            response.sendRedirect(path + "/topic/getTopicByGroup.action?group.id=" + object_id + "&topic.id=" + target_id + "&access_way=" + access_way);
        } else if (StringUtilsExt.isEquals("KBMS", mod)) {//知识库
            response.sendRedirect(path + "/directory/getAllShareDir.action");
        } else if (StringUtilsExt.isEquals("viewdoc", mod)) {//知识库-预览文档
            response.sendRedirect(path + "/document/viewDoc.action?from=mobile&document.en_id=" + object_id);
        } else if (StringUtilsExt.isEquals("viewcoursedoc", mod)) {//课程-预览文档
            response.sendRedirect(path + "/document/viewDoc.action?from=mobile&document.sourcefrom=COURSE&document.en_id=" + EncryptUtils.encrpt3DESStringKey(Constants.KBMS_DES_KEY, object_id));
        } else if ("onlineExam".equals(mod)) {//在线考试
            if ("HOUR".equals(object_type)) {
                response.sendRedirect(path + "/exam/goExamHome.action?exam.id=" + cw_id
                        + "&mobile_object_id=" + object_id
                        + "&mobile_c_id=" + c_id
                        + "&mobile_lh_id=" + lh_id
                );
            } else {
                response.sendRedirect(path + "/exam/goExamHome.action?exam.id=" + object_id);
            }

        } else if ("reviewExam".equals(mod)) {//回顾考试
            response.sendRedirect(path + "/exam/reviewExamByAtmp.action?atmp.id=" + object_id);
        } else if ("myques".equals(mod)) {//我的问卷
            response.sendRedirect(path + "/portal/userhomemb.action?from=myques");
        } else if ("mytopics".equals(mod)) {//我的话题
            response.sendRedirect(path + "/portal/userhomemb.action?from=mytopics&access_way=" + access_way);
        } else if ("myqa".equals(mod)) {//我的问答
            response.sendRedirect(path + "/portal/userhomemb.action?from=myqa&access_way=" + access_way);
        } else if ("myhomeworks".equals(mod)) {//我的作业
            response.sendRedirect(path + "/portal/userhomemb.action?from=myhomeworks");
        } else if ("myexams".equals(mod)) {//我的考试
            response.sendRedirect(path + "/portal/userhomemb.action?from=myexams");
        } else if ("mygroups".equals(mod)) {//我的圈子
            response.sendRedirect(path + "/portal/userhomemb.action?from=mygroups&access_way=" + access_way);
        } else if ("mynotes".equals(mod)) {//我的笔记
            response.sendRedirect(path + "/portal/userhomemb.action?from=mynotes");
        } else if ("reg".equals(mod)) {//报名
            response.sendRedirect(path + "/register/getIndexRegisterDetailsToReg.action?register.access_way=" + access_way + "&register.id=" + object_id);
        } else if ("signin".equals(mod)) {//报名签到
            response.sendRedirect(path + "/register/getIndexRegisterSignIn.action?register.id=" + object_id);
        } else if ("signout".equals(mod)) {//报名签退
            response.sendRedirect(path + "/register/getIndexRegisterSignOut.action?register.id=" + object_id);
        } else if ("dyndtls".equals(mod)) {//动态详细
            response.sendRedirect(path + "/dynamic/getIndexDynamicDetails.action?dynamic.id=" + object_id + "&access_way=" + access_way);
        } else if ("regmanage".equals(mod)) {//报名活动管理
            response.sendRedirect(path + "/register/front/temp_register_manage.jsp");
        } else if ("massage".equals(mod)) {//按摩
            response.sendRedirect(path + "/register/getMassageDetails.action");
        } else if ("massagesignin".equals(mod)) {//按摩签到
            response.sendRedirect(path + "/register/front/massage_sign_in.jsp");
        } else if ("scorm".equals(mod)) { // scorm 课件学习
            if ("old".equals(from)) {
                response.sendRedirect(path + "/player/pages/forward_app.jsp?object_id=" + object_id + "&c_id=" + c_id + "&lh_id=" + lh_id);
            } else {
                response.sendRedirect(path + "/player/pages/forward_app.jsp?object_id=" + object_id + "&c_id=" + c_id + "&lh_id=" + lh_id + "&l_id=" + l_id + "&from=" + from);
            }
        } else if ("picTxt".equals(mod)) {//图文课时
            response.sendRedirect(path + "/admin/course/lhour/prv_doc.jsp?doc_id=" + object_id + "&c_id=" + c_id + "&lh_id=" + lh_id);
        }
    } else {
        if ("reg".equals(mod)) {//报名
            response.sendRedirect(path + "/register/getIndexRegisterDetailsToReg.action?register.access_way=" + access_way + "&register.id=" + object_id);
        } else if ("signin".equals(mod)) {//报名签到
            response.sendRedirect(path + "/register/getIndexRegisterSignIn.action?register.id=" + object_id);
        } else if ("signout".equals(mod)) {//报名签退
            response.sendRedirect(path + "/register/getIndexRegisterSignOut.action?register.id=" + object_id);
        } else if ("wx_exam".equals(mod)) {//报名签退
            response.sendRedirect(path + "/register/getIndexRegisterSignOut.action?register.id=" + object_id);
        } else if ("courseFromClassshare".equals(mod)) {
            cn.kindee.common.core.support.UserToken utoken = (cn.kindee.common.core.support.UserToken)session.getAttribute(Constants.USERTOKEN);
            String pinfo_key = Constants.PLAYER_INFO + utoken.getUser_id() + "_" + type.split("_")[2];
            request.getSession().setAttribute(pinfo_key, type.split("_")[2] + "#" + type.split("_")[3]);
            String target = path + "/course/goCourseStudyInfoH5.action?from=class&object_id=" + type.split("_")[2]
                    + "&c_id=" + type.split("_")[3]
                    + "&l_id=" + type.split("_")[4]
                    + "&lh_id=" + type.split("_")[5];
            response.sendRedirect(target);
        } else if ("courseshare".equals(mod)) {
            cn.kindee.common.core.support.UserToken utoken = (cn.kindee.common.core.support.UserToken) request.getSession().getAttribute(Constants.USERTOKEN);
            String pinfo_key = Constants.PLAYER_INFO + utoken.getUser_id() + "_" + type.split("_")[1];
            request.getSession().setAttribute(pinfo_key, type.split("_")[1] + "#" + type.split("_")[2]);
            String target = path + "/course/goCourseStudyInfoH5.action?object_id=" + type.split("_")[1]
                    + "&c_id=" + type.split("_")[2];
            response.sendRedirect(target);
        } else if("courseNoreg".equals(mod)){
            String  target ="course/goCourseIntroH5.action?object_id="+type.split("_")[2]+"&c_id="+type.split("_")[3]+"register_id="+type.split("_")[4];
            response.sendRedirect(target);
        } else if("messageExam".equals(mod)){
            String  target ="exam/goExamHome.action?exam.id="+type.split("_")[1];
            response.sendRedirect(target);
        } else if("messageActivity".equals(mod)){
            String  target ="register/activityDetails.action?register.id="+type.split("_")[1];
            response.sendRedirect(target);
        } else if("mesageAss".equals(mod)){
            String  target ="survey/goSurveyHome.action?survey.id=="+type.split("_")[1];
            response.sendRedirect(target);
        }else {
            out.println("用户验证失败！");
        }
    }
%>
