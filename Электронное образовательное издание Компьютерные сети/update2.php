<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<script type="text/javascript" src="jquery.js"></script> 
</head>

<body>
<?php    
  include "connect.php";
	$db = db_connect();
  mysql_select_db("Fortest");   
 //$query = "set names cp1251";
 // $result = mysql_query($query);
  if ($_REQUEST['ff']==11){
  $query88 = "UPDATE Questions SET Question='".$_REQUEST['qq']."', Code = ".$_REQUEST['cc'].", Variant1 = '".$_REQUEST['vv1']."', Variant2 = '" .$_REQUEST['vv2']. "', Variant3 ='".$_REQUEST['vv3']."', Variant4 = '".$_REQUEST['vv4']."', Variant5 = '".$_REQUEST['vv5']."', Glava = ".$_REQUEST['gg']." WHERE Number = ".$_REQUEST['nn']." ;";
  $result88 = mysql_query($query88);
  if ($result88 != 1) {echo "Невозможно добавить данные в базу данных";} else {echo "Данные успешно заменены!";}};
  if ($_REQUEST['ff']=='22'){
$query88 = "Insert into Questions VALUES(0,'".$_REQUEST['qq']."',".$_REQUEST['cc'].",'".$_REQUEST['vv1']."','" .$_REQUEST['vv2']."','".$_REQUEST['vv3']."','".$_REQUEST['vv4']."','".$_REQUEST['vv5']."',".$_REQUEST['gg'].")";  
$result88 = mysql_query($query88);
  if ($result88 != 1) {echo "Невозможно добавить данные в базу данных";} else {echo "Данные успешно добавленны!";}};
  
?>   
</body>
</html>
