Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37817C
	for <xenomai@lists.linux.dev>; Wed,  6 Jul 2022 09:56:36 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 0E426E000A
	for <xenomai@lists.linux.dev>; Wed,  6 Jul 2022 09:56:28 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B9FFF94149F
	for <xenomai@xenomai.org>; Wed,  6 Jul 2022 09:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2DfD2p2WdogaBRp6FWE/yH5861mreV4jYd3Z6MvH6wbJSPzHuCvOScjZLeM+HKgxw+yKjSHKCoYFz7rMN8EWqPuuqG8zSP1o6lXg7qhD6ZfG47VfYlSuw0GWIHPQq/cF8PdxSFzHBjYu0IP9ffEgh8qcIrx5n+3OY1vJVXWL7KeJHnGLADluNT8gSXNNT9ts5xlg7nbZXOKCTxN0Grc/jMMZ1wF3hUF2D9KW55uInzFDk0YPM9F2kULYiwdOg1ymxt9HHn7yqF8xIkf1L5QPfLy4nGKC7wvhtllAWZUr0eJIQzerX2UFIUuYHkw55LFb+buEuafBzBDMEePxqY1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INszEmA85sLe+0vT401RtDu049nejFIB5VBpk2I+AXU=;
 b=IPZ6jjqax5PXHVh1A9RlQiHJKKNPuO/Dj2ma3AVqwUdbMqJLog2GIx88w3382ikoGSE2pueoeiTTAE0arFKc60dCYO4/h8+Lq6vwryTiOIt4WmFijCgQJ60tMxVdyY0Mfc9VrNaxs2osv7Np9iRyeTpl6ocNy6Rij81cBmyyxUnKre3REB7C1DYT6FLn/R83K8FFmxfsgErMNGMisCSKP5mxZR8mOSP1CrZUEKk3fRGT9uS2u7Fb5TCUcp+atT6jsVGn26cW4pNPsRMg5EyWHsrybQtqsx+4B2AynT50UfKkkPpnQXffGkW7sxt35IUTQJgsGix8dj/Eqhvp0e0BCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INszEmA85sLe+0vT401RtDu049nejFIB5VBpk2I+AXU=;
 b=DaMCco+SFd6ZiqE0DklJHLcFleHWsi9FM1teYhFjS04ncPL/YBhpZ/4u4+OpAcJ7F6pkZetkyAUfimN9MsH+kqxceq2tw/du4ZASm23WZXj9qvPxLyNWW4R3gtdip7QDVbMU62082/rDLU92JE2Mawn0H/tTe3qU94bfTP/3jOB5yNKRA9jXWwZ2d9ZPoiTR234qJlLadmcnZZ/fUDKqUVt4avEWNoTbhOWjW1uvXZi6TXHLm25lqmddE3fa1ODV+s+euA8UHOnbXFP6d9JHPIhMXHpEwYRC4fcackOZxRa8Ll/cxSk3fzOiRpmqUlZf4TRXJsf7SPbnK1engvaCyg==
Received: from AM6PR10CA0017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::30)
 by DB9PR10MB4877.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 09:56:26 +0000
