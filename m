Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E56256D
	for <xenomai@lists.linux.dev>; Mon, 12 Dec 2022 12:18:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsLcK7FF31NEFB5e3sIQNFX40vQfv3BeXPDHLEsMqs5UYTmiNl6PTZGRvl5F329+Rtvt2QuJ73zWjuU+k3ANPs1gB+3RZOzuiVvtqF5SaKFVr5Gdxju0zSsvA3KF66AU5YIgeZX/A8Mo4miA51MIWUmDSTuF7DP7IR8bXMBvUdkxuPCQAe0rf8T3niLsyBBomTyT0IjqNFVFg7K58B9Z8HjxQTHzFKLx2QwK2ELgNz4i/DVO+4jv5e1S6LuqV8bTjF0Smwy5VjWEgqi7RMzpbmHKrqP9Yn+Oejf/cLZazMmAzK3+qJ2OrYxa7er1bBRGVR5Kur3xeiTYAok0zjbdnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5b2QQ9JW+SLhBhuprQcSq7enqr7w+jnEOL5VM2WxGaU=;
 b=UBYRYnvb3Ic6NMe73RYIkEemOcxlCDP/HTrg5xzDRUeG2cLST9EJQp8Bd1nGiSXP8FOFcxvn4sYLr+ImwDklyoFBnD4Vs/Z0/Na4yJzPfaSXFtpkUOkWfLUCzXOQorjf+0cf0oExrSfdPMDY63NLMp3SgUTwgbyKHrUpVRDYA/ix2B1na335//E2rfzF26Dc+dCE/cUlE+dyMGgCUsD8JRcADgcnQyv9BFQ/xVEtzLani38GwgX2PGZF/5M1/7NQrBIllD8tVsMG7uZdnlC9xY72ehyMMNM1o0Jbz6NpH9mB3nnp1zIIMnZh6l3kYD1Mzx7burz2w63vP3jkduL23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5b2QQ9JW+SLhBhuprQcSq7enqr7w+jnEOL5VM2WxGaU=;
 b=R5Pk2+opCnFH9Lj7aFR7EVG8bhyVxdzODZRvICYGFItxjFQnO6hAfWGmtUQJynV/K7sO3lPjjnigEUMF1U71pxhJih8o7qfaSLi7ZzpDHb/PXFSCvhPN+e+T7+McriXQG/gbH2fKM9JG4ICEpTh0CeJYtell1Q82zoujV/PuvbERmNdp/KyzXJMmuhC9/l4blr8Uhz/pOE9XhoByVOr//1bDAsdfEN+M7hfGnBk2MqeyK3M/pV9mlAyIp9EDTtNxQyo9bymKyNdJ6TF+s/Q2RC1jalDwJ/1IaBUArmSQcXTmfbOgY8HkrdrohJRLLLhKvNiCK3x/5SW+sXueKggXDA==
Received: from GV3P280CA0016.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::26) by
 PAVPR10MB7308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Mon, 12 Dec 2022 12:18:01 +0000
