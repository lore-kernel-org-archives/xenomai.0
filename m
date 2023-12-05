Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B254EB2D
	for <xenomai@lists.linux.dev>; Tue,  5 Dec 2023 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="IS8tbGZ0"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20231205124141e4512215730a7197c8
        for <xenomai@lists.linux.dev>;
        Tue, 05 Dec 2023 13:41:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cW1Uhsyk4MiDbL+Kznp/o058FKp+zcl3fvmdyHdRjz0=;
 b=IS8tbGZ0VFGeqzhK5Ksg43blARgZemRME3k1MeHU1M5HN8unQRypuHyuYWTpfEM1RLcPSB
 IezV4T4cpH3SBblDWu3+0udz2uoNjMGyPTW6f1zXUnduZPJ2yISGhrG7jUwLooEndvS0icYx
 2oMxKigmM8CjHjr1+wj91tnFsqv5g=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 05 Dec 2023 13:41:41 +0100
Subject: [PATCH 04/13] kernel/drivers: Mirate to ARRAY_SIZE()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-flo-array-size-v1-4-3e0abd7c68fa@siemens.com>
References: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
In-Reply-To: <20231201-flo-array-size-v1-0-3e0abd7c68fa@siemens.com>
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Use ARRAY_SIZE() where possible. No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/analogy/national_instruments/mio_common.c          | 6 ++----
 kernel/drivers/analogy/national_instruments/ni_670x.c             | 2 +-
 kernel/drivers/analogy/national_instruments/ni_stc.h              | 4 ++--
 kernel/drivers/analogy/national_instruments/pcimio.c              | 2 +-
 kernel/drivers/net/drivers/experimental/e1000/e1000_80003es2lan.c | 3 +--
 kernel/drivers/net/drivers/experimental/e1000/e1000_82541.c       | 3 +--
 kernel/drivers/net/drivers/experimental/e1000/e1000_phy.c         | 6 ++----
 kernel/drivers/net/drivers/igb/e1000_phy.c                        | 6 ++----
 8 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/kernel/drivers/analogy/national_instruments/mio_common.c b/kernel/drivers/analogy/national_instruments/mio_common.c
