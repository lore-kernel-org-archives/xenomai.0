Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA42423177
	for <xenomai@lists.linux.dev>; Wed,  4 Feb 2026 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228635; cv=none; b=MLT9dVN3lDQIE0t20maDBCJ+pBirKOzaMHyqbv5Ky8WdhQinRoF5QS62Qjcy7Eo1MBP2fKyzLfjERisX74yfiXXpzLRmRNiVpQzd9q8nFI4bTIgUDNIDXaMRGUzS5/fWsPqRqGUUYnQeZqJjCUxOwnul0U34qCCdlZox2VyQVYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228635; c=relaxed/simple;
	bh=xmWh3TiB13tNG/7SpS8hf3pjtaMIaThM2zC0kGi7Pig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Evp+jDYfVWt8B0KXQp3IN31SfGrYMQTy3jUxKw+3D5WRK1RTjxN50KB/ECFSqqkup4TLqclX1mG+e8YuYyq7Y2WKn35qHbtKM/XAbGSUMXtYuM9SEYAJPByrY2iLwtQq34Rwd/5UwnPHBGoaS59hmmIqEuWY0r0QU2OzSFqtjgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=Z5F2mQo0; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Z5F2mQo0"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260204181025cf98a3da820002079d
        for <xenomai@lists.linux.dev>;
        Wed, 04 Feb 2026 19:10:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=t8FzA/LM9qxKoMGXENI3lojXIwWw40MnR2VRVvN5DgY=;
 b=Z5F2mQo0O8pM09mN6upcLSR6gY+HaxYsjqjWiKrO5vv+x2asPje6NvmmPuXkmfQxuk3igV
 KfR2Z1SE6Of9g/marNbM52i8HPkmbDTUqqTLozTCUib1VZg8/pJI45w4nL2RctYdsPFgEYJe
 ntdWDjJSnJZ3dd9a5DwBE+ALfoyFxc5N0Q/AdvvAxpRsixUTtTj4Hp4VauEDt73O+Y6ST8ci
 KyeR1UxiVd5GxTLT0+hdpwFQCO48XN12YlvqgC0VcgRxC/CoYwpzqj5lVMoFdzVQ4/CQ5vio
 XnNTdOQ4C/8EHUuOhr9Q8LIeHl5C0en7thLdUSuMoc5vqkH/lR30lOaw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/3] cobalt/thread: Simplify wait_for_rcu_grace_period
Date: Wed,  4 Feb 2026 19:10:23 +0100
Message-ID: <4bd971ad1c9da5babb988d139d063cda5ba9c59f.1770228624.git.jan.kiszka@siemens.com>
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

Now that xnthread struct holds a stable host_pid, we can simplify its
interface, just passing the thread. As we are no longer holder some
reference the pid object, additionally match the host_pid's current task
against the xnthread's host task reference to avoid being misguided by
a potential pid reuse.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/thread.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 1a3542caba..441d36a15d 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -1588,7 +1588,7 @@ static void grace_elapsed(struct rcu_head *head)
 	complete(&wgs->done);
 }
 
-static void wait_for_rcu_grace_period(struct pid *pid)
+static void wait_for_rcu_grace_period(struct xnthread *thread)
 {
 	struct wait_grace_struct wait = {
 		.done = COMPLETION_INITIALIZER_ONSTACK(wait.done),
@@ -1600,12 +1600,12 @@ static void wait_for_rcu_grace_period(struct pid *pid)
 	for (;;) {
 		call_rcu(&wait.rcu, grace_elapsed);
 		wait_for_completion(&wait.done);
-		if (pid == NULL)
+		if (thread == NULL)
 			break;
 		rcu_read_lock();
-		p = pid_task(pid, PIDTYPE_PID);
+		p = find_task_by_pid_ns(thread->host_pid, &init_pid_ns);
 		rcu_read_unlock();
-		if (p == NULL)
+		if (p != xnthread_host_task(thread))
 			break;
 		reinit_completion(&wait.done);
 	}
@@ -1648,8 +1648,6 @@ int xnthread_join(struct xnthread *thread, bool uninterruptible)
 {
 	struct xnthread *curr = xnthread_current();
 	int ret = 0, switched = 0;
-	struct pid *pid;
-	pid_t tpid;
 	spl_t s;
 
 	XENO_BUG_ON(COBALT, xnthread_test_state(thread, XNROOT));
@@ -1670,7 +1668,6 @@ int xnthread_join(struct xnthread *thread, bool uninterruptible)
 	trace_cobalt_thread_join(thread);
 
 	xnthread_set_state(thread, XNJOINED);
-	tpid = xnthread_host_pid(thread);
 
 	if (curr && !xnthread_test_state(curr, XNRELAX)) {
 		xnlock_put_irqrestore(&nklock, s);
@@ -1679,15 +1676,6 @@ int xnthread_join(struct xnthread *thread, bool uninterruptible)
 	} else
 		xnlock_put_irqrestore(&nklock, s);
 
-	/*
-	 * Since in theory, we might be sleeping there for a long
-	 * time, we get a reference on the pid struct holding our
-	 * target, then we check for its existence upon wake up.
-	 */
-	pid = find_get_pid(tpid);
-	if (pid == NULL)
-		goto done;
-
 	/*
 	 * We have a tricky issue to deal with, which involves code
 	 * relying on the assumption that a destroyed thread will have
@@ -1726,17 +1714,13 @@ int xnthread_join(struct xnthread *thread, bool uninterruptible)
 		wait_for_completion(&thread->exited);
 	else {
 		ret = wait_for_completion_interruptible(&thread->exited);
-		if (ret < 0) {
-			put_pid(pid);
+		if (ret < 0)
 			return -EINTR;
-		}
 	}
 
 	/* Make sure the joinee has scheduled away ultimately. */
-	wait_for_rcu_grace_period(pid);
+	wait_for_rcu_grace_period(thread);
 
-	put_pid(pid);
-done:
 	ret = 0;
 	if (switched)
 		ret = xnthread_harden();
-- 
2.51.0

