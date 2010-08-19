From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <181804936ABC2349BE503168465576460FA508FF@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460F9E6D9C@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F9E6DA5@domain.hid>
	<4C66939A.1060509@domain.hid> <4C6697F8.1090409@domain.hid>
	<181804936ABC2349BE503168465576460FA508FF@exchserver.basler.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 19 Aug 2010 07:55:59 +0200
Message-ID: <1282197359.1730.408.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Page fault in real time task causes lockup
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2010-08-17 at 10:03 -0500, Steve Deiters wrote:
> > -----Original Message-----
> > From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
> > Sent: Saturday, August 14, 2010 8:20 AM
> > To: Steve Deiters
> > Cc: xenomai@xenomai.org
> > Subject: Re: [Xenomai-help] Page fault in real time task causes lockup
> > 
> > Gilles Chanteperdrix wrote:
> > > Steve Deiters wrote:
> > >>> -----Original Message-----
> > >>> From: xenomai-help-bounces@domain.hid
> > >>> [mailto:xenomai-help-bounces@domain.hid] On Behalf Of Steve Deiters
> > >>> Sent: Friday, August 13, 2010 5:15 PM
> > >>> To: xenomai@xenomai.org
> > >>> Subject: [Xenomai-help] Page fault in real time task causes lockup
> > >>>
> > >>> I'm trying to track down a problem where it seems that a 
> > page fault 
> > >>> is causing a lockup on my machine.  I am running on a 
> > PowerPC with 
> > >>> Linux version 2.6.33.5 and Xenomai 2.5.4, but also saw the same 
> > >>> thing with Xenomai 2.5.3.
> > >>>
> > >>> What I am doing is mmaping a FPGA on the parallel bus in my task 
> > >>> initialization.  Later on I have a interrupt loop which uses 
> > >>> rt_intr_wait to service some FPGA stuff.  On access to some of my 
> > >>> FPGA mapped registers I get a page fault which causes a 
> > lockup.  I'm 
> > >>> guessing there is some interaction going on with the rt_intr_wait 
> > >>> and the fault exception.  If I prefault the map by 
> > reading some of 
> > >>> the registers before the loop it is ok.  If I change the 
> > >>> rt_intr_wait to a timed loop using rt_wait_period and 
> > don't prefault 
> > >>> the registers it is ok.
> > >>>
> > >>> If I enable T_WARNSW I get a SIGXCPU when it tries to access the 
> > >>> mapped registers.  I don't necessarily care that it 
> > faults there so 
> > >>> I don't want to have to prefault like I am doing.
> > >>>
> > >>> If I enable some of the debugging options I end up with the 
> > >>> following exception dump:
> > >>>
> > >>> -----------
> > >>>
> > >>> [   23.623184] Xenomai: Switching  to secondary mode 
> > after exception
> > >>> #769 from user-space at 0xff187ac (pid 586)
> > >>> [   23.634273] Xenomai: Switching  to secondary mode 
> > after exception
> > >>> #769 from user-space at 0xff187ac (pid 587)
> > >>> [   23.653414] Xenomai: Switching  to secondary mode 
> > after exception
> > >>> #769 from user-space at 0xff187ac (pid 592)
> > >>> [   23.675243] Xenomai: Switching dsp_task to secondary mode after
> > >>> exception #769 from user-space at 0x10016634 (pid 595)
> > >>> [   24.456360] Xenomai: Switching dsp_task to secondary mode after
> > >>> exception #769 from user-space at 0x10002d28 (pid 595)
> > >>> [   24.467285] I-pipe: Detected illicit call from domain 'Xenomai'
> > >>> [   24.467300] <3>        into a service reserved for domain 
> > >>> 'Linux' and
> > >>> below.
> > >>> [   24.480199] Xenomai: Switching dsp_task to secondary mode after
> > >>> exception #1792 in kernel-space at 0xc0062f48 (pid 595)
> > >>> [   24.491109] Oops: Exception in kernel mode, sig: 5 [#1]
> > >>> [   24.496258] PREEMPT MPC5121 BE
> > >>> [   24.499300] Modules linked in: lpcmem axe immmem
> > >>> [   24.503912] NIP: c0062f48 LR: c0025b0c CTR: c01be5b0
> > >>> [   24.508870] REGS: c7bc3c60 TRAP: 0700   Not tainted  (2.6.33.5)
> > >>> [   24.514775] MSR: 00021032 <ME,CE,IR,DR>  CR: 24000422  
> > >>> XER: 20000000
> > >>> [   24.521127] TASK = c7b30550[595] 'dsp_task' THREAD: c7bc2000
> > >>> [   24.526600] GPR00: 00000001 c7bc3d10 c7b30550 c03ac1c0 00002a39
> > >>> ffffffff c0360000 c03ac1c0
> > >>> [   24.534946] GPR08: 00000000 000028ff 00002900 c0360000 82000442
> > >>> 1003c7b8 00000001 c0360000
> > >>> [   24.543292] GPR16: c03b0000 c7bc3f50 00008000 c0300000 c03b0000
> > >>> c0360000 00000003 c0360000
> > >>> [   24.551638] GPR24: c0360000 c7bc3d3c 0000009c c7bc2000 0000000f
> > >>> c7bc3d4b c039d918 00000001
> > >>> [   24.560180] NIP [c0062f48] __ipipe_unstall_root+0x34/0x80
> > >>> [   24.565564] LR [c0025b0c] vprintk+0x340/0x444
> > >>> [   24.569895] Call Trace:
> > >>> [   24.572336] [c7bc3d10] [c7bc3d4b] 0xc7bc3d4b (unreliable)
> > >>> [   24.577729] [c7bc3d20] [c0025b0c] vprintk+0x340/0x444
> > >>> [   24.582770] [c7bc3db0] [c0026304] printk+0xb8/0x1f8
> > >>> [   24.587640] [c7bc3e00] [c006256c] ipipe_check_context+0xc4/0xcc
> > >>> [   24.593555] [c7bc3e10] [c0299538] 
> > __down_interruptible+0xb4/0x148
> > >>> [   24.599643] [c7bc3e40] [c004799c] down_interruptible+0xcc/0xdc
> > >>> [   24.605470] [c7bc3e60] [c0075acc] xnshadow_harden+0x64/0x248
> > >>> [   24.611114] [c7bc3e80] [c0075d4c] losyscall_event+0x9c/0x374
> > >>> [   24.616766] [c7bc3ed0] [c0063bc0] 
> > __ipipe_dispatch_event+0x98/0x1f0
> > >>> [   24.623025] [c7bc3f20] [c000bcf0] 
> > __ipipe_syscall_root+0x60/0x170
> > >>> [   24.629108] [c7bc3f40] [c00133e4] DoSyscall+0x20/0x5c
> > >>> [   24.634151] --- Exception: c01 at 0xff19c94
> > >>> [   24.634158]     LR = 0xff19c08
> > >>> [   24.641360] Instruction dump:
> > >>> [   24.644318] 7c0802a6 90010014 7c0000a6 5400045e 
> > 7c000124 3d60c036
> > >>> 3d20c03b 814b2858
> > >>> [   24.652055] 3929c1c0 7d4a4a78 312affff 7c095110 
> > <0f000000> 3d60c036
> > >>> 38600000 392b14f8
> > >>> [   24.660058] ------------[ cut here ]------------
> > >>> [   24.664600] kernel BUG at kernel/ipipe/core.c:311!
> > >>> [   24.669413] ---[ end trace ca02c1a54b14d664 ]---
> > >>> [   24.674021] note: dsp_task[595] exited with preempt_count 1
> > >>>
> > >>
> > >> If this gives any more clues, if I comment out the section in 
> > >> __rt_intr_wait in native/syscall.c where it raises the priority to 
> > >> XNSCHED_IRQ_PRIO it does not lock up.
> > > 
> > > This is strange, it looks like the thread wants to move 
> > from secondary 
> > > mode to primary mode while it is already running in primary mode.
> > > 
> > The most probable reason being that the previous call to 
> > xnshadow_relax went in fact wrong. The thing that could go 
> > wrong would be xnpod_suspend_thread in xnshadow_relax not 
> > suspending the thread.
> 
> It turns out my problem was caused by an interrupt storm.  I had set up
> the interrupt to propagate to the Linux domain.  When my rt task
> transferred to the Linux domain from the page fault it wasn't able to
> clear the device interrupt flag.  The interrupt was reenabled at the PIC
> level after Linux was done with it, and as soon as that happened it got
> interrupted again.

Which caused a stack overflow and now explains the weird behavior in
harden/relax, with the ipipe assertion triggering with no apparent
reason. This is a collateral damage of trashing the kernel memory this
way (observed at least once here as well).

> 
> My fix was to disable the interrupt at the device level as soon as
> rt_intr_wait returns, and reenable it before calling rt_intr_wait.  I'm
> still not sure why I was getting that exception.
> 

Likely because there is no page table entry available in the MMU hash
table for your mmaped pages until you fault them in. The e300 core
requires software-assistance to handle TLB misses. (I'm referring to the
0x300 exceptions here, not to the program check one (0x700) which is
clearly unexpected.

> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



