Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8033B352951
	for <xenomai@lists.linux.dev>; Wed, 28 Jan 2026 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599714; cv=none; b=QUnhL/paqvD0gYWYaSjM0ehLIpF9ert2iYI117f50l7XlG9WpUZw2aNEv8kUf7ti93qVETg3pF7HXGLUW71Bq4ob0QnzVcD2UZcc9nDE8XKyhRy+2vsKFIO3qeJATGf29v5rF1qxPGDbxBvPWPhDaEIMh6ZOQUVWpTnUVLxiVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599714; c=relaxed/simple;
	bh=iavQvXoEaWQ47dyO+Bbk1PusIr8vuiSbzbBzqOMbN6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ea3BNF7ceMIsGuROWAYE3x51Ic7/luuYCOF4qyH5JTa2TFIdwDWN5UAHwL5vUC3OAh/4Z0pfuSXqMj3JqkMlj+nhnGZkrYT5qfCaCygE0YGv7Hg8zpPXcsA1qfPYD6OWrC35pZ4qz/hLwaUTuWZuRKLiRz1PyGcnHF+4KK7WcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id EE6C5BE32A;
	Wed, 28 Jan 2026 12:28:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id EnM7rjBV6Pmc; Wed, 28 Jan 2026 12:28:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 20BC2BE32B;
	Wed, 28 Jan 2026 12:28:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MARsOpWf52n9; Wed, 28 Jan 2026 12:28:28 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id D05AEBE32E;
	Wed, 28 Jan 2026 12:28:27 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/5] Allow specifying CPU affinity in rtdm_task_init()
Date: Wed, 28 Jan 2026 12:28:21 +0100
Message-ID: <20260128112821.1232-5-richard@nod.at>
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

Previously, rtdm_task_init() did not provide a way to pin a task to a
specific CPU during initialization.

Update the function signature to accept a CPU identifier.
Passing -1 results in the default behavior, allowing the
scheduler to automatically select the CPU.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/cobalt/kernel/rtdm/driver.h                |  4 ++--
 kernel/cobalt/rtdm/drvlib.c                        | 14 +++++++++++---
 kernel/drivers/analogy/testing/fake.c              |  2 +-
 kernel/drivers/autotune/autotune.c                 |  2 +-
 kernel/drivers/net/addons/proxy.c                  |  2 +-
 kernel/drivers/net/stack/ipv4/tcp/timerwheel.c     |  2 +-
 kernel/drivers/net/stack/rtcfg/rtcfg_frame.c       |  2 +-
 kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c |  2 +-
 kernel/drivers/net/stack/rtmac/tdma/tdma_module.c  |  2 +-
 kernel/drivers/net/stack/rtnet_rtpc.c              |  2 +-
 kernel/drivers/net/stack/stack_mgr.c               |  2 +-
 kernel/drivers/testing/rtdmtest.c                  |  2 +-
 kernel/drivers/testing/timerbench.c                |  2 +-
 13 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/=
rtdm/driver.h
index 3fc5573cb..dcfbccbdf 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -1032,8 +1032,8 @@ typedef void (*rtdm_task_proc_t)(void *arg);
 /** @} rtdm_task */
=20
 int rtdm_task_init(rtdm_task_t *task, const char *name,
-		   rtdm_task_proc_t task_proc, void *arg,
-		   int priority, nanosecs_rel_t period);
+		   rtdm_task_proc_t task_proc, void *arg, int priority,
+		   nanosecs_rel_t period, int cpu);
 int __rtdm_task_sleep(xnticks_t timeout, xntmode_t mode);
 void rtdm_task_busy_sleep(nanosecs_rel_t delay);
=20
diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 08e113904..f68b1089c 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -101,6 +101,7 @@ nanosecs_abs_t rtdm_clock_read_monotonic(void);
  * @param[in] arg Custom argument passed to @c task_proc() on entry
  * @param[in] priority Priority of the task, see also
  * @ref rtdmtaskprio "Task Priority Range"
+ * @param[in] cpu preferred CPU to run on, pass -1 for auto selection
  * @param[in] period Period in nanoseconds of a cyclic task, 0 for non-c=
yclic
  * mode. Waiting for the first and subsequent periodic events is
  * done using rtdm_task_wait_period().
