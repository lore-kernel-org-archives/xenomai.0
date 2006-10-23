Message-ID: <453C7C48.30602@domain.hid>
Date: Mon, 23 Oct 2006 10:24:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010104060608020008010302"
Subject: [Xenomai-core] x86 FPU switches routines.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010104060608020008010302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

As once discussed with Heikki, and after a first missed attempt, here
is a patch for x86 which attempts to cope correctly with Linux (non
real-time) drivers using FPU in kernel-space.

I tested it on my laptop without drivers using FPU, and it appears to
work correctly, but it would be nice if people that had problems with
the previous attempt (if I remember correctly, on old pentiums and on
AMD processors) could test this patch.

Thanks in advance.

-- 
                                                  Gilles Chanteperdrix

--------------010104060608020008010302
Content-Type: text/x-patch;
 name="xeno-i386-fpu-switch-use-cr0-ts.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xeno-i386-fpu-switch-use-cr0-ts.diff"

Index: include/asm-i386/system.h
===================================================================
--- include/asm-i386/system.h	(revision 1704)
+++ include/asm-i386/system.h	(working copy)
@@ -69,6 +69,7 @@
     /* FPU context bits for root thread. */
     unsigned is_root: 1;
     unsigned ts_usedfpu: 1;
+    unsigned cr0_ts: 1;
 
 } xnarchtcb_t;
 
Index: include/asm-i386/bits/pod.h
===================================================================
--- include/asm-i386/bits/pod.h	(revision 1704)
+++ include/asm-i386/bits/pod.h	(working copy)
@@ -44,6 +44,7 @@
 	/* Remember the preempted Linux task pointer. */
 	rootcb->user_task = rootcb->active_task = current;
 	rootcb->ts_usedfpu = wrap_test_fpu_used(current) != 0;
+	rootcb->cr0_ts = (read_cr0() & 8) != 0;
 	/* So that xnarch_save_fpu() will operate on the right FPU area. */
 	rootcb->fpup = &rootcb->user_task->thread.i387;
 }
@@ -265,12 +266,21 @@
 {
 	struct task_struct *task = tcb->user_task;
 
-	if (task) {
-		if (!wrap_test_fpu_used(task))
+	if (!tcb->is_root) {
+		if (task) {
+			/* fpu not used or already saved by __switch_to. */
+			if (!wrap_test_fpu_used(task))
+				return;
+
+			/* Tell Linux that we already saved the state of the FPU
+		   	hardware of this task. */
+			wrap_clear_fpu_used(task);
+		}
+	} else {
+		if (tcb->cr0_ts || 
+		    (tcb->ts_usedfpu && !wrap_test_fpu_used(task)))
 			return;
 
-		/* Tell Linux that we already saved the state of the FPU
-		   hardware of this task. */
 		wrap_clear_fpu_used(task);
 	}
 
@@ -298,13 +308,14 @@
 			wrap_set_fpu_used(task);
 		}
 	} else {
-		/* Restore state of FPU if TS_USEFPU bit was armed. */
-		if (!tcb->ts_usedfpu) {
+		/* Restore state of FPU only if TS bit in cr0 was clear. */
+		if (tcb->cr0_ts) {
 			stts();
 			return;
 		}
 
-		wrap_set_fpu_used(task);
+		if (tcb->ts_usedfpu)
+			wrap_set_fpu_used(task);
 	}
 
 	/* Restore the FPU hardware with valid fp registers from a
@@ -336,7 +347,7 @@
 			}
 		}
 	} else {
-		if (!tcb->ts_usedfpu)
+		if (tcb->cr0_ts)
 			return;
 
 		xnarch_restore_fpu(tcb);

--------------010104060608020008010302--

