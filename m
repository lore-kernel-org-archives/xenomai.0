Date: Fri, 21 Jan 2011 18:01:26 +0100 (CET)
From: Michel Rinaldi <automation.03@domain.hid>
Message-ID: <22767829.221295629285203.JavaMail.SYSTEM@PC-MRINALDI>
In-Reply-To: <14515395.201295629170328.JavaMail.SYSTEM@PC-MRINALDI>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_21_29574853.1295629285187"
Subject: [Xenomai-help] Problems with rt_task_create and rt_task_join
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

------=_Part_21_29574853.1295629285187
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi to all, 

I'm running an application on a Linux system with kernel 2.6.35.7 patched with Xenomai 2.5.5.2, Adeos ipipe patch 2.7-04. 
My application uses native skin and creates some realtime tasks, each with rt_task_shadow(), each other with rt_task_create(). When I call for first time rt_task_create(), this function is very slow (700-800 ms) to execute, also if rt_task_shadow() calls come first. Subsequent calls of rt_task_create() are quick as expected. I read on manual that at first call rt_task_create() creates a signal handler for SIGWINCH signal: could be this operation that wastes time, maybe on waiting some resources from Linx kernel? 
Another problem that I've encountered is that if I call a rt_int_delete() and then a rt_task_join() on userspace task that handles destroyed IRQ, rt_task_join() never returns (obviously this task was created with joinable flag). If I create this task without joinable flag and then I call rt_task_delete() instead rt_task_join() I obtain two different behaviours: sometimes rt_task_delete() returns but I still view task on /proc/xenomai/sched (with X status), sometimes system freezes on this call. 
Thanks to all in advance. 
Regards 

Mauro Salvini 


------=_Part_21_29574853.1295629285187
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Times New Roman; font-size: 12pt; color: #000000'=
>Hi to all,<br><br>I'm running an application on a Linux system with kernel=
 2.6.35.7 patched with Xenomai 2.5.5.2, Adeos ipipe patch 2.7-04.<br>My app=
lication uses native skin and creates some realtime tasks, each with rt_tas=
k_shadow(), each other with rt_task_create(). When I call for first time rt=
_task_create(), this function is very slow (700-800 ms) to execute, also if=
 rt_task_shadow() calls come first. Subsequent calls of rt_task_create() ar=
e quick as expected. I read on manual that at first call rt_task_create() c=
reates a signal handler for SIGWINCH signal: could be this operation that w=
astes time, maybe on waiting some resources from Linx kernel? <br>Another p=
roblem that I've encountered is that if I call a rt_int_delete() and then a=
 rt_task_join() on userspace task that handles destroyed IRQ,&nbsp; rt_task=
_join() never returns (obviously this task was created with joinable flag).=
 If I create this task without joinable flag and then I call rt_task_delete=
() instead rt_task_join() I obtain two different behaviours: sometimes rt_t=
ask_delete() returns but I still view task on /proc/xenomai/sched (with X s=
tatus), sometimes system freezes on this call.<br>Thanks to all in advance.=
<br>Regards<br><br>Mauro Salvini<br><br></div></body></html>
------=_Part_21_29574853.1295629285187--

