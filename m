Message-ID: <476D5DA9.4050105@domain.hid>
Date: Sat, 22 Dec 2007 19:55:37 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <c12ec2810712100218s7c93af6drc2ada3ee7644c152@domain.hid>	<475D4A31.1080908@domain.hid>
	<c12ec2810712100655l47f5f55dr5ca5e762e18a1522@domain.hid>
	<475FACFF.6000402@domain.hid>
In-Reply-To: <475FACFF.6000402@domain.hid>
Content-Type: multipart/mixed; boundary="------------020002070202020407010901"
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rtpipe consistency problems
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020002070202020407010901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> Ulf Karlsson wrote:
>> Hi,
>>
>>> I can't reproduce this issue here, on the very same kernel/xenomai
>>> combo. Looking at the pipe code, a closing regular Linux side
>>> (linux-pipe) explicitly flushes the real-time output queue, so I just
>>> don't get how any lingering data could be delivered across a pipe close.
>>> Weird.
>>>
>>> Could you send your .config? TIA,
>> I have attached my .config-file.
>>
> 
> Bug confirmed. Some SMP-race seems to be at work here. Will fix, thanks.
> 

The attached patch against 2.4.0 fixes the issue. It has been merged
into all open maintenance and development trees, and will be part of the
upcoming v2.3.6 and v2.4.1 releases.

Thanks,

-- 
Philippe.

--------------020002070202020407010901
Content-Type: text/x-patch;
 name="pipe-fix-read-race.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pipe-fix-read-race.patch"

Index: ksrc/nucleus/pipe.c
===================================================================
--- ksrc/nucleus/pipe.c	(revision 3286)
+++ ksrc/nucleus/pipe.c	(working copy)
@@ -101,32 +101,36 @@
 }
 
 /* Must be entered with nklock held. */
+#define xnpipe_wait(__state, __mask, __s, __cond)	\
+({							\
+	wait_queue_head_t *__waitq;			\
+	DEFINE_WAIT(__wait);				\
+	int __sigpending;				\
+							\
+	if ((__mask) & XNPIPE_USER_WREAD)		\
+		__waitq = &(__state)->readq;		\
+	else						\
+		__waitq = &(__state)->syncq;		\
+							\
+	xnpipe_enqueue_wait(__state, __mask);		\
+	xnlock_put_irqrestore(&nklock, __s);		\
+									\
+	prepare_to_wait_exclusive(__waitq, &__wait, TASK_INTERRUPTIBLE);\
+									\
+	if (__cond)							\
+		xnpipe_dequeue_wait(__state, __mask);			\
+	else								\
+		schedule();						\
+									\
+	finish_wait(__waitq, &__wait);					\
+	__sigpending = signal_pending(current);				\
+									\
+	/* Restore the interrupt state initially set by the caller. */	\
+	xnlock_get_irqsave(&nklock, __s);				\
+									\
+	__sigpending;							\
+})
 
-static inline int xnpipe_wait(xnpipe_state_t *state, int mask, spl_t s)
-{
-	wait_queue_head_t *waitq;
-	DEFINE_WAIT(wait);
-	int sigpending;
-
-	if (mask & XNPIPE_USER_WREAD)
-		waitq = &state->readq;
-	else
-		waitq = &state->syncq;
-
-	xnpipe_enqueue_wait(state, mask);
-	xnlock_put_irqrestore(&nklock, s);
-
-	prepare_to_wait_exclusive(waitq, &wait, TASK_INTERRUPTIBLE);
-	schedule();
-	finish_wait(waitq, &wait);
-	sigpending = signal_pending(current);
-
-	/* Restore the interrupt state initially set by the caller. */
-	xnlock_get_irqsave(&nklock, s);
-
-	return sigpending;
-}
-
 static inline void xnpipe_dequeue_wait(xnpipe_state_t *state, int mask)
 {
 	spl_t s;
@@ -641,11 +645,9 @@
 		if (xnpipe_open_handler) {
 			xnlock_put_irqrestore(&nklock, s);
 
-			err =
-			    xnpipe_open_handler(xnminor_from_state(state),
-						NULL);
-
-			if (err != 0) {
+			err = xnpipe_open_handler(xnminor_from_state(state),
+						  NULL);
+			if (err) {
 				xnpipe_cleanup_user_conn(state);
 				return err;
 			}
@@ -662,10 +664,11 @@
 			return -EWOULDBLOCK;
 		}
 
-		sigpending = xnpipe_wait(state, XNPIPE_USER_WREAD, s);
-
-		if (sigpending && !testbits(state->status, XNPIPE_KERN_CONN)) {
-			xnpipe_cleanup_user_conn(state);
+		sigpending = xnpipe_wait(state, XNPIPE_USER_WREAD, s,
+					 testbits(state->status, XNPIPE_KERN_CONN));
+		if (sigpending) {
+			if (!testbits(state->status, XNPIPE_KERN_CONN))
+				xnpipe_cleanup_user_conn(state);
 			xnlock_put_irqrestore(&nklock, s);
 			return -ERESTARTSYS;
 		}
@@ -675,9 +678,8 @@
 		xnlock_put_irqrestore(&nklock, s);
 
 		if (xnpipe_open_handler)
-			err =
-			    xnpipe_open_handler(xnminor_from_state(state),
-						state->cookie);
+			err = xnpipe_open_handler(xnminor_from_state(state),
+						  state->cookie);
 	}
 
 	if (err)
@@ -763,7 +765,8 @@
 			return -EAGAIN;
 		}
 
-		sigpending = xnpipe_wait(state, XNPIPE_USER_WREAD, s);
+		sigpending = xnpipe_wait(state, XNPIPE_USER_WREAD, s,
+					 !emptyq_p(&state->outq));
 		holder = getq(&state->outq);
 		mh = link2mh(holder);
 
@@ -897,7 +900,8 @@
 	if (file->f_flags & O_SYNC) {
 		xnlock_get_irqsave(&nklock, s);
 		if (!emptyq_p(&state->inq)) {
-			if (xnpipe_wait(state, XNPIPE_USER_WSYNC, s))
+			if (xnpipe_wait(state, XNPIPE_USER_WSYNC, s,
+					!emptyq_p(&state->inq)))
 				count = -ERESTARTSYS;
 		}
 		xnlock_put_irqrestore(&nklock, s);

--------------020002070202020407010901--

