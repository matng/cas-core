<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/tablib.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<title></title>

<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/colorbox.css'/>" />
<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/fileinput.min.css'/>" />
<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/jquery.gritter.css'/>" />
<link rel="stylesheet" href="<c:url value='/bootstrap/assets/css/bootstrap-select.min.css'/>" />

<!-- ajax layout which only needs content area -->

<div class="row">
	<div class="col-xs-12">
		<div class="table-header">
			<c:if test="${create == true}">
			<button id="addBtn" class="btn btn-white btn-info btn-round">
					<i class="ace-icon fa fa-floppy-o bigger-120 blue"></i> 
					<fmt:message key="add" />
			</button>
			</c:if>
			
			<c:if test="${delete == true}">
			<button id="delBtn" class="btn btn-white btn-default btn-round">
				<i class="ace-icon fa fa-trash-o bigger-120 orange"></i> <fmt:message key="delete" />
			</button>
			</c:if>
		</div>
	
		<div>
			<table id="data-table"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th class="center"><label class="position-relative">
								<input type="checkbox" class="ace" /> <span class="lbl"></span>
						</label></th>
						<th><fmt:message key="title" /></th>
						<th><fmt:message key="menuid" /></th>						
						<th><fmt:message key="keyword" /></th>
						<th><fmt:message key="content" /></th>
						<th><fmt:message key="type" /></th>
						<th><fmt:message key="menu_seqno" /></th>
						<th><fmt:message key="addtime" /></th>
						<th><fmt:message key="ischeck" /></th>
						<th><fmt:message key="operate" /></th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
	</div>
	<div id="modal-table" class="modal fade" tabindex="-1">		
			<div class="modal-dialog" style="height: 60%; width: 80%;">
				<div class="modal-content">
					<div class="modal-header no-padding">
						<div class="table-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">
								<span class="white">&times;</span>
							</button>
							<span id="modal-title"><fmt:message key="op.success" /></span>
						</div>
					</div>

					<div id="modal-body" class="modal-body no-padding">
					<form id="MyForm" method="post" class="form-horizontal" role="form">
						<div class="form-group">
							<div class="col-sm-9">
								<input type="text" id="id" name="id" class="hidden" />
								<input type="text" id="type" name="type" class="hidden" />									
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="type"><fmt:message key="type" /></label>
							<div class="col-sm-9">
								<div class="clearfix">
									<select id="contentTypeSelect" class="selectpicker show-tick" data-size="5" data-style="btn btn-primary">
										<option value=1>公司动态</option>
										<option value=2>行业新闻</option>
										<option value=3>服务</option>
										<option value=4>新闻</option>
									</select>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="menuid"><fmt:message key="menuid" /></label>
							<div class="col-sm-9">
								<div class="clearfix">									
									<input type="text" id="menuid" name="menuid" class="col-xs-10 col-sm-5"/>
								</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right" 
							for="title"><fmt:message key="title" /></label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="title" name="title" class="col-xs-10 col-sm-5" />
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="keyword"><fmt:message key="keyword" /></label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="keyword" name="keyword"
									class="col-xs-10 col-sm-5" />
									</div>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="content"><fmt:message key="content" /></label>
							<div class="col-sm-9" style="width:70%">
								<div class="clearfix">
									<input type="text" id="content" name="content" class="hidden" />
									<div class="wysiwyg-editor" id="editor1"></div>
								</div>
							</div>
						</div>
						
						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="seqno"><fmt:message key="menu_seqno" /></label>
							<div class="col-sm-9">
								<div class="clearfix">
								<input type="text" id="seqno" name="seqno"
									class="col-xs-10 col-sm-5" />
									</div>
							</div>
						</div>

						<div class="space-4"></div>
						<div class="form-group">
							<label class="col-sm-3 control-label no-padding-right"
								for="ischeck"><fmt:message key="ischeck" /></label>
							<div class="col-sm-9">
								<div class="radio inline">
									<label>
										<input id="checked" name="ischeck" type="radio" class="ace" value="1"/>	
										<span class="lbl"><fmt:message key="enable" /></span>								
									</label>
									
								</div>
		
								<div class="radio inline">
									<label>
										<input id="unchecked" name="ischeck" type="radio" class="ace" value="0"/>
										<span class="lbl"><fmt:message key="disable" /></span>
									</label>
								</div>
							</div>
						</div>
						</form>
					</div>

					<div class="modal-footer no-margin-top">

						<button class="btn btn-sm" data-dismiss="modal">
							<i class="ace-icon fa fa-times"></i> <fmt:message key="cancel" />
						</button>

						<button id="saveBtn" class="btn btn-sm btn-primary">
							<i class="ace-icon fa fa-check"></i><fmt:message key="confirm" />
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
	</div>
	
