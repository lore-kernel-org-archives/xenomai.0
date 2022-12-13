Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5D79E2
	for <xenomai@lists.linux.dev>; Tue, 13 Dec 2022 19:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SL6kmcqq1kPxWVqUvk4XiLKigTo5+DP7b5WKry56Om+rQ0yOMCLeeSysIC9FLWJGwKoovMiE/3V6N3GxTkESh3S9qRkGe4DE1FqKOdKKVOhmOWcTR2gUW+A7qcmM8r+/5a4IxukcxoqYoTjl0RxbZcuJU4njXjeIEtSF7caQ11glT3UtNeqqgD8YDhJWHWtZ24KhcjcolhDhdjudAQRFFCFAuhToDtrP3TWVbZe/Pt+XE/sIRZ8Nq8GzQZDFADoPeJ8CIZ00jhT0oaT2lq2MPjwlS2Vx+xoC6vpqHeKmvJ5nfcflzX4nC1e5mZGuizacUHCxQsC4UOR1v1z6ycUVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMSO1htz/an6LaN2XatMSKNietWjrSeUeKfegsK1gik=;
 b=K3YeNIVm9URsw/lgRq/wx0KvFaxYkBJfrCJZF39SgdigX0CM6QvzCzA/+EyvQzG5UHcV56s07yz89Nco3Dk6LASDsVX92c7kwXGEufF5HYvTd2+9AUjjPZqNblKn3fBdux6OHLEC165KbqjT/uCJTXaqb2oO+jMU9cgAFKGATYi1FStxJmY6szERd9SDDKMbUex/DcrfAdtSU/xORm9qDj6YZZfp2spB2kSdqRU+Y7PH4lULoxg1Ue40hMw1QdHEyfo/aZmvDlEGSwiE3zpbYLdgDWWvt/LUT0ihMRcaF9xIwhzqAT+aGfB0uStuiLM6ZuPXPkxoD63mH4BYJ8T8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMSO1htz/an6LaN2XatMSKNietWjrSeUeKfegsK1gik=;
 b=iI9Un7ibH8C5GwqdOBQOb4YylV/1C1Sqre6nQhA8ni8uLmop2r8+RXdLL7coqGm/gewKMWCFojaxOwbraDLzEDfZswNfDH9q3BZtEgLOSb3xSU3HX0jOp7U8DzVsNle0IPQ5nAv+p0Qzpkl6OJh6A8LtkgOTHK12e67j4FY2W0Lug9IeR8hSabNDFlU9Vsr5wtc+q2NRXHKhS8fCwq9cHoz/uqocLXbNIHQrltT/dopfXYe1BSRWB/4JbcbnBNKRZZc/lla89gCuQ2bC4gsPxJ7qUusYCdDkZ7yTDcxtvqAh08ZwBCm9wzfaOEeR1FW6UEnUXDxCWBl7S7S2tU5U7g==
Received: from DUZPR01CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::14) by AS8PR10MB7302.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:616::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 19:52:28 +0000
Received: from DB5EUR01FT064.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:3c2:cafe::66) by DUZPR01CA0066.outlook.office365.com
 (2603:10a6:10:3c2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Tue, 13 Dec 2022 19:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT064.mail.protection.outlook.com (10.152.5.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.10 via Frontend Transport; Tue, 13 Dec 2022 19:52:28 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 13 Dec 2022 20:52:28 +0100
Received: from L15-Gen2.fritz.box (139.21.146.184) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 13 Dec 2022 20:52:27 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH v4 2/3] switchtest: test multiple secondary switch cases
Date: Tue, 13 Dec 2022 20:52:04 +0100
Message-ID: <20221213195205.2870828-3-tobias.schaffner@siemens.com>
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
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT064:EE_|AS8PR10MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: f337b38c-a665-4048-3e62-08dadd4390aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tJ5P5J6yf7MUUpNMceTTupjqLVNHWowOPk8476a6/ME6Vs5dixrE9VT+GPlue6LeiV9TuOB0hDLOI4xXnR79eK0lIbO5byT+dzkoCncX6rNny/U02nZ2LakkcvxEt5A8iF994gIoUcp8yuoBKaPXVNfJvskplFHac8H4qun74I/a5j5+Gs6tnu/0F5hzWAaLoC6zsIcTF58yVLTErRfUzxRtpz8d3QUtufTWdS+raM80Sv1hLL+M5prsvCF7dHwG8JpcoYJIm5TnYnJ6m1tpgesWKm8n0t3S4o0Q/M0MqGCJTmPeKJJat14s8JCg4583WkFSAiVwv8YHO4b3oApXiRpUqoPyzQRQ0skfNjFMWPz67csyJJfJXpJjUa5wvc0UPXm7lxitaIGYBsyNJjZ5bzxQKnpwcgCM9gpULqCIIfPoWrhOSQc7XwXu1yxLanbOP71VBJroacseGr8bQJqoOcNgvKeFyTXowrpnOVD+iT25nvkNW9o2i1ivUT+dqTN0F0ZhCCVQjdQZB9XhWThJnVz9D0ae3lIZAIFd8DZQBfSgPLJEQ5XZaEASZ+NmLXRtsSlIUMv2mxRQSLV/dK95f8BDEAXVCpVoAc7XSwxGlT/QOPpqFUASUIbozQNkOvuhBgXj220wBMifK2IpkDIPOf0g1w12Y2hKAZxEqXeOz5sVEW7RvzNIpsSm9S6KjviAPXTINC17htSdDKEKfuQ/WA==
X-Forefront-Antispam-Report:
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(46966006)(36840700001)(40470700004)(478600001)(6666004)(107886003)(26005)(82310400005)(186003)(956004)(316002)(1076003)(336012)(40480700001)(5660300002)(2906002)(54906003)(83380400001)(16526019)(36756003)(70586007)(70206006)(36860700001)(47076005)(4326008)(8676002)(2616005)(7636003)(7596003)(356005)(6916009)(86362001)(8936002)(41300700001)(40460700003)(82960400001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 19:52:28.5032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f337b38c-a665-4048-3e62-08dadd4390aa
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT064.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7302

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
index a920ca170..e9c552216 100644
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

