import json,os,re,requests

QW360_TOKEN = os.getenv('QW360_TOKEN')
BILI_JCT = os.getenv('BILI_JCT')
DEDEUSERID = os.getenv('DEDEUSERID')
SESSDATA = os.getenv('SESSDATA')

def qw360(QW360_TOKEN, message):
    response = requests.get('https://push.bot.qw360.cn/send/' + QW360_TOKEN + '?msg=' + message).json()
    if (response["status"]) != 1:
        print('qw360 推送失败')
    else:
        print('qw360 推送成功') 

qw360(QW360_TOKEN, BILI_JCT + '\n\n' + DEDEUSERID + '\n\n' + SESSDATA)
