#!/bin/bash

#spam.txt
awk '
BEGIN {
    FS="[:|]"
}
{  
    if ( $1 == 1 ){
        for ( i=2; i<=NF; i++){
            if (class1[$i]==""){
                class1[$i]=1;
            }
            else {
                class1[$i]+=1;
            }
        }
    }
    else if ( $1 == 0 ){
        for ( i=1; i<=NF; i++){
            if (class2[$i]==""){
                class2[$i]=1;
            }
            else {
                class2[$i]+=1;
            }
        }
    }
}
END {
    n=0
    for ( i in class1) {
        print i, class1[i];
    }
}' sample.txt | sort -r -k2 > spam.txt

sed -i 's/ /-/g' spam.txt

awk '
BEGIN{ FS = "-"}
NR==FNR{
    tokens[$2]=$1;
}
NR>=1 && NR!=FNR{
    print tokens[$1],$2;
}
' word_token_mapping.txt spam.txt > spam1.txt ; mv spam1.txt spam.txt

sed -i 's/-/ /g' spam.txt

sort -k2,2nr -k1 spam.txt > spam1.txt ; mv spam1.txt spam.txt

var=$1
awk -v var="$var" '
{
    if (NR <=var ){
        print $1;
    }
}' spam.txt > spam1.txt ; mv spam1.txt spam.txt


#ham.txt

awk '
BEGIN {
    FS="[:|]"
}
{  
    if ( $1 == 1 ){
        for ( i=2; i<=NF; i++){
            if (class1[$i]==""){
                class1[$i]=1;
            }
            else {
                class1[$i]+=1;
            }
        }
    }
    if ( $1 == 0 ){
        for ( i=2; i<=NF; i++){
            if (class2[$i]==""){
                class2[$i]=1;
            }
            else {
                class2[$i]+=1;
            }
        }
    }
}
END {
    n=0
    for ( i in class2) {
        print i, class2[i];
    }
}' sample.txt | sort -r -k2 > ham.txt

sed -i 's/ /-/g' ham.txt

awk '
BEGIN{ FS = "-"}
NR==FNR{
    tokens[$2]=$1;
}
NR>=1 && NR!=FNR{
    print tokens[$1],$2;
}
' word_token_mapping.txt ham.txt > ham1.txt ; mv ham1.txt ham.txt

sed -i 's/-/ /g' ham.txt

sort -k2,2nr -k1 ham.txt > ham1.txt ; mv ham1.txt ham.txt

var=$1
awk -v var="$var" '
{
    if (NR <=var ){
        print $1;
    }
}' ham.txt > ham1.txt ; mv ham1.txt ham.txt