<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/WEB-INF/view/admin/include/headHtml.jsp"%>
<script src="/jcappy/js/common.js"></script>
<!-- 필수입력칸 구현 -->
<script>
$(function(){
	
	$('#save').click(function(){
		if($("#ptype").val() == ''){
			alert("상품 종류를 입력해주세요");
			return false;
		}
		if($("#stype").val() == ''){
			alert("브랜드를 입력해주세요");
			return false;
		}
		if($("#stype").val() == '기타'){
			if($('#brandEtc').val().trim() == ''){
				$('#brandEtc').val('기타');
			}
		}
		if($("#pname").val() == ''){
			alert("상품명을 입력해주세요");
			return false;
		}
		if($("#pprice").val() == ''){
			alert("상품 가격을 입력해주세요");
			return false;
		}
		if(Number($("#pprice").val()) > 2000000000){
			alert("상품 가격을 2,000,000,000원 이하로 입력해주세요")
			return false;
		}
		if($("#pcount").val() == ''){
			alert("상품 재고를 입력해주세요");
			return false;
		}
		return true;
	})
})
</script>
<!-- 스마트에디터 -->
<script>
var oEditors;
$(function(){
   oEditors = setEditor("contents"); // textarea 아이디 값
});

function goSave() {
	oEditors.getById['contents'].exec("UPDATE_CONTENTS_FIELD",[]);
	$("#frm").submit();
}
</script>
<!-- 상품삭제 -->
<script>
       function isDel() {
          if (confirm('삭제하시겠습니까?')) {

             $.ajax({
                url:'delete',
                data:{
                   'pno':${vo.pno}
                },
                method:'post',
                success:function(res) {
                   console.log(res);
                   if (res.trim() == 'true') {
                      alert('정상적으로 삭제되었습니다.');
                      location.href='list';
                   } else {
                      alert('삭제 실패');
                   }
                },
             });
          }
       }
</script>
<!-- 이미지삭제 -->
<script>
function deleteImg() {
	if (confirm('삭제하시겠습니까?')) {
			
		$.ajax({
			url:'deleteImg',
            data: $('#frm').serialize(),
			method:'post',
            success:function(res) {
            	console.log(res);
            	if (res.trim() == 'true') {
                  alert('정상적으로 삭제되었습니다.');
                  location.reload();
               } else {
                  alert('삭제 실패');
               }
            },
		});
	}
}
</script>
<!-- 이미지 썸네일 -->
<script>
$(function() {
    $("#file1").on("change", function(){
        var files = !!this.files ? this.files : [];
        if (!files.length || !window.FileReader) return; 
        if (/^image/.test( files[0].type)){ 
            var reader = new FileReader(); 
            reader.readAsDataURL(files[0]); 
            reader.onloadend = function(){ 
             $('.imagePreview1').css("background-image", "url("+this.result+")"); 
            };
        }
    });
    
    $("#file2").on("change", function(){
        var files = !!this.files ? this.files : [];
        if (!files.length || !window.FileReader) return; 
        if (/^image/.test( files[0].type)){ 
            var reader = new FileReader(); 
            reader.readAsDataURL(files[0]); 
            reader.onloadend = function(){ 
             $('.imagePreview2').css("background-image", "url("+this.result+")"); 
            };
        }
    });
    
    $("#file3").on("change", function(){
        var files = !!this.files ? this.files : [];
        if (!files.length || !window.FileReader) return; 
        if (/^image/.test( files[0].type)){ 
            var reader = new FileReader(); 
            reader.readAsDataURL(files[0]); 
            reader.onloadend = function(){ 
             $('.imagePreview3').css("background-image", "url("+this.result+")"); 
            };
        }
    });
});
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
<!-- 브랜드에서 기타 선택시 input box 나오는것 -->
<script>
	$(function() {
		$("#brandEtc").hide();

		$("#stype").change(function() {
			pcompEct();
		});
		pcompEct();
	});
	
	function pcompEct() {
		if ($("#stype").val() == "기타") {
			$("#brandEtc").show();
		} else {
			$("#brandEtc").hide();
		}
	}
