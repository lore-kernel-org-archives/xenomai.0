Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2045.outbound.protection.outlook.com [40.107.103.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B858863A8
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 14:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH8PY5nLmeFkuqeLVPIFGI3qCsGmNNmmmc01QLkK+/spCcpewx6nTJAJgTEpA82VOM82wtqicg8pmcdfnBBE2RIzEF63L0UsCMhXWnsZ8O2Kmu5PoPTXQ9vaCfLrWSb7kWB+hUf5RYXYDJosZPAV8immBD0XWxBKe1IU8VF1RW5gvQbrVVi7XljomGIgES/CcT0sVl1yhV/gzF7xHUDRxj9hVpWgCTKg1w2rvjj+fndiZAHW2CfZ+FN5tI8RnZ+tEYa8QlU+YVqyKDwlrlli5WhqknYGAxPn6pgHNHtl5OQTXd1va5D0Sk1R02rUylop1kLPsZibjl8RMo4KdaDvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLEWTYb6wenl7XMcphxZLtg10s4eTxp6POQh35T+Ns0=;
 b=MuVr1Zh97MJ4Ht54iieBkHVhR97GupFEoDs8yESP3b32DcIcozXZ2MFhHFthJrwUgvI250ZAbJ7sMlKpRO2MIYgnuwHDRTMtjGnzn49Iqfu84wl2UGrHkjO3hQom36nAWAaJcEifR1Zv0LIu4RiTIZWSBpNgk/9tDDTlznrX98aesVGjjhmFutSmyHw0aA4xSXLZkrb8S9EsMHDj6n8zDfw6QCNQJtBxsPwMSpBkA1XANMWl8kOB1j0fk6iNUZPSDCJttThqzkSkIszK6KXtm1iiJRrWAEBqRRoqya7L/nELKFY1cA6+DXVNQHQOI76tSu9/z/hxnsyJHnb35ha7NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLEWTYb6wenl7XMcphxZLtg10s4eTxp6POQh35T+Ns0=;
 b=Mab/TyrO//IQvASDnWSV/DcTvideeO8mdz/hQpbeUWn9WPnT36F/bgTrjX/KI++2vGeZGeblE2yTfDWIm5ngl0QsCW0+AaG7A3JX3ZcdPOunMs5i7P1Lu/xjqfm8D0LfvJuambLvauj+vkpKAfqvIrYZe0LvDxRSSqP4LtB+JP5ue6VLLH7qSdqZogSweKKwsG8gZKmkjQD5OM0j18Lvc9IqtcP2YpGHBFtPnZTCXOvkbnV8Sk9SV/SQ344UgoCkXyaEPaRkmifPObuLFInzzSFYKGQcSXnZtRPyP1tA9/MIMwY8ZerTjKUqGBGwVkXWDaYvY+IpYe/COpi0IjxmoA==
Received: from DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) by DB8PR10MB3194.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:11a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 14:12:06 +0000
Received: from DB5EUR01FT105.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:3c3:cafe::15) by DUZPR01CA0006.outlook.office365.com
 (2603:10a6:10:3c3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 14:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT105.mail.protection.outlook.com (10.152.5.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Wed, 30 Nov 2022 14:12:06 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 15:12:06 +0100
Received: from L15-Gen2.fritz.box (139.21.146.191) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 15:12:05 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH 1/5] switchtest: fix rtuo not respectiong _ufps
Date: Wed, 30 Nov 2022 15:11:30 +0100
Message-ID: <20221130141134.2503172-2-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: DB5EUR01FT105:EE_|DB8PR10MB3194:EE_
X-MS-Office365-Filtering-Correlation-Id: 723a2746-8420-4af9-d8d7-08dad2dcdcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vpznldQD+HvfwC9d3rC90jjVgH2ehhxIcLILE20WTiKud9iUs/RN3AcRDGqWCTmEKrw2Ma0XCV4gnSmjg52kUgBarYeKGRj2haLje+E2UQmSKX7NEfqSobH01b8ncB/rKlJazz7MwzdqFa7L+GUpmTSPEg0a/sWGiM853vpwxqJxz757nVA3k5jxu3gTlK8UaMZCWWduApUDBGbF9MG6QKLcEle0OKuKaCoGftr0//U27hQINKuWspGK2DqI/U9WHipPHvlYxM9GpmLNx48W9k8X6/M4z6jitHYoCrKzyRHpF0iIpiFvYQ37hENMRoo3tyW9qOPbXw6wbr/mY/ZboGge10A98aFsvgPHY4I0CLIqx9y/nUdbBpNUmoSrzgtwEeQPu3qKd13COJH8WRYfqERW+9yUe0SLsbsX50tq2Y2aWQ0RPe09hG0TVK2nebaVdSoluuacwUucnM/Lc2PcfR8sH342ua8jKX66MLUWO4lLW12fqaiXnzmeG5+bd+YJYTr1s3IFoCJb2AKNBgwcAh0/FDdi7Zr1M5bxjwo8jrret9uU1Ddw3MzWaS4eTtcAEm+wL+WOrA0J7qVC1Dwk4ypwU56HK4eIuMtYxQkacFJyrxpIMVcvXiiTZy+wdTP0MV2LMhPADYGHfb17r3+GkJISLeGgEr815fbjbNrTQFrZo7rC1+SGZJNWKs/Ulb4NyrGsBSDsJ9P+TR3IQdwhxQ==
X-Forefront-Antispam-Report:
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(478600001)(86362001)(36860700001)(83380400001)(107886003)(6666004)(8936002)(316002)(6916009)(54906003)(41300700001)(336012)(40460700003)(956004)(2616005)(7596003)(47076005)(5660300002)(40480700001)(2906002)(356005)(7636003)(82740400003)(26005)(36756003)(82960400001)(8676002)(16526019)(70206006)(4326008)(1076003)(70586007)(82310400005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 14:12:06.7449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 723a2746-8420-4af9-d8d7-08dad2dcdcfc
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT105.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3194

From: Tobias Schaffner <tobias.schaffner@siemens.com>

The mode variable in the rtuo thread switches between 1 and 2.

A wrong check on the mode variable leaded to never using the FPU in secondary
mode.

Evaluate the mode variable correctly.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 testsuite/switchtest/switchtest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index f2a5c1601..e4339b0e2 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -668,7 +668,7 @@ static void *rtuo(void *cookie)
 		}
 
 		expected = rtsw.from + i * 1000;
-		if ((mode && param->fp & UFPP) || (!mode && param->fp & UFPS))
+		if ((mode == 2 && param->fp & UFPP) || (mode == 1 && param->fp & UFPS))
 			fp_regs_set(fp_features, expected);
 		err = ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw);
 		while (err == -1 && errno == EINTR)
@@ -682,7 +682,7 @@ static void *rtuo(void *cookie)
 		case -1:
 			clean_exit(EXIT_FAILURE);
 		}
-		if ((mode && param->fp & UFPP) || (!mode && param->fp & UFPS)) {
+		if ((mode == 2 && param->fp & UFPP) || (mode == 1 && param->fp & UFPS)) {
 			fp_val = check_fp_result(expected);
 			if (fp_val != expected)
 				handle_bad_fpreg(param->cpu, fp_val);
-- 
2.34.1

