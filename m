Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6EE4314A
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434681; cv=none; b=roP/WkYljEGMnpnvLfFe/mMB75SjEh481mzHTwgTD5LJFdYc0Npiu0hYJCRqvCctF3YxHcCaM3ti7ZtPKTJGYMq1kpj7Xtv7cKGH9JuX/sfQL9hy9fub6TTQWipb/oBvjTXoVld0TM46JhfxN+ao5kjQy2MnaiOrkNHzvAmT2XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434681; c=relaxed/simple;
	bh=44b5v0RI2A+HvFVFzFOgEG8sesSn7/3xrncPY4FtKLM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqLhkgNiz++vS/h3e/eitw4hGzAC7viCbmZ6cJBzohCjfr0jttMryaYpPJdg1dOKz90UDcgcI/kAcqAkoRhNqG1YKCbOWewifPwIWwkvKbc4PF0tM1Mjs38WvY6EK7a4HV7WdrOI+yhNRL6hPmrdaiRVDXv4FxDNOIXqFrmEatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=OUq0PJFf; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="OUq0PJFf"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240326063110d623e9fe393a3f86f9
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=rej/aGl97xExtCDXg4WOVPmVI42c8jH34AupIZIKhiY=;
 b=OUq0PJFf2zO8tuk0Vg2IeXyzs2fzBaoH/MM1onKhSfUIZaGL1OVvfINLn5xBTMTOjDbEjI
 29Mj8ETO8KOiYehzASldX6PhtyPFLPc+2dQHXFZ7iCa5yq9fzNc0Jcj8qhPlvhpOOoW0Bs4w
 iY66o1HG+0eH0x9mkmm8nO6TeZoOc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 18/25] drivers/net: Address missing prototype warnings by adding includes
Date: Tue, 26 Mar 2024 07:30:57 +0100
Message-Id: <78cd64e986c250754430782d9e5ddbf24703b1d3.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/stack/eth.c                      | 1 +
 kernel/drivers/net/stack/ipv4/ip_output.c           | 1 +
 kernel/drivers/net/stack/ipv4/ip_sock.c             | 1 +
 kernel/drivers/net/stack/rtcfg/rtcfg_client_event.c | 1 +
 kernel/drivers/net/stack/rtcfg/rtcfg_proc.c         | 1 +
 kernel/drivers/net/stack/rtdev_mgr.c                | 1 +
 kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c    | 1 +
 kernel/drivers/net/stack/rtmac/nomac/nomac_ioctl.c  | 1 +
 kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c  | 1 +
 kernel/drivers/net/stack/rtmac/tdma/tdma_dev.c      | 1 +
 kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c    | 1 +
 kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c   | 1 +
 12 files changed, 12 insertions(+)

diff --git a/kernel/drivers/net/stack/eth.c b/kernel/drivers/net/stack/eth.c
index 427687f375..2ad7f0aee4 100644
--- a/kernel/drivers/net/stack/eth.c
+++ b/kernel/drivers/net/stack/eth.c
@@ -26,6 +26,7 @@
 
 #include <rtdev.h>
 #include <rtnet_internal.h>
