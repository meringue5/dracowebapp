/**
 * 
 */

function chkInputValue(id, msg){
	if ( $.trim($(id).val()) == "") {
		alert("Input "+msg);
		$(id).focus();
		return false;
	} 
	return true;
}
function fn_formSubmit(){
	if ( ! chkInputValue("#rewriter1", "author")) return;
	if ( ! chkInputValue("#rememo1", "content")) return;
	
	var formData = $("#form1").serialize();
	$.ajax({
		url: "boardReplySave", 
		type:"post", 
		data : formData,
		success: function(result){ 
			if (result!=="") {
				$("#rewriter1").val("");
				$("#rememo1").val("");
				$("#replyList").append(result);
				alert("Saved");
			} else{
				alert("Failed due to server error");
			}
		}
	})		
}
function fn_replyDelete(reno){
	if (!confirm("Remove?")) {
		return;
	}
	$.ajax({
		url: "boardReplyDelete",
		type:"post", 
		data: {"reno": reno},
		success: function(result){
			if (result=="OK") {
				$("#replyItem"+reno).remove();
				alert("Removed");
			} else{
				alert("Cannot removed due to its comments");
			}
		}
	})
}
var updateReno = updateRememo = null;
function fn_replyUpdate(reno){
	hideDiv("replyDialog");
	
	$("#replyDiv").show();
	
	if (updateReno) {
		$("#replyDiv").appendTo(document.body);
		$("#reply"+updateReno).text(updateRememo);
	} 
	
	$("#reno2").val(reno);
	$("#rememo2").val($("#reply"+reno).text());
	$("#reply"+reno).text("");
	$("#replyDiv").appendTo($("#reply"+reno));
	$("#rememo2").focus();
	updateReno   = reno;
	updateRememo = $("#rememo2").val();
} 
function fn_replyUpdateSave(){
	if ( ! chkInputValue("#rememo2", "content")) return;
	
	var formData = $("#form2").serialize();
	$.ajax({
		url: "boardReplySave", 
		type:"post", 
		data : formData,
		success: function(result){
			if (result!=="") {
				$("#reply"+updateReno).text($("#rememo2").val());
				$("#replyDiv").hide();
				alert("Saved");
			} else{
				alert("Cannot save due to server error");
			}
		}
	})
} 
function fn_replyUpdateCancel(){
	hideDiv("#replyDiv");
	
	$("#reply"+updateReno).text(updateRememo);
	updateReno = updateRememo = null;
} 
function hideDiv(id){
	$(id).hide();
	$(id).appendTo(document.body);
}
function fn_replyReply(reno){
	$("#replyDialog").show();
	
	if (updateReno) {
		fn_replyUpdateCancel();
	} 
	
	$("#reparent3").val(reno);
	$("#rememo3").val("");
	$("#replyDialog").appendTo($("#reply"+reno));
	$("#rewriter3").focus();
} 
function fn_replyReplyCancel(){
	hideDiv("#replyDialog");
} 
function fn_replyReplySave(){
	if ( ! chkInputValue("#rewriter3", "author")) return;
	if ( ! chkInputValue("#rememo3", "content")) return;
	var formData = $("#form3").serialize();
	$.ajax({
		url: "boardReplySave",
		type:"post", 
		data : formData,
		success: function(result){
			if (result!=="") {
				var parent = $("#reparent3").val();
				$("#replyItem"+parent).after(result);
				hideDiv("#replyDialog");
				alert("Saved");
				$("#rewriter3").val("");
				$("#rememo3").val("");
			} else{
				alert("Cannot save due to server error");
			}
		}
	})	
}