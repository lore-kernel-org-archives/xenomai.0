From: Stelian Pop <stelian.pop@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 29 Sep 2006 15:53:28 +0200
Message-Id: <1159538008.15778.18.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] [PATCH] Clarify pthread_make_periodic_np() usage
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

Hi,

The attached patch makes the documentation of pthread_make_periodic_np()
explicit about the rescheduling which takes place on invocation, until
the start time has been reached.

I for one thought that pthread_make_periodic_np() would not sleep, and
that pthread_wait_np() would do the wait instead when invoked for the
first time...

Stelian.

Index: ksrc/skins/posix/thread.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/skins/posix/thread.c	(r=E9vision 1680)
+++ ksrc/skins/posix/thread.c	(copie de travail)
@@ -503,10 +503,12 @@
  *
  * This service is a non-portable extension of the POSIX interface.
  *
- * @param thread thread identifier;
+ * @param thread thread identifier. This thread is immediately delayed
+ * until the first periodic release point is reached.
  *
  * @param starttp start time, expressed as an absolute value of the
- * CLOCK_REALTIME clock;
+ * CLOCK_REALTIME clock. The affected thread will be delayed until
+ * this point is reached.
  *
  * @param periodtp period, expressed as a time interval.
  *
@@ -514,6 +516,8 @@
  * @return an error number if:
  * - ESRCH, @a thread is invalid;
  * - ETIMEDOUT, the start time has already passed.
+ *
+ * Rescheduling: always, until the @starttp start time has been reached.
  */
 int pthread_make_periodic_np(pthread_t thread,
 			     struct timespec *starttp,
=20
--=20
Stelian Pop <stelian.pop@domain.hid>


