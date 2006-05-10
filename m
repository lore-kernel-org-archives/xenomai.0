Message-ID: <44619D0B.1080402@domain.hid>
Date: Wed, 10 May 2006 09:58:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5FE0ACF3E1F0C662AD925C5D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [bug] zombie mutex owners
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
--------------enig5FE0ACF3E1F0C662AD925C5D
Content-Type: multipart/mixed; boundary="------------070704070506020903070402"

This is a multi-part message in MIME format.
--------------070704070506020903070402
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

running the attached test case for the native skin, you will get an ugly
lock-up on probably all Xenomai versions. Granted, this code is a bit
synthetic. I originally thought I could trigger the bug also via
timeouts when waiting on mutexes, but this scenario is safe (the timeout
is cleared before being able to cause harm).

What we see here is that task1 forwards the ownership of the mutex to
task2 on its first unlock invocation. Then we interrupt task2, making it
drop its wish to acquire the lock - but it already has it! Now weird
things happen on cleanup of task2 (likely also when trying to require
the lock via task1 beforehand).

The attached fix solves at least the crash but still gives an
unsatisfying result:

: fn      -158+  __rt_mutex_lock (hisyscall_event)
: fn      -156+  __copy_from_user_ll (__rt_mutex_lock)
: fn      -154+  xnregistry_fetch (__rt_mutex_lock)
:|fn      -151+  __ipipe_restore_pipeline_head (xnregistry_fetch)
: fn      -148+  rt_mutex_lock (__rt_mutex_lock)
:|fn      -144+  xnsynch_sleep_on (rt_mutex_lock)
:|fn      -134+  xnpod_resume_thread (xnsynch_sleep_on)
:|fn      -130+  xnpod_suspend_thread (xnsynch_sleep_on)
:|fn      -125+  xnpod_schedule (xnpod_suspend_thread)
:|fn      -116!  __switch_to (xnpod_schedule)
:|fn      -103+  rt_mutex_unlock (rt_mutex_lock)
:|fn      -100+  xnsynch_wakeup_one_sleeper (rt_mutex_unlock)
:|fn       -98+  xnpod_resume_thread (xnsynch_wakeup_one_sleeper)
:|fn       -95+  xnsynch_clear_boost (xnsynch_wakeup_one_sleeper)
:|fn       -89+  xnpod_schedule (rt_mutex_unlock)
:|fn       -85+  __switch_to (xnpod_schedule)
:|fn       -79!  __ipipe_restore_pipeline_head (rt_mutex_lock)

This means that task2 needs to be woken up in order to let task1
re-acquire the mutex. What would be more efficient for task1 is to
"steal" the granted lock again (that's what the preempt-rt people do in
their rtmutex code - and this is where I stumbled over our issues).

I haven't tried to construct test cases for other skins yet, but in
theory at least POSIX and RTDM should suffer from the same issue. This
raises the question if there might be some generic solution at nucleus
level for this, also improving the re-acquire path. But I have nothing
at hand so far.

Jan

--------------070704070506020903070402
Content-Type: text/x-patch;
 name="native-mutex-relock.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="native-mutex-relock.patch"

Index: ksrc/skins/native/mutex.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/native/mutex.c	(Revision 1058)
+++ ksrc/skins/native/mutex.c	(Arbeitskopie)
@@ -375,12 +375,17 @@ int rt_mutex_lock(RT_MUTEX *mutex, RTIME
=20
     xnsynch_sleep_on(&mutex->synch_base, timeout);
=20
-    if (xnthread_test_flags(&task->thread_base, XNRMID))
-        err =3D -EIDRM;           /* Mutex deleted while pending. */
-    else if (xnthread_test_flags(&task->thread_base, XNTIMEO))
-        err =3D -ETIMEDOUT;       /* Timeout. */
-    else if (xnthread_test_flags(&task->thread_base, XNBREAK))
-        err =3D -EINTR;           /* Unblocked. */
+    if (xnthread_test_flags(&task->thread_base, XNRMID | XNTIMEO | XNBRE=
AK)) {
+        if (xnthread_test_flags(&task->thread_base, XNRMID))
+            err =3D -EIDRM;           /* Mutex deleted while pending. */=

+        else if (xnthread_test_flags(&task->thread_base, XNTIMEO))
+            err =3D -ETIMEDOUT;       /* Timeout. */
+        else
+            err =3D -EINTR;           /* Unblocked. */
+
+        if (mutex->owner =3D=3D task)
+            rt_mutex_unlock(mutex);
+    }
=20
   unlock_and_exit:
=20

--------------070704070506020903070402
Content-Type: text/plain;
 name="mutex-relock.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="mutex-relock.c"

#include <stdio.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/mutex.h>
#include <native/timer.h>
#include <rtdm/rtbenchmark.h>

RT_TASK task1, task2;
RT_MUTEX mtx;
int fd;

void task1_fnc(void *arg)
{
        printf("started task1\n");
        rt_mutex_lock(&mtx, 0);
        rt_task_sleep(1000000000LL);
        rt_mutex_unlock(&mtx);

        rt_task_unblock(&task2);

        rt_mutex_lock(&mtx, 0);
        rt_dev_ioctl(fd, RTBNCH_RTIOC_REFREEZE_TRACE, 0);
        rt_dev_close(fd);
        rt_mutex_unlock(&mtx);
        printf("done task1\n");
}

void task2_fnc(void *arg)
{
        printf("started task2\n");
        if (rt_mutex_lock(&mtx, 0) < 0) {
                printf("lock failed in task2\n");
                return;
        }
        rt_mutex_unlock(&mtx);

        printf("done task2\n");
}

int main()
{
        mlockall(MCL_CURRENT | MCL_FUTURE);

        fd =3D rt_dev_open("rtbenchmark0", 0);
        rt_mutex_create(&mtx, NULL);

        rt_task_spawn(&task1, "task1", 0, 20, T_JOINABLE, task1_fnc, 0);
        rt_task_spawn(&task2, "task2", 0, 10, T_JOINABLE, task2_fnc, 0);

        rt_task_join(&task1);
        rt_task_join(&task2);

        rt_mutex_delete(&mtx);

        return 0;
}

--------------070704070506020903070402--

--------------enig5FE0ACF3E1F0C662AD925C5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEYZ0LniDOoMHTA+kRAsrdAJsGPx7b5qLs+/RtsnQUNU0kcR04WACfVnR/
b3+VewazX6eInHL35Ci6MD4=
=maln
-----END PGP SIGNATURE-----

--------------enig5FE0ACF3E1F0C662AD925C5D--

