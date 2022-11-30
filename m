Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BE663B0
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 14:12:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjt6YvDkTU6x9rulncLt6j3cqhq/NsEhbm0Qp1G1i7WFvP8ZuLf6vBkeRt5ygLtw0zg17P2n4gp7aMhVSMq+lDRPMv3Gdtj0w8xWQmn+Vh1UikxnHmTXfFkCDE3r2dqt3lnFvTlyLi0agqYdqQ2D5oKdVOQleBam9fvJbYxLbdIucFBTSrb2qt8vlboJg0kQzyxarMBFtK4Q1osgnaYYGZ7jGqu118cGqSo0+0jNg/6z0cEhg/ecdUVeqS62mBUlx8CBvTm0ZFzPRAc8a/PsRYLvSg17MokGL2luX/jOVtgK8B1GRkau0PYtaA0LNs9j1J24Fb/eErUUoNtxWvVr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki3Q5geZfzX4C8DJqsKTnaYHd6/sFoZOh1oXubIbD44=;
 b=MAjyqhIYhgsRklg54y583wydXNs4tjHN0zeXfjjtESnonLN3wgHbNvp5n4qkSNf8NKHhWMPK6vCxQPjDyiOes6KYr8/B9sE8tasX+NpGNwMYI7nP/PsDrFioaN1BqhVdY6WkBYIZtqZwIOM2iBFx2dkmM785GqdX6uMJndt611RY2AKnx3v7miPB9QvmbaxNuc2ogdaE/X4nVP2+eZTvN9Tv/8Q71G8Weqc66Nc0m4GAa7X7DShrAoFIlPdFr1B4mob8gvG2QmdZ/tFDcjz3Tt1sH57Epb6UsuGO+0Rds4buIdrKAd/sSw7NaaCRuM7CZMxoZgwlMdcb0P7E2kzofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki3Q5geZfzX4C8DJqsKTnaYHd6/sFoZOh1oXubIbD44=;
 b=a6h+d/Jr+nWhASnkR4Xe1DkuJq7Jvnduq6glBW9rJNU6f7wFele5RHqL3+/FmDjKGOTS6e8V23IeQ4er4ttjizgrQ2IyD1iJxmzlecogq9kMJLxM0yoK3QDwrAjXxxJm7RDDT00Eyi0/L1bjhXlf1K4FT2jhcolSMbwnRooFeDnyAx24JJR4WtfEGB8TtY6SaayuCf+KUbRavuzrYh+aB4wFeQDDm7rJXYFEvcvoq73C5GHSkrSc11h53RNoObMRajG6cOu2OnENovJVGcnoH+4uXbUo45rgUmJ49Hzu+KMg/2tBE+MN8egNDZ5BcBxyDxX55MzxA4TBB6WhwU7gqw==
Received: from DB3PR08CA0003.eurprd08.prod.outlook.com (2603:10a6:8::16) by
 DB8PR10MB3610.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Wed, 30 Nov 2022 14:12:18 +0000
