<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<div class="mt-5 col-6 offset-3">
<div>
	<h3>레시피등록</h3>
</div>

<form action="write" method="post" class="recipe-update-form" autocomplete="off" enctype="multipart/form-data">

<div>
	레시피 제목 <input type="text" name="recipeTitle" value="${recipeDto.recipeTitle}">
</div>

<div>
	레시피 소개 <input type="text" name="recipeInfo" value="${recipeDto.recipeInfo}">
</div>

<div>
	레시피 정보 시간 <select name="recipeTime">
		<option value="">시간</option>
		<c:forEach var="i" begin="5" step="5" end="120">
			<c:choose>
				<c:when test="${i != 120}">
					<option <c:if test="${recipeDto.recipeTime == i}">selected</c:if> value="${i}">${i}분</option>
				</c:when>
				<c:otherwise>
					<option <c:if test="${recipeDto.recipeTime == i}">selected</c:if> value="${i}">120분 이상</option>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</select>
	난이도 <select name="recipeDifficulty">
	    <option value="">난이도</option>
	    <c:choose>
	    	<c:when test="${recipeDto.recipeDifficulty == '쉬워요'}">
			    <option selected value="쉬워요">쉬워요</option>
			    <option value="보통이에요">보통이에요</option>
			    <option value="어려워요">어려워요</option>
	    	</c:when>
	    	<c:when test="${recipeDto.recipeDifficulty == '보통이에요'}">
			    <option value="쉬워요">쉬워요</option>
			    <option selected value="보통이에요">보통이에요</option>
			    <option value="어려워요">어려워요</option>
	    	</c:when>
	    	<c:otherwise>
			    <option value="쉬워요">쉬워요</option>
			    <option value="보통이에요">보통이에요</option>
			    <option selected value="어려워요">어려워요</option>
	    	</c:otherwise>
	    </c:choose>
	</select>
</div>

<div>
	<i class="fa-regular fa-lightbulb"></i>음식의 재료를 입력해주세요.
</div>

<div>
	<input type="text" class="input-ingredient" placeholder="재료">
	<button type="button" class="ingredient-all-clear">모두 지우기</button>
</div>

<div class="search-ingredient"></div>
<div class="add-ingredient">
	<c:forEach var="ingredient" items="${recipeIngredientList}">
		<p>
			<input type="text" name="recipeIngredientName" value="${ingredient}" readonly>
			<i class="fa-solid fa-xmark"></i>
		</p>
	</c:forEach>
</div>

<div>
	요리 순서
</div>
<div>
	<i class="fa-regular fa-lightbulb"></i>요리의 맛이 좌우될 수 있는 중요한 부분은 빠짐없이 적어주세요.
</div>

<div>
	<textarea readonly rows="4" cols="100">
	예) 10분간 익혀주세요       10분간 약한불로 익혀주세요.
	      마늘편은 익혀주세요        마늘편은 충분히 익혀주셔야 매운 맛이 사라집니다.
	      꿀을 조금 넣어주세요         꿀이 없는 경우, 설탕 1스푼으로 대체 가능합니다.
	</textarea> 
</div>

<c:forEach var="no" begin="0" end="9">
	<div class="content-page">
		Step<fmt:formatNumber value="${no+1}" minIntegerDigits="2"/> 
		<textarea name="recipeContentText">${recipeContentList[no].recipeContentText}</textarea>
		<input type="file" class="file-input" accept=".jpg, .png, .gif">
		<c:choose>
			<c:when test="${recipeContentList[no].recipeContentAttachmentNo != null}">
				<img class="preview" src="${pageContext.request.contextPath}/rest/download/${recipeContentList[no].recipeContentAttachmentNo}" width="200" height="200"><br>
			</c:when>
			<c:otherwise>
				<img class="preview" src="${pageContext.request.contextPath}/images/img_plus.png" width="200" height="200"><br>
			</c:otherwise>
		</c:choose>
		<label class="step-plus-btn"><button type="button"><i class="fa-solid fa-plus"></i></button> 순서 추가</label>
		<label class="step-minus-btn"><button type="button"><i class="fa-solid fa-minus"></i></button> 순서 삭제</label>
	</div>
