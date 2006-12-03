Subject: Re: =?ISO-8859-1?Q?R=E9p=2E?= : Re: [Xenomai-help]  Switch mode
	with x86
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45733D1B.7010805@domain.hid>
References: <s56d88c0.099@domain.hid>  <45732660.6050605@domain.hid>
	<1165175999.4952.431.camel@domain.hid>  <45733D1B.7010805@domain.hid>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 00:30:55 +0100
Message-Id: <1165188655.4952.457.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2006-12-03 at 22:09 +0100, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Sun, 2006-12-03 at 20:32 +0100, Jan Kiszka wrote:
> >> Nicolas BLANCHARD wrote:
> >>>>>>> "Nicolas BLANCHARD" <n.blanchard@domain.hid> 29.11 11:25 >>>
> >>>> Hello,
> >>>>
> >>>> I've tested wiith Xenomai 2.3-rc2 (adeos 1.5-02)
> >>>> and change the config : 
> >>>>                                        - CONFIG_M586
> >>>>                                        - disable CONFIG_INPUT_PCSPKR
> >>> (it was on module)
> >>>>                                        - disable prio boosting (check
> >>> CONFIG_XENO_OPT_RPDISALBLE)
> >>>> and it seems to work better, one hour without blocking, it's a record
> >>>> for me.
> >>>>
> >>>> So, i will investigate to find which modification improve my problem.
> >>> After somes tests (kernel compil), it seems that prio boost is
> >>> responsable of my
> >>> problem. When it's disable (kernel option checked) my program run
> >>> correctly.
> >> Confirmed!
> >>
> >> root@domain.hid :/root# cat /proc/xenomai/sched
> >> CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
> >>   0  0       99      0        0          R          ROOT
> >>   0  837     99      9999312  0          X          TASK1
> >>   0  838      0      10999998 0          R          TASK2
> >>
> >> So far "only" on real hardware (P-I 133) with CONFIG_M586 and (this is
> >> likely also very important) CONFIG_PREEMPT. I'm now about to check if I
> >> can migrate this problem into qemu and/or capture it with the I-pipe tracer.
> >>
> > 
> > Please also try moving task2 to the SCHED_FIFO class to see if things
> > evolve.
> > 
> 
> Here is the Xenomai scheduling sequence that leads to the deadlock. I
> raised the frequency of TASK2 a bit, and this seems to accelerate the
> lock-up.
> 
> ...
> > :|  *+[  844] TASK2    1 -5061+   4.436  xnpod_resume_thread+0x48 (gatekeeper_thread+0xf7)
> > :|  *+[  827] sshd    -1 -5055+   4.015  xnpod_schedule_runnable+0x45 (gatekeeper_thread+0x12e)

Damnit. What about this?

--- ksrc/nucleus/shadow.c~	2006-11-19 11:09:00.000000000 +0100
+++ ksrc/nucleus/shadow.c	2006-12-04 00:29:13.000000000 +0100
@@ -551,9 +551,6 @@
 			thread->sched = xnpod_sched_slot(cpu);
 #endif /* CONFIG_SMP */
 			xnpod_resume_thread(thread, XNRELAX);
-#ifndef CONFIG_XENO_OPT_RPIDISABLE
-			xnpod_renice_root(XNPOD_ROOT_PRIO_BASE);
-#endif /* CONFIG_XENO_OPT_RPIDISABLE */
 #ifdef CONFIG_XENO_OPT_ISHIELD
 			disengage_irq_shield();
 #endif /* CONFIG_XENO_OPT_ISHIELD */

-- 
Philippe.



