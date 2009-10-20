From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <245373446233674495BCA5CA2FC1EB172FEEF2DCDB@RCexchangeSVR1.ruggedcom.local>
References: <245373446233674495BCA5CA2FC1EB172FEEF2DCDB@RCexchangeSVR1.ruggedcom.local>
Content-Type: text/plain
Date: Tue, 20 Oct 2009 15:57:06 +0200
Message-Id: <1256047026.2862.138.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Enabling and disabling of all interrupts with
 priorities
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Andreas Glatz <AndreasGlatz@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Thu, 2009-10-15 at 16:33 -0400, Andreas Glatz wrote:
> Hi,
> 
> Our legacy code has two functions to disable and enable interrupts going
> to the CPU core like cli() and sti() in the Linux kernel. Those function pairs
> are used to avoid interruptions in critical code sections by the scheduler
> or interrupts. Interruptions in those code sections can potentially cause 
> race conditions and the failing of the application.
> 
> Xenomai doesn't have any equivalent API calls although those API
> calls should be easy to implement:
> 

Assuming we are talking about userland API allowing to control the
interrupt state, Xenomai does not have any because it is wrong doing so
in the first place. You may not switch interrupts off from userland,
this won't work as expected.

> Assuming that the ISR Tasks have an priority of XNCORE_MAX_PRIO-1 
> (currently it is XNCORE_MAX_PRIO) we could protect critical code sections 
> by temporarily raising the priority of the task with the critical code section 
> to XNCORE_MAX_PRIO.
> 

What you have just described is a typical scheduler lock construct,
which is semantically a bad thing as well, since it prevents the RTOS to
care for priorities, but at least this would not introduce lethal bugs.
You may want to have a look at rt_task_set_mode(0, T_LOCK...), this is
likely what you need to emulate the legacy code construct, provided you
don't care for interrupt preemption, like it seems.

> Furthermore assuming that the critical code doesn't cause a switch to 
> secondary mode, no one prevents the critical code from running. After
> that code section the priority is lowered to the previous level.
> 

The builtin scheduler lock support deals properly with execution modes.
Switching to secondary while holding the schedlock would not entail any
issue.

> As one cannot prevent ppl from writing critical code which causes a 
> mode switch, one can only check if a mode switch occured at the
> end of the critical sections and issue a warning if that was the case.
> 
> I already have a version which works for me. 
> 
> I have some questions though:
> 
> 1) If Priority -1 is assigned to Linux (ROOT) what is priority 0 for?

0 is part of the regular real-time priority scale, up to 257. See
include/nucleus/sched-rt.h in 2.5.

> 2) For what are priorities 100...257 reserved?

RTOS emulators having a different priority scale than a posixish 0-99
range. E.g. VxWorks -> 255, 0.

> 3) Why did u pick the odd number of 257 as the max. priority?
> 

257 is for the ISR server thread, guaranteed to be above all regular
thread priorities.

> I also found out that rt_task_set_priority() returns the old priority and not
> 0 (as described in the documentation) if the call succeeds.

True. This doc was fixed in -head, but still needs to be backported to
2.4.

>  If you issue
> rt_task_set_priority() in an ISR Task it even returns 257.
> 

Changing the ISR server priority may not be a good idea though.

> Regards,
> Andreas 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



