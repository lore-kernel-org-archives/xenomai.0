Message-ID: <4656F037.4040704@domain.hid>
Date: Fri, 25 May 2007 16:18:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4656E62F.3090603@domain.hid> <4656E887.7040406@domain.hid>	
	<4656EABD.60601@domain.hid> <1180102373.20410.103.camel@domain.hid>
In-Reply-To: <1180102373.20410.103.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [BUG] recursive fault on cyclictest termination
 --	scalable sched?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Fri, 2007-05-25 at 15:55 +0200, Jan Kiszka wrote:
> 
>>Gilles Chanteperdrix wrote:
>>
>>>Jan Kiszka wrote:
>>>
>>>>People, we have some new troubles:
>>>>
>>>>I'm reproducibly getting recursive faults on termination of cyclictest
>>>>via ^C. It's all standard here: ipipe 1.8-02, Xenomai trunk #2469, no
>>>>weird patches of mine.
>>>>
>>>>Something goes utterly wrong, the debugger currently points into
>>>>xnshadow_relax->rpi_push, and there into some queuing operation. Note
>>>>that I have XENO_OPT_SCALABLE_SCHED on in my config, also
>>>>XENO_OPT_PRIOCPL. Without XENO_OPT_SCALABLE_SCHED, things seems to work
>>>>find. Who did last work on this? What was fixed?
>>>
>>>Looking at svn log, you did the last modification. What about activating
>>>queue debugging ?
>>>
>>
>>Well, I remember that 64-bit issue now, but it was my patch IIRC.
>>
>>Anyway, good suggestion:
>>
>>T: 0 (  824) P:99 I:    1000 C:    1483 Min:       3 Act:     349 Avg:    1602 Max:    3240
>>[  474.912841] Xenomai: fatal: corrupted queue, qslot->elems=0, qslot=c0614a28 at include/xenomai/nucleus/queue.h:684
>>[  474.912921]  CPU  PID    PRI      TIMEOUT  STAT      NAME
>>[  474.912941]    0  0       -1      0        00500088  ROOT
>>[  474.912960]    0  823      0      0        00300380  cyclictest
>>[  474.912980] >  0  824      0      0        00300180  cyclictest
>>[  474.913000] Master time base: clock=1043585105469
>>[  474.913017] 
>>[  474.915241]        c11e7eb4 00000000 00000000 c0614a28 c11e7ed8 c0104c6e c033f860 00000000 
>>[  474.915762]        00000103 c11e7f18 c0154f02 c033fd86 c115c000 c0614a28 c03428c4 000002ac 
>>[  474.916378]        c015657d 00000000 c1180b30 ffffffff c1180d94 00000000 c1180b30 00000000 
>>[  474.916874] Call Trace:
>>[  474.917034]  [<c010451a>] show_trace_log_lvl+0x1a/0x30
>>[  474.917422]  [<c01045e1>] show_stack_log_lvl+0xb1/0xe0
>>[  474.917693]  [<c0104c6e>] show_stack+0x2e/0x40
>>[  474.917920]  [<c0154f02>] rpi_push+0x192/0x3a0
>>[  474.918146]  [<c0156a30>] xnshadow_relax+0x50/0x1c0
>>[  474.918394]  [<c01570c0>] hisyscall_event+0xd0/0x290
>>[  474.918647]  [<c0142a2e>] __ipipe_dispatch_event+0x8e/0x140
>>[  474.918917]  [<c010d97e>] __ipipe_syscall_root+0x3e/0xf0
>>[  474.919292]  [<c0102e59>] system_call+0x29/0x41
>>[  474.919534]  =======================
>>
>>Any comment?
>>
> 
> 
> Yeah. This is the exact bug I told you I was chasing some moons ago on
> qemu/x86_64 and which I can't reproduce anywhere else (on real hw for
> instance), glad to see I'm not alone in the twilight zone anymore. :o)
> (Btw, this issue predates any recent change; this is something I've seen
> popping up more than six weeks ago on my setup).

A recent change that might change the behaviour is the direct tsc access
by clock_gettime in user-space. This may make the bug win a race.

-- 
                                                 Gilles Chanteperdrix

