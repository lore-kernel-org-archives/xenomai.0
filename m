Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6222F3C
	for <xenomai@lists.linux.dev>; Mon,  5 Dec 2022 15:21:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvevlnqwWldu24IdAjXLH7nptg9wWvf3VrcZpGzYqR+L4Q6SdUFZ1tSPyalFAc2FnNQOr8jypMJyuLSBKM5QJloQtHe8qZygoFZXFEfmYHRPo8CFkRXaEw3KPpQ5AbJ8QBVCRxnGPJ2R2+5HBzAG5J8xFvjr+pF+rQ7ZG6eOvLRBXoIzEpoZT1liOL/KHGftkLRV8h71+dr2C7CMMOn4dgbpR7XDe616B9rgDwiQJ/rlWsnWYVEY+eJQzIohckRyJaCqP12zz5kwmea1dlikCPNESCpa84QvsEaZxerqm8zNCvx9HvWSbb7BwzKMfixXPs4IaimXm+C0Ra7sFY9yCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql+ePEdKpZJxo62Z09jjZuQyzKdFTM8Sc3ZJaDh9Trs=;
 b=VUulJ2oKZjULQ+8Kuju+Luoa6nt7ssKGhlh6IdDsqo1R/i7Kfuw0bJTnh60bquvxF/qW2vKKXMNMT5m3QRYGpdBfg2MASUMD12/p+RMZt7oUAguMpap811bcsZTzUHS7EYW9Aw7+5uhDpJIp5Ib2Udg6354jfDmS7hR9Ff/kze+QYbhlXBPNjhTA7vaTby1bxlC1YsYfKOB6aXalN3pkl24A1IJoChDMaVRo9L4MJVXG3P+fKeb3oED0gNV3VrFNgzvmZq57Owa463QX37HFuptdWEb0yVJ5kb+Ln91lDZusIu23j6Mi3DjyDiMB/wTLFJ0aNiWW44/g3v3TncIT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql+ePEdKpZJxo62Z09jjZuQyzKdFTM8Sc3ZJaDh9Trs=;
 b=nF4d8WtMNtRXK8wMvDkyuD7zjRdvWO08bp2o6Gc2eVp7GyZnEWeit0zfKHhZn6B+JgXva8TTHMHP2syLgWdU/YcOPTtOADv/D5d5CdKx1PJ+g3kkU1S13FLNaReQn3+aAIG3WBpxRh3aFvgOvO2uJl0gcFSBYf4E5LBwQ3Mk5KutjW2rpdg45TH3FCQsU5uHbYvpfp+qCQm7wrP0Jt+GgY5Ctg2CVsjvdj3SalBRW0bdGyLZcMYcewBesKAla501g43s6PUoyPsNcijCzgUR+U6DKryhyKhluS3ZGo86igsF9Dl47/IvSt1jXF123A1YUhjjGCb/R/ZOUk30oevzBw==
Received: from OL1P279CA0065.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::16)
 by DB8PR10MB3960.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 15:21:21 +0000
Received: from HE1EUR01FT013.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::3b) by OL1P279CA0065.outlook.office365.com
 (2603:10a6:e10:15::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Mon, 5 Dec 2022 15:21:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT013.mail.protection.outlook.com (10.152.0.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.13 via Frontend Transport; Mon, 5 Dec 2022 15:21:21 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 5 Dec 2022 16:21:20 +0100
Received: from L15-Gen2.fritz.box (139.21.146.182) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 5 Dec 2022 16:21:19 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH v2 0/3] switchtest: test different migration types
Date: Mon, 5 Dec 2022 16:21:01 +0100
Message-ID: <20221205152104.3555474-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: HE1EUR01FT013:EE_|DB8PR10MB3960:EE_
X-MS-Office365-Filtering-Correlation-Id: 4521fdac-d719-4076-104e-08dad6d45d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1vs83Ik6FffE/wa4W6M0uDfTrAAsA2YEvEwrY0vbVecR2iNMj1tAn2VrRxvSFpY5OzLRiXHu9RcPZZ/ghQkxo2UFxDGe9hP8Mh6v10oFe5ImH/SVsb8K65ZbiSEDB56Wc97OAwJV7Bm1OFflRfdZjWhMtwBT8EPFBNSaQidHbhAUsIMbCnPUxHFvZrYvBZ/rGtcEGgfVtWY8ZVI0o6RcJOzeem6rN7rtxkslX8hRYAYn10iYDP2DJsO4tI84Z2/ZwzPtTMeM2szY26Vx9UxplZqLYFbjOHNrGCdov7r3swH2FvxiGRrM5GVwqxJs1ZCW9Oa92ujEnfXIVUm8o2P6tywHYeq1UkS0FY6ptizOrSkZQXoGCsxpWpxhVBAJp+cnwhegxo3xFMEkB0imRVhtPVLa7tCTgcXkGjDkQFYu7c/OmmUzF701M0dE90pw19aAj5a0lmGcvcbzlGsd6T8NUlkpbhgcI6dx8hx0v6woEhPvWaKnrgEXD+kf4mmeyccG8PaME3YRf8AM00B9AqOMYklQsAPL2s4So14EQuMZDxVRMN/PvNfuL2ci3kt4xpLGGR0CVFY7cVSPYTTU1Cu/g3PcD7bw3jOODYSJkA5aEXXqvpjMeYy52AIg3E0+ASh7ESZV6u25jLkiTUNEN6pvXpTHMUv4f7oyHe/Uvtdakh3dfaz5MQsJZjcefBVYkqMGPp/bbaDFBQI5frb/+fKz9gCcnKw0F/ghZ/3kBX0smZ/OWa6KAI/aOap23vU2VwbjhULqsUJrRmvYNZulHLGsYA==
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(36860700001)(356005)(86362001)(81166007)(82960400001)(82740400003)(4744005)(5660300002)(41300700001)(40460700003)(8936002)(2906002)(4326008)(82310400005)(8676002)(40480700001)(186003)(26005)(107886003)(336012)(16526019)(47076005)(1076003)(6666004)(956004)(54906003)(316002)(2616005)(6916009)(70586007)(478600001)(70206006)(36756003)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 15:21:21.0578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4521fdac-d719-4076-104e-08dad6d45d36
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT013.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3960

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Switchtest only tested intended switches between primary and secondary
mode in userland.

Let the rtuo thread also test fault based migrations and migrations that
occur while in kernel mode.

This patch series will also test the bug that was fixed in
829d4d33cb7aa3ee485ad56da6ac0c3b0ce5dbe5

Changes since v1:
- Squash patches 1 and 2 aswell as 3 and 4
- Call the correct rtswitch_to_xxx function after mode switch in the
  switchtest driver
- Only switch to secondary mode by using a linux syscall or by a call to
  cobalt_thread_relax()

Tobias Schaffner (3):
  switchtest: split the set_mode method
  switchtest: test multiple secondary switch cases
  switchtest: test mode switche while in kernel mode

 include/rtdm/uapi/testing.h         |  10 ++
 kernel/drivers/testing/switchtest.c |   8 ++
 testsuite/switchtest/switchtest.c   | 142 +++++++++++++++++++++-------
 3 files changed, 126 insertions(+), 34 deletions(-)

-- 
2.34.1