Received: from DB5EUR01FT044.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:8:0:cafe::18) by DB3PR08CA0003.outlook.office365.com
 (2603:10a6:8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 14:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT044.mail.protection.outlook.com (10.152.4.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23 via Frontend Transport; Wed, 30 Nov 2022 14:12:18 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 15:12:17 +0100
Received: from L15-Gen2.fritz.box (139.21.146.191) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 15:12:17 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH 3/5] switchtest: test multiple secondary switch cases
Date: Wed, 30 Nov 2022 15:11:32 +0100
Message-ID: <20221130141134.2503172-4-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: DB5EUR01FT044:EE_|DB8PR10MB3610:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1b6e96-80ad-4880-521d-08dad2dce3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qumWH9PtGM8301MlMRgzazg6V1xSUQFr4t5BxDlGW4ONBnqFhdTRetYw+OugoUiodXXd7saKg9abqjg8L/mPKAdUdzIWFoRbkJuwAKN8G5ubfUwvxGTmJf7v1NZ+uP6laHkBi4fu95i6mG+8x7b4MxMvfYT95awrwtZBBpmnOB2G+9yMf3W6LismwzCiQbNNtT3VdmUy3veH1YHTJ5QAJIFQBbQs9kveHjA5zkpvdnUiBwv8ASwi9yDrDH0C6n2QTbZvTbcOXT1UTOF3WIxbcHxzvmGVg3erIx4aUJhjycLkqyLhZqH5h4UtI+/HhG5yI9lalJ76ShsxibQRL+gdDOdF8ikkJgdMvzxlyruQFM5F7hUBJZWhFLC/gDzsqr43VPH3cTu+eHdFF9dB6ez5An2/JGF3MRc7y+XxLAusZQ1u8ipLeiF80i1Aw9Vb6Uy4CbHqiE6dACDk5pZ8dq2QeZWwJDbOKzmHJsOcn+vRTI7Wdz2x/gO1a/eMz12UOgw5QTUD5jRC0X8t7yRTpgDUKBb/osPx3scCqjEK6BxY4dkFs9vZhm45FOVwZvVED2wmuQoOoEGgnppN6EwmlAS+EhLQJ2Ie2aVim6mEX7Ck2/br0X+lBhWEehs3neSqfJcBWkRUtR0zEvDBsDEsAtLgS9WYvWie6GhqxWpImf79N2qcZS2WxtjQsUOUB4lGpizh+bMyNwizDR6cNZ0D4z5cvv00aiJ2RXC02YQFAPeUG8s=
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(478600001)(82310400005)(36756003)(82960400001)(40480700001)(26005)(6666004)(81166007)(40460700003)(41300700001)(70206006)(8676002)(356005)(70586007)(86362001)(4326008)(316002)(54906003)(6916009)(5660300002)(8936002)(336012)(47076005)(956004)(186003)(2616005)(16526019)(1076003)(83380400001)(107886003)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 14:12:18.1610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1b6e96-80ad-4880-521d-08dad2dce3c5
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT044.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3610

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Switches to secondary mode do not only occure when a relax is explicitly called
via the cobalt api but also e.g. when a linux syscall is called in primary mode.

Also test fault related cases in the oscillating switchtest thread.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 testsuite/switchtest/switchtest.c | 84 +++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index 3a6126a81..f3737d193 100644
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
@@ -297,6 +299,59 @@ static int printout(const char *fmt, ...)
 #define check_fp_result(__expected)	\
 	fp_regs_check(fp_features, __expected, printout)
 
+static void _assert_primary_mode(char const * calling_func) {
+	if (cobalt_thread_mode() & (XNRELAX|XNWEAK)) {
+		fprintf(stderr, "Switch to primary mode failed in %s.", calling_func);
+		clean_exit(EXIT_FAILURE);
+	}
+}
+
+#define assert_primary_mode() _assert_primary_mode(__func__)
+
+static void _assert_secondary_mode(char const * calling_func) {
+	if (!(cobalt_thread_mode() & (XNRELAX))) {
+		fprintf(stderr, "Switch to secondary mode failed in %s.", calling_func);
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
+static void switch_to_secondary_mode_by_fault_in_xenomai_syscall(void)
+{
+	XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait64, NULL, NULL);
+	assert_secondary_mode();
+}
+
+#define SWITCH_FUNC_COUNT 6
+
+static void (*switch_funcs[SWITCH_FUNC_COUNT]) (void) = {
+	switch_to_secondary_mode,
+	switch_to_primary_mode,
+	switch_to_secondary_mode_by_using_linux_syscall,
+	switch_to_primary_mode,
+	switch_to_secondary_mode_by_fault_in_xenomai_syscall,
+	switch_to_primary_mode,
+};
+
 static void *sleeper_switcher(void *cookie)
 {
 	struct task_params *param = (struct task_params *) cookie;
@@ -440,24 +495,6 @@ static void *fpu_stress(void *cookie)
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
@@ -699,15 +736,10 @@ static void *rtuo(void *cookie)
 				handle_bad_fpreg(param->cpu, fp_val);
 		}
 
-		/* Switch mode. */
+		/* Switch between primary and secondary mode */
 		if (i % 3 == 2) {
-			if (mode == COBALT_PRIMARY) {
-				switch_to_secondary_mode();
-				mode = COBALT_SECONDARY;
-			} else {
-				switch_to_primary_mode();
-				mode = COBALT_PRIMARY;
-			}
+			switch_funcs[i / 3 % SWITCH_FUNC_COUNT]();
+			mode = !mode;
 		}
 
 		if (++i == 4000000)
-- 
2.34.1

