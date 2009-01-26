MIME-Version: 1.0
Date: Mon, 26 Jan 2009 09:12:42 +0530
Message-ID: <8e2adebc0901251942q75a08473m6121fcd2d296f598@domain.hid>
From: Mandar Thite <mandarthite@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] NULL ptr dereference: porting I-pipe to ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: adeos-main@gna.org, xenomai@xenomai.org

Hello everyone,

I am trying to boot Linux kernel ver. 2.6.26 patched with ADEOS ipipe
ver. 1.11-02 on OMAP5912 CPU(arch/arm/mach-omap1) containing ARM926
core.
Of course, I have configured my Linux kernel to run in tickless mode.
In the final steps of booting, kernel is encountering " NULL pointer
dereference " in the function " rb_erase() " called from " __remove_hrtimer() ".
Following is the backtrace log emitted by the kernel.

Unable to handle kernel NULL pointer dereference at virtual address 00000008
pgd = c0004000
[00000008] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0    Tainted: G        W  (2.6.26-ipipe #3)
PC is at rb_erase+0x114/0x358
LR is at __remove_hrtimer+0x88/0x94
Backtrace:

[<c012ed1c>] (rb_erase+0x0/0x358) from [<c0053f48>] (__remove_hrtimer+0x88/0x94)
 r9:00000080 r8:c0285530 r7:00000000 r6:00000001 r5:c0285530 r4:c02a6298

[<c0053ec0>] (__remove_hrtimer+0x0/0x94) from [<c00548a8>]
(hrtimer_start+0x74/0x108)
 r7:00000006 r6:02625a00 r5:00000000 r4:2d4cae00

[<c0054834>] (hrtimer_start+0x0/0x108) from [<c005af18>]
(tick_nohz_stop_sched_tick+0x2bc/0x3a4)

[<c005ac5c>] (tick_nohz_stop_sched_tick+0x0/0x3a4) from [<c0023318>]
(cpu_idle+0x38/0x60)

[<c00232e0>] (cpu_idle+0x0/0x60) from [<c01f7d58>] (rest_init+0x58/0x6c)
 r5:c001cdc4 r4:c02bc754

[<c01f7d00>] (rest_init+0x0/0x6c) from [<c0008ad0>] (start_kernel+0x244/0x290)

[<c000888c>] (start_kernel+0x0/0x290) from [<10008034>] (0x10008034)
 r6:c001cdc0 r5:c029af88 r4:00053175

Code: e3580001 01a04005 189dabf0 ea000082 (e5941008)
---[ end trace b0a66fe3e48abdda ]---
Kernel panic - not syncing: Attempted to kill the idle task!

>From this what I understand is, address of nonexistent node is passed
to rb_erase()?

Can anybody please direct me, how to investigate further into this problem?

--Mandar