</c:forEach>

<div>
	요리 완성사진 
	<button type="button">사진 한 번에 넣기</button>
	<button type="button">사진 모두 지우기</button>
	<br>
	<c:forEach var="no" begin="0" end="3">
		<div class="thumb-page">
			<input type="file" class="file-input" accept=".jpg, .png, .gif">
		<c:choose>
			<c:when test="${recipeImgList[no] != null}">
				<img class="preview" src="${pageContext.request.contextPath}/rest/download/${recipeImgList[no]}" width="200" height="200"><br>
			</c:when>
			<c:otherwise>
				<img class="preview" src="${pageContext.request.contextPath}/images/img_plus.png" width="200" height="200"><br>
			</c:otherwise>
		</c:choose>
		</div>
	</c:forEach>
</div>

<div>
	요리 해시태그
	<select name="recipeHashtag">
		<option value="">해시태그</option>
		<c:forEach var="hashtagDto" items="${hashtagList}">
		<c:choose>
			<c:when test="${hashtagDto.hashtagName == recipeDto.recipeHashtag}">
				<option selected>${hashtagDto.hashtagName}</option>
			</c:when>
			<c:otherwise>
				<option>${hashtagDto.hashtagName}</option>
			</c:otherwise>
		</c:choose>
		</c:forEach>
	</select>
</div>

<div class="col-10 offset-1">
	<button class="col-5 btn btn-md text-lg btn-warning recipe-insert-btn" type="submit">레시피 수정하기</button>
	<button class="col-5 btn btn-md text-lg btn-warning recipe-return-btn" type="button">돌아가기</button>
</div>

</form>
</div>

