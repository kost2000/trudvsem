#!/bin/bash

# Требуется установить xmlstarlet
# Выгрузка в тектовый файл statsus.csv данных из xml-файлов в текущей директории информацию: номер заявления, дата заяявления, статус, дате статуса, ФИО

DIR=.
log=statsus.csv
rm $log
IFS=$'\n'
for file in `find $DIR -maxdepth 1 -type f -name "*.xml"`
do
dat=$(xmlstarlet sel -t -m //requestClientJobless -v requestNum -o ";" -v requestDate  -o ";" -v requestStatus -o ";" -v requestStatusDate -o ";" -v lastName  -o " " -v firstName -o " " -v middleName "$file")
#new="${file%/*}/$dat.xml"
#mv "$file" "$new"
echo $dat >> $log
done
