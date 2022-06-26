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
	$(function() {	
		var table;
		var ids = [];
		//datagrid初始化 
	    $('#dataList').datagrid({ 
	        title:'稿件信息列表', 
	        iconCls:'icon-more',//图标 
	        border: true, 
	        collapsible:false,//是否可折叠的 
	        fit: true,//自动大小 
	        method: "post",
	        url:"get_list_by_NoDistribute?t="+new Date().getTime(),
	        idField:'manuscript_id', 
	        singleSelect:false,//是否单选 
	        pagination:true,//分页控件 
	        rownumbers:true,//行号 
	        sortName:'id',
	        sortOrder:'DESC',
	        remoteSort: true,
	        columns: [[  
	        	{field:'chk',checkbox: true,width:50},
 		        {field:'author_name',title:'作者姓名',width:60},
 		      	{field:'state',title:'稿件状态',width:60},
 		     	{field:'submit_time',title:'投稿日期',width:150,sortable:true},
 		   		{field:'summary',title:'稿件摘要',width:300},
 		     	{field:'title',title:'稿件标题',width:300},
 		     	{field:'remarks',title:'备注',width:100,styler:cellStyler}
	 		]], 
	        toolbar: "#toolbar"
	    }); 
		
	   /* $('#dataList_to_expert').datagrid({ 
 	        title:'专家列表', 
 	        iconCls:'icon-more',//图标 
 	        border: true, 
 	        collapsible:false,//是否可折叠的 
 	        fit: true,//自动大小 
 	        method: "post",
 	        url:"get_list_expert?t="+new Date().getTime(),
 	        idField:'id', 
 	        singleSelect:false,//是否单选 
 	        pagination:true,//分页控件 
 	        rownumbers:true,//行号 
 	        sortName:'id',
 	        sortOrder:'DESC',
 	        remoteSort: true,
 	        columns: [[  
 	        	{field:'chk',checkbox: true,width:50},
  		        {field:'name',title:'专家姓名',width:60},
  		      	{field:'sex',title:'专家性别',width:60},
  		     	{field:'phone_number',title:'电话',width:150,sortable:true},
  		   		{field:'address',title:'地址',width:300}
 	 		]], 
 	        toolbar: "#toolbar"
 	    }); */
		
		
	    function cellStyler(value,row,index){
			if(row.remarks == "已分配"){
				return 'color:green;';
			}
		}
	    //设置分页控件 
	    var p = $('#dataList').datagrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [10,20,30,50,100],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {pages} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
	    });
	    
	    //点击分配稿件
	    $("#distribute").click(function(){
	    	/*var selectRows = $("#dataList").datagrid("getSelections");
	    	
	       	if(selectRows.length != 1){
	           	$.messager.alert("消息提醒", "请选择一条数据进行操作!", "warning");
	           } else{
		    	$("#distributeDialog").dialog("open");
	           }
	       	*/
	       	var selectRows = $("#dataList").datagrid("getSelections");
	    	//console.log(selectRows);
        	var selectLength = selectRows.length;
        	if(selectLength == 0){
            	$.messager.alert("消息提醒", "请至少选择一条记录!", "warning");
            } else{
            	$(selectRows).each(function(i, row){
            		ids[i] = row.manuscript_id;
            	});
            	
            	$("#distributeDialog").dialog("open");
            }
	       	$('#dataList_to_expert').datagrid({ 
	 	        title:'专家列表', 
	 	        iconCls:'icon-more',//图标 
	 	        border: true, 
	 	        collapsible:false,//是否可折叠的 
	 	        fit: true,//自动大小 
	 	        method: "post",
	 	        url:"get_list_expert?t="+new Date().getTime(),
	 	        idField:'id', 
	 	        singleSelect:false,//是否单选 
	 	        pagination:true,//分页控件 
	 	        rownumbers:true,//行号 
	 	        sortName:'id',
	 	        sortOrder:'DESC',
	 	        remoteSort: true,
	 	        columns: [[  
	 	        	{field:'chk',checkbox: true,width:50},
	  		        {field:'name',title:'专家姓名',width:60},
	  		      	{field:'sex',title:'专家性别',width:60},
	  		     	{field:'phone_number',title:'电话',width:150,sortable:true},
	  		   		{field:'address',title:'地址',width:300}
	 	 		]]
	 	    });
	       	
	    });
	  	 //分配稿件
	  	 $("#distributeDialog").dialog({
	  		//datagrid初始化 
	  		title: "分配给指定专家",
	    	width: 800,
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
					text:'确定分配',
					plain: true,
					iconCls:'icon-edit',
					handler:function(){
						//var validate = $("#editForm").form("validate");
						/*if(!validate){
							$.messager.alert("消息提醒","请检查你输入的数据!","warning");
							return;*/
						//} else{
							//var data = $("#editForm").serialize();
							var id;
							var selectRow = $("#dataList_to_expert").datagrid("getSelected");
							id = selectRow.id;
							$.messager.confirm("消息提醒", "将分配所勾选记录，确认继续？", function(r){
								if(r){
									
									$.ajax({
										type: "post",
										url: "distributeManuscript",
										data: {
											ids : ids,
											id : id	
										},
										dataType:'json',
										success: function(data){
											if(data.type == "success"){
												$.messager.alert("消息提醒","分配成功","info");
												//关闭窗口
												$("#distributeDialog").dialog("close");
												
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
								
							})
							
					//	}
					}
				},
			],
			onBeforeOpen: function(){
				//var selectRow = $("#dataList").datagrid("getSelected");
				//设置值
				//$("#edit-id").val(selectRow.id);
			}
	  	 });
	  		 
	  		 
	   /* $("#distribute").click(function(){
	    	var selectRows = $("#dataList").datagrid("getSelections");
	    	console.log(selectRows);
        	var selectLength = selectRows.length;
        	if(selectLength == 0){
            	$.messager.alert("消息提醒", "请至少选择一条记录!", "warning");
            } else{
            	var ids = [];
            	$(selectRows).each(function(i, row){
            		ids[i] = row.manuscript_id;
            	});
            	$.messager.confirm("消息提醒", "将分配所勾选记录，确认继续？", function(r){
            		if(r){
            			$.ajax({
							type: "post",
							url: "distributeManuscript",
							data: {ids: ids},
							dataType:'json',
							success: function(data){
								if(data.type == "success"){
									$.messager.alert("消息提醒","分配成功!","info");
									//刷新表格
									$("#dataList").datagrid("reload");
									$("#dataList").datagrid("uncheckAll");
								} else{
									$.messager.alert("消息提醒",data.msg,"warning");
									return;
								}
							}
						});
            		}
            	});
            }
	    });*/
	});
	</script>
</head>
<body>
	<!-- 数据列表 -->
	<table id="dataList" cellspacing="0" cellpadding="0"> 
	    
	    
	</table> 
	<!-- 工具栏 -->
	<div id="toolbar">
		<a id="distribute" href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-large-shapes',plain:true">分配稿件</a>
	</div>
	
	<!-- 分配稿件给指定专家窗口 -->
	<div id="distributeDialog" style="padding: 10px">
    	<table id="dataList_to_expert" cellspacing="0" cellpadding="0"> 
	    
	    
		</table>
	</div>
</body>
</html>