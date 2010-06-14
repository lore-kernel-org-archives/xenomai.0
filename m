Message-ID: <4C1672ED.4080101@domain.hid>
Date: Mon, 14 Jun 2010 20:20:29 +0200
From: Ramon <ramoncostacastello@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------010903030502010905090206"
Subject: [Xenomai-help] rt_task_set_periodic
Reply-To: ramoncostacastello@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010903030502010905090206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm beginning to work with periodical task in xenomai. Currently I'm 
using rt_task_set_periodic.

The third parameter RTIME period allows to specify the period in  clock 
ticks (taken from : 
http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__task.html).

I would like to know how can I get information from the clock tick 
(which is the value? , can be changed ?) ?

Why Is the minimum period I can use in user space ? (experimentally it 
seems to be 0.1ms in my system)
Working in kernel space this period is lower ?


When using the POSIX skin
int pthread_make_periodic_np    (    pthread_t     thread,struct 
timespec *     starttp,struct timespec *     periodtp    )
the resolution is the same ? (performance will be the same ?)

Is there any simple approach to develop a periodic task using the POSIX 
     commands (pthread_cond_timedwait 
<group__posix__cond.html#gfc43955fc3f1cb43723a9e0be19d0ad1> ?) ?



Thank you in advance
Ramon

--------------010903030502010905090206
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi,<br>
<br>
I'm beginning to work with periodical task in xenomai. Currently I'm
using rt_task_set_periodic.<br>
<br>
The third parameter RTIME period allows to specify the period in&nbsp; clock
ticks (taken from : <a
 href="http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__task.html">http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__task.html</a>).<br>
<br>
I would like to know how can I get information from the clock tick
(which is the value? , can be changed ?) ?<br>
<br>
Why Is the minimum period I can use in user space ? (experimentally it
seems to be 0.1ms in my system)<br>
Working in kernel space this period is lower ?<br>
<br>
<br>
When using the POSIX skin<br>
int pthread_make_periodic_np&nbsp;&nbsp;&nbsp; (&nbsp;&nbsp;&nbsp; pthread_t &nbsp;&nbsp;&nbsp; thread,struct
timespec * &nbsp;&nbsp;&nbsp; starttp,struct timespec * &nbsp;&nbsp;&nbsp; periodtp&nbsp;&nbsp;&nbsp; ) <br>
the resolution is the same ? (performance will be the same ?)<br>
<br>
Is there any simple approach to develop a periodic task using the POSIX
&nbsp;&nbsp;&nbsp; commands (<span class="Apple-style-span"
 style="border-collapse: separate; color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; font-size: medium;"><span
 class="Apple-style-span"
 style="font-family: Geneva,Arial,Helvetica,sans-serif; font-size: 13px;"><a
 class="el"
 href="group__posix__cond.html#gfc43955fc3f1cb43723a9e0be19d0ad1"
 style="color: rgb(26, 65, 168); text-decoration: none; font-weight: bold; background-color: rgb(242, 242, 255);">pthread_cond_timedwait</a><span
 class="Apple-converted-space"> ?</span></span></span>) ? <br>
<br>
<br>
<br>
Thank you in advance<br>
Ramon<br>
</body>
</html>

--------------010903030502010905090206--

