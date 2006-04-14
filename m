Message-ID: <443FB205.6010400@domain.hid>
Date: Fri, 14 Apr 2006 10:30:29 -0400
From: Sean McGranaghan <smm@domain.hid>
MIME-Version: 1.0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Getting calling task id inside RTDM driver
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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="-1"><font face="Helvetica, Arial, sans-serif">Hello all,<br>
<br>
I am writing an RTDM driver that needs a simple task suspend/resume. I
have a simple ioctl() that needs to initiate some io and then sleep
until an interrupt occurs. I have been trying to use rt_task_suspend()
and rt_task_resume(). I tried to save the calling task id using
rt_task_self() inside open(). When I try to suspend the task in the
ioclt() rt_task_suspend() returns an EINVAL. (I looked at the code and
it appears to fail a magic number test.)<br>
<br>
I then compared the calling task id before the open() to the task id
inside open() and they are different. Is there a way to retrieve the
calling task id without explicitly sending it to the ioctl()?<br>
<br>
Sean<br>
</font></font>
</body>
</html>

