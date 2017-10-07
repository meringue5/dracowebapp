var selectedNode = null;
$(function(){
// 	$("#tree").dynatree({
// 		children: <c:out value="${treeStr}" escapeXml="false"/>,
// 		onActivate: TreenodeActivate
// 	});
// 	fn_groupNew();
});
function TreenodeActivate(node) {
	selectedNode = node;
	
    if (selectedNode==null || selectedNode.data.key==0) return;
    $.ajax({
    	url: "boardGroupRead", 
    	cache: false,
    	data: { bgno : selectedNode.data.key }    	
    }).done(receiveData);
}
function receiveData(data){
    $("#bgno").val(data.bgno);
    $("#bgname").val(data.bgname);
	$('input:radio[name="bgused"][value="' + data.bgused + '"]').prop('checked', true);
	$('input:radio[name="bgreadonly"][value="' + data.bgreadonly + '"]').prop('checked', true);
	$('input:radio[name="bgreply"][value="' + data.bgreply + '"]').prop('checked', true);
}
function fn_groupNew(){
    $("#bgno").val("");
    $("#bgname").val("");
	$('input:radio[name="bgused"][value="Y"]').prop('checked', true);
	$('input:radio[name="bgreadonly"][value="N"]').prop('checked', true);
	$('input:radio[name="bgreply"][value="Y"]').prop('checked', true);
}
function fn_groupDelete(value){
    if (selectedNode==null){
    	alert("삭제할 게시판을 선택해 주세요!");
    	return;
    }
    if (selectedNode.childList){
    	alert("하위 게시판이 있는 게시판은 삭제 할 수 없습니다.");
    	return;
    }
    
    if(!confirm("삭제하시겠습니까?")) return;
    $.ajax({
    	url: "boardGroupDelete",
    	cache: false,
    	data: { bgno : selectedNode.data.key }    	
    }).done(receiveData4Delete);
}
function receiveData4Delete(data){
	alert("삭제되었습니다!");
	selectedNode.remove();		
	selectedNode = null;
	fn_groupNew();
}
function fn_groupSave(){
	if($("#bgname").val() == ""){
		alert("게시판 이름을 입력해주세요.");
		return;
	}
	var pid=null;
    if (selectedNode!=null) pid=selectedNode.data.key;
    if (!confirm("저장하시겠습니까?")) return;
    $.ajax({
     	url: "boardGroupSave",
     	cache: false,
     	type: "POST",
     	data: { bgno:$("#bgno").val(), bgname:$("#bgname").val(), bgparent: pid,
     			bgused : $("input:radio[name=bgused]:checked").val(), 
     			bgreadonly : $("input:radio[name=bgreadonly]:checked").val(), 
     			bgreply : $("input:radio[name=bgreply]:checked").val()}    	
     }).done(receiveData4Save);
}
function receiveData4Save(data){
	if (selectedNode!==null && selectedNode.data.key===data.bgno) {
		selectedNode.data.title=data.bgname;
		selectedNode.render();
	} else {
		addNode(data.bgno, data.bgname);
	}
	
	alert("저장되었습니다.");
}
function addNode(nodeNo, nodeTitle){
	var node = $("#tree").dynatree("getActiveNode");
	if (!node) node = $("#tree").dynatree("getRoot");
	var childNode = node.addChild({key: nodeNo, title: nodeTitle});
	node.expand() ;
	node.data.isFolder=true;
	node.tree.redraw();
}