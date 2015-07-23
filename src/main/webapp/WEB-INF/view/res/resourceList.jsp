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
<link rel="stylesheet"
	href="<c:url value='/bootstrap/assets/css/jquery.gritter.css'/>" />

<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->

		<!-- #section:plugins/fuelux.treeview -->
		<div class="row">
			<div class="col-sm-2">
				<div class="widget-box widget-color-blue">
					<div class="widget-header">
					</div>
					<div class="widget-body">
						<div class="widget-main padding-10">
							<ul id="tree1" class="tree tree-folder-select" role="tree"></ul>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-sm-10">
				<div class="table-header">
						<c:if test="${type == 1}">
					       	<button id="storageBtn" class="btn btn-white btn-info btn-round">
									<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
									入库
							</button>
							<button id="removeBtn" class="btn btn-white btn-default btn-round">
								<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="remove" />
							</button>
						</c:if>
						
						<c:if test="${type == 0}">
					       	<button id="outStorageBtn" class="btn btn-white btn-info btn-round">
									<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i>
									出库
							</button>
							<button id="removeBtn" class="btn btn-white btn-default btn-round">
								<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="remove" />
							</button>
						</c:if>
				</div>
				
				<div id="show-data-table">
					<table id="data-table"
						class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th class="center"><label class="position-relative">
										<input type="checkbox" class="ace" /> <span class="lbl"></span>
								</label></th>
								<th>物资名称</th>
								<th>类别</th>
								<th>单价</th>
								<th>数量</th>
								<th>合计</th>
								<th>录入时间</th>
								<th>修改时间</th>
								<th>描述</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
			</div>
		</div>


		<div id="modal-storage-form" class="modal fade" tabindex="-1">		
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
						<form id="inForm" method="post" class="form-horizontal" role="form">
							<div class="form-group">
								<div class="col-sm-9">
									<input type="text" id="id" name="id"
										class="hidden" />
								</div>
							</div>
													
							
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right"
									for="rolename">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称</label>
								<div class="col-sm-9">
									<div class="clearfix">
										<input type="text" id="inResName" name="resName" readonly="readonly"
										class="col-xs-10 col-sm-5" />
									</div>
								</div>
							</div>
	
							<div class="space-4"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right"
									for="rolename">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价</label>
								<div class="col-sm-9">
									<div class="clearfix">
										<input type="text" id="inUnitPrice" name="unitPrice" onkeyup="countTotal()"
											class="col-xs-10 col-sm-5" />
									</div>
								</div>
							</div>
							
							<div class="space-4"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right"
									for="rolename">数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量</label>
								<div class="col-sm-9">
									<div class="clearfix">
										<input type="text" id="inNumber" name="number" onkeyup="countTotal()"
											class="col-xs-10 col-sm-5" />
									</div>
								</div>
							</div>
							
							<div class="space-4"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right"
									for="rolename">合&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;计</label>
								<div class="col-sm-9">
									<div class="clearfix">
										<input type="text" id="inTotalPrice" name="totalPrice" readonly="readonly"
											class="col-xs-10 col-sm-5" />
									</div>
								</div>
							</div>
							
							<div class="space-4"></div>
							<div class="form-group">
								<label class="col-sm-3 control-label no-padding-right"
									for="rolename">描&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;述</label>
								<div class="col-sm-9">
									<div class="clearfix">
										<input type="text" id="inInfo" name="info"
											class="col-xs-10 col-sm-5" />
									</div>
								</div>
							</div>
						</form>
					</div>
					
					<div class="modal-footer no-margin-top">
						<button class="btn btn-sm" data-dismiss="modal">
							<i class="ace-icon fa fa-times"></i> 取消
						</button>
						<button id="inSaveBtn" class="btn btn-sm btn-primary">
							<i class="ace-icon fa fa-check"></i> 确定
						</button>
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
	$('.selectpicker').selectpicker();
});

