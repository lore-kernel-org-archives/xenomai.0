Subject: Re: [Xenomai-help] Xenomai v2.2.3
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <451068AD.6080000@domain.hid>
References: <1158564530.5020.5.camel@domain.hid> <450F1686.3010304@domain.hid>
	<451068AD.6080000@domain.hid>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 11:24:38 +0200
Message-Id: <1158744278.5544.42.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-09-19 at 17:01 -0500, Jeff Webb wrote:
> Jeff Webb wrote:
> > Philippe Gerum wrote:
> >> Here is the third maintenance release for the v2.2.x branch.
> >> ...
> > 
> > This release works fine on my 2.6 kernel x86 machine, with the exception 
> > of the FPU problems noted elsewhere.
> > 
> > I have the following problems with my 2.4 kernel x86 machine:
> >  * The latency and switchtest test programs yield segmentation faults.
> >  * My own user-space test programs seg fault.
> > 
> > Things that work:
> >  * The kernel boots and runs fine.
> >  * xeno_native, _posix, _rtai all insert and remove without problems.
> >  * Some simple kernel module test programs work fine.
> > 
> > I am using the same config as I was for 2.2.2 (which worked fine), but I 
> > am running a slightly newer kernel version (2.4.33.3 as opposed to 2.4.32).
> 
> I was able to build a working xenomai-2.2.3 by using linux-2.4.32 and adeos-ipipe-2.4.32-i386-1.2-07.patch.  The latency and switchtest programs seem to work now.  My problematic build used linux-2.4.33.3 and the adeos-ipipe-2.4.33-i386-1.3-00.patch.  I used the same kernel config for both builds.  
> 
> So, does this mean the problem is with the ipipe patch?
> 

The problem also occurs with older patches, and it looks like extremely
volatile, depending on various parameters, including the CPU
generation/brand, so I tend to think that this issue is not directly
related to the recent Adeos changes, but might trigger more easily with
the latest patch on your box. Could you try the following patch against
vanilla 2.2.3, on all your failing configs so far, and let us know of
the outcome? TIA,

--- include/asm-i386/system.h	(revision 1644)
+++ include/asm-i386/system.h	(working copy)
@@ -68,7 +68,6 @@
 
     /* FPU context bits for root thread. */
     unsigned is_root: 1;
-    unsigned cr0_ts: 1;
     unsigned ts_usedfpu: 1;
 
 } xnarchtcb_t;
