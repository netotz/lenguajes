use warnings;
use strict;

my $A = 0;
my $B = 0;

print " A B | (!AB)+(A!B)\n";
print "-----+--\n";

for(my $i = 0; $i < 2; $i++){
	for(my $j = 0; $j < 2; $j++){
		print " $A $B | ";
		
		if( ((not $A) and $B) or ($A and (not $B)) ){
			print "1\n";
		}
		else{
			print "0\n";
		}
		
		$B = not $B;
		$B = 0 if (not $B);
	}
	$A = not $A;
}

print "\n\n";
for(my $i = 0, my $p = 1; $i < 2; $i++, $p = !$p){
	for(my $j = 0, my $q = 1; $j < 2; $j++, $q = !$q){
		for(my $k = 0, my $r = 1; $k < 2; $k++, $r = !$r){
			for(my $l = 0, my $s = 1; $l < 2; $l++, $s = !$s){
				if( ($r and $s) or ($q and $p) ){
					print " 1\n";
				}
				else{
					print " 0\n";
				}
			}
		}
	}
}