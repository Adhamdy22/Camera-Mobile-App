<?php
require_once("connect.php");
$select=$connect->query("SELECT * FROM images");
$list=array();
if($select){
while($data=$select->fetch_assoc()){
    $list[]=$data;
}
echo json_encode($list);
}
$connect->close();
return;
?>