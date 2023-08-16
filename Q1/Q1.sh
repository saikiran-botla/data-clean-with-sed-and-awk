#!/bin/bash

sed -e '/^$/d' -e 's!http[s]\?://\S*!!g' -e 's/www\.\S*//g' -e 's/[[:punct:]]\+//g' -e 's/[^[:print:]\t]//g' -e 's/[A-Z]/\L&/g' sample.txt > output.txt

for i in $(cat stopwords.txt) 
do
    sed -i "s/\<$i\>//g" output.txt
done

sed -ri -e 's/[0-9]*//g' -e 's/\s+/ /g' -e 's/^[ \t]*//' -e 's/ [a-z]{1,2} / /g' output.txt


sed -ri -e '/^$/d' -e 's/\s+/ /g' output.txt
#sed -E 's/\b\w{1,2}\b[[:blank:]]*//g' output.txt > output1.txt ; mv output1.txt output.txt
sed -Ei 's/\b\w{1,2}\b[[:blank:]]*//g' output.txt

for i in $(cat suffixes.txt) 
do
    sed -ir "s/${i}\b/1/g" output.txt
done
sed -ir -e 's/1//g' -e 's/\s+/ /g' -e 's/[ \t]*$//' output.txt

rm output.txtr