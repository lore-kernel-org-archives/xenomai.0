Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0DA6112
	for <xenomai@lists.linux.dev>; Mon,  5 Dec 2022 15:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7V3MBl2oC4Csrgxq9l33ONylHuMzOwsfPD00v5UwiwVB8+zfS0dC4FPxRg8srsQYM8jsLtFZVrLwJlKW+Dxp9cXcxi8LuX5pQNmZF8iK+dwtEHtHtkL/b1t52of0bow5G6hx5PGYhrzdhb/QGYda9vFINbzIcQND5VUR6t+/u6kLeDBVJEledsGNjVJOlDeaVzSKDqAM+ruZNWWqHfS7lgV/XUiXMg33+mGFVVGFMcz1+j2B0HXJjdBMU1gMivHW9kO8CEKMLrwZGNUSJmmq3t4RNLnVuVFjNQrafqLDUHnMo82wtbW7SE/It8w9rZOZ8/Ivgccs+FKfT5M+KWGNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zo61ue8qcr7KDwmzkn04u7aCimHy5EcBqV4++MW2I8U=;
 b=XFJbHNP/to2dfOjU+52teyM/r+5vMOf7pUPm9otti9RZci9qh/xmZK/KWkZrFdKlPMGL8IEGGIno5mC9/6Fth+XtwSYghlzkHwR1jYG2T2S1pEsEtpInVMHFxhyiUXrHSKbs0aHd/bxKtc2pFfVYzLA0w6c+vU/oyNB/rl8zkZO2q0pzALvQi3gpOiIw9i7g5DqD9F4SmkIxld8sUPs0R8JvN3Bm7WahcuduaP2xCf//mKELrwfl4lkp5LTEgeJJurJdpixIucclLalneiQjKK9LWaqRO5D+xcRYY1XKZSoT5L6ixwyRYSCogrTaJL+kxifDmzAmQFON15fYAi17hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo61ue8qcr7KDwmzkn04u7aCimHy5EcBqV4++MW2I8U=;
 b=fFOjLWhf2ncRA8grBgEq+zztHk9606wHWMsyXmY0HG/SDCFmSSW+eYmGulLiTnYKRkXm9u4F0vn/R3VqN0CjbJZHCLItE+ce6BvEJBSS5u1iTu3FeMCr4opniXzfzNYm0nk1yTNuYtZbLTeDj0cErYBQKd0ZhI8vb/JnS2gckJ2hCdiOq7Kdmnymcq4gg2JjUbjvAsOrntYW2Z2FgnnS1JZ8/lZX76RCJChIEYBs+Ld9hyDy3u3gtjXu60AHIIOeHkMtG29yNm8FOKCx+YQFnjlRHrUZzAWE2oU3zON4jG6jNwi0eCrOux4twgUERsyYXjDiXxDqzBzESuURq08DWQ==
Received: from GVYP280CA0017.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:fa::15)
 by GV2PR10MB7509.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 15:21:40 +0000
