<%@page import="java.io.Console"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<title>Resource list</title>
<link rel="stylesheet"
	href="<c:url value='/bootstrap/assets/css/bootstrap-select.min.css'/>" />
<link rel="stylesheet"
	href="<c:url value='/bootstrap/assets/css/fileinput.min.css'/>" />
<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/jquery.gritter.css'/>" />

<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->

		<!-- #section:plugins/fuelux.treeview -->
		<div class="row">
			<div class="col-sm-12">
				<div class="widget-box widget-color-blue2">
					<div class="widget-header">
					       	<button id="addNodeBtn" class="btn btn-white btn-info btn-round">
								<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
								<fmt:message key="add" />
							</button>
							<shiro:hasPermission name="flash:u">
							<button id="editNodeBtn" class="btn btn-white btn-default btn-round">
								<i class="ace-icon fa fa-pencil-square-o red2"></i> 编辑
							</button>
							</shiro:hasPermission>
							<button id="delNodeBtn" class="btn btn-white btn-default btn-round">
								<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="delete" />
							</button>
					</div>

					<div class="widget-body">
						<div class="widget-main padding-8">
							<div id="tree_div">
								<ul id="tree1" class="tree tree-folder-select" role="tree"></ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>

		<div id="modal-table-resource-group" class="modal fade" tabindex="-1">		
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header no-padding">
						<div class="table-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">
								<span class="white">&times;</span>
							</button>
							<span id="modal-title-resource-group">新增</span>
						</div>
					</div>

					<div id="modal-body" class="modal-body no-padding">
					<form id="MyResourceGroupForm" method="post" class="form-horizontal" role="form">
						<div class="form-group">
							<div class="col-sm-9">
								<input type="text" id="groupid" name="id" class="hidden" />
								<input type="text" id="parentgroupid" name="parentgroupid" class="hidden" />
								<input type="text" id="grouptype" name="grouptype" class="hidden" />
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="groupname">种类名称</label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="groupname" name="groupname" class="col-xs-10 col-sm-5"/>
								</div>
							</div>
						</div>
						
						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" 
							for="groupdesc">种类描述</label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="groupdesc" name="groupdesc" class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						</form>
					</div>

					<div class="modal-footer no-margin-top">

						<button class="btn btn-sm" data-dismiss="modal">
							<i class="ace-icon fa fa-times"></i> <fmt:message key="cancel" />
						</button>

						<button id="saveGroupBtn" class="btn btn-sm btn-primary">
							<i class="ace-icon fa fa-check"></i><fmt:message key="confirm" />
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->


		</div>


		<div id="modal-table" class="modal fade" tabindex="-1">		
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header no-padding">
						<div class="table-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">
								<span class="white">&times;</span>
							</button>
							<span id="modal-title">新增</span>
						</div>
					</div>

					<div id="modal-body" class="modal-body no-padding">
						<form id="MyResourceForm" method="post" class="form-horizontal" enctype="multipart/form-data">
							<div class="form-group">
								<div class="col-sm-9" style="width:100%">
									<div id="fileinput-div">
										<input id="upLoadInput" type="file" class="file" name="file" multiple data-preview-file-type="any" data-upload-url="<c:url value='/res/upload'/>">
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->


</div>
		<!-- PAGE CONTENT ENDS -->
	</div><!-- /.col -->
</div><!-- /.row -->

<!-- page specific plugin scripts -->
<script type="text/javascript">
$(function(){
	var validator = $("#MyResourceGroupForm").validate({
		errorElement: 'div',
		errorClass: 'help-block',
		focusInvalid: false,
		ignore: "",
		rules: {
			groupname: {
				required: true,
				maxlength:200
			},
			groupdesc: {
				required: true,
				maxlength:600
			}
		},
	
		messages: {
			groupname: {
				required: "不能为空.",
				maxlength:"名称不能超过200个字符！"
			},
			groupdesc: {
				required: "不能为空.",
				maxlength:"分组描述不能超过600个字符！"
			}
		},
		highlight: function (e) {
			$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
		},
	
		success: function (e) {
			$(e).closest('.form-group').removeClass('has-error');
			$(e).remove();
		},
		errorPlacement: function (error, element) {
			if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
				var controls = element.closest('div[class*="col-"]');
				if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
				else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
			}
			else error.insertAfter(element.parent());
		}
	
	});
});

var globalGroupID = null;
var remoteSource = null;
//编辑
$("#delNodeBtn").click(deleteSelectObj);
function deleteSelectObj() {

	var items = $('#tree1').tree('selectedItems');
	var json = JSON.stringify(items);
	////alert(json);
	
	var id = '';
	for(var i in items) {
		var item = items[i];
		id = item.id;
	}
	
	if (id != '')
	{
		bootbox.confirm("确定删除吗? ", function(result) {
			if(result) {
				var url = "<c:url value='/res/deleteResourceGroup'/>";
				var json = {"id":id};
				
				fnAjaxPost(url,JSON.stringify(json),function(res){
					var obj = JSON.parse(JSON.stringify(res));		
					if (obj.success) {
						msgBox(obj.success);
						refreshTreeItem();
					} else {
						errMsgBox(obj.error);
					}
				});				
			}
		});
	}
	else
	{
		errMsgBox('请选择一个编组结点!');
	}

}

