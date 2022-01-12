<?PHP
 $files = scandir(".");
 foreach ($files as $f) {
  if (strpos($f,"hirt") && strpos($f,"_f")) $fname[]=$f;
 }
 $i=0;
 for ($i=count($fname)-1;$i>=0;$i--) { 
   //rename($fname[$i],"shirt$i"."_f.png");
  echo "mv $fname[$i] shirt$i"."_f.png\n";
 }
 //print_r($fname);
?>
