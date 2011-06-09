From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4DF0BFA8.9070003@domain.hid>
References: <4DF0BFA8.9070003@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 09 Jun 2011 15:05:11 +0200
Message-ID: <1307624711.2139.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Oops with synchronous message passing support
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2011-06-09 at 14:42 +0200, Wolfgang Grandegger wrote:
> Hello,
> 
> I just realized a problem with synchronous message passing support. When
> rt_task_send() send times out, I get the oops below from line:
> 

Does this help?

diff --git a/ksrc/skins/native/task.c b/ksrc/skins/native/task.c
index b822fd0..b0e99a7 100644
--- a/ksrc/skins/native/task.c
+++ b/ksrc/skins/native/task.c
@@ -1988,21 +1988,28 @@ int rt_task_receive(RT_TASK_MCB *mcb_r, RTIME timeout)
 	}
 
 	/*
-	 * Wait on our receive slot for some client to enqueue itself
-	 * in our send queue.
+	 * We loop to care for spurious wakeups, in case the
+	 * client times out before we unblock.
 	 */
-	info = xnsynch_sleep_on(&server->mrecv, timeout, XN_RELATIVE);
-	/*
-	 * XNRMID cannot happen, since well, the current task would be the
-	 * deleted object, so...
-	 */
-	if (info & XNTIMEO) {
-		err = -ETIMEDOUT;	/* Timeout. */
-		goto unlock_and_exit;
-	} else if (info & XNBREAK) {
-		err = -EINTR;	/* Unblocked. */
-		goto unlock_and_exit;
-	}
+	do {
+		/*
+		 * Wait on our receive slot for some client to enqueue
+		 * itself in our send queue.
+		 */
+		info = xnsynch_sleep_on(&server->mrecv, timeout, XN_RELATIVE);
+		/*
+		 * XNRMID cannot happen, since well, the current task
+		 * would be the deleted object, so...
+		 */
+		if (info & XNTIMEO) {
+			err = -ETIMEDOUT;	/* Timeout. */
+			goto unlock_and_exit;
+		}
+		if (info & XNBREAK) {
+			err = -EINTR;	/* Unblocked. */
+			goto unlock_and_exit;
+		}
+	} while (!xnsynch_pended_p(&server->mrecv));
 
 	holder = getheadpq(xnsynch_wait_queue(&server->msendq));
 	/* There must be a valid holder since we waited for it. */

> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/native/task.c#1976
> 
> -bash-3.2# ./oops_sender 
> pre-rt_task_receive()
> [  662.423571] Unable to handle kernel paging request for data at address 0x0000024c
> [  662.515607] Faulting instruction address: 0xc0070124
> [  662.576614] Oops: Kernel access of bad area, sig: 11 [#2]
> [  662.642806] mpc5200-simple-platform
> [  662.685493] last sysfs file: 
> [  662.721775] Modules linked in:
> [  662.759127] NIP: c0070124 LR: c00701c8 CTR: 00000000
> [  662.819974] REGS: c7b8bd40 TRAP: 0300   Tainted: G      D      (2.6.36.4-00003-g1af23a4-dirty)
> [  662.925684] MSR: 00003032 <FP,ME,IR,DR>  CR: 24008482  XER: 20000000
> [  663.003613] DAR: 0000024c, DSISR: 20000000
> [  663.053780] TASK = c7b923f0[1227] 'oops_test_main' THREAD: c7b8a000
> [  663.128525] GPR00: 00000000 c7b8bdf0 c7b923f0 c902a69c c042ea60 00000000 36291b28 c042ea60 
> [  663.231015] GPR08: c902a210 fffffe0c c902a210 c9029df8 24008422 1004a118 00000000 00000000 
> [  663.333503] GPR16: c040dc54 c0425ba0 fffffff0 c7b8bf50 c0425ba0 c042f058 00000010 c902a210 
> [  663.435993] GPR24: c03f9af8 c0425ba0 c03fb678 00000000 fffffdfc c902a200 c7b8be20 fffffffc 
> [  663.540611] NIP [c0070124] rt_task_receive+0xc8/0x1ac
> [  663.602534] LR [c00701c8] rt_task_receive+0x16c/0x1ac
> [  663.664436] Call Trace:
> [  663.694322] [c7b8bdf0] [c00701c8] rt_task_receive+0x16c/0x1ac (unreliable)
> [  663.778687] [c7b8be10] [c0072de4] __rt_task_receive+0xd0/0x1b0
> [  663.850245] [c7b8be90] [c0068cd0] losyscall_event+0xc8/0x328
> [  663.919654] [c7b8bed0] [c00587c8] __ipipe_dispatch_event+0xa4/0x200
> [  663.996532] [c7b8bf20] [c000ae78] __ipipe_syscall_root+0x58/0x164
> [  664.071289] [c7b8bf40] [c00104b8] DoSyscall+0x20/0x5c
> [  664.133213] --- Exception: c01 at 0xffaca7c
> [  664.133222]     LR = 0xffaca14
> [  664.221809] Instruction dump:
> [  664.258092] 557b07fe 90091b48 813d049c 7f9c4800 419e007c 2f890000 3929fe0c 419e0070 
> [  664.353104] 2f890000 3b800000 419e0008 3b89fff0 <83bc0450> 3be0ff97 801e000c 7f9d0040 
> [  664.452834] ---[ end trace 07ae98a3f6576a96 ]---
> 
> Message from syslogd@ at Sat Feb 21 08:02:43 1970 ...
> CPUP0 kernel: [  662.685493] last sysfs file: rt_task_send() failed: -110 (Connection timed out)
> Killing child
> 
> The oops is *not* trigger if the timeout is long enough and
> rt_task_send() returns successfully.
> 
> I'm using on a PowerPC MPC5200-based system:
> 
>   -bash-3.2# cat /proc/ipipe/version 
>   2.12-03
>   -bash-3.2# cat /proc/xenomai/version 
>   2.5.6
>   -bash-3.2# uname -a
>   Linux CPUP0 2.6.36.4-00003-g1af23a4-dirty #9 Thu Jun 9 11:56:54 CEST 2011 ppc ppc ppc GNU/Linux
> 
> Any idea what could go wrong. I have attached my litte test programs
> including Makefile. Just start it with ./oops_sender.
> 
> Thanks,
> 
> Wolfgang.
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

-- 
Philippe.