+#include <ethernet/eth.h>
 
 /*
  *  Create the Ethernet MAC header for an arbitrary protocol layer
diff --git a/kernel/drivers/net/stack/ipv4/ip_output.c b/kernel/drivers/net/stack/ipv4/ip_output.c
index 47da3ca75c..ccec6d5f11 100644
--- a/kernel/drivers/net/stack/ipv4/ip_output.c
+++ b/kernel/drivers/net/stack/ipv4/ip_output.c
@@ -29,6 +29,7 @@
 #include <stack_mgr.h>
 #include <ipv4/ip_fragment.h>
 #include <ipv4/ip_input.h>
+#include <ipv4/ip_output.h>
 #include <ipv4/route.h>
 
 static DEFINE_RTDM_LOCK(rt_ip_id_lock);
diff --git a/kernel/drivers/net/stack/ipv4/ip_sock.c b/kernel/drivers/net/stack/ipv4/ip_sock.c
index 8ca6aebd19..ea15d2f05a 100644
--- a/kernel/drivers/net/stack/ipv4/ip_sock.c
+++ b/kernel/drivers/net/stack/ipv4/ip_sock.c
@@ -27,6 +27,7 @@
 #include <linux/in.h>
 
 #include <rtnet_socket.h>
+#include <ipv4/ip_sock.h>
 
 int rt_ip_setsockopt(struct rtdm_fd *fd, struct rtsocket *s, int level,
 		     int optname, const void __user *optval, socklen_t optlen)
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_client_event.c b/kernel/drivers/net/stack/rtcfg/rtcfg_client_event.c
index 1a69bf478d..cf9e1fc83c 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_client_event.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_client_event.c
@@ -27,6 +27,7 @@
 #include <rtcfg/rtcfg_event.h>
 #include <rtcfg/rtcfg_frame.h>
 #include <rtcfg/rtcfg_timer.h>
+#include <rtcfg/rtcfg_client_event.h>
 
 static int rtcfg_client_get_frag(int ifindex, struct rt_proc_call *call);
 static void rtcfg_client_detach(int ifindex, struct rt_proc_call *call);
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_proc.c b/kernel/drivers/net/stack/rtcfg/rtcfg_proc.c
index 3b39b741a6..2b7ad9e4be 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_proc.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_proc.c
@@ -28,6 +28,7 @@
 #include <rtcfg/rtcfg_conn_event.h>
 #include <rtcfg/rtcfg_event.h>
 #include <rtcfg/rtcfg_frame.h>
+#include <rtcfg/rtcfg_proc.h>
 
 #ifdef CONFIG_XENO_OPT_VFILE
 DEFINE_MUTEX(nrt_proc_lock);
diff --git a/kernel/drivers/net/stack/rtdev_mgr.c b/kernel/drivers/net/stack/rtdev_mgr.c
index c6c78c2d76..e5f9d19825 100644
--- a/kernel/drivers/net/stack/rtdev_mgr.c
+++ b/kernel/drivers/net/stack/rtdev_mgr.c
@@ -23,6 +23,7 @@
 #include <linux/netdevice.h>
 
 #include <rtdev.h>
+#include <rtdev_mgr.h>
 #include <rtdm/net.h>
 #include <rtnet_internal.h>
 
diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c b/kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c
index 572d893c05..c3eccc79f3 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c
+++ b/kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c
@@ -27,6 +27,7 @@
 #include <rtdev.h>
 #include <rtmac.h>
 #include <rtmac/nomac/nomac.h>
+#include <rtmac/nomac/nomac_dev.h>
 
 static int nomac_dev_openclose(void)
 {
diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_ioctl.c b/kernel/drivers/net/stack/rtmac/nomac/nomac_ioctl.c
index 95c7bf7fe0..2ce313f4a0 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/nomac_ioctl.c
+++ b/kernel/drivers/net/stack/rtmac/nomac/nomac_ioctl.c
@@ -27,6 +27,7 @@
 
 #include <nomac_chrdev.h>
 #include <rtmac/nomac/nomac.h>
+#include <rtmac/nomac/nomac_ioctl.h>
 
 static int nomac_ioctl_attach(struct rtnet_device *rtdev)
 {
diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c b/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
index 66cd9fc846..c13c8ccf05 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
+++ b/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
@@ -27,6 +27,7 @@
 #include <rtdev.h>
 #include <rtmac/rtmac_proto.h>
 #include <rtmac/nomac/nomac.h>
+#include <rtmac/nomac/nomac_proto.h>
 
 static struct rtskb_queue nrt_rtskb_queue;
 static rtdm_task_t wrapper_task;
diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_dev.c b/kernel/drivers/net/stack/rtmac/tdma/tdma_dev.c
index 99c7672b18..6d9a247e9f 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/tdma_dev.c
+++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_dev.c
@@ -27,6 +27,7 @@
 #include <rtdev.h>
 #include <rtmac.h>
 #include <rtmac/tdma/tdma.h>
+#include <rtmac/tdma/tdma_dev.h>
 
 struct tdma_dev_ctx {
 	rtdm_task_t *cycle_waiter;
diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c b/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c
index fe4ff59748..f0fa353803 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c
+++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c
@@ -30,6 +30,7 @@
 #include <tdma_chrdev.h>
 #include <rtmac/rtmac_vnic.h>
 #include <rtmac/tdma/tdma.h>
+#include <rtmac/tdma/tdma_ioctl.h>
 
 #ifdef CONFIG_XENO_DRIVERS_NET_TDMA_MASTER
 static int tdma_ioctl_master(struct rtnet_device *rtdev,
diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c b/kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c
index d12a480cd4..e3c60cd9ae 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c
+++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c
@@ -24,6 +24,7 @@
 
 #include <rtmac/rtmac_proto.h>
 #include <rtmac/tdma/tdma_proto.h>
+#include <rtmac/tdma/tdma_worker.h>
 
 static void do_slot_job(struct tdma_priv *tdma, struct tdma_slot *job,
 			rtdm_lockctx_t lockctx)
-- 
2.35.3

