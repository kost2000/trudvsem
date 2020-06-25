#!/bin/bash
#
#               Загрузка xml-заявлений на пособие с портала Работа в России (https://adm.trudvsem.ru/) 
#
#
# Скрип предоставляется как есть, без всяких гарантий.

# логин и пароль от портала Работа в России
user="ЛОГИН"
pass="ПАРОЛЬ"
status="NEW"
#       Возможные статусы:
#
#NEW=Принято
#FILLING_APPLICATION=Дозаполнение / редактирование сведений
#IN_PROGRESS=Зарегистрировано
#REQUEST=Запрос сведений
#REQUEST_EMPTY=Сведений недостаточно
#JOB_OFFERED=Предложены вакансии
#APPROVED=Назначено пособие
#NOT_APPROVED=Отказано в пособии
#EMPLOYED=Трудоустроен
#REMOVED=Снят с учета
#DELETED=Заявление отозвано
#REREGISTRATION=Перерегистрация


# ОТ какой даты 
date2=01.01.2020
# 
#date2=`date '+%d.%m.%Y' -d '45 days ago'`
# ДО текущей  даты
date1=`date '+%d.%m.%Y'`






cookies=./cookies_trud.txt
useragent="Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36" 
date3=`date '+%d.%m.%Y %H:%M'`

count=$(curl -o /dev/null -L --user-agent "$useragent" -c $cookies -b $cookies -w '%{url_effective}' 'https://adm.trudvsem.ru/' |  cut -d? -f 2)

#echo $count


curl -L -c $cookies -b $cookies --user-agent "$useragent" 'https://adm.trudvsem.ru/login?'$count'-1.IFormSubmitListener-signInForm' \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Cache-Control: no-cache' \
  -H 'Origin: https://adm.trudvsem.ru' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'DNT: 1' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Referer: https://adm.trudvsem.ru/login?1' \
  -H 'Accept-Language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7' \
  --data 'username='$user'&password='$pass \
  --compressed > /dev/null

count=$(curl -o /dev/null -L -c $cookies -b $cookies -b "joblessListPage.itemsPerPage=100" -w '%{url_effective}' --user-agent "$useragent" 'https://adm.trudvsem.ru/szn/szn.jobless.list' |  cut -d? -f 2)



curl -L -c $cookies -b $cookies --user-agent "$useragent"  'https://adm.trudvsem.ru/szn/szn.jobless.list?'$count'-1.IBehaviorListener.0-actions-list-1-item-button' \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Cache-Control: no-cache' \
  -H 'DNT: 1' \
  -H 'Wicket-FocusedElementId: id65' \
  -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'Accept: application/xml, text/xml, */*; q=0.01' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'Wicket-Ajax: true' \
  -H 'Wicket-Ajax-BaseURL: szn/szn.jobless.list' \
  -H 'Origin: https://adm.trudvsem.ru' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Accept-Language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7' \
  --data 'id1b_hf_0=&groups%3Agroup-1%3Aitems%3Aitem-2%3Ainput%3Astatus='$status'&groups%3Agroup-1%3Aitems%3Aitem-3%3Ainput%3Afio=&groups%3Agroup-1%3Aitems%3Aitem-4%3Ainput%3Asnils=&groups%3Agroup-2%3Aitems%3Aitem-2%3Ainput%3AdateFrom='$date2'&groups%3Agroup-2%3Aitems%3Aitem-3%3Ainput%3AdateTo='$date1'&groups%3Agroup-2%3Aitems%3Aitem-4%3Ainput%3Anumber=&actions%3Alist%3A1%3Aitem%3Abutton=1' \
  --compressed > list-0.html

grep "szn.jobless.card" list-0.html |  cut  -c 191-280|   sed  "s/\&amp\;/\&/"    > list-0.txt
cp list-0.txt listall.txt




count1=1
while true 
    do 
#echo "========================================================="
curl -L -c $cookies -b $cookies --user-agent "$useragent"  'https://adm.trudvsem.ru/szn/szn.jobless.list?'$count'-1.IBehaviorListener.0-result-pagingNavigator-next&_=1591764474306' \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Cache-Control: no-cache' \
  -H 'Accept: application/xml, text/xml, */*; q=0.01' \
  -H 'DNT: 1' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'Wicket-Ajax-BaseURL: szn/szn.jobless.list?3' \
  -H 'Wicket-Ajax: true' \
  -H 'Wicket-FocusedElementId: id4f' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Referer: https://adm.trudvsem.ru/szn/szn.jobless.list?2' \
  -H 'Accept-Language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7' \
  --compressed > list-${count1}.html

    grep "szn.jobless.card" list-${count1}.html |  cut  -c 191-280|   sed  "s/\&amp\;/\&/"    > list-${count1}.txt

    if [ ! -s  list-${count1}.txt ]
	then
	echo "empty file"
	break
    fi
    let "n = $count1 - 1"
    
#    echo $n++++++++++++++++++++++++$count1
    DIFF=$(diff list-${count1}.txt list-${n}.txt)
    if [ "$DIFF" = "" ]
    then 
    rm list-${count1}.txt
    break
    fi

    cat list-${count1}.txt >> listall.txt
    echo 
    count1=$((count1+1))
    done


if [ -s listall.txt ]
then

count=$(curl -o /dev/null -L -c $cookies -b $cookies -w '%{url_effective}' 'https://adm.trudvsem.ru/' | cut -d? -f 2)

for f in  `cat listall.txt`
    do
    URL1="https://adm.trudvsem.ru/szn.jobless.card?$count&$f"
    count=$(curl  -o /dev/null -L -c $cookies -b $cookies -w '%{url_effective}' $URL1 | grep -o -P '(?<=\?).*(?=\&id_client)' )    #remarka '
#    URL="https://adm.trudvsem.ru/szn.jobless.card?"$count"-1.ILinkListener-editForm-tabsPanel-panelsContainer-panels-1-groupsPanel-5-itemsPanel-download-download-download&"$f
    URL="https://adm.trudvsem.ru/szn.jobless.card?"$count"-1.ILinkListener-editForm-tabsPanel-panelsContainer-panels-1-groupsPanel-4-itemsPanel-download-download-download&"$f

    curl  -L -O -J -c $cookies -b $cookies --user-agent "$useragent" $URL
    done

fi
rm list*.*
rm $cookies
