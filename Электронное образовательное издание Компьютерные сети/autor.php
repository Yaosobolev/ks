<html>
	<head>
		<script src="scriptaculous/lib/prototype.js" type="text/javascript"></script>
		<script src="scriptaculous/src/effects.js" type="text/javascript"></script>
    
		<script type="text/javascript" src="fabtabulous.js"></script>
		<script type="text/javascript" src="validation.js"></script>
        

		<link rel="stylesheet" type="text/css" href="style1.css" />
	</head>
	<body>
		<div id="container">
			<p align="center">		<font class="big">Уважаемый студент введите свои данные</font></p>
			<div id="mainmenu">
					<ul id="tabs">
						<li>
							<a href="#standard">Студент</a>
						</li>
						<li>
							<a href="#using-titles">Преподаватель</a>
						</li>
						</ul>
				<div>
				<div class="bar">&nbsp;</div>
				<div class="panel" id="standard">
					<form id="test" action="#" method="get">
					<fieldset>
							<div class="form-row">
							<div class="field-label"><label for="field1">Фамилия</label>:</div>
							<div class="field-widget"><input name="field1" id="field1" class="required" title="Введите вашу фамилию" />
                            </div>
						</div>
						    <div class="form-row">
							<div class="field-label"><label for="field2">Имя</label>:</div>
							<div class="field-widget"><input name="field2" id="field2" class="required" title="Введите ваше имя" />
						</div> </div>
						<div class="form-row">
							<div class="field-label"><label for="field3">Отчество</label>:</div>
							<div class="field-widget"><input name="field3" id="field3" class="required" title="Введите ваше отчество"/>
						</div> </div>
						
						<div class="form-row">
							<div class="field-label"><label for="field4">Факультет</label>:</div>
							<div class="field-widget">
								<select id="field4" name="field4" class="validate-selection" title="Выберите факультет"
                                onchange="ajaxLoad('field5', 'get_s.php '+this.value, '','',''); ">
                                    <option value="0">Выберите...</option>
				                    <option value="1">Фит</option>
				                    									
								</select>
							</div>
						</div>
						
                     
                        
                        
                        
                        
                        
						<div class="form-row">
							<div class="field-label"><label for="field5">Специальность</label>:</div>
							<div class="field-widget">
								<select id="field5" name="field5" class="validate-selection" title="Выберите вашу специальность" disabled="disabled">
									<option>Select one...</option>
									<option>Accounts</option>
									<option>Human Resources</option>
									<option>Information Technology</option>
									<option>Animal Management</option>
									<option>Ultimate Frisby</option>
								</select>
							</div>
						</div>
						
                        <div class="form-row">
							<div class="field-label"><label for="field6">Группа</label>:</div>
							<div class="field-widget">
								<select id="field6" name="field6" class="validate-selection" title="Выберите вашу группу" disabled="disabled">
									<option>Select one...</option>
									<option>Accounts</option>
									<option>Human Resources</option>
									<option>Information Technology</option>
									<option>Animal Management</option>
									<option>Ultimate Frisby</option>
								</select>
							</div>
						</div>
						
					</fieldset>
					<input type="submit" value="Вход" /> <input type="button" value="Отмена" onClick="valid.reset(); return false" />
					</form>
					<script type="text/javascript">
						function formCallback(result, form) {
							window.status = "valiation callback for form '" + form.id + "': result = " + result;
						}
						
						var valid = new Validation('test', {immediate : true, onFormValidate : formCallback});
						Validation.addAllThese([
							['validate-password', 'Your password must be more than 6 characters and not be \'password\' or the same as your name', {
								minLength : 7,
								notOneOf : ['password','PASSWORD','1234567','0123456'],
								notEqualToField : 'field1'
							}],
							['validate-password-confirm', 'Your confirmation password does not match your first password, please try again.', {
								equalToField : 'field8'
							}]
						]);
					</script>
				</div>
                
                
				<div class="panel" id="using-titles">
					<form id="test2" action="#" method="get">
						<fieldset>
							
							<div class="form-row">
							<div class="field-label"><label for="field7">Логин</label>:</div>
							<div class="field-widget"><input name="field7" id="field7" class="required" title="Введите ваш логин"/>
						</div> </div>                   
							<div class="form-row">
							<div class="field-label"><label for="field8">Пароль</label>:</div>
							<div class="field-widget"><input type="password" name="field8" id="field8" class="required" title="Введите ваш пароль" /></div>
						</div>							
						</fieldset>
					<input type="submit" value="Вход" /> <input type="button" value="Отмена" onClick="valid2.reset(); return false" />
					</form>
					<script type="text/javascript">
						var valid2 = new Validation('test2', {useTitles:true});
					</script>
                    
                    
                    
                    
                    
                    
                    
                    
				</div>
				<div class="panel" id="no-element-ids">
					<form id="test3" action="#" method="get">
						<fieldset>
							<legend>Form</legend>
										
						</fieldset>
						<input type="submit" value="Submit" /> <input type="button" value="Reset" onClick="valid3.reset(); return false" />
					</form>
					<script type="text/javascript">
						var valid3 = new Validation('test3');
					</script>
				</div>
		</div>
		<script type="text/javascript">
			new Fabtabs('tabs');
		</script>
 <?php
