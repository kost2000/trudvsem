#!/bin/bash

# Требуется установить xmlstarlet и diff
# Выгрузка в тектовый файл statsus.csv данных из xml-файлов (отозванных заявлений) в текущей директории информацию: номер заявления, дата заяявления, статус, дате статуса, ФИО
# И сравнение предыдущей выгрузки с текущей, если есть разница записываем изменения в diff.txt (типа лог)

DIR=.
log=status.csv
mv $log $log.old

IFS=$'\n'
for file in `find $DIR -maxdepth 1 -type f -name "*.xml"`
do
dat=$(xmlstarlet sel -t -m //requestClientJobless -v requestNum -o ";" -v requestDate  -o ";" -v requestStatus -o ";" -v requestStatusDate -o ";" -v lastName  -o " " -v firstName -o " " -v middleName "$file")
#new="${file%/*}/$dat.xml"
#mv "$file" "$new"
echo $dat >> $log
done

DIFF_OUTPUT="$(diff  $log $log.old)"
if [ "0" != "${#DIFF_OUTPUT}" ]; then
    echo "= = = = = = = = = = = = = = = = ="
    echo "= = = = Есть изменения! = = = = ="
    echo "= = = = = = = = = = = = = = = = ="
    TIME=$(date +"%d/%m/%Y %T")
    echo "============================================" >>diff.txt
    echo $TIME >> diff.txt
    echo "============================================" >>diff.txt
    echo "${DIFF_OUTPUT}" >> diff.txt

fi
