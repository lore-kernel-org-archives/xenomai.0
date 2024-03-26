Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1299374BEB
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434682; cv=none; b=KnQoaJLgF/X7FJzLYcxMiRdmrim3k0pxiAHtUTWaum4EgURaW+XN+NWiGLnA3JQqXScDUSf2ZQFedzXRlTb3P8eSF1hBNjh/yV6uhcCKnncPgA23Wy1WcZMxiVC38slZr/ERtxGccY3R8f51g7wdpI4L1b3AMcdjyC3H2DXSuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434682; c=relaxed/simple;
	bh=k34D+oL1/dxsbcBDxEyWFcHIFlsmUcEMrdaozjOyYDI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OWrYkz3a1hCnWRRjEeGUxlVHZ+i1AxYvlAaGeWKCjQOPxKq/AiWD+dCMweH8/IZSOE8fXDmEq5P7bJL59flkLYte/n/FYeA5CacpcPmec5QEQMkL3yAZQtIm59mlykS+4Jq20D2D7HeTDbsHCkyTFFeCC5jyhM3JzTwJZLEhknE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=bY+msnMD; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="bY+msnMD"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240326063112fa69bf9397a063e880
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=MKloosbRGbb33zA7QYKU2+JXRNdRbtM9wqLy9+aIre8=;
 b=bY+msnMDkrFnC+9gryOYV7gQ+sWBhK1/+F5mTQpwoGC7HUCv/s72KU1qgDpZvCdrnZZX4M
 Kzx+Rg43WA4KDR4n8oa7hCW0sbfKD/CzYA6J7KaUkpl7jTJ/OgzRUffLpOBldhIoTDDi9vCa
 DZuZ7UMAmYiMZ0mmEkAFOeONhYS6Y=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 23/25] drivers/serial: Make private functions static
Date: Tue, 26 Mar 2024 07:31:02 +0100
Message-Id: <d778fce8ca26e3cba84b229d615da24820e5d259.1711434664.git.jan.kiszka@siemens.com>
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
 kernel/drivers/serial/16550A.c      | 18 +++++++++---------
 kernel/drivers/serial/rt_imx_uart.c |  6 +++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/drivers/serial/16550A.c b/kernel/drivers/serial/16550A.c
index c9274fb191..f8faa9def9 100644
--- a/kernel/drivers/serial/16550A.c
+++ b/kernel/drivers/serial/16550A.c
@@ -428,7 +428,7 @@ static int rt_16550_set_config(struct rt_16550_context *ctx,
 	return err;
 }
 
-void rt_16550_cleanup_ctx(struct rt_16550_context *ctx)
+static void rt_16550_cleanup_ctx(struct rt_16550_context *ctx)
 {
 	rtdm_event_destroy(&ctx->in_event);
 	rtdm_event_destroy(&ctx->out_event);
@@ -436,7 +436,7 @@ void rt_16550_cleanup_ctx(struct rt_16550_context *ctx)
 	rtdm_mutex_destroy(&ctx->out_lock);
 }
 
-int rt_16550_open(struct rtdm_fd *fd, int oflags)
+static int rt_16550_open(struct rtdm_fd *fd, int oflags)
 {
 	struct rt_16550_context *ctx;
 	int dev_id = rtdm_fd_minor(fd);
@@ -500,7 +500,7 @@ int rt_16550_open(struct rtdm_fd *fd, int oflags)
 	return 0;
 }
 
-void rt_16550_close(struct rtdm_fd *fd)
+static void rt_16550_close(struct rtdm_fd *fd)
 {
 	struct rt_16550_context *ctx;
 	unsigned long base;
@@ -536,7 +536,7 @@ void rt_16550_close(struct rtdm_fd *fd)
 	kfree(in_history);
 }
 
-int rt_16550_ioctl(struct rtdm_fd *fd, unsigned int request, void *arg)
+static int rt_16550_ioctl(struct rtdm_fd *fd, unsigned int request, void *arg)
 {
 	rtdm_lockctx_t lock_ctx;
 	struct rt_16550_context *ctx;
@@ -779,7 +779,7 @@ int rt_16550_ioctl(struct rtdm_fd *fd, unsigned int request, void *arg)
 	return err;
 }
 
-ssize_t rt_16550_read(struct rtdm_fd *fd, void *buf, size_t nbyte)
+static ssize_t rt_16550_read(struct rtdm_fd *fd, void *buf, size_t nbyte)
 {
 	struct rt_16550_context *ctx;
 	rtdm_lockctx_t lock_ctx;
@@ -942,7 +942,7 @@ break_unlocked:
 	return ret;
 }
 
-ssize_t rt_16550_write(struct rtdm_fd *fd, const void *buf, size_t nbyte)
+static ssize_t rt_16550_write(struct rtdm_fd *fd, const void *buf, size_t nbyte)
 {
 	struct rt_16550_context *ctx;
 	rtdm_lockctx_t lock_ctx;
@@ -1092,9 +1092,9 @@ static struct rtdm_driver uart16550A_driver = {
 	},
 };
 
-void rt_16550_exit(void);
+static void rt_16550_exit(void);
 
-int __init rt_16550_init(void)
+static int __init rt_16550_init(void)
 {
 	struct rtdm_device *dev;
 	unsigned long base;
@@ -1169,7 +1169,7 @@ int __init rt_16550_init(void)
 	return err;
 }
 
-void rt_16550_exit(void)
+static void rt_16550_exit(void)
 {
 	int i;
 
diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index 00fdd5f363..2b2dbeeb72 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -786,7 +786,7 @@ static int rt_imx_uart_set_config(struct rt_imx_uart_ctx *ctx,
 	return err;
 }
 
-void rt_imx_uart_cleanup_ctx(struct rt_imx_uart_ctx *ctx)
+static void rt_imx_uart_cleanup_ctx(struct rt_imx_uart_ctx *ctx)
 {
 	rtdm_event_destroy(&ctx->in_event);
 	rtdm_event_destroy(&ctx->out_event);
@@ -933,7 +933,7 @@ static int rt_imx_uart_open(struct rtdm_fd *fd, int oflags)
 				rtdm_fd_device(fd)->name, ctx);
 }
 
-void rt_imx_uart_close(struct rtdm_fd *fd)
+static void rt_imx_uart_close(struct rtdm_fd *fd)
 {
 	struct rt_imx_uart_port *port;
 	struct rt_imx_uart_ctx *ctx;
@@ -1198,7 +1198,7 @@ wait_unlock_out:
 	return err;
 }
 
-ssize_t rt_imx_uart_read(struct rtdm_fd *fd, void *buf, size_t nbyte)
+static ssize_t rt_imx_uart_read(struct rtdm_fd *fd, void *buf, size_t nbyte)
 {
 	struct rt_imx_uart_ctx *ctx;
 	rtdm_lockctx_t lock_ctx;
-- 
2.35.3