@@ -142,7 +141,6 @@
 {
     /* Remember the preempted Linux task pointer. */
     rootcb->user_task = rootcb->active_task = current;
-    rootcb->cr0_ts = (read_cr0() & 8) != 0;
     rootcb->ts_usedfpu = wrap_test_fpu_used(current) != 0;
     /* So that xnarch_save_fpu() will operate on the right FPU area. */
     rootcb->fpup = &rootcb->user_task->thread.i387;
@@ -377,119 +375,96 @@
 static inline void xnarch_save_fpu (xnarchtcb_t *tcb)
 
 {
-    struct task_struct *task = tcb->user_task;
-    
-    if (!tcb->is_root)
-	{
-        if (task)
-	    {	
-            if (!wrap_test_fpu_used(task))
-		return;
+	struct task_struct *task = tcb->user_task;
 
-	    /* Tell Linux that we already saved the state of the FPU
-	       hardware of this task. */
-	    wrap_clear_fpu_used(task);
-	    }
-	}
-    else
-	{
-	    /* Do not save root context FPU if cr0 bit ts is armed . */
-	    if (tcb->cr0_ts)
-		return;
+	if (task) {
+		if (!wrap_test_fpu_used(task))
+			return;
 
-	    if (tcb->ts_usedfpu)
+		/* Tell Linux that we already saved the state of the FPU
+		   hardware of this task. */
 		wrap_clear_fpu_used(task);
 	}
 
+	clts();
 
-    clts();
-    
-    if (cpu_has_fxsr)
-        __asm__ __volatile__ ("fxsave %0; fnclex" : "=m" (*tcb->fpup));
-    else
-        __asm__ __volatile__ ("fnsave %0; fwait" : "=m" (*tcb->fpup));
+	if (cpu_has_fxsr)
+		__asm__ __volatile__("fxsave %0; fnclex":"=m"(*tcb->fpup));
+	else
+      __asm__ __volatile__("fnsave %0; fwait":"=m"(*tcb->fpup));
 }
 
 static inline void xnarch_restore_fpu (xnarchtcb_t *tcb)
 
 {
-    struct task_struct *task = tcb->user_task;
+	struct task_struct *task = tcb->user_task;
 
-    if (!tcb->is_root)
-	{
-	if (task)
-	    {
-	    if (!xnarch_fpu_init_p(task))
-		{
-		stts();
-		return;	/* Uninit fpu area -- do not restore. */
+	if (!tcb->is_root) {
+		if (task) {
+			if (!xnarch_fpu_init_p(task)) {
+				stts();
+				return;	/* Uninit fpu area -- do not restore. */
+			}
+
+			/* Tell Linux that this task has altered the state of
+			 * the FPU hardware. */
+			wrap_set_fpu_used(task);
 		}
-		    
-	    /* Tell Linux that this task has altered the state of
-	     * the FPU hardware. */
-	    wrap_set_fpu_used(task);
-	    }
-	}
-    else
-	{
-	/* Restore state of ts bit if armed. */
-	if (tcb->cr0_ts)
-	    {
-	    stts();
-	    return;
-	    }
+	} else {
+		/* Restore state of FPU if TS_USEFPU bit was armed. */
+		if (!tcb->ts_usedfpu) {
+			stts();
+			return;
+		}
 
-	if (tcb->ts_usedfpu)
-	    wrap_set_fpu_used(task);
+		wrap_set_fpu_used(task);
 	}
 
-    /* Restore the FPU hardware with valid fp registers from a
-       user-space or kernel thread. */
-    clts();
+	/* Restore the FPU hardware with valid fp registers from a
+	   user-space or kernel thread. */
+	clts();
 
-    if (cpu_has_fxsr)
-        __asm__ __volatile__ ("fxrstor %0": /* no output */ : "m" (*tcb->fpup));
-    else
-        __asm__ __volatile__ ("frstor %0": /* no output */ : "m" (*tcb->fpup));
+	if (cpu_has_fxsr)
+		__asm__ __volatile__("fxrstor %0": /* no output */
+				     :"m"(*tcb->fpup));
+	else
+      __asm__ __volatile__("frstor %0": /* no output */ :"m"(*tcb->
+	    fpup));
 }
 
 static inline void xnarch_enable_fpu(xnarchtcb_t *tcb)
 
 {
-    struct task_struct *task = tcb->user_task;
+	struct task_struct *task = tcb->user_task;
 
-    if (!tcb->is_root)
-	{
-	if (task)
-	    {
-	    if (!xnarch_fpu_init_p(task))
-		return;
+	if (!tcb->is_root) {
+		if (task) {
+			if (!xnarch_fpu_init_p(task))
+				return;
 
-	    /* If "task" switched while in Linux domain, its FPU
-	     * context may have been overriden, restore it. */
-	    if (!wrap_test_fpu_used(task))
-		{
+			/* If "task" switched while in Linux domain, its FPU
+			 * context may have been overriden, restore it. */
+			if (!wrap_test_fpu_used(task)) {
+				xnarch_restore_fpu(tcb);
+				return;
+			}
+		}
+	} else {
+		if (!tcb->ts_usedfpu)
+			return;
+
 		xnarch_restore_fpu(tcb);
 		return;
-		}
-	    }
 	}
-    else
-	{
-	if (tcb->cr0_ts)
-	    return;
 
-	xnarch_restore_fpu(tcb);
-	return;
-	}
+	clts();
 
-    clts();
-
-    if (!cpu_has_fxsr && task)
-        /* fnsave, called by switch_to, initialized the FPU state, so that on
-           cpus prior to PII (i.e. without fxsr), we need to restore the saved
-           state. */
-        __asm__ __volatile__ ("frstor %0": /* no output */ : "m" (*tcb->fpup));
+	if (!cpu_has_fxsr && task)
+		/* fnsave, called by switch_to, initialized the FPU state, so that on
+		   cpus prior to PII (i.e. without fxsr), we need to restore the saved
+		   state. */
+		__asm__ __volatile__("frstor %0": /* no output */
+				     :"m"(*tcb->fpup));
 }
 
 #else /* !CONFIG_XENO_HW_FPU */



