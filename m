MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HnlPNjYCCA"
Content-Transfer-Encoding: 7bit
Message-ID: <17912.37052.725635.483595@domain.hid>
Date: Thu, 15 Mar 2007 01:18:04 +0100
Subject: Re: [Xenomai-help] mem usage and other application
In-Reply-To: <45F88C71.2070804@domain.hid>
References: <45F86426.9000309@domain.hid>
	<17912.26777.313494.393466@domain.hid>
	<45F87970.5060506@domain.hid>
	<17912.31765.786905.929691@domain.hid>
	<45F87F03.9090202@domain.hid>
	<17912.32723.685853.878873@domain.hid>
	<45F884EC.3060006@domain.hid>
	<17912.34386.408353.651285@domain.hid>
	<45F88C71.2070804@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Maksym Veremeyenko <verem@domain.hid>
Cc: Xenomai-help@domain.hid


--HnlPNjYCCA
Content-Type: text/plain; charset=iso-8859-5
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Maksym Veremeyenko wrote:
 > Gilles Chanteperdrix ~~~~~:
 > 
 > >  > My problem with non-RT application happens only if RT application 
 > >  > (running in the same time) uses native skin. Perl and Eclipse 
 > >  > application fails when switchbench is running, but not problems during 
 > >  > switchtest.
 > > 
 > > Ok. If you can run switchtest at the same time as your application and
 > > switchtest does not fail, it does not look like an FPU bug. What is
 > > the error message when perl or eclipse fail to start ?
 > > 
 > 
 > Perl scripts fails with various compilation errors - approximately 6 
 > types (seems it could be much more if more modules were used).
 > 
 > Eclipse fails with Java VM init error:
 > [verem@domain.hid ~]$ /usr/local//eclipse/eclipse
 > Error occurred during initialization of VM
 > java.lang.IllegalArgumentException: Illegal Load: NaN
 > 
 > During runned 'latency' i even have ssh fail:
 > Mar 15 01:47:18 dev-3 sshd[2908]: fatal: Couldn't obtain random bytes 
 > (error 604389476)
 > Mar 15 01:52:11 dev-3 sshd[3006]: Received signal 15; terminating.

Well, it really looks like an FPU bug. Could you try to:
- upgrade your trunk to latest revision, then test
- then apply the attached patch to your up-to-date trunk, then test
  again ?

-- 


					    Gilles Chanteperdrix.

--HnlPNjYCCA
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-revert-all-fpu-changes.diff"
Content-Transfer-Encoding: 7bit

Index: include/asm-i386/bits/pod.h
===================================================================
--- include/asm-i386/bits/pod.h	(revision 2299)
+++ include/asm-i386/bits/pod.h	(working copy)
@@ -209,7 +209,6 @@
 {
 	struct task_struct *task = tcb->user_task;
 
-	if (!tcb->is_root) {
 		if (task) {
 			/* fpu not used or already saved by __switch_to. */
 			if (!wrap_test_fpu_used(task))
@@ -219,14 +218,7 @@
 		   	hardware of this task. */
 			wrap_clear_fpu_used(task);
 		}
-	} else {
-		if (tcb->cr0_ts || 
-		    (tcb->ts_usedfpu && !wrap_test_fpu_used(task)))
-			return;
 
-		wrap_clear_fpu_used(task);
-	}
-
 	clts();
 
 	if (cpu_has_fxsr)
@@ -239,7 +231,6 @@
 {
 	struct task_struct *task = tcb->user_task;
 
-	if (!tcb->is_root) {
 		if (task) {
 			if (!xnarch_fpu_init_p(task)) {
 				stts();
@@ -250,17 +241,7 @@
 			 * the FPU hardware. */
 			wrap_set_fpu_used(task);
 		}
-	} else {
-		/* Restore state of FPU only if TS bit in cr0 was clear. */
-		if (tcb->cr0_ts) {
-			stts();
-			return;
-		}
 
-		if (tcb->ts_usedfpu)
-			wrap_set_fpu_used(task);
-	}
-
 	/* Restore the FPU hardware with valid fp registers from a
 	   user-space or kernel thread. */
 	clts();
@@ -277,7 +258,6 @@
 {
 	struct task_struct *task = tcb->user_task;
 
-	if (!tcb->is_root) {
 		if (task) {
 			if (!xnarch_fpu_init_p(task))
 				return;
@@ -289,20 +269,7 @@
 				return;
 			}
 		}
-	} else {
-		if (tcb->cr0_ts)
-			return;
 
-		if (wrap_test_fpu_used(task)) {
-			/* Fpu context was not even saved, do not restore */
-			clts();
-			return;
-		}
-		
-		xnarch_restore_fpu(tcb);
-		return;
-	}
-
 	clts();
 
 	if (!cpu_has_fxsr && task)

--HnlPNjYCCA--

