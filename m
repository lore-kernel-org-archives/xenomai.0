Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125F32571
	for <xenomai@lists.linux.dev>; Mon, 12 Dec 2022 12:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4oXzoAO+FGJeT6ZY9/fB0X6N+pxwWz1NcWlRQR/HbTIXeMbqGtWVZFpO2RZ8nVg/EZcUCe9sBNSbq6Le9w0qAdGyDIjqQg1PTYUzNgZTVL5x0gf1n2MfCAmay35R/gf2IX03GB6T0nuXCG5vSf6Ekd/tgLc5mjfUhYimmV6++e5fbeKWYqYKLkqpKB2EDKc9LakVPyUMJvXW4+XNHieOjEXyAaRZX7rmOljlBMjXcSydildeSDmp3QTGZKL17Tb60Dsl33MvXnYabtJTszh8Lk4LmBC/Xa9RsHHJDWonsRwu9O7eMuFQlhabEHB34f2fD0B8bco93dAlpIjUQeNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKx/a9wFx/P6R4+NiZFSdLZBLZxWUsAfQEmDRCxaM04=;
 b=LjiBwUuhOs73ZNehgEA2N1+KncBxAs/wysO1hRluD59onXLcmkm3MFGnHCUfQdYP/ZbqsX+tNZ4+7zy2oxr1ZktLEda5kUdGcWwp1nSTK+FWsuUeWNySqFHjFNJQu7tcPeRxEGdEgfR+Zi66QPwsxhWGCqWVkVGqWzuRR44g3OD1pe1lHhAfDOikld/Z/tp2vIpC/bKhtbiVmHvKK5rLANF0v9vFF7+g+IcUKEWP1dx/fU2r1E4ZXZBhElW7JaL7yD6yjwq4rGd7vCjNQlv423LZUcCP2I3Zk8mTdlieXn82jcgxLb5uDNqUgKtYhxRMdwfjn0Z6WgjOzORtpTM0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKx/a9wFx/P6R4+NiZFSdLZBLZxWUsAfQEmDRCxaM04=;
 b=Kgl/K2ksqQhEwpxfm2R5i2s9Kdbce0S3n8v7RB2OkUuvv8/2+dBgIR6DWn5APHZOhBF2TjtXqRrfogUCTxNQSX92Qgikb7IbTTRNY0WNK1w1UKppkK+hzwvexV91TeDK5gtIYkH5VgkiS2z38FaGOpD1b1eBwoS47pSxEXIY0VDJNER3EsfhfHhljJxLN1nQR0F1O1ZseLD6nukkw6EnwqE/L2yTv2z9EvQjgb9+6DlA9SvPNy+1lYsFTQSo1auSQ0o1Q35z/Odiv+O2g3Zq8ILKfjf2oa+XOhChK8G4SGQUJUY4a1FzF0nWEBNsZU2n6aA4RMh0zbZjquNULDmOdA==
Received: from GV3P280CA0009.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::25) by
 DB8PR10MB3466.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Mon, 12 Dec 2022 12:17:46 +0000
