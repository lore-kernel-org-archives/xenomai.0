Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7D363B0
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 14:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsEfyMlo21esiBbOToLtZfagmSMzXCc8RBI5pkqLBIzpQwsn4vyGLYlRjxGoKusILEYWj+7CpPcRcIATo6jjyx7Xr6KsS6bWQM4s4YOdzb6/iuW6Bv/qWNQPslL2Nu7C8OjSHbIz5maC27NKOSj1iU7fiYhdz8egRq0sefmsbt9GAZagpCLkX/q3pbao283dAdiQGLd7Kcu75nln3HLM8qv22OZRzIgcSJD7ystQTtxZb9xRMrC6VtvZsdxXMNeFMk2DJt3bVT4rFxcNxtAixVbUAT/1KgqigiKTJOrxdMhpSdNCjtoDooPgE77gKFfr4c97tSUZqLiafYR6kq9rOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP3e6Ji/qhNBDMA9TLuC5FwtxgCCBPUDat2BTmMACXw=;
 b=IwAcjCF/gMm29U1camLMSo/J7psktOP/z17YrtEtve800L/QaEAhumAt/ZX9CpFKS5x70zutLwtO8Iz1tlN/Gb972BXNat+PENO/sBECsRoQq2g2/T8JHek8cjBzjxawMpfmaq5CqwRPj7kwReQYgLJlTHumM02+5Y6DEJRts1JcM6QXshSd/qYOw16dzmzdK81skkburSWHpFXleOtXJHDezuEhuitDTy14gh8SisLxcYB32hTYA4SORh/ydeR958xmj7TuNqJZJivlRZkuLaAGc+I3NG5wfbPyIc/B+eZePZtNGV29zgjnlEewRPnaVY+2nfCpRvi74jTzKzOkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP3e6Ji/qhNBDMA9TLuC5FwtxgCCBPUDat2BTmMACXw=;
 b=ZYTnCPPei0PpzBImQPYQSdjkeL2tWSn2WvnfT8U0HCUh1o1emuOQxjW18Vss5oHqcTMJvdpN6NSFSDwwUY3cvEphShHqZBQehfw61+9EeoiwzDfEg7P70aCZpDPmqjv7of859EmZDDNPhXxmUjgdS+DE/rVsCj+8KxjbPbUc0GyY/FCQk2iNC9gUE9BQ7WvRXgOxH12cGUxw6xsOMnXdZ3H5gUp4JHem5kNcwT9gBKayMHuvoAG9WRSGVUPhQwTaxbw9Dn51+ZXM7JVTM7lVxFEMghraupTT05iOY57GFzKTfYgJM91OzozWt5eZ2DyAVTN34+ahfL713U+aQ8u7yA==
