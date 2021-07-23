<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품목록</title>
<%@ include file="/WEB-INF/view/include/head.jsp"%>
</head>

<body>
	<div id="wrap">
		<%@ include file="/WEB-INF/view/include/top.jsp"%>
		<div id="container">
			<div class="menu_content">
				<div class="itemList_thema" style="background-image: url('/jcappy/img/냉장고 대표.jpg');">
					<a href="/jcappy/product/${type }">${productVo.sptype }</a>
				</div>
				<div class="cate_menu">
					<div class="cstyle_btn"><a href="/jcappy/product/${type }/a">${a }</a></div>
					<div class="cstyle_btn"><a href="/jcappy/product/${type }/b">${b }</a></div>
					<div class="cstyle_btn"><a href="/jcappy/product/${type }/c">${c }</a></div>
				</div>
			</div>
			<form id="searchForm" method="POST" action="/jcappy/product/${type }">
				<p class="itemList_count">${productVo.sptype } productVo.totCount(총 개수)</p>
				<div class="itemList_search">
					<select name="orderby" onchange="$('#searchForm').submit();">
						<option value="popular" <c:if test="${productVo.orderby == 'popular' && productVo.direct == 'DESC' }">selected</c:if>>인기순</option>
						<option value="pprice" <c:if test="${productVo.orderby == 'pprice' && productVo.direct == 'DESC' }">selected</c:if>>가격 높은순</option>
						<option value="pprice" <c:if test="${productVo.orderby == 'pprice' && productVo.direct == 'ASC' }">selected</c:if>>가격 낮은순</option>
					</select>
					<input type="hidden" name="direct" value="${productVo.direct }">
					
					<input type="text" name="sval" value="${productVo.sval }" placeholder="검색어를 입력해주세요.">
					<button class="cstyle_btn" type="submit">검색</button>
				</div>
			</form>
			<div class="product_content">
				<div class="flex">
				<c:forEach var="vo" items="${list }">
					<div class="item cstyle_border_gray">
						<a href="/jcappy/product/detail">
                            <span class="image" style="background-image: url('${vo.pimg1_org }');"></span>
                            <span class="name">${vo.pname }</span>
                            <span class="price"><fmt:formatNumber maxFractionDigits="3" type="number" value="${vo.pprice }"/>원</span>
                        </a>
					</div>
				</c:forEach>
				</div>
			</div>
			<div class="pagenate clear">
				<ul class="paging">
					<c:if test="${productVo.startPage > productVo.pageRange}">
						<li><a href="index.do?reqPage=${vo.startPage-1 }&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}">&lt;</a></li>
					</c:if>
					<c:forEach var="rp" begin="${productVo.startPage}" end="${productVo.endPage }">
					    <li><a href='index.do?reqPage=${rp}&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}' <c:if test="${rp==productVo.reqPage }">class='current'</c:if>>${rp }</a></li>
					</c:forEach>
					<c:if test="${productVo.totPage > productVo.endPage}">
						<li><a href="index.do?reqPage=${productVo.endPage+1 }&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}">&gt;</a></li>
					</c:if>
				</ul> 
			</div>
		</div>

	<%@ include file="/WEB-INF/view/include/bottom.jsp"%>
	</div>
</body>
</html>