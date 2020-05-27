<%@page import="model.BbsDTO"%>
<%@page import="model.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/isLogin.jsp"%>
<!-- 해당 파일내에서 bname에 대한 폼값을 받고 있음 -->
<%@ include file="../common/isFlag.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");

	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String content = request.getParameter("content");

	BbsDTO dto = new BbsDTO();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);

	BbsDAO dao = new BbsDAO(application);

	int affected = dao.updateEdit(dto);
	System.out.println(affected);
	if (affected == 1) {
		// 정상적으로 수정되었다면 수정된 내용의 확인을 위해 상세보기로 이동
		response.sendRedirect("BoardView.jsp?bname=" + bname + "&num=" + dto.getNum());
	} else {
%>
<script type="text/javascript">
	alert("수정하기에 실패하였습니다.");
	history.go(-1);
</script>
<%
	}
%>