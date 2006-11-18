Subject: Re: [Xenomai-help] Re: Re: What happens if task entry function
	returns?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <16178634.1163773048304.JavaMail.ngmail@domain.hid>
References: <455DC001.2040001@domain.hid>
	<434646.1163765689576.JavaMail.ngmail@domain.hid>
	<16178634.1163773048304.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Sat, 18 Nov 2006 16:52:23 +0100
Message-Id: <1163865143.4990.47.camel@domain.hid>
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Fri, 2006-11-17 at 15:17 +0100, M. Koehrer wrote:
> Hi Jan, 
> 
> First, I give you some more information about the error.
> The output is the following:
> Hi, I am task A Hello
> Hi, I am task B World
> Main waits for A
> This is the end of A
> Main waits for B
> 
> Then the system hangs.
> 

Confirmed here on a two-way PIII. Well, _this_ was a nice one.
Basically, the softlock was due to a missing rescheduling call after
task A has exited, leaving task B in ready state, somewhere in the
Twilight Zone. The patch below fixes it on my setup:

--- ksrc/nucleus/shadow.c	(revision 1854)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -1631,7 +1631,8 @@
 
 static inline void do_taskexit_event(struct task_struct *p)
 {
-	xnthread_t *thread = xnshadow_thread(p);	/* p == current */
+	xnthread_t *thread = xnshadow_thread(p); /* p == current */
+	spl_t s;
 
 	if (!thread)
 		return;
@@ -1639,12 +1640,15 @@
 	if (xnpod_shadow_p())
 		xnshadow_relax(0);
 
-	/* So that we won't attempt to further wakeup the exiting task in
-	   xnshadow_unmap(). */
-
+	xnlock_get_irqsave(&nklock, s);
+	/* Prevent wakeup call from xnshadow_unmap(). */
 	xnshadow_thrptd(p) = NULL;
 	xnthread_archtcb(thread)->user_task = NULL;
-	xnpod_delete_thread(thread);	/* Should indirectly call xnshadow_unmap(). */
+	/* xnpod_delete_thread() -> hook -> xnshadow_unmap(). */
+	xnpod_delete_thread(thread);
+	xnsched_set_resched(thread->sched);
+	xnpod_schedule();
+	xnlock_put_irqrestore(&nklock, s);
 
 	xnltt_log_event(xeno_ev_shadowexit, thread->name);
 }

-- 
Philippe.