Received: from VE1EUR01FT053.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:89:cafe::6d) by AM6PR10CA0017.outlook.office365.com
 (2603:10a6:209:89::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17 via Frontend
 Transport; Wed, 6 Jul 2022 09:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT053.mail.protection.outlook.com (10.152.3.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 09:56:25 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 6 Jul 2022 11:56:25 +0200
Received: from [139.22.133.252] (139.22.133.252) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 6 Jul 2022 11:56:25 +0200
Message-ID: <4f835795-447c-82bb-88fa-56595a236f43@siemens.com>
Date: Wed, 6 Jul 2022 11:56:19 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: [PATCH v2 05/15] drivers/net: Switch to dev_addr_set and
 eth_hw_addr_set
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <xenomai@xenomai.org>
CC: Gunter Grau <gunter.grau@philips.com>, Florian Bezdeka
	<florian.bezdeka@siemens.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
 <fed48b9dd1275fd788bbbc3571608b07b88d681e.1656940114.git.jan.kiszka@siemens.com>
In-Reply-To: <fed48b9dd1275fd788bbbc3571608b07b88d681e.1656940114.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.252]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.489800-8.000000
X-TMASE-MatchedRID: fr+PQyIZJaX5Ugo5LlTBclsTJlmwj2RYK2D6pmarVf/9xyC38S1f/QGZ
	/+APXW9kHNORVFrWC04YH2CQbe0FSGWdS71W+uwVc7cVEEvLq6ch4UgUH4JX7APZZctd3P4BlHL
	UcNM85dpsHXaY2NrO1yLm4/WzmuzL1efx9s5LIqI8czWEGg4annIfTcumHnhSB7TqRAYVohYkWe
	kKVsK1RCHUhsb+iFWI4bxGhHRenyzi8zVgXoAltkWL4rBlm20vjaPj0W1qn0Q7AFczfjr/7HE6L
	wNKsm+NKxKXB7OTkcFMEO9IureynFQaUbch+zcL0/XR2twf6Sw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.489800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 20D83182447ED3A0B77761A676BB335435EA6824BD939FFECEFCAC27621EE65B2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d42c9ea-fe7a-4899-2f36-08da5f35ca5b
X-MS-TrafficTypeDiagnostic: DB9PR10MB4877:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fcrdnq0XWuvFD6WituhnZr9hzKwx0t5IG1cXYa+3keO82aHfTAx3JlhvhtMtN7UUc1fonBnpJejATq+aBMhCK3Bdf+IdJ92sInB9uJzK6uLcTyDnbsEsXARlPyj/5nRKHjS20IVvAUNqtIBQKe+o5yiuIFlQWpkbqEdoM4wtojDlvSFXcGHU7DALwLcSZ7hkb+fuyx7XYzTK0d5CcelvGWju9i+6qqZi7QjbnkknQ5Or7dmpqk9yJ2GBXtxYwLffpB9rLE8Q5czQCx4fw6tvKYtikWntQQhdNt6CXp0EhLG51BMeNI35lsXGGzmg/rhFycKzeHo4iZ+fU6DrEpjLu/oCLgYDaeG/dvd7Uq1AN+tj0BXdrSVhu3DOEsH26DHU3s0Fx9vr5+QDLX07bW3jip5yN4pkQ3efG8gj0KTqwxvnn5rbm7NO+Klo0u6ER56Oem1rzQ6f6N4+sSNAu6oUYfzqKQH3/WLmsqOCreKd6ASFGfznaBKQvSbBgO6tKz+p0YkvL6t/IliElWr67wZc2t0SFDQNJ8gvzahVXMYCJ/lWcUqF9UuLrYKPN3XfgEw8WtQU7kUQqxeZd4HimJeqVktSAusEgho3kWkDPr2q9QUONe9Z1kn3PlMk0JaECKvKoIA8t+7MpRWMrjuovcu/S39iKY9zugbrT4cesdRtOpNq6+sI5Xp2ZdXGg+0g0wi8xEbYQgx83Ea2HRJR4Q+eSVuyAgVmyLpLaWZn8d6EQvgrty8/VpHuLi9HexYC813Kvr0idHk5cw5EjxjMBTAvAROfGqV1gRrifbIo5gHFUU3Bd32W53T2zmbSSf7RfrDkcD2uzwMaubjuspj7EvQs3IXhQF/vwmohwaZvHBCB81TVDZO2oybW19K1cGSBRebDcqJPFojB8VpG96hhKxNM96qNO8mWaIjLspnvWhkcBCA=
X-Forefront-Antispam-Report:
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(40470700004)(46966006)(186003)(16526019)(107886003)(2906002)(26005)(336012)(956004)(2616005)(83380400001)(6666004)(36860700001)(40480700001)(31686004)(36756003)(82310400005)(41300700001)(6916009)(54906003)(6706004)(356005)(44832011)(82960400001)(8936002)(478600001)(5660300002)(81166007)(8676002)(70206006)(70586007)(4326008)(47076005)(316002)(16576012)(40460700003)(31696002)(86362001)(82740400003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 09:56:25.8600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d42c9ea-fe7a-4899-2f36-08da5f35ca5b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT053.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4877
Received-SPF: pass (spool1: domain of siemens.com designates 40.107.21.87 as permitted sender) client-ip=40.107.21.87; envelope-from=jan.kiszka@siemens.com; helo=EUR05-VI1-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=DaMCco+S;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.21.87 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

From: Jan Kiszka <jan.kiszka@siemens.com>

Latest kernel complain about accessing dev_addr directly and push us
toward the accessor functions. Use them and provide wrappers for
kernels prior to 5.15.

CC: Gunter Grau <gunter.grau@philips.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - use eth_hw_addr_set for the fec driver

 kernel/cobalt/include/asm-generic/xenomai/wrappers.h |  5 +++++
 kernel/drivers/net/addons/cap.c                      |  5 ++---
 kernel/drivers/net/addons/proxy.c                    |  2 +-
 kernel/drivers/net/drivers/freescale/fec_main.c      | 11 +++++++----
 kernel/drivers/net/stack/rtmac/rtmac_vnic.c          |  5 ++---
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 88152a25e1..ea7ed3ad56 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -54,6 +54,11 @@
 #define close_fd(__ufd)	__close_fd(current->files, __ufd)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0)
+#define dev_addr_set(dev, addr)		memcpy((dev)->dev_addr, addr, MAX_ADDR_LEN)
+#define eth_hw_addr_set(dev, addr)	memcpy((dev)->dev_addr, addr, ETH_ALEN)
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(5,17,0)
 #define pde_data(i)	PDE_DATA(i)
 #endif
diff --git a/kernel/drivers/net/addons/cap.c b/kernel/drivers/net/addons/cap.c
index 1e86440699..3784b65226 100644
--- a/kernel/drivers/net/addons/cap.c
+++ b/kernel/drivers/net/addons/cap.c
@@ -263,9 +263,8 @@ static int tap_dev_open(struct net_device *dev)
 	if (err == 0)
 		return -EIDRM;
 
-	memcpy(dev->dev_addr,
-	       (*(struct rtnet_device **)netdev_priv(dev))->dev_addr,
-	       MAX_ADDR_LEN);
+	dev_addr_set(dev,
+		     (*(struct rtnet_device **)netdev_priv(dev))->dev_addr);
 
 	return 0;
 }
diff --git a/kernel/drivers/net/addons/proxy.c b/kernel/drivers/net/addons/proxy.c
index f70587678a..b37b42c9de 100644
--- a/kernel/drivers/net/addons/proxy.c
+++ b/kernel/drivers/net/addons/proxy.c
@@ -321,7 +321,7 @@ static void __init rtnetproxy_init(struct net_device *dev)
 
 	dev->tx_queue_len = 0;
 #ifdef CONFIG_XENO_DRIVERS_NET_ADDON_PROXY_ARP
-	memcpy(dev->dev_addr, rtnetproxy_rtdev->dev_addr, MAX_ADDR_LEN);
+	dev_addr_set(dev, rtnetproxy_rtdev->dev_addr);
 #else
 	dev->flags |= IFF_NOARP;
 #endif
diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index be0ed0c51e..0080505397 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -1315,11 +1315,14 @@ static void fec_get_mac(struct net_device *ndev)
 		return;
 	}
 
