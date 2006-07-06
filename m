Message-ID: <44ACF5FA.2050205@domain.hid>
Date: Thu, 06 Jul 2006 13:37:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1F10053913187D5D45E81E8D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1F10053913187D5D45E81E8D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

I think to remember people crying for some execution time statistics for =
quite a
while now. Here comes a straightforward approach to add this on a per-thr=
ead basis.
The results are printed like this:

root@domain.hid :/root# cat /proc/xenomai/stat=20
CPU  PID    MSW        CSW        PF    STAT              TIME  NAME
  0  0      0          7508041    0     01400080     166038894  ROOT
  0  0      0          2          0     00000082            55  timsPipeR=
eceiver
  0  1009   751        8800       0     00c00082        143026  display-1=
008
  0  1010   0          7514585    0     00c00084      54472477  sampling-=
1008

The new TIME column contains the accumulated execution time of each activ=
e thread in
nanoseconds. It's now a job of some user-space tool (shell script?) to pi=
ck those
numbers up and do, e.g., periodic evaluation (I'm thinking of some "xeno-=
top"). Any
volunteer around to hack this? Would be very welcome!

Jan

PS: Could someone have a look that I didn't miss an accounting point and =
my
acquisition is sound?


--
 include/nucleus/pod.h    |   28 ++++++++++++++++++++++++++++
 include/nucleus/thread.h |    1 +
 ksrc/nucleus/module.c    |   26 +++++++++++++++++++++-----
 ksrc/nucleus/pod.c       |    5 +++++
 ksrc/nucleus/thread.c    |    1 +
 5 files changed, 56 insertions(+), 5 deletions(-)

Index: include/nucleus/thread.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/thread.h	(revision 1303)
+++ include/nucleus/thread.h	(working copy)
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
--- include/nucleus/pod.h	(revision 1303)
+++ include/nucleus/pod.h	(working copy)
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
@@ -544,6 +548,30 @@ static inline void xnpod_delete_self (vo
     xnpod_delete_thread(xnpod_current_thread());
 }
=20
+#ifdef CONFIG_XENO_OPT_STATS
+static inline void xnpod_acc_exec_time(xnsched_t *sched,
+                                       xnthread_t *threadout)
+{
+    xnticks_t now =3D xntimer_get_rawclock();
+    threadout->stat.exec_time +=3D now - sched->last_csw;
+    sched->last_csw =3D now;
+}
+
+static inline void xnpod_update_csw_date(xnsched_t *sched)
+{
+    sched->last_csw =3D xntimer_get_rawclock();
+}
+#else /* !CONFIG_XENO_OPT_STATS */
+static inline void xnpod_acc_exec_time(xnsched_t *sched,
+                                       xnthread_t *threadout)
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
--- ksrc/nucleus/thread.c	(revision 1303)
+++ ksrc/nucleus/thread.c	(working copy)
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
--- ksrc/nucleus/pod.c	(revision 1303)
+++ ksrc/nucleus/pod.c	(working copy)
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
@@ -2431,6 +2434,7 @@ void xnpod_schedule(void)
 		xnarch_enter_root(xnthread_archtcb(threadin));
 	}
=20
+	xnpod_acc_exec_time(sched, threadout);
 	xnthread_inc_csw(threadin);
=20
 	xnarch_switch_to(xnthread_archtcb(threadout),
@@ -2602,6 +2606,7 @@ void xnpod_schedule_runnable(xnthread_t=20
 		nkpod->schedhook(runthread, XNREADY);
 #endif /* __XENO_SIM__ */
=20
+	xnpod_acc_exec_time(sched, runthread);
 	xnthread_inc_csw(threadin);
=20
 	xnarch_switch_to(xnthread_archtcb(runthread),
Index: ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/module.c	(revision 1303)
+++ ksrc/nucleus/module.c	(working copy)
@@ -254,6 +254,7 @@ struct stat_seq_iterator {
 		unsigned long ssw;
 		unsigned long csw;
 		unsigned long pf;
+		xnticks_t exec_time;
 	} stat_info[1];
 };
=20
@@ -294,13 +295,17 @@ static void stat_seq_stop(struct seq_fil
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
+		unsigned long long exec_time =3D xnpod_ticks2ns(p->exec_time);
+		seq_printf(seq, "%3u  %-6d %-10lu %-10lu %-4lu  %.8lx  %12llu"
+			   "  %s\n",
 			   p->cpu, p->pid, p->ssw, p->csw, p->pf, p->status,
-			   p->name);
+			   xnarch_ulldiv(exec_time, 1000, NULL), p->name);
 	}
=20
 	return 0;
@@ -318,7 +323,7 @@ static int stat_seq_open(struct inode *i
 	struct stat_seq_iterator *iter;
 	struct seq_file *seq;
 	xnholder_t *holder;
-	int err, count;
+	int err, count, cpu;
 	spl_t s;
=20
 	if (!nkpod)
@@ -341,6 +346,16 @@ static int stat_seq_open(struct inode *i
=20
 	iter->nentries =3D 0;
=20
+	/* update exec-time stats of currently running threads */
+	for_each_online_cpu(cpu) {
+		xnsched_t *sched;
+
+		xnlock_get_irqsave(&nklock, s);
+		sched =3D xnpod_sched_slot(cpu);
+		xnpod_acc_exec_time(sched, sched->runthread);
+		xnlock_put_irqrestore(&nklock, s);
+	}
+
 	/* Take a snapshot and release the nucleus lock immediately after,
 	   so that dumping /proc/xenomai/stat with lots of entries won't
 	   cause massive jittery. */
@@ -359,6 +374,7 @@ static int stat_seq_open(struct inode *i
 		iter->stat_info[n].ssw =3D thread->stat.ssw;
 		iter->stat_info[n].csw =3D thread->stat.csw;
 		iter->stat_info[n].pf =3D thread->stat.pf;
+		iter->stat_info[n].exec_time =3D thread->stat.exec_time;
 	}
=20
 	xnlock_put_irqrestore(&nklock, s);




--------------enig1F10053913187D5D45E81E8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErPX6niDOoMHTA+kRAlVrAJ0eae7T+JU0xx9uyZb/wJ89KltgWACfXhuF
C9mdI3gT54zrwR0nBVs3kWw=
=qq1K
-----END PGP SIGNATURE-----

--------------enig1F10053913187D5D45E81E8D--

