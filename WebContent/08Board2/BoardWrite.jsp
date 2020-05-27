<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 글작성 페이지 진입전 로그인 메세지 --%>
<%@ include file="../common/isLogin.jsp"%>
<%@ include file="../common/isFlag.jsp"%>
<%
//자유게시판, 질문과 답변만 글쓰기 가능함.
if (!(bname.equals("freeboard") || bname.equals("qna")))
{
	JavascriptUtil.jsAlertBack("해당 게시판은 글쓰기를 할 수 없습니다.", out);
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../common/boardHead.jsp" />
<body>
	<div class="container">
		<jsp:include page="../common/boardTop.jsp" />
		<div class="row">
			<jsp:include page="../common/boardLeft.jsp" />
			<div class="col-9 pt-3">
				<h3>
					<%=boardTitle %> - <small>Write(작성)</small>
				</h3>
				<script type="text/javascript">
					// 무기명함수
					var checkValidate2 = function(frm) {
						if (frm.title.value == "") {
							alert("제목을 입력하세요.");
							frm.title.focus();
							return false;
						}
						if (frm.content.value == "") {
							alert("내용을 입력하세요.");
							frm.content.focus();
							return false;
						}
					}
					// 유기명함수
					function checkValidate(frm) {
						if (frm.title.value == "") {
							alert("제목을 입력하세요.");
							frm.title.focus();
							return false;
						}
						if (frm.content.value == "") {
							alert("내용을 입력하세요.");
							frm.content.focus();
							return false;
						}
					}
				</script>
				<div class="row mt-3 mr-1">
					<table class="table table-bordered table-striped">
						<form action="WriteProc.jsp" name="writeFrm" method="post" onsubmit="return checkValidate2(this);">
							<!-- 글작성시 게시판 구분을 위한 flag 추가 -->
							<input type="hidden" name="bname" value="<%=bname%>" />
							<colgroup>
								<col width="20%" />
								<col width="*" />
							</colgroup>
							<tbody>
								<!-- <tr>
									<th class="text-center align-middle">작성자</th>
									<td>
										<input type="text" class="form-control" style="width: 100px;" />
									</td>
								</tr> -->
								<!-- <tr>
									<th class="text-center" style="vertical-align: middle;">패스워드</th>
									<td>
										<input type="password" class="form-control" style="width: 200px;" />
									</td>
								</tr> -->
								<tr>
									<th class="text-center" style="vertical-align: middle;">제목</th>
									<td>
										<input type="text" class="form-control" name="title" />
									</td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">내용</th>
									<td>
										<textarea rows="10" class="form-control" name="content"></textarea>
									</td>
								</tr>
								<!-- <tr>
									<th class="text-center" style="vertical-align: middle;">첨부파일</th>
									<td>
										<input type="file" class="form-control" />
									</td>
								</tr> -->
							</tbody>
					</table>
				</div>
				<div class="row mb-3">
					<div class="col text-right">

						<button type="submit" class="btn btn-danger">전송하기</button>
						<button type="button" class="btn btn-warning" onclick="location.href='BoardList.jsp?bname=<%=bname%>';">리스트보기</button>
					</div>
					</form>
				</div>
			</div>
		</div>
		<jsp:include page="../common/boardBottom.jsp" />
	</div>
</body>
</html>

<!-- 
	<i class='fas fa-edit' style='font-size:20px'></i>
	<i class='fa fa-cogs' style='font-size:20px'></i>
	<i class='fas fa-sign-in-alt' style='font-size:20px'></i>
	<i class='fas fa-sign-out-alt' style='font-size:20px'></i>
	<i class='far fa-edit' style='font-size:20px'></i>
	<i class='fas fa-id-card-alt' style='font-size:20px'></i>
	<i class='fas fa-id-card' style='font-size:20px'></i>
	<i class='fas fa-id-card' style='font-size:20px'></i>
	<i class='fas fa-pen' style='font-size:20px'></i>
	<i class='fas fa-pen-alt' style='font-size:20px'></i>
	<i class='fas fa-pen-fancy' style='font-size:20px'></i>
	<i class='fas fa-pen-nib' style='font-size:20px'></i>
	<i class='fas fa-pen-square' style='font-size:20px'></i>
	<i class='fas fa-pencil-alt' style='font-size:20px'></i>
	<i class='fas fa-pencil-ruler' style='font-size:20px'></i>
	<i class='fa fa-cog' style='font-size:20px'></i>
	아~~~~힘들다...ㅋ
 -->