#!/bin/bash

awk '
BEGIN {
    cases=1;
    count=1;
    inputbase=10;
    outputbase=10;
    num1=0;
    num2=0;
}
{
    if (NR==1){
        cases=$0;
    }
    if (NR%3==2){
        inputbase=$1;
        outputbase=$2;
    }
    if (NR%3==0){
        #num1=0;
        for ( i=NF; i >=1 ; i--){
            var=$i-0;
            num1+=var*(inputbase^(NF-i));
            #print num1;
        }
        #print num1;
    }
    if (NR%3==1 && NR!=1){
        #num2=0;
        for ( i=NF; i >=1 ;i--){
            if ($i == "0"){
                var=0;
            }
            else if ($i == "1") {
                var=1;
            }
            else if ($i == "2") {
                var=2;
            }
            else if ($i == "3") {
                var=3;
            }
            else if ($i == "4") {
                var=4;
            }
            else if ($i == "5") {
                var=5;
            }
            else if ($i == "6") {
                var=6;
            }
            else if ($i == "7") {
                var=7;
            }
            else if ($i == "8") {
                var=8;
            }
            else if ($i == "9") {
                var=9;
            }
            else{
                var=$i+0;
            }
            num2+=var*(inputbase^(NF-i));
        }
        #print num2;
    }
    if (num1!=0 && num2!=0){
        ORS="";
        sum = num1+num2;
        i=0;
        while (sum!=0 ){
            took[i] = sum%outputbase;
            sum=int(sum/outputbase);
            i++;
        }
        for ( j=i-1;j>=0;j--) {
            if (j==0){
                print took[j]"\n";
            }
            else{
                print took[j]" ";
            }
        }
        num1=num2=0;
        sums[count]=sum;
        count++;
    }
    
}' bonus_sample_input.txt > bonus_output.txt