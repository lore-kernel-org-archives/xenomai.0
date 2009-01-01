Message-ID: <495C80FB.7050501@domain.hid>
Date: Thu, 01 Jan 2009 09:38:19 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Oops when exiting Xenomai POSIX application
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hello,

first a Happy New Year to everybody.

With the POSIX skin of Xenomai trunk I get the following Oops when I
exit my application (with ^C) on my PowerPC :

 Xenomai: fatal: removing non-linked element, holder=c78e69c8, qslot=c7b03030 at kernel/xenomai/skins/posix/thread.c:52
[ 4081.676346]  CPU  PID    PRI      TIMEOUT  STAT      NAME
[ 4081.676356] >  0  0       -1      0        00500080  ROOT
[ 4081.676366]    0  1128    37      0        00300380  UT1
[ 4081.676376] Master time base: clock=137696806566
[ 4081.676385] 
[ 4081.722024] Call Trace:
[ 4081.724515] [c7b19d40] [c0008088] show_stack+0x4c/0x1ac (unreliable)
[ 4081.731030] [c7b19d80] [c0085670] thread_destroy+0x230/0x23c
[ 4081.736823] [c7b19da0] [c0085c28] thread_delete_hook+0xf4/0xf8
[ 4081.742781] [c7b19dc0] [c0053b74] xnpod_fire_callouts+0x48/0x94
[ 4081.748845] [c7b19de0] [c005fa64] xnsched_zombie_hooks+0x5c/0xcc
[ 4081.754982] [c7b19df0] [c005fb50] xnsched_finish_unlocked_switch+0x7c/0x9c
[ 4081.762003] [c7b19e00] [c0054ad4] __xnpod_schedule+0x1f8/0x6e4
[ 4081.767962] [c7b19e50] [c0055c34] xnpod_suspend_thread+0x3c0/0x54c
[ 4081.774275] [c7b19e90] [c0064810] xnshadow_relax+0x90/0x23c
[ 4081.779972] [c7b19eb0] [c00651c0] hisyscall_event+0x2a4/0x2cc
[ 4081.785841] [c7b19ee0] [c004d850] __ipipe_dispatch_event+0xac/0x224
[ 4081.792243] [c7b19f30] [c0009560] __ipipe_syscall_root+0x40/0xf0
[ 4081.798383] [c7b19f40] [c0011118] DoSyscall+0x20/0x5c
[ 4081.803556] --- Exception: c01 at 0xffaa1b0
[ 4081.807823]     LR = 0xffaa18c


Does that trigger a bell?

Thanks,

Wolfgang. 


