<html>
<head>
<link rel="StyleSheet" type="text/css" href="style.css">
</head>
<body>
<?php
include "connect.php";
	$db = db_connect();
  echo "<form method=\"POST\" action=\"calcdegree.php\">";  
  echo " \n";
$Q=50;
$Name=$_POST['Name'];
$Fathername=$_POST['Fathername'];
$Surname=$_POST['Surname'];
$Group=$_POST['field6'];
  echo "<input type=\"hidden\" name=\"Name\" value=\"$Name\"/>";
  echo "<input type=\"hidden\" name=\"Surname\" value=\"$Surname\"/>";
  echo "<input type=\"hidden\" name=\"Group\" value=\"$Group\"/>";
  echo "<input type=\"hidden\" name=\"Fathername\" value=\"$Fathername\"/>";
echo " "." Уважаемый ".$Surname." ".$Name." ".$Fathername."! Ответьте на $Q вопросов теста.";
  mysql_select_db("Fortest");
    $query = "SELECT * FROM Questions ";
   $result = mysql_query($query);
   $num_rows = mysql_num_rows($result);
 
  	$N=1;
	$i=1;                       /*Рандом без повторений ©P.S.Makarov*/
	$Numb[0]=rand(1,$num_rows);
	do{ do 
	{ 
	$Numb[$i]=rand(1,$num_rows);
	$f=0;
	for ($j=0; $j<$i; $j++) {
	if($Numb[$i]==$Numb[$j]){
	$f=1;
	}}}
	while ($f==1);	 
	$i++;}
	while ($i<$Q);
 
  for($i = 0; $i < $Q; $i++) //$num_rows
  {$query = "SELECT Number, Question, Code, Variant1, Variant2, Variant3, Variant4, Variant5 FROM Questions Where Number = ".$Numb[$i];
  $result = mysql_query($query);
  $row = mysql_fetch_array($result);
    
	echo " "."<p>$N) $row[Question]</p>\n"; //$row[Number]
 
	$checked_answer = 1;
	$answers_count = 5;
	$leter_index = array(1 => "а", "б", "в", "г", "д");
	for($j = 1; $j <= $answers_count; $j++)
	{
	  ($j == $checked_answer) ? $checked = " checked" : $checked = "";
      ($j == $answers_count) ? $separator = "." : $separator = ";";	  
	  echo " "."<input type=\"radio\" name=\"q$row[Number]\" value=\"$j\"$checked>$leter_index[$j]) " . $row["Variant" . $j] . "$separator</input><br />\n";
	  
	}
	$N++;
  } 
  echo " "."<input name=\"quec1\" type=\"hidden\" value=\"$Q\"> ";
  for($i = 0; $i < $Q; $i++) 
  echo " "."<input name=\"que$i\" type=\"hidden\" value=\"$Numb[$i]\"> ";
  echo "<br />\n<input type=\"submit\" value=\"Пройти тестирование\" />\n</form>\n";
 
  /* session_start();
   $_SESSION['Q_Count']=$Q;
   for ($i=1;$i<$Q;$i++){
   $_SESSION['Q'.$i]=$Numb[$i];}
   //header("Location: calcdegree.php"); 
   exit();*/
  // $GLOBALS["Q"] = $Q;
?>
</body>
</html>
