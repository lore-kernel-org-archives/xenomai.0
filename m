Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D3193070
	for <xenomai@lists.linux.dev>; Sun, 12 Jan 2025 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736679532; cv=none; b=I2KrQzTFGnWpVgV3RCC4VEgEhnC6lkiedebUH2flnhsjd2PM6PBrbE75H7PazLysziWP5Iki1FNgaJs+0MwbI0cBfDdzecR0AZQjZdvv2T1gcKuVcRCHOUDp+wsfTGhf3e8gUsoLtkAaaZexiGx0ZgktUEuvH4EOb5XVwKQvVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736679532; c=relaxed/simple;
	bh=qCWhfBPKa3xhyHZFV5la6mn6mmplzuo+T5vJEwHpMoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8sngqSJ+c0ZEqHVcGFwbWQSjHhqTvjRRlP6wZ/M+2ev+EU/ulan1FuCE7qBKEozTRCu5t5pkgsr603wz/IAuwZ2LTp+9igAglosoVdx6r0tkfPea1zC5Rd9yCa0WYNV3S7RNlYyuI4YvK8bMIqydWPB+iCSByog1EfGH3uscxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=dMOTsbB2; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="dMOTsbB2"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202501121048306eb11b1cff1e18a080
        for <xenomai@lists.linux.dev>;
        Sun, 12 Jan 2025 11:48:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ERIgBfLSFU6jI4y2dXMd+KX2sSe0o4+6ow24WzSzor4=;
 b=dMOTsbB2R+3lWj4geP2Uf9E+TLqWalFbxGCSSgtySw2P6Xh/8xGcwWvkARpUUtoztylUI1
 TFe++4DrxN/73YPHXLj2KuGcGBzkdur2V+ryenYUVa8CQ3tYezhVF1pXwyNPuwjzS3pDWr2m
 pt7hljuKQigeuaSdzn9gTnfjOvVxe7ezjZKgfT8e5KEOFw6sQJaF+io97q7T+LbV3fHQHBJs
 CCcXrw3XtOicnY6eFC/q/axyaQB8Hnc+POSXjBh3t7ubSgZxiEtfefAuSWgzIjjjPS86oKAI
 7AwAvWxxPg0ghhNt7rwwgXjunumCxubu+DCkd3BYm8IatAuCt6fWn4/w==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 3/3] cobalt: Add missing evaluations of __xn_get/put_user return codes
Date: Sun, 12 Jan 2025 11:48:29 +0100
Message-ID: <0a46e61f30ae6a7c9be36b78fd13a1d3b59abd83.1736678909.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1736678909.git.jan.kiszka@siemens.com>
References: <cover.1736678909.git.jan.kiszka@siemens.com>
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

We should always give userspace feedback on the validity of a provided
pointer, rather than silently swallowing errors. Except for
cobalt_map_user, this includes adding an access_ok check as well.

As a side-effect, this resolves a compiler issue caused by [1] in
__cobalt_monitor_wait: At least gcc 12 on arm64 manages to skip an
important instruction during fixup of _[_xn]_put_user that causes a
register corruption down the road [2]. That is triggered by us ignoring
the return value, thus making the compiler drop the asm-goto block for
it which would have contained that critical instruction as well (as
duplicate who knows why). While this may very well be a compiler bug,
the triggering pattern of us remains invalid.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7fd298d4b39d8d5fe99d56811a7ed78c7a5377d5
[2] https://lore.kernel.org/xenomai/87frltuz6j.fsf@xenomai.org

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/cond.c    | 9 ++++++---
 kernel/cobalt/posix/monitor.c | 3 ++-
 kernel/cobalt/posix/process.c | 5 ++++-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/cobalt/posix/cond.c b/kernel/cobalt/posix/cond.c
index cd9cf0cb98..2a1904c2c5 100644
--- a/kernel/cobalt/posix/cond.c
+++ b/kernel/cobalt/posix/cond.c
@@ -309,7 +309,9 @@ int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 		return -EINVAL;
 
 	if (cond->mutex == NULL) {
-		__xn_get_user(offset, &u_mx->state_offset);
+		if (!access_ok(&u_mx->state_offset, sizeof(u_mx->state_offset))
+		    || __xn_get_user(offset, &u_mx->state_offset))
+			return -EFAULT;
 		cond->state->mutex_state_offset = offset;
 	}
 
@@ -348,8 +350,9 @@ int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
 	if (cond->mutex == NULL)
 		cond->state->mutex_state_offset = ~0U;
 
-	if (err == -EINTR)
-		__xn_put_user(d.err, u_err);
+	if (err == -EINTR &&
+	    (!access_ok(u_err, sizeof(*u_err)) || __xn_put_user(d.err, u_err)))
+		err = -EFAULT;
 
 	return err == 0 ? perr : err;
 }
diff --git a/kernel/cobalt/posix/monitor.c b/kernel/cobalt/posix/monitor.c
index fb7fb27e94..9ce75f4bce 100644
--- a/kernel/cobalt/posix/monitor.c
+++ b/kernel/cobalt/posix/monitor.c
@@ -289,7 +289,8 @@ int __cobalt_monitor_wait(struct cobalt_monitor_shadow __user *u_mon,
 out:
 	xnlock_put_irqrestore(&nklock, s);
 
-	__xn_put_user(opret, u_ret);
+	if (!access_ok(u_ret, sizeof(*u_ret)) || __xn_put_user(opret, u_ret))
+		ret = -EFAULT;
 
 	return ret;
 }
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 8b4efcab40..f7cf97c398 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -617,8 +617,11 @@ int cobalt_map_user(struct xnthread *thread, __u32 __user *u_winoff)
 	if (u_window == NULL)
 		return -ENOMEM;
 
+	if (__xn_put_user(cobalt_umm_offset(umm, u_window), u_winoff)) {
+		cobalt_umm_free(umm, u_window);
+		return -EFAULT;
+	}
 	thread->u_window = u_window;
-	__xn_put_user(cobalt_umm_offset(umm, u_window), u_winoff);
 	xnthread_pin_initial(thread);
 
 	/*
-- 
2.43.0

