Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA6479E2
	for <xenomai@lists.linux.dev>; Tue, 13 Dec 2022 19:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jW4AGWlPEXQYRkfjWkaPAUvj9eNOhliOF6mBIbycliP+eYICRAfVpK2VJviUXe9MgXt7uAxjJmF/7mqJTPRVYtAkHMe3IY9B5xhN+KqdVoxiPf/VEvWGkBXIsUirwR+qvdez6oaaYh+tOPI+AActn2ZmKdxWWYkyZOZyraXIiJZCXCftcYHuV8hkJYviCgP2D1ollNbb/NI4lAk3Dpsc7p0lLgUTzhMabX4VLd4fp6AbyZmvVQEK1lY+JpL7fY5/elzdsxwNMxTxJ42YOIu6IxDzeS9E8RMEW+sOpK5s96Ka0FwEnyi1Kyf6djuao1zFXkIjwUWIZNNEM8gvdyKqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/GPRS6WOv9AetNuzH/Np8jw+1FuBYaoLmpSbuejbo8=;
 b=cjDNCPl5tccxQVxpy0/vfUOzA+EmxmgqEXiePzjlqfqxa3a9TrdB/Ris+e5uCo2qoLz5qveuQGzHnFhXs8+77aoUfMHo2E+Wqp775oovxQPVyAVbhVyO/FxaNj8f/T2Jb4WOhHRG8R31WN+P8HIRF6AfDaghQCNC6C2YqM6MHqZ80TYg831iau67oD9USi47nJjP9jq4R8McvxiS9bZ4bZlKZ7R7esoeyHzZI5M2zOp/i0TwSN1dOZEw8IvLVBs5Yp55LCtEH901Gv9eNVD4Ai24PsxDbE07tzM/n9UPxPXRsyCkqEgelPUKeiVCajOqqzueZhsSaMlF9Jm8OWKTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/GPRS6WOv9AetNuzH/Np8jw+1FuBYaoLmpSbuejbo8=;
 b=Q+HCXaQ44WWTrZ8B/cncKA+tlkT7QMA1JqSQYsAk/wtM2U8fs6lQjO8sq13HQBp8VfIFC2t7WkPjXocTqg8+8IFeLFzbZlGfTp1CRKVXMjGu+J0v9OZffPMWp+QfIa50goZTuX2Z/+CBwb4RpykuAlUWb64Bc/XN/GcZUf0IdRz0SedsJIHoM9okwrQjVvBhw7I/SR6+1FddGRHsJofAj+YdPd3OIuH9+Uf614XUypOdTrMtkb4V+XmdHo76xf5Nw8GGyPu/RMwlSFZuGdGB0RI/GRFq2uv/kyffjDNu65xKOGnCTa5yuNGnmiwfUoKbNVn5vkxR0yQ14TW+Gj4beA==
Received: from DB6PR0201CA0024.eurprd02.prod.outlook.com (2603:10a6:4:3f::34)
 by DU0PR10MB7028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 19:52:41 +0000
