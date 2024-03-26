Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C6745F3
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434680; cv=none; b=UFMCqIs2to6lj49veIGd/AVcZMJYVz156mtpjZ84zqmUYcU2rNvqyuVcIUP0gN1LSnCrI6d2Sk7tMxsax2IupEEKNlbXDqqFyPtD2+EE16LSwFZmeeItYlCEcZ9c4IHGk8szzMz1JApmHgGH4GPWOF075od3zv/Rg629qe6x5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434680; c=relaxed/simple;
	bh=+Nz+tzrv9TC8MVpf7LG+GLeQkN23uhxzmlvdQO/QwZc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fuk+7YdcfEwDwHQj+VaUQxeHkOsgTIbj/8rAz59aavVKp3kD7wgAXYH7EC3aJ8exiKG6QS0DfMALApWF5pJVwWBTE1hA4mPXQBY3gNgifCODuFhbLys6XuW+Bi/WNXrYzzuDq/m9Zr6YIstq8meXk5fTOlFv5iOpyxmxEU8KDss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=HRonvTd/; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="HRonvTd/"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240326063109121b27e56840481269
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=mBi2s21Saa15XNhxk5omkpH+M0N51fH3wLdTVi/iWrg=;
 b=HRonvTd//X47HQnCwrXfZ6FjlwTtuLtBUCS8IOg7vgFSQPmqrAtYmeYQLzDLd5jW4zRtal
 XhGRL0Og35XZF5nfBsCK+vJ4JeM0QwxCxD4CyaRSxvA1DX3JMvLhGX8h/DQ4Lh4XEd8/Dpdo
 WPcuEUI2p4j/TtuIxlVmMwnWM5TJY=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 13/25] drivers/can: Make private functions static
Date: Tue, 26 Mar 2024 07:30:52 +0100
Message-Id: <2dadf20318a531bf217814c118db20a21941ccb3.1711434664.git.jan.kiszka@siemens.com>
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

Addresses missing prototype warnings with kernel 6.8.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/can/rtcan_module.c           |  4 ++--
 kernel/drivers/can/rtcan_raw.c              | 16 +++++++---------
 kernel/drivers/can/sja1000/rtcan_isa.c      |  2 +-
 kernel/drivers/can/sja1000/rtcan_mem.c      |  2 +-
 kernel/drivers/can/sja1000/rtcan_peak_dng.c |  4 ++--
 kernel/drivers/can/sja1000/rtcan_sja1000.c  | 19 +++++++++----------
 6 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/kernel/drivers/can/rtcan_module.c b/kernel/drivers/can/rtcan_module.c
index 82f96d7ef7..55d6596899 100644
--- a/kernel/drivers/can/rtcan_module.c
+++ b/kernel/drivers/can/rtcan_module.c
@@ -401,7 +401,7 @@ static void rtcan_proc_unregister(void)
 
 
 
-int __init rtcan_init(void)
+static int __init rtcan_init(void)
 {
     int err = 0;
 
@@ -427,7 +427,7 @@ int __init rtcan_init(void)
 }
 
 
-void __exit rtcan_exit(void)
+static void __exit rtcan_exit(void)
 {
     rtcan_corectl_unregister();
 
diff --git a/kernel/drivers/can/rtcan_raw.c b/kernel/drivers/can/rtcan_raw.c
index 92b7617fb7..87f9c4e6bd 100644
--- a/kernel/drivers/can/rtcan_raw.c
+++ b/kernel/drivers/can/rtcan_raw.c
@@ -216,7 +216,7 @@ EXPORT_SYMBOL_GPL(rtcan_loopback);
 #endif /* CONFIG_XENO_DRIVERS_CAN_LOOPBACK */
 
 
-int rtcan_raw_socket(struct rtdm_fd *fd, int protocol)
+static int rtcan_raw_socket(struct rtdm_fd *fd, int protocol)
 {
     /* Only protocol CAN_RAW is supported */
     if (protocol != CAN_RAW && protocol != 0)
@@ -258,8 +258,7 @@ static void rtcan_raw_close(struct rtdm_fd *fd)
 }
 
 
-int rtcan_raw_bind(struct rtdm_fd *fd,
-		   struct sockaddr_can *scan)
+static int rtcan_raw_bind(struct rtdm_fd *fd, struct sockaddr_can *scan)
 {
     struct rtcan_socket *sock = rtdm_fd_to_private(fd);
     rtdm_lockctx_t lock_ctx;
@@ -406,8 +405,7 @@ static int rtcan_raw_setsockopt(struct rtdm_fd *fd,
 }
 
 
-int rtcan_raw_ioctl(struct rtdm_fd *fd,
-		    unsigned int request, void *arg)
+static int rtcan_raw_ioctl(struct rtdm_fd *fd, unsigned int request, void *arg)
 {
     int ret = 0;
 
@@ -523,8 +521,8 @@ do {									\
 	recv_buf_index = (recv_buf_index + len) & (RTCAN_RXBUF_SIZE - 1); \
 } while (0)
 
-ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd,
-			  struct user_msghdr *msg, int flags)
+static ssize_t rtcan_raw_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
+				 int flags)
 {
     struct rtcan_socket *sock = rtdm_fd_to_private(fd);
     struct sockaddr_can scan;
@@ -851,8 +849,8 @@ static ssize_t __rtcan_raw_sendmsg(struct rtcan_device *dev, struct rtcan_socket
     return ret;
 }
 
-ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
-			  const struct user_msghdr *msg, int flags)
+static ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
+				 const struct user_msghdr *msg, int flags)
 {
     struct rtcan_socket *sock = rtdm_fd_to_private(fd);
     struct sockaddr_can *scan = (struct sockaddr_can *)msg->msg_name;
diff --git a/kernel/drivers/can/sja1000/rtcan_isa.c b/kernel/drivers/can/sja1000/rtcan_isa.c
index a0e49fea30..c658fdfc34 100644
--- a/kernel/drivers/can/sja1000/rtcan_isa.c
+++ b/kernel/drivers/can/sja1000/rtcan_isa.c
@@ -84,7 +84,7 @@ static void rtcan_isa_writereg(struct rtcan_device *dev, int port, u8 val)
 }
 
 
