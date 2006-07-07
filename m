Message-ID: <44AECB5F.1080100@domain.hid>
Date: Fri, 07 Jul 2006 23:00:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig84F987403BAF49AB49488FF4"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 2/2] /proc output - add CPU usage stats
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
--------------enig84F987403BAF49AB49488FF4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yet another (hopefully the final) version of my attempt to add simple per=
-thread CPU
usage statistics. This variant now prints the usage in percent directly v=
ia
/proc/xenomai/stat.

As Philippe suggested to reorganise the /proc section for statistics, I d=
ecided to make
this probably intermediate version independent of any user-space tools. Y=
ou can simply
type "cat /proc/xenomai/stat" as often as you like to update the stats. E=
xample:

root@domain.hid :/root# cat /proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          5836670    0     01400080   78.8  ROOT
  0  0      0          1          0     00000082    0.0  timsPipeReceiver=

  0  1029   1          1          0     00c00180    0.0  irqloop
  0  1030   1          7843       0     00c00082    4.2  irqloop
  0  1039   16         140        0     00c00082    0.1  display-1038
  0  0      0          166598     0     00000084   16.9  timerbench

Each output marks the beginning of the following measuring interval, thus=
 when running

    while true; do cat /proc/xenomai/stat; sleep 1; clear; done

you effectively get the CPU usage of the last second continuously updated=
=2E

Note that the results are not always accurate when threads are added, rem=
oved, or
migrated. If numbers looks weird, just re-run and things should normalise=
=2E This is due
to the fact that the measuring only takes place between context switches =
on each CPU,
now longer explicitly on output. This appears least intrusive and SMP-saf=
e to me.
Nevertheless, I'm lacking SMP here, real testing is still required.

Jan


---
 include/nucleus/pod.h    |   38 ++++++++++++++++++++++++++++++++++++++
 include/nucleus/thread.h |    2 ++
 ksrc/nucleus/module.c    |   40 +++++++++++++++++++++++++++++++++++-----=

 ksrc/nucleus/pod.c       |    8 ++++++++
 ksrc/nucleus/thread.c    |    2 ++
 5 files changed, 85 insertions(+), 5 deletions(-)

Index: include/nucleus/thread.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/thread.h.orig
+++ include/nucleus/thread.h
@@ -152,6 +152,8 @@ typedef struct xnthread {
 	unsigned long csw;	/* Context switches (includes
 				   secondary -> primary switches) */
 	unsigned long pf;	/* Number of page faults */
+	xnticks_t exec_time;	/* Accumulated execution time (tsc) */
+	xnticks_t exec_start;	/* Start of execution time accumulation (tsc) */
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
@@ -545,6 +549,40 @@ static inline void xnpod_delete_self (vo
     xnpod_delete_thread(xnpod_current_thread());
 }
=20
+#ifdef CONFIG_XENO_OPT_STATS
+static inline void xnpod_acc_exec_time(xnsched_t *sched, xnthread_t *thr=
ead)
+{
+    xnticks_t now =3D xnarch_get_cpu_tsc();
+
+    thread->stat.exec_time +=3D now - sched->last_csw;
+    sched->last_csw =3D now;
+}
+
+static inline void xnpod_reset_exec_stats(xnthread_t *thread)
+{
+    thread->stat.exec_time =3D 0;
+    thread->stat.exec_start =3D xnarch_get_cpu_tsc();
+}
+
+static inline void xnpod_update_csw_date(xnsched_t *sched)
+{
+    sched->last_csw =3D xnarch_get_cpu_tsc();
+}
+
+#else /* !CONFIG_XENO_OPT_STATS */
+static inline void xnpod_acc_exec_time(xnsched_t *sched, xnthread_t *thr=
ead)
+{
+}
+
+static inline void xnpod_reset_exec_stats(xnthread_t *thread)
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
@@ -1889,6 +1892,9 @@ int xnpod_migrate_thread(int cpu)
=20
 	xnpod_schedule();
=20
+	/* Reset execution time stats due to unsync'ed TSCs */
+	xnpod_reset_exec_stats(thread);
+
       unlock_and_exit:
=20
 	xnlock_put_irqrestore(&nklock, s);
@@ -2433,6 +2439,7 @@ void xnpod_schedule(void)
 		xnarch_enter_root(xnthread_archtcb(threadin));
 	}
=20
+	xnpod_acc_exec_time(sched, threadout);
 	xnthread_inc_csw(threadin);