@@ -110,8 +111,8 @@ nanosecs_abs_t rtdm_clock_read_monotonic(void);
  * @coretags{secondary-only, might-switch}
  */
 int rtdm_task_init(rtdm_task_t *task, const char *name,
-		   rtdm_task_proc_t task_proc, void *arg,
-		   int priority, nanosecs_rel_t period)
+		   rtdm_task_proc_t task_proc, void *arg, int priority,
+		   nanosecs_rel_t period, int cpu)
 {
 	union xnsched_policy_param param;
 	struct xnthread_start_attr sattr;
@@ -124,7 +125,14 @@ int rtdm_task_init(rtdm_task_t *task, const char *na=
me,
 	iattr.name =3D name;
 	iattr.flags =3D 0;
 	iattr.personality =3D &xenomai_personality;
-	iattr.affinity =3D CPU_MASK_ALL;
+
+	if (cpu =3D=3D -1) {
+		iattr.affinity =3D CPU_MASK_ALL;
+	} else {
+		cpumask_clear(&iattr.affinity);
+		cpumask_set_cpu(cpu, &iattr.affinity);
+	}
+
 	param.rt.prio =3D priority;
=20
 	err =3D xnthread_init(task, &iattr, &xnsched_class_rt, &param);
diff --git a/kernel/drivers/analogy/testing/fake.c b/kernel/drivers/analo=
gy/testing/fake.c
index fd88ed99f..8daba1047 100644
--- a/kernel/drivers/analogy/testing/fake.c
+++ b/kernel/drivers/analogy/testing/fake.c
@@ -637,7 +637,7 @@ static int test_attach(struct a4l_device *dev, a4l_ln=
kdesc_t *arg)
=20
 	/* create the task */
 	ret =3D rtdm_task_init(&priv->task, "Fake AI task", task_proc, dev,
-		             RTDM_TASK_HIGHEST_PRIORITY, 0);
+		             RTDM_TASK_HIGHEST_PRIORITY, 0, -1);
 	if (ret)
 		a4l_dbg(1, drv_dbg, dev, "Error creating A4L task \n");
=20
diff --git a/kernel/drivers/autotune/autotune.c b/kernel/drivers/autotune=
/autotune.c
index c11d18057..970ef6fda 100644
--- a/kernel/drivers/autotune/autotune.c
+++ b/kernel/drivers/autotune/autotune.c
@@ -291,7 +291,7 @@ static int init_kthread_tuner(struct gravity_tuner *t=
uner)
=20
 	return rtdm_task_init(&k_tuner->task, "autotune",
 			      task_handler, k_tuner,
-			      RTDM_TASK_HIGHEST_PRIORITY, 0);
+			      RTDM_TASK_HIGHEST_PRIORITY, 0, -1);
 }
=20
 static void destroy_kthread_tuner(struct gravity_tuner *tuner)
diff --git a/kernel/drivers/net/addons/proxy.c b/kernel/drivers/net/addon=
s/proxy.c
index c3e5ce1c9..8398e4787 100644
--- a/kernel/drivers/net/addons/proxy.c
+++ b/kernel/drivers/net/addons/proxy.c
@@ -380,7 +380,7 @@ static int __init rtnetproxy_init_module(void)
 	rtdm_event_init(&rtnetproxy_tx_event, 0);
 	err =3D rtdm_task_init(&rtnetproxy_tx_task, "rtnetproxy",
 			     rtnetproxy_tx_loop, 0, RTDM_TASK_LOWEST_PRIORITY,
-			     0);
+			     0, -1);
 	if (err)
 		goto err4;
=20
diff --git a/kernel/drivers/net/stack/ipv4/tcp/timerwheel.c b/kernel/driv=
ers/net/stack/ipv4/tcp/timerwheel.c
index 209e45924..a7b259ffd 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/timerwheel.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/timerwheel.c
@@ -205,7 +205,7 @@ int __init timerwheel_init(nanosecs_rel_t timeout, un=
signed int granularity)
 	rtdm_lock_init(&wheel.slot_lock);
