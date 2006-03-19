Message-ID: <441DD89A.4000501@domain.hid>
Date: Sun, 19 Mar 2006 23:18:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070504030401090904010202"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] yet another test tool
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

This is a multi-part message in MIME format.
--------------070504030401090904010202
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Hi,

as I already mentioned, I experimented with the cyclictest-0.5 by Thomas
Gleixner (http://www.tglx.de/projects/misc/cyclictest), one of the
PREEMPT_RT developers. The attached patch fixes the scheduling policy
setup and locks the whole test into memory.

This tool is quite handy for running more than one timed thread, and for
basic testing of the POSIX skin. As Xenomai does not support hard-RT
signal delivery yet, the only relevant mode is -n, i.e. delaying via
clock_nanosleep. From the bugs I fixed I would say that not every
feature may work yet, but running with -n, -p 99 (highest priority
used), and -t 10 (create e.g. 10 cascading threads) looks fine to me.

What do you think, is it worth including as a POSIX counterpart for
testsuite/latency?

Jan

--------------070504030401090904010202
Content-Type: text/plain;
 name="cyclic.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="cyclic.patch"

--- cyclictest.c.orig	2005-11-24 13:33:21.000000000 +0100
+++ cyclictest.c	2006-03-17 10:50:26.000000000 +0100
@@ -24,12 +24,14 @@
 #include <string.h>
 #include <time.h>
 #include <unistd.h>
+#include <limits.h>
=20
 #include <linux/unistd.h>
=20
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/time.h>
+#include <sys/mman.h>
=20
 /* Ugly, but .... */
 #define gettid() syscall(__NR_gettid)
@@ -158,7 +160,7 @@ void *timerthread(void *param)
=20
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority =3D par->prio;
-	sched_setscheduler(0, policy, &schedp);
+	pthread_setschedparam(pthread_self(), policy, &schedp);
=20
 	/* Get current time */
 	clock_gettime(par->clock, &now);
@@ -265,7 +267,7 @@ out:	=09
=20
 	/* switch to normal */
 	schedp.sched_priority =3D 0;
-	sched_setscheduler(0, SCHED_OTHER, &schedp);=09
+	pthread_setschedparam(pthread_self(), SCHED_OTHER, &schedp);
=20
 	stat->threadstarted =3D -1;
=20
@@ -396,6 +398,7 @@ int main(int argc, char **argv)
 	int mode;
 	struct thread_param *par;
 	struct thread_stat *stat;
+	pthread_attr_t thattr;
 	int i, ret =3D -1;
=20
 	if (geteuid()) {
@@ -403,6 +406,8 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
=20
+	mlockall(MCL_CURRENT | MCL_FUTURE);
+
 	process_options(argc, argv);
=20
 	mode =3D use_nanosleep + use_system;
@@ -442,7 +447,9 @@ int main(int argc, char **argv)
 		par[i].stats =3D &stat[i];
 		stat[i].min =3D 1000000;
 		stat[i].max =3D -1000000;
-		pthread_create(&stat[i].thread, NULL, timerthread, &par[i]);
+		pthread_attr_init(&thattr);
+		pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
+		pthread_create(&stat[i].thread, &thattr, timerthread, &par[i]);
 		stat[i].threadstarted =3D 1;
 	}
 =09

--------------070504030401090904010202--

