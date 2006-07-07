Message-ID: <44AE194C.1000208@domain.hid>
Date: Fri, 07 Jul 2006 10:20:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
References: <44ACF5FA.2050205@domain.hid>	<1152196379.4978.74.camel@domain.hid>		<44AD27AF.8050804@domain.hid>	<1152200271.4978.85.camel@domain.hid>	<44AD3048.5050602@domain.hid>
	<44AD3C00.9050909@domain.hid> <44AD45AF.8070205@domain.hid>
In-Reply-To: <44AD45AF.8070205@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC97B5E34BC51821B87EC48CB"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC97B5E34BC51821B87EC48CB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:

> Here is such a patch + a reworked version of the exec-time stats. Compi=
les and boots,
> doesn't cause obvious troubles when running in a loop while threads are=
 created and
> destroyed in parallel. Nevertheless, a quick hack which may contain bug=
s.

As expected, there were bugs. This version of the exec-time patch always =
uses TSC for
timestamping and the related correct conversion function. And it doesn't =
try to update
the exec-time across CPUs as the TSCs may not be in sync. Thus, when ther=
e is no
scheduling activity on some CPU, we may not see progress in /stat. But th=
is is the least
invasive way, and we typically DO have activity anyway.

Jan


---
 include/nucleus/pod.h    |   28 ++++++++++++++++++++++++++++
 include/nucleus/thread.h |    1 +
 ksrc/nucleus/module.c    |   20 ++++++++++++++++----
 ksrc/nucleus/pod.c       |    5 +++++
 ksrc/nucleus/thread.c    |    1 +
 5 files changed, 51 insertions(+), 4 deletions(-)

Index: include/nucleus/thread.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/thread.h.orig
+++ include/nucleus/thread.h
@@ -152,6 +152,7 @@ typedef struct xnthread {
 	unsigned long csw;	/* Context switches (includes
 				   secondary -> primary switches) */
 	unsigned long pf;	/* Number of page faults */
+	xnticks_t exec_time;	/* Accumulated execution time (ticks) */
     } stat;
 #endif /* CONFIG_XENO_OPT_STATS */
=20
Index: include/nucleus/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/pod.h.orig
+++ include/nucleus/pod.h
@@ -145,6 +145,10 @@ typedef struct xnsched {
=20
     xnthread_t rootcb;          /*!< Root thread control block. */
=20
+#ifdef CONFIG_XENO_OPT_STATS
+    xnticks_t last_csw;         /*!< Last context switch (ticks). */
+#endif /* CONFIG_XENO_OPT_STATS */
+
 } xnsched_t;
=20
 #ifdef CONFIG_SMP
@@ -545,6 +549,30 @@ static inline void xnpod_delete_self (vo
     xnpod_delete_thread(xnpod_current_thread());
 }
=20
+#ifdef CONFIG_XENO_OPT_STATS
+static inline void xnpod_acc_exec_time(xnthread_t *thread)
+{
+    xnsched_t *sched =3D thread->sched;
+    xnticks_t now =3D xnarch_get_cpu_tsc();
+
+    thread->stat.exec_time +=3D now - sched->last_csw;
+    sched->last_csw =3D now;
+}
+
+static inline void xnpod_update_csw_date(xnsched_t *sched)
+{
+    sched->last_csw =3D xnarch_get_cpu_tsc();
+}
+#else /* !CONFIG_XENO_OPT_STATS */
+static inline void xnpod_acc_exec_time(xnthread_t *thread)
+{
+}
+
+static inline void xnpod_update_csw_date(xnsched_t *sched)
+{
+}
+#endif /* CONFIG_XENO_OPT_STATS */
+
 #ifdef __cplusplus
 }
 #endif