index 82b1da525..92f403d7b 100644
--- a/kernel/drivers/analogy/national_instruments/mio_common.c
+++ b/kernel/drivers/analogy/national_instruments/mio_common.c
@@ -1212,8 +1212,7 @@ static void ni_ai_fifo_read(struct a4l_subdevice *subd, int n)
 			a4l_buf_put(subd, &data[0], sizeof(sampl_t));
 		}
 	} else {
-		if (n > sizeof(devpriv->ai_fifo_buffer) /
-		    sizeof(devpriv->ai_fifo_buffer[0])) {
+		if (n > ARRAY_SIZE(devpriv->ai_fifo_buffer)) {
 			a4l_err(dev,
 				"ni_ai_fifo_read: "
 				"bug! ai_fifo_buffer too small");
@@ -1325,8 +1324,7 @@ static void ni_handle_fifo_dregs(struct a4l_subdevice *subd)
 		while (fifo_empty == 0) {
 			for (i = 0;
 			     i <
-				     sizeof(devpriv->ai_fifo_buffer) /
-				     sizeof(devpriv->ai_fifo_buffer[0]); i++) {
+				     ARRAY_SIZE(devpriv->ai_fifo_buffer); i++) {
 				fifo_empty =
 					devpriv->stc_readw(dev,
 							   AI_Status_1_Register) &
diff --git a/kernel/drivers/analogy/national_instruments/ni_670x.c b/kernel/drivers/analogy/national_instruments/ni_670x.c
index 35749be69..597e2dd2b 100644
--- a/kernel/drivers/analogy/national_instruments/ni_670x.c
+++ b/kernel/drivers/analogy/national_instruments/ni_670x.c
@@ -212,7 +212,7 @@ static const struct ni_670x_board ni_670x_boards[] = {
 	 },
 };
 
-#define n_ni_670x_boards ((sizeof(ni_670x_boards)/sizeof(ni_670x_boards[0])))
+#define n_ni_670x_boards	ARRAY_SIZE(ni_670x_boards)
 
 static const struct pci_device_id ni_670x_pci_table[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_NI, 0x2c90)},
diff --git a/kernel/drivers/analogy/national_instruments/ni_stc.h b/kernel/drivers/analogy/national_instruments/ni_stc.h
index d600a3204..85fd86f18 100644
--- a/kernel/drivers/analogy/national_instruments/ni_stc.h
+++ b/kernel/drivers/analogy/national_instruments/ni_stc.h
@@ -1027,7 +1027,7 @@ static inline int M_Offset_Static_AI_Control(int i)
 		0x262,
 		0x263,
 	};
-	if(((unsigned)i) >= sizeof(offset) / sizeof(offset[0]))
+	if(((unsigned)i) >= ARRAY_SIZE(offset))
 	{
 		rtdm_printk("%s: invalid channel=%i\n", __FUNCTION__, i);
 		return offset[0];
@@ -1043,7 +1043,7 @@ static inline int M_Offset_AO_Reference_Attenuation(int channel)
 		0x266,
 		0x267
 	};
-	if(((unsigned)channel) >= sizeof(offset) / sizeof(offset[0]))
+	if(((unsigned)channel) >= ARRAY_SIZE(offset))
 	{
 		rtdm_printk("%s: invalid channel=%i\n", __FUNCTION__, channel);
 		return offset[0];
diff --git a/kernel/drivers/analogy/national_instruments/pcimio.c b/kernel/drivers/analogy/national_instruments/pcimio.c
index 8a3cccc81..40ca8f76d 100644
--- a/kernel/drivers/analogy/national_instruments/pcimio.c
+++ b/kernel/drivers/analogy/national_instruments/pcimio.c
@@ -1104,7 +1104,7 @@ static ni_board ni_boards[]={
 		.caldac = {ad8804_debug,ad8804_debug},
 	},
 };
-#define n_pcimio_boards ((sizeof(ni_boards)/sizeof(ni_boards[0])))
+#define n_pcimio_boards	ARRAY_SIZE(ni_boards)
 
 /* How we access STC registers */
 
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_80003es2lan.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_80003es2lan.c
index 2ef70d67d..e8e2f1de4 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_80003es2lan.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_80003es2lan.c
@@ -73,8 +73,7 @@ static void e1000_power_down_phy_copper_80003es2lan(struct e1000_hw *hw);
 static const u16 e1000_gg82563_cable_length_table[] =
          { 0, 60, 115, 150, 150, 60, 115, 150, 180, 180, 0xFF };
 #define GG82563_CABLE_LENGTH_TABLE_SIZE \
-                (sizeof(e1000_gg82563_cable_length_table) / \
-                 sizeof(e1000_gg82563_cable_length_table[0]))
+	ARRAY_SIZE(e1000_gg82563_cable_length_table)
 
 /**
  *  e1000_init_phy_params_80003es2lan - Init ESB2 PHY func ptrs.
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_82541.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_82541.c
index a0d5c8801..5103dbefa 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_82541.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_82541.c
@@ -66,8 +66,7 @@ static const u16 e1000_igp_cable_length_table[] =
       100, 100, 100, 100, 110, 110, 110, 110, 110, 110, 110, 110, 110, 110, 110, 110,
       110, 110, 110, 110, 110, 110, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120};
 #define IGP01E1000_AGC_LENGTH_TABLE_SIZE \
-                (sizeof(e1000_igp_cable_length_table) / \
-                 sizeof(e1000_igp_cable_length_table[0]))
+	ARRAY_SIZE(e1000_igp_cable_length_table)
 
 struct e1000_dev_spec_82541 {
 	e1000_dsp_config dsp_config;
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_phy.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_phy.c
index cec2ba360..0c7913d6e 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_phy.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_phy.c
@@ -37,8 +37,7 @@ static s32  e1000_acquire_phy(struct e1000_hw *hw);
 static const u16 e1000_m88_cable_length_table[] =
 	{ 0, 50, 80, 110, 140, 140, E1000_CABLE_LENGTH_UNDEFINED };
 #define M88E1000_CABLE_LENGTH_TABLE_SIZE \
-                (sizeof(e1000_m88_cable_length_table) / \
-                 sizeof(e1000_m88_cable_length_table[0]))
+	ARRAY_SIZE(e1000_m88_cable_length_table)
 
 static const u16 e1000_igp_2_cable_length_table[] =
     { 0, 0, 0, 0, 0, 0, 0, 0, 3, 5, 8, 11, 13, 16, 18, 21,
@@ -50,8 +49,7 @@ static const u16 e1000_igp_2_cable_length_table[] =
       83, 89, 95, 100, 105, 109, 113, 116, 119, 122, 124,
       104, 109, 114, 118, 121, 124};
 #define IGP02E1000_CABLE_LENGTH_TABLE_SIZE \
-                (sizeof(e1000_igp_2_cable_length_table) / \
-                 sizeof(e1000_igp_2_cable_length_table[0]))
+	ARRAY_SIZE(e1000_igp_2_cable_length_table)
 
 /**
  *  e1000_check_reset_block_generic - Check if PHY reset is blocked
diff --git a/kernel/drivers/net/drivers/igb/e1000_phy.c b/kernel/drivers/net/drivers/igb/e1000_phy.c
index 8d740899c..fb069b0a7 100644
--- a/kernel/drivers/net/drivers/igb/e1000_phy.c
+++ b/kernel/drivers/net/drivers/igb/e1000_phy.c
@@ -38,8 +38,7 @@ static s32  igb_set_master_slave_mode(struct e1000_hw *hw);
 static const u16 e1000_m88_cable_length_table[] = {
 	0, 50, 80, 110, 140, 140, E1000_CABLE_LENGTH_UNDEFINED };
 #define M88E1000_CABLE_LENGTH_TABLE_SIZE \
-	(sizeof(e1000_m88_cable_length_table) / \
-	sizeof(e1000_m88_cable_length_table[0]))
+	ARRAY_SIZE(e1000_m88_cable_length_table)
 
 static const u16 e1000_igp_2_cable_length_table[] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 3, 5, 8, 11, 13, 16, 18, 21,
@@ -51,8 +50,7 @@ static const u16 e1000_igp_2_cable_length_table[] = {
 	83, 89, 95, 100, 105, 109, 113, 116, 119, 122, 124,
 	104, 109, 114, 118, 121, 124};
 #define IGP02E1000_CABLE_LENGTH_TABLE_SIZE \
-	(sizeof(e1000_igp_2_cable_length_table) / \
-	 sizeof(e1000_igp_2_cable_length_table[0]))
+	ARRAY_SIZE(e1000_igp_2_cable_length_table)
 
 /**
  *  igb_check_reset_block - Check if PHY reset is blocked

-- 
2.39.2

