Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1FF51475C
	for <xenomai@lists.linux.dev>; Tue,  8 Sep 2026 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865714; cv=none; b=nOVV7Nau4w5bbm9izVzK0lHmHXUmZR1I8Jy24QKNqHCmZSJaib2sTVDvtsK/3Su6ULIeIQF77XEEHIfkZCvV25RTetQ+K3kFKt1GKLi2Fxh7dxgh3ucf8M6yRREcCUAfk2xk7Ic2992W0xPTFBYKhmJHoEMn1R3+S7+MfMJRXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865714; c=relaxed/simple;
	bh=M73pymIAIf/XdO14QXoKmRCaG8BoIhp4a4KkG1r4zcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kO67I7jaGtCyavLLzKmxIXsLCGFUqErpeV9buCASTuTv2ipErSMlkDwq8WwLXZkGMYnBc2hWs4TBkwSxgIPb+f+VmwM8iuByYoNPv8fWb13LGMhJKeSih5JsogYFNd7kuiJO7MADhiJ9pPyau+ZNmMJvMrXuq61Qe1QhcgGLBC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=SNClEGbb; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="SNClEGbb"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202609081108220892700686000207b7
        for <xenomai@lists.linux.dev>;
        Tue, 08 Sep 2026 13:08:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ovV3JGJbT9kntAzGRUOlJexh5WGK92t4xv/8hwstLMw=;
 b=SNClEGbbCWIuQwvy1jiuoLiXqv8tr+oBS6sdLJkYgpCW0xX2zrkwMCKqi/54eWPweMIxwr
 DskA7CDZ9wxcggixwjmApcfcB0qnMk1m193THGfetOSr6wDPB8VeQ+DhHkLRM8mzFr2jXOfG
 VZ+BCVwkddADGskRVYVepkQAUL/XEHY//vuQaYFeMHkvfvXVhsfqg+SSjfbDrIIDbOtyj6nE
 yKKFBjW2sriGfvGPwxKpdlXq9kqF4wNkbxpYPLy0nf3MMIvU7C3xnmKO0NpBIbL1mYXJa4ER
 6X10dTAUoecXSt8voNoKakjFAWxSHSDVW0hpb1sgf0EYtKF3fEPTnIcQ==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 08 Sep 2026 13:08:21 +0200
Subject: [PATCH 1/2] cobalt: Replace strncpy() with strscpy()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-wip-flo-prepare-for-7-2-v1-1-eaf975a56944@siemens.com>
References: <20260908-wip-flo-prepare-for-7-2-v1-0-eaf975a56944@siemens.com>
In-Reply-To: <20260908-wip-flo-prepare-for-7-2-v1-0-eaf975a56944@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

strncpy() has been "deprecated" for some time and was finally removed
with Linux 7.2, so that dovetail does not provide it from 7.2 on as
well.

strscpy() is the replacement that should be used for all kernels that
xenomai/next is supporting - as long as we keep the third (size)
parameter. On modern kernels strscpy() is a macro where the third
parameter is only necessary if the size of dst is unknown to the
compiler. In most cases the size is known, so that the parameter could
be removed. We keep it to stay backward compatible.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/ancillaries.h                        |  3 +--
 kernel/drivers/can/c_can/rtcan_c_can_platform.c            |  2 +-
 kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c           |  2 +-
 kernel/drivers/can/rtcan_dev.c                             |  2 +-
 kernel/drivers/can/rtcan_flexcan.c                         |  2 +-
 kernel/drivers/can/rtcan_module.c                          | 14 +++++++-------
 kernel/drivers/can/rtcan_virt.c                            |  2 +-
 kernel/drivers/can/sja1000/rtcan_adv_pci.c                 |  2 +-
 kernel/drivers/can/sja1000/rtcan_ems_pci.c                 |  2 +-
 kernel/drivers/can/sja1000/rtcan_esd_pci.c                 |  2 +-
 kernel/drivers/can/sja1000/rtcan_isa.c                     |  2 +-
 kernel/drivers/can/sja1000/rtcan_ixxat_pci.c               |  2 +-
 kernel/drivers/can/sja1000/rtcan_mem.c                     |  2 +-
 kernel/drivers/can/sja1000/rtcan_peak_dng.c                |  2 +-
 kernel/drivers/can/sja1000/rtcan_peak_pci.c                |  2 +-
 kernel/drivers/can/sja1000/rtcan_plx_pci.c                 |  2 +-
 kernel/drivers/net/drivers/e1000e/netdev.c                 |  6 +++---
 .../drivers/net/drivers/experimental/e1000/e1000_ethtool.c |  8 ++++----
 kernel/drivers/net/drivers/experimental/e1000/e1000_main.c |  2 +-
 kernel/drivers/net/drivers/igb/igb_main.c                  |  2 +-
 kernel/drivers/net/drivers/igc/igc_main.c                  |  2 +-
 kernel/drivers/net/stack/ipv4/route.c                      |  2 +-
 kernel/drivers/net/stack/rtdev.c                           |  2 +-
 23 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/include/cobalt/kernel/ancillaries.h b/include/cobalt/kernel/ancillaries.h