Received: from DB5EUR01FT094.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:3f:cafe::8) by DB6PR0201CA0024.outlook.office365.com
 (2603:10a6:4:3f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Tue, 13 Dec 2022 19:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT094.mail.protection.outlook.com (10.152.4.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.10 via Frontend Transport; Tue, 13 Dec 2022 19:52:41 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 13 Dec 2022 20:52:40 +0100
Received: from L15-Gen2.fritz.box (139.21.146.184) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 13 Dec 2022 20:52:40 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH v4 3/3] switchtest: test mode switches while in kernel mode
Date: Tue, 13 Dec 2022 20:52:05 +0100
Message-ID: <20221213195205.2870828-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221213195205.2870828-1-tobias.schaffner@siemens.com>
References: <20221213195205.2870828-1-tobias.schaffner@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.21.146.184]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT094:EE_|DU0PR10MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 939fe0b4-6cde-4be6-02df-08dadd43983b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K7uatR33yMZ0DsmVPbpG1Vdmjc3ck6w0J6CdOq6QCms6D75TtNyPdj6V//hLZv3Z2iRst7lV2SjV4dKHrS/VJLzlX3Q8AF1qhd/cbo5frcJI+DS7knlm7WwTIUzcPq6aQNP0+LTkmTrEeAmMwvLfXUaaT7cid3xHZCdJWbYDMSfpEqekAfb/w3LPim2VoXDxg61s6c4RMMSC/9Eec6F3CNqMreFjyJFX8q67FxiAZQJeWrRDHNYANZZENXE6WjaHh0EGLjHj9ptPvVmmq6TpCf7U1/8PwQ7T/q5DCbVW5gUELE5aY6AXK91a/0uVaseVsGZq7g16BeC9/Eh+li85Y6zs1nhsvpgB3kUVYJV5BLuqJu/HEAQ1io7aFZPUDrEequjxiYIC6Oq7asT3xcVYYbii5+XW11XsNFMh5PWLlFBFzbWl/9gPvyZnrcJbYXQioq0JhnYdjEK2VNCpPevEOaUrARDvcMOZantn0LSend1AupfF2RompmyHAaPmI4BAcg2nJuqBbglkWx2XiBzDzIhjrwhMYLrq9DwgFTiS0vPCW9H0Zj87NURaiSwkdk379RwvUiCkfd9hR3LPYsl/uEYTL780eKMamWWlx05UaNynCl7sKN8qGeniQZQ8VBpZsQK9vGn4Q0o7MVD3c1n5w0O3sJLPIvvfueL2hkWEYPt5cDQnfcywTFJ04VzBarJErG4BL/iDsNG+Fqz2UgEViIHdD0mlAYQz5N4zZUd1aN0=
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(86362001)(82310400005)(47076005)(2906002)(107886003)(6666004)(5660300002)(8936002)(36860700001)(70586007)(83380400001)(54906003)(41300700001)(4326008)(316002)(70206006)(6916009)(8676002)(82960400001)(186003)(16526019)(40480700001)(956004)(81166007)(2616005)(82740400003)(336012)(26005)(356005)(40460700003)(1076003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 19:52:41.2089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 939fe0b4-6cde-4be6-02df-08dadd43983b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT094.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7028

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Make the rtuo thread switch between primary and secondary mode while in the
RTTST_RTIOC_SWTEST_SWITCH_TO syscall.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/rtdm/uapi/testing.h         | 14 ++++++++++++++
 kernel/drivers/testing/switchtest.c |  8 ++++++++
 testsuite/switchtest/switchtest.c   | 22 ++++++++++++++++++++--
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/rtdm/uapi/testing.h b/include/rtdm/uapi/testing.h
index 49f0b7f25..3674ae2de 100644
--- a/include/rtdm/uapi/testing.h
+++ b/include/rtdm/uapi/testing.h
@@ -70,9 +70,23 @@ struct rttst_swtest_task {
 #define RTTST_SWTEST_FPU		0x1
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
+	/** Index of the thread that should be replaced. */
 	unsigned int from;
+
+	/** Index of the thread that should run. */
 	unsigned int to;
+
+	/** If the mode should be switched: 0 for no switch, 1 for switch. */
+	unsigned int switch_mode;
 };
 
 struct rttst_swtest_error {
diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
index b6d0242de..674cdef73 100644
--- a/kernel/drivers/testing/switchtest.c
+++ b/kernel/drivers/testing/switchtest.c
@@ -622,6 +622,10 @@ static int rtswitch_ioctl_nrt(struct rtdm_fd *fd,
 				    arg,
 				    sizeof(fromto));
 
+		if (fromto.switch_mode) {
+			xnthread_harden();
+			return rtswitch_to_rt(ctx, fromto.from, fromto.to);
+		}
 		return rtswitch_to_nrt(ctx, fromto.from, fromto.to);
 
 	case RTTST_RTIOC_SWTEST_GET_SWITCHES_COUNT:
@@ -676,6 +680,10 @@ static int rtswitch_ioctl_rt(struct rtdm_fd *fd,
 				    arg,
 				    sizeof(fromto));
 
+		if (fromto.switch_mode) {
+			xnthread_relax(0, 0);
+			return rtswitch_to_nrt(ctx, fromto.from, fromto.to);
+		}
 		return rtswitch_to_rt(ctx, fromto.from, fromto.to);
 
 	case RTTST_RTIOC_SWTEST_GET_LAST_ERROR:
diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index e9c552216..cb8e956d5 100644
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
 
+	rtsw.switch_mode = 0;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -517,6 +521,7 @@ static void *rtup(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = 0;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -598,6 +603,7 @@ static void *rtus(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = 0;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -679,6 +685,7 @@ static void *rtuo(void *cookie)
 		clean_exit(EXIT_FAILURE);
 	}
 
+	rtsw.switch_mode = 0;
 	rtsw.from = param->swt.index;
 	to = param->swt.index;
 
@@ -727,6 +734,9 @@ static void *rtuo(void *cookie)
 		while (err == -1 && errno == EINTR)
 			err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
 
+		/* Return to default: do not switch in syscall */
+		rtsw.switch_mode = 0;
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
+				rtsw.switch_mode = 1;
+			}
+
 			mode = !mode;
 		}
 
-- 
2.34.1

