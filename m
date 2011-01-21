From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <22767829.221295629285203.JavaMail.SYSTEM@PC-MRINALDI>
References: <22767829.221295629285203.JavaMail.SYSTEM@PC-MRINALDI>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 Jan 2011 18:11:35 +0100
Message-ID: <1295629895.1828.59.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel Rinaldi <automation.03@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2011-01-21 at 18:01 +0100, Michel Rinaldi wrote:
> Hi to all,
> 
> I'm running an application on a Linux system with kernel 2.6.35.7
> patched with Xenomai 2.5.5.2, Adeos ipipe patch 2.7-04.
> My application uses native skin and creates some realtime tasks, each
> with rt_task_shadow(), each other with rt_task_create().

Sorry, -ENOPARSE. rt_task_shadow() is usually invoked from the main
thread to make it a Xenomai thread, rt_task_create is normally used to
create more tasks. Who is doing what in your code exactly? How many
times is rt_task_shadow() invoked?

>  When I call for first time rt_task_create(), this function is very
> slow (700-800 ms) to execute, also if rt_task_shadow() calls come
> first. Subsequent calls of rt_task_create() are quick as expected. I
> read on manual that at first call rt_task_create() creates a signal
> handler for SIGWINCH signal: could be this operation that wastes time,
> maybe on waiting some resources from Linx kernel? 

No, can't be that long. Something looks wrong in your application init.

> Another problem that I've encountered is that if I call a
> rt_int_delete() and then a rt_task_join() on userspace task that
> handles destroyed IRQ,  rt_task_join() never returns (obviously this
> task was created with joinable flag). If I create this task without
> joinable flag and then I call rt_task_delete() instead rt_task_join()
> I obtain two different behaviours: sometimes rt_task_delete() returns
> but I still view task on /proc/xenomai/sched (with X status),
> sometimes system freezes on this call.

Make sure to test the return values of ALL Xenomai syscalls in your app,
particularly what rt_intr_wait() sends you back, and make sure to break
out from your work loop whenever it signals any error.

> Thanks to all in advance.
> Regards
> 
> Mauro Salvini
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



