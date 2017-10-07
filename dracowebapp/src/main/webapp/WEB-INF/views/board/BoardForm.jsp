<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>board</title>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board/BoardCommon.css" />
<script>
function chkInputValue(id, msg){
	if ( $.trim($(id).val()) == "") {
		alert(" Input " + msg);
		$(id).focus();
		return false;
	} 
	return true;
}
function fn_formSubmit(){
	if ( ! chkInputValue("#brdwriter", "author")) return;
	if ( ! chkInputValue("#brdtitle", "title")) return;
	if ( ! chkInputValue("#brdmemo", "content")) return;
	
	$("#form1").submit();
} 
</script>
</head>
<body>
<%-- <a href="boardList?bgno=<c:out value="${boardInfo.bgno}"/>" class="crimsonBtn">To the list</a> --%>
	<h1><c:out value="${bgInfo.bgname}"/></h1>	
	<form id="form1" name="form1" action="boardSave" method="post" enctype="multipart/form-data">
		<table class="shadowedBox">
<%-- 			<caption>Board</caption> --%>
			<colgroup>
				<col width='15%' />
				<col width='*%' />
			</colgroup>
			<tbody>
				<tr>
					<td>Author</td> 
					<td><input type="text" id="brdwriter" name="brdwriter" size="20" maxlength="20" value="<c:out value="${boardInfo.brdwriter}"/>"></td> 
				</tr>
				<tr>
					<td>Title</td> 
					<td><input type="text" id="brdtitle" name="brdtitle" size="70" maxlength="250" value="<c:out value="${boardInfo.brdtitle}"/>"></td> 
				</tr>
				<tr>
					<td>Content</td> 
					<td><textarea id="brdmemo" name="brdmemo" rows="5" cols="60"><c:out value="${boardInfo.brdmemo}"/></textarea></td> 
				</tr>
				<tr>
					<td>Attachment</td> 
					<td>
						<c:forEach var="listview" items="${listview}" varStatus="status">
							<input type="checkbox" name="fileno" value="<c:out value="${listview.fileno}"/>">	
            				<a href="fileDownload?filename=<c:out value="${listview.filename}"/>&downname=<c:out value="${listview.realname }"/>"> 							 
							<c:out value="${listview.filename}"/></a> <c:out value="${listview.size2String()}"/><br/>
						</c:forEach>					
					
						<input type="file" name="uploadfile" multiple="" />
					</td> 
				</tr>
			</tbody>
		</table>     
		<input type="hidden" name="bgno" value="<c:out value="${bgno}"/>"> 
		<input type="hidden" name="brdno" value="<c:out value="${boardInfo.brdno}"/>"> 
		<a href="#" onclick="fn_formSubmit()" class="crimsonBtn">Save</a>
	</form>	
</body>
</html>