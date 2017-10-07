<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board/BoardCommon.css" />
<title>Board</title>
<script>
function fn_formSubmit(){
	document.form1.submit();	
}
</script>
</head>
<body>
	<a class="crimsonBtn" href="/">Home</a>
	<a class="crimsonBtn" href="boardForm?bgno=<c:out value="${searchVO.bgno}"/>">Compose</a>
	<h1><c:out value="${bgInfo.bgname}"/></h1>						
	<table id="boardTbl" class="shadowedBox">
<%-- 		<caption>Board</caption> --%>
		<colgroup>
			<col width='8%' />
			<col width='*%' />
			<col width='15%' />
			<col width='15%' />
			<col width='10%' />
			<col width='10%' />
		</colgroup>
		<thead>
			<tr>
				<th>NO</th> 
				<th>Title</th>
				<th>Author</th>
				<th>Date</th>
				<th>View</th>
				<th>Attachment</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="listview" items="${listview}" varStatus="status">	
				<c:url var="link" value="boardRead">
					<c:param name="brdno" value="${listview.brdno}" />
				</c:url>		
										  				
				<tr>
					<td><c:out value="${searchVO.totRow-((searchVO.page-1)*searchVO.displayRowCount + status.index)}"/></td>
					<td class="TdTitle">
						<a href="${link}"><c:out value="${listview.brdtitle}"/></a>
						<c:if test="${listview.replycnt>0}">
							(<c:out value="${listview.replycnt}"/>)
						</c:if>						
					</td>
					<td><c:out value="${listview.brdwriter}"/></td>
					<td><c:out value="${listview.brddate}"/></td>
					<td><c:out value="${listview.brdhit}"/></td>
					<td><c:out value="${listview.filecnt}"/></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<form id="form1" name="form1"  method="post">
	    <jsp:include page="/WEB-INF/views/common/pagingForSubmit.jsp" />
	    
		<div>
			<input type="checkbox" name="searchType" value="brdtitle" <c:if test="${fn:indexOf(searchVO.searchType, 'brdtitle')!=-1}">checked="checked"</c:if>/>
			<label class="chkselect" for="searchType1">Title</label>
			<input type="checkbox" name="searchType" value="brdmemo" <c:if test="${fn:indexOf(searchVO.searchType, 'brdmemo')!=-1}">checked="checked"</c:if>/>
			<label class="chkselect" for="searchType2">Content</label>
			<input type="text" name="searchKeyword" style="width:150px;" maxlength="50" value='<c:out value="${searchVO.searchKeyword}"/>' onkeydown="if(event.keyCode == 13) { fn_formSubmit();}">
			<input name="btn_search" value="Suchen" class="btn_sch" type="button" onclick="fn_formSubmit()" />
		</div>
	</form>	
</body>
</html>