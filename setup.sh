#!/bin/bash
version="2.1.0"

function installJava(){
  command -v apt >/dev/null 2>&1 && (apt-get update; apt-get install openjdk-8-jdk -y; return;)
  command -v yum >/dev/null 2>&1 && (yum install java-1.8.0-openjdk -y; return;)
}

function installUnzip(){
  command -v apt >/dev/null 2>&1 && (apt-get update; apt-get install unzip -y; return;)
  command -v yum >/dev/null 2>&1 && (yum install unzip -y; return;)
}

function download(){
  wget -O "/tmp/BILIBILI-HELPER.zip" "https://glare.now.sh/JunzhouLiu/BILIBILI-HELPER-PRE/BILIBILI-HELPER-v${1}.zip"
  mkdir "${HOME}/BILIBILI-HELPER"
  wget -O "/tmp/config.json" "https://cdn.jsdelivr.net/gh/zaxbpc0/BILIBILI-HELPER-PRE/src/main/resources/config_v210.json"
  command -v unzip >/dev/null 2>&1 || installUnzip
  unzip -o "/tmp/BILIBILI-HELPER.zip" -d "${HOME}/BILIBILI-HELPER"
  mv -f "${HOME}/BILIBILI-HELPER/BILIBILI-HELPER-v${1}.jar" "${HOME}/BILIBILI-HELPER/BILIBILI-HELPER.jar"
  mv -f "/tmp/config.json" "${HOME}/BILIBILI-HELPER/config.json"
  cd ${HOME}/BILIBILI-HELPER; ls -al
}

function setCron(){
  file="/var/spool/cron/${USER}"
  if [ ! -f "$file" ]; then
    touch "$file"
  else
    find=`grep "BILIBILI-HELPER" "$file"`
    if [ -z "$find" ]; then
      echo "" >> "$file"
	  echo "30 10 * * * cd ${HOME}/BILIBILI-HELPER; java -jar ./BILIBILI-HELPER.jar ${1} ${2} ${3} ${4} >>/var/log/cron.log 2>&1 &" >> "$file"
	  service crond reload
	  service cron reload
	fi
  fi
}

#read -p "请粘贴SESSDATA并回车:" SESSDATA
#read -p "请粘贴DEDEUSERID并回车:" DEDEUSERID
#read -p "请粘贴BILI_JCT并回车:" BILI_JCT
#read -p "请粘贴SCKEY并回车:" SCKEY

download $version
#setCron "${DEDEUSERID}" "${SESSDATA}" "${BILI_JCT}" "${SCKEY}"
command -v java >/dev/null 2>&1 || installJava
java -jar BILIBILI-HELPER.jar config.json
vim config.json

echo "执行完成"
