Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE171AA70
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 20:37:53 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2023083120374417ab4ca1b1d01f07c9
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 22:37:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Wej0lI58vJjrR+FBTzX6FELX/Dny9mSQyUlDwbt6tY0=;
 b=ZwLmMP1K40gh1zr0d0lp8D30vL5mtYyFIV8r+Eq1JVXPis1BPz4vrvwuVWEHrcQessxaFn
 HIRuhY2d0HqLf0Lbq9y8PFNUofokqkOrUjmi55Z/ptdS0MxxT9yb8DwkEIA9Ewg4kjPf0NXv
 fneEhALBI6SB/8kofKGQJ4LNBS7Wk=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 31 Aug 2023 22:37:35 +0200
Subject: [PATCH stable/v3.2.x 09/19] cobalt: Resolve cast-function-type
 warnings
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v1-9-0e08770820e8@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

[ master commit 73a91e2c85bb61863cc00f5b44b2095b6e4ecf90 ]

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
index a0395e187..f023de354 100644
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
index cd72b22d1..46c4998e4 100644
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
index 736e82da7..12155157a 100644
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
index e63fab7dc..c7ceb767f 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -90,7 +90,7 @@ static struct rtdm_fd *fetch_fd(struct cobalt_ppd *p, int ufd)
 
 #define assign_invalid_handler(__handler, __invalid)			\
 	do								\
-		(__handler) = (typeof(__handler))__invalid;		\
+		(__handler) = (typeof(__handler))(void (*)(void))__invalid; \
 	while (0)
 
 /* Calling this handler should beget ENOSYS if not implemented. */
diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c b/kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c
index f75f5f8b7..572d893c0 100644
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
2.39.2