<div id="modal-table-resource" class="modal fade" tabindex="-1">		
			<div class="modal-dialog" style="height: 100%; width: 60%; margin-top:200px">
				<div class="modal-content">
					<div class="modal-header no-padding">
						<div class="table-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">
								<span class="white">&times;</span>
							</button>
							<span id="modal-title-resource">资源库
							</span>
						</div>
					</div>

					<div id="modal-body" class="modal-body no-padding">
		
								<div class="row">
									<div class="col-sm-12">
										<div class="widget-box widget-color-blue2">
											<ul class="nav nav-tabs" role="tablist" id="maintab">
											  <li data-toggle="tab"><a href="#tabpane-resource"  onclick='showReource("image")'>图片</a></li>
											  <li class="active" data-toggle="tab"><a href="#tabpane-resource" onclick='showReource("flash")'>flash</a></li>
											  <li data-toggle="tab"><a href="#tabpane-resource" onclick='showReource("video")'>影音</a></li>
											  <li data-toggle="tab"><a href="#tabpane-resource" onclick='showReource("file")'>文件</a></li>
											</ul>
											
											<!-- Tab panes -->
											<div class="tab-content">
											  	<div class="tab-pane active" id="tabpane-resource">
											  		<div class="row">
														<div class="col-sm-3">
															<div id="resource-tree-div">
																<ul id="tree-resource" class="tree tree-folder-select" role="tree"></ul>
															</div>
														</div>
														
														<div class="col-sm-9">
															<div id="resource-table-div">
																<table id="resource-data-table"
																	class="table table-striped table-bordered table-hover">
																	<thead>
																		<tr>
																			<th class="center"><label class="position-relative">
																					<input type="checkbox" class="ace" /> <span class="lbl"></span>
																			</label></th>
																			<th><fmt:message key="restype" /></th>
																			<th><fmt:message key="fileurl" /></th>
																		</tr>
																	</thead>
																	<tbody></tbody>
																</table>
															</div>
															
															<div id="resource-colorbox-div">
																<ul class="ace-thumbnails clearfix" id="picture"></ul>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
					</div>
					<div class="modal-footer no-margin-top">

						<button class="btn btn-sm" data-dismiss="modal">
							<i class="ace-icon fa fa-times"></i> <fmt:message key="cancel" />
						</button>

						<button id="insertResourceBtn" class="btn btn-sm btn-primary">
							<i class="ace-icon fa fa-check"></i><fmt:message key="confirm" />
						</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
	</div>
</div><!-- /.row -->