Received: from HE1EUR01FT094.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:b:cafe::60) by GV3P280CA0016.outlook.office365.com
 (2603:10a6:150:b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 12:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT094.mail.protection.outlook.com (10.152.0.253) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.21 via Frontend Transport; Mon, 12 Dec 2022 12:18:00 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 12 Dec 2022 13:17:57 +0100
Received: from L15-Gen2.fritz.box (139.21.146.182) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 12 Dec 2022 13:17:57 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH v3 3/3] switchtest: test mode switches while in kernel mode
Date: Mon, 12 Dec 2022 13:16:50 +0100
Message-ID: <20221212121650.1294772-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212121650.1294772-1-tobias.schaffner@siemens.com>
References: <20221212121650.1294772-1-tobias.schaffner@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.21.146.182]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT094:EE_|PAVPR10MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fea3c2-c54d-45d6-3b28-08dadc3ae949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iovnHvWtrh+DHsX2Lt4RpyHGnW+1fndR/Fve9U1784qyjpEFkKf+RZWDUkvDYfyaKu4SubsPv5pPus1VaZuXcx9xhG8XJarmMYs+8udYyZw9gHNHv7Yy+OEvAy6gs9xYrwn+/086DacOoQDzgyG1HmHhUO2/D1BqfzPjweSmMMhjBSdGcS2RjgyM5qUuRw7XcWRFuF9G3SdePa1s+Aqdi9iWnA2/PH3yIxNbktZjxNjKnYF/wRYy+HGh9HqSm6rTG4lnIO+50TYHjhXNOcD5jUkaEZe8ZaUfEgjGbwFTFSafG4wSQjD6QVe3VZ6vy0Oi321LfShlQHAle90zZlk2Lfz5O20q5FP3f0Q2JQQ4rT8Hls80f2TBZv+UCJLj5pdGqu+QHZSL4Rnmd9nKaqPz0N9mo5NIRrODbyQ4FrnmgUN7xlJc6SX9hQ1h4xO2VjYn6ZqpE0NRHaCrlfdoiuNOe9Lxy5jq4QLalraeodgFB4v/ZMQVZB4JObQ2Boo3vqoUvRN+nppRz0X/vrdVeknb1KNu+KQL5kX4gvlKXKv2JJe0EUUzsVsKW2DIluP5QS1eYsRUNU55jsU7yoic1Vj/cc7YfTU5VGHjIVcDOYWQE1O9zFQkSwq/DL+3wmRxnWFT8xI7FOBhyFzxwuLGPtvQWq8j4FBzCjry+bj6v9P/Cjh4IUPVp6EW6CFC2C4otsHjYVF4Oef0cqWf9dS1V9phHw==
X-Forefront-Antispam-Report:
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(5660300002)(2906002)(41300700001)(83380400001)(8676002)(70206006)(70586007)(7636003)(7596003)(356005)(6916009)(54906003)(8936002)(36756003)(316002)(2616005)(86362001)(4326008)(956004)(26005)(107886003)(6666004)(40480700001)(40460700003)(82310400005)(186003)(47076005)(36860700001)(16526019)(336012)(1076003)(478600001)(82740400003)(82960400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 12:18:00.5513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fea3c2-c54d-45d6-3b28-08dadc3ae949
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT094.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7308

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Make the rtuo thread switch between primary and secondary mode while in the
RTTST_RTIOC_SWTEST_SWITCH_TO syscall.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/rtdm/uapi/testing.h         | 10 ++++++++++
 kernel/drivers/testing/switchtest.c |  8 ++++++++
 testsuite/switchtest/switchtest.c   | 22 ++++++++++++++++++++--
 3 files changed, 38 insertions(+), 2 deletions(-)

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
index b1a87b27e..cd6da2936 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -358,6 +358,9 @@ static void (*switch_funcs[SWITCH_FUNC_COUNT]) (void) = {
 	switch_to_primary_mode,
 };
 
+/* Switch two times: primary to secondary and back from secondary to primary */
+#define MODE_SWITCHES_KERNEL 2
+
 static void *sleeper_switcher(void *cookie)
 {
 	struct task_params *param = (struct task_params *) cookie;
@@ -377,6 +380,7 @@ static void *sleeper_switcher(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = false;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -517,6 +521,7 @@ static void *rtup(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = false;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -598,6 +603,7 @@ static void *rtus(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = false;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -679,6 +685,7 @@ static void *rtuo(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = false;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -727,6 +734,9 @@ static void *rtuo(void *cookie)
 		while (err == -1 && errno == EINTR)
 			err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
 
+		/* Return to default: do not switch in syscall */
+		rtsw.switch_mode = false;
+
 		switch (err) {
 		case 0:
 			break;
@@ -746,8 +756,16 @@ static void *rtuo(void *cookie)
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
+				/* Switch mode on next
+				 * RTTST_RTIOC_SWTEST_SWITCH_TO syscall */
+				rtsw.switch_mode = true;
+			}
+
 			mode = !mode;
 		}
 
-- 
2.34.1

