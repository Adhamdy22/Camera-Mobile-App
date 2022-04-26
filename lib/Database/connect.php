<?php
$connect=new mysqli("localhost","root","","car_wash");
if($connect){
   // echo" yes connected ";
}
else{
    echo "not connected";
}

?>