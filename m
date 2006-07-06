Message-ID: <44AD45AF.8070205@domain.hid>
Date: Thu, 06 Jul 2006 19:17:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
References: <44ACF5FA.2050205@domain.hid>	<1152196379.4978.74.camel@domain.hid>		<44AD27AF.8050804@domain.hid>	<1152200271.4978.85.camel@domain.hid>
	<44AD3048.5050602@domain.hid> <44AD3C00.9050909@domain.hid>
In-Reply-To: <44AD3C00.9050909@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF7694F58BEFD1AA8FFE5A384"
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
--------------enigF7694F58BEFD1AA8FFE5A384
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:

> Jan Kiszka wrote:
>  =20
>> Philippe Gerum wrote:
>>    =20
>>> On Thu, 2006-07-06 at 17:09 +0200, Jan Kiszka wrote:
>>>      =20
>>>>> We could do that from the current loop below, given that the
>>>>> accumulation routine is changed to use thread->sched implicitely.
>>>>>          =20
>>>> The idea is avoid adding even further load to the nklock-protected l=
oop.
>>>> And we only update the current thread, not each and every.
>>>>
>>>>        =20
>>> Yes, but why? I mean, accumulated time so far remains significant eve=
n
>>> for non-running threads.
>>>      =20
>> Update must only happen for the currently running thread on each cpu,
>> otherwise you skew the stats up.
>>
>>
>> But looking at the whole code in stat_seq_open() again, I now wonder i=
f
>> that whole routine isn't
>>
>> a) fragile on task removal and
>> b) still poorly scaling.
>>
>> The thread name is only copied by reference, a disappearing instance m=
y
>> cause troubles on printing it. And, instead of holding the lock all th=
e
>> time, shouldn't we better
>>
>> 1. pick some element from the queue and mark it somehow
>>    in-use under lock
>> 2. print or copy the entry
>> 3. reacquire the lock to proceed to the next one - after checking if
>>    that element happened to be removed from the queue meanwhile (in th=
at
>>    case we could abort the output or try to resync)
>>    =20
>
> Not feasible (threads may not always be prevented from being deleted),
> but what about this:
>
> - maintain a modification counter for nkpod->threadq
> - in our /proc-loops (sched and latency e.g.):
>   1. take nklock
>   2. get current counter
>   3. compare with previous, restart whole loop if not matching
>   4. copy current element (including the name...)
>   5. forward element pointer
>   6. release nklock
>   7. goto 1 if not end-of-list
>
> As modifications on threadq should be fairly rare, I don't see a risk o=
f
> looping endlessly here.
Here is such a patch + a reworked version of the exec-time stats. Compile=
s and boots,
doesn't cause obvious troubles when running in a loop while threads are c=
reated and
destroyed in parallel. Nevertheless, a quick hack which may contain bugs.=


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


---
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
+    xnticks_t now =3D xntimer_get_rawclock();
+
+    thread->stat.exec_time +=3D now - sched->last_csw;
+    sched->last_csw =3D now;
+}
+
+static inline void xnpod_update_csw_date(xnsched_t *sched)
+{
+    sched->last_csw =3D xntimer_get_rawclock();
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
+		unsigned long long exec_time =3D xnpod_ticks2ns(p->exec_time);
+		seq_printf(seq, "%3u  %-6d %-10lu %-10lu %-4lu  %.8lx  %12llu"
+			   "  %s\n",
 			   p->cpu, p->pid, p->ssw, p->csw, p->pf, p->status,
-			   p->name);
+			   xnarch_ulldiv(exec_time, 1000, NULL), p->name);
 	}
=20
 	return 0;
@@ -333,7 +338,7 @@ static int stat_seq_open(struct inode *i
 	struct stat_seq_iterator *iter =3D NULL;
 	struct seq_file *seq;
 	xnholder_t *holder;
-	int err, count, rev;
+	int err, count, rev, cpu;
 	spl_t s;
=20
 	if (!nkpod)
@@ -365,6 +370,16 @@ static int stat_seq_open(struct inode *i
=20
 	iter->nentries =3D 0;
=20
+	/* update exec-time stats of currently running threads */
+	for_each_online_cpu(cpu) {
+		xnsched_t *sched;
+
+		xnlock_get_irqsave(&nklock, s);
+		sched =3D xnpod_sched_slot(cpu);
+		xnpod_acc_exec_time(sched->runthread);
+		xnlock_put_irqrestore(&nklock, s);
+	}
+
 	/* Take a snapshot element-wise, restart if something changes
 	   underneath us. */
=20
@@ -389,6 +404,7 @@ static int stat_seq_open(struct inode *i
 		iter->stat_info[n].ssw =3D thread->stat.ssw;
 		iter->stat_info[n].csw =3D thread->stat.csw;
 		iter->stat_info[n].pf =3D thread->stat.pf;
+		iter->stat_info[n].exec_time =3D thread->stat.exec_time;
=20
 		holder =3D nextq(&nkpod->threadq, holder);
=20




--------------enigF7694F58BEFD1AA8FFE5A384
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErUWvniDOoMHTA+kRAmh2AJ4tQuAjX140u4WT6RsrYkz4CmXd/wCfcqZA
uuv25JS73hLgsz6jMvSvzKQ=
=Ew77
-----END PGP SIGNATURE-----

--------------enigF7694F58BEFD1AA8FFE5A384--

