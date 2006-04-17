Message-ID: <4443899A.4010004@domain.hid>
Date: Mon, 17 Apr 2006 08:27:06 -0400
From: Sean McGranaghan <smm@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Getting calling task id inside RTDM driver
References: <443FB205.6010400@domain.hid>
	<200604142155.12772.Sebastian.Smolorz@domain.hid>
In-Reply-To: <200604142155.12772.Sebastian.Smolorz@domain.hid>
Content-Type: text/html; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: xenomai@xenomai.org

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=iso-8859-15"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<font size="-1"><font face="Helvetica, Arial, sans-serif">After posting
I performed a two tests, first using an RTDM event and then using a
semaphore as described below. The synchronization worked in both cases,
but I think I have another problem. On exit my test application
generates a segmentation fault, but only occasionally. I do not get a
stack dump in the kernel log and the system does not seem to become
unstable. I tried running my test application under strace and gdb. In
both cases I could not reproduce the error. I am installing the latest
version of Xenomai and adding debugging options to the build. I will
post when I know more.<br>
<br>
Any suggestions on which Xenomai and kernel options to set for
debugging?<br>
<br>
Thanks,<br>
Sean<br>
<br>
</font></font>Sebastian Smolorz wrote:
<blockquote
 cite="mid200604142155.12772.Sebastian.Smolorz@domain.hid"
 type="cite">
  <pre wrap="">Am Freitag 14. April 2006 16:30 schrieb Sean McGranaghan:

  </pre>
  <blockquote type="cite">
    <pre wrap="">I am writing an RTDM driver that needs a simple task suspend/resume. I
have a simple ioctl() that needs to initiate some io and then sleep
until an interrupt occurs. I have been trying to use rt_task_suspend()
and rt_task_resume().
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Try to avoid using skin functions other than those of RTDM inside drivers. 
Your problem can be solved with a semaphore with an initial value of 0. A  
rtdm_sem_down will make your task sleep. Inside the interrupt handler a 
rtdm_sem_up will wake up your task (after the interrupt handler has exited).

Sebastian


  </pre>
</blockquote>
</body>
</html>

