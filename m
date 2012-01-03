Message-ID: <4F02C0A8.5020908@domain.hid>
Date: Tue, 03 Jan 2012 09:47:36 +0100
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
MIME-Version: 1.0
References: <4EF1C18C.3020407@domain.hid> <4EF8B4E8.8060003@domain.hid>
In-Reply-To: <4EF8B4E8.8060003@domain.hid>
Content-Type: multipart/mixed; boundary="------------020706090204000409090709"
Subject: Re: [Xenomai-help] Xenomai rtcan build issue on MPC5121 (kernel >=
 2.6.35)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020706090204000409090709
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Gilles,

please find attached a properly formatted patch using git (hope so).

Fabrice

> It is not OK, your patch fails to apply. But if you send a properly
> formatted patch, it will be applied. If you do not know how to properly
> format a patch, use "git format-patch".
>

--------------020706090204000409090709
Content-Type: text/x-patch;
 name="0001-mpc5121-can-adapt-to-platform-driver-infrastructure-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-mpc5121-can-adapt-to-platform-driver-infrastructure-.pa";
 filename*1="tch"

>From 735c80009228d66a77126dd989008a6ca9b1d6b4 Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@domain.hid>
Date: Tue, 3 Jan 2012 09:28:40 +0100
Subject: [PATCH] mpc5121 can: adapt to platform driver infrastructure changes for 2.6.35

---
 ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c b/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
index 82aea37..e65e0c2 100644
--- a/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
+++ b/ksrc/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
@@ -155,7 +155,7 @@ static u32 __devinit mpc512x_can_get_clock(struct of_device *ofdev,
 	}
 
 	/* Determine the MSCAN device index from the physical address */
-	pval = of_get_property(ofdev->node, "reg", &plen);
+	pval = of_get_property(mpc5xxx_get_of_node(ofdev), "reg", &plen);
 	BUG_ON(!pval || plen < sizeof(*pval));
 	clockidx = (*pval & 0x80) ? 1 : 0;
 	if (*pval & 0x2000)
@@ -171,11 +171,11 @@ static u32 __devinit mpc512x_can_get_clock(struct of_device *ofdev,
 	 */
 	if (clock_name && !strcmp(clock_name, "ip")) {
 		*mscan_clksrc = MSCAN_CLKSRC_IPS;
-		freq = mpc5xxx_get_bus_frequency(ofdev->node);
+		freq = mpc5xxx_get_bus_frequency(mpc5xxx_get_of_node(ofdev));
 	} else {
 		*mscan_clksrc = MSCAN_CLKSRC_BUS;
 
-		pval = of_get_property(ofdev->node,
+		pval = of_get_property(mpc5xxx_get_of_node(ofdev),
 				       "fsl,mscan-clock-divider", &plen);
 		if (pval && plen == sizeof(*pval))
 			clockdiv = *pval;
-- 
1.7.0.4


--------------020706090204000409090709--

