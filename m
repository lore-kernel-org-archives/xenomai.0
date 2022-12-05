Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B779C611B
	for <xenomai@lists.linux.dev>; Mon,  5 Dec 2022 15:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MP3D3W6V37FPmK5LtN+Q7MHneB2bNo+lL4ZFkzTIJEm072Zb/ky5gIGPjcoWOZJiacf20ahPMnFxN7njO3OPNr8z1QeSRhxiE5CQuHZhyONe+G6MvRp2KDzPCH1tQG4vur6eSU54GoakqUFgxbRTipofNBxJHNsGYmRID7jPZdkj9cBNHMcueVlkk58eQcuoekdQN08qCbQDCZ5ejW7kky06IyjpwTkHt6Cmc1u8iySl8CvVx2FZwzs0fF964UwZXPVDSfZJc0sbhvwVpEyqX3A3rMAIdtbB7nKQK/Kvu69ptcn4cNTTWKsSH5s4CTIYh/2rKWJj5dzBAiTkDKikVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ug0OlQ/39GybYe438vZ2IHJuuw5pZ4RU0iNdhAfFIO4=;
 b=DpQeXgrR1A7dWyU3hjLSl9Pj9w6tlzDG4t5ahJNCN1+vhHtyWSGL4AejbJQemRP2zCM9zm17RkHvCIMqwZESUUQ2kPrvmarfnccnFihRf3EpQlIJcT2qplkkzfFUg1t3jKOIEXMTL/GUiwFWlVgESZ4NHd1pryS88qYXJlm5Odiyg711U5H1lVuAof2HpC0xIyZak2AD0xKBEbJC7eaSN4GnpDzBUlJfe4/MZldmHqpPJ8bv9x8ozIswp8y3LFObjJNXd8BqtkqNS0wg5aiclKq2OMg5cEzy+Z7uxIE4RARhQWWp36a0CRUbGCFgWLWdwPdbNHpsRTrCS9JAbYzyEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ug0OlQ/39GybYe438vZ2IHJuuw5pZ4RU0iNdhAfFIO4=;
 b=M4JgKy6I2DeTKOhzwpGI2m9mQHoDypRdgNZD73gZZ1S542LuLWdnqEmFUgS299/5hrxQVofxA2jRxxkJNYFdwiZwM8i0kqgNWOF4ey713OJQQA2MkmeCmNhYSRo+nrbqlBZAtN8e48xzEJHz0y1Rx2Ia9Ifj254PdSYn0CCR80/rU+0rD+iA7wG/6BqAqqd5EknGEIb/hpv4LEwUTmItp9CUtrVKYWNNF/lCFR2lwUHiDrCJPYkx1X3ZM2XWQBeGPBWSv6PnQXMipe/bJCopzVSPEyDceR31Jmf1zvwQcNOfiFurQNtF20oSgzfJ+aIc8VkX0M+LiAHqDW48aGf6Xg==
Received: from OL1P279CA0030.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:13::17)
 by VI1PR10MB3533.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:139::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 15:21:25 +0000
