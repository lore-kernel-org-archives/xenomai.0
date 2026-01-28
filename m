Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE38352948
	for <xenomai@lists.linux.dev>; Wed, 28 Jan 2026 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599713; cv=none; b=dIhjWpLCnjnQslYkdf2/qGeSmbH4Wav/NBckDLvVSOFzeVa7VHWfeebNFBcJf7O7nlj7K2H407SuSGf59beNM6Y5pTOm3tk/D9X6ZOlTbLBUidheaG09lwxRiDjd1lOT4wDD9RhUZ4CeZCGhuuhcFutRAxPKilDKB7Ku7fdWHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599713; c=relaxed/simple;
	bh=j+5hnYnlct/gd0g7sJOf/VtkOCXjkP9atHuF260+dUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OiitVwLPmjvF6KfdMO70HIFGOfy6BNtMEddvCAG+46Jh9KQ/zx8veOy7eM4v/ssfXRTUqbHee1pbzhUkYI/czCsmb78ohSBqlCvDCMqdKCQsAobGHB5AshkWVwDUEOYhcriqak1wS4su9eCuxGIpgf8VAIi4hrCKOIpT35Qnopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 47369BE32E;
	Wed, 28 Jan 2026 12:28:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id XlKVbAvAEIuL; Wed, 28 Jan 2026 12:28:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6120FBE32C;
	Wed, 28 Jan 2026 12:28:27 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rjN6sjEBLnfC; Wed, 28 Jan 2026 12:28:27 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 2147ABE32A;
	Wed, 28 Jan 2026 12:28:27 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/5] Allow changing CPU affinity of RTDM tasks
Date: Wed, 28 Jan 2026 12:28:17 +0100
Message-ID: <20260128112821.1232-1-richard@nod.at>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, calling sched_affinity() on an RTDM task has no effect
on the Xenomai side, even though the shadow task reflects the desired
affinity. This discrepancy causes confusion because the failure is not
immediately visible.
A cryptic WARN_ON() triggers only when CONFIG_XENO_OPT_DEBUG_COBALT is
enabled.

This change addresses the issue by implementing an approach similar to
that used for userspace tasks: forcing a relaxation and hardening cycle
to apply the new affinity upon receiving SIGSHADOW.

A new helper, rtdm_task_test_sigshadow(), checks whether SIGSHADOW is
pending for the shadow task. If so, the signal is consumed, and a
relax/harden cycle is performed. This works because signal_pending()
only checks a flag and does not cause a domain switch. The new helper
is integrated into rtdm_task_should_stop(), so existing RTDM tasks utiliz=
e
it automatically.

Sending SIGSHADOW to a kernel task causes blocking functions to return
-EINTR. Currently, almost all RT kernel tasks treat
non-zero returns from functions like rtdm_event_wait() as fatal errors
and terminate. With this change, blocking functions that return -EINTR
require restarting (continuing the thread loop).

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/cobalt/kernel/rtdm/driver.h | 21 +++++++++++++++++++++
 kernel/cobalt/rtdm/drvlib.c         |  4 ++++
 kernel/cobalt/thread.c              | 10 ++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/=
rtdm/driver.h
index 604d54b2b..3fc5573cb 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -34,6 +34,7 @@
 #include <linux/cdev.h>
 #include <linux/wait.h>
 #include <linux/notifier.h>
+#include <linux/sched/signal.h>
 #include <pipeline/lock.h>
 #include <xenomai/version.h>
 #include <cobalt/kernel/heap.h>
@@ -1043,8 +1044,28 @@ static inline void rtdm_task_destroy(rtdm_task_t *=
task)
 	xnthread_join(task, true);
 }
=20
+static inline int __rtdm_task_should_stop(void)
+{
+	return xnthread_test_info(xnthread_current(), XNCANCELD);
+}
+
+static inline void rtdm_task_test_sigshadow(void)
+{
+	int sig;
+
+	if (signal_pending(current)) {
+		if (!xnthread_test_state(xnthread_current(), XNRELAX))
+			xnthread_relax(0, 0);
+		sig =3D kernel_dequeue_signal();
+		XENO_WARN_ON(COBALT, sig !=3D SIGSHADOW);
+		xnthread_harden();
+	}
+}
+
 static inline int rtdm_task_should_stop(void)
 {
+	rtdm_task_test_sigshadow();
+
 	return xnthread_test_info(xnthread_current(), XNCANCELD);
 }
=20
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 86788743f..08e113904 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -90,6 +90,10 @@ nanosecs_abs_t rtdm_clock_read_monotonic(void);
  * After initialising a task, the task handle remains valid and can be
  * passed to RTDM services until either rtdm_task_destroy() or
  * rtdm_task_join() was invoked.
+ * RTDM tasks are required to use rtdm_task_should_stop() in their threa=
d loop
+ * and must handle interrupted RTDM services, such as rtdm_event_wait().
+ * The -EINTR return code is not a fatal error. It should simply trigger=
 a
+ * continuation of the thread loop.
  *
  * @param[in,out] task Task handle
  * @param[in] name Optional task name
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 607f115a7..3f0ed98ef 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -204,6 +204,8 @@ static int kthread_trampoline(void *arg)
 		return ret;
 	}
=20
+	allow_signal(SIGSHADOW);
+
 	trace_cobalt_shadow_entry(thread);
=20
 	thread->entry(thread->cookie);
@@ -2373,8 +2375,12 @@ void __xnthread_signal(struct xnthread *thread, in=
t sig, int arg)
 	struct lostage_signal *sigwork;
 	int slot;
=20
-	if (XENO_WARN_ON(COBALT, !xnthread_test_state(thread, XNUSER)))
-		return;
+	if (!xnthread_test_state(thread, XNUSER)) {
+		if (sig !=3D SIGSHADOW) {
+			XENO_WARN(COBALT, 1, "unexpected signal: %i", sig);
+			return;
+		}
+	}
=20
 	slot =3D get_slot_index_from_sig(sig, arg);
 	if (WARN_ON_ONCE(slot < 0))
--=20
2.51.0

