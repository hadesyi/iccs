<%@ page contentType="text/html;charset=utf-8"%>
<a name="leftmenu"></a>
<h2 id="left_title"><img src="../03_community/images/left_menu_title.gif" alt="커뮤니티" border="0"></h2>
<div id="left_menu">
<% 
	if (ruleChk){ 
		out.print("<script>flash('../flash/left_navi_03_pub.swf?pageNum="+left_pageNum+"&sub="+left_sub+"','154','260');</script>");
	} else { 
		out.print("<script>flash('../flash/left_navi_03.swf?pageNum="+left_pageNum+"&sub="+left_sub+"','154','260');</script>");
	}
%>
</div>
<div id="left_bottom">
<img src="../images/left_menu/left_menu_bottom.gif" border="0">
</div>
<div id="left_banner">
	<%@ include file="../inc/left_banner.jsp" %>
</div>

