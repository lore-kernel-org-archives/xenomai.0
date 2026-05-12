Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074836F8E9
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570244; cv=none; b=kG9C4YkOHE7BgIW8sZV14mMSRNiqhSkOCafRM59/4AKfNu5InMeY5Ng2GzUWMw0dYWI5YhK0+0l+D/l3dD/1DGJ26LUhsaPHTL+mfpsQTgZWiaFTUUmBcXIRReZJA2zCw4HebITbjUap/Sm/pua6qigjIH+S3fSyQd/TTFu9dmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570244; c=relaxed/simple;
	bh=TpCvRM+63Y9d0tqzhwh6xA/MAozHRk5YzvrUvj7TV9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqab6RPuJG4NG+VfNrK4KG2NtNpQ2IF+uMaMp66lyBUd7QBF0W8TdjcNJprRSIbNW0ufEZhFQrJhKmF3cFWJgfqosQdwFdpRU8PpxJ+2Cbue26lMOL4cIZh1APf4uQwqIlSh2bpE1HMsoR7MtTvFBOE7JcwkcCrYdghg34lHEkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 56E6A298580
	for <xenomai@lists.linux.dev>; Tue, 12 May 2026 09:17:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id j9NVLJqiiyZ1; Tue, 12 May 2026 09:17:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7E62D298599;
	Tue, 12 May 2026 09:17:09 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nTp_VOWgfFGu; Tue, 12 May 2026 09:17:09 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 4B42F298580;
	Tue, 12 May 2026 09:17:09 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH] [RFC] Add test to detect spurious suspend wakeups
Date: Tue, 12 May 2026 09:17:03 +0200
Message-ID: <20260512071703.2830843-1-richard@nod.at>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <411e79a0-cabf-4d86-bed0-12e0b9546c1f@siemens.com>
References: <411e79a0-cabf-4d86-bed0-12e0b9546c1f@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a task is suspend and SIGSHADOW is used to harden it,
it can happen that the target task itself harends (e.g. by using
a syscall). Then the already hardened and suspended task will see
SIGSHADOW and resumes.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 configure.ac                                  |   1 +
 testsuite/smokey/Makefile.am                  |   3 +
 .../smokey/spurious-suspend-wake/Makefile.am  |  10 +
 .../spurious-suspend-wake.c                   | 238 ++++++++++++++++++
 4 files changed, 252 insertions(+)
 create mode 100644 testsuite/smokey/spurious-suspend-wake/Makefile.am
 create mode 100644 testsuite/smokey/spurious-suspend-wake/spurious-suspe=
nd-wake.c

diff --git a/configure.ac b/configure.ac
index 0d6dd87b6..69d9947fd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1086,6 +1086,7 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/bufp/Makefile \
 	testsuite/smokey/sigdebug/Makefile \
 	testsuite/smokey/timerfd/Makefile \
+	testsuite/smokey/spurious-suspend-wake/Makefile \
 	testsuite/smokey/tsc/Makefile \
 	testsuite/smokey/leaks/Makefile \
 	testsuite/smokey/memcheck/Makefile \
diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index c49a5d77f..f3c1151b6 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -37,6 +37,7 @@ COBALT_SUBDIRS =3D 	\
 	setsched	\
 	sigdebug	\
 	timerfd		\
+	spurious-suspend-wake \
 	tsc		\
 	xddp		\
 	y2038		\
@@ -82,6 +83,7 @@ DIST_SUBDIRS =3D 		\
 	setsched	\
 	sigdebug	\
 	timerfd		\
+	spurious-suspend-wake \
 	tsc		\
 	xddp		\
 	y2038		\
@@ -130,6 +132,7 @@ smokey_LDADD =3D 					\
 	$(plugin_list)				\
 	../../lib/smokey/libsmokey@CORE@.la		\
 	../../lib/copperplate/libcopperplate@CORE@.la	\
+	../../lib/alchemy/libalchemy@CORE@.la \
 	@XENO_CORE_LDADD@			\
 	 @XENO_USER_LDADD@			\
 	-lpthread -lrt
