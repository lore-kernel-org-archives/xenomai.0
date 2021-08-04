From: MONTET Julien <julien.montet@reseau.eseo.fr>
Subject: RE: [PATCH v3] cobalt: Sort out virtual vs. real pids
Date: Wed, 4 Aug 2021 10:04:20 +0000
Message-ID: <PR3PR02MB62029331AD49FE26DDB7790AD1F19@PR3PR02MB6202.eurprd02.prod.outlook.com>
References: <3e3762cd-fdf6-af27-a4de-c063d0676cda@siemens.com>
In-Reply-To: <3e3762cd-fdf6-af27-a4de-c063d0676cda@siemens.com>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>
Cc: Marco Barletta <barlettamarco8@gmail.com>

Hi Jan,

I did some new tests this morning with your new patch.
It doesn't work yet, but I have some debug info that may help you.

At first, I looked at the output of "cat /proc/xenomai/sched/stat" directly=
 inside the docker and on the target where the app is running.
PID, MSW, CSW and XSC are the same (maybe it is just normal). I can also fi=
nd the same with the command "top".

Then I tried to compare the output of the Docker executable with the classi=
c target executable (which works).
You will find in the link below the output of  "cat /proc/xenomai/sched/sta=
t" where the docker AND the classic executable are running.
The result is the same if the executables work separately
I renamed the thread and added comments with in ().
https://paste.ubuntu.com/p/PSsqTct7xV/
What does MSW, CSW and XSC mean here ? Values remain the same with Docker w=
hile they are different with a normal executable.

Regards,
________________________________
De : Jan Kiszka <jan.kiszka@siemens.com>
Envoy=E9 : lundi 2 ao=FBt 2021 18:56
=C0 : Xenomai <xenomai@xenomai.org>
Cc : MONTET Julien <julien.montet@reseau.eseo.fr>; Marco Barletta <barletta=
marco8@gmail.com>
Objet : [PATCH v3] cobalt: Sort out virtual vs. real pids

From: Jan Kiszka <jan.kiszka@siemens.com>

Make sure that we consider all pids taken from or sent to userspace via
syscalls as virtual. That means converting them to global pids before
processing them or converting them back to virtual pids in the caller's
namespace before reporting them. We also need to switch thread hashing
from vpids to real pids.

Not converted is the procfs interface as this one continues to provide
only a global view on cobalt objects and associated pids.

A few syscall tracepoints that report the vpid as passed down from
userspace get adjusted in their output so that it is clear that no
global pid is shown.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v3:
 - handle process-local thread lookups correctly (hopefully)

This is in next for a while and ran several test cycles. Even if we
should have remaining issues under pid namespaces, we should not have
regressions in the normal cases.

 include/cobalt/kernel/thread.h     |  2 ++
 kernel/cobalt/posix/event.c        |  2 +-
 kernel/cobalt/posix/mqueue.c       |  2 +-
 kernel/cobalt/posix/process.c      | 14 ++++++++++++++
 kernel/cobalt/posix/process.h      |  2 ++
 kernel/cobalt/posix/sched.c        | 10 ++++++----
 kernel/cobalt/posix/sem.c          |  2 +-
 kernel/cobalt/posix/signal.c       | 10 ++++++----
 kernel/cobalt/posix/thread.c       | 18 ++++++++++--------
 kernel/cobalt/posix/thread.h       |  2 +-
 kernel/cobalt/thread.c             | 10 ++++++++++
 kernel/cobalt/trace/cobalt-posix.h |  4 ++--
 12 files changed, 56 insertions(+), 22 deletions(-)

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.=
h
index b79cb84296..4c8a0b9f2a 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -450,6 +450,8 @@ char *xnthread_format_status(unsigned long status,

 pid_t xnthread_host_pid(struct xnthread *thread);

+pid_t xnthread_host_vpid(struct xnthread *thread);
+
 int xnthread_set_clock(struct xnthread *thread,
                        struct xnclock *newclock);

diff --git a/kernel/cobalt/posix/event.c b/kernel/cobalt/posix/event.c
index 3712154f53..5871106301 100644
--- a/kernel/cobalt/posix/event.c
+++ b/kernel/cobalt/posix/event.c
@@ -352,7 +352,7 @@ COBALT_SYSCALL(event_inquire, current,
                 xnsynch_for_each_sleeper(thread, &event->synch) {
                         if (nrwait >=3D nrpids)
                                 break;
-                       t[nrwait++] =3D xnthread_host_pid(thread);
+                       t[nrwait++] =3D xnthread_host_vpid(thread);
                 }
         }

diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
index dd8acd55b0..fcde87a077 100644
--- a/kernel/cobalt/posix/mqueue.c
+++ b/kernel/cobalt/posix/mqueue.c
@@ -720,7 +720,7 @@ mq_notify(struct cobalt_mqd *mqd, unsigned index, const=
 struct sigevent *evp)
                  * receiver's namespaces. We pass the receiver's creds
                  * into the init namespace instead.
                  */
-               mq->si.si_pid =3D task_pid_nr(current);
+               mq->si.si_pid =3D task_pid_vnr(current);
                 mq->si.si_uid =3D get_current_uuid();
         }

diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 1f059ad830..98b7df33fb 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -975,6 +975,20 @@ int cobalt_handle_cleanup_event(struct mm_struct *mm)
         return KEVENT_PROPAGATE;
 }

+pid_t cobalt_vpid2pid_nr(pid_t vpid)
+{
+       struct pid *pid;
+       pid_t nr =3D -1;
+
+       rcu_read_lock();
+       pid =3D find_vpid(vpid);
+       if (pid)
+               nr =3D pid_nr(pid);
+       rcu_read_unlock();
+
+       return nr;
+}
+
 static int attach_process(struct cobalt_process *process)
 {
         struct cobalt_ppd *p =3D &process->sys_ppd;
diff --git a/kernel/cobalt/posix/process.h b/kernel/cobalt/posix/process.h
index 279707a680..46dff43b7a 100644
--- a/kernel/cobalt/posix/process.h
+++ b/kernel/cobalt/posix/process.h
@@ -175,4 +175,6 @@ int cobalt_handle_cleanup_event(struct mm_struct *mm);

 int cobalt_handle_user_return(struct task_struct *task);

+pid_t cobalt_vpid2pid_nr(pid_t vpid);
+
 #endif /* !_COBALT_POSIX_PROCESS_H */
diff --git a/kernel/cobalt/posix/sched.c b/kernel/cobalt/posix/sched.c
index 4fd9c2b46e..26259fbd3f 100644
--- a/kernel/cobalt/posix/sched.c
+++ b/kernel/cobalt/posix/sched.c
@@ -736,7 +736,7 @@ COBALT_SYSCALL(sched_weightprio, current,
         return __cobalt_sched_weightprio(policy, &param_ex);
 }

-int cobalt_sched_setscheduler_ex(pid_t pid,
+int cobalt_sched_setscheduler_ex(pid_t vpid,
                                  int policy,
                                  const struct sched_param_ex *param_ex,
                                  __u32 __user *u_winoff,
@@ -747,9 +747,11 @@ int cobalt_sched_setscheduler_ex(pid_t pid,
         int ret, promoted =3D 0;
         spl_t s;

-       trace_cobalt_sched_setscheduler(pid, policy, param_ex);
+       trace_cobalt_sched_setscheduler(vpid, policy, param_ex);
+
+       if (vpid) {
+               pid_t pid =3D cobalt_vpid2pid_nr(vpid);

-       if (pid) {
                 xnlock_get_irqsave(&nklock, s);
                 thread =3D cobalt_thread_find(pid);
                 xnlock_put_irqrestore(&nklock, s);
@@ -757,7 +759,7 @@ int cobalt_sched_setscheduler_ex(pid_t pid,
                 thread =3D cobalt_current_thread();

         if (thread =3D=3D NULL) {
-               if (u_winoff =3D=3D NULL || pid !=3D task_pid_vnr(current))
+               if (u_winoff =3D=3D NULL || vpid !=3D task_pid_vnr(current)=
)
                         return -ESRCH;

                 thread =3D cobalt_thread_shadow(&hkey, u_winoff);
diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
index 72b20c78d2..030ce8ffed 100644
--- a/kernel/cobalt/posix/sem.c
+++ b/kernel/cobalt/posix/sem.c
@@ -602,7 +602,7 @@ COBALT_SYSCALL(sem_inquire, current,
                 xnsynch_for_each_sleeper(thread, &sem->synchbase) {
                         if (nrwait >=3D nrpids)
                                 break;
-                       t[nrwait++] =3D xnthread_host_pid(thread);
+                       t[nrwait++] =3D xnthread_host_vpid(thread);
                 }
         }

diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index 0b43b5fcfa..c2c9c092c4 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -510,7 +510,7 @@ int __cobalt_kill(struct cobalt_thread *thread, int sig=
, int group) /* nklocked,
                         sigp->si.si_signo =3D sig;
                         sigp->si.si_errno =3D 0;
                         sigp->si.si_code =3D SI_USER;
-                       sigp->si.si_pid =3D task_pid_nr(current);
+                       sigp->si.si_pid =3D task_pid_vnr(current);
                         sigp->si.si_uid =3D get_current_uuid();
                         if (cobalt_signal_send(thread, sigp, group) <=3D 0=
)
                                 cobalt_signal_free(sigp);
@@ -525,8 +525,9 @@ int __cobalt_kill(struct cobalt_thread *thread, int sig=
, int group) /* nklocked,
         return ret;
 }

-COBALT_SYSCALL(kill, conforming, (pid_t pid, int sig))
+COBALT_SYSCALL(kill, conforming, (pid_t vpid, int sig))
 {
+       pid_t pid =3D cobalt_vpid2pid_nr(vpid);
         struct cobalt_thread *thread;
         int ret;
         spl_t s;
@@ -544,8 +545,9 @@ COBALT_SYSCALL(kill, conforming, (pid_t pid, int sig))
         return ret;
 }

-int __cobalt_sigqueue(pid_t pid, int sig, const union sigval *value)
+int __cobalt_sigqueue(pid_t vpid, int sig, const union sigval *value)
 {
+       pid_t pid =3D cobalt_vpid2pid_nr(vpid);
         struct cobalt_sigpending *sigp;
         struct cobalt_thread *thread;
         int ret =3D 0;
@@ -569,7 +571,7 @@ int __cobalt_sigqueue(pid_t pid, int sig, const union s=
igval *value)
                         sigp->si.si_signo =3D sig;
                         sigp->si.si_errno =3D 0;
                         sigp->si.si_code =3D SI_QUEUE;
-                       sigp->si.si_pid =3D task_pid_nr(current);
+                       sigp->si.si_pid =3D task_pid_vnr(current);
                         sigp->si.si_uid =3D get_current_uuid();
                         sigp->si.si_value =3D *value;
                         if (cobalt_signal_send(thread, sigp, 1) <=3D 0)
diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index cdeb66d4f3..6a79fecb5c 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -176,11 +176,11 @@ struct cobalt_thread *cobalt_thread_find(pid_t pid) /=
* nklocked, IRQs off */
 }
 EXPORT_SYMBOL_GPL(cobalt_thread_find);

-struct cobalt_thread *cobalt_thread_find_local(pid_t pid) /* nklocked, IRQ=
s off */
+struct cobalt_thread *cobalt_thread_find_local(pid_t vpid) /* nklocked, IR=
Qs off */
 {
         struct cobalt_thread *thread;

-       thread =3D cobalt_thread_find(pid);
+       thread =3D cobalt_thread_find(cobalt_vpid2pid_nr(vpid));
         if (thread =3D=3D NULL || thread->hkey.mm !=3D current->mm)
                 return NULL;

@@ -624,7 +624,7 @@ int __cobalt_thread_create(unsigned long pth, int polic=
y,
                 return ret;
         }

-       if (!thread_hash(&hkey, thread, task_pid_vnr(p))) {
+       if (!thread_hash(&hkey, thread, task_pid_nr(p))) {
                 ret =3D -EAGAIN;
                 goto fail;
         }
@@ -682,7 +682,7 @@ cobalt_thread_shadow(struct cobalt_local_hkey *hkey,
                 return ERR_PTR(ret);
         }

-       if (!thread_hash(hkey, thread, task_pid_vnr(current))) {
+       if (!thread_hash(hkey, thread, task_pid_nr(current))) {
                 ret =3D -EAGAIN;
                 goto fail;
         }
@@ -819,7 +819,7 @@ COBALT_SYSCALL(thread_getpid, current, (unsigned long p=
th))
         if (thread =3D=3D NULL)
                 pid =3D -ESRCH;
         else
-               pid =3D xnthread_host_pid(&thread->threadbase);
+               pid =3D xnthread_host_vpid(&thread->threadbase);

         xnlock_put_irqrestore(&nklock, s);

@@ -827,7 +827,7 @@ COBALT_SYSCALL(thread_getpid, current, (unsigned long p=
th))
 }

 COBALT_SYSCALL(thread_getstat, current,
-              (pid_t pid, struct cobalt_threadstat __user *u_stat))
+              (pid_t vpid, struct cobalt_threadstat __user *u_stat))
 {
         struct cobalt_threadstat stat;
         struct cobalt_thread *p;
@@ -835,14 +835,16 @@ COBALT_SYSCALL(thread_getstat, current,
         xnticks_t xtime;
         spl_t s;

-       trace_cobalt_pthread_stat(pid);
+       trace_cobalt_pthread_stat(vpid);

-       if (pid =3D=3D 0) {
+       if (vpid =3D=3D 0) {
                 thread =3D xnthread_current();
                 if (thread =3D=3D NULL)
                         return -EPERM;
                 xnlock_get_irqsave(&nklock, s);
         } else {
+               pid_t pid =3D cobalt_vpid2pid_nr(vpid);
+
                 xnlock_get_irqsave(&nklock, s);
                 p =3D cobalt_thread_find(pid);
                 if (p =3D=3D NULL) {
diff --git a/kernel/cobalt/posix/thread.h b/kernel/cobalt/posix/thread.h
index 51be372a7a..66e3a88223 100644
--- a/kernel/cobalt/posix/thread.h
+++ b/kernel/cobalt/posix/thread.h
@@ -146,7 +146,7 @@ int cobalt_thread_setschedprio(unsigned long pth,

 struct cobalt_thread *cobalt_thread_find(pid_t pid);

-struct cobalt_thread *cobalt_thread_find_local(pid_t pid);
+struct cobalt_thread *cobalt_thread_find_local(pid_t vpid);

 struct cobalt_thread *cobalt_thread_lookup(unsigned long pth);

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 2c1ec6d3a4..9a97213fbe 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -388,6 +388,16 @@ pid_t xnthread_host_pid(struct xnthread *thread)
         return task_pid_nr(xnthread_host_task(thread));
 }

+pid_t xnthread_host_vpid(struct xnthread *thread)
+{
+       if (xnthread_test_state(thread, XNROOT))
+               return 0;
+       if (!xnthread_host_task(thread))
+               return -1;
+
+       return task_pid_vnr(xnthread_host_task(thread));
+}
+
 int xnthread_set_clock(struct xnthread *thread, struct xnclock *newclock)
 {
         spl_t s;
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobal=
t-posix.h
index 3df9295541..d994007bba 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -252,7 +252,7 @@ DECLARE_EVENT_CLASS(cobalt_posix_scheduler,
                 memcpy(__get_dynamic_array(param_ex), param_ex, sizeof(*pa=
ram_ex));
         ),

-       TP_printk("pid=3D%d policy=3D%s param=3D{ %s }",
+       TP_printk("vpid=3D%d policy=3D%s param=3D{ %s }",
                   __entry->pid,
                   cobalt_print_sched_policy(__entry->policy),
                   __parse_sched_params(__entry->policy,
@@ -369,7 +369,7 @@ DECLARE_EVENT_CLASS(cobalt_posix_pid,
         TP_fast_assign(
                 __entry->pid =3D pid;
         ),
-       TP_printk("pid=3D%d", __entry->pid)
+       TP_printk("vpid=3D%d", __entry->pid)
 );

 DEFINE_EVENT(cobalt_posix_pid, cobalt_pthread_stat,
--
2.31.1
