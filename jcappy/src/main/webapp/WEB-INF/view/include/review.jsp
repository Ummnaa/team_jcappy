<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/jcappy/js/starrating.js"></script>
<link rel="stylesheet" type="text/css" href="/jcappy/css/starrating.css" />
<script>
	$(function() {
		$("#review_img_detail_area").dialog({
			width: 600,	
			maxHeight: 600,
			modal: true,	// 모달(뒷페이지 클릭방지) 활성화 true
			autoOpen: false,	// 페이지 로드시 자동 활성화 false
			resizable: false,		// 사이즈 조절 false
			open: function() {
				$("#review_img_detail_area").on("click", function() {
					$(this).dialog("close").off();
				});
			},
		}).parents(".ui-dialog").find(".ui-dialog-titlebar").remove();	// 다이얼로그의 타이틀바를 클래스로 찾아서 제거 (타이틀바 사용안할 것)
		
		// 이미지 클릭시 다이얼로그로 큰 이미지 나타내기
		$(".review_img").on("click", function() {
			$("#review_img_detail_area").find(".review_img_detail").css("background-image", $(this).css("background-image"));
			$("#review_img_detail_area").dialog("open");
		});
	});
</script>
<style>
	#review_img_detail_area { padding: 0px !important; text-align: center; overflow: hidden; }
	.review_img_detail { width: 600px; height: 592px; background-repeat: no-repeat; background-size: contain; background-position: center; display: inline-block; }
	.not_exist_guid { width:1200px; margin: 20px 0px; text-align: center; }
</style>
<div>
	<ul>
		<c:if test="${empty list }">
		<p class="not_exist_guid">등록된 리뷰가 없습니다.</p>
		</c:if>
		<c:forEach var="vo" items="${list }">
			<li>
				<div class="review_content">
					<div class="review_score" id="review_score">${vo.rstar }</div>
					<div class="review_title">${vo.rtitle }</div>
					<div class="review_context">
						${vo.rcontent }
					</div>
					<c:if test="${!empty vo.rfile_org }">
						<div class="review_img" style="background-image: url('${pageContext.servletContext.contextPath }/upload/${vo.rfile_real }');"></div>
					</c:if>
				</div>
				<div class="review_info">
					<div>작성자 ${vo.mname }</div>
					<div>작성일 <fmt:formatDate value="${vo.rregdate }" pattern="yyyy-MM-dd hh:mm:ss"/></div>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>
<div id="review_img_detail_area">
	<div class="review_img_detail"></div>
</div>