Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9282030EF63
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432244; cv=none; b=GFwUlHynNClzFTqkdGuXfA2ftp0hltyFX3l+ItpWd3UiqL98IUUI11IVuyGQfgPbcWbaWt6vA9aD8RVJP6v9QMcaVTaFN+SJtlQq++rIkwmpdTsPN12ehuTySyhMQsEwVlZDd6xkBjDH4wcelMVxb1wcNDSVJLeVLsRXhckc3eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432244; c=relaxed/simple;
	bh=iLNMl+NjH0ktd8GrwRVZtRtE9gAftK9frcB9S9m2Nv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+ThA7453uII9iBxWXM22GR59SM4oTrRSOMO3/2dNvv124EBqjrB62UepeKAKM3QP41STohrGUWGyipXU7pYjfMqnBhZ5aAGX3uEJyYUUHQXnua+XaRi3it9iic3o1SD0Om8WaYXOXvjNmbjrYov+hZ9qu5yjxZ5ZnPNT44QHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 2C23B43E97
	for <xenomai@lists.linux.dev>; Mon, 26 Jan 2026 12:57:14 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	by spool.mail.gandi.net (Postfix) with ESMTPS id BE267460E06
	for <xenomai@xenomai.org>; Mon, 26 Jan 2026 13:57:13 +0100 (CET)
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of richard@nod.at designates 116.203.167.152 as permitted sender) smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id CB57E2C14A6;
	Mon, 26 Jan 2026 13:57:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id DZl2-E3R-zVK; Mon, 26 Jan 2026 13:57:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5C21D2ABFDE;
	Mon, 26 Jan 2026 13:57:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nY7GAwz8OSD5; Mon, 26 Jan 2026 13:57:12 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 1FE3F9B4E6;
	Mon, 26 Jan 2026 13:57:12 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: xenomai@xenomai.org
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH] Allow changing CPU affinity of RT kernel tasks
Date: Mon, 26 Jan 2026 13:57:01 +0100
Message-ID: <20260126125701.21000-1-richard@nod.at>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdhqredtredttdenucfhrhhomheptfhitghhrghrugcuhggvihhnsggvrhhgvghruceorhhitghhrghrugesnhhougdrrghtqeenucggtffrrghtthgvrhhnpeelfeevteekudffveefuedvhfdtgfeguddtgfffkeejhfefueduleehhfffhfdvleenucfkphepvddujedrjedtrddujeekrddvuddtpdekvddrudehtddrvddugedrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddutddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehrihgthhgrrhgusehnohgurdgrthdpqhhiugepvdevvdefueegfefgleejpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

Currently, calling sched_affinity() on an RT kernel task has no effect
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
is integrated into rtdm_task_should_stop(), so existing RT tasks utilize
it automatically.

RFC Discussion: Sending SIGSHADOW to a kernel task causes blocking
functions to return -EINTR. Currently, almost all RT kernel tasks treat
non-zero returns from functions like rtdm_event_wait() as fatal errors
and terminate. With this change, blocking functions that return -EINTR
require restarting (continuing the thread loop).

An alternative approach would be implementing restart logic in the rtdm_*
wrapper functions. If XNBREAK is set and it is a kernel task, the wrapper
could run rtdm_task_test_sigshadow() and restart the call internally
instead of returning -EINTR.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/cobalt/kernel/rtdm/driver.h | 17 +++++++++++++++++
 kernel/cobalt/thread.c              |  7 +++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/=
rtdm/driver.h
index 604d54b2b..d06e1126c 100644
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
@@ -1043,8 +1044,24 @@ static inline void rtdm_task_destroy(rtdm_task_t *=
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
+	if (signal_pending(current)) {
+		xnthread_relax(0, 0);
+		XENO_WARN_ON(COBALT, kernel_dequeue_signal() !=3D SIGSHADOW);
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
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 607f115a7..e9baf38e1 100644
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
@@ -2373,8 +2375,9 @@ void __xnthread_signal(struct xnthread *thread, int=
 sig, int arg)
 	struct lostage_signal *sigwork;
 	int slot;
=20
-	if (XENO_WARN_ON(COBALT, !xnthread_test_state(thread, XNUSER)))
-		return;
+	if (!xnthread_test_state(thread, XNUSER))
+		if (XENO_WARN_ON(COBALT, sig !=3D SIGSHADOW))
+			return;
=20
 	slot =3D get_slot_index_from_sig(sig, arg);
 	if (WARN_ON_ONCE(slot < 0))
--=20
2.51.0

