#!/usr/local/bin/perl 
#no warnings;
use utf8;
$eachW = $ARGV[0];
my $voiceDir = $ARGV[1];
my $combination;
#print " badri $eachW \n";
#open FILE,  "< ./unit_size.sh" or die $!;
#while (<FILE>) { 
	#print $_;
#	$combination = $_;
#}
#close(FILE); 
print "each word= $eachW \n";

print "combination = $combination \n";
chomp($combination);
my %hash = (
    	'ँ' => 2305,  
    	'ं'=> 2306, 
        'अ' => 2308,
        'औ' => 2324,
    	'म' => 2350,
    	'य' => 2351,
	'श' => 2358,    
    	'ह' => 2361,
    	'़' => 2364,
    	'ऽ' => 2365,
    	'ा'=> 2366,
    	'ॅ'=> 2373,
    	'्' => 2381,
    	'क़' => 2392,
    	'य़' => 2399,
    	'ॠ' => 2400
    
    );
my  $phone_hash
 = "   
a
aa
i
ii
u
uu
ee
ai
o
au
ao
rq
ax
ae
k
kh
g
gh
ng
c
ch
j
jh
nj
tx
txh
dx
dxh
nx
t
th
d
dh
n
p
ph
b
bh
m
y
r
l
lx
w
sh
sx
s
h
kq
khq
gq
z
dxq
dxhq
f
q
mq
hq
 ai
 " ;

my %HashPhone;
@ps = split(/\s+/, $phone_hash);
=for
foreach $oneChar (@ps) {
     $HashPhone{$oneChar} = $oneChar;
 }

=cut
foreach (@ps) {
    $HashPhone{$_}++;
  # print "ps = $_ \t";
}
chomp(@ps);

#if ($nargs < 1) {
 # print "Usage: perl il_parser.pl <word>\n";
 # exit;
#}

my $check = 0;
my $oF = $voiceDir."/wordpronunciation";
open(fp_out, ">$oF");

@psyl = &main($eachW);
foreach my $syl(@psyl)
{

 print "syl=$syl\t";
}
my $nS = $#psyl + 1;
my $oFDic = "pronunciationDict";