<script type="text/javascript">
	$(function(){
		$(".fa-xmark").click(function(){
			$(this).parent().remove();
		});
		
		$(".recipe-insert-form").keydown(function(e){
    		if(e.keyCode === 13){
	    		e.preventDefault();
    		}
    	});
    	
    	/* 등록하기 버튼 클릭 시 모든 칸 검사 후 제출 */
    	$(".recipe-insert-form").submit(function(e){
	   		var recipeTitle = $("[name=recipeTitle]");
	   		if(!recipeTitle.val()){
	   			alert("레시피 제목을 등록해주세요.");
	   			recipeTitle.focus();
	   			$("html, body").animate({scrollTop: recipeTitle.offset().top-100},400);
	   			return false;
	   		}
	   		
	   		var recipeInfo = $("[name=recipeInfo]");
	   		if(!recipeInfo.val()){
	   			alert("레시피 소개를 등록해주세요.");
	   			recipeInfo.focus();
	   			$("html, body").animate({scrollTop: recipeInfo.offset().top-100},400);
	   			return false;
	   		}
	
	   		var recipeTime = $("[name=recipeTime]");
	   		if(!recipeTime.val()){
	   			alert("레시피 소요시간을 선택해주세요.");
	   			recipeTime.focus();
	   			return false;
	   		}
	   		
	   		var recipeDifficulty = $("[name=recipeDifficulty]");
	   		if(!recipeDifficulty.val()){
	   			alert("레시피 난이도를 선택해주세요.");
	   			recipeDifficulty.focus();
	   			return false;
	   		}
	
	   		var recipeIngredient = $("[name=recipeIngredientName]");
	   		if(!recipeIngredient.val()){
	   			alert("레시피 재료를 선택해주세요.");
	   			$(".input-ingredient").focus();
	   			$("html, body").animate({scrollTop: $(".input-ingredient").offset().top-100},400);
	   			return false;
	   		}
	   		
			var contentText = $("[name=recipeContentText]");
			var contentImg = $(".content-page").find(".file-input");
			//레시피 컨텐트 아예 없을 때 리턴
			var contentCnt = 0;
			var contentImgCnt = 0;
			for(var i=0; i<contentText.length; i++){
				if(contentText.eq(i).text()){
					contentCnt++;
				}
				if(contentImg.eq(i).val()){
					contentImgCnt++;
				}
	               if(contentCnt != contentImgCnt){
	                   alert("레시피 내용 작성을 완료해주세요.");
	                   return false;
	               }
			}
			//레시피 컨텐트 아예 아무 것도 없을 때
			if(contentCnt == 0 && contentImgCnt == 0){
				alert("레시피 내용을 등록해주세요.");
				contentText.first().focus();
	   			$("html, body").animate({scrollTop: contentText.first().offset().top-100},400);
				return false;
			}
	
           //레시피 썸네일 아예 없을 때 리턴
			var recipeImg = $(".thumb-page").find(".file-input");
			var recipeImgCnt = 0;
			for(var i=0; i<recipeImg.length; i++){
				if(recipeImg.eq(i).val()){
					recipeImgCnt++;	
				}
			}
			//레시피 썸네일 아예 없을 때
			if(recipeImgCnt == 0){
				alert("레시피 썸네일을 지정해주세요.");
	   			$("html, body").animate({scrollTop: recipeImg.first().offset().top-100},400);
				return false;
			}
	   		
	   		var recipeHashtag = $("[name=recipeHashtag]");
	   		if(!recipeHashtag.val()){
	   			alert("레시피 해시태그를 선택해주세요.");
	   			recipeHashtag.focus();
	   			return false;
	   		}
	   		
	   		var choice = confirm("등록하시겠습니까?");
	   		if(!choice){
	    		e.preventDefault();
	   		}
	   		else{
				//레시피 내용 작성 돼 있으면 그 다음 칸부터는 삭제
	            for(var j=contentCnt; j<contentText.length; j++){
	                contentText.eq(j).parent().remove();
	            }
				//레시피 썸네일 없는 칸부터 빈칸 삭제
				for(var i=0; i<recipeImg.length; i++){
					if(!recipeImg.eq(i).val()){
						recipeImg.eq(i).parent().remove();
					}
				}
	   		}
    	});

    	/* 레시피 돌아가기 클릭 시 비동기로 첨부파일 삭제 */
    	$(".recipe-return-btn").click(function(e){
    		var param = $(".recipe-insert-form .img-no").serialize();
    		$.ajax({
    			url: "http://localhost:8888/rest/attachment/delete?"+param,
    			method: "delete",
    			success: function(resp){
    				history.back();
    			}
    		});
    	});
    	
    	/* 레시피 내용 블러 시 textarea 안에 값 넣어주기 */
    	$("[name=recipeContentText]").blur(function(){
    		$(this).text($(this).val());
    	});
    	
    	/* 재료 입력 비동기 불러오기 */
    	$(".input-ingredient").on("input", function(){
            setTimeout(() => {
                var keyword = $(".input-ingredient").val();
                if(keyword == ""){
                    $(".ingredientSearch").remove();
                }
                else{
                	var param = new String();
                	param.type = "ingredient_name";
                	param.keyword = keyword;
                	var search = $.param(param);
                    $.ajax({
                        url: "http://localhost:8888/rest/ingredient?"+search,
                        method: "get",
                        success: function(resp){
                            $(".ingredientSearch").remove();
                            for(var i=0; i<resp.length; i++){
                                var pTag = $("<p>")
                                    .addClass("ingredientSearch")
                                    .text(resp[i].ingredientName);
                                
                                pTag.click(function(){
                                    var xMark = $("<i>").addClass("fa-solid fa-xmark");
                                    xMark.click(function(){
                                        $(this).parent().remove();
                                    });
                                    
                                    var p = $("<p>")
                       				var input = $("<input>")
										.attr("readolny", true)
	                                    .attr("name", "recipeIngredientName")
	                                    .val($(this).text());
                                    p.append(input).append(xMark);
                                    $(".add-ingredient").append(p);
                                    $(".ingredientSearch").remove();
                                    $(".input-ingredient").val("");
                                });
                                
                                $(".search-ingredient").append(pTag);
                            }
                        }
                    });
                }
            }, 1000);
        });

    	/* 재료 엔터 등록 없을 시 등록 모달 구현 예정 */
    	$(".input-ingredient").keydown(function(e){
    		if(e.keyCode == 13) {
	    		$(".ingredientSearch").remove();
    			var keyword = $(this).val();
    			var param = new String();
            	param.type = "ingredient_name";
            	param.keyword = keyword;
            	var search = $.param(param);
    			$.ajax({
                    url: "http://localhost:8888/rest/ingredient?"+search,
                    method: "get",
                    success: function(resp){
                    	if(resp.length == 0){
                    		alert("등록되지 않은 재료입니다.");
				    		return;
                    	}
                    	else{
							var xMark = $("<i>").addClass("fa-solid fa-xmark");
							xMark.click(function(){
								$(this).parent().remove();
							});
							var p = $("<p>")
							var input = $("<input>")
								.attr("readonly", "readonly")
								.attr("name", "recipeIngredientName")
								.val(keyword);
							p.append(input).append(xMark);
							$(".add-ingredient").append(p);
							$(".input-ingredient").val("");
                    	}
                    }
    			});
    		}
    	});
    	
    	/* 전체 삭제 클릭 시 등록된 재료 전부 삭제 */
    	$(".ingredient-all-clear").click(function(){
    		$("[name=recipeIngredientName]").parent().remove();
    	});
    	
    	/* 순서 추가 버튼 클릭 시 다음 단계 등록 영역 생성 */
    	$(".step-plus-btn").last().remove();
    	$(".step-minus-btn").first().remove();
    	$(".content-page").hide();
    	$(".content-page").first().show();

    	$(".step-plus-btn").click(function(){
    		var contentText = $(this).parent().find("[name=recipeContentText]").val();
    		var contentImg = $(this).parent().find(".file-input").val();
    		if(!contentText || !contentImg){
    			alert("레시피 내용은 순서대로 등록해주세요.");
    			return;
    		}
    		$(this).hide();
    		$(this).next().hide();
    		$(this).parent().next().show();
    	});
    	$(".step-minus-btn").click(function(){
    		var contentText = $(this).parent().find("[name=recipeContentText]");
    		var contentImg = $(this).parent().find(".file-input");
    		if(contentText.val() || contentImg.val()){
    			var choice = confirm("작성한 내용은 저장되지 않습니다. 삭제하시겠습니까?");
    			if(!choice){
    				return;
    			}
    		}
    		var recipeContentAttachmentNo = $(this).parent().find("[name=recipeContentAttachmentNo]");
    		$.ajax({
    			url: "http://localhost:8888/rest/attachment/delete?"+recipeContentAttachmentNo.val(),
    			method: "delete",
    			success: function(resp){
					contentText.val("");
					contentImg.val("");
					$(this).parent().find(".preview").attr("src", "${pageContext.request.contextPath}/images/img_plus.png");
					recipeContentAttachmentNo.remove();
		    		$(this).parent().prev().find(".step-plus-btn").show();
		    		$(this).parent().prev().find(".step-minus-btn").show();
		    		$(this).parent().hide();
    			}
    		});
    	});

    	/* 이미지 업로드 비동기 후 미리보기 구현 */
        $(".file-input").change(function(){
        	var that = $(this);
            if(this.files.length > 0){
                var fd = new FormData();
                fd.append("attach", this.files[0]);
                $.ajax({
                    url: "http://localhost:8888/rest/upload",
                    method: "post",
                    data: fd,
                    processData: false,
                    contentType: false,
                    success: function(resp){
                    	that.next().attr("src", resp);
                    	var attachmentNo = parseInt((resp.split("download/"))[1]);
                    	if(that.parent().attr("class") == "thumb-page"){
	                    	var imgNo = $("<input>").attr("type", "hidden").addClass("img-no").attr("name", "recipeAttachmentNo").val(attachmentNo);
                    	}
                    	if(that.parent().attr("class") == "content-page"){
	                    	var imgNo = $("<input>").attr("type", "hidden").addClass("img-no").attr("name", "recipeContentAttachmentNo").val(attachmentNo);
                    	}
						that.parent().append(imgNo);
                    }
                });
            }
            else{
                $(".preview").attr("src", "${pageContext.request.contextPath}/images/img_plus.png");
            }
        });
	});
</script>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>