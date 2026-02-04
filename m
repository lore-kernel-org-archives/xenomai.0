Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592192DFA4A
	for <xenomai@lists.linux.dev>; Wed,  4 Feb 2026 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228630; cv=none; b=MvJ2r4lVPiPIGFJMIRu3xuHZYvi+GPyy1eogGDOqm306JoU8DLsF+l/svL4D69JWPBvQ14SFoWG6/L6Nf1sHLYOjNIqbMUjynu7liMf8+TIpZ8IHzP6TjN3cNMILD2D6Qg02iHQQoHU3x+uD0X4lQp/E3/2QbCA3JWuAlX3dico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228630; c=relaxed/simple;
	bh=cWGmWG61jnn3t5k+ikgUG9OvTURe9lIV9yVbFuGNPnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/xMIouGzjLJIq/Ip1u3JmGW86KAxx8aP+Y1vNCB7swHW5gpkDdIGGxhHmTCP9HwEo/C4FrW+bGl5EJOd2QYFrNpsdcGGlbgagj4xzWYLnxQSruW15iz6BaSsmMICZJcvEZOO5KBTTbTRFQKf+1qb1F2P5SdK+R+f7HoAJ/bEX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=C9ffJC6E; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="C9ffJC6E"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260204181025fb85cea6bf000207be
        for <xenomai@lists.linux.dev>;
        Wed, 04 Feb 2026 19:10:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UGYMW/hyYh76MpXflJN7tumyu71J2PLa/uUsHni53sA=;
 b=C9ffJC6EJ+8QjZZbTncB59ISmn5SY3YoPFPyuOccTRrDQ/y3mCuJBhLmAGCJqy3tpcKWfV
 XjldwSHtGpkxytfH1bgGTvCae9Tq8FXg/Ecy/zmrZbewsSvosHG+viiZ3XdF/F0fBpplCFVQ
 Pnhq+51Mpy6O14Ir5494+nE980Jl2vPel6zqahzuYzecSc2ppeKeO0zjjUQ9m95mUOu9SElr
 UB29ErXS3oZt9C0aZjmE3/Pm+fleq9hBsXnMRBOwOgz9HATmE/AI2zWl5N6of7yuOZck1sSX
 0I2dXzs1qxStFONJjmj9S3jwB5syykCUZmP4nVm4npo41VpfU+LX/EVA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/3] cobalt/thread: Keep host task PID in xnthread struct as well
Date: Wed,  4 Feb 2026 19:10:22 +0100
Message-ID: <8ed0a0322f89c91f48bd217a81fa1c9cfa54d7ad.1770228624.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1770228624.git.jan.kiszka@siemens.com>
References: <cover.1770228624.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

This side-steps the logic of current xnthread_host_pid to check for
corner cases. Furthermore, it avoids the race on kernel thread shutdown
between the thread leaving its loop and freeing its task_struct on the
one side and xnthread_join trying to dereference the host task in order
to retrieve the PID (see also
https://lore.kernel.org/xenomai/20260127213927.26960-1-richard@nod.at).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/thread.h |  7 ++++++-
 kernel/cobalt/dovetail/sched.c |  2 ++
 kernel/cobalt/thread.c         | 11 +----------
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/cobalt/kernel/thread.h b/include/cobalt/kernel/thread.h
index 04fad0e491..5ff3e541d3 100644
--- a/include/cobalt/kernel/thread.h
+++ b/include/cobalt/kernel/thread.h
@@ -204,6 +204,8 @@ struct xnthread {
 	void (*entry)(void *cookie); /* Thread entry routine */
 	void *cookie;		/* Cookie to pass to the entry routine */
 
+	pid_t host_pid;		/* PID of host task (if any), or -1 */
+
 	/**
 	 * Thread data visible from userland through a window on the
 	 * global heap.
@@ -453,7 +455,10 @@ void xnthread_deregister(struct xnthread *thread);
 char *xnthread_format_status(unsigned long status,
 			     char *buf, int size);
 
-pid_t xnthread_host_pid(struct xnthread *thread);
+static inline pid_t xnthread_host_pid(struct xnthread *thread)
+{
+	return thread->host_pid;
+}
 
 int xnthread_set_clock(struct xnthread *thread,
 		       struct xnclock *newclock);
diff --git a/kernel/cobalt/dovetail/sched.c b/kernel/cobalt/dovetail/sched.c
index 01ea4422d1..241b1039db 100644
--- a/kernel/cobalt/dovetail/sched.c
+++ b/kernel/cobalt/dovetail/sched.c
@@ -37,6 +37,7 @@ void pipeline_init_shadow_tcb(struct xnthread *thread)
 	 * Initialize the alternate scheduling control block.
 	 */
 	dovetail_init_altsched(&xnthread_archtcb(thread)->altsched);
+	thread->host_pid = task_pid_nr(xnthread_host_task(thread));
 
 	trace_cobalt_shadow_map(thread);
 }
@@ -47,6 +48,7 @@ void pipeline_init_root_tcb(struct xnthread *thread)
 	 * Initialize the alternate scheduling control block.
 	 */
 	dovetail_init_altsched(&xnthread_archtcb(thread)->altsched);
+	thread->host_pid = 0;
 }
 
 int pipeline_leave_inband(void)
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 607f115a7b..1a3542caba 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -284,6 +284,7 @@ int __xnthread_init(struct xnthread *thread,
 	/* These will be filled by xnthread_start() */
 	thread->entry = NULL;
 	thread->cookie = NULL;
+	thread->host_pid = -1;
 	init_completion(&thread->exited);
 	memset(xnthread_archtcb(thread), 0, sizeof(struct xnarchtcb));
 	memset(thread->sigarray, 0, sizeof(thread->sigarray));
@@ -377,16 +378,6 @@ char *xnthread_format_status(unsigned long status, char *buf, int size)
 	return buf;
 }
 
-pid_t xnthread_host_pid(struct xnthread *thread)
-{
-	if (xnthread_test_state(thread, XNROOT))
-		return 0;
-	if (!xnthread_host_task(thread))
-		return -1;
-
-	return task_pid_nr(xnthread_host_task(thread));
-}
-
 int xnthread_set_clock(struct xnthread *thread, struct xnclock *newclock)
 {
 	spl_t s;
-- 
2.51.0

