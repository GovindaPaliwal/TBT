#!/usr/local/bin/perl 
#no warnings;
use utf8;

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
my @tempword;
my $i;
my %Uni2IT3MAP;
my %it3Type;
my $hexValue;
my @syllabified_words;
my $mychar;
my $hexSyllable;
my @hextemp1;
my @psyl;
my $o;
my @words1;
my $hal;
my @silUnitIndices;
my @ps;
my $word_present;
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
my $phone_hash
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
 " ;
my %HashPhone;
@ps = split(/\s+/, $phone_hash);

foreach (@ps) {
    $HashPhone{$_}++;
  # print "ps = $_ \t";
}
chomp(@ps);

my $vowel_hash
 = "   
a
aa
i
ii
u
uu
rq
ae
ee
ai
ax
o
au
 " ;
my %HashVowel;
@ps1 = split(/\s+/, $vowel_hash);

foreach (@ps1) {
    $HashVowel{$_}++;
  # print "ps = $_ \t";
}
chomp(@ps1);

############################################################
#my $path1=$PWD;

my $path1=$ARGV[0];



my $file=$path1."/all_sys";
open (FP1, "<", $file) or die $!;
my @content= <FP1>;
my $dict_file=$path1."/syldict";
open FLAB, ">$dict_file" or die $!;

my $vowelcount_file=$path1."/vowelcount";
open FLAC, ">$vowelcount_file" or die $!;

my $line = ();
my $t;
my @sylls;
my %hashsylls;
my $tempStr="";
my @phones;
my $middlevalue;
my @sylls;
my @syllables;
my $n=0;#for counting number of line
my @timeframe;#
my @syllablelab;
my $k=0;
 
my $constvalue=100;