Received: from GV3PEPF000000DA.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:c) by AS2PR10MB7904.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:648::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 14:12:08 +0000
Received: from HE1EUR01FT103.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::204) by GV3PEPF000000DA.outlook.office365.com
 (2603:1026:900:3::f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 14:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT103.mail.protection.outlook.com (10.152.1.45) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23 via Frontend Transport; Wed, 30 Nov 2022 14:12:08 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 15:12:07 +0100
Received: from L15-Gen2.fritz.box (139.21.146.191) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 15:12:06 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH 2/5] switchtest: split the set_mode method
Date: Wed, 30 Nov 2022 15:11:31 +0100
Message-ID: <20221130141134.2503172-3-tobias.schaffner@siemens.com>
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
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT103:EE_|AS2PR10MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a241b9f-2d35-4f14-71cc-08dad2dcddcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CXAvgIYQWy+KpEHM2WBhOiVnvQTucIuNXPDDW2iPTBtH+ckb28UucpijxJhCAELb5jAij0txSs+JLN415/SYb2cLeXsHMnxjxXxnptjyKHPXtcCtIF5Nf0BNGUMGldboZIRVwqyMoIg+rJePljDMAbgXBbkVTtvVY4Dv3KhUNcUj7Mxb1J9HQjMBSOKkdV6ufOFg11Y4Qh1CJrz50tnmBqsa1f8BIqmnSGelW0xBn9yOr3jzwROpQcN1o4ITO6DtrAoiF7Sh1ZuxMDA4HS7GUDVz1VSntBhS4LJowhZGUDcCaA+/DPcKSu0d5j98vp3kbsl+hN6r+32Lb4/xD6R2W+sdsUYmysIGdAXD08fK5hE23QWy/F9q4evmPfRFWsD6QpJfsXMZWQiI4nkbCvKseF0r0sSgP+uwUExDGGAe7beuKwJ3oilQRrJszYQNa22va83HLrht86Hkz0w0FmwVvE12iEopSbc3Tqy7gvovfBvk+xTd4UVk/H1ejpg4OghNwe2fM+P9TfyUNUDWqV/UtBMAAMqvk3wZ1eSrqNZjt6niZCfWClKq+3VYitrDaVu+7N46Kec3SCak3gitPjABI3+W3kDpph6hjaM6f9iADJk71pYQ8I0TQtCy91hfBvXx9lTcaqE8WmuC8iCBUD1PRlyPA/G+3BKaq3kWfLf/wUD6O1K2MyymOsO/Tgo7immowf/iU/BTTs9q57Zxh4MVVe9W5X7HieAIdepbBd3j4uU=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(356005)(2906002)(40480700001)(36756003)(40460700003)(81166007)(107886003)(6666004)(86362001)(16526019)(478600001)(41300700001)(26005)(316002)(70586007)(36860700001)(5660300002)(6916009)(70206006)(54906003)(8676002)(8936002)(4326008)(956004)(82740400003)(82960400001)(2616005)(186003)(1076003)(336012)(83380400001)(82310400005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 14:12:08.1250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a241b9f-2d35-4f14-71cc-08dad2dcddcf
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT103.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7904

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Split the set_mode method in separate methods for switching to primary and
secondary mode for improved readability.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 testsuite/switchtest/switchtest.c | 48 ++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index e4339b0e2..3a6126a81 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -440,15 +440,21 @@ static void *fpu_stress(void *cookie)
 	return NULL;
 }
 
-static void set_mode(const char *prefix, int fd, unsigned mode)
+static void switch_to_primary_mode(void)
 {
-	switch (mode) {
-	case 1:
-		cobalt_thread_harden();
-		return;
+	cobalt_thread_harden();
+	if (cobalt_thread_mode() & (XNRELAX|XNWEAK)) {
+		perror("Switch to primary mode failed.");
+		clean_exit(EXIT_FAILURE);
+	}
+}
 
-	case 2:
-		cobalt_thread_relax();
+static void switch_to_secondary_mode(void)
+{
+	cobalt_thread_relax();
+	if (!(cobalt_thread_mode() & (XNRELAX))) {
+		perror("Switch to secondary mode failed.");
+		clean_exit(EXIT_FAILURE);
 	}
 }
 
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
-		if ((mode == 2 && param->fp & UFPP) || (mode == 1 && param->fp & UFPS))
+		if ((mode == COBALT_PRIMARY && param->fp & UFPP) ||
+		    (mode == COBALT_SECONDARY && param->fp & UFPS)) {
 			fp_regs_set(fp_features, expected);
+		}
 		err = ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw);
 		while (err == -1 && errno == EINTR)
 			err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
@@ -682,7 +691,9 @@ static void *rtuo(void *cookie)
 		case -1:
 			clean_exit(EXIT_FAILURE);
 		}
-		if ((mode == 2 && param->fp & UFPP) || (mode == 1 && param->fp & UFPS)) {
+
+		if ((mode == COBALT_PRIMARY && param->fp & UFPP) ||
+		    (mode == COBALT_SECONDARY && param->fp & UFPS)) {
 			fp_val = check_fp_result(expected);
 			if (fp_val != expected)
 				handle_bad_fpreg(param->cpu, fp_val);
@@ -690,11 +701,16 @@ static void *rtuo(void *cookie)
 
 		/* Switch mode. */
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
 
-		if(++i == 4000000)
+		if (++i == 4000000)
 			i = 0;
 	}
 
-- 
2.34.1

