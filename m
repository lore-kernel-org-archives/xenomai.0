Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7CF63A8
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 14:12:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJw8noCZB4wxbAUI2ZfG04KlGTxknKcdH9Ot9TqsrZc6OB+Hq+nsj1VyKE6myedg3JFptEp17O8/TKjqxaP9dkALhi3Pw5xeuj96qD0nTgzP3mc6nJ9X846AP35sRXkGR9+bjRVWG3mBZIvLsjoWfMuiD/ohDl7peMSssbh5i77L7W83wXIBLo0NURg6o6UJsgSqnDzHwjcujtbSfHCOrnD9OwJDFerIrKVv+vzua1a7h2hZUKoZ4HlYLV/WiS2hBlmmW2RXItqCsxKdYgF2VheN+eefDXfuQ20Eefq8ddBVQuSqwnkVMn6qoajQPun5f3q6UTdF6O7D22OgaAq3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oer8OAssRmA1Cm0rzU28hz5wa8sPaU22XPmxhoHmtRg=;
 b=YEMmSoWDjJ0l9K+vKy/Y/z4g1pG3RyRuJkld2qI+vMiDGTKWuKg1ruHX+JDCJ84qhuyTZlihNn0uGIYRZ2f10wkpwA8OIYQdBDbnbGEgu9H3JP/IDgTMP8B1sQe04mlAoU9/ow5f9Sd0F6mdIVUmvNZhUaQhcu8LwUaIzNbEmf5UbLwCgPPOkd17JgjI6zy1R5ynsTHURrLn0LNrIqk0UBAGTDEUuKWDpe45k9FNixc6KSmrxrZwH92dMwggtGIfbMzDPIiXlOV657DWexaLJ2Aq1Aoat01Dw+I5Law7r0tb+vPxyL8Qny0qXRmFrcjpYorQjwb7pTqNsx6KkTdARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oer8OAssRmA1Cm0rzU28hz5wa8sPaU22XPmxhoHmtRg=;
 b=xuD7yowlxIw9NheiDF9q4fvdjKFbqO/M3e4ryfzGcNoC28EdkSpB+kTG6J7Y5blwtMgSBglHz/guBBXcmSoH/7Kl53grb/KLjtzjhthRYFk+KX5CvCn+xS9zakzFf9lyrh5wznS41Cu6hEQjQNYmGcB9wz7wLT5QhN9t+oJcatjq0VgLLVS9gWZCJP+CmyxGgRDg9KwXsa6jhdHucOEug4N0v3JT9tCsaRalgeWZrHRPlFqb9oLYghrURI3S4Ct7nD3s6SDtMX6cJ+bmZE6nuXhI2xxdAzk5voHzrmke6DJGWVCWzowGHZB4FJXZ8g8MMO1cvKr6IGGjtOvdBUHCUA==
Received: from GVX0EPF000013D8.SWEP280.PROD.OUTLOOK.COM (2603:10a6:144:1::13)
 by AS2PR10MB6375.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:556::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 14:11:59 +0000
Received: from HE1EUR01FT093.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::200) by GVX0EPF000013D8.outlook.office365.com
 (2603:1026:900:2::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25 via Frontend
 Transport; Wed, 30 Nov 2022 14:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT093.mail.protection.outlook.com (10.152.0.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Wed, 30 Nov 2022 14:11:58 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 15:11:57 +0100
Received: from L15-Gen2.fritz.box (139.21.146.191) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 30 Nov 2022 15:11:57 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH 0/5] switchtest: test different migration types
Date: Wed, 30 Nov 2022 15:11:29 +0100
Message-ID: <20221130141134.2503172-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: HE1EUR01FT093:EE_|AS2PR10MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: a1734411-fd94-4cfd-82f4-08dad2dcd80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MesP0sC4IaN7N4WqyNaqBOK/3HjWMDP1zlJhsX+3j+82mFpq3xVCrTjfyxy8RjJXdx77dXpH9Zs1UJT5ohy4nB8tXS7KdrC8WM4jP2EMvRxwyEDJ7Pl5U+Q2L1p5FhZokDLbLxXuMHXeMP7TLQ9DdxcLoDZg8653pFi3XUJyVLRX4dCEn+qlB3QHdi8STXlk5rJJGprYfSUTyNZ6o9jYjPj/jRm9R+v7H08eHjawBRfgbGgvYi62fD59qNlEddhd7/m//Seo7u0HIY3jG4wAbImq77mRL2CvqTaI8E9v1aoiq9TCaw1B5y1XMQUOPJ9T+j4DUrO53ly06jMX9XRSOILHEW/QxeqbRvcdzjun8UxNMdpq8A032u78a52zwNg9NgVjwEzuTwl+JzDlrkIQ1G4WGum+W/2oCIXAl5/Dvq0Z4VjkD5D6SxHn4yPT/Tq5utv1TSeXdg4qrlCpz6EFH34csJcShXJfO5ZlT9KtxCDNNzsR8RYeZnw96MytdegTncUJkMkzKahZVT94ffqKjj9MSUM6KSOb4JJHhSZyCUYztKN8TgeOnjEbDwb2JXNYcEU+c6X9vng0dq5eks1b+Ay3EUVwKTvAyAqJhEP1OxUUVxtDZTGrKodu0n4snNuk67W5SYWTn+FfIoaK/xMmqpDU5Sj2CYNspwCh6UVj8cnfVQaLJX/y+BLqJssCulcnoXkUq/fNntA/wfbrLPPCrQOiEZykcBRkiHkghdLGHBs=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(478600001)(82310400005)(36756003)(82960400001)(40480700001)(26005)(6666004)(81166007)(40460700003)(41300700001)(70206006)(8676002)(356005)(70586007)(86362001)(4326008)(316002)(4744005)(54906003)(6916009)(5660300002)(8936002)(336012)(47076005)(956004)(186003)(2616005)(16526019)(1076003)(83380400001)(107886003)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 14:11:58.4811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1734411-fd94-4cfd-82f4-08dad2dcd80d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT093.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6375

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Switchtest only tested intended switches between primary and secondary mode in
userland.

Let the rtuo thread also test fault based migrations and migrations that occur
while in kernel mode.

This patch series will also test the bug that was fixed in
829d4d33cb7aa3ee485ad56da6ac0c3b0ce5dbe5

Tobias Schaffner (5):
  switchtest: fix rtuo not respectiong _ufps
  switchtest: split the set_mode method
  switchtest: test multiple secondary switch cases
  switchtest: Remove assertion after fault migration
  switchtest: test mode switche while in kernel mode

 include/rtdm/uapi/testing.h         |   4 +
 kernel/drivers/testing/switchtest.c |   4 +
 testsuite/switchtest/switchtest.c   | 110 ++++++++++++++++++++++------
 3 files changed, 96 insertions(+), 22 deletions(-)

-- 
2.34.1

