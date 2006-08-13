Subject: Re: [Xenomai-help] -110 error on rt_task_send... bug?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1155417252.4381.49.camel@domain.hid>
References: <44D7EDCF.9010409@domain.hid> <44D90C41.5070307@domain.hid>
	<b647ffbd0608090235o2868571ajbe74c0b09dd27282@domain.hid>
	<1155247988.4297.52.camel@domain.hid>
	<b647ffbd0608120333j7cd4ef35q7ed00bafab35753d@domain.hid>
	<1155417252.4381.49.camel@domain.hid>
Content-Type: text/plain
Date: Sun, 13 Aug 2006 16:47:52 +0200
Message-Id: <1155480473.11108.22.camel@domain.hid>
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Sat, 2006-08-12 at 23:14 +0200, Philippe Gerum wrote:

> IOW, a construct like "if (synch-> ...." when returning from suspension
> is the root of all evil. We must not depend on anything requiring such
> dereference when resuming the thread. A way to fix this would be to
> introduce a new thread status flag which gets raised whenever some
> object ownership is stolen, so that we would not have to inspect the
> synch object anymore to know about such situation, and rely on
> potentially wrong information from the ->owner field. We would only have
> to inspect the status flags of the thread that got "robbed" (i.e. the
> one that resumes) and act accordingly. I will post a patch implementing
> this, after I have solved all the related issues.

The patch below provides a more general fix to the issues introduced by
the resource stealing feature. There is still one case where this code
could attempt to reuse a stolen resource unsafely, but the calling code
would have to be quite fragile in the first place. Normal use cases
should be ok.

Already checked on the simulator, but please give this a try.

Index: ksrc/nucleus/pod.c
===================================================================
--- ksrc/nucleus/pod.c	(revision 1420)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -1419,7 +1419,7 @@
 			__clrbits(thread->status, XNREADY);
 		}
 
-		__clrbits(thread->status, XNRMID | XNTIMEO | XNBREAK);
+		__clrbits(thread->status, XNRMID | XNTIMEO | XNBREAK | XNWAKEN | XNROBBED);
 	}
 
 	__setbits(thread->status, mask);
Index: ksrc/nucleus/synch.c
===================================================================
--- ksrc/nucleus/synch.c	(revision 1420)
+++ ksrc/nucleus/synch.c	(working copy)
@@ -92,7 +92,7 @@
 	if (flags & XNSYNCH_PIP)
 		flags |= XNSYNCH_PRIO;	/* Obviously... */
 
