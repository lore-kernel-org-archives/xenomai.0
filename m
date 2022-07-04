Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BDF46AB
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:45 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id B6A1E240011
	for <xenomai@lists.linux.dev>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 50E037803E5
	for <xenomai@xenomai.org>; Mon,  4 Jul 2022 13:08:37 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20220704130837a121b38b78cbd0ab24
        for <xenomai@xenomai.org>;
        Mon, 04 Jul 2022 15:08:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=90nKhdHZdl5mnwgEPls6lutu3qHNHpBlzmlb4uo7Wzs=;
 b=FNDznzN3OOAauHf7m/7gtLNh+FYZggce5hExREePf56MrT75FYuy6CwmTwjfE+IelpzeOe
 3zdHZiqO8oQWTJH7uYO8hd4RMZKg0Exk8J0Hxrs897y+68tXx6AuOzjohiUqDNK7jODZho1P
 Cka+QlhijITcbEA003uTOdiOlMoiI=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@xenomai.org
Subject: [PATCH 10/15] cobalt: Resolve cast-function-type warnings
Date: Mon,  4 Jul 2022 15:08:30 +0200
Message-Id: <ea3cb676a468e3494c3c46043c9e36a5d2ac06c1.1656940114.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1656940114.git.jan.kiszka@siemens.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass (spool4: domain of rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) client-ip=185.136.64.227; envelope-from=fm-294854-20220704130837a121b38b78cbd0ab24-lgY7GA@rts-flowmailer.siemens.com; helo=mta-64-227.siemens.flowmailer.net;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=FNDznzN3;
	spf=pass (spool.mail.gandi.net: domain of fm-294854-20220704130837a121b38b78cbd0ab24-lgY7GA@rts-flowmailer.siemens.com designates 185.136.64.227 as permitted sender) smtp.mailfrom=fm-294854-20220704130837a121b38b78cbd0ab24-lgY7GA@rts-flowmailer.siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

Latest kernel with around gcc-10 starts to complain about the type casts
done for error stubs, syscall handlers and nomac_dev_openclose. Those
casts remain fine, so suppress them by casting to the special
"void (*)(void)" type first.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h |  3 ++-
 kernel/cobalt/posix/syscall.c                          |  3 ++-
 kernel/cobalt/rtdm/device.c                            | 10 ++++++----
 kernel/cobalt/rtdm/fd.c                                |  2 +-
 kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c       |  4 ++--
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
index a0395e1872..f023de354d 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
@@ -40,7 +40,8 @@
 #error "__NR_COBALT_SYSCALLS > __COBALT_IA32_BASE"
 #endif
 
-#define __syshand32emu__(__name)	((cobalt_syshand)(CoBaLt32emu_ ## __name))
+#define __syshand32emu__(__name)	\
+	((cobalt_syshand)(void (*)(void))(CoBaLt32emu_ ## __name))
 
 #define __COBALT_CALL32emu_INITHAND(__handler)	\
 	[__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __handler,
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index cd72b22d14..46c4998e4c 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -426,7 +426,8 @@ static int CoBaLt_ni(void)
  *
  * --rpm
  */
-#define __syshand__(__name)	((cobalt_syshand)(CoBaLt_ ## __name))
+#define __syshand__(__name)	\
+	((cobalt_syshand)(void (*)(void))(CoBaLt_ ## __name))
 
 #define __COBALT_NI	__syshand__(ni)
 
diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
index 736e82da7d..12155157a6 100644
--- a/kernel/cobalt/rtdm/device.c
+++ b/kernel/cobalt/rtdm/device.c
@@ -412,10 +412,12 @@ int rtdm_dev_register(struct rtdm_device *dev)
 	}
 
 	dev->ops = drv->ops;
-	if (drv->device_flags & RTDM_NAMED_DEVICE)
-		dev->ops.socket = (typeof(dev->ops.socket))enosys;
-	else
-		dev->ops.open = (typeof(dev->ops.open))enosys;
+	if (drv->device_flags & RTDM_NAMED_DEVICE) {
+		dev->ops.socket =
+			(typeof(dev->ops.socket))(void (*)(void))enosys;
+	} else {
+		dev->ops.open = (typeof(dev->ops.open))(void (*)(void))enosys;
+	}
 
 	INIT_LIST_HEAD(&dev->openfd_list);
 	init_waitqueue_head(&dev->putwq);
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index 3c26534f39..ed2e135780 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -89,7 +89,7 @@ static struct rtdm_fd *fetch_fd(struct cobalt_ppd *p, int ufd)
 
 #define assign_invalid_handler(__handler, __invalid)			\
 	do								\
-		(__handler) = (typeof(__handler))__invalid;		\
+		(__handler) = (typeof(__handler))(void (*)(void))__invalid; \
 	while (0)
 
 /* Calling this handler should beget ENOSYS if not implemented. */
diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c b/kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c
index f75f5f8b73..572d893c05 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c
+++ b/kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c
@@ -59,11 +59,11 @@ static struct rtdm_driver
 			 .context_size = 0,
 			 .ops = {
 				 .open = (typeof(nomac_driver.ops.open))
-					 nomac_dev_openclose,
+					 (void (*)(void))nomac_dev_openclose,
 				 .ioctl_rt = nomac_dev_ioctl,
 				 .ioctl_nrt = nomac_dev_ioctl,
 				 .close = (typeof(nomac_driver.ops.close))
-					 nomac_dev_openclose,
+					 (void (*)(void))nomac_dev_openclose,
 			 } };
 
 int nomac_dev_init(struct rtnet_device *rtdev, struct nomac_priv *nomac)
-- 
2.35.3

