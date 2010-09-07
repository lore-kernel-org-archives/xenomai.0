Message-ID: <4C862A3B.2050300@domain.hid>
Date: Tue, 07 Sep 2010 14:04:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C8605E6.4000400@domain.hid>
In-Reply-To: <4C8605E6.4000400@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How do I force a core dump on a page fault event?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
>   I am seeing various Oops reports referencing my rt user task, but they 
> don't provide any useful information regarding my program's state at the 
> time of the Oops.
> 
> The most common Oops is...
> Unable to handle kernel NULL pointer dereference at virtual address 0000000c
> pgd = cf02c000
> [0000000c] *pgd=8f8a5031, *pte=00000000, *ppte=00000000
> Internal error: Oops: 17 [#2]
> last sysfs file: /sys/devices/virtual/gpio/gpio7/value
> Modules linked in: rtservo_driver rtasuspidvr [last unloaded: 
> rtservo_driver]
> CPU: 0    Tainted: G      D     (2.6.33 #10)
> PC is at do_page_fault+0x40/0x26c
> LR is at do_DataAbort+0x34/0x11c
> pc : [<c002d9d8>]    lr : [<c002733c>]    psr: 60000113
> sp : ce8620d8  ip : 00000007  fp : 00000000
> r10: ce862218  r9 : 00000017  r8 : 0000000c
> r7 : ce862218  r6 : 0000000c  r5 : 00000017  r4 : ffffffff
> r3 : 00000000  r2 : 00000003  r1 : 00000017  r0 : c0429100
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c5387d  Table: 8f02c019  DAC: 00000015
> Process navigator (pid: 666, stack limit = 0xce8602e8)
> Stack: (0xce8620d8 to 0xce862000)
> [<c002d9d8>] (do_page_fault+0x40/0x26c) from [<c002733c>] 
> (do_DataAbort+0x34/0x11c)
> [<c002733c>] (do_DataAbort+0x34/0x11c) from [<c0027bec>] 
> (__dabt_svc+0x4c/0x60)

This tells us that a bug happens in kernel-space for some reason, while
trying to handle a user-space fault.

Do you have a simple piece of code which I can run to reproduce this issue?

> Another is...
> Unable to handle kernel paging request at virtual address 70000049
> pgd = cf034000
> [70000049] *pgd=00000000
> Internal error: Oops: 805 [#1]
> last sysfs file: /sys/devices/virtual/gpio/gpio7/value
> Modules linked in: rtservo_driver rtasuspidvr
> CPU: 0    Not tainted  (2.6.33 #10)
> PC is at 0x40038998
> LR is at 0x40038984
> pc : [<40038998>]    lr : [<40038984>]    psr: 60000113
> sp : cf0f3ff8  ip : 00000000  fp : 00000001
> r10: 40242c3c  r9 : 00000000  r8 : 40242c40
> r7 : 000f0042  r6 : 40242c40  r5 : 402434b0  r4 : 00000000
> r3 : 00000a64  r2 : 70000049  r1 : ffffffab  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c5387d  Table: 8f034019  DAC: 00000015
> Process navigator (pid: 646, stack limit = 0xcf0f22e8)
> Stack: (0xcf0f3ff8 to 0xcf0f4000)
> 3fe0:                                                       00000000 
> 00000000
> Code: 0affffe9 e3500000 059d3014 059d2008 (05823000)
> ---[ end trace 6d46aff735536a73 ]---

This is the real user-space fault. Happening at pc 0x40038998 which
corresponds to an address in your process. However, the stack pointer is
invalid here. So, the most probablie reason for such fault is that you
overwrote some piece of stack, which caused the return from a function
to try and use cf0f3ff8 as a stack address, causing the fault.

> 
> Both Oops reports reference paging and of course none should be 
> occurring. (mlockall(MCL_CURRENT | MCL_FUTURE)); was called.

No. do_page_fault means that a fault occurs, it has nothing to do with
whether memory is locked or not. You are running with an MMU, if you try
and reference an invalid address, you get an MMU fault, and end up in
do_page_fault.

> 
> They also reference "navigator" which is the name of my rt user task 
> which should be running in primary mode until it is told to terminate. 

Well, from the traces, it seems that you are referencing
/sys/devices/virtual/gpio/gpio7/value. If you do that, you leave primary
mode.

> (No explicit memory allocations are being performed.)
> How can I force a core dump when the page fault occurs?

with ulimit. But there is a simpler way to know where the fault occurs,
simply run your application inside gdb.

> Can I configure the SIGXCPU signal (as generated from 
> pthread_set_mode_np(0, PTHREAD_WARNSW); ) to core dump?

You do not need to do that. Simply install a handler which prints the
backtrace, as in the "sigxcpu.c" example.

-- 
					    Gilles.