-	synch->status = flags & ~(XNSYNCH_CLAIMED | XNSYNCH_PENDING);
+	synch->status = flags & ~XNSYNCH_CLAIMED;
 	synch->owner = NULL;
 	synch->cleanup = NULL;	/* Only works for PIP-enabled objects. */
 	initpq(&synch->pendq, xnpod_get_qdir(nkpod),
@@ -169,79 +169,74 @@
 
 	xnltt_log_event(xeno_ev_sleepon, thread->name, synch);
 
-	if (testbits(synch->status, XNSYNCH_PRIO)) {
+	if (!testbits(synch->status, XNSYNCH_PRIO)) { /* i.e. FIFO */
+		appendpq(&synch->pendq, &thread->plink);
+		xnpod_suspend_thread(thread, XNPEND, timeout, synch);
+		goto unlock_and_exit;
+	}
 
-		if (testbits(synch->status, XNSYNCH_PIP)) {
-		      redo:
-			owner = synch->owner;
+	if (!testbits(synch->status, XNSYNCH_PIP)) { /* i.e. no ownership */
+		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
+		xnpod_suspend_thread(thread, XNPEND, timeout, synch);
+		goto unlock_and_exit;
+	}
 
-			if (owner
-			    && xnpod_compare_prio(thread->cprio,
-						  owner->cprio) > 0) {
+redo:
+	owner = synch->owner;
 
-				if (testbits(synch->status, XNSYNCH_PENDING)) {
-					/* Ownership is still pending, steal the resource. */
-					synch->owner = thread;
-					__clrbits(thread->status,
-						  XNRMID | XNTIMEO | XNBREAK);
-					goto grab_ownership;
-				}
+	if (!owner) {
+		synch->owner = thread;
+		__clrbits(thread->status, XNRMID | XNTIMEO | XNBREAK);
+		goto unlock_and_exit;
+	}
 
-				if (!testbits(owner->status, XNBOOST)) {
-					owner->bprio = owner->cprio;
-					__setbits(owner->status, XNBOOST);
-				}
+	if (xnpod_compare_prio(thread->cprio, owner->cprio) > 0) {
 
-				if (testbits(synch->status, XNSYNCH_CLAIMED))
-					removepq(&owner->claimq, &synch->link);
-				else
-					__setbits(synch->status,
-						  XNSYNCH_CLAIMED);
+		if (testbits(owner->status, XNWAKEN)) {
+			/* Ownership is still pending, steal the resource. */
+			synch->owner = thread;
+			__clrbits(thread->status, XNRMID | XNTIMEO | XNBREAK);
+			__setbits(owner->status, XNROBBED);
+			goto unlock_and_exit;
+		}
 
-				insertpqf(&synch->pendq, &thread->plink,
-					  thread->cprio);
-				insertpqf(&owner->claimq, &synch->link,
-					  thread->cprio);
-				xnsynch_renice_thread(owner, thread->cprio);
-			} else
-				insertpqf(&synch->pendq, &thread->plink,
-					  thread->cprio);
+		if (!testbits(owner->status, XNBOOST)) {
+			owner->bprio = owner->cprio;
+			__setbits(owner->status, XNBOOST);
+		}
 
-			xnpod_suspend_thread(thread, XNPEND, timeout, synch);
+		if (testbits(synch->status, XNSYNCH_CLAIMED))
+			removepq(&owner->claimq, &synch->link);
+		else
+			__setbits(synch->status, XNSYNCH_CLAIMED);
 
-			if (unlikely(testbits(thread->status, XNRMID | XNTIMEO | XNBREAK)))
-				goto unlock_and_exit;
+		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
+		insertpqf(&owner->claimq, &synch->link, thread->cprio);
+		xnsynch_renice_thread(owner, thread->cprio);
+	} else
+		insertpqf(&synch->pendq, &thread->plink, thread->cprio);
 
-			if (unlikely(synch->owner != thread)) {
-				/* Somebody stole us the ownership while we were ready to
-				   run, waiting for the CPU: we need to wait again for the
-				   resource. */
-				if (timeout == XN_INFINITE)
-					goto redo;
-				timeout = xnthread_timeout(thread);
-				if (timeout > 1)	/* Otherwise, it's too late, time elapsed. */
-					goto redo;
-				__setbits(thread->status, XNTIMEO);
-				goto unlock_and_exit;
-			}
-		} else {
-			insertpqf(&synch->pendq, &thread->plink, thread->cprio);
-			xnpod_suspend_thread(thread, XNPEND, timeout, synch);
-		}
-	} else {		/* otherwise FIFO */
-		appendpq(&synch->pendq, &thread->plink);
-		xnpod_suspend_thread(thread, XNPEND, timeout, synch);
-		if (unlikely(testbits(thread->status, XNRMID | XNTIMEO | XNBREAK)))
-			goto unlock_and_exit;
-	}
+	xnpod_suspend_thread(thread, XNPEND, timeout, synch);
 
-      grab_ownership:
+	if (testbits(thread->status, XNRMID | XNTIMEO | XNBREAK))
+		goto unlock_and_exit;
 
-	/* Now the resource is truely owned by the caller. */
-	__clrbits(synch->status, XNSYNCH_PENDING);
+	if (testbits(thread->status, XNROBBED)) {
+		/* Somebody stole us the ownership while we were ready
+		   to run, waiting for the CPU: we need to wait again
+		   for the resource. */
+		if (timeout == XN_INFINITE)
+			goto redo;
+		timeout = xnthread_timeout(thread);
+		if (timeout > 1) /* Otherwise, it's too late. */
+			goto redo;
+		__setbits(thread->status, XNTIMEO);
+	}
 
       unlock_and_exit:
 
+	__clrbits(thread->status, XNWAKEN);
+
 	xnlock_put_irqrestore(&nklock, s);
 }
 
@@ -368,13 +363,11 @@
 		thread = link2thread(holder, plink);
 		thread->wchan = NULL;
 		synch->owner = thread;
-		__setbits(synch->status, XNSYNCH_PENDING);
+		__setbits(thread->status, XNWAKEN);
 		xnltt_log_event(xeno_ev_wakeup1, thread->name, synch);
 		xnpod_resume_thread(thread, XNPEND);