print fp_out "(set! wordstruct '( ";
my $sp = 0;
my $currIndexLoc = 0; # Used for SIL unit insertion 
my $cntr4SIL = 0; # Used for SIL unit insertion 
my $numSILIndices = @silUnitIndices; # Used for SIL unit insertion 
my $prntStr = "";
my $appendStr;
my $tempStr;
my $remainUnit;
my $total_units;
my $sp = 0;
my $counter;
my $value;
my $var;
for (my $j = 0; $j < $nS; $j++) {
   $tempStr="";
   # $syl=$psyl[$j];
   if ($j == 0 )
   {
	$var = "_beg";
      
   }
   elsif ($j == ($nS -1) )
   { 
	$var = "_end";
       
   }
   else
   {
	$var = "_mid";
       
   }
    #$word_present = @psyl[$j].$var;
=for
                                  if((@psyl[$j] =~ m/.*n$/)&&(@psyl[$j+1] =~ m/^j.*/)){
                                                    
                                                 @psyl[$j] =~ s/n$/nj/;  
                                                   @psyl[$j+1] =~ s/^j//;                                             


                                                    }
                                                   
=cut


$word_present = @psyl[$j];

#$word_present="सिक्स्_beg";
	#print "Word present is $word_present \n";
        #print "\n hash phone word present = $HashPhone{$word_present}";
        #  print "\n exists hash phone word present =". exists $HashPhone{$word_present};
#$word_present=" निःस्_beg ";
  #$word_present = $psyl[$j]."_mid";


$combination="phone";
print "combination=$combination\n";
 #  if($combination eq " phone " && (exists $HashPhone{$word_present})) {
 #if($combination eq " phone "  && exists $HashPhone{$word_present}) {
#if($combination eq "phone" && exists $HashPhone{$word_present}){
 #      print "\n exists worked";
#	$tempStr = "-x";
 # } 
   $sp = 0;
####pranaw start
   #my $change_psyl = $word_present.$tempStr ;
my $change_psyl   ;

if($combination eq "phone") {
              @words1= split( //, $word_present) ;
                print "words= @words1\n";

              my $nwd = $#words1 + 1;


             print "nwd=$nwd";
		#$h += $nutf8char;
	for ( my $loop = 0 ; $loop < $nwd ; ) {
            print "wd= $words1[$loop]";

            if (exists $HashPhone{$words1[$loop].$words1[$loop+1].$words1[$loop+2].$words1[$loop+3]}){

                     $change_psyl .= $words1[$loop].$words1[$loop+1].$words1[$loop+2].$words1[$loop+3]." ";
                  $loop +=3;

                  }
                elsif (exists $HashPhone{$words1[$loop].$words1[$loop+1].$words1[$loop+2]}){

                     $change_psyl .= $words1[$loop].$words1[$loop+1].$words1[$loop+2]." ";
                $loop +=2;

                  }
                   elsif (exists $HashPhone{$words1[$loop].$words1[$loop+1]}){

                     $change_psyl .= $words1[$loop].$words1[$loop+1]." ";
                    $loop +=1;

                  }
 elsif (exists $HashPhone{$words1[$loop]}){

                     $change_psyl .= $words1[$loop]." ";

                  }
                 


                $loop++;
              }
      


###pranaw end


   print fp_out "((";
    print  "((";
 #  print fp_out "\"$change_psyl\"";
  print fp_out "$change_psyl";

print  "\"$change_psyl\"";

   print fp_out ") $sp) ";
 print  ") $sp) ";


 }#ind of if combination phone
else
{
 $word_present = @psyl[$j].$var;
 $change_psyl=$word_present;
print fp_out "((";
    print  "((";
   print fp_out "\"$change_psyl\"";
print  "\"$change_psyl\"";

   print fp_out ") $sp) ";
 print  ") $sp) ";


} 


}
   print fp_out "))\n";
   print  "))\n";
close(fp_out);

sub getStress
{
	my $syl = shift;
	my @phs = &Phonify($syl);
	my $sp = 0;
	for(my $i=0; $i<@phs; $i++)
	{
		if(&IsVowel($phs[$i]) && $phs[$i] ne "a")
		{
			$sp = 1;
			return $sp;
		}
	}
	return $sp;
}

sub main {
	#my @words_list = &readWords($utf8FileIn, $utf8FileOut);
	#my @words_with_halant = &dehalant( $_[0]);
	#my $word_syllabified;
=for         
	if($combination eq "phone") {
              print "pranaw phone";
		print "phonification word=$_[0]";
		return &getPhones_temp($_[0]);
	} else {
                  print "pranaw syllable";
                print "syllabification word=$_[0]";
	return &getSyllables($_[0]);
	}
=cut
return &getSyllables($_[0]);
	#print "comes $word_syllabified \n";
	#print fp_out_syl $word_syllabified;
	#system("rm /home/badri/festival/voices/iitm_hin_anjanafb/syll_word.txt");
	#system ("java Write2UTF8 /home/badri/festival/voices/iitm_hin_anjanafb/wordpronunciation3 /home/ashwin/aug14/voices/iitm_hin_anjanafb/syll_word.txt");
	#return &syllabified_utf8;
       #	return &hex2utf($word_syllabified );
}          


sub getPhones_temp
{
my $wrd=$_[0];
my @phones_word;
    @psyl =  &getSyllables($wrd);
           print " syllables:\t";
             my $nS = $#psyl + 1;
                for (my $j = 0; $j < $nS; $j++) {
                           print "j=$j syl=:$psyl[$j]\t";
                         # @phones=" ";
                           @phones =  &getPhones($psyl[$j]);
                         
                           foreach (@phones){
                                   push(@phones_word,$_);

                                     }


            }#end of for of syllable                  



return @phones_word;

}



sub hex2utf
{

 my $syll_word = $_[0];

 my $syllable_utf='';
print "syll_word= $syll_word \n";
  my @syll_array = split(/\s+/,$syll_word);
  foreach my $syllable (@syll_array)
  {
	@hextemp1 = ();
	$hexSyllable = '';
    
for($i=0; $i < length($syllable); $i+=3) {
		my $hex = substr $syllable, $i, 3;

                print "hex= $hex  ";
                 my $dec=&hex2dec($hex);
                        print "dec= $dec  ";
              $mychar= chr($dec);
                   print "mychar=$mychar ";
               $syllable_utf .=$mychar;
              print "syllable_utf=   $syllable_utf ";

           }
 $syllable_utf .=" ";
}

@syllabified_words = split(/\s+/, $syllable_utf);

return @syllabified_words;
}
sub getSyllables {
	print "getsyllables";
	my $endln = "\n";
	my $line  = ();
	my $t;
	my $syllabified_word;
	my @sentence;
	my $syllabified_sentence;
	my @tempsent;
	my $word  = $_[0];
	my $engl   = 0;
	my $otherl = 0;
	#foreach my $word (@words) {
	my @utf8char;
	my $initial = 0;
	my @test;
	my $tempword;
	my $hexword;
	my $decword;
	my $other = 0;
	my $eng   = 0;
     #  print "wrd= $word";
         #  @words1= split( //, $word ) ;
# print "words= @words1\n";
  #     foreach $wd (@words1)
      #    {
      #      print "wd= $wd\t";
       #  }
	foreach  ( split( //, $word ) ) {
             #   print "doller= $wd \n";
              #   print "string2bin= &string2bin($_)";
		push( @utf8char, &string2bin($_) );
	}
	my $nutf8char = $#utf8char + 1;

		#$h += $nutf8char;
	for ( my $loop = 0 ; $loop < $nutf8char ; ) {
		$t = 0;

		my $dec_input = &hex2dec( $utf8char[$loop] );
                   # print "utfchar=  $utf8char[$loop] \n";
                    #print "dec_input= $dec_input \n"; 
                    #my $value = $dec_input & 128;
                   # print "value= $value \n";
		if ( ( my $value = $dec_input & 128 ) == 0 ) {
			$t = $t | $dec_input;
			$loop++;
			$eng = 1;
		}
		elsif ( ( $value = $dec_input & 224 ) == 192 ) {
			$eng = 1;
			$t   = $t | ( $dec_input & 31 );
			$t   = $t << 6;
			$loop++;

			$t = $t | ( $dec_input & 63 );
			$loop++;
		}

		elsif ( ( $value = $dec_input & 240 ) == 224 ) {
			$other = 1;
			$t     = $t | ( $dec_input & 15 );
			$t     = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t | ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;
			$dec_input = &hex2dec( $utf8char[$loop] );
			$t = $t | ( $dec_input & 63 );
			$loop++;
		}

		elsif ( ( $value = $dec_input & 248 ) == 240 ) {
			$other = 1;

			$t = $t + ( $dec_input & 7 );
			$t = $t << 6;
			$loop++;
			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t = $t + ( $dec_input & 63 );
			$loop++;
		}

		elsif ( ( $value = $dec_input & 252 ) == 248 ) {
			$other = 1;
			$t     = $t + ( $dec_input & 3 );
			$t     = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;
			$dec_input = &hex2dec( $utf8char[$loop] );
			$t = $t + ( $dec_input & 63 );
			$loop++;

		}

		elsif ( ( $value = $dec_input & 254 ) == 252 ) {
			$other = 1;
			$t     = $t + ( $dec_input & 63 );
			$t     = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;
			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t = $t + ( $dec_input & 63 );
			$loop++;
		}
		else {
			$loop++;
		}
		my $result = &check_language($t);

		next if ( ( $result !~ true ) );
		my $hex = &dec2hex($t);

		$decword .= " " . $t;
		$hexword .= " " . $hex;
		if ( $hex == "94D" )    #To check if halant present
		{
			$hal = 1;
		}
	}
        print "hexword=  $hexword \n";
	my @hextemp     = split( /\s+/,            $hexword );
	my @dectemp     = split( /\s+/,            $decword );
	my @modfiedWord = &dehalanting( \@hextemp, \@dectemp );
       print "modified word=@modfiedWord \n";
       
	my $words = " ";
	#$syllabified_sentence .= &syllabify( \@modfiedWord );
        $syllabified_sentence .= &syllabify( \@modfiedWord );
	#print "op is $#modfiedWord :::::: $syllabified_sentence\n";
    #$syllabified_sentence= '92C94D93092E94D 939 92692494D92494D92C ';
	 print "\n syllabified sentence1 =$syllabified_sentence pranaw";
#handling dipthonge aa(93E) & i(907), both should be in same syllable, so removed the space between them. eg saaibeeria
           $syllabified_sentence=~ s/93E 907/93E907/g;   
              # $syllabified_sentence=~ s/(94D(...)94D $)/94D $2/g;
#handling schaw deletion if words end with conjunct, in marathi there is no schaw deletion in this case
                    if($syllabified_sentence=~ m/94D(...)94D $/){   
                                           $temp=$1;
                                    #print 'dollor1= '.$1;           
                                $syllabified_sentence=~ s/94D...94D $/94D $temp/;
                             }
                          elsif($syllabified_sentence=~ m/94D(...)94D$/){   
                                           $temp=$1;
                                    #print 'dollor1= '.$1;           
                                $syllabified_sentence=~ s/94D...94D$/94D $temp/;
                             }
#handling  पोहोचलो, spoken as पहोचले  so replacing पोहो by पहो
                    if($syllabified_sentence=~ m/92A94B 93994B/){   
                                           #$temp=$1;
                                    #print 'dollor1= '.$1;           
                                $syllabified_sentence=~ s/92A94B 93994B/92A 93994B/;
                             }
                          elsif($syllabified_sentence=~ m/92A94B93994B/){   
                                           $temp=$1;
                                    #print 'dollor1= '.$1;           
                                 $syllabified_sentence=~ s/92A94B93994B/92A 93994B/;
                             }
#handling Anuswar occuring at the end of the word eg  याचं, it is used to just indicate that we do not have to delete the schaw 
                    if($syllabified_sentence=~ m/902 $/){   
                                           $temp=$1;
                                    #print 'dollor1= '.$1;           
                                $syllabified_sentence=~ s/902 $//;
                             }
                          elsif($syllabified_sentence=~ m/902$/){   
                                           $temp=$1;
                                    #print 'dollor1= '.$1;           
                                $syllabified_sentence=~ s/902$//;
                             }

#handling two conjecutive character with halant
 $syllabified_sentence=~ s/^(...)94D(...)94D /$1\94D$2\94D/;

 print "\n syllabified sentence2 =$syllabified_sentence \n";
	#$words = join("",@modfiedWord);
	#print "words=$words--";
	#my @word_trans = &transliterate($words);
         #my @word_trans = &hex2utf($words);
	#print " words_trans_dehalant=@word_trans \n";
	#print "-- $syllabified_sentence \n";
	#print fp_out "(\"$word_trans\" nil ( ";
 
       #   my @syllables1= &transliterate($syllabified_sentence);
         # print "syllabified sentence_trans =@syllables1 \n";
            #print "\t";
          # print "\t@word_trans\t";
          # @sylls1= &transliterate($syllabified_sentence);
            #   foreach my $syl(@sylls1)
            # { print "syl=$syl\t"
            #    }
          # print "\t";
           # return &hex2utf($syllabified_sentence);
 
	return &transliterate($syllabified_sentence);
        #system("rm /home/boss/voices/cdac_marathi_kousikutf/iitm/syll_word.txt");
	#system ("java -classpath /home/boss/voices/cdac_marathi_kousikutf/iitm/ Write2UTF8 /home/boss/voices/cdac_marathi_kousikutf/iitm/wordpronunciation3 /home/boss/voices/cdac_marathi_kousikutf/iitm/syll_word.txt");
	#return &syllabified_utf8;

}
sub getPhones {
	#print "getPhones";
	my $endln = "\n";
	my $line  = ();
	my $t;
	my $syllabified_word;
	my @sentence;
	my $syllabified_sentence;
	my @tempsent;
	my $word  = $_[0];
	my $engl   = 0;
	my $otherl = 0;
	#foreach my $word (@words) {
	my @utf8char;
	my $initial = 0;
	my @test;
	my $tempword;
	my $hexword;
	my $decword;
	my $other = 0;
	my $eng   = 0;
      # print "wrd in getPhone= $word";
         #  @words1= split( //, $word ) ;
# print "words= @words1\n";
  #     foreach $wd (@words1)
      #    {
      #      print "wd= $wd\t";
       #  }
	foreach  ( split( //, $word ) ) {
             #   print "doller= $wd \n";
              #   print "string2bin= &string2bin($_)";
		push( @utf8char, &string2bin($_) );
	}
	my $nutf8char = $#utf8char + 1;

		#$h += $nutf8char;
	for ( my $loop = 0 ; $loop < $nutf8char ; ) {
		$t = 0;

		my $dec_input = &hex2dec( $utf8char[$loop] );
                   # print "utfchar=  $utf8char[$loop] \n";
                    #print "dec_input= $dec_input \n"; 
                    #my $value = $dec_input & 128;
                   # print "value= $value \n";
		if ( ( my $value = $dec_input & 128 ) == 0 ) {
			$t = $t | $dec_input;
			$loop++;
			$eng = 1;
		}
		elsif ( ( $value = $dec_input & 224 ) == 192 ) {
			$eng = 1;
			$t   = $t | ( $dec_input & 31 );
			$t   = $t << 6;
			$loop++;

			$t = $t | ( $dec_input & 63 );
			$loop++;
		}

		elsif ( ( $value = $dec_input & 240 ) == 224 ) {
			$other = 1;
			$t     = $t | ( $dec_input & 15 );
			$t     = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t | ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;
			$dec_input = &hex2dec( $utf8char[$loop] );
			$t = $t | ( $dec_input & 63 );
			$loop++;
		}

		elsif ( ( $value = $dec_input & 248 ) == 240 ) {
			$other = 1;

			$t = $t + ( $dec_input & 7 );
			$t = $t << 6;
			$loop++;
			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t = $t + ( $dec_input & 63 );
			$loop++;
		}

		elsif ( ( $value = $dec_input & 252 ) == 248 ) {
			$other = 1;
			$t     = $t + ( $dec_input & 3 );
			$t     = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;
			$dec_input = &hex2dec( $utf8char[$loop] );
			$t = $t + ( $dec_input & 63 );
			$loop++;

		}

		elsif ( ( $value = $dec_input & 254 ) == 252 ) {
			$other = 1;
			$t     = $t + ( $dec_input & 63 );
			$t     = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;
			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t = $t + ( $dec_input & 63 );
			$loop++;
		}
		else {
			$loop++;
		}
		my $result = &check_language($t);

		next if ( ( $result !~ true ) );
		my $hex = &dec2hex($t);

		$decword .= " " . $t;
		$hexword .= " " . $hex;
		if ( $hex == "94D" )    #To check if halant present
		{
			$hal = 1;
		}
	}
        # print "hexword=  $hexword \n";
	my @hextemp     = split( /\s+/,            $hexword );
	my @dectemp     = split( /\s+/,            $decword );
	my @modfiedWord = &dehalanting( \@hextemp, \@dectemp );
       # print "modified word_phone=@modfiedWord \n";
       
	my $words = " ";
	#$syllabified_sentence .= &syllabify( \@modfiedWord );
        $syllabified_sentence .= &phonify( \@modfiedWord );
	#print "op is $#modfiedWord :::::: $syllabified_sentence\n";
	 # print "syllabified sentence_phone =$syllabified_sentence \n";
	$words = join("",@modfiedWord);
	#print "words=$words--";
	#my @word_trans = &transliterate($words);
            my @word_trans = &hex2utf($words);
	#print " words_trans_dehalant=@word_trans \n";
	#print "-- $syllabified_sentence \n";
	#print fp_out "(\"$word_trans\" nil ( ";
 
       #   my @syllables1= &transliterate($syllabified_sentence);
         # print "syllabified sentence_trans =@syllables1 \n";
            #print "\t";
          
          # print "\t";
            return &hex2utf($syllabified_sentence);
 
	#return &transliterate($syllabified_sentence);
        #system("rm /home/boss/voices/cdac_marathi_kousikutf/iitm/syll_word.txt");
	#system ("java -classpath /home/boss/voices/cdac_marathi_kousikutf/iitm/ Write2UTF8 /home/boss/voices/cdac_marathi_kousikutf/iitm/wordpronunciation3 /home/boss/voices/cdac_marathi_kousikutf/iitm/syll_word.txt");
	#return &syllabified_utf8;

}



sub phonify {
	my $phonified_word;
         # print " [0]  =@{ $_[0] } \n";
          # print "phoneword[0]= ${ $_[0] }[0] \t";
           #print "phoneword[1]= ${ $_[0] }[1] \t";
 #&hex2dec("${ $_[0] }[$i]")
       
	for ( my $i = 0 ; $i < @{ $_[0] } ; $i++ ) {
            
          if(${ $_[0] }[$i] ne "")
           {
               #  print "phonified_word=$phonified_word.'pranaw'\t";
                      #  print "i=$i\tword1=${ $_[0] }[$i] \n"; 
		if (  (&hex2dec("${ $_[0] }[$i]") >= $hash{ 'अ' }) && (&hex2dec("${ $_[0] }[$i]") <= $hash{ 'औ' }) ) {
                  #      print "1";
			$phonified_word .= ${ $_[0] }[$i] . " ";
		}
		elsif ((&hex2dec("${ $_[0] }[$i]") > $hash{ 'औ' }) && (&hex2dec("${ $_[0] }[$i]") <= $hash{ 'ह' })) {
			if (( &hex2dec("${ $_[0] }[$i+1]") >= $hash{'़'}) && (&hex2dec("${ $_[0] }[$i+1]") < $hash{ '्' })
				|| (&hex2dec("${ $_[0] }[$i+1]") == $hash{ 'ँ'} && &hex2dec("${ $_[0] }[$i+1]") == $hash{'ं'})) {
                               #    print"2a";
				$phonified_word .= ${ $_[0] }[$i];
			}
			else {
                              #    print "2b";
				$phonified_word .= ${ $_[0] }[$i] . " ";
			}
		}
		elsif ((&hex2dec("${ $_[0] }[$i]") >= $hash{'़'}) && (&hex2dec("${ $_[0] }[$i]") <= $hash{ '्' })) {
                              #    print "3";
				$phonified_word =~ s/ $//g;
				$phonified_word .= ${ $_[0] }[$i] . " ";

		}
		elsif ((&hex2dec("${ $_[0] }[$i]") == $hash{ 'ँ'} || &hex2dec("${ $_[0] }[$i]") == $hash{'ं'})) {
                      #   print "4";
			$phonified_word =~ s/ $//g;
			$phonified_word .= ${ $_[0] }[$i] . " ";
		}
   }#end of if
	}#end of for
	#print "phonified_word :::::::::$phonified_word";
	return $phonified_word;
}

sub syllabify {
	my $syllabified_word;
       # print "word= @{ $_[0] } \n"; 
	for ( my $i = 0 ; $i < @{ $_[0] } ; $i++ ) {
            
          if(${ $_[0] }[$i] ne "")
           {
             # print "syllabified_word =$syllabified_word.'pranaw'\t";
                     #   print "i=$i\tword1=${ $_[0] }[$i] \n"; 
                       # print "word2= @{ $_[0] } \n";    
                       # print "doller= $";

		if (   &hex2dec("${ $_[0] }[$i]") > &hex2dec("904")
			&& &hex2dec("${ $_[0] }[$i]") < &hex2dec("915") )
		{
                       print "1 \n";
			$syllabified_word .= ${ $_[0] }[$i] . " ";
		}
		elsif (((&hex2dec("${ $_[0] }[$i]") > &hex2dec("914")&& &hex2dec("${ $_[0] }[$i]") < &hex2dec("940")	)) ||((&hex2dec("${ $_[0] }[$i]") > &hex2dec("957")&& &hex2dec("${ $_[0] }[$i]") < &hex2dec("962")	)) )
		{ 
              if (( &hex2dec("${ $_[0] }[$i+1]") == &hex2dec("94d")) || (&hex2dec("${ $_[0] }[$i+1]") == &hex2dec("93c") && &hex2dec("${ $_[0] }[$i+2]") == &hex2dec("94d"))) {
                               #94d halant, 93c nukta,

                              print "2a \n";
                     print "syl_word1= $syllabified_word \n";
				$syllabified_word =~ s/ $//g;
                                   print "syl_word2= $syllabified_word \n";
				$syllabified_word .= ${ $_[0] }[$i];
                               print "syl_word3= $syllabified_word \n";
			}
			elsif ((&hex2dec("${ $_[0] }[$i+1]") >= &hex2dec("93c") && &hex2dec("${ $_[0] }[$i+1]") < &hex2dec("94d")))
			{    print "2b \n";
				$syllabified_word .= ${ $_[0] }[$i];
                           print "syl_word2b= $syllabified_word \n";
			}
			else {
                                print "2c \n";
				$syllabified_word .= ${ $_[0] }[$i] . " ";
			}
		}
		elsif (
			(
				   &hex2dec("${ $_[0] }[$i]") >= &hex2dec("93c")
				&& &hex2dec("${ $_[0] }[$i]") < &hex2dec("94e")
			)
		  )
		{

			if ( $i == 2 && &hex2dec("${ $_[0] }[$i]") == &hex2dec("94d") ) {
                               print "3a \n";
				$syllabified_word .= ${ $_[0] }[$i];
			}
			else {
                                  print "3b \n";
				$syllabified_word .= ${ $_[0] }[$i] . " ";
                              print "syl_word3b= $syllabified_word\n";
			}

			#				$syllabified_word .= ${ $_[0] }[$i]." ";
		}
		elsif ((&hex2dec("${ $_[0] }[$i]") > &hex2dec("901") || &hex2dec("${ $_[0] }[$i]") < &hex2dec("902")
			)
		  )
		{     print "4 \n";
			$syllabified_word =~ s/ $//g;
			$syllabified_word .= ${ $_[0] }[$i] . " ";
		}

      print "syl_word=$syllabified_word \n";
   }#end of if
	}#end of for

	#$syllabified_word = join(' ',split(' ',$syllabified_word));
	return $syllabified_word;
}

sub dehalanting {
	my @hallist;
	my $k = 0;
	my $j = @{ $_[0] };
	for ( my $i = 0 ; $i < @{ $_[0] } ; $i++ ) {
		if (   ( ${ $_[1] }[$i] > 2324 && ${ $_[1] }[$i] < 2362 )
			|| ( ${ $_[1] }[$i] > 2391 && ${ $_[1] }[$i] < 2400 )||${ $_[1] }[$i]==&hex2dec("93C") )
		{
			$k = $k + 1;
			$hallist[$k] = $i;
			if ( ( ${ $_[1] }[ $i + 1 ] > 2304 && ${ $_[1] }[ $i + 1 ] < 2325 )
			  )    #full vowel
			{
				delete $hallist[$k];
			}
			elsif (
				( ${ $_[1] }[ $i + 1 ] > 2365 && ${ $_[1] }[ $i + 1 ] < 2381 )
			  )    #kaa kii type
			{
				delete $hallist[$k];
			}
			elsif (
				( ${ $_[1] }[ $i + 1 ] == &hex2dec("94D") )
				|| (
					( ${ $_[1] }[ $i - 1 ] == &hex2dec("94D") )
					&& (
						   (${ $_[1] }[ $i] > 2350
							&& ${ $_[1] }[ $i] < 2358 )||($i+1 != $j))
					)
				)
			  
			{
				delete $hallist[$k];    #conjsyll + ya,ra,la,va

			}
			elsif (
				(
					( ${ $_[1] }[ $i + 2 ] == &hex2dec("94D") )
					&& (
						(
							   ${ $_[1] }[ $i + 3 ] > 2324
							&& ${ $_[1] }[ $i + 3 ] < 2362
						)
						|| ( ${ $_[1] }[$i] > 2391 && ${ $_[1] }[$i] < 2400 )
					)
				)
			  )
			{
				delete $hallist[$k];    # followed by a conjsyl

			}
			elsif ( ${ $_[1] }[ $i + 1 ] == &hex2dec("93C") ) {
				delete $hallist[$k];    #nukta

			}
			elsif ( $i == 1 )           #first syllable
			{
				delete $hallist[$k];

			}
			elsif ( ( ${ $_[1] }[$i] == &hex2dec("92F") || ${ $_[1] }[$i] == &hex2dec("95F") )
				&& (   ${ $_[1] }[ $i - 1 ] > 2366
					&& ${ $_[1] }[ $i - 1 ] < 2373 ) )
			{
				#print "Here?? $i";
				delete $hallist[$k];    #yarule

			}
			#elsif ( ( ${ $_[0] }[$i] == "930" || ${ $_[0] }[$i] == "931" )&&( $i + 1 ) != $j ) {
			#	delete $hallist[$k];    #rarule
			#}
		}
	}
	my $t = @hallist;
    
        for ( my $k = @hallist -1; $k >= 0;$k--)
         { my $p1 = $hallist[$k];
	  if (($k!=(@hallist-1))&&($hallist[$k-1]==$p1-1)||($hallist[$k+1]==$p1+1))
          { #print "$hallist[$k]-asda";
            delete $hallist[$k];
	  }
        }
       #print "-@hallist-word\n";
	my @withhal;
	my $m = 1;
	for ( my $i = 1 ; $i < @{ $_[0] } ; $i++ ) {
		$withhal[$m] = ${ $_[0] }[$i];
		my $p = 0;
	       for ( $o = 0 ; $o < @hallist ; $o++ ) {
		#	print "o=$o->$hallist[$o] ";
			if ( $hallist[$o] == $i ) {
				$p = 1;
				
			}
		}
		if ( $p == 1 ) {
			$m = $m + 1;
			$withhal[$m] = "94D";
		}
		$m = $m + 1;
	}

	#print "---@{$_[0]}---\n";
        #print "---@withhal---\n";
	return @withhal;
}

sub splitWord2Letters {
	my @utf8char;
	my $i=0;
#	foreach my $word ( @{ $_[0] } ) {
		foreach ( split( //, $_[0] ) ) {
				push( @utf8char,$_ );
		}
#	}
	return @utf8char; 	
}

sub printArrayValues {
	foreach my $arr_values ( @{ $_[0] } ) {
		if($arr_values eq "") {
			print "$arr_values \n";
		} else {
			print " else $arr_values \n";
		}
	}
}


sub char2utf8num {
	my @utf8num;
	foreach $_ (@{ $_[0] }) {
		push(@utf8num , &string2bin($_) );
	}
	return @utf8num;
}

sub string2bin($) {
	return sprintf( "%02x ", ord($_) );
}

sub hex2dec($) {
	eval "return sprintf(\"\%d\", 0x$_[0])";
}

sub dec2hex {
	my $decnum = $_[0];
	my ( $hexnum, $tempval );
	while ( $decnum != 0 ) {
		$tempval = $decnum % 16;
		$tempval = chr( $tempval + 55 ) if ( $tempval > 9 );
		$hexnum  = $tempval . $hexnum;
		$decnum  = int( $decnum / 16 );
		if ( $decnum < 16 ) {
			$decnum = chr( $decnum + 55 ) if ( $decnum > 9 );
			$hexnum = $decnum . $hexnum;
			$decnum = 0;
		}
	}
	return $hexnum;
}
sub check_language
{

	#my @Language_Ranges = @{$_[1]};

	#foreach my $line (@Language_Ranges)
	#{
	#my $line   = "HINDI_2305-2429";
        my $line   = "Marathi_2305-2429";
	my @values = split( /_/, $line );
	my $lan    = shift(@values);
	foreach my $ran (@values) {
		my @range = split( /-/, $ran );
		# print " $range[0]  ::::: $_[0] \n";
		if ( $range[0] <= $_[0] ) {
			if ( $_[0] <= $range[1] ) {
				return (true);
			} else {
				return false;
			}
		}
	}

	#}
}

sub transliterate
{
# print "translitrate \n";
  my $syll_word = $_[0];
#print "syll_word= $syll_word \n";
  my @syll_array = split(/\s+/,$syll_word);
  my $hexSyllable;
  my @hextemp1;
   @tempword=();
  &loadPhoneSet();
  foreach my $syllable (@syll_array)
  {
	@hextemp1 = ();
	$hexSyllable = '';
	for($i=0; $i < length($syllable); $i+=3) {
		my $hex = substr $syllable, $i, 3;
                
		if($it3Type{$hex} eq "CON")
 		{
			$hexSyllable .=" ".$hex;
                        $hexSyllable .=" ".905;
		}
		else 
		{
			$hexSyllable .=" ".$hex;
		}
		
		
	}
	print "\nhextempb4 $hexSyllable ";
	@hextemp1 = split(/\s+/,$hexSyllable);
	
	&write2speak(\@hextemp1,\%it3Type);
	print "hextempafter @hextemp1 \n";
        my $tempSyllable;
	foreach $hexValue(@hextemp1) {
	 		$tempSyllable .= $Uni2IT3MAP{$hexValue} if(exists $Uni2IT3MAP{$hexValue});
		#print "tempSyllable $tempSyllable";
	}
	#print "\n tempSyllable $tempSyllable";
       # print "\n tempWord @tempword";
        push(@tempword,join("",$tempSyllable));
	$tempSyllable ="";      
  }
  return @tempword;
}
sub loadPhoneSet
{
	#my @pHbuf = &readFile("./iitm/etc/Hindi_PhoneSet.txt");
         my @pHbuf = &readFile($voiceDir."/bin/PhoneSet.txt");
	my $SCHWA = ();
            #print "phbuf= @pHbuf  ";
	foreach my $phone (@pHbuf)
	{
                   #   print "phone=$phone\n";
		my ($key,$value,$tag) = split(/\s+/,$phone);
		
		$Uni2IT3MAP{$key} = $value;
		$it3Type{$key} = $tag;
		$SCHWA = $value if($tag eq "SCHWA");
		
	}

	if(length($SCHWA) == 0)
	{
		print "There is no Schwa in the Phone set. Please make the required changes.\n";
		exit(0);
	}
		
	
	foreach my $phone (@pHbuf)
	{
		my ($key,$value,$tag) = split(/\s+/,$phone);
# 		$Uni2IT3MAP{$key} .= " $SCHWA" if($it3Type{$key} eq "CON");
		
	}
}
sub readFile
{
	open(IN,$_[0]);
	my @file = <IN>;
	chomp(@file);
	close( IN );
	return(@file);
}


sub hex2utf
{

 my $syll_word = $_[0];

 my $syllable_utf='';
#print "syll_word= $syll_word \n";
  my @syll_array = split(/\s+/,$syll_word);
  foreach my $syllable (@syll_array)
  {
	@hextemp1 = ();
	$hexSyllable = '';
    
for($i=0; $i < length($syllable); $i+=3) {
		my $hex = substr $syllable, $i, 3;

                #print "hex= $hex  ";
                 my $dec=&hex2dec($hex);
                       # print "dec= $dec  ";
              $mychar= chr($dec);
                #   print "mychar=$mychar ";
               $syllable_utf .=$mychar;
            #  print "syllable_utf=   $syllable_utf ";

           }
 $syllable_utf .=" ";
}

@syllabified_words = split(/\s+/, $syllable_utf);

return @syllabified_words;
}




sub write2speak
{       
	for(my $i=0;$i<@{$_[0]};$i++)
	{        
		print "\n TAG VALUE : -${$_[1]}{${$_[0]}[$i]}-";
               print "  VALUE B4: -${$_[0]}[$i]-";

		#if(($i==@{$_[0]}-1)&&${$_[1]}{${$_[0]}[$i]} eq "SCHWA")
        	#{
                   # &erase(\@{$_[0]},$i,1);
                #}
		if(${$_[1]}{${$_[0]}[$i]} eq "STRESS")
		{
		 print "\ninside STRESS";
			${$_[0]}[$i] = ${$_[0]}[$i+1];
		}

		if(${$_[1]}{${$_[0]}[$i]} eq "SCHWA")
		{
 			print "INside SCHWA ...\n";

			if(${$_[1]}{${$_[0]}[$i + 1]} eq "HLT")
			{
 				print "INside HLT ...\n";
				if(${$_[1]}{${$_[0]}[$i + 2]} eq "HLT")
				{
 					 print " Inside HLT2 : -\@{$_[0]}-";
					&erase(\@{$_[0]},$i,3);
				}
				else
				{
# 				      print " Else ERASE PARAM 1 : -\@{$_[0]}-";
					&erase(\@{$_[0]},$i,2);
				}
			}
			elsif(${$_[1]}{${$_[0]}[$i + 1]} eq "VOW")
			{
# 				print "INside VOW ...\n";
				&erase(\@{$_[0]},$i,1);
			}
			elsif(${$_[1]}{${$_[0]}[$i + 1]} eq "NUK" && ${$_[1]}{${$_[0]}[$i + 2]} eq "HLT")
			{
				
				&erase(\@{$_[0]},$i,1);
				&erase(\@{$_[0]},$i + 1,1);
			}
			elsif(${$_[1]}{${$_[0]}[$i + 1]} eq "NUK" && ${$_[1]}{${$_[0]}[$i + 2]} eq "VOW")
			{
				
				&erase(\@{$_[0]},$i,1);
			}
			if( (${$_[1]}{${$_[0]}[$i - 1]} eq "VOW" || ${$_[1]}{${$_[0]}[$i - 1]} eq "SCHWA") && ${$_[1]}{${$_[0]}[$i]} eq "NUK" && ${$_[1]}{${$_[0]}[$i + 1]} eq "CON")
			{
				
				my $g = ${$_[0]}[$i];
				${$_[0]}[$i] = ${$_[0]}[$i - 1];
				${$_[0]}[$i - 1] = $g;
			}
			if( (${$_[1]}{${$_[0]}[$i]} eq "VOW") && ${$_[1]}{${$_[0]}[$i + 1]} eq "HLT")
			{
				&erase(\@{$_[0]},$i + 1,1);
			}
			if( (${$_[1]}{${$_[0]}[$i]} eq "HLT") && ${$_[1]}{${$_[0]}[$i + 1]} eq "HLT")
			{
				&erase(\@{$_[0]},$i,2);
			}

		}
      print "\n VALUE after: -${$_[0]}[$i]- ";
	}
	#print join(" ",@{$_[0]})."\n";
	#<STDIN>;
	
}


sub erase
{
print "\ninside erase";
	my $end = @{$_[0]} - $_[2];
	for(my $i=$_[1];$i<$end;$i++)
	{
		${$_[0]}[$i] = ${$_[0]}[$i + $_[2]];
	}
	for(my $i=0;$i<$_[2];$i++)
	{
		pop(@{$_[0]});
	}
}


sub writeFile
{
	#usage: writeFile(<filenmae> <features - inarray> <header option [0/1] 0-without, 1-with header>);
	my $file = shift;
	my $features = shift;
	
	my $header = 0;
	if(@_ == 1)
	{
		$header = shift;;
	}
	chomp(@{$features});
	open(FILE, ">$file") || die("$file can't be created\n");
	if($header != 0 && $header ne "")
	{
		my $cnt = scalar(@{$features});
		my $vecSize = split(/\s+/, ${$features}[0]);
		print FILE "$cnt $vecSize\n";		
	}
	print FILE join("\n", @{$features})."\n";
	close(FILE);
	#&addHeader($file);
}
