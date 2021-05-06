#!/bin/bash

# выгрузка в тектовый файл данных из xml-файлов в текущей директории информации: номер заявления, дата заяявления, статус, дате статуса

DIR=.
log=log.txt
rm $log
IFS=$'\n'
for file in `find $DIR -maxdepth 1 -type f -name "*.xml"`
do
dat=$(xmlstarlet sel -t -m //requestClientJobless -v requestNum -o ";" -v requestDate  -o ";" -v requestStatus -o ";" -v requestStatusDate -o ";" -v lastName  -o " " -v firstName -o " " -v middleName "$file")
#new="${file%/*}/$dat.xml"
#mv "$file" "$new"
echo $dat >> $log
done
