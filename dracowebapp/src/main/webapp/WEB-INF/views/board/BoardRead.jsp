<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>board</title>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board/BoardCommon.css" />
<script src="${pageContext.request.contextPath}/js/board/BoardRead.js"></script>
</head>
<body>
	<a href="boardList?bgno=<c:out value="${boardInfo.bgno}"/>" class="crimsonBtn">To the list</a>
	<h1><c:out value="${bgInfo.bgname}"/></h1>				

		<table class="shadowedBox">
<%-- 			<caption>Board</caption> --%>
			<colgroup>
				<col width='15%' />
				<col width='*%' />
			</colgroup>
			<tbody>
				<tr>
					<td>Author</td> 
					<td><c:out value="${boardInfo.brdwriter}"/></td> 
				</tr>
				<tr>
					<td>Title</td> 
					<td><c:out value="${boardInfo.brdtitle}"/></td>  
				</tr>
				<tr>
					<td>Content</td> 
					<td><c:out value="${boardInfo.brdmemo}" escapeXml="false"/></td> 
				</tr>
				<tr>
					<td>Attachment</td> 
					<td>
						<c:forEach var="listview" items="${listview}" varStatus="status">	
            				<a href="/fileDownload?filename=<c:out value="${listview.filename}"/>&downname=<c:out value="${listview.realname }"/>"> 							 
							<c:out value="${listview.filename}"/></a> <c:out value="${listview.size2String()}"/><br/>
						</c:forEach>					
					</td> 
				</tr>
			</tbody>
		</table>    
		<a href="boardDelete?bgno=<c:out value="${boardInfo.bgno}"/>&brdno=<c:out value="${boardInfo.brdno}"/>" class="crimsonBtn">Remove</a>
		<a href="boardForm?brdno=<c:out value="${boardInfo.brdno}"/>" class="crimsonBtn">Modify</a>
		<p>&nbsp;</p>
		
		<c:if test="${bgInfo.bgreply=='Y'}">
			<div style="border: 1px solid; width: 600px; padding: 5px">
				<form id="form1" name="form1">
					<input type="hidden" id="brdno1" name="brdno" value="<c:out value="${boardInfo.brdno}"/>"> 
					commenter: <input type="text" id="rewriter1" name="rewriter" size="20" maxlength="20"> <br/>
					<textarea id="rememo1" name="rememo" rows="3" cols="60" maxlength="500" placeholder="Comment here"></textarea>
					<a href="#" onclick="fn_formSubmit()" class="crimsonBtn">Save</a>
				</form>
			</div>
		</c:if>
				
		<div id="replyList"> 
			<c:forEach var="replylist" items="${replylist}" varStatus="status">
				<div id="replyItem<c:out value="${replylist.reno}"/>"
							style="border: 1px solid gray; width: 600px; padding: 5px; margin-top: 5px; margin-left: <c:out value="${20*replylist.redepth}"/>px; display: inline-block">	
					<c:out value="${replylist.rewriter}"/> <c:out value="${replylist.redate}"/>
					<a href="#" onclick="fn_replyDelete('<c:out value="${replylist.reno}"/>')">Remove</a>
					<a href="#" onclick="fn_replyUpdate('<c:out value="${replylist.reno}"/>')">Modify</a>
					<a href="#" onclick="fn_replyReply('<c:out value="${replylist.reno}"/>')">Leave a comment</a>
					<br/>
					<div id="reply<c:out value="${replylist.reno}"/>"><c:out value="${replylist.rememo}"/></div>
				</div><br/>
			</c:forEach>
		</div>

		<div id="replyDiv" style="width: 99%; display:none">
			<form id="form2" name="form2" action="boardReplySave" method="post">
				<input type="hidden" id="brdno2" name="brdno" value="<c:out value="${boardInfo.brdno}"/>"> 
				<input type="hidden" id="reno2" name="reno"> 
				<textarea id="rememo2" name="rememo" rows="3" cols="60" maxlength="500"></textarea>
				<a href="#" onclick="fn_replyUpdateSave()" class="crimsonBtn">Save</a>
				<a href="#" onclick="fn_replyUpdateCancel()" class="crimsonBtn">Cancel</a>
			</form>
		</div>
		
		<div id="replyDialog" style="width: 99%; display:none">
			<form id="form3" name="form3" action="boardReplySave" method="post">
				<input type="hidden" id="brdno3" name="brdno" value="<c:out value="${boardInfo.brdno}"/>"> 
				<input type="hidden" id="reno3" name="reno"> 
				<input type="hidden" id="reparent3" name="reparent"> 
				작성자: <input type="text" id="rewriter3" name="rewriter" size="20" maxlength="20"> <br/>
				<textarea id="rememo3" name="rememo" rows="3" cols="60" maxlength="500"></textarea>
				<a href="#" onclick="fn_replyReplySave()">Save</a>
				<a href="#" onclick="fn_replyReplyCancel()">Cancel</a>
			</form>
		</div>							
</body>
</html>