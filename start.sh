#!/bin/bash

source /etc/profile 
source ~/.bashrc 
source ~/.zshrc #其他终端请自行引入环境变量
echo $PATH
java -jar ${HOME}/BILIBILI-HELPER/BILIBILI-HELPER.jar ${HOME}/BILIBILI-HELPER/config.json >> /var/log/bilibili-help.log
# 注意将jar包路径替换为实际路径。将参数修改该你自己的参数，cookies中含有等特殊字符需要转义。
