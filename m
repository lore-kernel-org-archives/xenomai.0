Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1315D79E1
	for <xenomai@lists.linux.dev>; Tue, 13 Dec 2022 19:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8TgGILHWaONsHA8TmOj73xKkK7G936bowmozZWnhNiZjGCi0bkO74E9p+gh3szN+PJRG9u86kfOKerod3jaIC96Y6FYYlHD5UWtRXJUERo/Jf3L6DjFj3l4RZBgBIoiV99xXOeqlZLT8caYXEmUDhsn0yirYhu0HIv9w3AXbeDLo+PVkUPbah+ks7OrrbwMhGe0LS4ev37v+6vrOlWHijYRGlpCsocqyPrXCHpv3rM9IZDYsSPIALWLnZKcHaUOsZXBzl5jcQ+VMFBECP76snVd9JXv6DAH2nPE03ClOrsfvqisiOMCOq0ZbxyggiJNXWF9vs+2FrKUiJoC57PEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrBtsmU22uOn1ZcyW0uyAJPLuEN2t9YYC9vnjx+N22g=;
 b=BKZ8mbN0IEEOrMuHTcUUUkFFs05uto9C8zWWBhK+t1der5tNwAxc0JefqFDLCxyVJ9o2wIfQvXHMnGZbAo3k4GNnimM5kTWKOcTWD18QaTr5uK9CNm+7k6cbUPjGrYSx0iWfCISgjLrKgRlRRxYgJ9LgvJUuSNrEabfD+d/Vv6iAHY4YC6q7aNnLxQhRGKVhlfOBQWNfLQNwjuPDTdtkPdUnEvGGmfOwuntOEaaC4Mkb65kuRcoyc8J5MaLbCX3z5ewgfJ0jHA56X4ZaV/PucRgAqeMPK6siFfyBSkOtWi+gP3s+/LsF5h1XQFVoB/0yPmn3yT7280cURBcUrI4CGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrBtsmU22uOn1ZcyW0uyAJPLuEN2t9YYC9vnjx+N22g=;
 b=kp1Z3MMuYiXTYcrUkMrbbj6018qP8n/JoZW9+ULd9nW9j5gatm8UkemfecHTGVZkRr2BUP0sF0krfht0CqmgLzRJV3FZRNRXiFr3XgjBbmrigQ0YfdHNE4NSKDDm/11KwK8M0A884YCl6mkDaKJt0dBUhhYpFMOJq5WYEZHlkRN/wHp8GS1F8EMa3cDv1iwilrizJ12a0fOlgn9BMy6IDQ4FoZtf83Pxx+2ioPTQ6S5pk9nii9k6nFg/DHtJAiMeEUBikDhRVq0c8uMC8G7liFXYt8STJ/vJ2bKjLri/EbghwYGovMwfg74ZyqgHO5v1xq8qouCAjrJjZZ+Us33i9Q==
Received: from OL1P279CA0044.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::13)
 by PR3PR10MB3786.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 19:52:28 +0000
