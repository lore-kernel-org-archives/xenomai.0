Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715E256D
	for <xenomai@lists.linux.dev>; Mon, 12 Dec 2022 12:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bwx2ukUN13wLnT9AruDwD3pXexeKcwkxsV0ieJuXIEXb2htRCRW+7M2mq4a8Y3d/RTxW7JLXsmWu1GfskQazseUocHq8iM/dIBEWrBKjFXiZEKBnrnw2xrBNzpwj3pR2yCUwqqGJdmxDpQ5Hrb41+jNY95cLdCT0b5ZGX3HvCcXW+6zSq1QK5i1lTM/JQqfn9fgbc3JC1gZzmBhcpOOWfSJpPteToI+v99+GQgmZt8g72krASuz+X8K/CZtPOqRlkbKfDONbUkcVSp/3cUQd5Te/FtNUe+4ALQAb4IDfvfz7Lo57Funmc5tLxhuYCmIZ+ar6Wq+SHOwL4ETAS6DHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDmoofJrsyV59ecAjkLYFxRBv/ZDPWgnNKFhkXxGmP0=;
 b=OFwZpzMFWjbEGC9KeYo0V8aX2x+4zFwR8GVpXxBxkysFYta0JqfAm7CFHDd0eZiGuReTySh7nXuyQ3z3G14D9JJydg7kk0FyoEGg5DjB6Z8KAAZ8yL1WUW4ff7syR9lQHW6ZOG8tN14U36oRBpIujP69o5iWxD3lQHNYN6qAPXPkRKn9On/iQPiyZSvF8RQgs06il7iNCCp3IBjwk6hxg4ubaI1WFj+txre/R8f2JwCGB6wt57G8VhB9kt4f8u54pZZFTjtAwKNIYNH8B+ipz2YhA7+TQHHjKzBkduULcSPNENmolfMOBMr1iN4neNlDfMQAq5k2YkoHWVQ0NhzJng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDmoofJrsyV59ecAjkLYFxRBv/ZDPWgnNKFhkXxGmP0=;
 b=Mw0Tuv0zy3jfmSdYFlnLkdchjMBz9+7YVkzilbYdB9v6Cfjh5L06NeOL+c8vDnUlrk/2GzkUZ2EZavTWSu65crbGqifNoZIY42hYRp52ffJCFPnZ1+mQDxmOcN29pPeY/GHiN8yNnEeOGZn1RzFoi2r0tLNl2Su3HsuphfoghBcMCWkORSLg2J1BXChChwuRAuI4OkQdM1GX/gYlNuuckhdq8at5ZykbcI0lxMffJYj2o460WINYpSISGVB0jDEVM/02YamJEP10ttBSXWnbMhRDCnHH1ESwLyRY8BqkbYC59zABdQKSg3nWQ5gp9gdPzFhoZjx2wG84Mwt/3GOJoQ==
Received: from OS6P279CA0082.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3e::10)
 by DB9PR10MB7956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:305::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 12:17:58 +0000
Received: from HE1EUR01FT033.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:3e:cafe::63) by OS6P279CA0082.outlook.office365.com
 (2603:10a6:e10:3e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Mon, 12 Dec 2022 12:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT033.mail.protection.outlook.com (10.152.0.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.21 via Frontend Transport; Mon, 12 Dec 2022 12:17:57 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 12 Dec 2022 13:17:41 +0100
Received: from L15-Gen2.fritz.box (139.21.146.182) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 12 Dec 2022 13:17:41 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH v3 1/3] switchtest: split the set_mode method
Date: Mon, 12 Dec 2022 13:16:48 +0100
Message-ID: <20221212121650.1294772-2-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: HE1EUR01FT033:EE_|DB9PR10MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 378ba5e4-96d4-4d52-5874-08dadc3ae79f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gNTomRMcUQpBH1BjlUV1R68aEPuytuH8EaGLPGaRLI7uKTtAVm4F4GpjsITCDb2EKEVZyfKYYwyYfuWss99NumEenDFbR5wBgxgqp12pKh+z+fvw7vZjZqiio4NR0dRDQT44qC7svxNpvUA8ePMtDLbcya14lZ5TU0AYvIYweZ+driJ4C3nA0bhM7/E9PRquWewa87+Gw4ukt363wEtKrXoJEljqnLWmEAy19M1ase6/9vLFhDZ0g+oE1ijmfITHJxExaAc/yyg/4rE0dlYWv/HxyIbxT91wkDJe3kHp0UM3fF4I4eWeWWJs0AN8LUFY5BsG/7ZP6pe/GKc8m2fOVtx+0zHYiyZLoPlbaj2nMU4T8pWHQCLyFCsk+3JF+5lBPu/VTiAqYGDfTufPDbyvu5OspHr6IYI8y4Ppp6On7nRCrbCXAkjNs/g7qXIenWXDzx55a7QAtP/G+1LOnkvHkR/4mx5VVlXXeP8iyGgv6CrIjVsiE+Ut2zc6nCvwJhuDjrlCTjEmpaZriAPRHI/b9q4jUDQdtxYKeJ2u/01O8PdCU0NgxQF/4W2pP+lYB1ppqNomJrgVeKbSTuOe/doSu3x0Qhatu2fxzv8JKeEjwZK9nTHlRe2hAhTcgu0nwGqf1r0hkzeiFCFJ91bkJW0biJqu1ikbww4bmoUICTVNh0TI7aUGrWr7/6rdKjPcImd4UJoHDeRlevC92hy+nUsNWlTEabdbL2pv0r5v6cI4mV8=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(70586007)(16526019)(107886003)(6916009)(316002)(4326008)(40480700001)(8676002)(41300700001)(8936002)(40460700003)(54906003)(70206006)(5660300002)(36756003)(26005)(336012)(47076005)(2906002)(83380400001)(2616005)(86362001)(186003)(1076003)(956004)(82960400001)(36860700001)(82740400003)(356005)(81166007)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 12:17:57.7602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 378ba5e4-96d4-4d52-5874-08dadc3ae79f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT033.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7956

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
index f2a5c1601..c7b704a7b 100644
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

