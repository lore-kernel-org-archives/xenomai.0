MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2Q2qWMFgHb"
Content-Transfer-Encoding: 7bit
Message-ID: <17357.4354.415669.858219@domain.hid>
Date: Tue, 17 Jan 2006 16:45:06 +0100
In-Reply-To: <fd6a47a90601170609u594d4fd4k@domain.hid>
References: <fd6a47a90601160809l6aa38508o@domain.hid>
	<17355.55389.544946.912659@domain.hid>
	<fd6a47a90601170609u594d4fd4k@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai-core] Re: [Xenomai-help] Scheduling while atomic
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


--2Q2qWMFgHb
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Jeroen Van den Keybus wrote:
 > Gilles, Jan,
 > 
 > 
 > The offending program is quite complex (several .c files and
 > a considerable .h file tree) and involves 2 computers. However, I think I
 > can narrow down the problem to concurrent access (from 2 Xenomai threads in
 > 2nd domain) to the same Linux file descriptor for a TCP/IP connection.
 > 
 > In order to rule this out, I have put RT_MUTEXes around the send() and
 > recv() calls.However, I still received 'scheduling while atomic'. Further
 > investigation, however, has shown that the mutexes seem to fail:
 > rt_mutex_enquire() returns 0 or even -1 after acquisition of the lock. With
 > this program, I didn't (yet) receive the 'scheduling...' error, but by
 > increasing the task repetition rate, it should be a matter of (a long) time
 > (both tasks arriving at a blocking write).
 > 
 > I have compiled a program that represents the structure of the original
 > program. Could you have a look and see if I'm not making a mistake here ?
 > 
 > For proper following up, I've also attached the dmesg log asked for earlier
 > by Jan.

Looking at the message log, it seems xnshadow_harden is called at a
point where irqs are disabled. But is there no other error before these
"scheduling while atomic" messages ? If not, could you try and enable
the nucleus debugging ?

In case there is no error before the error messages, even with nucleus
debugging activated, I attached a patch which breaks nklock and
activates interrupts on xnshadow_harden entry and restore the caller
state on xnshadow_harden exit. Could you test it and report if you still
see the "scheduling while atomic" messages ?

-- 


					    Gilles Chanteperdrix.

--2Q2qWMFgHb
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-harden.diff"
Content-Transfer-Encoding: 7bit

Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c	(revision 464)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -439,13 +439,17 @@
        preemption. */
     struct __gatekeeper *gk = &gatekeeper[task_cpu(this_task)];
     xnthread_t *thread = xnshadow_thread(this_task);
+    spl_t s;
 
     if (!thread)
 	return -EPERM;
 
+    xnlock_get_irqsave(&nklock, s);
+    xnlock_clear_irqon(&nklock);
+
     if (signal_pending(this_task) ||
 	down_interruptible(&gk->sync)) /* Grab the request token. */
-	return -ERESTARTSYS;
+        goto out_interrupted;
 
     xnltt_log_event(xeno_ev_primarysw,this_task->comm);
 
@@ -495,6 +499,8 @@
 			    thread->name,
 			    xnthread_user_pid(thread));
 #endif /* CONFIG_XENO_OPT_DEBUG */
+out_interrupted:
+            xnlock_put_irqrestore(&nklock, s);
 	    return -ERESTARTSYS;
 	}
     }
@@ -510,7 +516,7 @@
     if (xnthread_signaled_p(thread))
         xnpod_dispatch_signals();
 
-    xnlock_clear_irqon(&nklock);
+    xnlock_put_irqrestore(&nklock, s);
 
     xnltt_log_event(xeno_ev_primary,thread->name);
 

--2Q2qWMFgHb--

