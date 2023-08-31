Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070E01AA80
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 20:37:55 +0000 (UTC)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20230831203747ce1f475ec20e6895ef
        for <xenomai@lists.linux.dev>;
        Thu, 31 Aug 2023 22:37:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=R2WuoKCsJZTuRiV4w6FqtTIJII62XHutilpr6FBMt0k=;
 b=RFADwz7gycnFl/S1U2fYnMUHfz3tR3S08WtzOpmMUkV3/UZxWBkQ3UuKKQEnjggtal3olk
 X7n6Ihb/+ZHhFo/rrIRgbOmZPoVeY+t+uwYh4PSjeR6CbVS+fbkiRB3TwngAyHfBaURwPMV/
 tWMp8662CFm9GWQBbp6vkUBc9YEFY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Thu, 31 Aug 2023 22:37:42 +0200
Subject: [PATCH stable/v3.2.x 16/19] cobalt: Adjust dev_addr_set wrapper to
 5.10, 5.1 and 4.19 backports
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-florian-enable-stable-3-2-for-6-1-v1-16-0e08770820e8@siemens.com>
References: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
To: xenomai@lists.linux.dev, jan.kiszka@siemens.com
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Based on master commit
97edeebab85a ("cobalt: Adjust dev_addr_set wrapper to 5.10 backport").

The 3.2 stable branch still supports kernel 4.19. As 4.19 got the
affected functions as backports we have to care.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 62fbb1a2a..7654047b4 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -252,7 +252,13 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #define close_fd(__ufd)	__close_fd(current->files, __ufd)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
+    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
+     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188)) && \
+    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,5,0) || \
+     LINUX_VERSION_CODE < KERNEL_VERSION(5,4,251)) && \
+    (LINUX_VERSION_CODE >= KERNEL_VERSION(4,20,0) || \
+     LINUX_VERSION_CODE < KERNEL_VERSION(4,19,291))
 #define dev_addr_set(dev, addr)		memcpy((dev)->dev_addr, addr, MAX_ADDR_LEN)
 #define eth_hw_addr_set(dev, addr)	memcpy((dev)->dev_addr, addr, ETH_ALEN)
 #endif

-- 
2.39.2

