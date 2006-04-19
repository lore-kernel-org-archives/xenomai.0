Message-ID: <4446B348.10403@domain.hid>
Date: Thu, 20 Apr 2006 00:01:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3E057F477621AFD0B0351956"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC] shadow threads with prio 0 / SCHED_NORMAL
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
--------------enig3E057F477621AFD0B0351956
Content-Type: multipart/mixed; boundary="------------020004090704030003090504"

This is a multi-part message in MIME format.
--------------020004090704030003090504
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

this is an experimental hack to open the non-rt priority levels of Linux
to Xenomai shadow threads, i.e. allow shadows to be scheduled under
SCHED_NORMAL when in secondary mode. The scenario are typical borderline
threads between RT and non-RT: they share a critical code path with RT
threads, maybe mutex protected, but they are mostly time-sharing threads
which do not need SCHED_FIFO for this.

The patch (be careful, quick-hack!) addresses the prio level 0 in the
ipipe patch, the nucleus/shadow subsystem, and the native skin. A quick
test with the attached demo showed the expected behaviour so far: no
lock-up during busy-waiting in secondary mode, prio-boost when holding
the lock (visible via /proc/xenomai/sched), no obvious side effects.

Any comments? Does this break other things in a subtle way?

Jan

--------------020004090704030003090504
Content-Type: text/plain;
 name="ipipe-prio0.hack"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ipipe-prio0.hack"

