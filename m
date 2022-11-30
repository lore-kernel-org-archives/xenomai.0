Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D9F63A8
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 14:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljdy3VIwm0h9Mp+CFa0Eex3l4kzjckjZ15kPQPO3Hi3cEnVcVTfg3W/9QjgxcXrn+zj2CIse6+Byg9QCU+UbiBPwl7RNgV/WlcbgNBW3N22Zf0UUP8J6+9fbXfYMkcKn1RdE8PwFEdS6U3JIJ4uHp0pnDOsa8yTzzmQyHQtomW5cbhq4PaCEMmm8eEx2dn4Pu1aLs6zZTP96sNf64Lx1iDNWiM+nuTW0TMXIFoTrg3j6Ac794PbvanpmPR10cWA4ZxBmIODEekxFUnjDDUBXHOsdRG5012bU8Y293QSiseQUBIMqTxq+WGkeCng120MudGKw5DeGF2VTURPss9vRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QvNifGLa5v4KjPAGbKqrF7XPxdW1UnRYjO+TpGWTuc=;
 b=iolki9yLhHd0NOyFsk0JcPRSrF73kni66j9Zp1sODkT5BbmvKx7E8g63wrb8azx9Mh3fjR92HGfj8lhi78U+0Q8Iq3FuJ5mP6A2btYU1gUB66rf4rLMnlWIq3oaz3K+kUPVoZ7G0g0f6iuGBXGejn+jIfjdlhD5qlyJVJafaGtfctgTTKzALtNnW1e0YKh2EUvxBkCgWAciFvE/5TmkG4ThpPHUyth+4ldzMbsQz6dHDn7zTU+FG7asVOGofBrxx49LmvE5gCt+eacWgiVGREZwpiA4xl0hC/9EGIkHm+F3mepGg0b6vEbiXaLNq/28G6HDmjJ7oa3/XUjjn5qMhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QvNifGLa5v4KjPAGbKqrF7XPxdW1UnRYjO+TpGWTuc=;
 b=VceO1SOJintWwCh5ciBw9V0PX2s8ZobvqPPTMQVs27xZvrbdakv4K/YqGNnIvDIfJkZM8oqJ+yBHuRrUxUjMJGUEke+Y6uijstFWo1xMuJ/30njdCNfwZrIkjauGLC7TRxoVVmNbJFkyt1Ay6nY3kOyQaHo7xrxiYY+PlolKRr3FJ9PiXTaZ2++2iBF6T/F7l6pP4Vsh/c6hSLxiL0jA8kEybvYJnlTusNLLBEnyVEzTxu0b/XusfpkHDKB88sQ9adXSdv7Oe6uHB1h8CuLFymLXv/WKJPoQh8Ao0voRuvLi9agsndh4868TKyfwpOABXk0TuhkcBYcrbqJGv1tlfg==
Received: from GVX0EPF000013D9.SWEP280.PROD.OUTLOOK.COM (2603:10a6:144:1::15)
 by AS4PR10MB5269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 14:12:20 +0000
Received: from HE1EUR01FT065.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::204) by GVX0EPF000013D9.outlook.office365.com
 (2603:1026:900:2::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25 via Frontend
 Transport; Wed, 30 Nov 2022 14:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT065.mail.protection.outlook.com (10.152.0.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.17 via Frontend Transport; Wed, 30 Nov 2022 14:12:19 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 15:12:18 +0100
Received: from L15-Gen2.fritz.box (139.21.146.191) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 15:12:18 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH 4/5] switchtest: Remove assertion after fault migration
Date: Wed, 30 Nov 2022 15:11:33 +0100
Message-ID: <20221130141134.2503172-5-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: HE1EUR01FT065:EE_|AS4PR10MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: dac3d2e4-11a7-4246-b7d1-08dad2dce496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nfkJNe20bELYvHC2Va/j7YcP7F3Y4KZJNCEK1iZJX9uE1fAXEt3zh7+c8S0Wr6/1F+qetJswg+46cR8PZ/e5BMiBoM7siS4tHBzH1LffT00G/q7FqyAO+ZwKnl7YP/Foan9l448LAK7kOQEV5i/UnOg77N7kZ2zx73os8QkFO3GhrfjEtPm85zkHKRZzetzbjXPSckgLfZJAb4i+ZDfknpzC+NrkZHwJo526p8TBMrebVJsGNiX7AvXGXtV/ElRz7lTlwGQml/P/fKZpRXt9IRdXKBPqrmUC4boYyjzqqaT4dmKNtZVoRwngllWH0nUxkVaK+xg27bULd3Y1LSEtB8w7n4VWEg3wAmIn2S2yfUFbApIE5oii6qAsm++zy+woXEmoBbe8HUMEvzKlttgnnwJ12LCJgTXImc1eD2rNmuHT+r3B0d58GUMu8BzQjP7U5+nka8HrzjUMWrWzhHwWnBJVgmdmEKMNbu8npmDgwZ6MJ89jdB/BeeaMf21lUW2LHKnRuUHA5jl63HgKQcsrAPV8+nQZpHFaYTa3B4+ixsXFTmPUHVtIO8QkZgYFIdeTANauB/BqDtSnpwQeW802/lXtht5E3vOVkL4Hjt5372Qv0YZDRf+e8Z2qMohdDjWkg2zxYimTQG/H/awbXEszMt+T2C5YEuneCC/qZuEvGXaYLf9WOatz9oeWBtkkUrKYJLAuGwAidshckWB/YWsTqfpctkoZBZSHZztxkTvijT0=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(82960400001)(41300700001)(478600001)(956004)(107886003)(36756003)(36860700001)(336012)(54906003)(316002)(6666004)(356005)(186003)(8676002)(82740400003)(70206006)(26005)(70586007)(82310400005)(4326008)(8936002)(2906002)(5660300002)(2616005)(1076003)(16526019)(40480700001)(40460700003)(86362001)(83380400001)(6916009)(81166007)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 14:12:19.5129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dac3d2e4-11a7-4246-b7d1-08dad2dce496
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT065.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5269

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Faults in a xenomai syscall lead to a migration to secondary mode most but not
all of the time. Do not assert that the migration worked but expect it to work
on next iteration of the test.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 testsuite/switchtest/switchtest.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
index f3737d193..970790b2e 100644
--- a/testsuite/switchtest/switchtest.c
+++ b/testsuite/switchtest/switchtest.c
@@ -309,7 +309,7 @@ static void _assert_primary_mode(char const * calling_func) {
 #define assert_primary_mode() _assert_primary_mode(__func__)
 
 static void _assert_secondary_mode(char const * calling_func) {
-	if (!(cobalt_thread_mode() & (XNRELAX))) {
+	if (! (cobalt_thread_mode() & (XNRELAX))) {
 		fprintf(stderr, "Switch to secondary mode failed in %s.", calling_func);
 		clean_exit(EXIT_FAILURE);
 	}
@@ -338,7 +338,12 @@ static void switch_to_secondary_mode_by_using_linux_syscall(void)
 static void switch_to_secondary_mode_by_fault_in_xenomai_syscall(void)
 {
 	XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait64, NULL, NULL);
-	assert_secondary_mode();
+
+	/* A fault in a xenomai syscall will lead to a migration most but not all
+	   of the time. 
+
+	   assert_secondary_mode();
+	*/
 }
 
 #define SWITCH_FUNC_COUNT 6
-- 
2.34.1

