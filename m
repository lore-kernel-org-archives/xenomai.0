Date: Thu, 20 May 2010 16:26:14 +0200
From: Tschaeche IT-Services <services@domain.hid>
Message-ID: <20100520142614.GA23058@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
Subject: [Xenomai-help] Monitoring Xenomai scheduler switches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

we started an application which monitors task switches
using Xenomai 2.5.3.

For monitoring primary domain switches we hooked
in our code by using rt_task_add_hook(T_HOOK_SWITCH)
(storing a timestamp and the Xenomai task ID in an array,
which is read later by user space appl from shared memory).

It seems, that our code is not called when Xenomai switches to the ROOT task.

We already had this issue with Xenomai 2.4.10
and solved it by applying the attached patch.

How can we catch these Xenomai scheduler events in 2.5.3?

What is the reason for filtering them out?

Best regards,

	Olli

--cNdxnHkX5QqsyA0e
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="Add-scheduler-switch-notification-for-all-switches.patch"

Index: xenomai-2.4.10/ksrc/nucleus/pod.c
===================================================================
--- xenomai-2.4.10.orig/ksrc/nucleus/pod.c	2009-08-11 15:53:55.000000000 +0200
+++ xenomai-2.4.10/ksrc/nucleus/pod.c	2010-01-27 12:41:05.000000000 +0100
@@ -2561,7 +2561,7 @@
 		nkpod->schedhook(runthread, XNRUNNING);
 #endif /* __XENO_SIM__ */
 
-	if (!emptyq_p(&nkpod->tswitchq) && !xnthread_test_state(runthread, XNROOT)) {
+	if (!emptyq_p(&nkpod->tswitchq)) {
 		trace_mark(xn_nucleus, thread_callout,
 			   "thread %p thread_name %s hook %s",
 			   runthread, xnthread_name(runthread), "SWITCH");

--cNdxnHkX5QqsyA0e--

