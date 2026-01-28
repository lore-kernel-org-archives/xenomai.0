Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF7335294A
	for <xenomai@lists.linux.dev>; Wed, 28 Jan 2026 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599713; cv=none; b=WgXPymuCa/RKwY+BwYaFhI4d80oCGP2dUqfmslRt9odjmZoNds0PtjbdDHKG28YMfmUPLUaNb0dW0JSd82TFIITI5NuU1lG4bfq9UYSFshl0/2wKvNR0fEQZmiGMHStHzkX8+hVxbO19ABdgTfiWGuFoTcxUIRRGIWoe44iZEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599713; c=relaxed/simple;
	bh=Sxqmb+IuZCaT2WuhAh5hiM7Ys/N2kSX+blvzRuVxlck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuTCO9Uek/F1vZxYriYEe5fGQfb0g8jR+jnmWpt0pVDhtje2kcxFmQWsTZH/S+ZfxXhC8vayz1eclOi/1wWfuMEjwN9Gw8LllrP1ZgGd/smfw2YwAJEQA6g9kq62u0y5pqrrX4kUCsOz/Ah+d8mZxKuh7OmtZOQ/hx/8yNHnQ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 49728BE32F;
	Wed, 28 Jan 2026 12:28:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id p3HCqGLVUSa4; Wed, 28 Jan 2026 12:28:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8655CBE32A;
	Wed, 28 Jan 2026 12:28:27 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o0xQve5o9M6b; Wed, 28 Jan 2026 12:28:27 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 4A1D9BE32B;
	Wed, 28 Jan 2026 12:28:27 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/5] Make RTDM tasks behave, part I
Date: Wed, 28 Jan 2026 12:28:18 +0100
Message-ID: <20260128112821.1232-2-richard@nod.at>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128112821.1232-1-richard@nod.at>
References: <20260128112821.1232-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RTDM tasks must now utilize rtdm_task_should_stop() to ensure proper
cleanup and SIGSHADOW detection.
Also, handle -EINTR gracefully, rather than exiting immediately on
interruption, the task should loop and re-check rtdm_task_should_stop()
to decide if termination is actually required.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 kernel/drivers/autotune/autotune.c              | 17 ++++++++++-------
 kernel/drivers/net/addons/proxy.c               |  6 +++++-
 kernel/drivers/net/stack/ipv4/tcp/timerwheel.c  |  6 ++++--
 kernel/drivers/net/stack/rtcfg/rtcfg_frame.c    |  6 +++++-
 .../drivers/net/stack/rtmac/nomac/nomac_proto.c |  6 +++++-
 .../drivers/net/stack/rtmac/tdma/tdma_worker.c  |  4 +++-
 kernel/drivers/net/stack/rtnet_rtpc.c           |  5 ++++-
 kernel/drivers/net/stack/stack_mgr.c            |  6 +++++-
 kernel/drivers/testing/rtdmtest.c               |  9 ++++-----
 kernel/drivers/testing/timerbench.c             |  2 +-
 10 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/kernel/drivers/autotune/autotune.c b/kernel/drivers/autotune=
/autotune.c
index 03fd688de..c11d18057 100644
--- a/kernel/drivers/autotune/autotune.c
+++ b/kernel/drivers/autotune/autotune.c
@@ -248,22 +248,25 @@ static void task_handler(void *arg)
 	xnticks_t now;
 	int ret =3D 0;
