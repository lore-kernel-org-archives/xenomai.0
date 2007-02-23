Message-ID: <45DEF1DE.70708@domain.hid>
Date: Fri, 23 Feb 2007 14:53:34 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid> <45DEE913.9080809@domain.hid>
	<1172237186.26738.8.camel@domain.hid>
In-Reply-To: <1172237186.26738.8.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: rpm@xenomai.org
Cc: Xenomai-core@domain.hid

Philippe Gerum wrote:
> On Fri, 2007-02-23 at 14:16 +0100, Gilles Chanteperdrix wrote:
> 
>> I do not think to remember that there are cases where calling schedule
>> from a real-time context is done by Xenomai, so maybe you can call panic
>> in schedule instead of returning. I will try and trig a tracer freeze
>> and dump the tracer at this point in order to have a better idea of what
>>  happens.
>>
> 
> True. Just BUG() instead of returning from schedule() in this case would
> do.

Ok. I put in a BUG() :

RTD|      16.000|     149.200|     240.800|       3|      11.600|     284.000
kernel BUG at kernel/sched.c:3331!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c1f34000
[00000000] *pgd=21f28031, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1]
Modules linked in:
CPU: 0
PC is at __bug+0x40/0x54
LR is at vscnprintf+0x14/0x28
pc : [<c001dbb4>]    lr : [<c00f8e5c>]    Not tainted
sp : c02b7f64  ip : c02b7f20  fp : c02b7f74
r10: 40247000  r9 : c02b6000  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : c0019de4  r4 : 00000000
r3 : 00000000  r2 : c0185845  r1 : 00003fda  r0 : 00000002
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  Segment user
Control: C000717F
Table: 21F34000  DAC: 00000015
Process display-181 (pid: 183, stack limit = 0xc02b6250)
Stack: (0xc02b7f64 to 0xc02b8000)
7f60:          ffffffff c02b7fac c02b7f78 c0178434 c001db84 c02b7f84 c001f140
7f80: c001ee88 ffffffff fefff000 00000000 00000000 00000000 c02b6000 40247000
7fa0: 00000000 c02b7fb0 c0019de4 c0178410 0000000e 00000000 00000003 00000352
7fc0: 9999999a 4023b3c8 00000008 00000000 4024888c 0000000c 40247000 be7ff4bc
7fe0: 9999999a be7ff3b8 9999999a 4017f0b8 20000010 ffffffff 00000004 c0188328
Backtrace:
[<c001db74>] (__bug+0x0/0x54) from [<c0178434>] (schedule+0x34/0x838)
* r4 = FFFFFFFF *
[<c0178400>] (schedule+0x0/0x838) from [<c0019de4>] (ret_slow_syscall+0x0/0x10)
Code: 1b00479a e59f0014 eb004798 e3a03000 (e5833000)


:-(

Won't help much?

--
Steven

