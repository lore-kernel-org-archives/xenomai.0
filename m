MIME-Version: 1.0
References: <CAK6DXL3JYzvoz9tnMQJ+FBqUarS7DNh_06oLzfBoSF5gQBYNXw@mail.gmail.com>
 <87fsymok0m.fsf@xenomai.org>
In-Reply-To: <87fsymok0m.fsf@xenomai.org>
From: Marco Barletta <barlettamarco8@gmail.com>
Date: Sun, 16 May 2021 16:15:17 +0200
Message-ID: <CAK6DXL1Mmi5z40D0Mm9=gc2GtczQWwcQKw1kFTtqNjnXtwBD-g@mail.gmail.com>
Subject: Re: Feedback on sched_quota modification
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Thank you very much for the feedback. Yes you got it right, that was the
main idea of the modification and I know it's a very heavy mod, that's why
I said that could be introduced as an additional schedule more than heavily
modifing SCHED_QUOTA, and yes an additional property is needed. However
this could allow threads to use the full space of priority levels still
being isolated from thread of other groups. I'm gonna fix the startup
phase, and I'm gonna fix naming issues of list_first_entry. I want to
apologize for some italian left comment, it was useful for me when I was
learning the scheduler and I forgot to remove it.
Anyway I'm posting the patch so everyone in the mailing list can read what
we're talking about.
Best regards.

diff -Naur ./original/include/cobalt/kernel/sched-quota.h
./modified/include/cobalt/kernel/sched-quota.h
--- ./original/include/cobalt/kernel/sched-quota.h 2021-03-01
17:50:32.000000000 +0100
+++ ./modified/include/cobalt/kernel/sched-quota.h 2021-05-14
11:15:43.167462700 +0200
@@ -44,10 +44,13 @@
  xnticks_t run_start_ns;
  xnticks_t run_budget_ns;
  xnticks_t run_credit_ns;
+ struct list_head rlink;
  struct list_head members;
- struct list_head expired;
+ struct list_head quota_expired;
+ xnsched_queue_t runnable;
  struct list_head next;
  int nr_active;
+ int cprio;
  int nr_threads;
  int tgid;
  int quota_percent;
@@ -59,13 +62,13 @@
  struct xntimer refill_timer;
  struct xntimer limit_timer;
  struct list_head groups;
+ struct list_head runnable;
+ struct list_head expired;
 };

 static inline int xnsched_quota_init_thread(struct xnthread *thread)
 {
  thread->quota =3D NULL;
- INIT_LIST_HEAD(&thread->quota_expired);
-
  return 0;
 }

@@ -81,6 +84,10 @@
      int quota_percent, int quota_peak_percent,
      int *quota_sum_r);

+
+void xnsched_quota_set_prio(struct xnsched_quota_group *tg,
+     int prio);
+
 struct xnsched_quota_group *
 xnsched_quota_find_group(struct xnsched *sched, int tgid);

diff -Naur ./original/include/cobalt/kernel/thread.h
./modified/include/cobalt/kernel/thread.h
--- ./original/include/cobalt/kernel/thread.h 2021-03-01 17:50:32.000000000
+0100
+++ ./modified/include/cobalt/kernel/thread.h 2021-05-12 17:08:38.226559900
+0200
@@ -105,7 +105,6 @@
 #endif
 #ifdef CONFIG_XENO_OPT_SCHED_QUOTA
  struct xnsched_quota_group *quota; /* Quota scheduling group. */
- struct list_head quota_expired;
  struct list_head quota_next;
 #endif
  cpumask_t affinity; /* Processor affinity. */
diff -Naur ./original/include/cobalt/uapi/sched.h
./modified/include/cobalt/uapi/sched.h
--- ./original/include/cobalt/uapi/sched.h 2021-03-01 17:50:32.000000000
+0100
+++ ./modified/include/cobalt/uapi/sched.h 2021-05-12 17:27:17.979432500
+0200
@@ -103,6 +103,7 @@
  int tgid;
  int quota;
  int quota_peak;