var validator = $("#inForm").validate({
	errorElement: 'div',
	errorClass: 'help-block',
	focusInvalid: false,
	ignore: "",
	rules: {
		unitPrice: {
			required: true,
			number:true
		},
		number: {
			required: true,
			number:true
		}
	},

	messages: {
		unitPrice: {
			required: "不能为空.",
			number: "非法字符，请输入数字."
		},
		number: {
			required: "不能为空.",
			number: "非法字符，请输入数字."
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


var globalResID = null;

//编辑
$("#storageBtn").click(storage);
function storage() {
	
	var items = $('#tree1').tree('selectedItems');
	var item = items[0];
	if(item != null && item.type == 'item'){
		globalResID = item.id;
		$('#inResName').val(item.text);
		$('#modal-storage-form').modal('show');
	}else{
		errMsgBox("请选择物资类型!");
	}
	
}

//计算合计
function countTotal(){
	var price = $('#inUnitPrice').val()==null || $('#inUnitPrice').val()==''?'1':$('#inUnitPrice').val();
	var number =  $('#inNumber').val()==null && $('#inNumber').val()==''?'1':$('#inNumber').val();
	var total = parseFloat(price)*parseFloat(number);
	$('#inTotalPrice').val(total.toFixed(2));
}

//入库
$("#inSaveBtn").click(inSaveData);
function inSaveData() {
	if(!$('#inForm').valid()) {
		return;
	}
	var pid = $('#parentgroupid').val();
	var formData = $("#inForm").serializeJSON();
	formData.restype = globalResID;
	formData.groupid = 1;

	var json = JSON.stringify(formData);
	
	var url = "<c:url value='/res/insert'/>";		
	
	fnAjaxPost(url,json,function(res){
		var obj = JSON.parse(JSON.stringify(res));		
		if (obj.success) {
			msgBox(obj.success);
			$("#modal-storage-form").modal('hide');
			oTable.fnDraw();
			resetFrom();
		} else {
			errMsgBox(obj.error);
		}
	});
	
}

//更新编辑
function updateObj(json) {
	$("#modal-title").html("编辑!");
	var obj = JSON.parse(decodeJson(json));
	$("#rolename").val(obj.rolename);
	$("#roledesc").val(obj.roledesc);
	var isenable = document.getElementsByName("isenable");
	for(var i=0;i<isenable.length;i++)
		{
			if(isenable.item(i).value==obj.isenable)
				{
				isenable.item(i).checked=true;
				}
		}
}
function delRow(ids) {
	bootbox.confirm("确定删除吗? ", function(result) {
		if(result) {
			var idList = new Array();
			idList.push(ids);
			deleteObj(idList);	
		}
	});
}
//删除方法
function deleteObj(ids){	
	var url = "<c:url value='/res/delete'/>";
	var json = {"idList":ids};
	fnAjaxPost(url,JSON.stringify(json),function(res){
		
		var obj = JSON.parse(JSON.stringify(res));		
		if (obj.success) {
			msgBox(obj.success);
			oTable.fnDraw();	
		} else {
			errMsgBox(obj.error);
		}
		
	});
}

//批量删除
$('#removeBtn').click(batchDelete);
function batchDelete() {
	var ids = fnGetIDs('#data-table');
	if (ids.length > 0) {
		bootbox.confirm("确定删除吗? ", function(result) {
			if(result) {
				deleteObj(ids);
			}
		});
		 	
	} else {
        errMsgBox('请选择一条记录操作。');
    }
}

//删除一条
function delOne(ids) {
	bootbox.confirm("确定删除吗? ", function(result) {
		if(result) {
			var idList = new Array();
			idList.push(ids);
			deleteObj(idList);
		}
	});
}

	
	/**
	* define datatables and tree.
	**/
	
	//*
	var oTable;
	var scripts = ["<c:url value='/bootstrap/js/jquery.dataTables.min.js'/>",
	               "<c:url value='/bootstrap/js/jquery.dataTables.bootstrap.min.js'/>",
	               "<c:url value='/bootstrap/assets/js/fuelux/fuelux.tree.js'/>"]
	$('.page-content-area').ace_ajax('loadScripts', scripts, function() {

		jQuery(function($) {
			//var dataUrlStr = $('#dataUrlStr').val();
			var url = "<c:url value='/res/listJson'/>";
			var colJson = [
							  {"mDataProp": "id", "sClass":"center", "bSortable": false,"bSearchable": false, "mRender": chkRender },
							  {"mDataProp": "resName", "sClass":"center","bSortable":true,"bSearchable": true},
							  {"mDataProp": "groupid", "sClass":"center","bSortable": false,"bSearchable": false,"mRender": typeRender },
							  {"mDataProp": "unitPrice", "sClass":"center","bSortable": false,"bSearchable": false },
							  {"mDataProp": "number", "sClass":"center","bSortable": false,"bSearchable": false },
							  {"mDataProp": "totalPrice", "sClass":"center","bSortable": false,"bSearchable": false },
							  {"mDataProp": "createTime", "sClass":"center","bSortable": false,"bSearchable": false },
							  {"mDataProp": "updateTime", "sClass":"center","bSortable": false,"bSearchable": false},
							  {"mDataProp": "info", "sClass":"center","bSortable": false,"bSearchable": false },
							  {"mDataProp": "id", "sClass": "left","bSearchable": false,"bSortable": false,"mRender": opRender}
							];		
			//初始化 datatables
			var callBackFunc = callAjaxFunc;
			oTable = fnInitDataTables('#data-table',url,colJson,callBackFunc);
			
			function chkRender(data,type,full) {
				var html = '<label class="position-relative">';
				    html += '<input id="id" type="checkbox" class="ace" value="'+data+'"/>';
				    html += '<span class="lbl"></span>';
				    html += '</label>';
				return html;
			}

			function typeRender(data,type,full){
				var html = '';
				if (data == '0') {
					html = '<span class="label label-sm label-success">出库</span>';
				} else {
					html = '<span class="label label-sm label-warning">入库</span>';
				}			
				return html;
				
			}
			
			function opRender(data,type,full) {			
				var html = "<div class=\'hidden-sm hidden-xs action-buttons\'>"+
					"<a class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+encodeJson(JSON.stringify(full))+"\') data-toggle=\'modal\' data-target=\'#modal-table\'>"+
					"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"+
					"<a class=\'red\' href=\'javascript:void(0);\' onclick=delRow(\'"+data+"\');>"+
					"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"+
					"</div>";
					return html;
			}
			
			//回调函数
			function callAjaxFunc( sSource, aoData, fnCallback ) {
				var groupid = ${type};
				aoData.push({"name": "sortCol", "value": getDataTablesColumns(colJson) }); 
			    var url = sSource;
			    var json = { 'aoData': JSON.stringify(aoData),"restype": globalResID, "groupid":groupid};
			    fnAjaxGet(url,json,function(resp) {
					fnCallback(resp);
				});	
			}
			
			
			var remoteSource = function(options, callback) {	
				var parent_id = null
				if( !('text' in options || 'type' in options) ){
					parent_id = 0;//load first level data
				}
				else if('type' in options && options['type'] == 'folder') {//it has children
					if('additionalParameters' in options && 'children' in options.additionalParameters)
						parent_id = options.additionalParameters['id']
				}	
				
				var url = "<c:url value='/res/treeListJson'/>";
				var grouptype = ${type};
				var json = {'id':parent_id,'grouptype':grouptype};		
				
				
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
					//pid = item.id;
				}
				
				if (item != null)
				{
					if (selectedId != item.id)
					{
						selectedId = item.id;
						globalResID = item.id;
						oTable.fnDraw();
						//refreshDataTable(selectedId);
						
					}
				}
				else
				{
				}
				
			});
			
			$('#tree1').on('deselected.fu.tree', function(e) {
				var items = $('#tree1').tree('selectedItems');
				var json = JSON.stringify(items);
				
				var item = null;
				for(var i in items) {
					item = items[i];
				}
				
				if (item == null)
				{
					globalResID = null;
					oTable.fnDraw();
					selectedId = null;
				}
				
			});
					
		
		})
	});
	
	//*/
</script>
