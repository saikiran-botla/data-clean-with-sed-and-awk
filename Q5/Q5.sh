#!/bin/bash

awk '
BEGIN{
    FS="<|>";
    count=0;
    num=0;
}
NR==FNR{
    if (NR>=405 && NR%4==1 && NR <=545){
        num++;
        name[num]=$11;
        cases[num]=$27;
    }
}
NR!=FNR{
    count++;
    states[count]=$1;
}
END{
    for ( i=1; i <= num; i++){
        for ( j=1; j <= count; j++){
            if (index(states[j],name[i])){
                printf("%s %d\n",name[i],cases[i]);
            }
        }
    }
}' covid_status.html sample.txt > output.txt