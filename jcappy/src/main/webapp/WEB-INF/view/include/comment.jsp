<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
				<table class="list">
                    <p style="text-align:left;"><span><strong>총 ${commentVo.totCount }개</strong>  |  ${commentVo.reqPage}/${commentVo.totPage }페이지</span></p>
                    <hr>
                        <caption>댓글 목록</caption>
                        <colgroup>
                            <col width="*" />
                            <col width="100px" />
                            <col width="100px" />
                        </colgroup>
                        <tbody>
						<c:if test="${empty list }">
                            <tr>
                                <td class="first" colspan="3">등록된 댓글이 없습니다.</td>
                            </tr>
                        </c:if>
                        <!-- 댓글 리스트 -->
                        <c:forEach var="vo" items="${list }">     
                            <tr>
                                <td class=cstyle_text_align_left style="padding:10px 0px;">
                                    ${vo.cm_content}
                                    <c:if test="${membersInfo.mno == vo.mno}">
									<a href="javascript:commentDel(${vo.cm_no});">[X]</a>
									</c:if>
                                </td>
                                <td class="writer">
                                    <c:if test="${!empty vo.aname}">
                                    ${vo.aname }
                                    </c:if>
                                    <c:if test="${empty vo.aname}">
                                    ${vo.mname }
                                    </c:if>
                                </td>
                                <td class="date"><fmt:formatDate value="${vo.cm_regdate }" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <hr>
                    <!-- 페이징 -->
                    <div class="pagenate clear">
                        <div class='page'>
	                        <c:if test="${commentVo.startPage > commentVo.pageRange}">
	                        	<span><a href="javascript:getComment(${commentVo.startPage-1 })"><</a></span>
	                        </c:if>
	                        <c:forEach var="rp" begin="${commentVo.startPage}" end="${commentVo.endPage }">
	                            <span><a href='javascript:getComment(${rp})' <c:if test="${rp==commentVo.reqPage }">class='current'</c:if>>${rp }</a></span>
	                        </c:forEach>
	                        <c:if test="${commentVo.totPage > commentVo.endPage}">
	                        	<span><a href="javascript:getComment(${commentVo.endPage+1 })">></a></span>
	                        </c:if>
						</div>
                    </div>