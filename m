Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888F663B0
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 14:12:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uqbfcnljiv378FyKy+Mn9s6bc+MzGU9r0nTQOV3CLroZZay0Dj4Tmo8ImdkSb2/rtHs53Q4kDx0KyvAStHsKjRisaWvQAk/aOuX+UCk2cDP453dXpX9WFZoDNUJ9tZBLuzGniKcoXU7xy9B9dnLO3gFG5uWHnfgKHYJnzcwuYUnpwlSvNfZmS1fHyYYzCNn3Eq4tlLjgjPnbXWoMxLoHl6zy/eVLusG36oowsW3XPAuoEUe8Bf7/1dsRSh2wTegWzFJZ9FvV5prXVOHRcRW4zyn3HXp70gOfHA+75FJUUujFO+bR92QWx1MKlOC1eZ7EbrzHSun2pbCEcNK9dlgFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thllrDJBxOxJSqhULfNkzeqwOVDB71AA+glBI1+F8Kw=;
 b=PbMSs6SQqoyS6BDnXAMc0/aiQDBX4JG0eSi830b2rjnAoEDiWaL9Y3eAXycj1C24fKaxQbbXU3TiNBhvmLkBY54cuH68akIy0kY4lUhV7EOqGMeTV2tgHeUGHotJ9b6NQsJbE+Ei9IgHyMnMgcR7i+11De4CKMQJcKxTEXRNAUs3AxubgiaIrTNfQgl/CGz7xmw/W0Ah9SLxLmbGFXizzxDYf/NDGmXu7Xbo8WApXN+RMrzdmIuk3YDYcxp5fbspWM+8hm410BQDjjwahDp8uidiSg26mRofP+jsRvj2niPLBuHuU4DEg6uR5ih9CKR2VbuirBzuikWy3DyehXAtyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thllrDJBxOxJSqhULfNkzeqwOVDB71AA+glBI1+F8Kw=;
 b=p+A26HF5iLST38XoJshg20k4ExNkuNx9sB6slumzJ5DQXpwESxX8VPR82peVTWRHwK/6+X114WjnC4w2F+Sr48z1MNIEDuQASPIGWImfrkVkihgrap9KWnS+TU9VBTp+hV6EQAQ9P0j6myVWJ6d/+gK/KK5hjNnipgTnxY6Ry+alYVjrv0NCqY00DUk4z1SHpOKdBcJRBY/d2RAB6wfHBzszQKzbohAz54Y8Lwf9wpAIkoyOP4BNkEa9C6sf8xzCkcyxsEl3WnxROm93bbm5tUJ7YJP9/+xiHYwsvOS0ix7z+S287UTnutWWf1L2RGeYwgSK7stJIk2Ul0o9uZtytA==
Received: from DB3PR06CA0020.eurprd06.prod.outlook.com (2603:10a6:8:1::33) by
 AS2PR10MB7154.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 14:12:21 +0000
