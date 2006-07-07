Message-ID: <44AECB5B.20504@domain.hid>
Date: Fri, 07 Jul 2006 23:00:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAED00B910CFCCCA7C895BA7F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 1/2] /proc output - improve scalability
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
--------------enigAED00B910CFCCCA7C895BA7F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This is an unmodified resent of my previously posted patch to make
/proc/xenomai/{sched,stat} O(1) wrt nklock. It also solve a potential rac=
e during
thread cleanup when accessing the dying thread's name.

Jan


---
 include/nucleus/pod.h |    1=20
 ksrc/nucleus/module.c |   94 +++++++++++++++++++++++++++++++++----------=
-------
 ksrc/nucleus/pod.c    |    2 +
 3 files changed, 66 insertions(+), 31 deletions(-)

Index: xenomai/include/nucleus/pod.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/nucleus/pod.h
+++ xenomai/include/nucleus/pod.h
@@ -195,6 +195,7 @@ struct xnpod {
     xnsched_t sched[XNARCH_NR_CPUS]; /*!< Per-cpu scheduler slots. */
=20
     xnqueue_t threadq;          /*!< All existing threads. */
+    int threadq_rev;            /*!< Modification counter of threadq. */=

=20
     volatile u_long schedlck;	/*!< Scheduler lock count. */
=20
Index: xenomai/ksrc/nucleus/module.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/module.c
+++ xenomai/ksrc/nucleus/module.c
@@ -99,7 +99,7 @@ struct sched_seq_iterator {
 	struct sched_seq_info {
 		int cpu;
 		pid_t pid;
-		const char *name;
+		char name[XNOBJECT_NAME_LEN];
 		int cprio;
 		xnticks_t timeout;
 		xnflags_t status;
@@ -177,17 +177,26 @@ static struct seq_operations sched_op =3D=20
=20
 static int sched_seq_open(struct inode *inode, struct file *file)
 {
-	struct sched_seq_iterator *iter;
+	struct sched_seq_iterator *iter =3D NULL;
 	struct seq_file *seq;
 	xnholder_t *holder;
-	int err, count;
+	int err, count, rev;
 	spl_t s;
=20
 	if (!nkpod)
 		return -ESRCH;
=20
+      restart:
+	xnlock_get_irqsave(&nklock, s);
+
+	rev =3D nkpod->threadq_rev;
 	count =3D countq(&nkpod->threadq);	/* Cannot be empty (ROOT) */
+	holder =3D getheadq(&nkpod->threadq);
+
+	xnlock_put_irqrestore(&nklock, s);
=20
+	if (iter)
+		kfree(iter);
 	iter =3D kmalloc(sizeof(*iter)
 		       + (count - 1) * sizeof(struct sched_seq_info),
 		       GFP_KERNEL);
@@ -202,31 +211,37 @@ static int sched_seq_open(struct inode *
 	}
=20
 	iter->nentries =3D 0;
+	iter->start_time =3D xntimer_get_jiffies();
=20
-	/* Take a snapshot and release the nucleus lock immediately after,
-	   so that dumping /proc/xenomai/sched with lots of entries won't
-	   cause massive jittery. */
+	/* Take a snapshot element-wise, restart if something changes
+	   underneath us. */
=20
-	xnlock_get_irqsave(&nklock, s);
+	while (holder) {
+		xnthread_t *thread;
+		int n;
=20
-	iter->start_time =3D xntimer_get_jiffies();
+		xnlock_get_irqsave(&nklock, s);
+
+		if (nkpod->threadq_rev !=3D rev)
+			goto restart;
+		rev =3D nkpod->threadq_rev;
=20
-	for (holder =3D getheadq(&nkpod->threadq);
-	     holder && count > 0;
-	     holder =3D nextq(&nkpod->threadq, holder), count--) {
-		xnthread_t *thread =3D link2thread(holder, glink);
-		int n =3D iter->nentries++;
+		thread =3D link2thread(holder, glink);
+		n =3D iter->nentries++;
=20
 		iter->sched_info[n].cpu =3D xnsched_cpu(thread->sched);
 		iter->sched_info[n].pid =3D xnthread_user_pid(thread);
-		iter->sched_info[n].name =3D thread->name;
+		memcpy(iter->sched_info[n].name, thread->name,
+		       sizeof(iter->sched_info[n].name));
 		iter->sched_info[n].cprio =3D thread->cprio;
 		iter->sched_info[n].timeout =3D
 		    xnthread_get_timeout(thread, iter->start_time);
 		iter->sched_info[n].status =3D thread->status;
-	}
=20
-	xnlock_put_irqrestore(&nklock, s);
+		holder =3D nextq(&nkpod->threadq, holder);
+
+		xnlock_put_irqrestore(&nklock, s);
+	}
=20
 	seq =3D (struct seq_file *)file->private_data;
 	seq->private =3D iter;
@@ -250,7 +265,7 @@ struct stat_seq_iterator {
 		int cpu;
 		pid_t pid;
 		xnflags_t status;
-		const char *name;
+		char name[XNOBJECT_NAME_LEN];
 		unsigned long ssw;
 		unsigned long csw;
 		unsigned long pf;
@@ -315,17 +330,26 @@ static struct seq_operations stat_op =3D {
=20
 static int stat_seq_open(struct inode *inode, struct file *file)
 {
-	struct stat_seq_iterator *iter;
+	struct stat_seq_iterator *iter =3D NULL;
 	struct seq_file *seq;
 	xnholder_t *holder;
-	int err, count;
+	int err, count, rev;
 	spl_t s;
=20
 	if (!nkpod)
 		return -ESRCH;
=20
+      restart:
+	xnlock_get_irqsave(&nklock, s);
+
+	rev =3D nkpod->threadq_rev;
 	count =3D countq(&nkpod->threadq);	/* Cannot be empty (ROOT) */
+	holder =3D getheadq(&nkpod->threadq);
+
+	xnlock_put_irqrestore(&nklock, s);
=20
+	if (iter)
+		kfree(iter);
 	iter =3D kmalloc(sizeof(*iter)
 		       + (count - 1) * sizeof(struct stat_seq_info),
 		       GFP_KERNEL);
@@ -341,27 +365,35 @@ static int stat_seq_open(struct inode *i
=20
 	iter->nentries =3D 0;
=20
-	/* Take a snapshot and release the nucleus lock immediately after,
-	   so that dumping /proc/xenomai/stat with lots of entries won't
-	   cause massive jittery. */
+	/* Take a snapshot element-wise, restart if something changes
+	   underneath us. */
=20
-	xnlock_get_irqsave(&nklock, s);
+	while (holder) {
+		xnthread_t *thread;
+		int n;
+
+		xnlock_get_irqsave(&nklock, s);
+
+		if (nkpod->threadq_rev !=3D rev)
+			goto restart;
+		rev =3D nkpod->threadq_rev;
+
+		thread =3D link2thread(holder, glink);
+		n =3D iter->nentries++;
=20
-	for (holder =3D getheadq(&nkpod->threadq);
-	     holder && count > 0;
-	     holder =3D nextq(&nkpod->threadq, holder), count--) {
-		xnthread_t *thread =3D link2thread(holder, glink);
-		int n =3D iter->nentries++;
 		iter->stat_info[n].cpu =3D xnsched_cpu(thread->sched);
 		iter->stat_info[n].pid =3D xnthread_user_pid(thread);
-		iter->stat_info[n].name =3D thread->name;
+		memcpy(iter->stat_info[n].name, thread->name,
+		       sizeof(iter->stat_info[n].name));
 		iter->stat_info[n].status =3D thread->status;
 		iter->stat_info[n].ssw =3D thread->stat.ssw;
 		iter->stat_info[n].csw =3D thread->stat.csw;
 		iter->stat_info[n].pf =3D thread->stat.pf;
-	}
=20
-	xnlock_put_irqrestore(&nklock, s);
+		holder =3D nextq(&nkpod->threadq, holder);
+
+		xnlock_put_irqrestore(&nklock, s);
+	}
=20
 	seq =3D (struct seq_file *)file->private_data;
 	seq->private =3D iter;
Index: xenomai/ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/pod.c
+++ xenomai/ksrc/nucleus/pod.c
@@ -815,6 +815,7 @@ int xnpod_init_thread(xnthread_t *thread
 	xnlock_get_irqsave(&nklock, s);
 	thread->sched =3D xnpod_current_sched();
 	appendq(&nkpod->threadq, &thread->glink);
+	nkpod->threadq_rev++;
 	xnpod_suspend_thread(thread, XNDORMANT | (flags & XNSUSP), XN_INFINITE,=

 			     NULL);
 	xnlock_put_irqrestore(&nklock, s);
@@ -1225,6 +1226,7 @@ void xnpod_delete_thread(xnthread_t *thr
 	sched =3D thread->sched;
=20
 	removeq(&nkpod->threadq, &thread->glink);
+	nkpod->threadq_rev++;
=20
 	if (!testbits(thread->status, XNTHREAD_BLOCK_BITS)) {
 		if (testbits(thread->status, XNREADY)) {






--------------enigAED00B910CFCCCA7C895BA7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFErstbniDOoMHTA+kRAsVJAJ4pmD/yALEPGF5ziCvu7l7xFMcCegCfbiu3
MDEKWiFfuotTXTpLn1M/L1g=
=DIK5
-----END PGP SIGNATURE-----

--------------enigAED00B910CFCCCA7C895BA7F--