=20
-	for (;;) {
-		if (rtdm_task_should_stop())
-			break;
-
+	while (!rtdm_task_should_stop()) {
 		ret =3D rtdm_event_wait(&k_tuner->barrier);
-		if (ret)
+		if (ret =3D=3D -EINTR)
+			continue;
+		else if (ret)
 			break;
=20
 		ret =3D rtdm_task_set_period(&k_tuner->task, k_tuner->start_time,
 					   k_tuner->interval);
-		if (ret)
+		if (ret =3D=3D -EINTR)
+			continue;
+		else if (ret)
 			break;
=20
 		for (;;) {
 			ret =3D rtdm_task_wait_period(NULL);
-			if (ret && ret !=3D -ETIMEDOUT)
+			if (ret =3D=3D -EINTR)
+				break;
+			else if (ret && ret !=3D -ETIMEDOUT)
 				goto out;
=20
 			now =3D xnclock_read_raw(&nkclock);
diff --git a/kernel/drivers/net/addons/proxy.c b/kernel/drivers/net/addon=
s/proxy.c
index d63bb13bc..e9956cd33 100644
--- a/kernel/drivers/net/addons/proxy.c
+++ b/kernel/drivers/net/addons/proxy.c
@@ -103,9 +103,13 @@ static void rtnetproxy_tx_loop(void *arg)
 {
 	struct rtnet_device *rtdev;
 	struct rtskb *rtskb;
+	int ret;
=20
 	while (!rtdm_task_should_stop()) {
-		if (rtdm_event_wait(&rtnetproxy_tx_event) < 0)
+		ret =3D rtdm_event_wait(&rtnetproxy_tx_event);
+		if (ret =3D=3D -EINTR)
+			continue;
+		else if (ret < 0)
 			break;
=20
 		while ((rtskb =3D rtskb_dequeue(&tx_queue)) !=3D NULL) {
diff --git a/kernel/drivers/net/stack/ipv4/tcp/timerwheel.c b/kernel/driv=
ers/net/stack/ipv4/tcp/timerwheel.c
index 6c8bf7e66..209e45924 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/timerwheel.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/timerwheel.c
@@ -124,9 +124,11 @@ static void timerwheel_pivot(void *arg)
 	struct timerwheel_timer *timer;
 	int ret;
=20
-	while (1) {
+	while (!rtdm_task_should_stop()) {
 		ret =3D timerwheel_sleep();
-		if (ret < 0) {
+		if (ret =3D=3D -EINTR)
+			continue;
+		else if (ret < 0) {
 			pr_err("timerwheel_pivot interrupted %d\n", -ret);
 			break;
 		}
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c b/kernel/driver=
s/net/stack/rtcfg/rtcfg_frame.c
index ca6c130b5..c7babb6d1 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
@@ -61,9 +61,13 @@ static void rtcfg_rx_task(void *arg)
 	struct rtskb *rtskb;
 	struct rtcfg_frm_head *frm_head;
 	struct rtnet_device *rtdev;
+	int ret;
=20
 	while (!rtdm_task_should_stop()) {
-		if (rtdm_event_wait(&rx_event) < 0)
+		ret =3D rtdm_event_wait(&rx_event);
+		if (ret =3D=3D -EINTR)
+			continue;
+		else if (ret < 0)
 			break;
=20
 		while ((rtskb =3D rtskb_dequeue(&rx_queue))) {
diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c b/kernel/=
drivers/net/stack/rtmac/nomac/nomac_proto.c
index e9842ac5e..84317697b 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
+++ b/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
@@ -80,9 +80,13 @@ static void nrt_xmit_task(void *arg)
 {
 	struct rtskb *rtskb;
 	struct rtnet_device *rtdev;
+	int ret;
=20
 	while (!rtdm_task_should_stop()) {
-		if (rtdm_event_wait(&wakeup_sem) < 0)
+		ret =3D rtdm_event_wait(&wakeup_sem);
+		if (ret =3D=3D -EINTR)
+			continue;
+		else if (ret < 0)
 			break;
=20
 		while ((rtskb =3D rtskb_dequeue(&nrt_rtskb_queue))) {
diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c b/kernel/d=
rivers/net/stack/rtmac/tdma/tdma_worker.c
index e3c60cd9a..c1235e3cc 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c
+++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c
@@ -193,7 +193,9 @@ void tdma_worker(void *arg)
 		case WAIT_ON_SYNC:
 			rtdm_lock_put_irqrestore(&tdma->lock, lockctx);
 			ret =3D rtdm_event_wait(&tdma->sync_event);
-			if (ret)
+			if (ret =3D=3D -EINTR)
+				continue;
+			else if (ret)
 				return;
 			rtdm_lock_get_irqsave(&tdma->lock, lockctx);
 			break;
diff --git a/kernel/drivers/net/stack/rtnet_rtpc.c b/kernel/drivers/net/s=
tack/rtnet_rtpc.c
index cd5f0546d..fe60209f2 100644
--- a/kernel/drivers/net/stack/rtnet_rtpc.c
+++ b/kernel/drivers/net/stack/rtnet_rtpc.c
@@ -178,7 +178,10 @@ static void rtpc_dispatch_handler(void *arg)
 	int ret;
=20
 	while (!rtdm_task_should_stop()) {
-		if (rtdm_event_wait(&dispatch_event) < 0)
+		ret =3D rtdm_event_wait(&dispatch_event);
+		if (ret =3D=3D -EINTR)
+			continue;
+		else if (ret < 0)
 			break;
=20
 		while ((call =3D rtpc_dequeue_pending_call())) {
diff --git a/kernel/drivers/net/stack/stack_mgr.c b/kernel/drivers/net/st=
ack/stack_mgr.c
index b30a74549..f4f8c7fff 100644
--- a/kernel/drivers/net/stack/stack_mgr.c
+++ b/kernel/drivers/net/stack/stack_mgr.c
@@ -196,9 +196,13 @@ static void rt_stack_mgr_task(void *arg)
 {
 	rtdm_event_t *mgr_event =3D &((struct rtnet_mgr *)arg)->event;
 	struct rtskb *rtskb;
+	int ret =3D 0;
=20
 	while (!rtdm_task_should_stop()) {
-		if (rtdm_event_wait(mgr_event) < 0)
+		ret =3D rtdm_event_wait(mgr_event);
+		if (ret =3D=3D -EINTR)
+			continue;
+		else if (ret < 0)
 			break;
=20
 		/* we are the only reader =3D> no locking required */
diff --git a/kernel/drivers/testing/rtdmtest.c b/kernel/drivers/testing/r=
tdmtest.c
index 87aef8ee6..ca29ec54b 100644
--- a/kernel/drivers/testing/rtdmtest.c
+++ b/kernel/drivers/testing/rtdmtest.c
@@ -138,12 +138,11 @@ static void actor_handler(void *arg)
 	struct rtdm_actor_context *ctx =3D arg;
 	int ret;
=20
-	for (;;) {
-		if (rtdm_task_should_stop())
-			return;
-
+	while (!rtdm_task_should_stop()) {
 		ret =3D rtdm_event_wait(&ctx->run);
-		if (ret)
+		if (ret =3D=3D -EINTR)
+			continue;
+		else if (ret)
 			break;
=20
 		switch (ctx->request) {
diff --git a/kernel/drivers/testing/timerbench.c b/kernel/drivers/testing=
/timerbench.c
index 68e50a241..75da6bfdb 100644
--- a/kernel/drivers/testing/timerbench.c
+++ b/kernel/drivers/testing/timerbench.c
@@ -146,7 +146,7 @@ static void timer_task_proc(void *arg)
 	/* first event: one millisecond from now. */
 	ctx->date =3D rtdm_clock_read_monotonic() + 1000000;
=20
-	while (1) {
+	while (!rtdm_task_should_stop()) {
 		for (count =3D 0; count < ctx->samples_per_sec; count++) {
 			cobalt_atomic_enter(s);
 			ctx->start_time =3D rtdm_clock_read_monotonic();
--=20
2.51.0

