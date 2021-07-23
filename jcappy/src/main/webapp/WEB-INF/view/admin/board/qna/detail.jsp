<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/WEB-INF/view/admin/include/headHtml.jsp" %>
</head>
<body> 
<div id="wrap">
	<!-- canvas -->
	<div id="canvas">
		<!-- S T A R T :: headerArea-->
		<%@ include file="/WEB-INF/view/admin/include/top.jsp" %>
		<!-- E N D :: headerArea--> 
		
		<!-- S T A R T :: containerArea-->
		<div id="container">
			<div id="content">
				<div class="con_tit">
					<h2>문의게시판 - [읽기]</h2>
				</div>
				<!-- //con_tit -->
				<div class="con">
					<!-- 내용 : s -->
					<div id="bbs">
						<div id="bread">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" summary="관리자 관리 기본내용입니다.">
								<colgroup>
									<col width="10%" />
									<col width="15%" />
									<col width="10%" />
									<col width="15%" />
									<col width="25%" />
									<col width="25%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><label for="">번호</label></th>
										<td colspan="10">
											${vo.qno}
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="">제목</label></th>
										<td colspan="10">
											${vo.qtitle}
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="">작성날짜</label></th>
										<td colspan="10">
											${vo.qregdate}
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="">회원이름</label></th>
										<td colspan="10">
											${vo.mname}
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="">회원연락처</label></th>
										<td colspan="10">
											${vo.mphone }
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="">회원이메일</label></th>
										<td colspan="10">
											${vo.memail }
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="">내용</label></th>
										<td colspan="10">
											${vo.qcontent}
										</td>
									</tr>
									
								</tbody>
							</table>
							<div class="btn">
								<div class="btnLeft">
									<a class="btns" href="list?<c:if test="${!empty param.reqPage}">reqPage=${param.reqPage}</c:if>&stype=${param.stype}&sval=${param.sval}"><strong>목록</strong></a>
								</div>
								<div class="btnRight">
									<a class="btns" style="cursor:pointer;" href="reply?qno=${vo.qno}"><strong>답글</strong></a>
									<a class="btns" style="cursor:pointer;" href=""><strong>삭제</strong></a>
								</div>
							</div>
							<!--//btn-->
						</div>
						<!-- //bread -->
					</div>
					<!-- //bbs --> 
					<!-- 내용 : e -->
				</div>
				<!--//con -->
			</div>
			<!--//content -->
		</div>
		<!--//container --> 
		<!-- E N D :: containerArea-->
	</div>
	<!--//canvas -->
</div>
<!--//wrap -->

</body>
</html>