# -*- coding: utf-8 -*-
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.header import Header
import time
import sys

def send_mail(receiver,path_send_file):
    sender = 'yz-ops@yingzi.com'
    receivers = [receiver]
 
    message = MIMEMultipart()
    message['From'] = Header("Data Sync", 'utf-8')
    message['To'] =  Header("zhangge", 'utf-8')
    subject = 'Error record of synchronous from Streamsets'
    message['Subject'] = Header(subject, 'utf-8')
 
    message.attach(MIMEText('This is the error records and their errorMessages when synchronous', 'plain', 'utf-8'))
    #send appendix with error records to receiver
    att1 = MIMEText(open(path_send_file, 'rb').read().decode('utf-8','ignore'), 'base64', 'utf-8')
    att1["Content-Type"] = 'application/octet-stream'
    att1["Content-Disposition"] = 'attachment; filename="error message"'
    message.attach(att1)
 

    try:
        smtpObj = smtplib.SMTP('smtp.yingzi.com',25)
        smtpObj.login('yz-ops@yingzi.com', 'Yzops666')
        smtpObj.sendmail(sender, receivers, message.as_string())
        localtime = time.asctime( time.localtime(time.time()) )
        print ("%s\t邮件发送成功" % localtime)
    except smtplib.SMTPException:
        localtime = time.asctime( time.localtime(time.time()) )
        print ("%s\tError: 无法发送邮件" % localtime)
