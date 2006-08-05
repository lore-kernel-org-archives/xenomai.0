Subject: Re: [Xenomai-help] rt_pipe and rt_queue problems
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44D4CC6C.1020709@domain.hid>
References: 00608021808.18076@domain.hid> <200608021808.18076@domain.hid>
	<44D0F72E.3020406@domain.hid> <200608031628.31584@domain.hid>
	<44D26C1C.5040506@domain.hid> <200608041345.6449@domain.hid>
	<44D4CC6C.1020709@domain.hid>
Content-Type: multipart/mixed; boundary="=-DxLfMzDEiY4w1UeWWshB"
Date: Sat, 05 Aug 2006 19:40:34 +0200
Message-Id: <1154799634.4330.23.camel@domain.hid>
Mime-Version: 1.0
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
Cc: Petr Cervenka <grugh@domain.hid>, xenomai@xenomai.org


--=-DxLfMzDEiY4w1UeWWshB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2006-08-05 at 18:50 +0200, Jan Kiszka wrote:
> Petr Cervenka wrote:
> 
> > ...
> > I made a reduced example and the error was still there. So I tried a couple of things and I found out, that new interface rt_queue_write/rt_queue_read is faulty (perhaps only rt_queue_read) or I misused it. I used these functions to speed up the trasfer from rt_pipes/linux devices. "Zero-copy" optimization should come somewhere in near future (or never) ;-)
> > When I tried to use rt_queue_alloc/rt_queue_send/rt_queue_receive/rt_queue_free, everything was fine.
> > Xenomai version: 2.2.0 with any patches
> > Linux: 2.6.17.7, adeos: 2.6.17-i386-1.3-09
> > Petr
> >
> >   
> I quick run of your program confirmed that there is something fishy:
> 
> [  277.130780] Xenomai: Switching consumer to secondary mode after exception #14 in kernel-space at 0xc01cb6dc (pid 907)
> [  277.131489] I-pipe tracer log (30 points):
> [  277.131571] func                    0 ipipe_trace_panic_freeze+0x8 (xnpod_fault_handler+0xe1)
> [  277.131757] func                  -15 xnpod_fault_handler+0xd (xnpod_trap_fault+0x32)
> [  277.131921] func                  -29 xnpod_trap_fault+0x8 (xnarch_trap_fault+0x1f)
> [  277.132083] func                  -35 xnarch_trap_fault+0xb (exception_event+0x2d)
> [  277.132347] func                  -46 exception_event+0x9 (__ipipe_dispatch_event+0x5e)
> [  277.132547] func                  -50 __ipipe_dispatch_event+0xe (__ipipe_handle_exception+0x4d)
> [  277.132746] func                  -54 __ipipe_handle_exception+0xb (error_code+0x54)
> [  277.132937] func                  -68 __copy_from_user_ll+0xa (__rt_queue_read+0x87)
> [  277.133128] func                  -81 __ipipe_restore_pipeline_head+0x8 (xnregistry_fetch+0x79)
> [  277.133326] func                  -83 xnregistry_fetch+0x9 (__rt_queue_read+0x44)
> [  277.133515] func                  -87 __copy_from_user_ll+0xa (__rt_queue_read+0x3c)
> [  277.133855] func                  -96 __rt_queue_read+0xe (hisyscall_event+0x140)
> [  277.134047] func                 -107 hisyscall_event+0xe (__ipipe_dispatch_event+0x5e)
> [  277.134241] func                 -108 __ipipe_dispatch_event+0xe (__ipipe_syscall_root+0x55)
> [  277.134437] func                 -110 __ipipe_syscall_root+0x9 (system_call+0x20)
> [  277.134626] func                 -172 ipipe_unstall_pipeline_head+0x8 (xnshadow_harden+0x118)
> [  277.134823] func                 -178 xnpod_switch_fpu+0xa (xnshadow_harden+0x105)
> [  277.135012] func                 -181 __switch_to+0xe (schedule+0x4b2)
> 
> Philippe, can you comment on this?
> 

Not really, just "gasp..."

-- 
Philippe.


--=-DxLfMzDEiY4w1UeWWshB
Content-Disposition: attachment; filename=fix-timeout-arg.patch
Content-Type: text/x-patch; name=fix-timeout-arg.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: ksrc/skins/native/syscall.c
===================================================================
--- ksrc/skins/native/syscall.c	(revision 1406)
+++ ksrc/skins/native/syscall.c	(working copy)
@@ -2430,7 +2430,7 @@
 	    (curr, VERIFY_READ, __xn_reg_arg4(regs), sizeof(timeout)))
 		return -EFAULT;
 
-	__xn_copy_from_user(curr, &timeout, (void __user *)__xn_reg_arg3(regs),
+	__xn_copy_from_user(curr, &timeout, (void __user *)__xn_reg_arg4(regs),
 			    sizeof(timeout));
 
 	rsize = rt_queue_receive(q, &mbuf, timeout);

--=-DxLfMzDEiY4w1UeWWshB--


