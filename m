Date: Fri, 11 Feb 2011 11:50:39 +0100 (CET)
From: Mauro Salvini <mauro.salvini@domain.hid>
Message-ID: <21119302.61297421436968.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <8218410.41297420786765.JavaMail.SYSTEM@pc-msalvini>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3_7408107.1297421436968"
Subject: [Xenomai-help] Signal mask inheritance
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

------=_Part_3_7408107.1297421436968
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi to all, 

I would build an application where only one of real-time tasks executes a custom signal handler to respond to a set of signals (ex SIGINT, SIGTERM). 
Xenomai tasks are also POSIX threads, so I think that at creation they inherits all signal masks and handlers from parent thread. 
So, what I can do in my app is reset signal mask to block all signals when new task starts. 
Can I block all signals or there are some signals (eg SIGWINCH) needed by Xenomai for inter-task communication? 

By the way, is there a method in Xenomai to initialize all RT_TASK structure fields without use field names (eg PTHREAD_MUTEX_INITIALIZER )? 
I use this simple define: 




------=_Part_3_7408107.1297421436968
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head><style type='text/css'>p { margin: 0; }</style></head><body><div style='font-family: Times New Roman; font-size: 12pt; color: #000000'>Hi to all,<br><br>I would build an application where only one of real-time tasks executes a custom signal handler to respond to a set of signals (ex SIGINT, SIGTERM).<br>Xenomai tasks are also POSIX threads, so I think that at creation they inherits all signal masks and handlers from parent thread. <br>So, what I can do in my app is reset signal mask to block all signals when new task starts.<br>Can I block all signals or there are some signals (eg SIGWINCH) needed by Xenomai for inter-task communication?<br><br>By the way, is there a method in Xenomai to initialize all RT_TASK structure fields without use field names (eg&nbsp; <tt>PTHREAD_MUTEX_INITIALIZER</tt>)?<br>I use this simple define:<br><br><br><br></div></body></html>
------=_Part_3_7408107.1297421436968--