Received: from HE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:13:cafe::42) by OL1P279CA0030.outlook.office365.com
 (2603:10a6:e10:13::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Mon, 5 Dec 2022 15:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT043.mail.protection.outlook.com (10.152.0.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14 via Frontend Transport; Mon, 5 Dec 2022 15:21:25 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 5 Dec 2022 16:21:24 +0100
Received: from L15-Gen2.fritz.box (139.21.146.182) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 5 Dec 2022 16:21:23 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH v2 2/3] switchtest: test multiple secondary switch cases
Date: Mon, 5 Dec 2022 16:21:03 +0100
Message-ID: <20221205152104.3555474-3-tobias.schaffner@siemens.com>
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
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT043:EE_|VI1PR10MB3533:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a28691-ec4b-4600-dce5-08dad6d45f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PUx/D89D/4aDgcYUW31tUeDF4DxSXJwCqKcNRIvYGC314Os/RYT8AzLNetOXzHmsSDK+hqRktTqE9mlsnHxpS6ZQHaG0cieAM4nbJleFwT3l+x3eaWOM6NBrU0v5f6OuL68VX5TdOheP7g8n47FON3/pZyFr5WoQs42/fLs+MYoV2RAAktq4zfM4XjPk8MlaaeUpByd4agf1fhf33H/DIiPNxpUq8aeo33LJa0I3xTvxkQb+UgT6vepX7YGajl+gwuqy5eV20hIpX7fG06j3AeIeMOLS5djY9nlCxz4OH4z9Ny61f5jm4RQucsoVEHou9PndKW6wWCKFHfsHfIYEgJye75826zDwF/L7sYTkHNiCthzGY7TjvV7f3sqW0kkys7sfWykxB5ZlSKbZ0uaiAiK98DZHBSfbZtNOBwaA3HMeOA8qdJIkEOVmZbOUdhoLeC4fuc3raUCTb5fz9qzWoXO1Ijvfh82rKbFiwUqXknPx3SMrXWdPrb5oC4Vw+6Py4VHPvMAUq4lFgGMQBDHq68jlGxom6cZ+piSK35lvAYNWBlRqBghD8uJraYQdbSiY88LOb5MZeZ0/bpCRuyE+lC2aVSQ8kB6J3X7lJvCw/2gUVRSQBxBT6zpwAFExNmNWDkiO6dJqRanZboUnE7r100DTFafFtHsI6RRoPMgV/t/hL57UKnH1yRqp5ojnU7KvO17oy4AdNEac1Ps5QjUA8A==
X-Forefront-Antispam-Report:
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(8936002)(47076005)(83380400001)(336012)(5660300002)(4326008)(8676002)(82310400005)(1076003)(41300700001)(16526019)(956004)(2616005)(70206006)(70586007)(40460700003)(36860700001)(82740400003)(356005)(7636003)(7596003)(82960400001)(36756003)(2906002)(40480700001)(6666004)(26005)(107886003)(86362001)(186003)(316002)(6916009)(54906003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 15:21:25.0345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a28691-ec4b-4600-dce5-08dad6d45f93
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3533

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Switches to secondary mode do not only occur when a relax is explicitly
called via the cobalt api but also e.g. when a linux syscall is called in
primary mode.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 testsuite/switchtest/switchtest.c | 117 ++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 38 deletions(-)

diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index f8a37da79..12516186b 100644
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
@@ -297,6 +307,57 @@ static int printout(const char *fmt, ...)
 #define check_fp_result(__expected)	\
 	fp_regs_check(fp_features, __expected, printout)
 
+static void _assert_primary_mode(char const *calling_func)
+{
+	if (cobalt_thread_mode() & (XNRELAX|XNWEAK)) {
+		fprintf(stderr,
+			"Switch to primary mode failed in %s.",
+			calling_func);
+		clean_exit(EXIT_FAILURE);
+	}
+}
+
+#define assert_primary_mode() _assert_primary_mode(__func__)
+
+static void _assert_secondary_mode(char const *calling_func)
+{
+	if (!(cobalt_thread_mode() & (XNRELAX))) {
+		fprintf(stderr,
+			"Switch to secondary mode failed in %s.",
+			calling_func);
+		clean_exit(EXIT_FAILURE);
+	}
+}
+
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
@@ -354,13 +415,13 @@ static void *sleeper_switcher(void *cookie)
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
@@ -440,24 +501,6 @@ static void *fpu_stress(void *cookie)
 	return NULL;
 }
 
-static void switch_to_primary_mode(void)
-{
-	cobalt_thread_harden();
-	if (cobalt_thread_mode() & (XNRELAX|XNWEAK)) {
-		perror("Switch to primary mode failed.");
-		clean_exit(EXIT_FAILURE);
-	}
-}
-
-static void switch_to_secondary_mode(void)
-{
-	cobalt_thread_relax();
-	if (!(cobalt_thread_mode() & (XNRELAX))) {
-		perror("Switch to secondary mode failed.");
-		clean_exit(EXIT_FAILURE);
-	}
-}
-
 static void *rtup(void *cookie)
 {
 	struct task_params *param = (struct task_params *) cookie;
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

