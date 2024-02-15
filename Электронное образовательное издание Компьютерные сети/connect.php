<?php
  $db_name="Fortest";
  function db_connect()
  {
    $db = mysql_pconnect("" , "root");
    if (!$db)
    {
      echo "Невозможно подключиться к MySQL";
      exit;
    }
	return $db;
  }
?>  