Received: from HE1EUR01FT065.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:fa:cafe::2) by GVYP280CA0017.outlook.office365.com
 (2603:10a6:150:fa::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Mon, 5 Dec 2022 15:21:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT065.mail.protection.outlook.com (10.152.0.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14 via Frontend Transport; Mon, 5 Dec 2022 15:21:40 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 5 Dec 2022 16:21:39 +0100
Received: from L15-Gen2.fritz.box (139.21.146.182) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 5 Dec 2022 16:21:39 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH v2 3/3] switchtest: test mode switche while in kernel mode
Date: Mon, 5 Dec 2022 16:21:04 +0100
Message-ID: <20221205152104.3555474-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205152104.3555474-1-tobias.schaffner@siemens.com>
References: <20221205152104.3555474-1-tobias.schaffner@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.21.146.182]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT065:EE_|GV2PR10MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 095b1e8b-8e2b-40e1-4409-08dad6d468b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TOe4c4GoQkvN8M3xT8Y1krLm+dfo+2ZsEXK6woBMc4fU4bRbl2psZlROZxzvt9N5rHKOLQ07oU5FR/jn5PQ0aSCmrNGQ7ACkuDx6jgkmJZ066D7ZSbKfgB9BwKHfvuWEzQ1RcAMw8+EJ6rh7s51r39M+5R+t4+ObJL9xIRT/2LgdYKe1ChRuhIMUsrC3yEjiDg3ih8WnBE/neJCdzJNIdCcNpgOlxi6VB8tE3ux/5wS8xiJxFMPx6gAG44R+ej3KgqsWStlPkGrVCCX2mmWzH2Shx7sVJZoSH4mMksG8DZQCfLH9H3g0sDLBuJcIl/167GC6eHnYKhErc8zfOBm4FByy7ZEqkNxG/Q4h1DTKV6KyYOBChrSoCjSJAWOYw6M3zYBRq3Z966BJvahYRMFkNG6HJZ5GiOv6Mud4KGBcOeY3dt6EztGnOJMaOy2+kTFkp+1CbBBHRuE1hY7P+EXtAXzUvRtlSaodgGiQnbOGk3AH1TikEiITOcOoCQbhfeWE9HYh+4h4u1EBKf6QMatUZKNZ+zcpY11Kd/00vP9Jof72Bm/SfRb4b9EDIaMgUTVs0/kCaPuDoh3I44/qlG/7TUKTXTPRTp8Oxbb7y1G3AklxszKN1/o2cBj/SqEuv2S2XogTbxrnj3pKoCZ48cBtEXwYFlhgY9yMA3EPHVds80WdEVtIL2yQvAVe5MzfnrwyXPpE/cLewmyTG9AE/cbkPoh4Pd2dUnWsgcdr5aQPs0A=
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(4326008)(70206006)(82960400001)(70586007)(81166007)(2906002)(8936002)(356005)(478600001)(82740400003)(83380400001)(86362001)(36860700001)(8676002)(40460700003)(16526019)(6916009)(54906003)(186003)(2616005)(956004)(1076003)(316002)(47076005)(41300700001)(336012)(82310400005)(5660300002)(40480700001)(26005)(107886003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 15:21:40.3726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 095b1e8b-8e2b-40e1-4409-08dad6d468b8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT065.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7509

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Make the rtuo thread switch between primary and secondary mode while in the
RTTST_RTIOC_SWTEST_SWITCH_TO syscall.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/rtdm/uapi/testing.h         | 10 ++++++++++
 kernel/drivers/testing/switchtest.c |  8 ++++++++
 testsuite/switchtest/switchtest.c   | 21 +++++++++++++++++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/rtdm/uapi/testing.h b/include/rtdm/uapi/testing.h
index f8207b8c7..c389cdc25 100644
--- a/include/rtdm/uapi/testing.h
+++ b/include/rtdm/uapi/testing.h
@@ -24,6 +24,7 @@
 #define _RTDM_UAPI_TESTING_H
 
 #include <linux/types.h>
+#include <stdbool.h>
 
 #define RTTST_PROFILE_VER		2
 
@@ -71,9 +72,18 @@ struct rttst_swtest_task {
 #define RTTST_SWTEST_USE_FPU		0x2 /* Only for kernel-space tasks. */
 #define RTTST_SWTEST_FREEZE		0x4 /* Only for kernel-space tasks. */
 
+/**
+ * @brief parameter for the RTTST_RTIOC_SWTEST_SWITCH_TO syscall
+ * @anchor rttst_swtest_dir
+ *
+ * This structure is used to tell the RTTST_RTIOC_SWTEST_SWITCH_TO syscall
+ * which threads should be exchanged and if the mode (primary/secondary) of the
+ * from thread should be switched.
+ */
 struct rttst_swtest_dir {
 	unsigned int from;
 	unsigned int to;
+	bool switch_mode;
 };
 
 struct rttst_swtest_error {
diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
index 312b4d870..e2c0f4bcd 100644
--- a/kernel/drivers/testing/switchtest.c
+++ b/kernel/drivers/testing/switchtest.c
@@ -647,6 +647,10 @@ static int rtswitch_ioctl_nrt(struct rtdm_fd *fd,
 				    arg,
 				    sizeof(fromto));
 
+		if (fromto.switch_mode) {
+			xnthread_harden();
+			return rtswitch_to_rt(ctx, fromto.from, fromto.to);
+		}
 		return rtswitch_to_nrt(ctx, fromto.from, fromto.to);
 
 	case RTTST_RTIOC_SWTEST_GET_SWITCHES_COUNT:
@@ -701,6 +705,10 @@ static int rtswitch_ioctl_rt(struct rtdm_fd *fd,
 				    arg,
 				    sizeof(fromto));
 
+		if (fromto.switch_mode) {
+			xnthread_relax(0, 0);
+			return rtswitch_to_nrt(ctx, fromto.from, fromto.to);
+		}
 		return rtswitch_to_rt(ctx, fromto.from, fromto.to);
 
 	case RTTST_RTIOC_SWTEST_GET_LAST_ERROR:
diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index 12516186b..490e39f1f 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -358,6 +358,8 @@ static void (*switch_funcs[SWITCH_FUNC_COUNT]) (void) = {
 	switch_to_primary_mode,
 };
 
+#define MODE_SWITCHES_KERNEL 2
+
 static void *sleeper_switcher(void *cookie)
 {
 	struct task_params *param = (struct task_params *) cookie;
@@ -377,6 +379,7 @@ static void *sleeper_switcher(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = false;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -517,6 +520,7 @@ static void *rtup(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = false;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -598,6 +602,7 @@ static void *rtus(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = false;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -679,6 +684,7 @@ static void *rtuo(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = false;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -727,6 +733,9 @@ static void *rtuo(void *cookie)
 		while (err == -1 && errno == EINTR)
 			err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
 
+		// Return to default: do not switch in syscall
+		rtsw.switch_mode = false;
+
 		switch (err) {
 		case 0:
 			break;
@@ -746,8 +755,16 @@ static void *rtuo(void *cookie)
 		/* Switch between primary and secondary mode */
 		if (i % TASK_SWITCH_MODES == TASK_SWITCH_MODE) {
 			uint switch_iteration = (i / TASK_SWITCH_MODES %
-				SWITCH_FUNC_COUNT);
-			switch_funcs[switch_iteration]();
+				(SWITCH_FUNC_COUNT + MODE_SWITCHES_KERNEL));
+
+			if (switch_iteration < SWITCH_FUNC_COUNT) {
+				switch_funcs[switch_iteration]();
+			} else {
+				// Switch mode on next
+				// RTTST_RTIOC_SWTEST_SWITCH_TO syscall
+				rtsw.switch_mode = true;
+			}
+
 			mode = !mode;
 		}
 
-- 
2.34.1

