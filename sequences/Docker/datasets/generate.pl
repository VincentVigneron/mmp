#!/usr/bin/perl


if(@ARGV != 3 && @ARGV != 4){
die "Usage: generate.pl <num_items> <trans_size> <num_trans> [<datasetname>]\nNote: random generator is not seeded so same parameter will generate the same dataset.\n"

}


if (@ARGV == 3){
    ($num_items, $trans_size, $num_trans) = @ARGV;
    $filename = "random_NUM_ITEMS.".$num_items."_TRANS_SIZE.".$trans_size."_NUM_TRANS.".$num_trans.".dat";
}

if (@ARGV == 4){
    ($num_items, $trans_size, $num_trans, $filename) = @ARGV;
}



print "Stored in $filename\n"; 

open OUTPUT, ">$filename" or die $!;
# print OUTPUT  "num_items = $num_items;\n";
# print OUTPUT  "trans_size = $trans_size;\n";
# print OUTPUT  "num_trans = $num_trans;\n";

#print OUTPUT  "data = \n"; 
for ($t = 1; $t <= $num_trans; $t++){
    for($n = 1; $n <= $trans_size; $n++){
	$random = int( rand($num_items)) +1 ;
	print OUTPUT  $random; 
	print OUTPUT2  "$random "; 
	if($n != $trans_size){
	    print OUTPUT  " ";
	}

    }
	print OUTPUT2  "\n"; 	
    print OUTPUT  "";
    if($t != $num_trans){
	print OUTPUT  "\n"; 	
    }

}
print OUTPUT  "\n";

    close OUTPUT; 