index b957310c78e273846e12cdfa04e46abb50d055e1..43ac2458cf39d3f3bfdfaa770537a68d47654d2f 100644
--- a/include/cobalt/kernel/ancillaries.h
+++ b/include/cobalt/kernel/ancillaries.h
@@ -58,8 +58,7 @@ void __knamecpy_requires_character_array_as_destination(void);
 	({								\
 		if (!__builtin_types_compatible_p(typeof(__dst), char[])) \
 			__knamecpy_requires_character_array_as_destination();	\
-		strncpy((__dst), __src, sizeof(__dst));			\
-		__dst[sizeof(__dst) - 1] = '\0';			\
+		strscpy((__dst), (__src), sizeof(__dst));		\
 		__dst;							\
 	 })
 
diff --git a/kernel/drivers/can/c_can/rtcan_c_can_platform.c b/kernel/drivers/can/c_can/rtcan_c_can_platform.c
index aef6f8895c5242b5b5d458e1f17a8600815329d6..97ab549ccceaa13d8d149f959e0a251202a7a984 100644
--- a/kernel/drivers/can/c_can/rtcan_c_can_platform.c
+++ b/kernel/drivers/can/c_can/rtcan_c_can_platform.c
@@ -411,7 +411,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	dev->state = CAN_STATE_STOPPED;
 
 	/* Give device an interface name */
