Message-ID: <4F29DE8A.3080009@domain.hid>
Date: Wed, 01 Feb 2012 19:53:30 -0500
From: Mitchell Tasman <tasman@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Handler executed on behalf of rtdm_nrtsig_pend()
 appears to be running in Linux hardirq, rather than softirq, context
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

Xenomai documents rtdm_nrtsig_pend() as follows:

> The signal handler will run in soft-IRQ context of the non-real-time subsystem. Note the implications of this context, e.g. no invocation of blocking operations.

As a result, I would have anticipated that when invoked from within the 
signal handler, in_irq() would return 0, while in_softirq() would return 
non-zero.

Instead, I've found that in_irq() returns the value 0x10000, which 
(digging around in include/linux/hardirq.h) indicates that the hardirq 
count is 1.

A partial Linux kernel stack backtrace, leading up to execution of the 
signal handler, is as follows:

> [  217.844177] [<bf031838>] (my_signalClient+0x24/0x48 [my_rtdm_driver]) from [<c00df42c>] (__ipipe_sync_stage+0x164/0x198)
> [  217.844207] [<c00df42c>] (__ipipe_sync_stage+0x164/0x198) from [<c0058960>] (ipipe_trigger_irq+0x14/0x20)
> [  217.844238] [<c0058960>] (ipipe_trigger_irq+0x14/0x20) from [<c011ca78>] (gatekeeper_thread+0x1ac/0x398)

It seems that there are at least several possibilities:

1.  I've misunderstood the documentation, and the signal handler is 
intended to run in Linux hardirq context.  If so, and I need softirq 
context, I'd need to schedule a tasklet from within the signal handler.

2.  There's something broken about my specific environment.  I am 
presently using a Beagleboard xM Rev C, running a TI 2.6.37-derived OMAP 
kernel from the staging tree on Arago, with a tailored (by me) version 
of the ARM I-pipe patchset for 2.6.37.6 that ships with Xenomai-2.6.0. 
The Xenomai version is also the as-released 2.6.0.

3.  I've discovered a bug (or feature) in the rtdm_nrtsig_pend() 
implementation and/or in the underlying plumbing.

Perhaps someone from the Xenomai community can comment.

Thanks much.



