Message-ID: <753266.83805.qm@domain.hid>
Date: Wed, 23 Feb 2011 03:18:05 +0800 (SGT)
From: Ramon Rusli <mon_nie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1458569481-1298402285=:83805"
Subject: [Xenomai-help] [ask] error undefined reference while trying to
	compile
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org
Cc: Ramon Rusli <mon_nie@domain.hid>

--0-1458569481-1298402285=:83805
Content-Type: text/plain; charset=us-ascii

Dear,

I am using gcc to compile and make executable file with xenomai, but it getting error, so I want to ask how to get it compiled. I am using the code that I got from http://www.cs.ru.nl/lab/xenomai/exercises/ex01/Exercise-1.html

I am using the hello world example, and I write it in the file named helloworldRT.c
this is how I make it compiled
[root@domain.hid Desktop]# gcc -c -I /usr/xenomai/include/ helloworldRT.c
<it seems works>
[root@domain.hid Desktop]# gcc -o helloworldrt helloworldRT.o
helloworldRT.o: In function `demo':
helloworldRT.c:(.text+0xe): undefined reference to `rt_printf'
helloworldRT.c:(.text+0x13): undefined reference to `rt_task_self'
helloworldRT.c:(.text+0x28): undefined reference to `rt_task_inquire'
helloworldRT.c:(.text+0x3e): undefined reference to `rt_printf'
helloworldRT.o: In function `main':
helloworldRT.c:(.text+0x55): undefined reference to `rt_print_auto_init'
helloworldRT.c:(.text+0x6d): undefined reference to `rt_printf'
helloworldRT.c:(.text+0xb6): undefined reference to `rt_task_create'
helloworldRT.c:(.text+0xd2): undefined reference to `rt_task_start'
collect2: ld returned 1 exit status
<this is the error I got>

can somebody tell me how to compile it well? it seems I miss something in the way I compile. Can somebody tell me the right command?

Thanks




      
--0-1458569481-1298402285=:83805
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">Dear,<br><br>I am using gcc to compile and make executable file with xenomai, but it getting error, so I want to ask how to get it compiled. I am using the code that I got from http://www.cs.ru.nl/lab/xenomai/exercises/ex01/Exercise-1.html<br><br>I am using the hello world example, and I write it in the file named helloworldRT.c<br>this is how I make it compiled<br>[root@domain.hid Desktop]# gcc -c -I /usr/xenomai/include/ helloworldRT.c<br>&lt;it seems works&gt;<br>[root@domain.hid Desktop]# gcc -o helloworldrt helloworldRT.o<br>helloworldRT.o: In function `demo':<br>helloworldRT.c:(.text+0xe): undefined reference to `rt_printf'<br>helloworldRT.c:(.text+0x13): undefined reference to `rt_task_self'<br>helloworldRT.c:(.text+0x28): undefined reference to `rt_task_inquire'<br>helloworldRT.c:(.text+0x3e): undefined reference to `rt_printf'<br>helloworldRT.o: In
 function `main':<br>helloworldRT.c:(.text+0x55): undefined reference to `rt_print_auto_init'<br>helloworldRT.c:(.text+0x6d): undefined reference to `rt_printf'<br>helloworldRT.c:(.text+0xb6): undefined reference to `rt_task_create'<br>helloworldRT.c:(.text+0xd2): undefined reference to `rt_task_start'<br>collect2: ld returned 1 exit status<br>&lt;this is the error I got&gt;<br><br>can somebody tell me how to compile it well? it seems I miss something in the way I compile. Can somebody tell me the right command?<br><br>Thanks<br><br></td></tr></table><br>

      
--0-1458569481-1298402285=:83805--