+ int prio;
  } set;
  struct {
  int tgid;
diff -Naur ./original/kernel/cobalt/posix/sched.c
./modified/kernel/cobalt/posix/sched.c
--- ./original/kernel/cobalt/posix/sched.c 2021-03-01 17:50:32.000000000
+0100
+++ ./modified/kernel/cobalt/posix/sched.c 2021-05-12 18:13:38.512521900
+0200
@@ -462,6 +462,7 @@
  group =3D container_of(tg, struct cobalt_sched_group, quota);
  if (group->scope !=3D cobalt_current_resources(group->pshared))
  goto bad_tgid;
+ xnsched_quota_set_prio(tg, p->set.prio);
  xnsched_quota_set_limit(tg, p->set.quota, p->set.quota_peak,
  &quota_sum);
  xnlock_put_irqrestore(&nklock, s);
diff -Naur ./original/kernel/cobalt/sched-quota.c
./modified/kernel/cobalt/sched-quota.c
--- ./original/kernel/cobalt/sched-quota.c 2021-05-16 13:00:58.857223500
+0200
+++ ./modified/kernel/cobalt/sched-quota.c 2021-05-16 13:00:38.715992300
+0200
@@ -85,8 +85,8 @@
  return 0;
 }

-static inline void replenish_budget(struct xnsched_quota *qs,
-    struct xnsched_quota_group *tg)
+//diamo una mano al caching e al compilatore ... quel codice non verr=C3=
=A0 mai
usato
+static inline void replenish_budget(struct xnsched_quota_group *tg)
 {
  xnticks_t budget_ns, credit_ns;

@@ -147,8 +147,7 @@

 static void quota_refill_handler(struct xntimer *timer)
 {
- struct xnsched_quota_group *tg;
- struct xnthread *thread, *tmp;
+ struct xnsched_quota_group *tg, *tmp;
  struct xnsched_quota *qs;
  struct xnsched *sched;

@@ -157,13 +156,10 @@
  sched =3D container_of(qs, struct xnsched, quota);

  trace_cobalt_schedquota_refill(0);
-
  list_for_each_entry(tg, &qs->groups, next) {
  /* Allot a new runtime budget for the group. */
- replenish_budget(qs, tg);
+ replenish_budget(tg);

- if (tg->run_budget_ns =3D=3D 0 || list_empty(&tg->expired))
- continue;
  /*
  * For each group living on this CPU, move all expired
  * threads back to the runqueue. Since those threads
@@ -173,9 +169,14 @@
  * The expiry queue is FIFO to keep ordering right
  * among expired threads.
  */
- list_for_each_entry_safe_reverse(thread, tmp, &tg->expired,
quota_expired) {
- list_del_init(&thread->quota_expired);
- xnsched_addq(&sched->rt.runnable, thread);
+ }
+ if(!list_empty(&qs->expired))
+ {
+ list_for_each_entry_safe_reverse(tg, tmp, &qs->expired, quota_expired){
+ list_del_init(&tg->quota_expired);
+ if(tg->nr_active>0){
+ list_add_prilf(tg, &qs->runnable, cprio, rlink);
+ }
  }
  }

@@ -185,7 +186,6 @@
 static void quota_limit_handler(struct xntimer *timer)
 {
  struct xnsched *sched;
-
  sched =3D container_of(timer, struct xnsched, quota.limit_timer);
  /*
  * Force a rescheduling on the return path of the current
@@ -217,6 +217,8 @@

  qs->period_ns =3D CONFIG_XENO_OPT_SCHED_QUOTA_PERIOD * 1000ULL;
  INIT_LIST_HEAD(&qs->groups);
+ INIT_LIST_HEAD(&qs->expired);
+ INIT_LIST_HEAD(&qs->runnable);

 #ifdef CONFIG_SMP
  ksformat(refiller_name, sizeof(refiller_name),
@@ -337,29 +339,12 @@
 static void xnsched_quota_forget(struct xnthread *thread)
 {
  trace_cobalt_schedquota_remove_thread(thread->quota, thread);
-
  thread->quota->nr_threads--;
  XENO_BUG_ON(COBALT, thread->quota->nr_threads < 0);
  list_del(&thread->quota_next);
  thread->quota =3D NULL;
 }

-static void xnsched_quota_kick(struct xnthread *thread)
-{
- struct xnsched_quota_group *tg =3D thread->quota;
- struct xnsched *sched =3D thread->sched;
-
- /*
- * Allow a kicked thread to be elected for running until it
- * relaxes, even if the group it belongs to lacks runtime
- * budget.
- */
- if (tg->run_budget_ns =3D=3D 0 && !list_empty(&thread->quota_expired)) {
- list_del_init(&thread->quota_expired);
- xnsched_addq_tail(&sched->rt.runnable, thread);
- }
-}
-
 static inline int thread_is_runnable(struct xnthread *thread)
 {
  return thread->quota->run_budget_ns > 0 ||
@@ -371,25 +356,32 @@
  struct xnsched_quota_group *tg =3D thread->quota;
  struct xnsched *sched =3D thread->sched;

- if (!thread_is_runnable(thread))
- list_add_tail(&thread->quota_expired, &tg->expired);
- else
- xnsched_addq_tail(&sched->rt.runnable, thread);
-
+ xnsched_addq_tail(&tg->runnable, thread);
+ /* if the group wasn't active and now it becomes active, either it has
budget to run (likely) thus we enqueue to runnable queue, or it's expired
because of a former execution, thus
+ we add to expired list*/
+ if (!tg->nr_active){
+ if(tg->run_budget_ns)
+ list_add_priff(tg, &sched->quota.runnable, cprio, rlink);
+ else
+ list_add_tail(&tg->quota_expired, &qs->expired);
+ }
  tg->nr_active++;
 }

 static void xnsched_quota_dequeue(struct xnthread *thread)
 {
  struct xnsched_quota_group *tg =3D thread->quota;
- struct xnsched *sched =3D thread->sched;
-
- if (!list_empty(&thread->quota_expired))
- list_del_init(&thread->quota_expired);
- else
- xnsched_delq(&sched->rt.runnable, thread);

+ xnsched_delq(&tg->runnable, thread);
  tg->nr_active--;
+ /* if there was a thread active in the group and now it's empty it means
that either the group was active and waiting for the CPU, thus we remove it
from the runnable queue
+   or it's expired , thus we remove  it from expired list. To be expired,
group expier_quota must be not empty*/
+ if (!tg->nr_active){
+ if(!list_empty(&tg->quota_expired))
+ list_del_init(&tg->quota_expired);
+ else
+ list_del(&tg->rlink);
+ }
 }

 static void xnsched_quota_requeue(struct xnthread *thread)
@@ -397,13 +389,29 @@
  struct xnsched_quota_group *tg =3D thread->quota;
  struct xnsched *sched =3D thread->sched;

- if (!thread_is_runnable(thread))
- list_add(&thread->quota_expired, &tg->expired);
- else
- xnsched_addq(&sched->rt.runnable, thread);
-
+ xnsched_addq(&tg->runnable, thread);
+ if (!tg->nr_active){
+ if(tg->run_budget_ns)
+ list_add_prilf(tg, &sched->quota.runnable, cprio, rlink);
+ else
+ list_add_tail(&tg->quota_expired, &qs->expired);
+ }
  tg->nr_active++;
 }
+#define list_get_entry_group(__head, __type, __member) \
+  ({ \
+  __type *__item; \
+  __item =3D list_first_entry(__head, __type, __member); \
+  __item; \
+  })
+
+#define xnsched_getq_group(__q) \
+ ({ \
+ struct xnsched_quota_group *__t =3D NULL; \
+ if (!list_empty(__q)) \
+ __t =3D list_get_entry_group(__q, struct xnsched_quota_group, rlink); \
+ __t; \
+ })

 static struct xnthread *xnsched_quota_pick(struct xnsched *sched)
 {
@@ -427,36 +435,30 @@
  else
  otg->run_budget_ns =3D 0;
 pick:
- next =3D xnsched_getq(&sched->rt.runnable);
- if (next =3D=3D NULL) {
+ tg =3D xnsched_getq_group(&qs->runnable);
+ if (unlikely(tg =3D=3D NULL)) { //se non ho thread grup posso perdere tem=
po
con mispred
  xntimer_stop(&qs->limit_timer);
  return NULL;
  }

- /*
- * As we basically piggyback on the SCHED_FIFO runqueue, make
- * sure to detect non-quota threads.
- */
- tg =3D next->quota;
- if (tg =3D=3D NULL)
- return next;
-
  tg->run_start_ns =3D now;

+ if (tg->run_budget_ns =3D=3D 0) {
+ /* Flush expired group as we go. */
+ list_del(&tg->rlink);
+ list_add_tail(&tg->quota_expired, &qs->expired);
+ goto pick;
+ }
+
+ if (tg-> nr_active =3D=3D 1)
+ list_del(&tg->rlink);
+
+ next =3D xnsched_getq(&tg->runnable);
+
  /*
  * Don't consider budget if kicked, we have to allow this
  * thread to run until it eventually relaxes.
  */
- if (xnthread_test_info(next, XNKICKED)) {
- xntimer_stop(&qs->limit_timer);
- goto out;
- }
-
- if (tg->run_budget_ns =3D=3D 0) {
- /* Flush expired group members as we go. */
- list_add_tail(&next->quota_expired, &tg->expired);
- goto pick;
- }

  if (otg =3D=3D tg && xntimer_running_p(&qs->limit_timer))
  /* Same group, leave the running timer untouched. */
@@ -468,7 +470,9 @@
  if (ret) {
  /* Budget exhausted: deactivate this group. */
  tg->run_budget_ns =3D 0;
- list_add_tail(&next->quota_expired, &tg->expired);
+ xnsched_addq(&tg->runnable, next);
+ list_del(&tg->rlink);
+ list_add_tail(&tg->quota_expired, &qs->expired);
  goto pick;
  }
 out:
@@ -530,8 +534,11 @@
  tg->quota_peak_ns =3D qs->period_ns;
  tg->nr_active =3D 0;
  tg->nr_threads =3D 0;
+ tg->cprio =3D XNSCHED_QUOTA_MIN_PRIO;
+ //tg->rlink
  INIT_LIST_HEAD(&tg->members);
- INIT_LIST_HEAD(&tg->expired);
+ xnsched_initq(&tg->runnable);
+ INIT_LIST_HEAD(&tg->quota_expired);

  trace_cobalt_schedquota_create_group(tg);

@@ -587,8 +594,9 @@
  struct xnsched *sched =3D tg->sched;
  struct xnsched_quota *qs =3D &sched->quota;
  xnticks_t old_quota_ns =3D tg->quota_ns;
- struct xnthread *thread, *tmp, *curr;
+ struct xnthread *curr;
  xnticks_t now, elapsed, consumed;
+ struct xnsched_quota_group *tgit;

  atomic_only();

@@ -643,10 +651,10 @@
  *quota_sum_r =3D quota_sum_all(qs);

  if (tg->run_budget_ns > 0) {
- list_for_each_entry_safe_reverse(thread, tmp, &tg->expired,
- quota_expired) {
- list_del_init(&thread->quota_expired);
- xnsched_addq(&sched->rt.runnable, thread);
+ if(!list_empty(&tg->quota_expired)){
+ list_del_init(&tg->quota_expired);
+ if(tg->nr_active>0)
+ list_add_priff(tg, &sched->quota.runnable, cprio, rlink);
  }
  }

@@ -654,11 +662,24 @@
  * Apply the new budget immediately, in case a member of this
  * group is currently running.
  */
+
  xnsched_set_resched(sched);
  xnsched_run();
 }
 EXPORT_SYMBOL_GPL(xnsched_quota_set_limit);

+void xnsched_quota_set_prio(struct xnsched_quota_group *tg,
+     int prio)
+{
+ if(tg =3D=3D NULL)
+ return;
+
+ if(prio < XNSCHED_QUOTA_MIN_PRIO || prio > XNSCHED_QUOTA_MAX_PRIO)
+ prio =3D XNSCHED_QUOTA_MIN_PRIO;
+ tg->cprio =3D prio;
+}
+EXPORT_SYMBOL_GPL(xnsched_quota_set_prio);
+
 struct xnsched_quota_group *
 xnsched_quota_find_group(struct xnsched *sched, int tgid)
 {
@@ -705,6 +726,7 @@
  int tgid;
  xnticks_t budget;
  char name[XNOBJECT_NAME_LEN];
+ int tgid_prio;
 };

 static struct xnvfile_snapshot_ops vfile_sched_quota_ops;
@@ -754,7 +776,7 @@
  p->tgid =3D thread->quota->tgid;
  p->prio =3D thread->cprio;
  p->budget =3D thread->quota->run_budget_ns;
-
+ p->tgid_prio =3D thread->quota->cprio;
  return 1;
 }

@@ -765,16 +787,17 @@
  char buf[16];

  if (p =3D=3D NULL)
- xnvfile_printf(it, "%-3s  %-6s %-4s %-4s %-10s %s\n",
-       "CPU", "PID", "TGID", "PRI", "BUDGET", "NAME");
+ xnvfile_printf(it, "%-3s  %-6s %-4s %-4s %-10s %-10s %s\n",
+       "CPU", "PID", "TGID", "PRI", "BUDGET", "GPRI", "NAME");
  else {
  xntimer_format_time(p->budget, buf, sizeof(buf));
- xnvfile_printf(it, "%3u  %-6d %-4d %-4d %-10s %s\n",
+ xnvfile_printf(it, "%3u  %-6d %-4d %-4d %-10s %-10d %s\n",
        p->cpu,
        p->pid,
        p->tgid,
        p->prio,
        buf,
+   p->tgid_prio,
        p->name);
  }

@@ -823,7 +846,7 @@
  .sched_trackprio =3D xnsched_quota_trackprio,
  .sched_protectprio =3D xnsched_quota_protectprio,
  .sched_forget =3D xnsched_quota_forget,
- .sched_kick =3D xnsched_quota_kick,
+ .sched_kick =3D NULL,
 #ifdef CONFIG_XENO_OPT_VFILE
  .sched_init_vfile =3D xnsched_quota_init_vfile,
  .sched_cleanup_vfile =3D xnsched_quota_cleanup_vfile,

Il giorno dom 16 mag 2021 alle ore 16:01 Philippe Gerum <rpm@xenomai.org>
ha scritto:

>
> Hi,
>
> Marco Barletta via Xenomai <xenomai@xenomai.org> writes:
>
> > Hi everyone;
> > you can find attached the modification I made to sched_quota in order t=
o
> > have a hierarchical scheduler. Actually original sched_quota wasn't tru=
ly
> > hierarchical since when a group expires and has a lot of thread ready t=
o
> > run, it considers one by one threads and on the go flushes them to the
> > expired list. In this there's a problem since this operation could not =
be
> > bounded in time since it's O(n) and could be nasty for theoretical
> analysis
> > in hard-real-time systems.
> > If you are interested in such modification in order to add it as a sche=
d
> > modification or to add it as a new scheduler, I'd be delighted to have =
a
> > feedback from you.
> > I had some problems to handle kick function because of the double
> runnable
> > queue. Moreover I want to specify that I choose to implement the runnab=
le
> > list of groups with a linked list and not xnsched_queue_t since we expe=
ct
> > just a few goups and anyway their number is bounded by compile time
> macro,
> > so is still O(1).
> > Best regards.
>
> Introducing a dedicated SCHED_QUOTA runqueue instead of piggybacking on
> the SCHED_FIFO class simplifies some portions of the code elegantly and
> indeed solves the O(N) issue upon re-arming threads from groups which
> have their runtime budget replenished.
>
> However this also introduces a significant change to SCHED_QUOTA: a new
> group priority property needs to be defined, for ordering groups in the
> per-CPU runqueue for the quota policy if I got that correctly. Threads
> are then picked by group priority, then thread priority within that
> group, instead of competing solely on thread priority globally. I guess
> this denotes the hierarchical view you mentioned. In other words, this
> is no more SCHED_QUOTA as we currently define its behavior.
>
> A couple of nitpicks now:
>
> - it seems that any new active group would have to wait for the next
>   replenishment tick to happen via quota_refill_handler(), where it can
>   be queued as runnable into the per-CPU runqueue. Practically this
>   might not make much of a difference, but in theory, this might cause
>   some unexpected delay before its thread can be scheduled.
>
> - we tend to assume that list_get_*() means 'consume the item at head',
>   meaning the item is unlinked from the list if present then returned to
>   the caller. So list_get_entry_group() may be confusing with that in
>   mind, list_first_entry_group() would better describe what this does if
>   we were to follow the common convention.
>
> - the handling of kicked threads must be restored at some point,
>   otherwise this scheduling policy could cause soft hangs in some
>   runtime situations. This said, this is clearly not a fundamental issue
>   wrt mere scheduling.
>
> - C-style comments, English only. Generally speaking, we follow the
>   kernel coding style
>   (https://www.kernel.org/doc/html/latest/process/coding-style.html),
>   some fixes here and there may be due in this dept.
>
> PS: please post your patches inline instead of attached, this is easier
> for commenting on them.
>
> --
> Philippe.
>


--=20
Marco Barletta