-	strncpy(dev->name, DEV_NAME, IFNAMSIZ);
+	strscpy(dev->name, DEV_NAME, IFNAMSIZ);
 
 	ret = rtcan_c_can_register(dev);
 	if (ret) {
diff --git a/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c b/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c
index 5214159b3123c7c8a09ecad570c8e4b891e79af8..ab352b260cdf690bde6b59d70344857da9148214 100644
--- a/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c
+++ b/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c
@@ -601,7 +601,7 @@ struct rtcan_device *alloc_peak_canfd_dev(int sizeof_priv, int index)
 		return NULL;
 
 	/* RTCAN part initialization */
-	strncpy(rdev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+	strscpy(rdev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 	rdev->ctrl_name = RTCAN_CTRLR_NAME;
 	rdev->can_sys_clock = 80*1000*1000;	/* default */
 	rdev->state = CAN_STATE_STOPPED;
diff --git a/kernel/drivers/can/rtcan_dev.c b/kernel/drivers/can/rtcan_dev.c
index bd741e1db3f053c1db7f01bffc1c5f5dbf849723..25c7913ac6fa38d288b8fa8a55e97ed7d8850821 100644
--- a/kernel/drivers/can/rtcan_dev.c
+++ b/kernel/drivers/can/rtcan_dev.c
@@ -130,7 +130,7 @@ void rtcan_dev_alloc_name(struct rtcan_device *dev, const char *mask)
     for (i = 0; i < RTCAN_MAX_DEVICES; i++) {
 	ksformat(buf, IFNAMSIZ, mask, i);
 	if ((tmp = rtcan_dev_get_by_name(buf)) == NULL) {
-	    strncpy(dev->name, buf, IFNAMSIZ);
+	    strscpy(dev->name, buf, IFNAMSIZ);
 	    break;
 	}
 #ifdef RTCAN_USE_REFCOUNT
diff --git a/kernel/drivers/can/rtcan_flexcan.c b/kernel/drivers/can/rtcan_flexcan.c
index 48febe4d5fae3496bed92c1add9f6592df9bd0c4..2ca3a78c3726cf6bb71ff32067af03716305abe2 100644
--- a/kernel/drivers/can/rtcan_flexcan.c
+++ b/kernel/drivers/can/rtcan_flexcan.c
@@ -1465,7 +1465,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	dev->do_set_bit_time = flexcan_copy_bittiming;
 	dev->bittiming_const = &flexcan_bittiming_const;
 	dev->state = CAN_STATE_STOPPED;
-	strncpy(dev->name, DEV_NAME, IFNAMSIZ);
+	strscpy(dev->name, DEV_NAME, IFNAMSIZ);
 	
 	err = register_flexcandev(dev);
 	if (err) {
diff --git a/kernel/drivers/can/rtcan_module.c b/kernel/drivers/can/rtcan_module.c
index 8fc7a699c581d325986a368af7fa1172db4e5c5c..9c43a6d65ed722c3c85166c07eda1643284be954 100644
--- a/kernel/drivers/can/rtcan_module.c
+++ b/kernel/drivers/can/rtcan_module.c
@@ -66,9 +66,9 @@ static void rtcan_dev_get_state_name(can_state_t state,
 {
     if (state >= CAN_STATE_ACTIVE &&
 	state <= CAN_STATE_SLEEPING)
-	strncpy(name, rtcan_state_names[state], max_len);
+	strscpy(name, rtcan_state_names[state], max_len);
     else
-	strncpy(name, "unknown", max_len);
+	strscpy(name, "unknown", max_len);
 }
 
 static void rtcan_dev_get_baudrate_name(can_baudrate_t baudrate,
@@ -76,10 +76,10 @@ static void rtcan_dev_get_baudrate_name(can_baudrate_t baudrate,
 {
     switch (baudrate) {
     case CAN_BAUDRATE_UNCONFIGURED:
-	strncpy(name, "undefined", max_len);
+	strscpy(name, "undefined", max_len);
 	break;
     case CAN_BAUDRATE_UNKNOWN:
-	strncpy(name, "unknown", max_len);
+	strscpy(name, "unknown", max_len);
 	break;
     default:
 	ksformat(name, max_len, "%d", baudrate);
@@ -107,7 +107,7 @@ static void rtcan_dev_get_bittime_name(struct can_bittime *bit_time,
 		 bit_time->btr.btr0, bit_time->btr.btr1);
 	break;
     default:
-	strncpy(name, "unknown", max_len);
+	strscpy(name, "unknown", max_len);
 	break;
     }
 }
@@ -116,7 +116,7 @@ static void rtcan_get_timeout_name(nanosecs_rel_t timeout,
 				   char* name, int max_len)
 {
     if (timeout == RTDM_TIMEOUT_INFINITE)
-	strncpy(name, "infinite", max_len);
+	strscpy(name, "infinite", max_len);
     else
 	ksformat(name, max_len, "%lld", (long long)timeout);
 }
@@ -195,7 +195,7 @@ static int rtcan_read_proc_sockets(struct seq_file *p, void *data)
 	    if (ifindex) {
 		dev = rtcan_dev_get_by_index(ifindex);
 		if (dev) {
-		    strncpy(name, dev->name, IFNAMSIZ);
+		    strscpy(name, dev->name, IFNAMSIZ);
 		    rtcan_dev_dereference(dev);
 		}
 	    } else
diff --git a/kernel/drivers/can/rtcan_virt.c b/kernel/drivers/can/rtcan_virt.c
index 1e3b2c024465402afa3b471564acf3d2d8317f08..9d2ddb9025718200b74dee30b766d9554486472b 100644
--- a/kernel/drivers/can/rtcan_virt.c
+++ b/kernel/drivers/can/rtcan_virt.c
@@ -129,7 +129,7 @@ static int __init rtcan_virt_init_one(int idx)
 
 	rtcan_virt_set_mode(dev, CAN_MODE_STOP, NULL);
 
-	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+	strscpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 
 	dev->hard_start_xmit = rtcan_virt_start_xmit;
 	dev->do_set_mode = rtcan_virt_set_mode;
diff --git a/kernel/drivers/can/sja1000/rtcan_adv_pci.c b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
index 33724a4c4fc11b64f3bcf6010bc5d422895b828d..d26b9983341c120f7bcb6e32b3edbb29f74f98e7 100644
--- a/kernel/drivers/can/sja1000/rtcan_adv_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
@@ -194,7 +194,7 @@ static int rtcan_adv_pci_add_chan(struct pci_dev *pdev,
 	/* Clock divider register */
 	chip->cdr = ADV_PCI_CDR;
 
-	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+	strscpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 
 	/* Make sure SJA1000 is in reset mode */
 	chip->write_reg(dev, SJA_MOD, SJA_MOD_RM);
diff --git a/kernel/drivers/can/sja1000/rtcan_ems_pci.c b/kernel/drivers/can/sja1000/rtcan_ems_pci.c
index 2e3001b05c9f3c2bde82425d1709e2b4f03317d4..2184bc1279301195dbe6acb0e1aecf00ed089e29 100644
--- a/kernel/drivers/can/sja1000/rtcan_ems_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_ems_pci.c
@@ -310,7 +310,7 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 			goto failure_cleanup;
 		}
 
-		strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+		strscpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 		dev->board_name = ems_pci_board_name;
 		dev->board_priv = card;
 
diff --git a/kernel/drivers/can/sja1000/rtcan_esd_pci.c b/kernel/drivers/can/sja1000/rtcan_esd_pci.c
index 795e9f676ba68eec0d470f5b0d3674bd5a0f4a0d..28e665fa5e471862f0018c70fb15aa23579d9f26 100644
--- a/kernel/drivers/can/sja1000/rtcan_esd_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_esd_pci.c
@@ -188,7 +188,7 @@ static int rtcan_esd_pci_add_chan(struct pci_dev *pdev, int channel,
 	chip->ocr = ESD_PCI_OCR;
 	chip->cdr = ESD_PCI_CDR;
 
-	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+	strscpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 
 	chip->irq_flags = RTDM_IRQTYPE_SHARED;
 	chip->irq_num = pdev->irq;
diff --git a/kernel/drivers/can/sja1000/rtcan_isa.c b/kernel/drivers/can/sja1000/rtcan_isa.c
index 9c56b047ed4ff60462f535744db7629fc6dccc83..80b0b6a9e6fa6280b238a7a852d93c8fa88a4331 100644
--- a/kernel/drivers/can/sja1000/rtcan_isa.c
+++ b/kernel/drivers/can/sja1000/rtcan_isa.c
@@ -133,7 +133,7 @@ static int __init rtcan_isa_init_one(int idx)
 	else
 		chip->cdr = SJA_CDR_CAN_MODE | SJA_CDR_CLK_OFF | SJA_CDR_CBP;
 
-	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+	strscpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 
 	ret = rtcan_sja1000_register(dev);
 	if (ret) {
diff --git a/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c b/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
index ff91c6a121af92f06ab2fccc672fbdd780d9025e..69ff81550534e165cee33a30582e41f6310cc297 100644
--- a/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
@@ -169,7 +169,7 @@ static int rtcan_ixxat_pci_add_chan(struct pci_dev *pdev,
     /* Clock divider register */
     chip->cdr = SJA_CDR_CAN_MODE;
 
-    strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+    strscpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 
     /* Enable PCI interrupts */
     intcsr = inb(board->conf_addr + IXXAT_INTCSR_OFFSET);
diff --git a/kernel/drivers/can/sja1000/rtcan_mem.c b/kernel/drivers/can/sja1000/rtcan_mem.c
index 980eba9793d2ff4a998345335d1f993e54ff8fad..76626f74b47c461aca84b18f86108cd682278616 100644
--- a/kernel/drivers/can/sja1000/rtcan_mem.c
+++ b/kernel/drivers/can/sja1000/rtcan_mem.c
@@ -142,7 +142,7 @@ static int __init rtcan_mem_init_one(int idx)
 	else
 		chip->cdr = SJA_CDR_CAN_MODE | SJA_CDR_CLK_OFF | SJA_CDR_CBP;
 
-	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+	strscpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 
 	ret = rtcan_sja1000_register(dev);
 	if (ret) {
diff --git a/kernel/drivers/can/sja1000/rtcan_peak_dng.c b/kernel/drivers/can/sja1000/rtcan_peak_dng.c
index e201bf2adf3c415d8208477cd6132520a0986495..650c249edc4b0b3718487362c10a23403d866c7d 100644
--- a/kernel/drivers/can/sja1000/rtcan_peak_dng.c
+++ b/kernel/drivers/can/sja1000/rtcan_peak_dng.c
@@ -277,7 +277,7 @@ static int __init rtcan_peak_dng_init_one(int idx)
 
     sja->cdr = SJA_CDR_CAN_MODE;
 
-    strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+    strscpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 
     rtcan_peak_dng_enable(dev);
 
diff --git a/kernel/drivers/can/sja1000/rtcan_peak_pci.c b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
index dfae45a87a1a5df1a9ca69f44386b1c97e6945fd..d12c31775c1776ebd434ea98c8ea4722b27d9c28 100644
--- a/kernel/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
@@ -250,7 +250,7 @@ static int rtcan_peak_pci_add_chan(struct pci_dev *pdev, int channel,
     else
 	chip->cdr = PELICAN_SINGLE;
 
-    strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+    strscpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 
     /* Register and setup interrupt handling */
     chip->irq_flags = RTDM_IRQTYPE_SHARED;
diff --git a/kernel/drivers/can/sja1000/rtcan_plx_pci.c b/kernel/drivers/can/sja1000/rtcan_plx_pci.c
index 4da14f2cc5da016800bf7bda913e53b37268abbf..2caead6a47a2838e8d32e774872152ce77ec25c9 100644
--- a/kernel/drivers/can/sja1000/rtcan_plx_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_plx_pci.c
@@ -502,7 +502,7 @@ static int plx_pci_add_card(struct pci_dev *pdev,
 			goto failure_cleanup;
 		}
 
-		strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+		strscpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
 		dev->board_name = (char *)ci->name;
 
 		card->rtcan_dev[i] = dev;
diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index dad685eb7b8881312be1361052338bc1fe293daf..09df363ac2872bfb4ed03015c9b52eca71570b28 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -3801,7 +3801,7 @@ static void e1000_print_device_info(struct e1000_adapter *adapter)
 	ret_val = e1000_read_pba_string_generic(hw, pba_str,
 						E1000_PBANUM_LENGTH);
 	if (ret_val)
-		strncpy((char *)pba_str, "Unknown", sizeof(pba_str) - 1);
+		strscpy((char *)pba_str, "Unknown", sizeof(pba_str));
 	e_info("MAC: %d, PHY: %d, PBA No: %s\n",
 	       hw->mac.type, hw->phy.type, pba_str);
 }
@@ -3969,7 +3969,7 @@ static int e1000_probe(struct pci_dev *pdev,
 	//netdev->get_stats = e1000_get_stats;
 	netdev->map_rtskb = e1000_map_rtskb;
 	netdev->unmap_rtskb = e1000_unmap_rtskb;
-	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
 	netdev->mem_start = mmio_start;
 	netdev->mem_end = mmio_start + mmio_len;
@@ -4131,7 +4131,7 @@ static int e1000_probe(struct pci_dev *pdev,
 	if (!(adapter->flags & FLAG_HAS_AMT))
 		e1000e_get_hw_control(adapter);
 
-	strncpy(netdev->name, "rteth%d", sizeof(netdev->name) - 1);
+	strscpy(netdev->name, "rteth%d", sizeof(netdev->name));
 	err = rt_register_rtnetdev(netdev);
 	if (err)
 		goto err_register;
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c
index 4ead3b5791ee9c44ae617c639867d00f22ea90be..e22a5d25e012571f142ccefe7eebbc38ca548172 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c
@@ -627,8 +627,8 @@ static void e1000_get_drvinfo(struct net_device *netdev,
 	char firmware_version[32];
 	u16 eeprom_data;
 
-	strncpy(drvinfo->driver,  e1000_driver_name, 32);
-	strncpy(drvinfo->version, e1000_driver_version, 32);
+	strscpy(drvinfo->driver,  e1000_driver_name, 32);
+	strscpy(drvinfo->version, e1000_driver_version, 32);
 
 	/* EEPROM image version # is reported as firmware version # for
 	 * 8257{1|2|3} controllers */
@@ -649,8 +649,8 @@ static void e1000_get_drvinfo(struct net_device *netdev,
 		sprintf(firmware_version, "N/A");
 	}
 
-	strncpy(drvinfo->fw_version, firmware_version, 32);
-	strncpy(drvinfo->bus_info, pci_name(adapter->pdev), 32);
+	strscpy(drvinfo->fw_version, firmware_version, 32);
+	strscpy(drvinfo->bus_info, pci_name(adapter->pdev), 32);
 	drvinfo->n_stats = E1000_STATS_LEN;
 	drvinfo->testinfo_len = E1000_TEST_LEN;
 	drvinfo->regdump_len = e1000_get_regs_len(netdev);
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
index 071b6524433ecc165c3eb1a473800c6e6db9544a..315d5dc9d6804260e9e837e948a9858bcc681ea3 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
@@ -1139,7 +1139,7 @@ static int e1000_probe(struct pci_dev *pdev,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	netdev->poll_controller = e1000_netpoll;
 #endif
-	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
 	adapter->bd_number = cards_found;
 
diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index aedf526b63f8c7af78ed00bcd41a2b24367abf39..1e4f5f36af77118162afd38715e0818c98f6e82b 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -2073,7 +2073,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->watchdog_timeo = 5 * HZ;
 #endif
 
-	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
 	netdev->mem_start = pci_resource_start(pdev, 0);
 	netdev->mem_end = pci_resource_end(pdev, 0);
diff --git a/kernel/drivers/net/drivers/igc/igc_main.c b/kernel/drivers/net/drivers/igc/igc_main.c
index a3a6b711353b7acdac8c31287f6424baa34adb3e..10f6f72c235bd242eb2c00cca6e490aa51c270f3 100644
--- a/kernel/drivers/net/drivers/igc/igc_main.c
+++ b/kernel/drivers/net/drivers/igc/igc_main.c
@@ -3837,7 +3837,7 @@ static int igc_probe(struct pci_dev *pdev,
 	 */
 	igc_get_hw_control(adapter);
 
-	strncpy(netdev->name, "rteth%d", IFNAMSIZ);
+	strscpy(netdev->name, "rteth%d", IFNAMSIZ);
 	err = rt_register_rtnetdev(netdev);
 	if (err)
 		goto err_register;
diff --git a/kernel/drivers/net/stack/ipv4/route.c b/kernel/drivers/net/stack/ipv4/route.c
index 172eac3ec82bada81018ce04c4e115e7a3027553..ddcae72b5de85a92d72d187afd791aec61ca0825 100644
--- a/kernel/drivers/net/stack/ipv4/route.c
+++ b/kernel/drivers/net/stack/ipv4/route.c
@@ -702,7 +702,7 @@ int rt_ip_route_get_host(u32 addr, char *if_name, unsigned char *dev_addr,
 		     rt->dest_host.rtdev->local_ip == rtdev->local_ip)) {
 			memcpy(dev_addr, rt->dest_host.dev_addr,
 			       rt->dest_host.rtdev->addr_len);
-			strncpy(if_name, rt->dest_host.rtdev->name, IFNAMSIZ);
+			strscpy(if_name, rt->dest_host.rtdev->name, IFNAMSIZ);
 
 			rtdm_lock_put_irqrestore(&host_table_lock, context);
 			return 0;
diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/rtdev.c
index 9bf867e95e68ad5b5c85b2e39a3bf6a94c3aa0bb..cc112acf66c803c8647f5b277ad3a340654f13e5 100644
--- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -216,7 +216,7 @@ void rtdev_alloc_name(struct rtnet_device *rtdev, const char *mask)
 	for (i = 0; i < MAX_RT_DEVICES; i++) {
 		snprintf(buf, IFNAMSIZ, mask, i);
 		if ((tmp = rtdev_get_by_name(buf)) == NULL) {
-			strncpy(rtdev->name, buf, IFNAMSIZ);
+			strscpy(rtdev->name, buf, IFNAMSIZ);
 			break;
 		} else
 			rtdev_dereference(tmp);

-- 
2.55.0