Index: ksrc/nucleus/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/thread.c.orig
+++ ksrc/nucleus/thread.c
@@ -90,6 +90,7 @@ int xnthread_init(xnthread_t *thread,
 	thread->stat.ssw =3D 0;
 	thread->stat.csw =3D 0;
 	thread->stat.pf =3D 0;
+	thread->stat.exec_time =3D 0;
 #endif /* CONFIG_XENO_OPT_STATS */
=20
 	/* These will be filled by xnpod_start_thread() */
Index: ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/pod.c.orig
+++ ksrc/nucleus/pod.c
@@ -669,6 +669,9 @@ static inline void xnpod_switch_zombie(x
=20
 	xnthread_cleanup_tcb(threadout);
=20
+	/* no need to update stats of dying thread */
+	xnpod_update_csw_date(sched);
+
 	xnarch_finalize_and_switch(xnthread_archtcb(threadout),
 				   xnthread_archtcb(threadin));
=20
@@ -2433,6 +2436,7 @@ void xnpod_schedule(void)
 		xnarch_enter_root(xnthread_archtcb(threadin));
 	}
=20
+	xnpod_acc_exec_time(threadout);
 	xnthread_inc_csw(threadin);
=20
 	xnarch_switch_to(xnthread_archtcb(threadout),
@@ -2604,6 +2608,7 @@ void xnpod_schedule_runnable(xnthread_t=20
 		nkpod->schedhook(runthread, XNREADY);
 #endif /* __XENO_SIM__ */
=20
+	xnpod_acc_exec_time(runthread);
 	xnthread_inc_csw(threadin);
=20
 	xnarch_switch_to(xnthread_archtcb(runthread),
Index: ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/module.c.orig
+++ ksrc/nucleus/module.c
@@ -269,6 +269,7 @@ struct stat_seq_iterator {
 		unsigned long ssw;
 		unsigned long csw;
 		unsigned long pf;
+		xnticks_t exec_time;
 	} stat_info[1];
 };
=20
@@ -309,13 +310,17 @@ static void stat_seq_stop(struct seq_fil
 static int stat_seq_show(struct seq_file *seq, void *v)
 {
 	if (v =3D=3D SEQ_START_TOKEN)
-		seq_printf(seq, "%-3s  %-6s %-10s %-10s %-4s  %-8s  %s\n",
-			   "CPU", "PID", "MSW", "CSW", "PF", "STAT", "NAME");
+		seq_printf(seq, "%-3s  %-6s %-10s %-10s %-4s  %-8s  %12s"
+			   "  %s\n",
+			   "CPU", "PID", "MSW", "CSW", "PF", "STAT", "TIME",
+			   "NAME");
 	else {
 		struct stat_seq_info *p =3D (struct stat_seq_info *)v;
-		seq_printf(seq, "%3u  %-6d %-10lu %-10lu %-4lu  %.8lx  %s\n",
+		unsigned long long exec_time =3D xnarch_tsc_to_ns(p->exec_time);
+		seq_printf(seq, "%3u  %-6d %-10lu %-10lu %-4lu  %.8lx  %12llu"
+			   "  %s\n",
 			   p->cpu, p->pid, p->ssw, p->csw, p->pf, p->status,
-			   p->name);
+			   xnarch_ulldiv(exec_time, 1000, NULL), p->name);
 	}
=20
 	return 0;
@@ -365,6 +370,12 @@ static int stat_seq_open(struct inode *i
=20
 	iter->nentries =3D 0;
=20
+	/* Update exec-time stats at least on current CPU, unsync'ed TSCs
+	   prevent cross-CPU update yet. */
+	xnlock_get_irqsave(&nklock, s);
+	xnpod_acc_exec_time(xnpod_current_thread());
+	xnlock_put_irqrestore(&nklock, s);
+
 	/* Take a snapshot element-wise, restart if something changes
 	   underneath us. */
=20
@@ -389,6 +400,7 @@ static int stat_seq_open(struct inode *i
 		iter->stat_info[n].ssw =3D thread->stat.ssw;
 		iter->stat_info[n].csw =3D thread->stat.csw;
 		iter->stat_info[n].pf =3D thread->stat.pf;
+		iter->stat_info[n].exec_time =3D thread->stat.exec_time;
=20
 		holder =3D nextq(&nkpod->threadq, holder);
=20




--------------enigC97B5E34BC51821B87EC48CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD4DBQFErhlPniDOoMHTA+kRAgGUAJ9Vl1frBgH+vC1hwN/+10p5/CEvyQCRAWXB
GTPtAmsvalsSIiJdNNUjXw==
=50oX
-----END PGP SIGNATURE-----

--------------enigC97B5E34BC51821B87EC48CB--

