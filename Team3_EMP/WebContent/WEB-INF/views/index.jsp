<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.10/css/all.css" integrity="sha384-+d0P83n9kaQMCwj8F4RJB66tzIwOKmrdb46+porD/OvrJ+37WqIM7UoBtwHO6Nlg" crossorigin="anonymous">
	      
	
	<script type="text/javascript">
		var empList = null;
		var data = null;
		$(document).ready(function(){
			
			//response객체방식 ajax
			$('#responseBtn').click(function(){
				console.log("click")
				 $.ajax(
						 {  
							type : "post",
							url  : "response.ajax",
							success : function(data){ 
								console.log(data);
								empList = JSON.parse(data);
							//	var jsonData = JSON.parse(data);
								$('#exp').empty();
								$('#exp').append('<fieldset><legend>Response객체에 문자열 담기</legend><p>json형식으로 작성한 문자열을 response객체 담아 전송한다</p></fieldset>');
								createTable(empList, "response객체");
							} 
						 } 
				       )  
			});
			
			//objectmapper방식 ajax
			$('#objMapperBtn').click(function(){
				 $.ajax(
						 {  
							type : "post",
							url  : "objMapper.ajax",
							success : function(data){							
								console.log(data);
								empList = JSON.parse(data);
								$('#exp').empty();
								$('#exp').append('<fieldset><legend>ObjectMapper객체 사용하기</legend><p>객체를 json형식의 문자열로 바꿔준다</p></fieldset>');
								//var jsonData = JSON.parse(data);
								createTable(empList, "ObjectMapper");
							} 
						 }
						 	
				       )    
			});
			
			//@responsebody방식 ajax
			$('#responseBodyBtn').click(function(){
				 $.ajax(
						 {  
							type : "post",
							url  : "responseBody.ajax",
							success : function(data){								
								console.log(data);
								empList = data;	
								$('#exp').empty();
								$('#exp').append('<fieldset><legend>@ResponseBody 사용하기</legend><p>메소드의 반환형 앞에 @ResponseBody를 붙여서 사용 / 해당객체가 자동으로 Json객체로 변환되어 반환</p></fieldset>');
								createTable(data, "@ResponseBody");
							} 
						 } 
				       )    
			});
			
			//jasonview방식 ajax
			$('#ajaxBtn').click(function(){
				 $.ajax(
						 { 
							type : "post",
							url  : "json.ajax",
							success : function(data){
								
								empList = data.emp;								
								console.log(data);
								console.log(empList); 
								$('#exp').empty();
								$('#exp').append('<fieldset><legend>jsonview 방식</legend><p>View 객체가 Json객체로 파싱되어서 넘어온다</p></fieldset>');
								createTable(data.emp, "jsonview");
							} 
						 } 
				       )    
			});
			
			//@restcontroller방식 ajax
			$('#restconBtn').click(function(){
				 $.ajax(
						 {  
							type : "post",
							url  : "restcon.ajax",
							success : function(data){
								empList = data;	 
								console.log(data);
								$('#exp').empty();
								$('#exp').append('<fieldset><legend>@RestController</legend><p>@Controller 대신 @RestController를 사용하면 자동으로 @ResponseBody가 기본으로 작동</p></fieldset>');
							  
								createTable(data, "@Restcontroller");
							} 
						 } 
				       )    
			});
			
			//xml 형식 ajax
			$('#xmlBtn').click(function(){
				 $.ajax(
						 {  
							type : "post",
							url  : "xmllist.ajax",
							datatype : "xml",
							success : function(data){								
								var temp = xml2json(data);
								empList = temp.emplist.emp;																				
								$('#exp').empty();
								$('#exp').append('<fieldset><legend>XML형식</legend><p>XML 형식으로 읽기/쓰기</p></fieldset>');
								createxmlTable($(data).find('emplist').find('emp'),"XML");								
							} 
						 }
				       )    
			});
			//삭제
			$(document).on("click",".delete",function(){
				$.ajax({
					type : "post",
					url  : "delete.ajax",
					data : {empno : $(this).attr("value2")},
					success : function(data){ 
						createTable(data.emp, "삭제완료");
					} 
				})
			});

			//xml to json
			function xml2json(xml) {
				  try {
				    var obj = {};
				    if (xml.children.length > 0) {
				      for (var i = 0; i < xml.children.length; i++) {
				        var item = xml.children.item(i);
				        var nodeName = item.nodeName;

				        if (typeof (obj[nodeName]) == "undefined") {
				          obj[nodeName] = xml2json(item);
				        } else {
				          if (typeof (obj[nodeName].push) == "undefined") {
				            var old = obj[nodeName];

				            obj[nodeName] = [];
				            obj[nodeName].push(old);
				          }
				          obj[nodeName].push(xml2json(item));
				        }
				      }
				    } else {
				      obj = xml.textContent;
				    }
				    return obj;
				  } catch (e) {
				      console.log(e.message);
				  }
				}

		
		})
		//정렬
		function sort(me){
			var col = $('#sort').val();			
		 	var a =empList.sort(function(a,b){
			 	if(col==='Ename'){
				 	return a.ename < b.ename ? -1 : a.ename > b.ename ? 1: 0;
			 	}else if(col==='Sal'){
			 		return a.sal < b.sal ? -1 : a.sal > b.sal ? 1: 0;
				 }else if(col==='Hiredate'){
					 return a.hiredate < b.hiredate ? -1 : a.hiredate > b.hiredate ? 1: 0;
					 }
				
				
				
			})
			console.log(a)
			createTable(a, "이름순정렬")
		} 
		
		//수정 폼
		function empupdate(me){
				var tr = $(me).closest('tr')
				var datas = {empno:tr.children().html()};
				tr.empty();
				
				$.ajax({
					type : "get",
					url:"update.ajax",
					data:datas,
					success : function(data) {
					 	var td = "<td><input type='text' value='"+data.emp.empno +"' readonly></td>";
							td +="<td><input type='text' value='"+data.emp.ename +"'></td>";
							td +="<td><input type='text' value='"+data.emp.job +"'></td>";
							td +="<td><input type='text' value='"+data.emp.mgr +"'></td>";
							td +="<td><input type='text' value='"+data.emp.hiredate.substring(0,10) +"' readonly></td>";
							td +="<td><input type='text' value='"+data.emp.sal +"'></td>";
							td +="<td><input type='text' value='"+data.emp.comm +"'></td>";
							td +="<td><input type='text' value='"+data.emp.deptno +"'></td>";
							td +="<td colspan='2'><input type='button'onclick='empupdateconfirm(this)' value='완료' value2="+data.emp.empno+" /></td>";
							$(tr).append(td); 
					}
				})
			}
		
		
		function empupdateconfirm(me){			
			empupdateok(me);
		}
		//수정 처리
		function empupdateok(me){
			var tr = $(me).closest('tr');
			var data = {empno:tr.find("td:eq(0)").children().val(),
						ename:tr.find("td:eq(1)").children().val(),
						job:tr.find("td:eq(2)").children().val(),
						mgr:tr.find("td:eq(3)").children().val(),
						hiredate:tr.find("td:eq(4)").children().val(),
						sal:tr.find("td:eq(5)").children().val(),
						comm:tr.find("td:eq(6)").children().val(),
						deptno:tr.find("td:eq(7)").children().val(),
					   };
			$.ajax({
				type : "post",
				url:"update.ajax",
				data:data,
				success : function(data){  
					createTable(data.emp, "수정완료");
				} 
			})
		}
		
		//Json 전용 table 생성
		function createTable(data, way){
			console.log(data);
			$('#menuView').empty();
			var opr="<table id='fresh-table' class='table'><tr>"+way+"</tr><thead><tr>"+
			    "<th>EMPNO</th>"+
            	"<th>ENAME</th>"+
            	"<th>JOB</th>"+
            	"<th>MGR</th>"+
            	"<th>HIREDATE</th>"+
            	"<th>SAL</th>"+
            	"<th>COMM</th>"+
            	"<th>DEPTNO</th>"+
            	"<th>EDIT</th><th>DELETE</th></tr></thead><tbody>";
			$.each(data,function(index,emp){
				opr += "<tr><td>"+emp.empno+
				"</td><td>"+emp.ename+
				"</td><td>"+emp.job+
				"</td><td>"+emp.mgr+
				"</td><td>"+emp.hiredate.substring(0,10)+ 
				"</td><td>"+emp.sal+
				"</td><td>"+emp.comm+
				"</td><td>"+emp.deptno+
				"</td><td><input type='button' onclick='empupdate(this)' value='수정' class ='update'  value2="+emp.empno+
				"></td><td><input type='button' value='삭제' class ='delete' value2="+emp.empno+"></td></tr>";
			});
			opr+="<tr><td colspan='10'><input type='button' onclick='createinput(this)' value='추가'></td></tr></tbody></table>";
			opr+="<label class='' for='q'>사번</label> <input type='text' id='empNo' name='empNo' value='' /><input type='button' onclick='empselect(this)'value='검색' />";

				$('#menuView').append(opr);

		}

		//Json 전용 table 생성 (객체형식으로 넘어올때)
		function createTableObject(emp, way){
			console.log(emp);
			$('#menuView').empty();
			var opr="<table id='fresh-table' class='table'><tr>"+way+"</tr><thead><tr>"+
			    "<th>EMPNO</th>"+
            	"<th>ENAME</th>"+
            	"<th>JOB</th>"+
            	"<th>MGR</th>"+
            	"<th>HIREDATE</th>"+ 
            	"<th>SAL</th>"+
            	"<th>COMM</th>"+
            	"<th>DEPTNO</th>"+
            	"<th>EDIT</th><th>DELETE</th></tr></thead><tbody>";
			
				opr += "<tr><td>"+emp.empno+
				"</td><td>"+emp.ename+
				"</td><td>"+emp.job+
				"</td><td>"+emp.mgr+
				"</td><td>"+emp.hiredate.substring(0,10)+  
				"</td><td>"+emp.sal+
				"</td><td>"+emp.comm+
				"</td><td>"+emp.deptno+
				"</td><td><input type='button' onclick='empupdate(this)' value='수정' class ='update'  value2="+emp.empno+
				"></td><td><input type='button' value='삭제' class ='delete' value2="+emp.empno+"></td></tr>";
			
			opr+="<tr><td colspan='10'><input type='button' onclick='createinput(this)' value='추가'></td></tr></tbody></table>";
			opr+="<label class='' for='q'>사번</label> <input type='text' id='empNo' name='empNo' value='' /><input type='button' onclick='empselect(this)'value='검색' />";
			$('#menuView').append(opr);
		}
		
		//Xml 전용  table 생성
		function createxmlTable(data, way){
			$('#menuView').empty();
			var opr="<table id='fresh-table' class='table'><tr>"+way+"</tr><thead><tr>"+
			    "<th>EMPNO</th>"+
            	"<th>ENAME</th>"+
            	"<th>JOB</th>"+
            	"<th>MGR</th>"+
            	"<th>HIREDATE</th>"+
            	"<th>SAL</th>"+
            	"<th>COMM</th>"+
            	"<th>DEPTNO</th>"+
            	"<th>EDIT</th><th>DELETE</th></tr></thead><tbody>";
			$.each(data,function(){
				opr += "<tr><td>"+$(this).find('empno').text()+
				"</td><td>"+$(this).find('ename').text()+
				"</td><td>"+$(this).find('job').text()+
				"</td><td>"+$(this).find('mgr').text()+
				"</td><td>"+$(this).find('hiredate').text().substring(0,10)+
				"</td><td>"+$(this).find('sal').text()+
				"</td><td>"+$(this).find('comm').text()+
				"</td><td>"+$(this).find('deptno').text()+
				"</td><td><input type='button' onclick='empupdate(this)' value='수정' class ='update'  value2="+$(this).find('empno').text()+
				"></td><td><input type='button' value='삭제' class ='delete' value2="+$(this).find('empno').text()+"></td></tr>";
			});
			opr+="<tr><td colspan='10'><input type='button' onclick='createinput(this)' value='추가'></td></tr></tbody></table>";
			$('#menuView').append(opr);
		}
		
		//등록 폼
		function createinput(me){
			var tr = $(me).closest('tr');
			tr.empty();
			var td = "<td><input type='text'></td>";
			td +="<td><input type='text'></td>";
			td +="<td><input type='text'></td>";
			td +="<td><input type='text'></td>";
			td +="<td><input type='text'></td>";
			td +="<td><input type='text'></td>";
			td +="<td><input type='text'></td>";
			td +="<td><input type='text'></td>";
			td +="<td><input type='button'onclick='empinsert(this)' value='완료'/></td>";
			td +="<td><input type='button'onclick='cancel(this)' value='취소'/></td>";
			$(tr).append(td); 
		
		}
		
		//취소버튼
		function cancel(me){
			var tr = $(me).closest('tr');
			tr.empty();
			tr.append("<td colspan='10'><input type='button' onclick='createinput(this)' value='추가'></td>");
			
		}
		//등록 처리
		function empinsert(me){
			var tr = $(me).closest('tr');
			var data = {empno:tr.find("td:eq(0)").children().val(),
						ename:tr.find("td:eq(1)").children().val(),
						job:tr.find("td:eq(2)").children().val(),
						mgr:tr.find("td:eq(3)").children().val(),
						hiredate:tr.find("td:eq(4)").children().val(),
						sal:tr.find("td:eq(5)").children().val(),
						comm:tr.find("td:eq(6)").children().val(),
						deptno:tr.find("td:eq(7)").children().val(),
					   };
			$.ajax({
				type : "post",
				url:"insert.ajax",
				data:data,
				success : function(data){  
					createTable(data.emp, "추가");
				} 
			})
		}

		//사원 검색처리
		function empselect(me){
			var empNo = $('#empNo').val();
			console.log(empNo);
			var data = {empno:empNo};
			console.log(data);
			$.ajax({
				type : "post",
				url:"select.ajax",
				data:data,
				success : function(data){  
					createTable(data.emp, "검색");
				} 
			})
		}

		//사원, 부서번호 검색처리
		function empselectby(me){
			var selectoption = $('#test').val();
			var empnum = $('#empnum').val()
			
			console.log(selectoption, empnum);
			var data = {selectoption: selectoption, empnum:empnum};
			console.log(data);
			$.ajax({
				type : "post",
				url:"selectby.ajax",
				data:data,
				success : function(data){
					empList = data.emp;  
					createTable(empList, "검색");
				} 
			})
		}

		/*<option value="Ename">이름순</option>
				<option value="Deptno">연봉순</option>
				<option value="Hiredate">입사일순</option>  */
	 



		
	
	</script>
		 <style>
