Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75BA23BD
	for <xenomai@lists.linux.dev>; Mon, 12 Dec 2022 12:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hM1w2l63RhnHFAeWYohhxnxyaGRiQDK0K3F8iGsMXjnqvWaoG4Pf+X8SBzw3dzVqwRi/nxRB+4PS13fDe9czQf8IHplOUX/vCnT9nOTEgRfEaM6TFvc/Ezidswpke+nw9hsW0u9Giz/QHxnSZSHHnvezSesSBz3g/8z6jjIRr1uGIt5Egvzirs902RbE2x9g007/IZkZSTlqOaBkz/lY5GKgfeQxijLuDr5Tj/gVtkK3xEBE2uKBZEslGK29snVt0MPmcgPqsm/sWW1QtdB90T8AEVLWQpnVJEjVBXYa5q+Ah2H5F/C4T+nHQ2jhpnauIdQFrAsDUdwbGU3pvhFe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRTy71xq9D4ZmcV5duPuJ1rN8mE80e4/tvTvcaZdiuQ=;
 b=KU+NQ5JO48VI4WFnx3BH6jCpjg+qs5+gGRlzp/Gw5sdAjiEdccBTd2gU8WBbJCugI+J7latZDi5jZbKdZU6pWDlkeI2mZkX/7ai6ScnojTl6NfkjeDBT9gPzmrRhH07Fa4+QKOsrPSX4Xfu/SALhhGhzWtmVL2eYi7e8r7efArGr2O+uZXb0CtQPh4EVbbdOYnCJxfs4Bk+M3c1gsRJ8GXHdbhB6MBQkoCIHv7M/QBiWlvAW4S0tM2Ob9BRFcPWk4mfAqPUv8g7fDkNL4ASPKArJQg+1ZZmbyp3ykKN5M5ZAl3cxSoZ9DXiLB/eyG5Xwg8u3EMia+mcgKbli/gS4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRTy71xq9D4ZmcV5duPuJ1rN8mE80e4/tvTvcaZdiuQ=;
 b=GEHyiJ8QTcHJ8s4x6KmRnyiElY/GDRjjM+9XRVaYTHYvfT1UO6OlJlULcGRs5H7wq5DLdK8yca0I+Bu6W9pE5LeVQbRO6/CgvhmuGEJzFCd1HB56MVsB81bTLigeDN2jN0LnAz9tOWH+f/KOnqK7aN6mN9e8g5YlUBY+uj4cRptyyzROKi/dE+Rs8AnVy7n5TAAl86684d5oVnJnVD1/bjwCiEtWxfzGN1oJlHQojMS+fqik2dqxzEfVHIGrEC59D8Dq3wf818LCIsKb9q6CJ5nTOr8S7JSb/tiYSr0Yh1zQ2aOkZ9BtVmjtDJt2nQG3SQynVIgjQIOk8CbvwdKmSw==
Received: from GVX0EPF000013D9.SWEP280.PROD.OUTLOOK.COM (2603:10a6:144:1::15)
 by PAVPR10MB7257.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:310::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 12:17:40 +0000
Received: from HE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e1f::203) by GVX0EPF000013D9.outlook.office365.com
 (2603:1026:900:2::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25 via Frontend
 Transport; Mon, 12 Dec 2022 12:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT040.mail.protection.outlook.com (10.152.1.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.20 via Frontend Transport; Mon, 12 Dec 2022 12:17:39 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 12 Dec 2022 13:17:39 +0100
Received: from L15-Gen2.fritz.box (139.21.146.182) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 12 Dec 2022 13:17:38 +0100
From: "T. Schaffner" <tobias.schaffner@siemens.com>
To: <xenomai@lists.linux.dev>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>, Tobias Schaffner
	<tobias.schaffner@siemens.com>
Subject: [PATCH v3 0/3] switchtest: test different migration types
Date: Mon, 12 Dec 2022 13:16:47 +0100
Message-ID: <20221212121650.1294772-1-tobias.schaffner@siemens.com>
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
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT040:EE_|PAVPR10MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: f216859f-db46-455a-9973-08dadc3adcd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CkJI0XHGhyq9uEHOgzuDd5l4GkWSA2QwsNKtBuxPszreMiBoxmHfQHVvVeE0kwiBA+40Sp7DUrzVMDPnmuepE9rOBTRjnKyw9HLiwfRrrVqih9snGpBnTna63EQc+GMUU/BFBq5CUB649JuQVSGbctuVaAzDm9zqzu/xaXJV8WseJLsvA2R5xERqkbGAmeBnTKgemjKXLhRV5tnKxGvJgccmaHEgS+Dwzqks6WnEaJdkDsKB4nQOUpJTD1g29M1mxk0xayya5nnjWZf8fcvjvQLy8uxEhJxGkb/bQFxL+Te2kTz/78go2n7eSnckdMUhJbz5nN1nwhdrsooRzdWp+daOETR0shdD1cbhs/1fRziYa7+qqdToecUpi/9fJry5pvKu7/t18TUN+fw4KFB5j8EvVO/bTUaddrUYEpl+4Hq0HW8WkEpvpAuwn0Oj7W0wrer/dWoDsdAHH2K/0e/kem64hMQSC2mDlCIvuXRwFm3+oVbmAzi3IeDoqF2urxYC+lx60zzmbZJRcTUOOql6hV9/5hz1tAYa0d0/fA3SL72NpVkcLTqUR6Rh7aN/+5oUHEwTiV1enzRdzDbwhO3OMdPnqbVqfGFxiDnHwc6YUo04I5z2AxqAP+V7nTKGyyBkdZI45GLZGwpF0AUbr4MpSJXsJOm40Dgefbz3zIoX9CKleBNMUJp1lvIjMD8BGzGFrwtlc3Ag7ZvhCzl6gMZolP5J9rIjVB9UapbrKhcJuALNU4QbqPYMSvFdxNagZfHboOGhOkcmpDfyXwov7kzd9A==
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(82960400001)(356005)(36860700001)(40460700003)(86362001)(40480700001)(81166007)(41300700001)(82310400005)(478600001)(6666004)(8936002)(107886003)(8676002)(70586007)(4326008)(6916009)(316002)(70206006)(83380400001)(54906003)(47076005)(2906002)(186003)(26005)(956004)(2616005)(1076003)(336012)(16526019)(5660300002)(36756003)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 12:17:39.6649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f216859f-db46-455a-9973-08dadc3adcd8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7257

From: Tobias Schaffner <tobias.schaffner@siemens.com>

Switchtest only tested intended switches between primary and secondary
mode in userland.

Let the rtuo thread also test fault based migrations and migrations that
occur while in kernel mode.

This patch series will also test the bug that was fixed in
829d4d33cb7aa3ee485ad56da6ac0c3b0ce5dbe5

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

 include/rtdm/uapi/testing.h         |  10 ++
 kernel/drivers/testing/switchtest.c |   8 ++
 testsuite/switchtest/switchtest.c   | 143 +++++++++++++++++++++-------
 3 files changed, 127 insertions(+), 34 deletions(-)

-- 
2.34.1