=20
 	xnarch_switch_to(xnthread_archtcb(threadout),
@@ -2604,6 +2611,7 @@ void xnpod_schedule_runnable(xnthread_t=20
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
--- ksrc/nucleus/module.c.orig
+++ ksrc/nucleus/module.c
@@ -269,6 +269,8 @@ struct stat_seq_iterator {
 		unsigned long ssw;
 		unsigned long csw;
 		unsigned long pf;
+		xnticks_t exec_time;
+		xnticks_t exec_period;
 	} stat_info[1];
 };
=20
@@ -309,13 +311,27 @@ static void stat_seq_stop(struct seq_fil
 static int stat_seq_show(struct seq_file *seq, void *v)
 {
 	if (v =3D=3D SEQ_START_TOKEN)
-		seq_printf(seq, "%-3s  %-6s %-10s %-10s %-4s  %-8s  %s\n",
-			   "CPU", "PID", "MSW", "CSW", "PF", "STAT", "NAME");
+		seq_printf(seq, "%-3s  %-6s %-10s %-10s %-4s  %-8s  %5s"
+			   "  %s\n",
+			   "CPU", "PID", "MSW", "CSW", "PF", "STAT", "%CPU",
+			   "NAME");
 	else {
 		struct stat_seq_info *p =3D (struct stat_seq_info *)v;
-		seq_printf(seq, "%3u  %-6d %-10lu %-10lu %-4lu  %.8lx  %s\n",
+		int usage =3D 0;
+
+		if (p->exec_period) {
+			while (p->exec_period > 0xFFFFFFFF) {
+				p->exec_time >>=3D 16;
+				p->exec_period >>=3D 16;
+			}
+			usage =3D xnarch_ulldiv(
+				p->exec_time * 1000LL + (p->exec_period >> 1),
+				p->exec_period, NULL);
+		}
+		seq_printf(seq, "%3u  %-6d %-10lu %-10lu %-4lu  %.8lx  %3u.%u"
+			   "  %s\n",
 			   p->cpu, p->pid, p->ssw, p->csw, p->pf, p->status,
-			   p->name);
+			   usage / 10, usage % 10, p->name);
 	}
=20
 	return 0;
@@ -370,6 +386,8 @@ static int stat_seq_open(struct inode *i
=20
 	while (holder) {
 		xnthread_t *thread;
+		xnsched_t *sched;
+		xnticks_t period;
 		int n;
=20
 		xnlock_get_irqsave(&nklock, s);
@@ -381,7 +399,8 @@ static int stat_seq_open(struct inode *i
 		thread =3D link2thread(holder, glink);
 		n =3D iter->nentries++;
=20
-		iter->stat_info[n].cpu =3D xnsched_cpu(thread->sched);
+		sched =3D thread->sched;
+		iter->stat_info[n].cpu =3D xnsched_cpu(sched);
 		iter->stat_info[n].pid =3D xnthread_user_pid(thread);
 		memcpy(iter->stat_info[n].name, thread->name,
 		       sizeof(iter->stat_info[n].name));
@@ -390,6 +409,17 @@ static int stat_seq_open(struct inode *i
 		iter->stat_info[n].csw =3D thread->stat.csw;
 		iter->stat_info[n].pf =3D thread->stat.pf;
=20
+		period =3D sched->last_csw - thread->stat.exec_start;
+		if (!period && thread =3D=3D sched->runthread) {
+			iter->stat_info[n].exec_time =3D 1;
+			iter->stat_info[n].exec_period =3D 1;
+		} else {
+			iter->stat_info[n].exec_time =3D thread->stat.exec_time;
+			iter->stat_info[n].exec_period =3D period;
+		}
+		thread->stat.exec_time =3D 0;
+		thread->stat.exec_start =3D sched->last_csw;
+
 		holder =3D nextq(&nkpod->threadq, holder);
=20
 		xnlock_put_irqrestore(&nklock, s);
Index: ksrc/nucleus/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/thread.c.orig
+++ ksrc/nucleus/thread.c
@@ -90,6 +90,8 @@ int xnthread_init(xnthread_t *thread,
 	thread->stat.ssw =3D 0;
 	thread->stat.csw =3D 0;
 	thread->stat.pf =3D 0;
+	thread->stat.exec_time =3D 0;
+	thread->stat.exec_start =3D 0;
 #endif /* CONFIG_XENO_OPT_STATS */
=20
 	/* These will be filled by xnpod_start_thread() */




--------------enig84F987403BAF49AB49488FF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFErstfniDOoMHTA+kRAhZfAJ4gq4VNdkxqdMHz7bwT6oSeSAJIPwCfW6jX
xAlgG3+D+Hv7xftRpETmNkM=
=pjao
-----END PGP SIGNATURE-----

--------------enig84F987403BAF49AB49488FF4--

