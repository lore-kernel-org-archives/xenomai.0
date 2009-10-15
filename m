From: Andreas Glatz <AndreasGlatz@domain.hid>
Date: Thu, 15 Oct 2009 16:33:55 -0400
Message-ID: <245373446233674495BCA5CA2FC1EB172FEEF2DCDB@RCexchangeSVR1.ruggedcom.local>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-core] Enabling and disabling of all interrupts with
	priorities
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

Hi,

Our legacy code has two functions to disable and enable interrupts going
to the CPU core like cli() and sti() in the Linux kernel. Those function pa=
irs
are used to avoid interruptions in critical code sections by the scheduler
or interrupts. Interruptions in those code sections can potentially cause=20
race conditions and the failing of the application.

Xenomai doesn't have any equivalent API calls although those API
calls should be easy to implement:

Assuming that the ISR Tasks have an priority of XNCORE_MAX_PRIO-1=20
(currently it is XNCORE_MAX_PRIO) we could protect critical code sections=20
by temporarily raising the priority of the task with the critical code sect=
ion=20
to XNCORE_MAX_PRIO.

Furthermore assuming that the critical code doesn't cause a switch to=20
secondary mode, no one prevents the critical code from running. After
that code section the priority is lowered to the previous level.

As one cannot prevent ppl from writing critical code which causes a=20
mode switch, one can only check if a mode switch occured at the
end of the critical sections and issue a warning if that was the case.

I already have a version which works for me.=20

I have some questions though:

1) If Priority -1 is assigned to Linux (ROOT) what is priority 0 for?
2) For what are priorities 100...257 reserved?
3) Why did u pick the odd number of 257 as the max. priority?

I also found out that rt_task_set_priority() returns the old priority and n=
ot
0 (as described in the documentation) if the call succeeds. If you issue
rt_task_set_priority() in an ISR Task it even returns 257.

Regards,
Andreas =

