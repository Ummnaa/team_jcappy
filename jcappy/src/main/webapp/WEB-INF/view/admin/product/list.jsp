	<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/view/admin/include/headHtml.jsp"%>
<title>상품 목록</title>
<script>
function goSaveCount(no) {
	$("#pno").val(no);
	$("#frmListCount").submit();
}

	function isDel(no) {
		if (confirm('삭제하시겠습니까?')) {
			$.ajax({
				url : 'delete',
				data : {
					'pno' : no
				},
				method : 'post',
				success : function(res) {
					if (res.trim() == 'true') {
						alert('정상적으로 삭제되었습니다.');
						location.href = 'list';
					} else {
						alert('삭제 실패');
					}
				},
				error : function(res) {
				}
			});
		}
	}
</script>
<!-- 이중 select box -->
<script>
function categoryChange(e) {
    var pcate_frez = ["일반형냉장고", "양문형냉장고", "업소용냉장고"];
    var pcate_air = ["스탠드형에어컨", "벽걸이형에어컨", "창문형에어컨"];
    var pcate_tv = ["LEDTV", "QLEDTV", "OLEDTV"];
    var pcate_wash = ["일반세탁기", "드럼세탁기", "미니세탁기"];
    var target = document.getElementById("pcate");
 
    if(e.value == "냉장고") var d = pcate_frez;
    else if(e.value == "에어컨") var d = pcate_air;
    else if(e.value == "TV") var d = pcate_tv;
    else if(e.value == "세탁기") var d = pcate_wash;
 
    target.options.length = 0;
 
    for (x in d) {
        var opt = document.createElement("option");
        opt.value = d[x];
        opt.innerHTML = d[x];
        target.appendChild(opt);
    }    
}
</script>
</head>
<body>
	<div id="wrap">
		<!-- canvas -->
		<div id="canvas">
			<%@ include file="/WEB-INF/view/admin/include/top.jsp"%>
			<div id="container">
				<div id="content">
					<div class="con_tit">
						<h2>상품관리 - [목록]</h2>
					</div>
					<div class="con">
						<div id="bbs">
							<div id="blist">
								<p>
									<span><strong>총 ${productVo.totCount }개</strong> | ${productVo.reqPage}/${productVo.totPage }페이지</span>
								</p>
								<form name="frmListCount" id="frmListCount" action="updateCount"
									method="post">
									<table width="100%" border="0" cellspacing="0" cellpadding="0"
										summary="상품 목록">
										<colgroup>
											<col width="80px" />
											<col width="80px" />
											<col width="*" />
											<col width="120px" />
											<col width="80px" />
											<col width="160px" />
											<col width="80px" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col" class="first">상품 번호</th>
												<th scope="col">브랜드</th>
												<th scope="col">상품명</th>
												<th scope="col">상품 가격</th>
												<th scope="col">재고량</th>
												<th scope="col">상품 등록일</th>
												<th scope="col">삭제</th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${empty list }">
												<tr>
													<td colspan="7">등록된 글이 없습니다.</td>
												</tr>
											</c:if>
											<c:forEach var="vo" items="${list }" varStatus="status">
												<tr>
													<td class="first">${vo.pno }</td>
													<td>${vo.pcompany }</td>
													<td style="text-align: left; padding-left: 10px;"><a href="detail?pno=${vo.pno }">${vo.pname }</a></td>
													<td><fmt:formatNumber value="${vo.pprice }" pattern="#,###,###"/></td>
													<td><input type="number" name="pcount" class="w100" value="${vo.pcount }" />
													<a class="btns" href="javascript:goSaveCount(${vo.pno });"><strong>변경</strong></a>	
													</td>
													<td class="date">
													<fmt:formatDate value="${vo.pregdate }" pattern="yyyy-MM-dd HH:mm:ss" />
													</td>
													<td>
													<a href="javascript:isDel(${vo.pno });" class="btns"><strong>삭제</strong></a>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<input type="hidden" name="pno" id="pno" value="">
								</form>
								<div class="btn">
									<div class="btnRight">
										<a class="wbtn" href="write"><strong>등록</strong> </a>
									</div>
								</div>
								
								
								
								<!-- 페이징 처리 -->
								<div class='page'>
									<c:if test="${productVo.startPage > productVo.pageRange}">
										<a
											href="list?reqPage=${productVo.startPage-1 }&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}"><</a>
									</c:if>
									<c:forEach var="rp" begin="${productVo.startPage}" end="${productVo.endPage }">
										 <c:if test="${productVo.reqPage == rp }">
			                        	    <a href='list?reqPage=${rp}&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}'>
												<strong>
				                        	    	${rp }
				                        	    </strong>
			                        	    </a>
		                        	    </c:if>
		                        	    <c:if test="${productVo.reqPage != rp }">
			                        	    <a href='list?reqPage=${rp}&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}'>
												${rp }
											</a>
		                        	    </c:if>
									</c:forEach>
									<c:if test="${productVo.totPage > productVo.endPage}">
										<a
											href="list?reqPage=${productVo.endPage+1 }&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}">></a>
									</c:if>
								</div>
								<!-- //페이징 처리 -->
								<form name="searchForm" id="searchForm" action="" method="get">
									<div class="search">
										<select name="stype" title="검색분류선택">
											<option value="all">전체</option>
											<option value="pcompany"
												<c:if test="${param.stype=='pcompany' }">selected</c:if>>브랜드명</option>
											<option value="pname"
												<c:if test="${param.stype=='pname' }">selected</c:if>>상품명</option>
										</select> 
										
										<select name="ptype" onchange="categoryChange(this)" title="종류">
											<option value="all">전체</option>
											<option value="frez"
												<c:if test="${param.ptype=='frez' }">selected</c:if>>냉장고</option>
											<option value="air"
												<c:if test="${param.ptype=='air' }">selected</c:if>>에어컨</option>
											<option value="tv"
												<c:if test="${param.ptype=='tv' }">selected</c:if>>TV</option>
											<option value="wash"
												<c:if test="${param.ptype=='wash' }">selected</c:if>>세탁기</option>
										</select>
										
										<select name="pcate" id="pcate" title="카테고리">
											<option value="all">전체</option>
										</select>
										<input type="text" id="sval" name="sval" value="${param.sval }" title="검색할 내용을 입력해주세요" />
										<input type="image" src="<%=request.getContextPath()%>/img/admin/btn_search.gif" class="sbtn" alt="검색" />
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>