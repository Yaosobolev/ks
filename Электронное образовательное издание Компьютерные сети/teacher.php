
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<title>Страница преподавателя</title>

</head>

<body>
<?php
include "connect.php";
	$db = db_connect();
$log=$_GET["field7"];
$pass=$_GET["field8"];
 mysql_select_db("Fortest");
     $query9 = "SELECT * FROM Admins ";
   $result9 = mysql_query($query9);
   $num_rows9 = mysql_num_rows($result9);
    $row9 = mysql_fetch_array($result9);
	
  $query = "SELECT * FROM Groups ";
  $query1 = "SELECT distinct TestingDate FROM TestingResult  ";
  $query2 = "SELECT distinct mark FROM TestingResult  ORDER BY mark ASC";
  $result = mysql_query($query) or trigger_error(mysql_error().$query);
  $result1 = mysql_query($query1) or trigger_error(mysql_error().$query1);
  $result2 = mysql_query($query2) or trigger_error(mysql_error().$query2);
  $num_rows = mysql_num_rows($result);
   $num_rows1 = mysql_num_rows($result1);
    $num_rows2 = mysql_num_rows($result2);
	
	 for($i = 0; $i < $num_rows9; $i++){
	 if (($row9["login"]==$log)&& ($row9["passsword"]==$pass)){
	 echo "                          <Br>  ";
	 
	 
	 
	   echo "<form name=\"group\" method=\"POST\" action=\"teacher.php\">\n";
  echo "Выберите группу для которой необходимов вывести результаты тестирования\n";
  echo "<select name=\"GroupID\">\n";
 
  for($i = 0; $i < $num_rows; $i++)
  {
    $row1 = mysql_fetch_array($result); 
    echo "<option value=\"$row1[id]\">$row1[name]</option>\n";
  }
  echo "</select> ";
  echo "<input type=\"button\" value=\"Просмотр\" onClick=\"javascript:location='groups.php?group_id='+ GroupID.options[GroupID.selectedIndex].value  ;\" />\n"; //
  echo "<input type=\"hidden\" name=\"action\" value=\"view_result\" />\n";
  echo "</form>"; 
  //для даты
  echo "<form name=\"date\" method=\"POST\" action=\"teacher.php\">\n";
  echo "Выберите дату по которой необходимо вывести результаты тестирования\n";
  echo "<select name=\"TestingDate\">\n";
  for($i = 0; $i < $num_rows1; $i++)
  {
    $row2 = mysql_fetch_array($result1); 
    echo "<option value=\"$row2[TestingDate]\"";
	//if($row2[TestingDate] == $_POST["TestingDate"])
	//echo " selected";
	echo ">$row2[TestingDate]</option>\n";
  }
  echo "</select> ";
  echo "<input type=\"button\" value=\"Просмотр\" onClick=\"javascript:location='date.php?date_id='+TestingDate.options[TestingDate.selectedIndex].value;\" />\n";
  echo "<input type=\"hidden\" name=\"action\" value=\"view_result2\" />\n";
  echo "</form>";
  // Для оценки
  echo "<form name=\"mark\" method=\"POST\" action=\"teacher.php\">\n";
  echo "Выберите оценку по которой необходимо вывести результаты тестирования\n";
  echo "<select name=\"mark\">\n";
  $num_rows2 = mysql_num_rows($result2);
  for($i = 0; $i < $num_rows2; $i++)
  {
    $row3 = mysql_fetch_array($result2); 
    echo "<option value=\"$row3[mark]\"";
	//if($row3[mark] == $_POST["mark"])
	//echo " selected";
	echo ">$row3[mark]</option>\n";
  }
  echo "</select> ";
  echo "<input type=\"button\" value=\"Просмотр\" onClick=\"javascript:location='mark.php?mark_id='+mark.options[mark.selectedIndex].value;\" />\n";
  echo "<input type=\"hidden\" name=\"action\" value=\"view_result3\" />\n";
  echo "</form>"; 
  
  
  echo "<form name=\"All\" method=\"POST\" action=\"teacher.php\">\n";
  echo "Вывести все результаты.\n";
   echo "<input type=\"button\" value=\"Просмотр\" onClick=\"javascript:location='all.php';\" />\n";
  echo "<input type=\"hidden\" name=\"action\" value=\"view_result8\" />\n";
  echo "</form>";
	  echo "<form name=\"Red\" method=\"POST\" action=\"teacher.php\">\n";
  echo "Просмотреть или редактировать таблицу вопросов.\n";
   echo "<input type=\"button\" value=\"Просмотр\" onClick=\"javascript:location='red.php';\" />\n";
  echo "<input type=\"hidden\" name=\"action\" value=\"view_result8\" />\n";
  echo "</form>";
  echo "<form name=\"xx\" method=\"POST\" action=\"teacher.php\">\n";
  echo "<input type=\"hidden\" name=xx1 value=$log />\n";
  echo "<input type=\"hidden\" name=xx2 value=$pass />\n";
  echo "</form>";
   }
   }
   ?>
</body>
</html>