=20
 	err =3D rtdm_task_init(&wheel.pivot_task, "rttcp timerwheel",
-			     timerwheel_pivot, NULL, 1, 0);
+			     timerwheel_pivot, NULL, 1, 0, -1);
 	if (err) {
 		pr_err("error on pivot task initialization: %d\n", err);
 		kfree(wheel.ring);
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c b/kernel/driver=
s/net/stack/rtcfg/rtcfg_frame.c
index 70318ad3c..51cd2313e 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
@@ -545,7 +545,7 @@ int __init rtcfg_init_frames(void)
 	rtdm_event_init(&rx_event, 0);
=20
 	ret =3D rtdm_task_init(&rx_task, "rtcfg-rx", rtcfg_rx_task, 0,
-			     RTDM_TASK_LOWEST_PRIORITY, 0);
+			     RTDM_TASK_LOWEST_PRIORITY, 0, -1);
 	if (ret < 0) {
 		rtdm_event_destroy(&rx_event);
 		goto error1;
diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c b/kernel/=
drivers/net/stack/rtmac/nomac/nomac_proto.c
index 6cdedae2f..9cf48c245 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
+++ b/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
@@ -116,7 +116,7 @@ int __init nomac_proto_init(void)
 	rtdm_event_init(&wakeup_sem, 0);
=20
 	ret =3D rtdm_task_init(&wrapper_task, "rtnet-nomac", nrt_xmit_task, 0,
-			     RTDM_TASK_LOWEST_PRIORITY, 0);
+			     RTDM_TASK_LOWEST_PRIORITY, 0, -1);
 	if (ret < 0) {
 		rtdm_event_destroy(&wakeup_sem);
 		return ret;
diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c b/kernel/d=
rivers/net/stack/rtmac/tdma/tdma_module.c
index 3c516d23b..eb65f27d6 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
+++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
@@ -206,7 +206,7 @@ static int tdma_attach(struct rtnet_device *rtdev, vo=
id *priv)
 		goto err_out1;
=20
 	ret =3D rtdm_task_init(&tdma->worker_task, "rtnet-tdma", tdma_worker,
-			     tdma, DEF_WORKER_PRIO, 0);
+			     tdma, DEF_WORKER_PRIO, 0, -1);
 	if (ret !=3D 0)
 		goto err_out2;
=20
diff --git a/kernel/drivers/net/stack/rtnet_rtpc.c b/kernel/drivers/net/s=
tack/rtnet_rtpc.c
index 16dd84979..6d362c8d4 100644
--- a/kernel/drivers/net/stack/rtnet_rtpc.c
+++ b/kernel/drivers/net/stack/rtnet_rtpc.c
@@ -240,7 +240,7 @@ int __init rtpc_init(void)
=20
 	ret =3D rtdm_task_init(&dispatch_task, "rtnet-rtpc",
 			     rtpc_dispatch_handler, 0,
-			     RTDM_TASK_LOWEST_PRIORITY, 0);
+			     RTDM_TASK_LOWEST_PRIORITY, 0, -1);
 	if (ret < 0) {
 		rtdm_event_destroy(&dispatch_event);
 		rtdm_nrtsig_destroy(&rtpc_nrt_signal);
diff --git a/kernel/drivers/net/stack/stack_mgr.c b/kernel/drivers/net/st=
ack/stack_mgr.c
index 82e8412dc..eb3e720c5 100644
--- a/kernel/drivers/net/stack/stack_mgr.c
+++ b/kernel/drivers/net/stack/stack_mgr.c
@@ -249,7 +249,7 @@ int rt_stack_mgr_init(struct rtnet_mgr *mgr)
 	rtdm_event_init(&mgr->event, 0);
=20
 	return rtdm_task_init(&mgr->task, "rtnet-stack", rt_stack_mgr_task, mgr=
,
-			      stack_mgr_prio, 0);
+			      stack_mgr_prio, 0, -1);
 }
=20
 /***
diff --git a/kernel/drivers/testing/rtdmtest.c b/kernel/drivers/testing/r=
tdmtest.c
index ca29ec54b..cf5b6a927 100644
--- a/kernel/drivers/testing/rtdmtest.c
+++ b/kernel/drivers/testing/rtdmtest.c
@@ -167,7 +167,7 @@ static int rtdm_actor_open(struct rtdm_fd *fd, int of=
lags)
=20
 	return rtdm_task_init(&ctx->actor_task, "rtdm_actor",
 			      actor_handler, ctx,
-			      RTDM_TASK_LOWEST_PRIORITY, 0);
+			      RTDM_TASK_LOWEST_PRIORITY, 0, -1);
 }
=20
 static void rtdm_actor_close(struct rtdm_fd *fd)
diff --git a/kernel/drivers/testing/timerbench.c b/kernel/drivers/testing=
/timerbench.c
index 75da6bfdb..a96be5331 100644
--- a/kernel/drivers/testing/timerbench.c
+++ b/kernel/drivers/testing/timerbench.c
@@ -289,7 +289,7 @@ static int rt_tmbench_start(struct rtdm_fd *fd,
 	if (config->mode =3D=3D RTTST_TMBENCH_TASK) {
 		err =3D rtdm_task_init(&ctx->timer_task, "timerbench",
 				timer_task_proc, ctx,
-				config->priority, 0);
+				config->priority, 0, -1);
 		if (!err)
 			ctx->mode =3D RTTST_TMBENCH_TASK;
 	} else {
--=20
2.51.0

