<html>
<head>
<!--<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<script type="text/javascript" src="jquery.js"></script>--> 
</head>

<body>
<?php    
  include "connect.php";
	$db = db_connect();
  mysql_select_db("Fortest");   
 //$query = "set names cp1251";
 // $result = mysql_query($query);
  if ($_POST['ff']==11){
   if ($_POST['qq'] && $_POST['cc'] && $_POST['vv1'] && $_POST['vv2'] && $_POST['vv3'] && $_POST['vv4'] && $_POST['vv5'] && $_POST['gg'])
   {
    $query88 = "UPDATE Questions SET Question='".$_POST['qq']."', Code = ".$_POST['cc'].", Variant1 = '".$_POST['vv1']."', Variant2 = '" .$_POST['vv2']. "', Variant3 ='".$_POST['vv3']."', Variant4 = '".$_POST['vv4']."', Variant5 = '".$_POST['vv5']."', Glava = ".$_POST['gg']." WHERE Number = ".$_POST['nn']." ;";
    $result88 = mysql_query($query88);
    if ($result88 != 1) {echo "Невозможно добавить данные в базу данных";} else {echo "Данные успешно заменены!";}
   }
	else  echo "Введены не все данные <br><br>";
  };
  if ($_POST['ff']=='22'){
   if ($_POST['qq'] && $_POST['cc'] && $_POST['vv1'] && $_POST['vv2'] && $_POST['vv3'] && $_POST['vv4'] && $_POST['vv5'] && $_POST['gg'])
   { 
    $query88 = "Insert into Questions VALUES(0,'".$_POST['qq']."',".$_POST['cc'].",'".$_POST['vv1']."','" .$_POST['vv2']."','".$_POST['vv3']."','".$_POST['vv4']."','".$_POST['vv5']."',".$_POST['gg'].")";  
    $result88 = mysql_query($query88);
    if ($result88 != 1) {echo "Невозможно добавить данные в базу данных";} else {echo "Данные успешно добавленны!";}
   }
    else  echo "Введены не все данные <br><br>";
   }	
?>   
</body>
</html>
