Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA9779C9
	for <xenomai@lists.linux.dev>; Tue, 13 Dec 2022 19:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAIN8qeDV0eXGx8eA/GhhOzEkj+JsFUHFVEqVGTvctAn/W/gYBmlfNDl+TZf1jBWTtc51F/otTFNBOWU2iyFzWLG9JIo40Dcd7P76Kr2DWM2Vs6vcg8+s1yOGbHFLnTkR9svxMCPS2D2cH/U4/1W88afEDACEPxwlPmg81U+rV+6lTJ/MuEwPHG3mmc0BZXRmQmJxE9CKQJpNc8GQz7mgU3YmMCckp/d9CERq79vfHIs1krHgjs9D48HDPY6MxrX4f3kEcettl8qDUqbUASR2r5d/naXxzMG2MWd9m1Wc+lEcLkUVXEpUvaSHo6vTbv/Q9RQq7ARyXLrooiLANiuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiweVyyYgRT3BqI3Rmfm4yoxrAMVxeZrS8lWNM9I2EY=;
 b=YGLtAEpWOZnuwV1nDPPYY+b4ln8EVBZt5ZOJNeyfXG7jDS7JPUiK5nyVvWc5x4eBb9VyLtzDPAXN5+ff96donLlmLaQIyKAdNOUzxsp/soWH5DbwIlfgNkPsiWg7LMb7yEpcrwkDVD2s7Id1jcGZEnqUkhuxnhEVUm/LrzJMenNq4aOM0tTYwo+j26zM2QndyieXISBovRHVxqSxsQ8TnI1f/V37k9V2vXziu6IiiYsHSi5N1RqA1tcryLSBPVawaVBZwTt7gxC7ExH5lU4qBJ6SWYI6ftQZb1uBqaTn6ilsoC+v68XTY3cYm6Mc1VzWPYpm9KOnLZXqF4f3tr/UoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiweVyyYgRT3BqI3Rmfm4yoxrAMVxeZrS8lWNM9I2EY=;
 b=PxJuCMKTgO2eaK7p5VBhhjjOUK1wpSXNBdef5r8OcVufXFj9Vma6sMKPaLrcM8uhiDQtFFgQotAg/ZERK5R7JRZLQfMDZhmPLBTfZeY2oKPM20SlENinGmuczTGK0BOhJuN5JmQXxZ9GMA4aE7UURsdC5FdVwLF8rpvJ1WQHQ+Yww4q5MfdB7djsQ6a9BjRHFaOeO92SYNClIW65rJMFF/w0z3JyNqHaZH3PtI3A0GjYO0ROoCn6KUvGHgvCZJz4k2AwVURKlGSiarPNhKrN5XONzN0RbJM/BKMWpCJ0TAVlcjdVeLohg3veLd/N0a0DNihvRoi61dLsbLcFCMtQcg==
Received: from DB9PR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::25) by DB8PR10MB3180.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:f8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 19:52:27 +0000
Received: from DB5EUR01FT090.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1d8:cafe::a6) by DB9PR01CA0020.outlook.office365.com
 (2603:10a6:10:1d8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Tue, 13 Dec 2022 19:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT090.mail.protection.outlook.com (10.152.5.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.10 via Frontend Transport; Tue, 13 Dec 2022 19:52:26 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 13 Dec 2022 20:52:26 +0100
Received: from L15-Gen2.fritz.box (139.21.146.184) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 13 Dec 2022 20:52:25 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH v4 0/3] switchtest: test different migration types
Date: Tue, 13 Dec 2022 20:52:02 +0100
Message-ID: <20221213195205.2870828-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DB5EUR01FT090:EE_|DB8PR10MB3180:EE_
X-MS-Office365-Filtering-Correlation-Id: 488e7701-e8f0-461e-0f17-08dadd438fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zMSCEZjNAYeGnkvWEcHs5Thw7q6tv8ISWtfOHNkAIlFicvv5eTb71W883N1ow0uRbrb91EEH0jXihJkVkaAe270/LI2TV3CQowbe1DW2fErpEbkWImNP6cf688kQjxEU11SLTcSWeBntMpHKixyy0S2yl/8gHMron+Z0evpPO2k+mZlJYk7AmRN/BEN8N23ribKyzNSWjoBBuzVhr0X+fV8qz4Dq8p3gBZ1P4EjePPnM/2JhWrB9cJvnS0qWmEYwNamOgfDqZ/3r2BsQ5qwSwfa/cOc6kPnbaQTQxkHkPrpCiixoDe68v9NvpSZ8RuQ7THlNtIpZEV70kSach/qwni2ps0FFQAGzf/5wv03KDf+IWVTFRraryDsDyNPpwkfmcWHnqZcztbqEsu7rQrJxIWH83AQTL0z0SOENPm1Z87rmgn2eoFB56GRiXsFBGVyDgTWf4V+duX+npV+l+xwHAuFZ7oR+vbFPtjD45gOYeToIrDvc5qH/ZzSj3RCOflSXLjzydFIYHnJTD/+b3niwhj9I5otyQ+rGCzgxKaECKHurttfqAZk5WHCHSqVfS4o6TfHKf+jyExZNtFKuOnX1611S1jb1k1w95swFmXOCDmV7d+Dx0gGCvU5RLgcPqpLioNCayamzgO73RXKXJJuXD3FVtXUqBblMilZ2SMPi9QgWyraMq8K2j9epSG022NaXA+4d999LxqtiptMoW5Fpi9N5YxvWnVmy60ct2q/u38yHqlnD+WP2hZCR2PyUpUYGQW11E4dFg2ZP+5k1+cPENQ==
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(40460700003)(41300700001)(8936002)(70206006)(2616005)(1076003)(36756003)(82310400005)(8676002)(336012)(47076005)(16526019)(4326008)(956004)(186003)(70586007)(107886003)(83380400001)(40480700001)(86362001)(36860700001)(316002)(478600001)(26005)(6916009)(6666004)(54906003)(356005)(82740400003)(82960400001)(81166007)(2906002)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 19:52:26.9644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 488e7701-e8f0-461e-0f17-08dadd438fbd
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT090.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3180

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Switchtest only tested intended switches between primary and secondary
mode in userland.

Let the rtuo thread also test fault based migrations and migrations that
occur while in kernel mode.

This patch series will also test the bug that was fixed in
829d4d33cb7aa3ee485ad56da6ac0c3b0ce5dbe5

Changes since v3:
- avoid using bool in rttst_swtest_dir struct

Changes since v2:
- Fix style related comments
- Improve commit message of patch 2/3

Changes since v1:
- Squash patches 1 and 2 aswell as 3 and 4
- Call the correct rtswitch_to_xxx function after mode switch in the
  switchtest driver
- Only switch to secondary mode by using a linux syscall or by a call to
  cobalt_thread_relax()

Tobias Schaffner (3):
  switchtest: split the set_mode method
  switchtest: test multiple secondary switch cases
  switchtest: test mode switches while in kernel mode

 include/rtdm/uapi/testing.h         |  14 +++
 kernel/drivers/testing/switchtest.c |   8 ++
 testsuite/switchtest/switchtest.c   | 143 +++++++++++++++++++++-------
 3 files changed, 131 insertions(+), 34 deletions(-)

-- 
2.34.1

