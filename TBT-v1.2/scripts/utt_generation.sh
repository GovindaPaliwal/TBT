#! bin/bash

###########################################################################
##                                                                       ##
##                Centre for Development of Advanced Computing           ##
##                               Mumbai                                  ##
##                         Copyright (c) 2017                            ##
##                        All Rights Reserved.                           ##
##                                                                       ##
##  Permission is hereby granted, free of charge, to use and distribute  ##
##  this software and its documentation without restriction, including   ##
##  without limitation the rights to use, copy, modify, merge, publish,  ##
##  distribute, sublicense, and/or sell copies of this work, and to      ##
##  permit persons to whom this work is furnished to do so, subject to   ##
##  the following conditions:                                            ##
##   1. The code must retain the above copyright notice, this list of    ##
##      conditions and the following disclaimer.                         ##
##   2. Any modifications must be clearly marked as such.                ##
##   3. Original authors' names are not deleted.                         ##
##   4. The authors' names are not used to endorse or promote products   ##
##      derived from this software without specific prior written        ##
##      permission.                                                      ##
##                                                                       ##
##                                                                       ##
###########################################################################
##                                                                       ##
##                     TTS Building Toolkit                              ##
##                                                                       ##
##            Designed and Developed by Atish and Rachana                ##
##          		Date:  April 2017                                ##
##                                                                       ## 
###########################################################################

cd ..
rm -rf phone_level_lab/lab
cp -r Hybrid_Segmentation/output_lab_phone phone_level_lab/
mv phone_level_lab/output_lab_phone phone_level_lab/lab

cp resources/common/htsvoice/build_utts.c phone_level_lab/
cd phone_level_lab/
gcc build_utts.c -o build_utts

./build_utts
cd ..

rm -rf temp/htsvoice/utts
cp -r phone_level_lab/festival/utts temp/htsvoice/utts

echo -e "\n\n$(tput setaf 2)==Completed phoneme level UTT file generation==$(tput sgr0) \n\n"