diff --git a/testsuite/smokey/spurious-suspend-wake/Makefile.am b/testsui=
te/smokey/spurious-suspend-wake/Makefile.am
new file mode 100644
index 000000000..b2f4f3b6c
--- /dev/null
+++ b/testsuite/smokey/spurious-suspend-wake/Makefile.am
@@ -0,0 +1,10 @@
+noinst_LIBRARIES =3D libspurious-suspend-wake.a
+
+libspurious_suspend_wake_a_SOURCES =3D spurious-suspend-wake.c
+
+CCLD =3D $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+libspurious_suspend_wake_a_CPPFLAGS =3D   \
+        @XENO_USER_CFLAGS@              \
+        -I$(top_srcdir)/include
+
diff --git a/testsuite/smokey/spurious-suspend-wake/spurious-suspend-wake=
.c b/testsuite/smokey/spurious-suspend-wake/spurious-suspend-wake.c
new file mode 100644
index 000000000..969bd5344
--- /dev/null
+++ b/testsuite/smokey/spurious-suspend-wake/spurious-suspend-wake.c
@@ -0,0 +1,238 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <sched.h>
+#include <sys/types.h>
+#include <sys/syscall.h>
+#include <smokey/smokey.h>
+#include <alchemy/task.h>
+
+smokey_test_plugin(spurious_suspend_wake,
+		   SMOKEY_ARGLIST(
+			   SMOKEY_INT(iters),
+			   SMOKEY_INT(settle_us),
+			   SMOKEY_INT(quiet_us),
+			   SMOKEY_INT(victim_cpu),
+			   SMOKEY_INT(suspender_cpu),
+		   ),
+		   "Detect SIGSHADOW vs xnthread_suspend race that "
+		   "spuriously resumes an rt_task_suspend()'d task.");
+
+static volatile unsigned long victim_counter;
+static volatile bool stop;
+static RT_TASK victim_task;
+static RT_TASK suspender_task;
+
+static int iters		=3D 5000;
+static int settle_us		=3D 100;
+static int quiet_us		=3D 200;
+static int victim_cpu		=3D 0;
+static int suspender_cpu	=3D 1;
+
+static unsigned int spurious;
+static unsigned long max_delta;
+static int cycles_done;
+
+static void victim_body(void *arg)
+{
+	(void)arg;
+
+	/*
+	 * Tight relax/harden bouncing:
+	 *  - syscall(getpid) is a raw Linux syscall, sets XNRELAX on
+	 *    return, leaving us in secondary mode.
+	 *  - rt_task_sleep() resolves via libcobalt as a primary-mode
+	 *    syscall, so the wrapper runs xnthread_harden() before the
+	 *    sleep proper. On return we are back in primary mode.
+	 *
+	 * The window between the two is when the deferred SIGSHADOW
+	 * HARDEN posted by a concurrent rt_task_suspend() can land on a
+	 * non-XNRELAX victim and trigger the spurious wake.
+	 */
+	while (!stop) {
+		syscall(__NR_getpid);
+		rt_task_sleep(1000);	/* 1us, also forces a harden */
+		__atomic_add_fetch(&victim_counter, 1, __ATOMIC_RELAXED);
+	}
+}
+
+static void suspender_body(void *arg)
+{
+	int i, ret;
+
+	(void)arg;
+
+	for (i =3D 0; i < iters && !stop; i++) {
+		unsigned long c1, c2, delta;
+
+		ret =3D rt_task_suspend(&victim_task);
+		if (ret) {
+			smokey_warning("rt_task_suspend at iter %d: %s",
+				       i, symerror(ret));
+			break;
+		}
+
+		/*
+		 * Let SIGSHADOW HARDEN actually fire so the victim
+		 * either properly blocks on XNSUSP or, if the race
+		 * fired, has already been spuriously resumed.
+		 */
+		rt_task_sleep((RTIME)settle_us * 1000);
+
+		c1 =3D __atomic_load_n(&victim_counter, __ATOMIC_RELAXED);
+
+		/* Quiet window: victim must NOT advance. */
+		rt_task_sleep((RTIME)quiet_us * 1000);
+
+		c2 =3D __atomic_load_n(&victim_counter, __ATOMIC_RELAXED);
+
+		ret =3D rt_task_resume(&victim_task);
+		if (ret) {
+			smokey_warning("rt_task_resume at iter %d: %s",
+				       i, symerror(ret));
+			break;
+		}
+
+		delta =3D c2 - c1;
+		if (delta !=3D 0) {
+			spurious++;
+			if (delta > max_delta)
+				max_delta =3D delta;
+			if (spurious <=3D 5)
+				smokey_trace("iter %d: victim advanced by "
+					     "%lu in quiet window", i, delta);
+		}
+
+		/* Let the victim accumulate forward progress between
+		 * cycles, otherwise we hammer it continuously and can no
+		 * longer tell forward progress from wake. */
+		rt_task_sleep((RTIME)quiet_us * 1000);
+	}
+
+	cycles_done =3D i;
+}
+
+static int run_spurious_suspend_wake(struct smokey_test *t, int argc,
+				     char *const argv[])
+{
+	cpu_set_t set;
+	int ret, ncpu;
+
+	smokey_parse_args(t, argc, argv);
+	if (SMOKEY_ARG_ISSET(spurious_suspend_wake, iters))
+		iters =3D SMOKEY_ARG_INT(spurious_suspend_wake, iters);
+	if (SMOKEY_ARG_ISSET(spurious_suspend_wake, settle_us))
+		settle_us =3D SMOKEY_ARG_INT(spurious_suspend_wake, settle_us);
+	if (SMOKEY_ARG_ISSET(spurious_suspend_wake, quiet_us))
+		quiet_us =3D SMOKEY_ARG_INT(spurious_suspend_wake, quiet_us);
+	if (SMOKEY_ARG_ISSET(spurious_suspend_wake, victim_cpu))
+		victim_cpu =3D SMOKEY_ARG_INT(spurious_suspend_wake, victim_cpu);
+	if (SMOKEY_ARG_ISSET(spurious_suspend_wake, suspender_cpu))
+		suspender_cpu =3D SMOKEY_ARG_INT(spurious_suspend_wake,
+					       suspender_cpu);
+
+	ncpu =3D sysconf(_SC_NPROCESSORS_ONLN);
+	if (ncpu < 2) {
+		smokey_note("need >=3D 2 online CPUs to drive the race");
+		return -ENOSYS;
+	}
+	if (victim_cpu < 0 || suspender_cpu < 0 ||
+	    victim_cpu >=3D ncpu || suspender_cpu >=3D ncpu ||
+	    victim_cpu =3D=3D suspender_cpu) {
+		smokey_warning("victim_cpu and suspender_cpu must be "
+			       "distinct values in [0, %d)", ncpu);
+		return -EINVAL;
+	}
+	if (iters <=3D 0 || settle_us <=3D 0 || quiet_us <=3D 0) {
+		smokey_warning("iters, settle_us, quiet_us must be positive");
+		return -EINVAL;
+	}
+
+	stop =3D false;
+	victim_counter =3D 0;
+	spurious =3D 0;
+	max_delta =3D 0;
+	cycles_done =3D 0;
+
+	ret =3D rt_task_create(&victim_task, "ssw-victim", 0, 50, T_JOINABLE);
+	if (ret) {
+		smokey_warning("rt_task_create(victim): %s", symerror(ret));
+		return ret;
+	}
+
+	CPU_ZERO(&set);
+	CPU_SET(victim_cpu, &set);
+	ret =3D rt_task_set_affinity(&victim_task, &set);
+	if (ret) {
+		smokey_warning("rt_task_set_affinity(victim, %d): %s",
+			       victim_cpu, symerror(ret));
+		goto fail_after_victim_create;
+	}
+
+	ret =3D rt_task_create(&suspender_task, "ssw-suspender", 0, 50,
+			     T_JOINABLE);
+	if (ret) {
+		smokey_warning("rt_task_create(suspender): %s", symerror(ret));
+		goto fail_after_victim_create;
+	}
+
+	CPU_ZERO(&set);
+	CPU_SET(suspender_cpu, &set);
+	ret =3D rt_task_set_affinity(&suspender_task, &set);
+	if (ret) {
+		smokey_warning("rt_task_set_affinity(suspender, %d): %s",
+			       suspender_cpu, symerror(ret));
+		goto fail_after_suspender_create;
+	}
+
+	ret =3D rt_task_start(&victim_task, victim_body, NULL);
+	if (ret) {
+		smokey_warning("rt_task_start(victim): %s", symerror(ret));
+		goto fail_after_suspender_create;
+	}
+
+	smokey_trace("victim on CPU%d, suspender on CPU%d, %d iters, "
+		     "settle=3D%dus, quiet=3D%dus",
+		     victim_cpu, suspender_cpu, iters, settle_us, quiet_us);
+
+	ret =3D rt_task_start(&suspender_task, suspender_body, NULL);
+	if (ret) {
+		smokey_warning("rt_task_start(suspender): %s", symerror(ret));
+		stop =3D true;
+		rt_task_join(&victim_task);
+		goto fail_after_suspender_create;
+	}
+
+	rt_task_join(&suspender_task);
+
+	stop =3D true;
+	/*
+	 * Belt and braces: the suspender may have left the victim
+	 * suspended if it broke out early. rt_task_resume is a no-op on
+	 * a non-suspended task, so this is always safe.
+	 */
+	rt_task_resume(&victim_task);
+	rt_task_join(&victim_task);
+
+	rt_task_delete(&suspender_task);
+	rt_task_delete(&victim_task);
+
+	if (spurious) {
+		smokey_warning("FAIL: %u/%d cycles saw the victim advance "
+			       "during the quiet window (max delta %lu)",
+			       spurious, cycles_done, max_delta);
+		return -EPROTO;
+	}
+
+	smokey_trace("no spurious wakes in %d cycles", cycles_done);
+	return 0;
+
+fail_after_suspender_create:
+	rt_task_delete(&suspender_task);
+fail_after_victim_create:
+	rt_task_delete(&victim_task);
+	return ret;
+}
--=20
2.51.0

