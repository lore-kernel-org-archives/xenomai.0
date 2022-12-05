Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F396112
	for <xenomai@lists.linux.dev>; Mon,  5 Dec 2022 15:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNf9D0fjAmWn2yDJTEKHW/XPYh78TP4Aisr6gPFgrkjUg0GyMQIapSaWQCpwfgCQFLghbCLj5o253HB6C5yP0EaDx+ivQoBxbsRFL6N+fnipmrdh2LdRW5aHf9tzmjltsBJxCkvvLYLIcRf/Yc0PQvYdMQUPZM7LFVqWmMZ3Gl3bNg9XObBrU8g+PAmhszwpR9KKkuYUhtaabVGFCoSP6KJHxRnM+LLERIEAi9MdTl/4sabNeITPCbIyM6Tgaxje9WNBnD6C8ShvRBUShnm/BPHuRrb8u132DiAe5h6E2S7lUdvj1a0d8Ecxck6jFQsOPmUV7F/WjjgSDmn8JYop1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0gd0UZGLPG+YOodXqpC9lmKEzJb345nLVRD5VHOVMQ=;
 b=k1enS9IpHheJIpTndblDRByp4ejp7xULvpL/vjPXZBOTHnhSL73NhV1RQbZH14xJUf8YSAJy/xELBk9hG6h+qgrLOP3uZcfISnMBlODwWzhFJfvmUal40gwgl8me0h0iWRkUV33SSUKVYAYUhiKZdU7aLM6Wks3jtUbfiodknklmqrq02UBH4Ov1BjHC9mGon3yYH9OZPATBvsFiJqc1G6w4Lr+C6/Nbux2EC5oDuTxSzVsdGC/3UruixvfBQdGOdXO029hIr0PwRcsnZfNOfV95a3+Kr4GP3vWgi4KD7MwxrAmo3S/OhxBX0hstoDOGYvpxXOwwQkMXXz8JBpYjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0gd0UZGLPG+YOodXqpC9lmKEzJb345nLVRD5VHOVMQ=;
 b=DcQLmWdsSaWlqgSK82okeNd7VEUsKCu9PL0ParIAj5nrKNXZv9n6zi58JbpeXBRYof1VCrU0B1f4LhB1ZI0N0RxgwcKUmTxX4N3gwOdguYj1uXV72O5Le3SKI1mdqUA1RpFcjE6eZVCHIvsbDUH0OG5RkrS8atKfsDxOpkf0fLF2AAcMfD9elJQSMydXQ7UFd7I6EuEnAW7q09P/SprwYVkTvvmyqgsLB8Y8EGeDqQTnnH2Mk5RtyVCqqXqp/u4SHX0DV7Z+95CNnY4y9FMzUu9CXOWZw/rKqmuRRYMqtRBPxasNgwIZUTFZ8xKc7zYOXr1Tj6TDxacwTNLhtUxuqw==
Received: from GV3PEPF000000DD.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:2:0:b) by PAVPR10MB6816.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:2fd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 15:21:23 +0000
Received: from HE1EUR01FT075.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::202) by GV3PEPF000000DD.outlook.office365.com
 (2603:1026:900:3::f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13 via Frontend
 Transport; Mon, 5 Dec 2022 15:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT075.mail.protection.outlook.com (10.152.1.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.11 via Frontend Transport; Mon, 5 Dec 2022 15:21:23 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 5 Dec 2022 16:21:22 +0100
Received: from L15-Gen2.fritz.box (139.21.146.182) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 5 Dec 2022 16:21:22 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH v2 1/3] switchtest: split the set_mode method
Date: Mon, 5 Dec 2022 16:21:02 +0100
Message-ID: <20221205152104.3555474-2-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: HE1EUR01FT075:EE_|PAVPR10MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 884bbc9c-ecbf-42c7-de2b-08dad6d45e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2FLZ078bi2Vp4UUFbohGX3Qp/AMhwl2xOigGmaEiW9sdH51c8O4/4SOh2NKG7p50e03mHc3VGHVfdNEcnIW92IcLEX0bybp7cUSLnEOaIm2vMFGNwPzk7Uo6uSfQlqdDAxq9I+2yNnPaYurrgKnRKb6OSwTXs2vikLsnMhYAChN2ZD4Q/TSUze7ZP+v+8gNGnP5O4XJ4redAuqPf5eXS6Edt/A+jNU2bQEG/+UAPlWcOcy4bRAOUAzz4EZ257/rvbWr5hJixujB+XqZTtdS9hKV75lRzv+6tHPQTq8HH/w3KNydNsM6DaRJ0Hmkh5cJsS9VwjLqHMIAwDwLhFvqkp0KQi/4jnMwUJ00TQ5VhfoxNY43swBgCJz7+2u2LQo99NYBViheH7hEItj+hkQR0vydxYmU6eTFtGLwR4rorPlqnm4UpwJt1/vSxyUeKctOWMr8hR0EERcLV9OzGgXBq5eYKK2wx94yHGeXjxPUwrCgqZiNJEufsNGMCsnTN+/4wiTiFZmMtlNAxrFAC+gqJfbcv3yZzsYB49oKPmGyKhwqecE9nMK7r9E1ccD0Md0tsd5Kacj25//xPbi5Ayx9BmalZuTreC45ILkC56aAuEZdjMQHMLRfg9CDaNZNzMxIPEWrNb0lVAXFB9ocYwpvRi8Fr5LmWnUlWLgmJbXoEy+nMbVZs3ICp22FYnJTbhmAObcI2LnwW7aRe6MS7+STfyLtk3xiRK9YRSFlnC8xz/xw=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(81166007)(36756003)(40480700001)(86362001)(40460700003)(478600001)(356005)(8936002)(107886003)(26005)(4326008)(5660300002)(41300700001)(8676002)(6666004)(70206006)(316002)(2906002)(6916009)(54906003)(70586007)(36860700001)(82310400005)(82740400003)(82960400001)(956004)(16526019)(186003)(2616005)(1076003)(336012)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 15:21:23.2495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 884bbc9c-ecbf-42c7-de2b-08dad6d45e85
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT075.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6816

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Split the set_mode method in separate methods for switching to primary and
secondary mode for improved readability.

This also fixes a wrong evaluation of the mode variable that lead to never
checking the FPU registers in secondary mode.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 testsuite/switchtest/switchtest.c | 48 ++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index f2a5c1601..f8a37da79 100644
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