require_once($_SERVER['DOCUMENT_ROOT'].'/get_s.php');
//$field4 = @intval($_GET['field4']);
$link = mysql_connect("","root","") // Соединение с MySQL 
   or die ("Невозможно подключиться к MySQL "); 
mysql_select_db ("fortest") // Выбор Базы данных 
   or die ("Невозможно выбрать БД ");
$result = mysql_query("SELECT * FROM 'fakultet' ", $link);
if(isset($_GET['field4'])){
   $facult=$_SESSION['field4']=intval($_GET['field4']);
   $res = sql('SELECT * FROM Spec'); //WHERE facul ='.$facult);                     //.' ORDER by Short');
   /* todo if(mysql_num_rows($res)>1) */ echo '<option value=0 selected>Выберите</option>';
    while($row = mysql_fetch_array($res))
        echo "<option value='" . $row['id'] . "'>" . $row['Short'] . "</option>\n";
   exit;    
}
$script=@$_SERVER['SCRIPT_URL']; if(!$script)$script=@$_SERVER['REQUEST_URI'];
?>       

        
<script language=JavaScript><!--
function ajaxLoad(obj,url,defMessage,post,callback){
  var ajaxObj;
  if (defMessage) document.getElementById(obj).innerHTML=defMessage;
  if(window.XMLHttpRequest){ 
      ajaxObj = new XMLHttpRequest(); 
  } else if(window.ActiveXObject){ 
      ajaxObj = new ActiveXObject("Microsoft.XMLHTTP");  
  } else { 
      return; 
  } 
  ajaxObj.open ((post?'POST':'GET'), url);
  if (post&&ajaxObj.setRequestHeader)
      ajaxObj.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=windows-1251;");
 
  ajaxObj.onreadystatechange = ajaxCallBack(obj,ajaxObj,(callback?callback:null));
  ajaxObj.send(post); 
  return false;
  } 
function updateObj(obj, data, bold, blink){ 
   if(bold)data=data.bold();
   if(blink)data=data.blink();
   document.getElementById(obj).innerHTML = data; // упрощенный вариант, работает не во всех браузерах
  } 
function ajaxCallBack(obj, ajaxObj, callback){
return function(){
    if(ajaxObj.readyState == 4){
       if(callback) if(!callback(obj,ajaxObj))return;
       if (ajaxObj.status==200)
        updateObj(obj, ajaxObj.responseText);
       else updateObj(obj, ajaxObj.status+' '+ajaxObj.statusText,1,1);
    }
}}

//--></script>
        
        
	</body>
</html>