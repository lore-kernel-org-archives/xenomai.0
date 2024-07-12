Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C8F7EF09
	for <xenomai@lists.linux.dev>; Fri, 12 Jul 2024 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720781339; cv=none; b=CaEJ3tjdYGpEzyQwWK63LfJfuBI/PLGOeP2e2W8N+5vZjsXwbUZdbgvuPPYer0KmutWUGrJHaRZ+SlVE4EUY/y8xcerKlUZFpsSO/5woIGcfF36oDMuv1cRiB+cssQyn5MArcHXScQOV2W2C0nfgbMQacP9Y+F3bRx9JNqUPLGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720781339; c=relaxed/simple;
	bh=qniHzkza0fCG2OIees8TJEeAO0j8jCa35kiurtXBh8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=optI2N7eUtNiPmgOhHMUbm8ggvDcwF5fSsEnVMM45qxpEO2gN4H7gnMM4GIWIVZKkrsVLjZGgwJSI3jitzGPHgli4gMJQ1F94QS5OfuHboH2F+5d19UvTeHocz+sTGxmbxNwjSQnWyQfnYJj3QJ9LXDFRoZth5vsEqqIXNw/nVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=t8kzFCNv; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="t8kzFCNv"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240712104850c3f320513d09f10986
        for <xenomai@lists.linux.dev>;
        Fri, 12 Jul 2024 12:48:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kIqzaZLvxIExFjfJ+Ac3oZTBQ5z8KJ28hkEx3oIPGGg=;
 b=t8kzFCNv2+RiTnnDUX0tl+yBPcsUGBa/WvaK38flGo2r33dHDM/6y/3xzBGkubNf5SJPHq
 ZWk8oNiX97WbcfWh+AFpySg5eYew+RLWghQxzdwUzN1HIpSYp6l9BijOPpNjMAAZaQBMXFGA
 j/VpGwzSRuJ+Q/sysd2IrqZumIFKY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Fri, 12 Jul 2024 12:48:49 +0200
Subject: [PATCH v2 03/33] drivers/analogy: Migrate from rtdm_printk() and
 printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v2-3-facd992606c7@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v2-0-facd992606c7@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

There were a lot of (rtdm_)printk() calls with missing log level
information. The default level (= warn) does not fit well for most of
them.

Adding log levels is addressed by migrating to the pr_*() API.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h  | 16 +++---
 .../analogy/national_instruments/mio_common.c      |  3 +
 kernel/drivers/analogy/national_instruments/mite.c | 67 +++++++++++-----------
 .../drivers/analogy/national_instruments/ni_660x.c |  2 +
 .../drivers/analogy/national_instruments/ni_mio.h  |  2 +-
 .../drivers/analogy/national_instruments/ni_stc.h  | 19 +++---
 .../drivers/analogy/national_instruments/pcimio.c  | 21 +++----
 7 files changed, 68 insertions(+), 62 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h b/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
index 1de219f96..2adcb15b5 100644
--- a/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
+++ b/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
@@ -35,14 +35,14 @@
 
 #define RTDM_SUBCLASS_ANALOGY 0
 
-#define __a4l_err(fmt, args...)  rtdm_printk(KERN_ERR A4L_PROMPT fmt, ##args)
-#define __a4l_warn(fmt, args...) rtdm_printk(KERN_WARNING A4L_PROMPT fmt, ##args)
+#define __a4l_err(fmt, args...)  pr_err(A4L_PROMPT fmt, ##args)
+#define __a4l_warn(fmt, args...) pr_warn(A4L_PROMPT fmt, ##args)
 
 #ifdef  CONFIG_XENO_DRIVERS_ANALOGY_DEBUG_FTRACE
 #define __a4l_info(fmt, args...) trace_printk(fmt, ##args)
 #else
