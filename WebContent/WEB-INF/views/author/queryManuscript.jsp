<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>用户列表</title>
	<link rel="stylesheet" type="text/css" href="../easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="../easyui/css/demo.css">
	<script type="text/javascript" src="../easyui/jquery.min.js"></script>
	<script type="text/javascript" src="../easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyui/js/validateExtends.js"></script>
	<script type="text/javascript">
	function submitForm(){
		/*$('#ff').form('submit');*/
		var value = $("#select option:selected").text();
		console.log(value);
 		if($("#file_upload").filebox("getValue") == ''){
  			$.messager.alert("消息提醒","请选择文件!","warning");
  			return;
  		}
		$("#fileForm").submit();
	}
 	function uploaded(e){
		var data = $("#file_target").contents().find("body pre").text();//获取frames框架内的文档的内容
		if(data == ''){
			return;
		}
		data = JSON.parse(data);
		if(data.type == "success"){
			$.messager.alert("消息提醒",data.msg,"info");
		}else{
			$.messager.alert("消息提醒",data.msg,"warning");
		}
 	}
 	//清空表单
	function clearForm(){
		$('#fileForm').form('clear');
	}
	
	$(function() {	
		var table;
		//datagrid初始化 
	    $('#dataList').datagrid({ 
	        title:'稿件信息列表', 
	        iconCls:'icon-more',//图标 
	        border: true, 
	        collapsible:false,//是否可折叠的 
	        fit: true,//自动大小 
	        method: "post",
	        url:"get_list?t="+new Date().getTime(),
	        idField:'id', 
	        singleSelect:false,//是否单选 
	        pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        sortName:'id',
	        sortOrder:'DESC',
	        remoteSort: true,
	        columns: [[  
	        	{field:'chk',checkbox: true,width:50},
 		        {field:'author_name',title:'作者姓名',width:60},
 		      	{field:'state',title:'稿件状态',width:60,styler:cellStyler},
 		     	{field:'submit_time',title:'投稿日期',width:150,sortable:true},
 		   		{field:'summary',title:'稿件摘要',width:300},
 		     	{field:'title',title:'稿件标题',width:300}
	 		]], 
	        toolbar: "#toolbar"
	    }); 
	    function cellStyler(value,row,index){
			if(row.state == "未通过"){
				return 'color:red;';
			}if(row.state == "已通过"){
				return 'color:#006400;';
			}if(row.state == "已发布"){
				return 'color:#006400;';
			}
		}
	    
	    //修改
	    $("#edit").click(function(){
	    	table = $("#editTable");
	    	var selectRows = $("#dataList").datagrid("getSelections");
        	if(selectRows.length != 1){
            	$.messager.alert("消息提醒", "请选择一条数据进行操作!", "warning");
            } else{
		    	$("#editDialog").dialog("open");
            }
	    });
	  	
	  	//编辑用户信息
	  	$("#editDialog").dialog({
	  		title: "修改稿件信息",
	    	width: 900,
	    	height: 500,
	    	iconCls: "icon-edit",
	    	modal: true,
	    	collapsible: false,
	    	minimizable: false,
	    	maximizable: false,
	    	draggable: true,
	    	closed: true,
	    	buttons: [
	    		{
					text:'提交',
					plain: true,
					iconCls:'icon-edit',
					handler:function(){
						var validate = $("#editForm").form("validate");
						if(!validate){
							$.messager.alert("消息提醒","请检查你输入的数据!","warning");
							return;
						} else{
							var data = $("#editForm").serialize();
							$.ajax({
								type: "post",
								url: "editOwnInfo",
								data: data,
								dataType:'json',
								success: function(data){
									if(data.type == "success"){
										$.messager.alert("消息提醒",data.msg,"info");
										//关闭窗口
										$("#editDialog").dialog("close");
										
										//重新刷新页面数据
							  			$('#dataList').datagrid("reload");
							  			$('#dataList').datagrid("uncheckAll");
										
									} else{
										$.messager.alert("消息提醒",data.msg,"warning");
										return;
									}
								}
							});
						}
					}
				},
			],
			onBeforeOpen: function(){
				var selectRow = $("#dataList").datagrid("getSelected");
				//设置值
				$("#edit-id").val(selectRow.manuscript_id);
				$("#author_name").textbox('setValue', selectRow.author_name);
				$("#title").textbox('setValue', selectRow.title);
				$("#summary").val(selectRow.summary);
			}
	  	});
	  	
	  	
	    //设置分页控件 
	    var p = $('#dataList').datagrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [10,20,30,50,100],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
	    }); 
	  	//搜索按钮
	  	$("#search-btn").click(function(){
	  		$('#dataList').datagrid('reload',{
	  			state:$("#select option:selected").text()
	  		});
	  	});
	});
	</script>
</head>
<body>
	<!-- 数据列表 -->
	<table id="dataList" cellspacing="0" cellpadding="0"> 
	    
	    
	</table> 
	<!-- 工具栏 -->
	<div id="toolbar">
			<tr><td><a id="edit" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a></td></tr>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<tr><td>请选择查询类别：</td>
			<td>
			<select id="select" name="state" style="width:120px;height:26px;cursor:pointer;">
					<option value="1">待审核</option>
	    			<option value="2">已通过</option>
	    			<option value="3">未通过</option>
	    			<option value="4">已发布</option>
		    </select>
		    </td>
		    <td>
		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a id="search-btn" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">搜索</a>
			</td>
			</tr>
	</div>
	<div id="editDialog" style="padding: 10px">
		<form id="fileForm" action="/onlineSubmit/author/edit_file" enctype="multipart/form-data" method="post" target="file_target">
			<table id="dataList" cellspacing="10" cellpadding="8">
				<tr><td><input type="hidden" name="manuscript_id" id="edit-id"></td></tr>
				<tr><td><label>作者姓名:</label> </td><td><input id="author_name" class="easyui-textbox" type="text" name="author_name" data-options="required:false"/></td></tr>
				<tr><td><label>稿件标题:</label> </td><td><input id="title" class="easyui-textbox" name="title" style="width:100%;height:32px"/></td></tr>
			    <tr><td>稿件摘要:</td><td><textarea id="summary" rows="8" cols="80" name="summary"></textarea></td></tr>
				<tr><td>添加附件:</td><td><input id="file_upload" class="easyui-filebox" name="manuscript_file" data-options="prompt:'选择一个文件'" style="width:500px;"/></td></tr>
			</table>
		</form>
		<div style="text-align:center;padding:5px;margin-right:500px;">
	   		<a href="javascript:void(0)" class="easyui-linkbutton" style="margin-right:30px;width:60px;" onclick="submitForm()">提交</a>
	   		<a href="javascript:void(0)" class="easyui-linkbutton" style="width:60px;" onclick="clearForm()">重置</a>
		</div>
		<!-- 提交表单处理iframe框架 -->
		<iframe id="file_target" name="file_target" onload="uploaded(this)" style="display:none;"></iframe> 
	</div>
</body>
</html>