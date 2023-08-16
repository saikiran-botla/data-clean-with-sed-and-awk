#!/bin/bash
awk '
BEGIN{
    count=0;
    ORS=" ";
}
{
    for(i=1;i<=NF;i++){
        if (tokens[$i]!="") {
            continue;
        }
        else{
            tokens[$i] = count;
            #print "token:",$i, tokens[$i];
            count++;
        }
    }
    for(i=1;i<=NF;i++){
       if(i==NF){
           ORS="\n";
       }
       print tokens[$i];
    }
    ORS=" ";
}' sample.txt >output.txt