-	} else {
+	} else
 		synch->owner = NULL;
-		__clrbits(synch->status, XNSYNCH_PENDING);
-	}
 
 	if (testbits(synch->status, XNSYNCH_CLAIMED))
 		xnsynch_clear_boost(synch, lastowner);
@@ -441,7 +434,7 @@
 	thread = link2thread(holder, plink);
 	thread->wchan = NULL;
 	synch->owner = thread;
-	__setbits(synch->status, XNSYNCH_PENDING);
+	__setbits(thread->status, XNWAKEN);
 	xnltt_log_event(xeno_ev_wakeupx, thread->name, synch);
 	xnpod_resume_thread(thread, XNPEND);
 
@@ -467,7 +460,7 @@
  * is cleared, such as before the resource is deleted.
  *
  * @param synch The descriptor address of the synchronization object
- * whose ownership is changed.
+ * to be flushed.
  *
  * @param reason Some flags to set in the status mask of every
  * unblocked thread. Zero is an acceptable value. The following bits
@@ -528,9 +521,6 @@
 		status = XNSYNCH_RESCHED;
 	}
 
-	synch->owner = NULL;
-	__clrbits(synch->status, XNSYNCH_PENDING);
-
 	xnlock_put_irqrestore(&nklock, s);
 
 	xnarch_post_graph_if(synch, 0, emptypq_p(&synch->pendq));
Index: include/nucleus/synch.h
===================================================================
--- include/nucleus/synch.h	(revision 1420)
+++ include/nucleus/synch.h	(working copy)
@@ -32,7 +32,6 @@
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
 #define XNSYNCH_CLAIMED 0x8	/* Claimed by other thread(s) w/ PIP */
-#define XNSYNCH_PENDING 0x10	/* Pending ownership -- may be stolen  */
 
 /* Spare flags usable by upper interfaces */
 #define XNSYNCH_SPARE0  0x01000000
@@ -86,13 +85,11 @@
 void xnsynch_init(xnsynch_t *synch,
 		  xnflags_t flags);
 
-#define xnsynch_destroy(synch) \
-xnsynch_flush(synch,XNRMID)
+#define xnsynch_destroy(synch) xnsynch_flush(synch,XNRMID)
 
 static inline void xnsynch_set_owner (xnsynch_t *synch, struct xnthread *thread)
 {
     synch->owner = thread;
-    __clrbits(synch->status, XNSYNCH_PENDING);
 }
 
 static inline void xnsynch_register_cleanup (xnsynch_t *synch, void (*handler)(xnsynch_t *))
Index: include/nucleus/thread.h
===================================================================
--- include/nucleus/thread.h	(revision 1420)
+++ include/nucleus/thread.h	(working copy)
@@ -53,6 +53,8 @@
 #define XNSHADOW  0x00800000	/* Shadow thread */
 #define XNROOT    0x01000000	/* Root thread (i.e. Linux/IDLE) */
 #define XNINVPS   0x02000000	/* Using inverted priority scale */
+#define XNWAKEN   0x04000000	/* Thread waken up upon resource availability */
+#define XNROBBED  0x08000000	/* Robbed from resource ownership */
 
 /*
   Must follow the declaration order of the above bits. Status symbols
@@ -73,12 +75,12 @@
   'o' -> Priority coupling off.
   'f' -> FPU enabled (for kernel threads).
 */
-#define XNTHREAD_SLABEL_INIT { \
-  'S', 'W', 'D', 'R', 'U', \
-  '.', '.', '.', 'X', 'H', \
-  '.', '.', '.', '.', 'b', 'T', \
-  'l', 'r', '.', 's', 't', 'o', \
-  'f', '.', '.', '.'		\
+#define XNTHREAD_SLABEL_INIT  {		\
+	'S', 'W', 'D', 'R', 'U',	\
+	'.', '.', '.', 'X', 'H',	\
+	'.', '.', '.', '.', 'b', 'T',	\
+	'l', 'r', '.', 's', 't', 'o',	\
+	'f', '.', '.', '.', '.', '.'	\
 }
 
 #define XNTHREAD_BLOCK_BITS   (XNSUSP|XNPEND|XNDELAY|XNDORMANT|XNRELAX|XNHELD)
-- 
Philippe.



