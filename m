Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016835294B
	for <xenomai@lists.linux.dev>; Wed, 28 Jan 2026 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599714; cv=none; b=rcsXYTKiWKqO2JvKdn+Pqwu8xwOagZXUY72q0aS5Dk2sskWJDp4/cXTifopS16SfvmCvrs1zUpmDJtr8CG6verdLa+8Y6TsnyGs7sCk4rRJVpnaWoCrFx/ZRqCRATyF/kpwhgoJ6rneuzq45uCMIFVBCM+1qAk0FGjOabu/5xKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599714; c=relaxed/simple;
	bh=WeXjzIB/HwUxZdWNMmgMXF6YLbiBe09Rn7RlRlXn1BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSw/fO2SnLrhuW1A48znnzFaWkL7KXVDdD2QH8QDbypYRXvkmlHsdkiszwM1Gdm+Oeum95oipc/+8V9MhhbdtfbCJJrz6THawEapdSEha9uZgGR/x3FICKTjyBbuRvQgN4BzFyyCYn56Wzs60N1PrAnjAi4lkkZ1eddtqQObZTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5CEFFBE32C;
	Wed, 28 Jan 2026 12:28:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id MAIt-cc4ahAP; Wed, 28 Jan 2026 12:28:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B81C42E52E4;
	Wed, 28 Jan 2026 12:28:27 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yw6g_0RL3qJP; Wed, 28 Jan 2026 12:28:27 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 74E4A2C14AB;
	Wed, 28 Jan 2026 12:28:27 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/5] Make RTDM tasks behave, part II
Date: Wed, 28 Jan 2026 12:28:19 +0100
Message-ID: <20260128112821.1232-3-richard@nod.at>
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

Make sure that RTDM tasks terminate gracefully via rtdm_task_should_stop(=
).
To achieve this, enforce the correct teardown order: always terminate and
join the thread first, and only then destroy the resources it was using.

While this change does not fix a bug, it allows us to distinguish between
expected and unexpected task termination.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 kernel/drivers/net/addons/proxy.c                  | 2 +-
 kernel/drivers/net/stack/rtcfg/rtcfg_frame.c       | 4 ++--
 kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c | 2 +-
 kernel/drivers/net/stack/rtmac/tdma/tdma_module.c  | 4 ++--
 kernel/drivers/net/stack/rtnet_rtpc.c              | 2 +-
 kernel/drivers/net/stack/stack_mgr.c               | 3 ++-
 6 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/drivers/net/addons/proxy.c b/kernel/drivers/net/addon=
s/proxy.c
index e9956cd33..c3e5ce1c9 100644
--- a/kernel/drivers/net/addons/proxy.c
+++ b/kernel/drivers/net/addons/proxy.c
@@ -418,8 +418,8 @@ static void __exit rtnetproxy_cleanup_module(void)
 	unregister_netdev(dev_rtnetproxy);
 	free_netdev(dev_rtnetproxy);
=20
-	rtdm_event_destroy(&rtnetproxy_tx_event);
 	rtdm_task_destroy(&rtnetproxy_tx_task);
+	rtdm_event_destroy(&rtnetproxy_tx_event);
=20
 	/* free the non-real-time signal */
 	rtdm_nrtsig_destroy(&rtnetproxy_rx_signal);
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c b/kernel/driver=
s/net/stack/rtcfg/rtcfg_frame.c
index c7babb6d1..70318ad3c 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
@@ -558,8 +558,8 @@ int __init rtcfg_init_frames(void)
 	return 0;
=20
 error2:
-	rtdm_event_destroy(&rx_event);
 	rtdm_task_destroy(&rx_task);
+	rtdm_event_destroy(&rx_event);
=20
 error1:
 	rtskb_pool_release(&rtcfg_pool);
@@ -573,8 +573,8 @@ void rtcfg_cleanup_frames(void)
=20
 	rtdev_remove_pack(&rtcfg_packet_type);
=20
-	rtdm_event_destroy(&rx_event);
 	rtdm_task_destroy(&rx_task);
+	rtdm_event_destroy(&rx_event);
=20
 	while ((rtskb =3D rtskb_dequeue(&rx_queue)) !=3D NULL) {
 		kfree_rtskb(rtskb);
diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c b/kernel/=
drivers/net/stack/rtmac/nomac/nomac_proto.c
index 84317697b..6cdedae2f 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
+++ b/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
@@ -127,6 +127,6 @@ int __init nomac_proto_init(void)
=20
 void nomac_proto_cleanup(void)
 {
-	rtdm_event_destroy(&wakeup_sem);
 	rtdm_task_destroy(&wrapper_task);
+	rtdm_event_destroy(&wakeup_sem);
 }
diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c b/kernel/d=
rivers/net/stack/rtmac/tdma/tdma_module.c
index 47c66d91f..3c516d23b 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
+++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
@@ -228,14 +228,14 @@ static int tdma_detach(struct rtnet_device *rtdev, =
void *priv)
 	struct tdma_priv *tdma =3D (struct tdma_priv *)priv;
 	struct tdma_job *job, *tmp;
=20
+	rtdm_task_destroy(&tdma->worker_task);
+
 	rtdm_event_destroy(&tdma->sync_event);
 	rtdm_event_destroy(&tdma->xmit_event);
 	rtdm_event_destroy(&tdma->worker_wakeup);
=20
 	tdma_dev_release(tdma);
=20
-	rtdm_task_destroy(&tdma->worker_task);
-
 	list_for_each_entry_safe (job, tmp, &tdma->first_job->entry, entry) {
 		if (job->id >=3D 0)
 			tdma_cleanup_slot(tdma, SLOT_JOB(job));
diff --git a/kernel/drivers/net/stack/rtnet_rtpc.c b/kernel/drivers/net/s=
tack/rtnet_rtpc.c
index fe60209f2..16dd84979 100644
--- a/kernel/drivers/net/stack/rtnet_rtpc.c
+++ b/kernel/drivers/net/stack/rtnet_rtpc.c
@@ -251,8 +251,8 @@ int __init rtpc_init(void)
=20
 void rtpc_cleanup(void)
 {
-	rtdm_event_destroy(&dispatch_event);
 	rtdm_task_destroy(&dispatch_task);
+	rtdm_event_destroy(&dispatch_event);
 	rtdm_nrtsig_destroy(&rtpc_nrt_signal);
 }
=20
diff --git a/kernel/drivers/net/stack/stack_mgr.c b/kernel/drivers/net/st=
ack/stack_mgr.c
index f4f8c7fff..82e8412dc 100644
--- a/kernel/drivers/net/stack/stack_mgr.c
+++ b/kernel/drivers/net/stack/stack_mgr.c
@@ -257,6 +257,7 @@ int rt_stack_mgr_init(struct rtnet_mgr *mgr)
  */
 void rt_stack_mgr_delete(struct rtnet_mgr *mgr)
 {
-	rtdm_event_destroy(&mgr->event);
+
 	rtdm_task_destroy(&mgr->task);
+	rtdm_event_destroy(&mgr->event);
 }
--=20
2.51.0

