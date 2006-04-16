Message-ID: <44424EAD.1080707@domain.hid>
Date: Sun, 16 Apr 2006 16:03:25 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Getting calling task id inside RTDM driver
References: <443FB205.6010400@domain.hid>
In-Reply-To: <443FB205.6010400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Sean McGranaghan <smm@domain.hid>
Cc: xenomai@xenomai.org

Sean McGranaghan wrote:
> Hello all,
> 
> I am writing an RTDM driver that needs a simple task suspend/resume. I 
> have a simple ioctl() that needs to initiate some io and then sleep 
> until an interrupt occurs. I have been trying to use rt_task_suspend() 
> and rt_task_resume(). I tried to save the calling task id using 
> rt_task_self() inside open(). When I try to suspend the task in the 
> ioclt() rt_task_suspend() returns an EINVAL. (I looked at the code and 
> it appears to fail a magic number test.)
> 

Object descriptors must be exclusively used in the execution space (i.e. 
kernel or user) they have been obtained from. Those descriptors are only 
containers of some data pointing at the indexed object, therefore they 
can be mapped at distinct addresses whilst still representing the same 
object -- and they actually do when they belong to different execution 
spaces.

> I then compared the calling task id before the open() to the task id 
> inside open() and they are different. Is there a way to retrieve the 
> calling task id without explicitly sending it to the ioctl()?

suspend/resume are going to be racy for synchronization purpose. It 
would be better to use RTDM services (e.g. sema4s), which would fix the 
current issue in the same move.

> 
> Sean
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

