my ($motiffile, $fastafile, $rna);# = @ARGV ;

use lib '.';
use PerlPluMA;



my @line_info;
my %file_data;


sub input {
   open(FH, '<', $_[0])
     or die "Could not open file '$_[0]' $!";
   while (<FH>)
   {
           #chomp($line);
           #print $line;
           chomp($_);
      @line_info = split(/\t/, $_);
      $file_data{$line_info[0]} = $line_info[1];
   }
   $motiffile = PerlPluMA::prefix."/".$file_data{"motifs"};
   $fastafile = PerlPluMA::prefix."/".$file_data{"fasta"};
   $rna = PerlPluMA::prefix."/".$file_data{"rna"};
}

sub run{}

sub output {
print $motiffile;
$outfile = $_[0];
open(FH, '>', $outfile) or die $!;
open I, "< $motiffile" ;
while(my $re = <I>){
	$re =~ s/\s+$// ;
	my $res = `genregexp -reldist 0 -fastafile $fastafile -rna $rna -re \"$re\"` ;
	print FH ">$re", "\n", $res if ($res) ;
}
}