Received: from DB5EUR01FT074.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:8:1:cafe::9) by DB3PR06CA0020.outlook.office365.com
 (2603:10a6:8:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 14:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT074.mail.protection.outlook.com (10.152.5.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Wed, 30 Nov 2022 14:12:20 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 15:12:20 +0100
Received: from L15-Gen2.fritz.box (139.21.146.191) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 15:12:19 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH 5/5] switchtest: test mode switche while in kernel mode
Date: Wed, 30 Nov 2022 15:11:34 +0100
Message-ID: <20221130141134.2503172-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221130141134.2503172-1-tobias.schaffner@siemens.com>
References: <20221130141134.2503172-1-tobias.schaffner@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.21.146.191]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT074:EE_|AS2PR10MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: 721e386b-7023-4422-8ce0-08dad2dce562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xetIN4PXxSnqQuV7JKsAdZ/kh7sXISLJybvBNcIiBWkKmynewrQaVciwfpJfMYIpcv5OBecHUCaIyDva78y8B9UTc9s2wQ6VYrPX+ITrlCWdcXJ26Oik8HfJs8E+9D2J8VY3P61mjMPT8cKQ6YVVwa1UUbgQIK3HE4xUPrdxN+MRtJS1osZj1Tgf4kwA9nMSiiu4k3qhBAsUGpnxwRKDck6rbSHJeElYZSzGUa9vsgqcVgUeJa+XclhxGHwOWhL/vhr+tiFUGA/3Acy24dATOzHgBrwCX4tTf0Nv8rSSllh540NUEih8yFf1ZvuvAOaHaonB32shN6en7T6mnMug2AYWNiFw6U/beFVLEwtbHNinPOS718EYTXLBGTBKRt7qf4lmwMrAKUUqpg/Af/u/D3WJ1vvnVhQZfmX9Dp/vyiE4PxD95o4YQVyBJWoRiyS6oQPSKIRfq5enUS6d0hjCIsdM+taj58gLPQDwFqFsVmlb5J7+x9/Q6QHJzwltIiR9C30k3sCo05TQaXKeQaI90dl3IxOs1ldGBTKkAOVZPXW4qZISnYnUyjFuX5ZMjzW2Oh7t9SWeOZw7m8eEakrF1+vH8/xYhKGjeAWDNyniHSrxB+1F+xDShgLyRJRUPNvavoPqEozVNaqOvntJ4cyoMQs1nM3yv9acAd0qb/QaOdwfkTGopQCbRAoK0w/FEGHPfYxUI7pndNLjKHpdeapdPA==
X-Forefront-Antispam-Report:
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(70586007)(70206006)(8936002)(107886003)(36756003)(82310400005)(4326008)(5660300002)(41300700001)(86362001)(36860700001)(8676002)(6666004)(26005)(83380400001)(956004)(16526019)(2616005)(336012)(54906003)(1076003)(47076005)(186003)(7636003)(316002)(40460700003)(6916009)(478600001)(356005)(82740400003)(40480700001)(7596003)(2906002)(82960400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 14:12:20.8331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 721e386b-7023-4422-8ce0-08dad2dce562
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT074.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7154

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Make the rtuo thread switch between primary and secondary mode while in the
RTTST_RTIOC_SWTEST_SWITCH_TO syscall.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/rtdm/uapi/testing.h         |  4 ++++
 kernel/drivers/testing/switchtest.c |  4 ++++
 testsuite/switchtest/switchtest.c   | 15 ++++++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/rtdm/uapi/testing.h b/include/rtdm/uapi/testing.h
index f8207b8c7..059a1e0b6 100644
--- a/include/rtdm/uapi/testing.h
+++ b/include/rtdm/uapi/testing.h
@@ -24,6 +24,7 @@
 #define _RTDM_UAPI_TESTING_H
 
 #include <linux/types.h>
+#include <stdbool.h>
 
 #define RTTST_PROFILE_VER		2
 
@@ -74,6 +75,9 @@ struct rttst_swtest_task {
 struct rttst_swtest_dir {
 	unsigned int from;
 	unsigned int to;
+
+        /* Switch mode of from thread on RTTST_RTIOC_SWTEST_SWITCH_TO call. */
+	bool switch_mode;
 };
 
 struct rttst_swtest_error {
diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
index 312b4d870..05938a261 100644
--- a/kernel/drivers/testing/switchtest.c
+++ b/kernel/drivers/testing/switchtest.c
@@ -647,6 +647,8 @@ static int rtswitch_ioctl_nrt(struct rtdm_fd *fd,
 				    arg,
 				    sizeof(fromto));
 
+		if (fromto.switch_mode)
+		    xnthread_harden();
 		return rtswitch_to_nrt(ctx, fromto.from, fromto.to);
 
 	case RTTST_RTIOC_SWTEST_GET_SWITCHES_COUNT:
@@ -701,6 +703,8 @@ static int rtswitch_ioctl_rt(struct rtdm_fd *fd,
 				    arg,
 				    sizeof(fromto));
 
+		if (fromto.switch_mode)
+		    xnthread_relax(0, 0);
 		return rtswitch_to_rt(ctx, fromto.from, fromto.to);
 
 	case RTTST_RTIOC_SWTEST_GET_LAST_ERROR:
diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index 970790b2e..e7441f9d4 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -376,6 +376,7 @@ static void *sleeper_switcher(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = false;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -516,6 +517,7 @@ static void *rtup(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = false;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -597,6 +599,7 @@ static void *rtus(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = false;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -678,6 +681,7 @@ static void *rtuo(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = false;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -721,10 +725,14 @@ static void *rtuo(void *cookie)
 		    (mode == COBALT_SECONDARY && param->fp & UFPS)) {
 			fp_regs_set(fp_features, expected);
 		}
+
 		err = ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw);
 		while (err == -1 && errno == EINTR)
 			err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
 
+		// Return to default: do not switch in syscall
+		rtsw.switch_mode = false;
+
 		switch (err) {
 		case 0:
 			break;
@@ -743,7 +751,12 @@ static void *rtuo(void *cookie)
 
 		/* Switch between primary and secondary mode */
 		if (i % 3 == 2) {
-			switch_funcs[i / 3 % SWITCH_FUNC_COUNT]();
+			if (i / 3 % (SWITCH_FUNC_COUNT + 2 ) < SWITCH_FUNC_COUNT) {
+				switch_funcs[i / 3 % (SWITCH_FUNC_COUNT + 2 )]();
+			} else {
+				// Switch mode on next RTTST_RTIOC_SWTEST_SWITCH_TO syscall
+				rtsw.switch_mode = true;
+			}
 			mode = !mode;
 		}
 
-- 
2.34.1