-#define __a4l_info(fmt, args...) 						\
-        rtdm_printk(KERN_INFO A4L_PROMPT "%s: " fmt, __FUNCTION__, ##args)
+#define __a4l_info(fmt, args...) \
+	pr_info(A4L_PROMPT "%s: " fmt, __FUNCTION__, ##args)
 #endif
 
 #ifdef CONFIG_XENO_DRIVERS_ANALOGY_DEBUG
@@ -53,10 +53,10 @@
 		trace_printk(fmt, ##args); 				\
 	} while (0)
 #else
-#define __a4l_dbg(level, debug, fmt, args...)						\
-	do {										\
-	if ((debug) >= (level))								\
-		rtdm_printk(KERN_DEBUG A4L_PROMPT "%s: " fmt, __FUNCTION__ , ##args);	\
+#define __a4l_dbg(level, debug, fmt, args...)                                  \
+	do {                                                                   \
+		if ((debug) >= (level))                                        \
+			pr_debug(A4L_PROMPT "%s: " fmt, __FUNCTION__, ##args); \
 	} while (0)
 #endif
 
diff --git a/kernel/drivers/analogy/national_instruments/mio_common.c b/kernel/drivers/analogy/national_instruments/mio_common.c
index 7cd57ecf2..ae9af547a 100644
--- a/kernel/drivers/analogy/national_instruments/mio_common.c
+++ b/kernel/drivers/analogy/national_instruments/mio_common.c
@@ -42,6 +42,9 @@
  *   as yet. Terry Barnaby, BEAM Ltd.
  *
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/slab.h>
 #include "../intel/8255.h"
diff --git a/kernel/drivers/analogy/national_instruments/mite.c b/kernel/drivers/analogy/national_instruments/mite.c
index 2f2014bcd..09896a3e2 100644
--- a/kernel/drivers/analogy/national_instruments/mite.c
+++ b/kernel/drivers/analogy/national_instruments/mite.c
@@ -41,11 +41,13 @@
  * ISSUES:
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include "mite.h"
 
 #ifdef CONFIG_DEBUG_MITE
-#define MDPRINTK(fmt, args...) rtdm_printk(fmt, ##args)
+#define MDPRINTK(fmt, args...) pr_debug(fmt, ##args)
 #else /* !CONFIG_DEBUG_MITE */
 #define MDPRINTK(fmt, args...)
 #endif /* CONFIG_DEBUG_MITE */
@@ -254,17 +256,14 @@ void a4l_mite_list_devices(void)
 {
 	struct list_head *this;
 
-	printk("Analogy: MITE: Available NI device IDs:");
+	pr_info("Analogy: MITE: Available NI device IDs:\n");
 	list_for_each(this, &mite_devices) {
 		struct mite_struct *mite =
 			list_entry(this, struct mite_struct, list);
 
-		printk(" 0x%04x", mite_device_id(mite));
-		if(mite->used)
-			printk("(used)");
+		pr_info(" 0x%04x%s\n", mite_device_id(mite),
+			mite->used ? " (used)" : "");
 	}
-
-	printk("\n");
 }
 
 
@@ -399,7 +398,7 @@ int a4l_mite_buf_change(struct mite_dma_descriptor_ring *ring, struct a4l_subdev
 				   n_links * sizeof(struct mite_dma_descriptor),
 				   &ring->descriptors_dma_addr, GFP_ATOMIC);
 	if (!ring->descriptors) {
-		printk("MITE: ring buffer allocation failed\n");
+		pr_err("MITE: ring buffer allocation failed\n");
 		return -ENOMEM;
 	}
 	ring->n_links = n_links;
@@ -716,63 +715,61 @@ void a4l_mite_dump_regs(struct mite_channel *mite_chan)
 	unsigned long addr = 0;
 	unsigned long temp = 0;
 
-	printk("a4l_mite_dump_regs ch%i\n", mite_chan->channel);
-	printk("mite address is  =0x%08lx\n", mite_io_addr);
+	pr_info("a4l_mite_dump_regs ch%i\n", mite_chan->channel);
+	pr_info("mite address is  =0x%08lx\n", mite_io_addr);
 
 	addr = mite_io_addr + MITE_CHOR(mite_chan->channel);
-	printk("mite status[CHOR]at 0x%08lx =0x%08lx\n", addr, temp =
-	       readl((void *)addr));
+	pr_info("mite status[CHOR]at 0x%08lx =0x%08lx\n", addr,
+		temp = readl((void *)addr));
 	a4l_mite_decode(mite_CHOR_strings, temp);
 	addr = mite_io_addr + MITE_CHCR(mite_chan->channel);
-	printk("mite status[CHCR]at 0x%08lx =0x%08lx\n", addr, temp =
-	       readl((void *)addr));
+	pr_info("mite status[CHCR]at 0x%08lx =0x%08lx\n", addr,
+		temp = readl((void *)addr));
 	a4l_mite_decode(mite_CHCR_strings, temp);
 	addr = mite_io_addr + MITE_TCR(mite_chan->channel);
-	printk("mite status[TCR] at 0x%08lx =0x%08x\n", addr,
-	       readl((void *)addr));
+	pr_info("mite status[TCR] at 0x%08lx =0x%08x\n", addr,
+		readl((void *)addr));
 	addr = mite_io_addr + MITE_MCR(mite_chan->channel);
-	printk("mite status[MCR] at 0x%08lx =0x%08lx\n", addr, temp =
-	       readl((void *)addr));
+	pr_info("mite status[MCR] at 0x%08lx =0x%08lx\n", addr,
+		temp = readl((void *)addr));
 	a4l_mite_decode(mite_MCR_strings, temp);
 
 	addr = mite_io_addr + MITE_MAR(mite_chan->channel);
-	printk("mite status[MAR] at 0x%08lx =0x%08x\n", addr,
-	       readl((void *)addr));
+	pr_info("mite status[MAR] at 0x%08lx =0x%08x\n", addr,
+		readl((void *)addr));
 	addr = mite_io_addr + MITE_DCR(mite_chan->channel);
-	printk("mite status[DCR] at 0x%08lx =0x%08lx\n", addr, temp =
-	       readl((void *)addr));
+	pr_info("mite status[DCR] at 0x%08lx =0x%08lx\n", addr,
+		temp = readl((void *)addr));
 	a4l_mite_decode(mite_DCR_strings, temp);
 	addr = mite_io_addr + MITE_DAR(mite_chan->channel);
-	printk("mite status[DAR] at 0x%08lx =0x%08x\n", addr,
-	       readl((void *)addr));
+	pr_info("mite status[DAR] at 0x%08lx =0x%08x\n", addr,
+		readl((void *)addr));
 	addr = mite_io_addr + MITE_LKCR(mite_chan->channel);
-	printk("mite status[LKCR]at 0x%08lx =0x%08lx\n", addr, temp =
-	       readl((void *)addr));
+	pr_info("mite status[LKCR]at 0x%08lx =0x%08lx\n", addr,
+		temp = readl((void *)addr));
 	a4l_mite_decode(mite_LKCR_strings, temp);
 	addr = mite_io_addr + MITE_LKAR(mite_chan->channel);
-	printk("mite status[LKAR]at 0x%08lx =0x%08x\n", addr,
-	       readl((void *)addr));
+	pr_info("mite status[LKAR]at 0x%08lx =0x%08x\n", addr,
+		readl((void *)addr));
 
 	addr = mite_io_addr + MITE_CHSR(mite_chan->channel);
-	printk("mite status[CHSR]at 0x%08lx =0x%08lx\n", addr, temp =
-	       readl((void *)addr));
+	pr_info("mite status[CHSR]at 0x%08lx =0x%08lx\n", addr,
+		temp = readl((void *)addr));
 	a4l_mite_decode(mite_CHSR_strings, temp);
 	addr = mite_io_addr + MITE_FCR(mite_chan->channel);
-	printk("mite status[FCR] at 0x%08lx =0x%08x\n\n", addr,
-	       readl((void *)addr));
+	pr_info("mite status[FCR] at 0x%08lx =0x%08x\n\n", addr,
+		readl((void *)addr));
 }
 
-
 static void a4l_mite_decode(const char *const bit_str[], unsigned int bits)
 {
 	int i;
 
 	for (i = 31; i >= 0; i--) {
 		if (bits & (1 << i)) {
-			printk(" %s", bit_str[i]);
+			pr_info(" %s\n", bit_str[i]);
 		}
 	}
-	printk("\n");
 }
 
 #endif /* CONFIG_DEBUG_MITE */
diff --git a/kernel/drivers/analogy/national_instruments/ni_660x.c b/kernel/drivers/analogy/national_instruments/ni_660x.c
index eeac4b402..73a4891e9 100644
--- a/kernel/drivers/analogy/national_instruments/ni_660x.c
+++ b/kernel/drivers/analogy/national_instruments/ni_660x.c
@@ -45,6 +45,8 @@
  *   Julien Delange <julien.delange@esa.int>
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/interrupt.h>
 
 #include <linux/module.h>
diff --git a/kernel/drivers/analogy/national_instruments/ni_mio.h b/kernel/drivers/analogy/national_instruments/ni_mio.h
index 7fee167f9..97068897e 100644
--- a/kernel/drivers/analogy/national_instruments/ni_mio.h
+++ b/kernel/drivers/analogy/national_instruments/ni_mio.h
@@ -22,7 +22,7 @@
 /* Debug stuff */
 
 #ifdef CONFIG_DEBUG_MIO
-#define MDPRINTK(fmt, args...) rtdm_printk(format, ##args)
+#define MDPRINTK(fmt, args...) pr_debug(fmt, ##args)
 #else /* !CONFIG_DEBUG_MIO */
 #define MDPRINTK(fmt, args...)
 #endif /* CONFIG_DEBUG_MIO */
diff --git a/kernel/drivers/analogy/national_instruments/ni_stc.h b/kernel/drivers/analogy/national_instruments/ni_stc.h
index 85fd86f18..f774af3f5 100644
--- a/kernel/drivers/analogy/national_instruments/ni_stc.h
+++ b/kernel/drivers/analogy/national_instruments/ni_stc.h
@@ -327,8 +327,8 @@ static inline unsigned int RTSI_Output_Bit(unsigned channel, int is_mseries)
 	}
 	if(channel > max_channel)
 	{
-		rtdm_printk("%s: bug, invalid RTSI_channel=%i\n",
-			    __FUNCTION__, channel);
+		pr_err("%s: bug, invalid RTSI_channel=%i\n", __FUNCTION__,
+		       channel);
 		return 0;
 	}
 	return 1 << (base_bit_shift + channel);
@@ -1029,7 +1029,7 @@ static inline int M_Offset_Static_AI_Control(int i)
 	};
 	if(((unsigned)i) >= ARRAY_SIZE(offset))
 	{
-		rtdm_printk("%s: invalid channel=%i\n", __FUNCTION__, i);
+		pr_err("%s: invalid channel=%i\n", __FUNCTION__, i);
 		return offset[0];
 	}
 	return offset[i];
@@ -1045,7 +1045,7 @@ static inline int M_Offset_AO_Reference_Attenuation(int channel)
 	};
 	if(((unsigned)channel) >= ARRAY_SIZE(offset))
 	{
-		rtdm_printk("%s: invalid channel=%i\n", __FUNCTION__, channel);
+		pr_err("%s: invalid channel=%i\n", __FUNCTION__, channel);
 		return offset[0];
 	}
 	return offset[channel];
@@ -1054,7 +1054,8 @@ static inline unsigned M_Offset_PFI_Output_Select(unsigned n)
 {
 	if(n < 1 || n > NUM_PFI_OUTPUT_SELECT_REGS)
 	{
-		rtdm_printk("%s: invalid pfi output select register=%i\n", __FUNCTION__, n);
+		pr_err("%s: invalid pfi output select register=%i\n",
+		       __FUNCTION__, n);
 		return M_Offset_PFI_Output_Select_1;
 	}
 	return M_Offset_PFI_Output_Select_1 + (n - 1) * 2;
@@ -1102,7 +1103,8 @@ unsigned int MSeries_PLL_In_Source_Select_RTSI_Bits(unsigned int RTSI_channel)
 {
 	if(RTSI_channel > 7)
 	{
-		rtdm_printk("%s: bug, invalid RTSI_channel=%i\n", __FUNCTION__, RTSI_channel);
+		pr_err("%s: bug, invalid RTSI_channel=%i\n", __FUNCTION__,
+		       RTSI_channel);
 		return 0;
 	}
 	if(RTSI_channel == 7) return MSeries_PLL_In_Source_Select_RTSI7_Bits;
@@ -1121,7 +1123,7 @@ unsigned int MSeries_PLL_Divisor_Bits(unsigned int divisor)
 	static const unsigned int max_divisor = 0x10;
 	if(divisor < 1 || divisor > max_divisor)
 	{
-		rtdm_printk("%s: bug, invalid divisor=%i\n", __FUNCTION__, divisor);
+		pr_err("%s: bug, invalid divisor=%i\n", __FUNCTION__, divisor);
 		return 0;
 	}
 	return (divisor & 0xf) << 8;
@@ -1132,7 +1134,8 @@ unsigned int MSeries_PLL_Multiplier_Bits(unsigned int multiplier)
 	static const unsigned int max_multiplier = 0x100;
 	if(multiplier < 1 || multiplier > max_multiplier)
 	{
-		rtdm_printk("%s: bug, invalid multiplier=%i\n", __FUNCTION__, multiplier);
+		pr_err("%s: bug, invalid multiplier=%i\n", __FUNCTION__,
+		       multiplier);
 		return 0;
 	}
 	return multiplier & 0xff;
diff --git a/kernel/drivers/analogy/national_instruments/pcimio.c b/kernel/drivers/analogy/national_instruments/pcimio.c
index 40ca8f76d..687d9d465 100644
--- a/kernel/drivers/analogy/national_instruments/pcimio.c
+++ b/kernel/drivers/analogy/national_instruments/pcimio.c
@@ -80,6 +80,8 @@
  *
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <rtdm/analogy/device.h>
 
@@ -1224,7 +1226,7 @@ static void m_series_stc_writew(struct a4l_device *dev, uint16_t data, int reg)
 		offset = M_Offset_AO_FIFO_Clear;
 		break;
 	case DIO_Control_Register:
-		rtdm_printk("%s: FIXME: register 0x%x does not map cleanly on to m-series boards.\n", __FUNCTION__, reg);
+		pr_warn("%s: FIXME: register 0x%x does not map cleanly on to m-series boards.\n", __FUNCTION__, reg);
 		return;
 		break;
 	case G_Autoincrement_Register(0):
@@ -1285,8 +1287,8 @@ static void m_series_stc_writew(struct a4l_device *dev, uint16_t data, int reg)
 		by M_Offset_Static_Digital_Output (32 bit) and
 		M_Offset_SCXI_Serial_Data_Out (8 bit) */
 	default:
-		rtdm_printk("%s: bug! unhandled register=0x%x in switch.\n",
-			    __FUNCTION__, reg);
+		pr_err("%s: bug! unhandled register=0x%x in switch.\n",
+		       __FUNCTION__, reg);
 		BUG();
 		return;
 	}
@@ -1320,9 +1322,8 @@ static uint16_t m_series_stc_readw(struct a4l_device *dev, int reg)
 		offset = M_Offset_G01_Status;
 		break;
 	default:
-		rtdm_printk("%s: bug! "
-			    "unhandled register=0x%x in switch.\n",
-			    __FUNCTION__, reg);
+		pr_err("%s: bug! unhandled register=0x%x in switch.\n",
+		       __FUNCTION__, reg);
 		BUG();
 		return 0;
 		break;
@@ -1364,8 +1365,8 @@ static void m_series_stc_writel(struct a4l_device *dev, uint32_t data, int reg)
 		offset = M_Offset_G1_Load_B;
 		break;
 	default:
-		rtdm_printk("%s: bug! unhandled register=0x%x in switch.\n",
-			    __FUNCTION__, reg);
+		pr_err("%s: bug! unhandled register=0x%x in switch.\n",
+		       __FUNCTION__, reg);
 		BUG();
 		return;
 	}
@@ -1390,8 +1391,8 @@ static uint32_t m_series_stc_readl(struct a4l_device *dev, int reg)
 		offset = M_Offset_G1_Save;
 		break;
 	default:
-		rtdm_printk("%s: bug! unhandled register=0x%x in switch.\n",
-			    __FUNCTION__, reg);
+		pr_err("%s: bug! unhandled register=0x%x in switch.\n",
+		       __FUNCTION__, reg);
 		BUG();
 		return 0;
 	}

-- 
2.39.2