table {
	border-collapse: collapse; /* 붕괴하다 , 무너지다 */
	width: 100%;
}

th {
	text-align: center;
	width: 10px;
}

td {
	text-align: center;
	width: 10px;
}
input[type="text"]{
	width: 60%;
}

</style>
</head>
<body>
 <a href="view.ajax">view</a>
<form id="content-searchform" class="article-search-form"
					action="selectBy.htm" method="post">
					<fieldset>
						<legend class="hidden"> 사원 조회 </legend>
						<input type="hidden" name="pg" value="" /> <label for="f"
							class="hidden">검색필드</label> 
						<select id="test" name="f">
							<option value="Empno">사&nbsp&nbsp번</option>
							<option value="Deptno">부서번호</option>
							<option value="Ename">이름</option>
						</select> 
						<label class="hidden" for="q">검색어</label> 
						<input type="text" id="empnum" name="q" value="" /> 
						<input type='button' onclick='empselectby(this)'value='검색' />
					</fieldset>
</form>

			<select id="sort" name="sort" onchange="sort(this)" >
				<option value="" selected disabled hidden >정렬방법선택</option>
				<option value="Ename">이름순정렬</option>
				<option value="Sal">연봉순정렬</option>
				<option value="Hiredate">입사일순정렬</option>
			</select> 
<hr>

<div class="wrapper">
    <div class="fresh-table toolbar-color-azure full-screen-table" style="align-content: center;">
<div class="container-fluid">
<div class="row">
<div class="col-sm-6">
<fieldset>
	<legend>JSON</legend>
	<input type="button" value="Response" id="responseBtn">
	<input type="button" value="ObjectMapper" id="objMapperBtn">
	<input type="button" value="ResponseBody" id="responseBodyBtn">
	<input type="button" value="JsonView" id="ajaxBtn">
	<input type="button" value="RestController" id="restconBtn">
</fieldset>
</div>
<div class="col-sm-6">
<fieldset>
	<legend>XML</legend>
	<input type="button" value="Xml" id="xmlBtn">
</fieldset>
</div>
</div>

	<hr>
	<div id="exp"></div>
		<span id="menuView"></span>
	</div>
	</div>
</div>
	
</body>
</html>