---
layout: post
category : Python
title: Python Scripts
tagline: ""
tags : [Python, Scripts]
---
{% include JB/setup %}


http://www.cnblogs.com/levenyes/p/4003681.html


需要特别提出的几个点

第一，因为需要实现开机自启动，所以要把python文件复制到系统的“启动”文件夹里。

第二，由于.py文件启动后会有控制台界面出现，非常影响使用效果，因此要把.py文件的后缀改成.pyw。

第三，不需要担心如果自己想要用电脑的话会受到这个限制，只要在开机六分钟内把python进程关掉即可


    #! /usr/bin/env python

    #coding=utf-8

    import os 
    import time   
    import datetime   

    #根据是否工作日设置限制时间
    if datetime.date.today().weekday()<5:
        timeLimit = 20
    else:
        timeLimit = 40

    #读取文本中记录的日期
    f = open('E:\\thefile.txt','r+')
    f_date = f.readline()
    f.close

    #读取系统日期，并与文本日期进行比对
    #如果不相等，则清空文件，进行当日初始化
    n_date = time.strftime("%d/%m/%Y")+"\n"
    if f_date != n_date:
        print("sucessed")
        f = open('E:\\thefile.txt','r+')
        f.truncate()
        f.close
        f = open('E:\\thefile.txt','r+')
        f.write((n_date))
        run_time="0"
        f.write(run_time)
        f.close

    #死循环语句，当且仅当运行时间大于等于限制时间时跳出循环
    while 2 > 1 :
        f = open('E:\\thefile.txt','r+')
        f_date = f.readline()
        run_time = f.readline()
        run = int(run_time)
        time.sleep(360)
        if run<timeLimit:
            run = run + 1
            f.truncate()
            f.close
            f = open('E:\\thefile.txt','r+')
            f.write(f_date)
            run_time = str(run)
            f.write(run_time)
            f.close
        else:
            break

    #关机命令       
    cmd="cmd.exe /k shutdown -s -t 0";

    #执行关机命令
    os.system(cmd)


　周一到周五，能用电脑的时间最多只能是两个小时；而周末，则是四个小时。
