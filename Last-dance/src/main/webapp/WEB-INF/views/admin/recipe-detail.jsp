<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<div class="mt-5">&nbsp;</div>

<h1>레시피 디테일</h1>

${recipeDto.recipeTitle}<br>
${recipeDto.recipeNick}<br>
${recipeDto.recipeInfo}<br>
${recipeDto.recipeTime}<br>
${recipeDto.recipeDifficulty}<br>
${recipeDto.recipeHashtag}<br>

<c:forEach var="recipeContentDto" items="${recipeContentList}">
${recipeContentDto.recipeContentText}
<img src="${pageContext.request.contextPath}/rest/download/${recipeContentDto.recipeContentAttachmentNo}" width="200" height="200">
<br>
</c:forEach>

<c:forEach var="recipeIngredientDto" items="${recipeIngredientList}">
	${recipeIngredientDto}
</c:forEach>
<br>

<c:forEach var="recipeImg" items="${recipeImgList}">
<img src="${pageContext.request.contextPath}/rest/download/${recipeImg}" width="200" height="200">
</c:forEach>
<br>

<a href="../update?recipeNo=${recipeDto.recipeNo}">수정</a>
<a class="delete-btn" href="../delete/${recipeDto.recipeNo}">삭제</a>

<script>
    $(function(){
    	$(".delete-btn").click(function(e){
    		
    		var choice = confirm("정말 삭제하시겠습니까?");
    		if(!choice){
    			e.preventDefault();
    		}
    	});
    });
</script>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>