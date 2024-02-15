<html>
<head> <script type="text/javascript" src="jquery.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
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
  // $query = "set names cp1251";
 // $result = mysql_query($query);
  

   /* echo "<form method=\"POST\" action=\"all.php\">\n";
    $query = "SELECT COUNT(Number) FROM Questions";
    $result = mysql_query($query) or trigger_error(mysql_error().$query);
	$row = mysql_fetch_row($result);
	$question_count = $row[0];*/
   
	$query = "SELECT *
    FROM Questions where Number = $_GET[red_id]";
    $result = mysql_query($query);
	if ($result)
	{	
	 // $num_rows = mysql_num_rows($result);
	   $num_rows = mysql_num_rows($result);
	  if(isset($_GET["print"]))
	echo "<H3 style=\"margin-left: 5em;\"> Вопросы для тестирования.</H3>";
	else	  
	 echo "<br><H4 align=center> Всего вопросов в таблице: $num_rows</H4>";
	 echo "<form method=\"POST\" action=\"update.php\">";
	  echo "<table cellpadding=6 border=2>\n";
	  echo "<tr><th width=15>№</th><th width=100>Вопрос</th><th width=50>Прав.Отв.</th><th width=100>Вариант 1</th><th width=100>Вариант 2</th><th width=100>Вариант 3</th><th width=100>Вариант 4</th><th width=100>Вариант 5</th><th width=100>Глава</th></tr>\n";
	   
	  for($i = 0; $i < $num_rows; $i++)
	  {
		$row = mysql_fetch_array($result); 
		echo "<tr><td class=\"center\"><input name=\"nn\" type=\"text\" value=$row[Number]></td><td><textarea name=\"qq\" type=\"text\" rows=\"10\">$row[Question]</textarea></td><td><input name=\"cc\" type=\"text\" value=$row[Code]></td><td><textarea name=\"vv1\" type=\"text\" rows=\"10\">$row[Variant1]</textarea></td><td><textarea name=\"vv2\" type=\"text\" rows=\"10\">$row[Variant2]</textarea></td><td><textarea name=\"vv3\" type=\"text\" rows=\"10\">$row[Variant3]</textarea></td><td><textarea name=\"vv4\" type=\"text\" rows=\"10\">$row[Variant4]</textarea></td><td><textarea name=\"vv5\" type=\"text\" rows=\"10\">$row[Variant5]</textarea></td><td><input name=\"gg\" type=\"text\" value=$row[Glava]></td></tr><input type=\"hidden\" name=\"ff\" value=11>\n";
	  }
	  
	   echo "</table>";
	   echo "  <br>";
	   echo "<input type=\"submit\" value=\"Сохранить изменения\">";
	   echo "</form>";
	   echo "<div id=\"content\"></div>";
	}
	else 
	{
	echo "Отсуствуют результаты для отображения\n";
	}
	if(!isset($_GET["print"]))
	{  
		echo "<a style=\"float: left;\" href=\"red.php\"> Назад</a>";
		//echo "<a style=\"float: right;margin-right: 10px;\"  href=\"print_red.php\" target=blank> Версия для печати </a>";	
	}
?>
<!--
<script type="text/javascript">
 $(document).ready(function(){   
           
            $('#Reda').submit(function(){   
                $.ajax({   
                    type: "POST",   
                    url: "update.php",   
                    data: "qq="+$("#Que").val()+"&cc="+$("#Cod").val()+"&vv1="+$("#V1").val()+"&vv2="+$("#V2").val()+"&vv3="+$("#V3").val()+"&vv4="+$("#V4").val()+"&vv5="+$("#V5").val()+"&gg="+$("#Gl").val()+"&nn="+$("#Nom").val()+"&ff=11",   
                    success: function(html){   
                        $("#content").html(html);   
                    }   
                });   
                return false;   
            });   
               
        });   
</script>
-->
</html>
</head>
</body>