-int __init rtcan_isa_init_one(int idx)
+static int __init rtcan_isa_init_one(int idx)
 {
 	struct rtcan_device *dev;
 	struct rtcan_sja1000 *chip;
diff --git a/kernel/drivers/can/sja1000/rtcan_mem.c b/kernel/drivers/can/sja1000/rtcan_mem.c
index 965735eb35..8c90574c22 100644
--- a/kernel/drivers/can/sja1000/rtcan_mem.c
+++ b/kernel/drivers/can/sja1000/rtcan_mem.c
@@ -91,7 +91,7 @@ static void rtcan_mem_writereg(struct rtcan_device *dev, int reg, u8 val)
 	writeb(val, board->vmem + reg);
 }
 
-int __init rtcan_mem_init_one(int idx)
+static int __init rtcan_mem_init_one(int idx)
 {
 	struct rtcan_device *dev;
 	struct rtcan_sja1000 *chip;
diff --git a/kernel/drivers/can/sja1000/rtcan_peak_dng.c b/kernel/drivers/can/sja1000/rtcan_peak_dng.c
index d1e3f44648..f949c76692 100644
--- a/kernel/drivers/can/sja1000/rtcan_peak_dng.c
+++ b/kernel/drivers/can/sja1000/rtcan_peak_dng.c
@@ -208,7 +208,7 @@ static inline void rtcan_peak_dng_disable(struct rtcan_device *dev)
 }
 
 /** Init module */
-int __init rtcan_peak_dng_init_one(int idx)
+static int __init rtcan_peak_dng_init_one(int idx)
 {
     int ret, dtype;
     struct rtcan_device *dev;
@@ -304,7 +304,7 @@ int __init rtcan_peak_dng_init_one(int idx)
     return ret;
 }
 
-void rtcan_peak_dng_exit_one(struct rtcan_device *dev)
+static void rtcan_peak_dng_exit_one(struct rtcan_device *dev)
 {
     struct rtcan_peak_dng *dng = (struct rtcan_peak_dng *)dev->board_priv;
 
diff --git a/kernel/drivers/can/sja1000/rtcan_sja1000.c b/kernel/drivers/can/sja1000/rtcan_sja1000.c
index 0f49551f95..887c4e4937 100644
--- a/kernel/drivers/can/sja1000/rtcan_sja1000.c
+++ b/kernel/drivers/can/sja1000/rtcan_sja1000.c
@@ -547,16 +547,15 @@ static int rtcan_sja_mode_start(struct rtcan_device *dev,
     return ret;
 }
 
-can_state_t rtcan_sja_get_state(struct rtcan_device *dev)
+static can_state_t rtcan_sja_get_state(struct rtcan_device *dev)
 {
     can_state_t state = dev->state;
     rtcan_sja_is_operating(dev, &state);
     return state;
 }
 
-int rtcan_sja_set_mode(struct rtcan_device *dev,
-		       can_mode_t mode,
-		       rtdm_lockctx_t *lock_ctx)
+static int rtcan_sja_set_mode(struct rtcan_device *dev,
+			      can_mode_t mode, rtdm_lockctx_t *lock_ctx)
 {
     int ret = 0;
     can_state_t state;
@@ -608,9 +607,9 @@ int rtcan_sja_set_mode(struct rtcan_device *dev,
     return ret;
 }
 
-int rtcan_sja_set_bit_time(struct rtcan_device *dev,
-			   struct can_bittime *bit_time,
-			   rtdm_lockctx_t *lock_ctx)
+static int rtcan_sja_set_bit_time(struct rtcan_device *dev,
+				  struct can_bittime *bit_time,
+				  rtdm_lockctx_t *lock_ctx)
 {
     struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
     u8 btr0, btr1;
@@ -642,7 +641,7 @@ int rtcan_sja_set_bit_time(struct rtcan_device *dev,
     return 0;
 }
 
-void rtcan_sja_enable_bus_err(struct rtcan_device *dev)
+static void rtcan_sja_enable_bus_err(struct rtcan_device *dev)
 {
     struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
 
@@ -820,7 +819,7 @@ void rtcan_sja1000_unregister(struct rtcan_device *dev)
     rtcan_dev_unregister(dev);
 }
 
-int __init rtcan_sja_init(void)
+static int __init rtcan_sja_init(void)
 {
 	if (!rtdm_available())
 		return -ENOSYS;
@@ -830,7 +829,7 @@ int __init rtcan_sja_init(void)
 }
 
 
-void __exit rtcan_sja_exit(void)
+static void __exit rtcan_sja_exit(void)
 {
 	printk("%s removed\n", sja_ctrl_name);
 }
-- 
2.35.3