//编辑
$("#editNodeBtn").click(updateSelectObj);
function updateSelectObj() {
	var items = $('#tree1').tree('selectedItems');
	var json = JSON.stringify(items);
	
	var item = null;
	for(var i in items) {
		item = items[i];
	}

	//只有根节点才需要选择模块
	if (item != null)
	{
		$('#groupid').val(item.id);
		$('#parentgroupid').val(item.parentgroupid);
		$('#groupdesc').val(item.groupdesc);
		$('#menuUrl').val(item.menuUrl);
		$('#groupname').val(item.groupname);
	}
	else
	{
		errMsgBox('请选择一个菜单结点!');
		return;
	}
	$("#modal-title-resource-group").html("编辑!");
	$('#modal-table-resource-group').modal('show');
}

//添加节点
$("#addNodeBtn").click(addGroupNode);
function addGroupNode() {
	$("#modal-title-resource-group").html("新增!");
	$('#modal-table-resource-group').modal('show');
	$('#groupdesc').val('');
	$('#groupname').val('');
	
	var items = $('#tree1').tree('selectedItems');
	var json = JSON.stringify(items);
	
	var item = null;
	for(var i in items) {
		item = items[i];
	}
	//只有根节点才需要选择模块
	if (item != null)
	{
		$('#parentgroupid').val(item.id);
		
	}
	else
	{
		$('#parentgroupid').val(0);
	}

}


function refreshTreeItem() {
		$('#tree_div').html('');
		$('#tree_div').html('<ul id="tree1" class="tree tree-folder-select" role="tree"></ul>');
		$('#tree1').ace_tree({
		   'dataSource': remoteSource,
		   'multiSelect': false,
		   'cacheItems': true,
		   'open-icon' : 'ace-icon tree-minus',
		   'close-icon' : 'ace-icon tree-plus',
		   'selectable' : true,
		   'selected-icon' : 'ace-icon fa fa-check',
		   'unselected-icon' : 'ace-icon fa fa-times',
		   'loadingHTML' : '<div class="tree-loading"><i class="ace-icon fa fa-refresh fa-spin blue"></i></div>',
		   'selectable' : true ,  
		   'folderSelect': true
		  });	 
}

//保存
$("#saveGroupBtn").click(saveGroupData);
function saveGroupData() {
	if(!$('#MyResourceGroupForm').valid()) {
		return;
	}
	var pid = $('#parentgroupid').val();
	var formData = $("#MyResourceGroupForm").serializeJSON();
	formData.groupType = 1;
	formData.parentgroupid = pid;

	var json = JSON.stringify(formData);
	var url = "<c:url value='/res/saveResourceGroup'/>";		
	
	fnAjaxPost(url,json,function(res){
		var obj = JSON.parse(JSON.stringify(res));		
		if (obj.success) {
			msgBox(obj.success);
			$("#modal-table-resource-group").modal('hide');
			resetFrom();
			refreshTreeItem();	
		} else {
			errMsgBox(obj.error);
		}
	});
	
}

	var scripts = ["<c:url value='/bootstrap/assets/js/fuelux/fuelux.tree.js'/>"]
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {
		
		remoteSource = function(options, callback) {	
			var parent_id = null
			if( !('text' in options || 'type' in options) ){
				parent_id = 0;//load first level data
			}
			else if('type' in options && options['type'] == 'folder') {//it has children
				if('additionalParameters' in options && 'children' in options.additionalParameters)
					parent_id = options.additionalParameters['id']
			}	
			
			var url = "<c:url value='/res/treeListJson'/>";
			var json = {'id':parent_id,'grouptype':1};		
			
			if(parent_id !== null) {
				fnAjaxPost(url,JSON.stringify(json),function(resp){
					callback({ data: resp })
				});	
			}			
				
		}
			$('#tree1').ace_tree({
				'dataSource': remoteSource, //sampleData['dataSource1'],
				'multiSelect': false,
				'cacheItems': true,
				'open-icon' : 'ace-icon tree-minus',
				'close-icon' : 'ace-icon tree-plus',
				'selectable' : true,
				'selected-icon' : 'ace-icon fa fa-check',
				'unselected-icon' : 'ace-icon fa fa-times',
				'loadingHTML' : '<div class="tree-loading"><i class="ace-icon fa fa-refresh fa-spin blue"></i></div>',
				'selectable' : true ,  
				'folderSelect': true
			});
			
			//避免关闭包结点时也刷新数据
			var selectedId = null;
		
			$('#tree1').on('selected.fu.tree', function(e) {
				var items = $('#tree1').tree('selectedItems');
				var json = JSON.stringify(items);
				
				var item = null;
				for(var i in items) {
					item = items[i];
				}
				
				if (item != null)
				{
					if (selectedId != item.id)
					{
						globalGroupID = item.id;
					}
				}
			});
			
			$('#tree1').on('deselected.fu.tree', function(e) {
				var items = $('#tree1').tree('selectedItems');
				var json = JSON.stringify(items);
				////alert(json);
				
				var item = null;
				for(var i in items) {
					item = items[i];
					//pid = item.id;
				}
				
				if (item == null)
				{
					globalGroupID = null;
					oTable.fnDraw();
					//refreshDataTable(null);
					selectedId = null;
				}
				
			});
					
		});	
</script>
