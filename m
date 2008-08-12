Message-ID: <48A1AD61.5020704@domain.hid>
Date: Tue, 12 Aug 2008 17:33:53 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48A126E5.7070708@domain.hid>
In-Reply-To: <48A126E5.7070708@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Early timeouts from rt_mutex_acquire() ?
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
To: Josh Bowman <jbowman@domain.hid>
Cc: xenomai@xenomai.org

Josh Bowman wrote:
> Hi,
> 
> In the documentation for rt_mutex_acquire, it says that it should return
> -ETIMEDOUT "if the mutex cannot be made available to the calling task
> within the specified amount of time."
> 
> I'm not sure if this is really a bug, but I've run into a case where the
> it returns the -ETIMEDOUT well before the specified amount of time has
> passed.  It took me a little while to track down what's happening, and
> in the process I've created a small test program.  Basically what's
> happening in the test is that a higher priority task is holding the
> mutex, releases it, and (without blocking) re-acquires the mutex.  Then
> the higher priority task sleeps, and the lower priority task (which
> should be blocked waiting for quite some time yet) wakes up with -ETIMEDOUT.
> 
> Can anyone say whether this behavior is correct?
>

Ouch. No, it's not. The patch below fixes this bug. It has been committed to
both the maintenance and devel branches.

Thanks for the test case.

--- include/nucleus/timer.h	(revision 4088)
+++ include/nucleus/timer.h	(working copy)
@@ -586,6 +586,11 @@
 	return timer->base->ops->get_timer_timeout(timer);
 }

+static inline xnticks_t xntimer_get_timeout_stopped(xntimer_t *timer)
+{
+	return timer->base->ops->get_timer_timeout(timer);
+}
+
 /*!
  * \fn xnticks_t xntimer_get_interval(xntimer_t *timer)
  *
@@ -688,6 +693,11 @@
 	return xntimer_get_timeout_aperiodic(timer);
 }

+static inline xnticks_t xntimer_get_timeout_stopped(xntimer_t *timer)
+{
+	return xntimer_get_timeout_aperiodic(timer);
+}
+
 static inline xnticks_t xntimer_get_interval(xntimer_t *timer)
 {
 	return xntimer_get_interval_aperiodic(timer);

--- ksrc/nucleus/synch.c	(revision 4088)
+++ ksrc/nucleus/synch.c	(working copy)
@@ -234,7 +234,7 @@
 		   for the resource. */
 		if (timeout_mode != XN_RELATIVE || timeout == XN_INFINITE)
 			goto redo;
-		timeout = xnthread_timeout(thread);
+		timeout = xntimer_get_timeout_stopped(&thread->rtimer);
 		if (timeout > 1) /* Otherwise, it's too late. */
 			goto redo;
 		xnthread_set_info(thread, XNTIMEO);

-- 
Philippe.

