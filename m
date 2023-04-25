Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2110.outbound.protection.outlook.com [40.107.22.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B007B
	for <xenomai@lists.linux.dev>; Tue, 25 Apr 2023 09:08:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm590xZtAB4CdyvmbPpsw/mnFvGyIwBNK2wEP8+Lv2ZgTnlmo4SNX9DCBzQJQg2Woy+t2d+zAyJ+EdQxp16bECA4kFsaTElcDYT6XUv/SevR6eDlPzmzl1sfF0BnV0IHdolPRS4rYmjnvUhZg5ojzhdMDVa3Iiq5mDzDS81sFhDlVMOzp7HQh3mMOANcyy/kD+GAk7oy85bug/3H6/PEO1HlDECeyw84Lpe9nqfAZ2HC+6Yvt6igkFaowj/0z5BZCJB7TBfdeGkrLuC4CV9ekfE+0IZU0MBWloKaZ8+W31IuYeqzdhP9kG2tW50wltfHfs4UZGQocoSkCOiB98EXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpQex+HUYdEfUiamZnVIp+EA+seuLGNq/f0nZiOjpP8=;
 b=As9KznF0TTiUKfQ8/Cwm6NkmHeg2yLD7QzO42AK5vu8lCTHQmtxpn8mn0j+6CiB79Eg5/I4yga5J4BlU5nOAh4La5Wd/mdKdph/nJrbRfti1/ZyznhI7DfRGm02Ou/vYiwdKBY67hjP9guh0poqzr/ES5eRum9vpUqi8eWumfk4uDWVFRACG1dudhQ3gtt7ksu142+tbMHm+M70Qa1dmMQeUAMEjXGIsLSBXlUArAEb7nbQr+y2782RA47vJuC1mb4bKBr5l8XJHQDz3EX0kJ87sTM6husCNxoTuw2PICpffDQVL2JtAheZLwODtyzv2xj2Ftemfwm5VpnL/g0EeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=lists.linux.dev
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpQex+HUYdEfUiamZnVIp+EA+seuLGNq/f0nZiOjpP8=;
 b=VjbMKkJbSFh2Ss5+1L1mmNRtZBSOnYGI9/Zg3dBF0tCfkmLpMwoK8Zaz5Nmfgxul8Of+C1c7eqIPy4WBS56PEETWbon2T4S6hmri+Rdz+XsxVUGvE+IkG8t7MOk8Nuf1m8LdJcTUXauHQGUq092rrjRFn5Z+NHfal0P/lDQDK6s=
Received: from AM6P194CA0015.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::28)
 by AM6P122MB0136.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 09:08:55 +0000
