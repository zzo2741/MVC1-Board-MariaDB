<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 파일명 : isLogin.jsp -->
<%
	if (session.getAttribute("USER_ID") == null) {
%>
<script type="text/javascript">
	alert("로그인안해?")
	location.href = "../06Session/Login.jsp";
</script>
<%
	return;
	}
%>
