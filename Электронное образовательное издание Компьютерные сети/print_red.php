<html>
<head> <meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<title></title>
  <style type="text/css">
	.center {
	  text-align: center;
	}
  </style>
<body>
<?php
include "connect.php";
	$db = db_connect();
  mysql_select_db("Fortest");
  $query = "set names cp1251";
  $result = mysql_query($query);
  

   // echo "<form method=\"POST\" action=\"all.php\">\n";
  /*  $query = "SELECT COUNT(Number) FROM Questions";
    $result = mysql_query($query) or trigger_error(mysql_error().$query);
	$row = mysql_fetch_row($result);
	$question_count = $row[0];*/
   
	$query = "SELECT *
    FROM Questions";
    $result = mysql_query($query);
	if ($result)
	{	
	 // $num_rows = mysql_num_rows($result);
	   $num_rows = mysql_num_rows($result);
	  if(isset($_GET["print"]))
	echo "<H3 style=\"margin-left: 5em;\"> Вопросы для тестирования.</H3>";
	else	  
	 echo "<br><H4 align=left> Всего вопросов в таблице: $num_rows</H4>\n";
	 echo "<form name=\"Reda\" method=\"POST\" action=\"red.php\">";
	  echo "<table cellpadding=6 border=2>\n";
	  echo "<tr><th width=15>№</th><th width=100>Вопрос</th><th width=50>Прав.Отв.</th><th width=100>Вариант 1</th><th width=100>Вариант 2</th><th width=100>Вариант 3</th><th width=100>Вариант 4</th><th width=100>Вариант 5</th><th width=100>Глава</th>
	  <th width=120> ... </th></tr>\n";
	   
	  for($i = 0; $i < $num_rows; $i++)
	  {
		$row = mysql_fetch_array($result); 
		echo "<tr><td class=\"center\">$row[Number]</td><td>$row[Question]</td><td>$row[Code]</td><td>$row[Variant1]</td><td>$row[Variant2]</td><td>$row[Variant3]</td><td>$row[Variant4]</td><td>$row[Variant5]</td><td>$row[Glava]</td> <td class=\"center\"><input type=\"button\" value=\"Редактировать\" onClick=\"javascript:location='redakt.php?red_id='+$row[Number];\"></td>
		</tr>\n";
	  }	  
	   echo "</table>";
	   echo "</form>";
	}
	else 
	{
	echo "Отсуствуют результаты для отображения\n";
	}
	if(!isset($_GET["print"]))
	{  
		echo "<a style=\"float: left;\" href=\"teacher.php\"> Назад к выбору критерия</a>";
		echo "<a style=\"float: right;margin-right: 10px;\"  href=\"red.php\" target=blank> Версия для печати </a>";	
	}
?>
</html>
</head>
</body>