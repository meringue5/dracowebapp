<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>board</title>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath}/js/board/BoardGroupList.js"></script>

<!-- <link rel="stylesheet" href="js/dynatree/ui.dynatree.css" id="skinSheet"/> -->
<!-- <script src="js/dynatree/jquery.dynatree.js"></script> -->
</head>
<body>
	<div style="width:270px; height:400px; overflow:auto; display: inline-block;" >
    	<div id="tree">
			<ul id="treeData" style="display: none;">
				
			</ul>
		</div>
	</div>

	<div style="width: 500px; padding-left: 10px; display: inline-block;vertical-align:top">
		<div style="text-align: right;"><a onclick="fn_groupNew()" href="#">추가</a></div>
		<input name="bgno" id="bgno" type="hidden" value=""> 
		<table style="border: 1px solid; width: 100%; height: 160px">
			<colgroup>
				<col width="30%">
				<col width="70%">
			</colgroup>
 	 		<tbody>
			<tr>
	 			<th>그룹명</th>
	 			<td> 
	 				<input name="bgname" id="bgname" style="width: 300px;" type="text" maxlength="100" value="">
	 			</td>
 			</tr>
 			<tr>
				<th>사용여부</th>
				<td>
					<input name="bgused" id="bgusedY" type="radio" checked="checked" value="Y"><label for="bgusedY">사용</label>
					<input name="bgused" id="bgusedN" type="radio" value="N"><label for="bgusedN">사용중지</label>
				</td>
			</tr>
 			<tr>
	 			<th>등록가능</th>
	 			<td>
					<input name="bgreadonly" id="bgreadonlyN" type="radio" checked="checked" value="N"><label for="bgreadonlyN">사용</label>
					<input name="bgreadonly" id="bgreadonlyY" type="radio" value="Y"><label for="bgreadonlyY">사용안함</label>
				</td>
 			</tr>
 			<tr>
	 			<th>댓글</th>
	 			<td>
					<input name="bgreply" id="bgreplyY" type="radio" checked="checked" value="Y"><label for="bgreplyY">사용</label>
					<input name="bgreply" id="bgreplyN" type="radio" value="N"><label for="bgreplyN">사용안함</label>
				</td>
 			</tr>
		 </tbody>
		 </table>
		<div style="text-align: right;">
			<a onclick="fn_groupSave()" href="#">저장</a>
			<a onclick="fn_groupDelete()" href="#">삭제</a>
        </div>
	</div>	
</body>
</html>