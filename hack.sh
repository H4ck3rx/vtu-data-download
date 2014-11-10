#!/bin/bash
echo "enter limit:"
read v
i=1
while [ $i -le $v ]
do
if [ $i -le 9 ]
then 
b=get_res.php?usn=4pa12cs00$i
a=http://results.vtualerts.com/$b
fi
if  [ $i -gt 9 -a $i -le 99  ]
then
b=get_res.php?usn=4pa12cs0$i
fi
a=http://results.vtualerts.com/$b
if [ $i -gt 99 ]
then
b=get_res.php?usn=4pa12cs$i
a=http://results.vtualerts.com/$b
fi

i=$((i+1))
wget "$a"
sed -e 's/<[^>]*>/ /g' $b > $b.c

 sed -n '/3 sem/,/&nbsp/p' $b.c >$i.txt
sed -i 's/&nbsp;//g' $i.txt
sed -i 's/Subject  External   Internal  Total  Result//g' $i.txt
 sed -i 's/  PREVIOUS SEM RESULTS     1 sem       2 sem       3 sem//g ' $i.txt
sed -i 's/CHECK YOUR CLASS RANK//g ' $i.txt
sed -i 's/CHECK OTHER USN//g ' $i.txt

sed -e 's/\s\s\s\s\s\s*/\n/g' $i.txt >> result.txt

done

i=1
while [ $i -le $v ]
do
if [ $i -le 9 ]
then 
b=get_res.php?usn=4pa12cs00$i
rm "$b"
fi
if  [ $i -gt 9 -a $i -le 99  ]
then
b=get_res.php?usn=4pa12cs0$i
rm "$b"
fi
if [ $i -gt 99 ]
then
b=get_res.php?usn=4pa12cs$i
rm "$b"
fi

i=$((i+1))
rm "$b.c"
rm "$i.txt"
done


 sed 1d result.txt > r.txt
 sed -i '1s/^/a,/g' r.txt

rm result.txt
sed -i 's/result://g ' r.txt
sed -e 's/  /,/g' r.txt>result.csv
sed 's/[^,]*,//' result.csv>r.csv
rm result.csv
awk -F"," '{print $1",",$2",",$3}' r.csv > as.csv
rm r.csv
rm r.txt
cat as.csv > as.txt
rm as.csv
sed 2d as.txt>av.txt
rm as.txt
sed 3d av.txt>as.txt
rm av.txt
sed 4d as.txt >as.csv
rm as.txt
cat as.csv>res.txt
rm as.csv
sed ':a;N;$!ba;s/\n/, /g' res.txt>rr.txt
sed -i 's/  /,  /g ' rr.txt
 
sed -i 's/, , , , , , , , , , , , /\n/g ' rr.txt 
sed -i 's/,/   /g ' rr.txt 
sed -i 's/\s\s\s\s\s\s\s\s*/,/g ' rr.txt
cat rr.txt>rr.csv
rm res.txt
rm rr.txt
echo "NAME,SEM,RESULT,SUB1,SUB2,SUB3,SUB4,SUB5,SUB6,SUB7,SUB8,TOTAL">x.txt
cat rr.csv>>x.txt
cat x.txt>>result.csv
rm rr.csv
rm x.txt
