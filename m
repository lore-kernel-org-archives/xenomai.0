Date: Fri, 11 Feb 2011 12:00:54 +0100 (CET)
From: Mauro Salvini <mauro.salvini@domain.hid>
Message-ID: <14109749.81297422048953.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <21119302.61297421436968.JavaMail.SYSTEM@pc-msalvini>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4_24846731.1297422048953"
Subject: Re: [Xenomai-help] Signal mask inheritance
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

------=_Part_4_24846731.1297422048953
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


I apologize for latter message, my client decides to automatically send it before completion... 

I rewrite it here: 

Hi to all, 

I would build an application where only one of real-time tasks executes a custom signal handler to respond to a set of signals (ex SIGINT, SIGTERM). 
Xenomai tasks are also POSIX threads, so I think that at creation they inherits all signal masks and handlers from parent thread. 
So, what I can do in my app is reset signal mask to block all signals when new task starts. 
Can I block all signals or there are some signals (eg SIGWINCH) needed by Xenomai for inter-task communication? 

By the way, is there a method in Xenomai to initialize all RT_TASK structure fields without use field names (eg PTHREAD_MUTEX_INITIALIZER )? 
I use this simple define: 

#define RT_TASK_RESET(task) task.opaque=0 , task.opaque2=0 

but it works only for kernel tasks (in include/native/task.h RT_TASK structure isn't the same for kernel/non kernel tasks). 
I think that a struct initializer into library could be a next feature. 

Thank you,regards. 

------=_Part_4_24846731.1297422048953
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Times New Roman; font-size: 12pt; color: #000000'=
><style>=C2=A0{ margin: 0; }</style><div style=3D"font-family: Times New Ro=
man; font-size: 12pt; color: rgb(0, 0, 0);">I apologize for latter message,=
 my client decides to automatically send it before completion...<br><br>I r=
ewrite it here:<br><br>Hi to all,<br><br>I would build an application where=
 only one of real-time tasks executes a custom signal handler to respond to=
 a set of signals (ex SIGINT, SIGTERM).<br>Xenomai tasks are also POSIX thr=
eads, so I think that at creation they inherits all signal masks and handle=
rs from parent thread. <br>So, what I can do in my app is reset signal mask=
 to block all signals when new task starts.<br>Can I block all signals or t=
here are some signals (eg SIGWINCH) needed by Xenomai for inter-task commun=
ication?<br><br>By the way, is there a method in Xenomai to initialize all =
RT_TASK structure fields without use field names (eg&nbsp; <tt>PTHREAD_MUTE=
X_INITIALIZER</tt>)?<br>I use this simple define:<br><br>#define RT_TASK_RE=
SET(task) task.opaque=3D0 , task.opaque2=3D0<br><br>but it works only for k=
ernel tasks (in include/native/task.h RT_TASK structure isn't the same for =
kernel/non kernel tasks).<br>I think that a struct initializer into library=
 could be a next feature.<br><br>Thank you,regards.<br></div></div></body><=
/html>
------=_Part_4_24846731.1297422048953--