</script>
</head>
<body>
	<div id="wrap">
		<!-- canvas -->
		<div id="canvas">
			<!-- S T A R T :: headerArea-->
			<%@ include file="/WEB-INF/view/admin/include/top.jsp"%>
			<!-- E N D :: headerArea-->
			<!-- S T A R T :: containerArea-->
			<div id="container">
				<div id="content">
					<div class="con_tit">
						<h2>상품관리 - [상세보기]</h2>
					</div>
					<!-- //con_tit -->
					<div class="con">
						<!-- 내용 : s -->
						<div id="bbs">
							<div id="bread">
								<form method="post" name="frm" id="frm" action="update"
									enctype="multipart/form-data">
									<table width="100%" border="0" cellspacing="0" cellpadding="0"
										summary="상품정보 상세보기">
										<colgroup>
											<col width="10%" />
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><label for="ino">상품 번호</label></th>
												<td colspan="10"><input type="text" id="ino" name="ino"
													class="w100" value="${vo.pno }" /></td>
											</tr>
											<tr>
												<th scope="row"><label for="ptype">상품 종류</label></th>
												<td colspan="10">
													<div>
														<select id="ptype" name="ptype" style="font-size: 13px"
															onchange="categoryChange(this)">
															<option>${vo.ptype }</option>
															<option value="냉장고">냉장고</option>
															<option value="에어컨">에어컨</option>
															<option value="TV">TV</option>
															<option value="세탁기">세탁기</option>
														</select> <select name="pcate" style="font-size: 13px" id="pcate">
															<option>${vo.pcate }</option>
														</select>
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row"><label for="stype">브랜드</label></th>
												<td colspan="10">
												<select name="pcompany" style="font-size: 13px" id="stype" title="브랜드">
														<option value="삼성전자"
														<c:if test="${vo.pcompany == '삼성전자'}">selected</c:if>>삼성전자</option>
														<option value="LG전자"
														<c:if test="${vo.pcompany == 'LG전자'}">selected</c:if>>LG전자</option>
														<option value="캐리어"
														<c:if test="${vo.pcompany == '캐리어'}">selected</c:if>>캐리어</option>
														<option value="위니아전자"
														<c:if test="${vo.pcompany == '위니아전자'}">selected</c:if>>위니아전자</option>
														<option value="기타"
														<c:if test="${vo.pcompany != '삼성전자' && vo.pcompany != 'LG전자' && vo.pcompany != '캐리어' && vo.pcompany != '위니아전자'}">selected</c:if>>기타</option>
												</select> 
												<input type="text" id="brandEtc" name="pcomp" <c:if test="${vo.pcompany != '삼성전자' && vo.pcompany != 'LG전자' && vo.pcompany != '캐리어' && vo.pcompany != '위니아전자'}">value="${vo.pcompany}"</c:if>/>
												</td>
											</tr>
											<tr>
												<th scope="row"><label for="pname">상품명</label></th>
												<td colspan="10">
													<input type="text" id="pname" name="pname" class="w100" value="${vo.pname }"/>
												</td>
											</tr>
											<tr>
												<th scope="row"><label for="pprice">상품 가격</label></th>
												<td colspan="10">
													<input type="number" style="font-size: 12px" id="pprice" name="pprice" class="w100" value="${vo.pprice }"/>
												</td>
											</tr>
											<tr>
												<th scope="row"><label for="pcount">상품 재고</label></th>
												<td colspan="10">
												<input type="number"style="font-size: 12px" id="pcount" name="pcount" class="w100" value="${vo.pcount }"/>
												</td>
											</tr>
											<tr>
												<th scope="row"><label for="pregdate">상품 등록일</label></th>
												<td colspan="10">
												<input type="text" id="pregdate" name="pregdate" class="w100" value="${vo.pregdate }" readonly />
												</td>
											</tr>
											<tr>
												<th scope="row"><label for="">상품 이미지</label></th>
												<td colspan="10" rowspan="1">
												
												<div class="imagePreview1"></div>
												<c:if test="${!empty vo.pimg1_org}">
													<input type="checkbox" name="delImg1" id="delImg1" value="1"/>
													<img style="width: 100px;" src="${vo.pimg1_real}">
												</c:if>
												<input type="file" id="file1" name="file1" class="w100" />
												
												<div class="imagePreview2"></div>
												<c:if test="${!empty vo.pimg2_org}">
													<input type="checkbox" name="delImg2" id="delImg2" value="1"/>
													<img style="width: 100px;" src="${vo.pimg2_real}">
												</c:if>
												<input type="file" id="file2" name="file2" class="w100" />
												 
												 <div class="imagePreview3"></div>
												 <c:if test="${!empty vo.pimg3_org}">
													<input type="checkbox" name="delImg3" id="delImg3" value="1"/>
													<img style="width: 100px;" src="${vo.pimg3_real}">
												</c:if>
												<input type="file" id="file3" name="file3" class="w100" />
												
												<a class="btns" style="cursor: pointer;" href="#" onclick="deleteImg();"><strong>삭제</strong> </a>
												</td>
											</tr>
											<tr>
												<th scope="row"><label for="contents">상품 상세정보</label></th>
												<td colspan="10"><textarea name="pdetail" id="contents"
														style="width: 100%;">${vo.pdetail }</textarea></td>
										</tbody>
									</table>
									<input type="hidden" name="cmd" value="write" /> <input
										type="hidden" name="pno" value="${vo.pno}">
								</form>
								<div class="btn">
									<div class="btnLeft">
										<a class="btns" href="list"><strong>목록</strong></a>
									</div>
									<div class="btnRight">
										<a class="btns" id="save" style="cursor: pointer;" href="javascript:goSave();"><strong>수정</strong></a>
										<a class="btns" style="cursor: pointer;" href="javascript:isDel();"><strong>삭제</strong></a>
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
					<!-- 주문목록 -->
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