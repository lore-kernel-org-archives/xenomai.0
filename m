Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77992DEA7D
	for <xenomai@lists.linux.dev>; Thu, 16 Oct 2025 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596356; cv=none; b=JAdAyDZfqFf+chO8Czdqmwbw26mSFXGGppLIEBIhTS7WWQYQj/rPOlDJmpp0ibzv4X42CzBumfeHG5XWodAKQrzAuwiuI3mnzYfzI4ztC/HIm9GYe2LOEkvqLFpmplSCx1o0f9Js2Lp0m33ei9cJzboRs7Fq4jTUzYD0QSwZQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596356; c=relaxed/simple;
	bh=HruQ/JIeKJJm94+8c7HyhnpLgM80Kx26EtjqTevnY7M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5k3L0lbgCh/CGUAcwAAkAADLRFSohpG8mlNyPU/c1rqtqX53LpJiubTKtqvRvBweHk6h0J6Wytv5zhwMzmh+8pnMXshnx/6TT8GIiolMJ9X/RVUBrPju76hiZBAgf/BDMOThq17uommYeYDZD0XSrRA3FYs0Yg359fSIiYvySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=E5Vqiu3d; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="E5Vqiu3d"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20251016063226dfffdf369a00020757
        for <xenomai@lists.linux.dev>;
        Thu, 16 Oct 2025 08:32:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=nOV8KygdM1jqFUWbnv1S7IC9JjvbOf50yJTuK98X4eQ=;
 b=E5Vqiu3dAuamnu+E203URL8yuH4BnMnEpRkLQ0dhbtwfY3GeJlTcOsqvNhp+393DdwF8dr
 EuwmR/j6p2sSU98hAKWQyy0gkByYZCSt8kSXW69e/u5u9oM0XUbFfo2TS3mSAionS6lctFY4
 u7fXTiIvprWukGKp8qVzLF3q1S7fwtlf6pEhp2jS9Kw5wqpdlibL09458GiH+jVS8tRyztCh
 8+1TgF/Pq615bGfULDfQ15KEV/T5xgU57z883hwHwwu6ejUSvn5jMKcKUNbusYZBMdVCjTJ/
 Z8UiZvtBJnYihH0v+Ma+RMdCu+lunj8viMyuCk50yJ6lEfsw5vbhu2Sg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH v2 4/7] kernel/cobalt: Optimize xndebug_trace_relax implementation
Date: Thu, 16 Oct 2025 08:32:21 +0200
Message-ID: <b271974120e054643e312500fc96379f73a8f72b.1760596344.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1760596344.git.jan.kiszka@siemens.com>
References: <cover.1760596344.git.jan.kiszka@siemens.com>
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

There is no need to use xnthread_signal with its irq_work_queue here
because the only caller of xndebug_trace_relax is already relaxed, and
it is invoked over the target thread as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/debug.c  | 11 ++++++++---
 kernel/cobalt/debug.h  |  5 ++---
 kernel/cobalt/thread.c |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
index 25b194c263..3c7696e5ad 100644
--- a/kernel/cobalt/debug.c
+++ b/kernel/cobalt/debug.c
@@ -196,10 +196,15 @@ DEFINE_PRIVATE_XNLOCK(relax_lock);
  * executable mappings that could be involved).
  */
 
-void xndebug_notify_relax(struct xnthread *thread, int reason)
+void xndebug_notify_relax(int reason)
 {
-	xnthread_signal(thread, SIGSHADOW,
-			  sigshadow_int(SIGSHADOW_ACTION_BACKTRACE, reason));
+	kernel_siginfo_t si;
+
+	memset(&si, 0, sizeof(si));
+	si.si_signo = SIGSHADOW;
+	si.si_code = SI_QUEUE;
+	si.si_int = sigshadow_int(SIGSHADOW_ACTION_BACKTRACE, reason);
+	send_sig_info(SIGSHADOW, &si, current);
 }
 
 void xndebug_trace_relax(int nr, unsigned long *backtrace,
diff --git a/kernel/cobalt/debug.h b/kernel/cobalt/debug.h
index 24dc354aa5..b759c76f51 100644
--- a/kernel/cobalt/debug.h
+++ b/kernel/cobalt/debug.h
@@ -52,13 +52,12 @@ static inline void xndebug_shadow_init(struct xnthread *thread)
 #endif  /* !XENO_OPT_DEBUG */
 
 #ifdef CONFIG_XENO_OPT_DEBUG_TRACE_RELAX
-void xndebug_notify_relax(struct xnthread *thread,
-			  int reason);
+void xndebug_notify_relax(int reason);
 void xndebug_trace_relax(int nr, unsigned long *backtrace,
 			 int reason);
 #else
 static inline
-void xndebug_notify_relax(struct xnthread *thread, int reason)
+void xndebug_notify_relax(int reason)
 {
 }
 static inline
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index bdd0531404..607f115a7b 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2116,7 +2116,7 @@ void xnthread_relax(int notify, int reason)
 	if (xnthread_test_state(thread, XNUSER) && notify) {
 		if (xnthread_test_state(thread, XNWARN)) {
 			/* Help debugging spurious relaxes. */
-			xndebug_notify_relax(thread, reason);
+			xndebug_notify_relax(reason);
 			memset(&si, 0, sizeof(si));
 			si.si_signo = SIGDEBUG;
 			si.si_code = SI_QUEUE;
-- 
2.51.0