-	memcpy(ndev->dev_addr, iap, ETH_ALEN);
-
 	/* Adjust MAC if using macaddr */
-	if (iap == macaddr)
-		 ndev->dev_addr[ETH_ALEN-1] = macaddr[ETH_ALEN-1] + fep->dev_id;
+	if (iap == macaddr) {
+		memcpy(tmpaddr, macaddr, ETH_ALEN);
+		tmpaddr[ETH_ALEN-1] += fep->dev_id;
+		eth_hw_addr_set(ndev, tmpaddr);
+	} else {
+		eth_hw_addr_set(ndev, iap);
+	}
 }
 
 /* ------------------------------------------------------------------------- */
diff --git a/kernel/drivers/net/stack/rtmac/rtmac_vnic.c b/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
index 138e276ad9..4b41785db8 100644
--- a/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
+++ b/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
@@ -114,9 +114,8 @@ static void rtmac_vnic_signal_handler(rtdm_nrtsig_t *nrtsig, void *arg)
 
 static int rtmac_vnic_copy_mac(struct net_device *dev)
 {
-	memcpy(dev->dev_addr,
-	       (*(struct rtnet_device **)netdev_priv(dev))->dev_addr,
-	       MAX_ADDR_LEN);
+	dev_addr_set(dev,
+		     (*(struct rtnet_device **)netdev_priv(dev))->dev_addr);
 
 	return 0;
 }
-- 
2.35.3
