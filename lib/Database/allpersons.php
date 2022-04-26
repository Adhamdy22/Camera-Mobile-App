<?php
require_once("connect.php");
$imgname=$_POST["imgname"];
$img=$_POST["img"];
$imgstatus=$_POST["imgstatus"];
$sql="INSERT INTO images(imgname,img,imgstatus)VALUES('$imgname','$img','$imgstatus')";
$query=mysqli_query($connect,$sql);
if($query){
    echo "Success";
}
$connect->close();
return;
?>