Received: from HE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::3d) by OL1P279CA0044.outlook.office365.com
 (2603:10a6:e10:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Tue, 13 Dec 2022 19:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT011.mail.protection.outlook.com (10.152.0.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.10 via Frontend Transport; Tue, 13 Dec 2022 19:52:27 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 13 Dec 2022 20:52:27 +0100
Received: from L15-Gen2.fritz.box (139.21.146.184) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 13 Dec 2022 20:52:26 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH v4 1/3] switchtest: split the set_mode method
Date: Tue, 13 Dec 2022 20:52:03 +0100
Message-ID: <20221213195205.2870828-2-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: HE1EUR01FT011:EE_|PR3PR10MB3786:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9f89da-45b5-41e9-8c93-08dadd439055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n8QHDkgeKAUAFJm/O5+2fm1uBWtc9uvyq6IOiIDkW0LMAADMxYadDtV1rSrzZQoApmfzDLPHRJxmDuJRkXQ3wOhlmOiZPfeUPE5S02YLF6HGMOz9MKBQUzZsHpRs72n5fjBdXLNm72gjQ5Y7GziMIKrQ3X4FId9rXTtzzlhPvKn+lRLQ3nSvDj8ldIGfOtBc11HUEpg46MXeBEw86pXMqGeKp6vA8Pn6Hpp+fKQn4jhgwMoNaDw/GRLr2YfYyFGbbSGWKYA5O64DwdobEDVzkjVou40w3Ir5WiRzNhtrSnfKGG3lJvxsOHvGtisNZKgQvIE7lOIRFJAWVWMGu1b52U9uAZL8CoePhcpAzIcMJsKznoR7LwROJefOMf6OAgN1qbw8q8pITFI0gj46xY77juK95Y3wd1aNmUWQv1+F/jJTpgcAZR1LJc/66BNYdcoa1TCX+vlzzGDCNm9JGlLsMfJtqi+MH4+IlZLhA91UaDZAao5a4TaDyKtm2ZxSaqlvo16J6H384HtjEdFU6zGRIB6KvbN0gcTCr9SC65j2f9VjHtUI2fEhvBeUotgQ+sQndmrstXzj7OKzxKoz8HeW5RIBwZ54V1dINrsv8AbCC7vuHDV9u4yVoEGa9FDMPuAHitzrE1bzpIrIm34eo3gmvQGtiVMT/6M7crTVrdmHlHPVTdkQnnqBtGLbH77yCPGHpLkyHM1LRLrksBfoDyxMhamgPYO9/1pTsf4/yNMC+JM=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(316002)(54906003)(6916009)(40480700001)(26005)(36860700001)(107886003)(2906002)(6666004)(70586007)(186003)(36756003)(956004)(356005)(70206006)(47076005)(478600001)(8936002)(40460700003)(2616005)(83380400001)(82740400003)(81166007)(82960400001)(5660300002)(16526019)(336012)(86362001)(8676002)(4326008)(41300700001)(1076003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 19:52:27.9325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9f89da-45b5-41e9-8c93-08dadd439055
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT011.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3786

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Split the set_mode method in separate methods for switching to primary and
secondary mode for improved readability.

This also fixes a wrong evaluation of the mode variable that lead to never
checking the FPU registers in secondary mode.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 testsuite/switchtest/switchtest.c | 58 ++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index 752671e39..a920ca170 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -297,6 +297,24 @@ static int printout(const char *fmt, ...)
 #define check_fp_result(__expected)	\
 	fp_regs_check(fp_features, __expected, printout)
 
+static void switch_to_primary_mode(void)
+{
+	cobalt_thread_harden();
+	if (cobalt_thread_mode() & (XNRELAX|XNWEAK)) {
+		perror("Switch to primary mode failed.");
+		clean_exit(EXIT_FAILURE);
+	}
+}
+
+static void switch_to_secondary_mode(void)
+{
+	cobalt_thread_relax();
+	if (!(cobalt_thread_mode() & XNRELAX)) {
+		perror("Switch to secondary mode failed.");
+		clean_exit(EXIT_FAILURE);
+	}
+}
+
 static void *sleeper_switcher(void *cookie)
 {
 	struct task_params *param = (struct task_params *) cookie;
@@ -440,18 +458,6 @@ static void *fpu_stress(void *cookie)
 	return NULL;
 }
 
-static void set_mode(const char *prefix, int fd, unsigned mode)
-{
-	switch (mode) {
-	case 1:
-		cobalt_thread_harden();
-		return;
-
-	case 2:
-		cobalt_thread_relax();
-	}
-}
-
 static void *rtup(void *cookie)
 {
 	struct task_params *param = (struct task_params *) cookie;
@@ -475,7 +481,7 @@ static void *rtup(void *cookie)
 	   allowed when suspended in ioctl. */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 
-	set_mode("rtup", fd, 1);
+	switch_to_primary_mode();
 
 	do {
 		err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
@@ -556,7 +562,7 @@ static void *rtus(void *cookie)
 	   allowed when suspended in ioctl. */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 
-	set_mode("rtus", fd, 2);
+	switch_to_secondary_mode();
 
 	do {
 		err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
@@ -637,8 +643,9 @@ static void *rtuo(void *cookie)
 	   allowed when suspended in ioctl. */
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 
-	mode = 1;
-	set_mode("rtuo", fd, mode);
+	switch_to_primary_mode();
+	mode = COBALT_PRIMARY;
+
 	do {
 		err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
 	} while (err == -1 && errno == EINTR);
@@ -668,8 +675,10 @@ static void *rtuo(void *cookie)
 		}
 
 		expected = rtsw.from + i * 1000;
-		if ((mode && param->fp & UFPP) || (!mode && param->fp & UFPS))
+		if ((mode == COBALT_PRIMARY && param->fp & UFPP) ||
+		    (mode == COBALT_SECONDARY && param->fp & UFPS)) {
 			fp_regs_set(fp_features, expected);
+		}
 		err = ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw);
 		while (err == -1 && errno == EINTR)
 			err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
@@ -682,16 +691,23 @@ static void *rtuo(void *cookie)
 		case -1:
 			clean_exit(EXIT_FAILURE);
 		}
-		if ((mode && param->fp & UFPP) || (!mode && param->fp & UFPS)) {
+
+		if ((mode == COBALT_PRIMARY && param->fp & UFPP) ||
+		    (mode == COBALT_SECONDARY && param->fp & UFPS)) {
 			fp_val = check_fp_result(expected);
 			if (fp_val != expected)
 				handle_bad_fpreg(param->cpu, fp_val);
 		}
 
-		/* Switch mode. */
+		/* Switch between primary and secondary mode */
 		if (i % 3 == 2) {
-			mode = 3 - mode;
-			set_mode("rtuo", fd, mode);
+			if (mode == COBALT_PRIMARY) {
+				switch_to_secondary_mode();
+				mode = COBALT_SECONDARY;
+			} else {
+				switch_to_primary_mode();
+				mode = COBALT_PRIMARY;
+			}
 		}
 
 		if(++i == 4000000)
-- 
2.34.1