<!-- page specific plugin scripts -->
<script type="text/javascript">
$(function(){
	$('.selectpicker').selectpicker();
	$('#contentTypeSelect').selectpicker('val', 1);
	$('#contentTypeSelect').selectpicker('refresh');
});
var validator = $("#MyForm").validate({
	errorElement: 'div',
	errorClass: 'help-block',
	focusInvalid: false,
	ignore: "",
	rules: {
		title: {
			required: true,
			maxlength:300
		},
		keyword: {
			required: true,
			maxlength:400
		},
		seqno: {
			required: true,
			number: true
		},		
		ischeck: {
			required: true
		}
	},

	messages: {
		title: {
			required: "不能为空.",
			maxlength:"标题长度不能超过300个字符!"
		},
		keyword: {
			required:"不能为空.",
			maxlength:"关键字长度不能超过400个字符!"
		},
		seqno: {
			required: "不能为空.",
			number:"只能为数字!"
		},
		ischeck: "请选择状态。"
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

//初始化弹出表格
$('maintab').tab();
var globalGroupID = null;
var GlobleResourceType = 2;
function showReource(tabid)
{
	//alert(tabid);
	if (tabid == 'image')
	{
		$('#resource-table-div').show();
		$('#resource-colorbox-div').hide();
		globalGroupID = null;
		GlobleResourceType = 1;
		//getGalleryDate(globalGroupID);
	}
	else if (tabid == 'flash')
	{
		$('#resource-colorbox-div').hide();
		$('#resource-table-div').show();
		globalGroupID = null;
		GlobleResourceType = 2;
	}
	else if (tabid == 'video')
	{
		$('#resource-colorbox-div').hide();
		$('#resource-table-div').show();
		globalGroupID = null;
		GlobleResourceType = 3;
	}
	else if (tabid == 'file')
	{
		$('#resource-colorbox-div').hide();
		$('#resource-table-div').show();
		globalGroupID = null;
		GlobleResourceType = 4;
	}
	else
	{
		GlobleResourceType = null;
	}
	
	$('#resource-tree-div').html('');
	$('#resource-tree-div').append('<ul id="tree-resource" class="tree tree-folder-select" role="tree"></ul>');
	
	$('#tree-resource').ace_tree({
		'dataSource': remoteSource_Resource, 
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
	
	//重新加载表格数据
	oResourceTable.fnDraw();
	return false;
}

//插入资源
$('#insertResourceBtn').click(insertResource);
function insertResource()
{
	//alert(GlobleResourceType);
	var ids = fnGetIDs('#resource-data-table');
	if (ids.length > 0)
	{
		var url = "<c:url value='/res/insert'/>";		
		var json = {"idList":ids};
		fnAjaxPost(url,JSON.stringify(json),function(res){
			var obj = JSON.parse(JSON.stringify(res));
			for (var i=0; i < obj.length;i++)
			{
				switch (obj[i].restype)
				{
				case 1:
					{
						var htm = '<img src=<%=path%>'+obj[i].fileurl+'>';
						$('#editor1').append(htm);
					}

					break;
				case 2:
					{
						var srcFile = '<%=path%>'+obj[i].fileurl;
						var html = '<embed src='+srcFile+' width="600" height="300" wmode="transparent" autostart="false" loop="false" />';

					   // alert(html);
							
						$('#editor1').append(html);
					}
					break;
				case 3:
					{
						var htm =   '<video id="example_video_1" class="video-js vjs-default-skin" controls="controls" preload="none" width="650" height="300" '+'poster=<c:url value="/html/vedio-js/vedioBg.jpg"/>'+
						         ' data-setup={example_option:true}>'+
						        '<source src=<%=path%>'+obj[i].fileurl+' type="video/mp4" /><p class="vjs-no-js">您的浏览器不支持html5</p></video>';
						$('#editor1').append(htm);
					}
					break;
				case 4:
					{
						var fileurl = obj[i].fileurl;
						var filename = fileurl.substr(fileurl.lastIndexOf("/")+1, fileurl.length);
						var htm = '<a href="<%=path%>/res/download/'+obj[i].id+'">'+filename+'</a>';
						$('#editor1').append(htm);
					}
					break;
				}
			}
			$("#modal-table-resource").modal('hide');
		});
	
	}else {
		errMsgBox('请选择一条资源操作!');
	}
}
//插入资源
function onclickFunc() {
	$("#modal-table-resource").modal('show');
}
//删除方法
function deleteObj(ids){	
	var url = "<c:url value='/cms/delete'/>";
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
$('#delBtn').click(batchDelete);
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
			//alert(idList);
			deleteObj(idList);
		}
	});
}


//预览功能
function previewData(data) {
	var url = "<c:url value='/cms/queryMenuUrlById'/>";
	var json = {"id":data};
	var params = "left=0,screenX=0,top=0,screenY=0,scrollbars=1";
	  if (window.screen) {
	     var ah = screen.availHeight - 30;
	     var aw = screen.availWidth - 10;
	     params += ",height=" + ah;
	     params += ",innerHeight=" + ah;
	     params += ",width=" + aw;
	     params += ",innerWidth=" + aw;
	     params += ",resizable"
	 } else {
		 params += ",resizable"; 
	 }
	fnAjaxPost(url,JSON.stringify(json),function(res){
		if (res) {
			var obj = JSON.parse(JSON.stringify(res));		
			var newUrl = '/'+obj.menuurl+'/'+data;
			
			var winUrl = '<%=path%>'+newUrl;
			//alert('winUrl='+winUrl);
			window.open(winUrl, 'newwindow', params);
		}		
	});	
}

//新增
$('#addBtn').click(addData);
function addData() {
	validator.resetForm();
	resetFrom();
	var menuid = ${menuid};
	//alert(menuid);
	$('#menuid').attr("disabled",false);
	$("#modal-title").html("新增!");
	$("#modal-table").modal("show");
	$("#modal-table").draggable({
	      handle: ".modal-header"
	  });
	
	$('#editor1').html('');
	$('#id').val(null);
	$('#menuid').val(menuid);
	
	$('#menuid').attr("disabled",true);	
}

//更新编辑
function updateObj(id) {
	
	// init data
	validator.resetForm();
	resetFrom();
	//clean editor
	$('#editor1').html('');
	// init data
	var idJson = {"id":id};
	var url = "<c:url value='/cms/queryById'/>";	
	fnAjaxPost(url,JSON.stringify(idJson),function(res){
		var obj = JSON.parse(JSON.stringify(res));		
		$('#menuid').attr("disabled",false);
		$("#menuid").val(obj.menuid);
		$("#title").val(obj.title);
		$("#contentTypeSelect").selectpicker('val',obj.type);
		$("#type").val(obj.type);
		$("#keyword").val(obj.keyword);
		//$("#htmlurl").val(obj.htmlurl);
		$("#seqno").val(obj.seqno);
		$('#editor1').append(html_decode(obj.content));
		if (obj.ischeck == 1)
		{
			$("#checked").attr("checked","checked");
		}
		else
		{
			$("#unchecked").attr("checked","checked");
		}
		$("#id").val(obj.id);
		$('#menuid').attr("disabled",true);
		$("#modal-title").html("编辑!");
		$("#modal-table").modal("show");
	});
}

//保存
$("#saveBtn").click(saveData);
function saveData() {
	if(!$('#MyForm').valid()) {
		return;
	}
	var contentTypeObj = document.getElementById("contentTypeSelect");
	var contentType = contentTypeObj.value;
	
	var id = $('#id').val();
	var formData = $("#MyForm").serializeJSON();
	formData.id = id;
	formData.type = contentType;
	formData.menuid = ${menuid};
	var editorContent = $('#editor1').html();
	//alert(editorContent);
	formData.content = html_encode(editorContent);
	var json = JSON.stringify(formData);
	var url = "<c:url value='/cms/save'/>";		
	
	fnAjaxPost(url,json,function(res){
		var obj = JSON.parse(JSON.stringify(res));		
		if (obj.success) {
			msgBox(obj.success);
			$("#modal-table").modal('hide');
			resetFrom();
			oTable.fnDraw();
	
		} else {
			errMsgBox(obj.error);
		}
	});
	
}

/**
* define datatables.
**/
var oTable;
var oResourceTable;
var scripts = ["<c:url value='/bootstrap/js/jquery.dataTables.min.js'/>",
               "<c:url value='/bootstrap/js/jquery.dataTables.bootstrap.min.js'/>"]
$('.page-content-area').ace_ajax('loadScripts', scripts, function() {

	jQuery(function($) {	
		var url = "<c:url value='/cms/listJson'/>";
		var colJson = [
						  {"mDataProp": "id", "sClass":"center", "bSortable": false,"bSearchable": false, "mRender": chkRender },
						  {"mDataProp": "title", "sClass":"center","bSortable": false,"bSearchable": false },
						  {"mDataProp": "menuid", "sClass":"center","bSortable":true},
						  {"mDataProp": "keyword", "sClass":"left","bSortable": true,"bSearchable": false },
						  {"mDataProp": "content", "sClass":"left","bSortable": true,"bSearchable": false, "mRender": contentRender },
						  {"mDataProp": "type", "sClass":"center","bSortable":true,"mRender": typeRender},
						  {"mDataProp": "seqno", "sClass":"left","bSortable": true,"bSearchable": false },
						  {"mDataProp": "addtime", "sClass":"left","bSortable": true,"bSearchable": false, "mRender": timeRender},							  
						  {"mDataProp": "ischeck", "sClass":"center","bSortable": false,"bSearchable": false, "mRender": checkRender },
						  {"mDataProp": "id", "sClass": "left","bSearchable": false,"bSortable": false,"mRender": opRender}
						];
		var callBackFunc = callAjaxFunc;		
		//初始化 datatable
		oTable = fnInitDataTables('#data-table',url,colJson,callBackFunc);

		function chkRender(data,type,full) {
			var html = '<label class="position-relative">';
			    html += '<input id="id" type="checkbox" class="ace" value="'+data+'"/>';
			    html += '<span class="lbl"></span>';
			    html += '</label>';
			return html;
		}
		
		
		function checkRender(data,type,full) {
			if (data == '1') {
				html = '已审核';
			} else {
				html = '未审核';
			}			
			return html;		
		}
		
		function contentRender(data,type,full) {
			if (data.length > 100)
			{
				return data.substr(0,100)+'...';
			}
			else
			{
				return data;
			}
		}
		
		function timeRender(data,type,full) {
			//var html = '';
			var date = new Date(data);
			var dateString = date.toLocaleString();
			return dateString;
		}
		
		function typeRender(data,type,full) {
			var info = null;
			switch(data)
			{
				case 1:
					info = "公司动态";break;
				case 2:
					info = "行业新闻";break;
				case 3:
					info = "服务";break;
				case 4:
					info = "产品";break;
				default: info = "数据出错";
			}
			return info;
		}
		
		//<a href="${link.siteurl}" target='_blank'></a>
		function opRender(data,type,full) {		
			//alert('full='+JSON.stringify(full));
			var html = "<div class=\'hidden-sm hidden-xs action-buttons\'>"
			<c:if test="${update == true}">
				+"<a title=\'更新\' class=\'green\' href=\'javascript:void(0);\' onclick=updateObj(\'"+data+"\') >"
				+"<i class=\'ace-icon fa fa-pencil bigger-130\'></i></a>"
			</c:if>
				+"<a title=\'预览\' class=\'green\' href=\'javascript:void(0);\'; onclick=previewData(\'"+data+"\')>"
				+"<i class=\'ace-icon fa fa-eye bigger-130\'></i></a>"
			<c:if test="${delete == true}">
				+"<a class=\'red\' href=\'javascript:void(0);\' onclick=delOne(\'"+data+"\');>"
				+"<i class=\'ace-icon fa fa-trash-o bigger-130\'></i></a>"
			</c:if>
				+"</div>"
			return html;		
		}
		
		function statusRender(data,type,full) {
			var html = '';
			//alert(data);
			if (data == '1') {
				html = '<span class="label label-sm label-success">生效</span>';
			} else {
				html = '<span class="label label-sm label-warning">禁用</span>';
			}			
			return html;		
		}
		
		//回调函数
		function callAjaxFunc( sSource, aoData, fnCallback ) {
			var menuid = ${menuid};
			//alert(type);
			aoData.push({"name": "sortCol", "value": getDataTablesColumns(colJson) });
		    //alert(JSON.stringify(aoData)); 
		    var url = sSource;
		    var json = { 'aoData': JSON.stringify(aoData),"menuid": menuid };
		    fnAjaxGet(url,json,function(resp) {
		    	//alert(JSON.stringify(resp));
				fnCallback(resp);
			});		    
		}
		
		
		var resourceUrl = "<c:url value='/res/listJson'/>";
		var resourceColJson = [
						  {"mDataProp": "id", "sClass":"center", "bSortable": false,"bSearchable": false, "mRender": chkRender },
						  {"mDataProp": "restype", "sClass":"center","bSortable":true, "mRender": resourceTypeRender},
						  {"mDataProp": "fileurl", "sClass":"center","bSortable": false,"bSearchable": false },
						];		
		//初始化 datatables
		var resourceCallBackFunc = resourceCallAjaxFunc;
		oResourceTable = fnInitDataTables('#resource-data-table',resourceUrl,resourceColJson,resourceCallBackFunc);
		
		function chkRender(data,type,full) {
			var html = '<label class="position-relative">';
			    html += '<input id="id" type="checkbox" class="ace" value="'+data+'"/>';
			    html += '<span class="lbl"></span>';
			    html += '</label>';
			return html;
		}
		
		function resourceTypeRender(data,type,full) {
			var info = null;
			switch(data)
			{
				case 1:
					info = "图片";break;
				case 2:
					info = "flash";break;
				case 3:
					info = "影音";break;
				case 4:
					info = "附件";break;
				default: info = "数据出错";
			}
			return info;
		}
		
		//回调函数
		function resourceCallAjaxFunc( sSource, aoData, fnCallback ) {
			aoData.push({"name": "sortCol", "value": getDataTablesColumns(colJson) }); 
		    var url = sSource;
		    //alert(globalGroupID);
		    var json = { 'aoData': JSON.stringify(aoData),"restype": GlobleResourceType, "groupid":globalGroupID};
		    fnAjaxGet(url,json,function(resp) {
		    	//alert(JSON.stringify(resp));
				fnCallback(resp);
			});	
		}
				
	
	})
});


//init editors
var editorScripts = ["<c:url value='/bootstrap/assets/js/bootstrap-wysiwyg.js'/>",
               "<c:url value='/bootstrap/assets/js/jquery-ui.custom.js'/>",
               "<c:url value='/bootstrap/assets/js/jquery.ui.touch-punch.js'/>",
               "<c:url value='/bootstrap/assets/js/jquery.hotkeys.js'/>",	               
               "<c:url value='/bootstrap/assets/js/bootbox.js'/>",
               "<c:url value='/bootstrap/assets/js/fuelux/fuelux.tree.js'/>",
               "<c:url value='/bootstrap/assets/js/jquery.colorbox.js'/>"]

$('.page-content-area').ace_ajax('loadScripts', editorScripts, function() {

	 jQuery(function($){
		 
		//初始化colorbox
		var $overflow = '';
		colorbox_params = {
			rel: 'colorbox',
			reposition: true,
			scalePhotos:false,
			scrolling:false,
			previous:'<i class="ace-icon fa fa-arrow-left"></i>',
			next:'<i class="ace-icon fa fa-arrow-right"></i>',
			close:'&times;',
			current:'{current} of {total}',
			maxWidth:'50%',
			maxHeight:'50%',
			onOpen:function(){
				$overflow = document.body.style.overflow;
				document.body.style.overflow = 'hidden';
			},
			onClosed:function(){
				document.body.style.overflow = $overflow;
			},
			onComplete:function(){
				$.colorbox.resize();
			}
		};

		$('.ace-thumbnails [data-rel="colorbox"]').colorbox(colorbox_params);
		$("#cboxLoadingGraphic").html("<i class='ace-icon fa fa-spinner orange fa-spin'></i>");//let's add a custom loading icon
	
	
		$(document).one('ajaxloadstart.page', function(e) {
			$('#colorbox, #cboxOverlay').remove();
	   	});

		//初始化editor
		$('#editor1').ace_wysiwyg({
			toolbar:
			[
				'font',
				null,
				'fontSize',
				null,
				'foreColor',
				null,
				{name:'bold', className:'btn-info'},
				{name:'italic', className:'btn-info'},
				{name:'strikethrough', className:'btn-info'},
				{name:'underline', className:'btn-info'},
				null,
				{name:'insertunorderedlist', className:'btn-success'},
				{name:'insertorderedlist', className:'btn-success'},
				{name:'outdent', className:'btn-purple'},
				{name:'indent', className:'btn-purple'},
				null,
				{name:'justifyleft', className:'btn-primary'},
				{name:'justifycenter', className:'btn-primary'},
				{name:'justifyright', className:'btn-primary'},
				{name:'justifyfull', className:'btn-inverse'},
				null,
				{name:'createLink', className:'btn-pink'},
				{name:'unlink', className:'btn-pink'},
				null,
				{name:'insertImage', className:'btn-success',button_text:'onclickFunc()'},
				null,
				{name:'undo', className:'btn-grey'},
				{name:'redo', className:'btn-grey'},
				'viewSource'
			],
			'wysiwyg': {
				fileUploadError: showErrorAlert
			}
		}).prev().addClass('wysiwyg-style3');
		
		
		function showErrorAlert (reason, detail) {
				var msg='';
				if (reason==='unsupported-file-type') { 
					msg = "Unsupported format " +detail; 
				}else {
					//console.log("error uploading file", reason, detail);
				}
				
				$('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>'+ 
				 '<strong>File upload error</strong> '+msg+' </div>').prependTo('#alerts');
			}
	});
});


var remoteSource_Resource = function(options, callback) {	
	var parent_id = null
	if( !('text' in options || 'type' in options) ){
		parent_id = 0;//load first level data
	}
	else if('type' in options && options['type'] == 'folder') {//it has children
		if('additionalParameters' in options && 'children' in options.additionalParameters)
			parent_id = options.additionalParameters['id']
	}	
	
	var url = "<c:url value='/res/treeListJson'/>";
	var json = {'id':parent_id,'grouptype':GlobleResourceType};		
	
	////alert(JSON.stringify(json));
	
	if(parent_id !== null) {
		fnAjaxPost(url,JSON.stringify(json),function(resp){
			//alert(JSON.stringify(resp));
			callback({ data: resp })
		});	
	}			
		
}

var treeScripts = ["<c:url value='/bootstrap/assets/js/fuelux/fuelux.tree.js'/>"];
$('.page-content-area').ace_ajax('loadScripts', treeScripts, function() {

	jQuery(function($){
			$('#tree-resource').ace_tree({
				'dataSource': remoteSource_Resource, //sampleData['dataSource1'],
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
	
			$('#tree-resource').on('selected.fu.tree', function(e) {
				var items = $('#tree-resource').tree('selectedItems');
				var json = JSON.stringify(items);
				////alert(json);
				
				var item = null;
				for(var i in items) {
					item = items[i];
					//pid = item.id;
				}
				
				if (item != null)
				{
					if (selectedId != item.id)
					{
						//alert(item.id);
						globalGroupID = item.id;
						if (item.grouptype == 1)
						{
							getGalleryDate(globalGroupID);
						}
						else
						{
							selectedId = item.id;
							oResourceTable.fnDraw();
						}
						
					}
				}
				else
				{
					//alert('123');
				}
				
			});
			
			$('#tree-resource').on('deselected.fu.tree', function(e) {
				var items = $('#tree-resource').tree('selectedItems');
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
					if (item.grouptype == 1)
					{
						getGalleryDate(globalGroupID);
					}
					else
					{
						selectedId = null;
						oResourceTable.fnDraw();
					}
				}
				
			});
		
		});
			
	});
</script>
