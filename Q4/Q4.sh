#!/bin/bash

start=$1
end=$2

awk -v start="$start", -v end="$end" ' 
BEGIN{
    FS="\t";
    split(end,e,":");
    split(start,s,":");
    endtime=(e[1]-s[1]+0)*3600 + (e[2]-s[2]+0)*60 + (e[3]-s[3]+0);
}
{if(NR!=1){
    split($NF,b,",| ");
    split(b[3],a,":");
    status=$2;
    
    name=$1;
    
    a[1]=a[1]+0; a[2]=a[2]+0; a[3]=a[3]+0;

    time=(a[1]-s[1])*3600 + (a[2]-s[2])*60 + (a[3]-s[3]) ;   

    if (status=="Joined") {
        if (time<0){
            time=0;
        }
        store[name]=time;
    }
    else if (status=="Left") {
        if (time > endtime){
            time=endtime;
        }
        t[name]+=(time-store[name]);
        store[name]=-1;
    }
}
}
END{
    
    for ( i in store){
        if (store[i]!=-1){
            t[i]+= (endtime-store[i]);
            store[i]=-1;
        }
    }

    for ( i in t){
        hr=int(t[i]/3600);
        min=int((t[i]-hr*3600)/60);
        sec=(t[i]-hr*3600-min*60);

        if (int(hr/10)==0){
            hr="0" hr;
        }
        if (int(min/10)==0){
            min="0" min;
        }
        if (int(sec/10)==0){
            sec="0" sec;
        }
        print i "\t" hr":"min":"sec;
    }
}' sample.csv | sort -k1 > output.txt