Received: from VE1EUR01FT093.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:90:cafe::5e) by AM6P194CA0015.outlook.office365.com
 (2603:10a6:209:90::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Tue, 25 Apr 2023 09:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 VE1EUR01FT093.mail.protection.outlook.com (10.152.3.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20 via Frontend Transport; Tue, 25 Apr 2023 09:08:55 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
	(Client did not present a certificate)
	by ext-eur1.smtp.philips.com with ESMTP
	id r9sRpQA0cV2YQrEfPppLkH; Tue, 25 Apr 2023 11:08:55 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
	by smtprelay-eur1.philips.com with ESMTP
	id rEfPpPOq7SwYErEfPplYC0; Tue, 25 Apr 2023 11:08:55 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xbm1.bbl.ms.philips.com (bbl2xbm1.bbl.ms.philips.com [130.143.220.186])
	by mail.bbl.ms.philips.com (Postfix) with ESMTP id 385EC184756
	for <xenomai@lists.linux.dev>; Tue, 25 Apr 2023 11:08:55 +0200 (CEST)
Received: by bbl2xbm1.bbl.ms.philips.com (Postfix, from userid 1992)
	id 2F34275801DB; Tue, 25 Apr 2023 11:08:55 +0200 (CEST)
From: Gunter Grau <guntgrau@bbl.ms.philips.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH 1/1] rtnet_fec: Get build working with linux 6.3
Date: Tue, 25 Apr 2023 11:08:55 +0200
Message-Id: <20230425090855.883471-2-guntgrau@bbl.ms.philips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230425090855.883471-1-guntgrau@bbl.ms.philips.com>
References: <dd9c6665-ca22-b93c-c68b-75ce825119f3@siemens.com>
 <20230425090855.883471-1-guntgrau@bbl.ms.philips.com>
Reply-To: Gunter Grau <gunter.grau@philips.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT093:EE_|AM6P122MB0136:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2ce8646b-32f9-4e98-13fc-08db456cb271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gvu524SHg0Z0DSKlRiuSZkesOQAVtIndJt9gmzAz/6kG3hGc4haaCAe4NO3On2LfmAMD7B6ZJBy7uLFWNlmgZfFuXjRZazhLLb5UaZHJQkdt33VswyLA6ma/EyGm0EQZIXUx9PbSvEL3JGSRB3I78MeZtODbja0ZwLVJVAcQen2Chi9o6tq29qUzqFK7V/10OnWAgGh0FYTQkRjOmLUXUg+pRzHvLW7JIwABDy4BW7A9pqGAzsDX/m6u2BhQnSz3mEDixlIpwVsQl3P9Rjg481Ifu40cuaFw8hEh8nfbpuago7y2L9x+hYsuBfu/Iw3ZE6X4yqinQWS9739SsPzNz3Re5gXX2lJPv02ebEasjTLZG0mkubykn7ZUPQAgjnCGGuuK+qWQ5eNLpvMWcFIMxLV6/bnKoOnafdJ5oQi8aJlVVw6aZLeAb5ibgYpL5b2+TX0jgQJdbT29mvXYK0GD/KRHK4vm+rdd7DCWt3izQd2z5P30/FMuVYVWqun3tZEn4gZzJCUFJcAuH5IJgCY4UAvBP8rTKriUBXW9Mcu67F1Z2RkQydK86SdxPNlrHEDAPejR3TQU6/8cbR4BYeAOwr3CBU5Be3/9UJJ0vljhBuds39cLKbYYWVQsH9e0NmmJzs4wID5LsnfHk9hQrz8CcH1QwEnk32XLMAeE5OSrMiM5KFHQyD639dO3DWEkCkxVolRDxdU0KqDhhu88R44j5Q==
X-Forefront-Antispam-Report:
	CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(8676002)(8936002)(5660300002)(40480700001)(70586007)(70206006)(316002)(40460700003)(82960400001)(356005)(7636003)(7596003)(478600001)(41300700001)(42186006)(2616005)(82310400005)(336012)(426003)(120186005)(26005)(1076003)(6266002)(2906002)(186003)(86362001)(47076005)(83380400001)(36860700001)(6916009);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 09:08:55.4858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce8646b-32f9-4e98-13fc-08db456cb271
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT093.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P122MB0136

From: Gunter Grau <gunter.grau@philips.com>

Due to separation of C22 and C45 phy access in kernel 6.3 the built
broke. This is the port from the regular freescale fec driver of
following commits:
	8d03ad1ab0b0 net: fec: Separate C22 and C45 transactions
	abc33494ddd5 net: fec: make use of MDIO C45 quirk

In case of older kernels then 6.3 the old implementation will be
used.

Signed-off-by: Gunter Grau <gunter.grau@philips.com>
---
 kernel/drivers/net/drivers/freescale/fec.h    |   5 +
 .../drivers/net/drivers/freescale/fec_main.c  | 197 +++++++++++++++++-
 2 files changed, 193 insertions(+), 9 deletions(-)

diff --git a/kernel/drivers/net/drivers/freescale/fec.h b/kernel/drivers/net/drivers/freescale/fec.h
index 0e2566296..e5c08b349 100644
--- a/kernel/drivers/net/drivers/freescale/fec.h
+++ b/kernel/drivers/net/drivers/freescale/fec.h
@@ -469,6 +469,11 @@ struct bufdesc_ex {
  */
 #define FEC_QUIRK_DELAYED_CLKS_SUPPORT	(1 << 18)
 
+/* Not all FEC hardware block MDIOs support accesses in C45 mode.
+ * Older blocks in the ColdFire parts do not support it.
+ */
+#define FEC_QUIRK_HAS_MDIO_C45		BIT(24)
+
 struct bufdesc_prop {
 	int qid;
 	/* Address of Rx and Tx buffers */
diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index 5abf5e822..63285bf1b 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -92,28 +92,32 @@ struct fec_devinfo {
 
 static const struct fec_devinfo fec_imx25_info = {
 	.quirks = FEC_QUIRK_USE_GASKET | FEC_QUIRK_MIB_CLEAR |
-		  FEC_QUIRK_HAS_FRREG,
+		  FEC_QUIRK_HAS_FRREG | FEC_QUIRK_HAS_MDIO_C45,
 };
 
 static const struct fec_devinfo fec_imx27_info = {
-	.quirks = FEC_QUIRK_MIB_CLEAR | FEC_QUIRK_HAS_FRREG,
+	.quirks = FEC_QUIRK_MIB_CLEAR | FEC_QUIRK_HAS_FRREG |
+		  FEC_QUIRK_HAS_MDIO_C45,
 };
 
 static const struct fec_devinfo fec_imx28_info = {
 	.quirks = FEC_QUIRK_ENET_MAC | FEC_QUIRK_SWAP_FRAME |
 		  FEC_QUIRK_SINGLE_MDIO | FEC_QUIRK_HAS_RACC |
-		  FEC_QUIRK_HAS_FRREG | FEC_QUIRK_CLEAR_SETUP_MII,
+		  FEC_QUIRK_HAS_FRREG | FEC_QUIRK_CLEAR_SETUP_MII |
+		  FEC_QUIRK_HAS_MDIO_C45,
 };
 
 static const struct fec_devinfo fec_imx6q_info = {
 	.quirks = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
 		  FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
 		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_ERR006358 |
-		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_CLEAR_SETUP_MII,
+		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_CLEAR_SETUP_MII |
+		  FEC_QUIRK_HAS_MDIO_C45,
 };
 
 static const struct fec_devinfo fec_mvf600_info = {
-	.quirks = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_RACC,
+	.quirks = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_RACC |
+		  FEC_QUIRK_HAS_MDIO_C45,
 };
 
 static const struct fec_devinfo fec_imx6x_info = {
@@ -122,7 +126,7 @@ static const struct fec_devinfo fec_imx6x_info = {
 		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_HAS_AVB |
 		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
 		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
-		  FEC_QUIRK_CLEAR_SETUP_MII,
+		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MDIO_C45,
 };
 
 static const struct fec_devinfo fec_imx6ul_info = {
@@ -130,7 +134,8 @@ static const struct fec_devinfo fec_imx6ul_info = {
 		  FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
 		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_ERR007885 |
 		  FEC_QUIRK_BUG_CAPTURE | FEC_QUIRK_HAS_RACC |
-		  FEC_QUIRK_HAS_COALESCE | FEC_QUIRK_CLEAR_SETUP_MII,
+		  FEC_QUIRK_HAS_COALESCE | FEC_QUIRK_CLEAR_SETUP_MII |
+		  FEC_QUIRK_HAS_MDIO_C45,
 };
 
 static const struct fec_devinfo fec_imx8mq_info = {
@@ -139,7 +144,7 @@ static const struct fec_devinfo fec_imx8mq_info = {
 		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_HAS_AVB |
 		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
 		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
-		  FEC_QUIRK_CLEAR_SETUP_MII,
+		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MDIO_C45,
 };
 
 static const struct fec_devinfo fec_imx8qm_info = {
@@ -148,7 +153,7 @@ static const struct fec_devinfo fec_imx8qm_info = {
 		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_HAS_AVB |
 		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
 		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
-		  FEC_QUIRK_DELAYED_CLKS_SUPPORT,
+		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45,
 };
 
 static struct platform_device_id fec_devtype[] = {
@@ -1394,6 +1399,7 @@ static int fec_enet_mdio_wait(struct fec_enet_private *fep)
 	return ret;
 }
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(6, 3, 0))
 static int fec_enet_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 {
 	struct fec_enet_private *fep = bus->priv;
@@ -1504,6 +1510,170 @@ out:
 	return ret;
 }
 
+#else
+
+static int fec_enet_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
+{
+	struct fec_enet_private *fep = bus->priv;
+	struct device *dev = &fep->pdev->dev;
+	int ret = 0, frame_start, frame_addr, frame_op;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	/* C22 read */
+	frame_op = FEC_MMFR_OP_READ;
+	frame_start = FEC_MMFR_ST;
+	frame_addr = regnum;
+
+	/* start a read op */
+	writel(frame_start | frame_op |
+	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
+	       FEC_MMFR_TA, fep->hwp + FEC_MII_DATA);
+
+	/* wait for end of transfer */
+	ret = fec_enet_mdio_wait(fep);
+	if (ret) {
+		netdev_err(fep->netdev, "MDIO read timeout\n");
+		goto out;
+	}
+
+	ret = FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));
+
+out:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static int fec_enet_mdio_read_c45(struct mii_bus *bus, int mii_id,
+				  int devad, int regnum)
+{
+	struct fec_enet_private *fep = bus->priv;
+	struct device *dev = &fep->pdev->dev;
+	int ret = 0, frame_start, frame_op;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	frame_start = FEC_MMFR_ST_C45;
+
+	/* write address */
+	writel(frame_start | FEC_MMFR_OP_ADDR_WRITE |
+	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
+	       FEC_MMFR_TA | (regnum & 0xFFFF),
+	       fep->hwp + FEC_MII_DATA);
+
+	/* wait for end of transfer */
+	ret = fec_enet_mdio_wait(fep);
+	if (ret) {
+		netdev_err(fep->netdev, "MDIO address write timeout\n");
+		goto out;
+	}
+
+	frame_op = FEC_MMFR_OP_READ_C45;
+
+	/* start a read op */
+	writel(frame_start | frame_op |
+	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
+	       FEC_MMFR_TA, fep->hwp + FEC_MII_DATA);
+
+	/* wait for end of transfer */
+	ret = fec_enet_mdio_wait(fep);
+	if (ret) {
+		netdev_err(fep->netdev, "MDIO read timeout\n");
+		goto out;
+	}
+
+	ret = FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));
+
+out:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static int fec_enet_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
+				   u16 value)
+{
+	struct fec_enet_private *fep = bus->priv;
+	struct device *dev = &fep->pdev->dev;
+	int ret, frame_start, frame_addr;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	/* C22 write */
+	frame_start = FEC_MMFR_ST;
+	frame_addr = regnum;
+
+	/* start a write op */
+	writel(frame_start | FEC_MMFR_OP_WRITE |
+	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
+	       FEC_MMFR_TA | FEC_MMFR_DATA(value),
+	       fep->hwp + FEC_MII_DATA);
+
+	/* wait for end of transfer */
+	ret = fec_enet_mdio_wait(fep);
+	if (ret)
+		netdev_err(fep->netdev, "MDIO write timeout\n");
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static int fec_enet_mdio_write_c45(struct mii_bus *bus, int mii_id,
+				   int devad, int regnum, u16 value)
+{
+	struct fec_enet_private *fep = bus->priv;
+	struct device *dev = &fep->pdev->dev;
+	int ret, frame_start;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	frame_start = FEC_MMFR_ST_C45;
+
+	/* write address */
+	writel(frame_start | FEC_MMFR_OP_ADDR_WRITE |
+	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
+	       FEC_MMFR_TA | (regnum & 0xFFFF),
+	       fep->hwp + FEC_MII_DATA);
+
+	/* wait for end of transfer */
+	ret = fec_enet_mdio_wait(fep);
+	if (ret) {
+		netdev_err(fep->netdev, "MDIO address write timeout\n");
+		goto out;
+	}
+
+	/* start a write op */
+	writel(frame_start | FEC_MMFR_OP_WRITE |
+	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
+	       FEC_MMFR_TA | FEC_MMFR_DATA(value),
+	       fep->hwp + FEC_MII_DATA);
+
+	/* wait for end of transfer */
+	ret = fec_enet_mdio_wait(fep);
+	if (ret)
+		netdev_err(fep->netdev, "MDIO write timeout\n");
+
+out:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+#endif
+
 static void fec_enet_phy_reset_after_clk_enable(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -1750,8 +1920,17 @@ static int fec_enet_mii_init(struct platform_device *pdev)
 	}
 
 	fep->mii_bus->name = "fec_enet_mii_bus";
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(6, 3, 0))
 	fep->mii_bus->read = fec_enet_mdio_read;
 	fep->mii_bus->write = fec_enet_mdio_write;
+#else
+	fep->mii_bus->read = fec_enet_mdio_read_c22;
+	fep->mii_bus->write = fec_enet_mdio_write_c22;
+	if (fep->quirks & FEC_QUIRK_HAS_MDIO_C45) {
+		fep->mii_bus->read_c45 = fec_enet_mdio_read_c45;
+		fep->mii_bus->write_c45 = fec_enet_mdio_write_c45;
+	}
+#endif
 	snprintf(fep->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
 		pdev->name, fep->dev_id + 1);
 	fep->mii_bus->priv = fep;
-- 
2.25.1