foreach my $line (@content){

        $line =~ s/^\(\s+|\.*"\s+\)$//g;
      #	print "line2 = $line \n";
	#$line =~ s/"//g;
        #	print "line3 = $line \n";
	my @words = split(/\s+/, $line);
	#my $header = shift(@words);
	#shift(@words); #removint the starting quatations
      @syllables="";
	foreach my $word(@words)
	{
                   print "\n word =  $word \t";
                    @sylls ="";
		$word =~ s/\,|\.//g;
               
		 &main($word);
	       
			
	}	#end of foreach	word

    


	
}





#################################################################################################








sub main {
	
#return &getSyllables($_[0]);

#my  @psyl=&getSyllables($_[0]);
#my $nS = $#psyl + 1;

my $change_psyl   ;

#$word_present = $_[0];
my  @psyl=&getSyllables($_[0]);
my $nS = $#psyl + 1;

my $change_psyl   ;
#for (my $j = 0; $j < $nS; $j++) {
$j=0;
$word_present = @psyl[$j];
  print "word present= $word_present\n";
              @words1= split( //, $word_present) ;
              #  print "words= @words1\n";

              my $nwd = $#words1 + 1;
            #$nwd=1;

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
  
print "change syl in phoneme=$change_psyl";


#vowel count
my $vc=0;
for ( my $loop = 0 ; $loop < $nwd ; ) {
            print "wd= $words1[$loop]";

            if (exists $HashVowel{$words1[$loop].$words1[$loop+1].$words1[$loop+2].$words1[$loop+3]}){

                    $vc++;
                  $loop +=3;

                  }
                elsif (exists $HashVowel{$words1[$loop].$words1[$loop+1].$words1[$loop+2]}){

                      $vc++;
                $loop +=2;

                  }
                   elsif (exists $HashVowel{$words1[$loop].$words1[$loop+1]}){

                     $vc++;
                    $loop +=1;

                  }
               elsif (exists $HashVowel{$words1[$loop]}){

                     $vc++;

                  }
               $loop++;
        
               }
###vowel count end
if($vc!=1)
{

printf FLAC "$_[0] $change_psyl vc=$vc\n";
}
$change_psyl =~ s/ $//;
$change_psyl= "beg-".$change_psyl."_end";
printf FLAB "$_[0] $change_psyl   \n";
#my @phonemes = split(/\s+/, $change_psyl);


#return @phonemes;
	  return; 
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
		#$hexword .= " " . $hex;
                $hexword .= $hex;
	
		if ( $hex == "94D" )    #To check if halant present
		{
			$hal = 1;
		}
	}
        print "hexword=  $hexword \n";
	#my @hextemp     = split( /\s+/,            $hexword );
	#my @dectemp     = split( /\s+/,            $decword );
	#my @modfiedWord = &dehalanting( \@hextemp, \@dectemp );
        #print "modified word=@modfiedWord \n";
       
	#my $words = " ";
	#$syllabified_sentence .= &syllabify( \@modfiedWord );
       # $syllabified_sentence .= &syllabify( \@hextemp );
	#print "op is $#modfiedWord :::::: $syllabified_sentence\n";
	
	
 
	#return &transliterate($syllabified_sentence);
        return &transliterate($hexword);
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
	print " words_trans_dehalant=@word_trans \n";
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
                        print "1";
			$phonified_word .= ${ $_[0] }[$i] . " ";
		}
		elsif ((&hex2dec("${ $_[0] }[$i]") > $hash{ 'औ' }) && (&hex2dec("${ $_[0] }[$i]") <= $hash{ 'ह' })) {
			if (( &hex2dec("${ $_[0] }[$i+1]") >= $hash{'़'}) && (&hex2dec("${ $_[0] }[$i+1]") < $hash{ '्' })
				|| (&hex2dec("${ $_[0] }[$i+1]") == $hash{ 'ँ'} && &hex2dec("${ $_[0] }[$i+1]") == $hash{'ं'})) {
                                   print"2a";
				$phonified_word .= ${ $_[0] }[$i];
			}
			else {
                                  print "2b";
				$phonified_word .= ${ $_[0] }[$i] . " ";
			}
		}
		elsif ((&hex2dec("${ $_[0] }[$i]") >= $hash{'़'}) && (&hex2dec("${ $_[0] }[$i]") <= $hash{ '्' })) {
                                  print "3";
				$phonified_word =~ s/ $//g;
				$phonified_word .= ${ $_[0] }[$i] . " ";

		}
		elsif ((&hex2dec("${ $_[0] }[$i]") == $hash{ 'ँ'} || &hex2dec("${ $_[0] }[$i]") == $hash{'ं'})) {
                         print "4";
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
	#print "hextempb4 $hexSyllable ";
	@hextemp1 = split(/\s+/,$hexSyllable);
	
	&write2speak(\@hextemp1,\%it3Type);
	#print "hextempafter @hextemp1";
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
        #my @pHbuf = &readFile("./PhoneSet.txt");
	my @pHbuf = &readFile("./bin/PhoneSet.txt");
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
	#print "hextempb4 $hexSyllable ";
	@hextemp1 = split(/\s+/,$hexSyllable);
	
	&write2speak(\@hextemp1,\%it3Type);
	#print "hextempafter @hextemp1";
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

sub write2speak
{       
	for(my $i=0;$i<@{$_[0]};$i++)
	{        
# 		print " TAG VALUE : -${$_[1]}{${$_[0]}[$i]}-";

		#if(($i==@{$_[0]}-1)&&${$_[1]}{${$_[0]}[$i]} eq "SCHWA")
        	#{
                   # &erase(\@{$_[0]},$i,1);
                #}
		if(${$_[1]}{${$_[0]}[$i]} eq "STRESS")
		{
		 
			${$_[0]}[$i] = ${$_[0]}[$i+1];
		}

		if(${$_[1]}{${$_[0]}[$i]} eq "SCHWA")
		{
# 			print "INside SCHWA ...\n";

			if(${$_[1]}{${$_[0]}[$i + 1]} eq "HLT")
			{
# 				print "INside HLT ...\n";
				if(${$_[1]}{${$_[0]}[$i + 2]} eq "HLT")
				{
# 					 print " ERASE PARAM 1 : -\@{$_[0]}-";
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
	}
	#print join(" ",@{$_[0]})."\n";
	#<STDIN>;
	
}


sub erase
{
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


