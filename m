Message-ID: <497DE125.5020402@domain.hid>
Date: Mon, 26 Jan 2009 16:13:25 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D533F9A@slcmail.slc.mew.int>
	<4975E491.1040506@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB6@domain.hid>
	<4975E612.9040708@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534028@domain.hid>
	<4976EABD.3060505@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534053@domain.hid>
	<497751E3.3020301@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53405D@slcmail.slc.mew.int>
	<49775759.2090505@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534064@domain.hid>
	<49776313.2090403@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53407D@slcmail.slc.mew.int>
	<49777C1F.4040805@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53408C@slcmail.slc.mew.int>
	<49779002.5080704@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534095@domain.hid>
	<49779319.5040500@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D5907E5@domain.hid>
	<4977	99F2.8070605@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D5907E9@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D5907E9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] fpu issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org, Adeos <adeos-main@gna.org>

Steven Seeger wrote:
> It is being called a lot. Running my test with the break in both loops
> yields approximately 60 calls to it. Half of those are called even
> before i387.c's init_fpu().

For the records: we found a solution to this FPU issue. The issue was
two-fold:
- when xenomai was preempting some linux kernel code which has called
kernel_fpu_begin, it was saving the current FPU context over the current
thread user-space FPU backup area, erasing its value previously saved by
kernel_fpu_begin();
- xenomai could preempt the linux kernel anywhere within the
kernel_fpu_begin function, which caused it to observe an incoherent
state (namely incoherent values of
current_thread_info()->status & TS_USEDFPU and TS bit in CR0).

These issues were easy to observe on Geode, because Linux on these
processors use MMX, thus kernel_fpu_begin routinely.

So, the following patch should be integrated into the I-pipe patch:

diff --git a/include/asm-x86/i387.h b/include/asm-x86/i387.h
index 56d00e3..e850fa1 100644
--- a/include/asm-x86/i387.h
+++ b/include/asm-x86/i387.h
@@ -222,11 +222,14 @@ static inline void __clear_fpu(struct task_struct
*tsk)
 static inline void kernel_fpu_begin(void)
 {
 	struct thread_info *me = current_thread_info();
+	unsigned long flags;
 	preempt_disable();
+	local_irq_save_hw_cond(flags);
 	if (me->status & TS_USEDFPU)
 		__save_init_fpu(me->task);
 	else
 		clts();
+	local_irq_restore_hw_cond(flags);
 }

 static inline void kernel_fpu_end(void)


And the following patch should be applied to Xenomai:

Index: include/asm-x86/bits/pod_32.h
===================================================================
--- include/asm-x86/bits/pod_32.h	(revision 4572)
+++ include/asm-x86/bits/pod_32.h	(working copy)
@@ -63,7 +63,12 @@ static inline void xnarch_leave_root(xna
 	rootcb->ts_usedfpu = wrap_test_fpu_used(current) != 0;
 	rootcb->cr0_ts = (read_cr0() & 8) != 0;
 	/* So that xnarch_save_fpu() will operate on the right FPU area. */
-	rootcb->fpup = x86_fpustate_ptr(&rootcb->user_task->thread);
+	if (rootcb->cr0_ts || rootcb->ts_usedfpu)
+		rootcb->fpup = x86_fpustate_ptr(&rootcb->user_task->thread);
+	else
+		/* the kernel is currently using fpu in kernel-space, do not
+		   clobber the user-space fpu backup area. */
+		rootcb->fpup = &rootcb->i387;
 }

 #define xnarch_enter_root(rootcb)  do { } while(0)





-- 
                                                 Gilles.

