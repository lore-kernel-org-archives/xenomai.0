Message-ID: <4714F580.7030403@domain.hid>
Date: Tue, 16 Oct 2007 19:31:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090303020509020902020106"
Subject: [Xenomai-core] [RFC][PATCH] Enforce nkaffinity unconditionally
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is a multi-part message in MIME format.
--------------090303020509020902020106
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

after looking at the reason for the nkaffinity-vs.-POSIX issue [1]
again, I came to the conclusion that there is no way to apply the
current global affinity scheme on the POSIX skin. This scheme goes like
this:
 - If the user provides whatever thread affinity _explicitly_, use this
   one.
 - If the user doesn't do so, apply the global nkaffinity.

In kernel space, is is simple to differentiate between both cases,
because all affinity fiddling for all skins go through Xenomai's hands.
But for the user space POSIX skin, we rely on the task affinity that is
 set using standard Linux services, and that one has no "dirty-bit" to
tell both scenarios apart.

So my conclusion is that we should rather apply the nkaffinity always,
ie. logically AND it with the desired (or default) affinity. The
system's default behaviour will still be the same compared to earlier
Xenomai versions, as nkaffinity is ALL_CPUS by default. I also think
this behaviour is easier to understand for the user than the current
approach.

Any concerns about the (yet untested) attached patch?

Jan


[1] https://mail.gna.org/public/xenomai-core/2007-10/msg00012.html


-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------090303020509020902020106
Content-Type: text/x-patch;
 name="always-enforce-nkaffinity.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="always-enforce-nkaffinity.patch"

Index: xenomai/ksrc/nucleus/pod.c
===================================================================
--- xenomai/ksrc/nucleus/pod.c	(Revision 3081)
+++ xenomai/ksrc/nucleus/pod.c	(Arbeitskopie)
@@ -801,8 +801,7 @@ int xnpod_start_thread(xnthread_t *threa
 	if (!xnthread_test_state(thread, XNDORMANT))
 		return -EBUSY;
 
-	if (xnarch_cpus_equal(affinity, XNPOD_ALL_CPUS))
-		affinity = nkaffinity;
+	xnarch_cpus_and(affinity, affinity, nkaffinity);
 
 	xnlock_get_irqsave(&nklock, s);
 
Index: xenomai/ksrc/nucleus/shadow.c
===================================================================
--- xenomai/ksrc/nucleus/shadow.c	(Revision 3081)
+++ xenomai/ksrc/nucleus/shadow.c	(Arbeitskopie)
@@ -1297,7 +1297,7 @@ int xnshadow_map(xnthread_t *thread, xnc
 {
 	xnarch_cpumask_t affinity;
 	unsigned muxid, magic;
-	int prio, err, cpu;
+	int prio, err;
 
 	if (!xnthread_test_state(thread, XNSHADOW))
 		return -EINVAL;
@@ -1347,13 +1347,9 @@ int xnshadow_map(xnthread_t *thread, xnc
 	xnthread_set_state(thread, XNMAPPED);
 	xnpod_suspend_thread(thread, XNRELAX, XN_INFINITE, XN_RELATIVE, NULL);
 
-	/* Restrict affinity to a single CPU of nkaffinity or
-	   the current set. */
-	if (xnarch_cpus_equal(current->cpus_allowed, XNPOD_ALL_CPUS))
-		cpu = xnarch_first_cpu(nkaffinity);
-	else
-		cpu = xnarch_first_cpu(current->cpus_allowed);
-	affinity = xnarch_cpumask_of_cpu(cpu);
+	/* Restrict affinity to a single CPU of nkaffinity & current set. */
+	xnarch_cpus_and(affinity, current->cpus_allowed, nkaffinity);
+	affinity = xnarch_cpumask_of_cpu(xnarch_first_cpu(affinity));
 	set_cpus_allowed(current, affinity);
 
 	if (u_completion) {

--------------090303020509020902020106--

