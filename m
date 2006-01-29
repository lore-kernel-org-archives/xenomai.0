Message-ID: <43DD4F81.7050605@domain.hid>
Date: Mon, 30 Jan 2006 00:28:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Scheduling while atomic
References: <fd6a47a90601171559x13acf2c2m@domain.hid>	<43CE9FCB.2070305@domain.hid>
	<43CEA1B4.4010104@domain.hid>
In-Reply-To: <43CEA1B4.4010104@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Jan Kiszka wrote:
> 
>>...
>>[Update] While writing this mail and letting your test run for a while,
>>I *did* get a hard lock-up. Hold on, digging deeper...
>>
> 
> 
> And here are its last words, spoken via serial console:
> 
> c31dfab0 00000086 c30d1a90 c02a2500 c482a360 00000001 00000001 00200000
>        c012e564 00000022 ffffffff 00000246 c30d1a90 c4866ce0 00000033
> c4820000
>        c482a360 c4866ca0 ffffffff c48293a4 c48524e1 00000000 00000000
> 00000002
> Call Trace:
>  [<c012e564>] __ipipe_dispatch_event+0x56/0xdd
>  [<c4820000>] e100_hw_init+0x3ad/0xa81 [e100]
>  [<c48524e1>] xnpod_suspend_thread+0x714/0x76d [xeno_nucleus]
>  [<c4856946>] xnsynch_sleep_on+0x76d/0x7a7 [xeno_nucleus]
>  [<c4a09b29>] rt_sem_p+0xa6/0x10a [xeno_native]
>  [<c4a03c62>] __rt_sem_p+0x5d/0x66 [xeno_native]
>  [<c485b207>] hisyscall_event+0x1cb/0x2d3 [xeno_nucleus]
>  [<c012e564>] __ipipe_dispatch_event+0x56/0xdd
>  [<c010b3ea>] __ipipe_syscall_root+0x53/0xbe
>  [<c01029c0>] system_call+0x20/0x41
> Xenomai: fatal: blocked thread main[863] rescheduled?! (status=0x300082,
> sig=0, prev=gatekeeper/0[809])
>  CPU  PID    PRI  TIMEOUT  STAT      NAME
> 
>> 0  0      30   0        00500080  ROOT
> 
>    0  864    30   0        00300180  task0
>    0  865    29   0        00300288  task1
>    0  863    1    0        00300082  main
> Timer: oneshot [tickval=1 ns, elapsed=175144731477]
> 
> c31e1f14 c4860572 c3188000 c31dfab0 00300082 c02a2500 00000286 c02a2500
>        c030cbec c012e564 00000022 c02a2500 c30d1a90 c30d1a90 00000022
> 00000001
>        c02a2500 c30d1a90 c08e4623 00000028 c31e1fa0 c0266ed5 0000f610
> c030cd80
> Call Trace:
>  [<c012e564>] __ipipe_dispatch_event+0x56/0xdd
>  [<c0266ed5>] schedule+0x3ef/0x5ed
>  [<c485a27c>] gatekeeper_thread+0x0/0x179 [xeno_nucleus]
>  [<c485a316>] gatekeeper_thread+0x9a/0x179 [xeno_nucleus]
>  [<c010dd8b>] default_wake_function+0x0/0x12
>  [<c0124fbc>] kthread+0x68/0x95
>  [<c0124f54>] kthread+0x0/0x95
>  [<c0100d71>] kernel_thread_helper+0x5/0xb
> 
> Any bells already ringing?

Yes; the bad news is that this looks like the same bug than you reported recently, 
which I only partially fixed, it seems. xnshadow_harden() is still not working 
properly under certain preemption situation induced by CONFIG_PREEMPT, and the 
hardening thread is likely unexpectedly moved back to the Linux runqueue while 
transitioning to Xenomai. The good news is that it's a well identified issue, at 
least...

> 
> Will try Gilles' patch now...
> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