Received: from HE1EUR01FT046.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:b:cafe::ce) by GV3P280CA0009.outlook.office365.com
 (2603:10a6:150:b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 12:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT046.mail.protection.outlook.com (10.152.0.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.21 via Frontend Transport; Mon, 12 Dec 2022 12:17:45 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 12 Dec 2022 13:17:45 +0100
Received: from L15-Gen2.fritz.box (139.21.146.182) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 12 Dec 2022 13:17:44 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH v3 2/3] switchtest: test multiple secondary switch cases
Date: Mon, 12 Dec 2022 13:16:49 +0100
Message-ID: <20221212121650.1294772-3-tobias.schaffner@siemens.com>
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
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT046:EE_|DB8PR10MB3466:EE_
X-MS-Office365-Filtering-Correlation-Id: 1588b005-895b-4b48-21be-08dadc3ae062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rfnoE+ZSxEJNVMAkz/+H+DE5JkA6iHrPkrxc3Q9Q2f6k5MFJeo8XRDQdGYngQJEGiU1VrGK/LBRvytMxEP1viebUV3evbVb30+BIRI18WmSHiFnPPB+HNQz/gZiNO+en73LmHFRwnk1Hfc3JRiQqEltV5bU6pxqAH0l34aJABib9Qkbs13pVvDmtYFd7DHRFJBpq8jac43T64zLbrBUEDVRGrmHBe+CzQs9Mt70v33q0bm9MrOLLDp1+8e8Df1+3vsoEAohX7ykklUvV1zi7y5IHsrl6f27v45pW+Y+UWWgdMSLWMg+W4/iRuAhRlZF5G+NU/FsbfPPKtlYIdcqIFS1sIpxiS+YI/h+SyzNHQFOM+0gXwZEogV/qDYSOrFLolmD8QUrCxiYj1k+p0mBgCV3D6L94IvDkbLZBGBiILfMFyq5jGlwxcmax61ruzAxvXHx2lDLBBKDBsReNFpOn6uz5gr882fTQQ85igLPncGDEVIyh/hD8GiO+ae63voCyX+8nLLPVjTiUZ5ZH5OI3m8F4BPQg+OAn45R6Ntwudk/K7bO/9EgJdTe51Rl4S8J76ZfvSi5sJkyJpZ2wwnYB3AbEYhMUqxF9A6km1QL/SKoFTCSBgmRgYKTDh6X98GubUNggUy+nMxcff6REWti5acdrmMBpAce6LukRQQAkY1+aZMlOBEB7DkD9I1946emIbIZAfeo6MV1zKKyCAJlrLw==
X-Forefront-Antispam-Report:
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(41300700001)(83380400001)(54906003)(316002)(36860700001)(70586007)(70206006)(4326008)(6916009)(40460700003)(8676002)(2906002)(86362001)(8936002)(356005)(7636003)(82740400003)(82960400001)(36756003)(5660300002)(40480700001)(107886003)(7596003)(16526019)(478600001)(336012)(1076003)(2616005)(956004)(47076005)(26005)(82310400005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 12:17:45.6150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1588b005-895b-4b48-21be-08dadc3ae062
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT046.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3466

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Switches to secondary mode do not only occur when a relax is explicitly
called via the cobalt api but also e.g. when a linux syscall is called in
primary mode.

Also test migrations to secondary mode based on linux syscalls in the rtuo task.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 testsuite/switchtest/switchtest.c | 93 ++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 26 deletions(-)

diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index c7b704a7b..b1a87b27e 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -34,7 +34,9 @@
 #include <semaphore.h>
 #include <setjmp.h>
 #include <getopt.h>
+#include <asm/unistd.h>
 #include <asm/xenomai/features.h>
+#include <asm/xenomai/syscall.h>
 #include <asm/xenomai/uapi/fptest.h>
 #include <cobalt/trace.h>
 #include <rtdm/testing.h>
@@ -75,6 +77,14 @@ typedef enum {
 	UFPS = 4	 /* use the FPU while in secondary mode. */
 } fpflags;
 
+#define TASK_SWITCH_MODES 3
+
+enum task_switch_mode {
+	TASK_SWITCH_PREVIOUS = 0,
+	TASK_SWITCH_NEXT = 1,
+	TASK_SWITCH_MODE = 2
+};
+
 struct cpu_tasks;
 
 struct task_params {
@@ -297,24 +307,57 @@ static int printout(const char *fmt, ...)
 #define check_fp_result(__expected)	\
 	fp_regs_check(fp_features, __expected, printout)
 
-static void switch_to_primary_mode(void)
+static void _assert_primary_mode(char const *calling_func)
 {
-	cobalt_thread_harden();
 	if (cobalt_thread_mode() & (XNRELAX|XNWEAK)) {
-		perror("Switch to primary mode failed.");
+		fprintf(stderr,
+			"Switch to primary mode failed in %s.",
+			calling_func);
 		clean_exit(EXIT_FAILURE);
 	}
 }
 
-static void switch_to_secondary_mode(void)
+#define assert_primary_mode() _assert_primary_mode(__func__)
+
+static void _assert_secondary_mode(char const *calling_func)
 {
-	cobalt_thread_relax();
 	if (!(cobalt_thread_mode() & XNRELAX)) {
-		perror("Switch to secondary mode failed.");
+		fprintf(stderr,
+			"Switch to secondary mode failed in %s.",
+			calling_func);
 		clean_exit(EXIT_FAILURE);
 	}
 }
 
+#define assert_secondary_mode() _assert_secondary_mode(__func__)
+
+static void switch_to_primary_mode(void)
+{
+	cobalt_thread_harden();
+	assert_primary_mode();
+}
+
+static void switch_to_secondary_mode(void)
+{
+	cobalt_thread_relax();
+	assert_secondary_mode();
+}
+
+static void switch_to_secondary_mode_by_using_linux_syscall(void)
+{
+	syscall(__NR_gettid);
+	assert_secondary_mode();
+}
+
+#define SWITCH_FUNC_COUNT 4
+
+static void (*switch_funcs[SWITCH_FUNC_COUNT]) (void) = {
+	switch_to_secondary_mode,
+	switch_to_primary_mode,
+	switch_to_secondary_mode_by_using_linux_syscall,
+	switch_to_primary_mode,
+};
+
 static void *sleeper_switcher(void *cookie)
 {
 	struct task_params *param = (struct task_params *) cookie;
@@ -372,13 +415,13 @@ static void *sleeper_switcher(void *cookie)
 		if (tasks_count == 1)
 			continue;
 
-		switch (i % 3) {
-		case 0:
+		switch (i % TASK_SWITCH_MODES) {
+		case TASK_SWITCH_PREVIOUS:
 			/* to == from means "return to last task" */
 			rtsw.to = rtsw.from;
 			break;
 
-		case 1:
+		case TASK_SWITCH_NEXT:
 			if (++to == rtsw.from)
 				++to;
 			if (to > tasks_count - 1)
@@ -493,13 +536,13 @@ static void *rtup(void *cookie)
 	for (;;) {
 		unsigned expected, fp_val;
 
-		switch (i % 3) {
-		case 0:
+		switch (i % TASK_SWITCH_MODES) {
+		case TASK_SWITCH_PREVIOUS:
 			/* to == from means "return to last task" */
 			rtsw.to = rtsw.from;
 			break;
 
-		case 1:
+		case TASK_SWITCH_NEXT:
 			if (++to == rtsw.from)
 				++to;
 			if (to > tasks_count - 1)
@@ -574,13 +617,13 @@ static void *rtus(void *cookie)
 	for (;;) {
 		unsigned expected, fp_val;
 
-		switch (i % 3) {
-		case 0:
+		switch (i % TASK_SWITCH_MODES) {
+		case TASK_SWITCH_PREVIOUS:
 			/* to == from means "return to last task" */
 			rtsw.to = rtsw.from;
 			break;
 
-		case 1:
+		case TASK_SWITCH_NEXT:
 			if (++to == rtsw.from)
 				++to;
 			if (to > tasks_count - 1)
@@ -656,13 +699,13 @@ static void *rtuo(void *cookie)
 	for (;;) {
 		unsigned expected, fp_val;
 
-		switch (i % 3) {
-		case 0:
+		switch (i % TASK_SWITCH_MODES) {
+		case TASK_SWITCH_PREVIOUS:
 			/* to == from means "return to last task" */
 			rtsw.to = rtsw.from;
 			break;
 
-		case 1:
+		case TASK_SWITCH_NEXT:
 			if (++to == rtsw.from)
 				++to;
 			if (to > tasks_count - 1)
@@ -679,6 +722,7 @@ static void *rtuo(void *cookie)
 		    (mode == COBALT_SECONDARY && param->fp & UFPS)) {
 			fp_regs_set(fp_features, expected);
 		}
+
 		err = ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw);
 		while (err == -1 && errno == EINTR)
 			err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
@@ -700,14 +744,11 @@ static void *rtuo(void *cookie)
 		}
 
 		/* Switch between primary and secondary mode */
-		if (i % 3 == 2) {
-			if (mode == COBALT_PRIMARY) {
-				switch_to_secondary_mode();
-				mode = COBALT_SECONDARY;
-			} else {
-				switch_to_primary_mode();
-				mode = COBALT_PRIMARY;
-			}
+		if (i % TASK_SWITCH_MODES == TASK_SWITCH_MODE) {
+			uint switch_iteration = (i / TASK_SWITCH_MODES %
+				SWITCH_FUNC_COUNT);
+			switch_funcs[switch_iteration]();
+			mode = !mode;
 		}
 
 		if(++i == 4000000)
-- 
2.34.1