Index: linux-2.6.15.3/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15.3.orig/kernel/sched.c	2006-04-19 11:07:51.000000000 +020=
0
+++ linux-2.6.15.3/kernel/sched.c	2006-04-19 23:14:43.000000000 +0200
@@ -5779,7 +5779,7 @@ int ipipe_setscheduler_root (struct task
 	runqueue_t *rq;
 	int oldprio;
=20
-	if (prio < 1 || prio > MAX_RT_PRIO-1)
+	if (prio < 0 || prio > MAX_RT_PRIO-1)
 		return -EINVAL;
=20
 	rq =3D task_rq_lock(p, &flags);

--------------020004090704030003090504
Content-Type: text/plain;
 name="xeno-prio0.hack"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xeno-prio0.hack"

Index: include/nucleus/core.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/core.h	(Revision 956)
+++ include/nucleus/core.h	(Arbeitskopie)
@@ -38,7 +38,7 @@
 #define XNCORE_NR_PRIO      (XNCORE_MAX_PRIO - XNCORE_MIN_PRIO + 2)
=20
 /* Priority sub-range used by core APIs. */
-#define XNCORE_LOW_PRIO     1
+#define XNCORE_LOW_PRIO     0
 #define XNCORE_HIGH_PRIO    99
=20
 /* Priority of IRQ servers in user-space. */
Index: src/skins/native/task.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/native/task.c	(Revision 956)
+++ src/skins/native/task.c	(Arbeitskopie)
@@ -56,8 +56,10 @@ static void *rt_task_trampoline (void *c
     long err;
=20
     /* Ok, this looks like weird, but we need this. */
-    param.sched_priority =3D sched_get_priority_max(SCHED_FIFO);
-    pthread_setschedparam(pthread_self(),SCHED_FIFO,&param);
+    if (iargs->prio > 0) {
+	param.sched_priority =3D sched_get_priority_max(SCHED_FIFO);
+	pthread_setschedparam(pthread_self(),SCHED_FIFO,&param);
+    }
=20
     /* rt_task_delete requires asynchronous cancellation */
     pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
@@ -132,8 +134,10 @@ int rt_task_create (RT_TASK *task,
     pthread_attr_setstacksize(&thattr,stksize);
     if (!(mode & T_JOINABLE))
 	pthread_attr_setdetachstate(&thattr,PTHREAD_CREATE_DETACHED);
-    pthread_attr_setschedpolicy(&thattr,SCHED_FIFO);
-    param.sched_priority =3D sched_get_priority_max(SCHED_FIFO);
+    if (prio > 0) {
+	pthread_attr_setschedpolicy(&thattr,SCHED_FIFO);
+	param.sched_priority =3D sched_get_priority_max(SCHED_FIFO);
+    }
     pthread_attr_setschedparam(&thattr,&param);
=20
     err =3D pthread_create(&thid,&thattr,&rt_task_trampoline,&iargs);
Index: ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/shadow.c	(Revision 956)
+++ ksrc/nucleus/shadow.c	(Arbeitskopie)
@@ -120,7 +120,7 @@ static inline void request_syscall_resta
 static inline void set_linux_task_priority (struct task_struct *p, int p=
rio)
=20
 {
-    if (rthal_setsched_root(p,SCHED_FIFO,prio) < 0)
+    if (rthal_setsched_root(p,prio ? SCHED_FIFO : SCHED_NORMAL,prio) < 0=
)
 	printk(KERN_WARNING "Xenomai: invalid Linux priority level: %d, task=3D=
%s\n",prio,p->comm);
 }
=20
@@ -577,7 +577,7 @@ void xnshadow_relax (int notify)
 		    xnthread_user_pid(thread));
 #endif /* CONFIG_XENO_OPT_DEBUG */
     cprio =3D thread->cprio < MAX_RT_PRIO ? thread->cprio : MAX_RT_PRIO-=
1;
-    rthal_reenter_root(get_switch_lock_owner(),SCHED_FIFO,cprio ?: 1);
+    rthal_reenter_root(get_switch_lock_owner(),cprio ? SCHED_FIFO : SCHE=
D_NORMAL,cprio);
=20
     xnthread_inc_ssw(thread);	/* Account for secondary mode switch. */
=20
@@ -671,11 +671,13 @@ static int xnshadow_wait_completion (xnc
 void xnshadow_exit (void)
=20
 {
-    rthal_reenter_root(get_switch_lock_owner(),SCHED_FIFO,current->rt_pr=
iority);
+    rthal_reenter_root(get_switch_lock_owner(),
+                       current->rt_priority ? SCHED_FIFO : SCHED_NORMAL,=

+                       current->rt_priority);
     do_exit(0);
 }
=20
-/*!=20
+/*!
  * \fn int xnshadow_map(xnthread_t *thread, xncompletion_t __user *u_com=
pletion)
  * @internal
  * \brief Create a shadow thread context.
@@ -762,7 +764,7 @@ int xnshadow_map (xnthread_t *thread,
=20
     xnarch_init_shadow_tcb(xnthread_archtcb(thread),thread,xnthread_name=
(thread));
     prio =3D xnthread_base_priority(thread) < MAX_RT_PRIO ? xnthread_bas=
e_priority(thread) : MAX_RT_PRIO-1;
-    set_linux_task_priority(current,prio ?: 1);
+    set_linux_task_priority(current,prio);
     xnshadow_thrptd(current) =3D thread;
     xnpod_suspend_thread(thread,XNRELAX,XN_INFINITE,NULL);
=20
@@ -919,7 +921,7 @@ void xnshadow_renice (xnthread_t *thread
        range, since the core pod's priority scale is a superset of
        Linux's priority scale. */
     int prio =3D thread->cprio < MAX_RT_PRIO ? thread->cprio : MAX_RT_PR=
IO-1;
-    schedule_linux_call(LO_RENICE_REQ,p,prio ?: 1);
+    schedule_linux_call(LO_RENICE_REQ,p,prio);
 }
=20
 void xnshadow_suspend (xnthread_t *thread)

--------------020004090704030003090504
Content-Type: text/plain;
 name="demo-prio0.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="demo-prio0.c"

#include <native/task.h>
#include <native/mutex.h>
#include <native/timer.h>
#include <stdio.h>
#include <sys/mman.h>

RT_TASK task1, task2;
RT_MUTEX mutex;

void spin(long long time)
{
    long long timeout =3D rt_timer_read() + time;

    while (rt_timer_read() < timeout);
}

void func1(void *arg)
{
    printf("switching to secondary\n");

    spin(3000000000LL);

    printf("back to primary\n");

    rt_mutex_lock(&mutex, TM_INFINITE);
    rt_task_sleep(3000000000LL);
    spin(1000000000LL);

    rt_mutex_unlock(&mutex);

    printf("done with primary\n");

    sleep(3);

    spin(3000000000LL);
}

void func2(void *arg)
{
    rt_task_sleep(3500000000LL);
    rt_mutex_lock(&mutex, TM_INFINITE);
    rt_mutex_unlock(&mutex);
}

int main()
{
    mlockall(MCL_CURRENT|MCL_FUTURE);

    rt_mutex_create(&mutex, NULL);

    spin(3000000000LL);

    printf("rt_task_spawn(task1) =3D %d\n",
           rt_task_spawn(&task1, "mytask", 0, 0, T_JOINABLE, func1, NULL)=
);
    printf("rt_task_spawn(task2) =3D %d\n",
           rt_task_spawn(&task2, "mytask2", 0, 10, T_JOINABLE, func2, NUL=
L));

    rt_task_join(&task1);
    rt_task_join(&task2);
    return 0;
}

--------------020004090704030003090504--

--------------enig3E057F477621AFD0B0351956
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERrNIniDOoMHTA+kRAlq/AJ9M0/XP9tSbNMkqFuCf7sztKlm2lwCggn5n
2pIHCDtS4PuUKF16x+ewm6I=
=pg0Y
-----END PGP SIGNATURE-----

--------------enig3E057F477621AFD0B0351956--

