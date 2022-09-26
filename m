Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00069.outbound.protection.outlook.com [40.107.0.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E438D
	for <xenomai@lists.linux.dev>; Mon, 26 Sep 2022 16:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKbflS0d5/1M85SyOG1KQxPN3x0nid0XC7NvCcvyhpdqhZimjSIpV3rUQ+q0iTnG/H9HsbEgVANg7vdUz9er9LQIi/9KuVWue2grMhrQcmQbHHFvbT23sIhLO2vyMaFcxJxWy+4lYv7Qy8lSKEaUTgZ5IWEPahbGdR7svUB1H/WzJQMFtbhQ3JWV75T+YbfTMQhqUDkZPv5iix2O3tOObXhO9raVO2rE8rRLWvIzT6n94o2id9Ak+VEUFhWfVJD9Ah76cIm7NTJ57m9eDw//4vlWXVQ3rieTyz8Fz/FFUZKoZchjtYWCnLXC+1zLyb2S+0uHDzQ6RvOu6cwc1LdRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdzImi50rkPpBnHL6b27ecPTCKJKnCBlT1qMCjHR+7Y=;
 b=XmQ3E9s6KD9uyVOYfOgyTOoowYVb3RKLl2pcqqW+4BUN8DRmn69nyL6vpvQG4Y5kZW9N41hEVcCR2q5LM0DwWo0R3JpR/MMgt+l3iXBuGRtVtE5Td2NMKGyim09ylWJKuIa3GaIFieSQckjHBIOsA4BD3DQQcalOmYHbzfCNIidjAe8yb+wtADw64+9XBDVhjoRhUcfNfBqFnvKuo2Gqsv/5hITfqcPz6DXHBFTbdJKKLYqIT7wcmt/E4TBOE1X6RFDR01Wytz1xA/eFY7fTqhmW3g40k7kHEVf/pnbRcut3KB9jmJJE5BdpxQUgL95+pCwUO1+Z/rEABFnqyRAM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdzImi50rkPpBnHL6b27ecPTCKJKnCBlT1qMCjHR+7Y=;
 b=WVL1fZa/6RK5bzdeAjPMm7Av8l5HXlRJ1eblOO+v3U00SrgKjf8vSXDU2QhaLackCzPtA/7xcOHcMfZx1Js2OchfsIclaOj83CEnY9Nnvmlxybr3+hV1AlX+TthqYx5bjgIlZc8qlurGyyR7z7yFAdjJbo20PadRmiae+2aFe6AdbzqhD8acjfH8qdztw5a/Q5sxffNK+qnrU1kWO9yhTDYeOBz0XT+WHT2GQeMskaujV/BGzdX69jIISd92emyxp+eS5U3/K9X93V8FHQ9lUjU3twIQcVqciwl7i1ZHFlwaovynSUCJvEigZVEIWDTttB4I5+obDY69vcKI89HsoQ==
Received: from DB3PR06CA0011.eurprd06.prod.outlook.com (2603:10a6:8:1::24) by
 AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:591::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 16:31:52 +0000
Received: from DB5EUR01FT018.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:8:1:cafe::76) by DB3PR06CA0011.outlook.office365.com
 (2603:10a6:8:1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 16:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT018.mail.protection.outlook.com (10.152.4.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 16:31:51 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 26 Sep 2022 18:31:51 +0200
Received: from [167.87.17.23] (167.87.17.23) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 26 Sep
 2022 18:31:51 +0200
Message-ID: <f564636a-8f6b-30b6-b9af-82c297d6b648@siemens.com>
Date: Mon, 26 Sep 2022 18:31:50 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] Update to kas 3.1
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.17.23]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.344800-8.000000
X-TMASE-MatchedRID: dh+U1xplaFMwfXkTrrUIE7CBwcM2jkC0IeFIFB+CV+wD2WXLXdz+Af6u
	GOfv9tMUEd+K6O5Nt521JtkKyX2MjiFhmazzAKYp5ASSCWKkZHe+f28f3A7AdVjYbsfv83HE6qG
	5M9QNAO3tmBTw3VGW6fw6wH58706f4vM1YF6AJbZFi+KwZZttL/nZI3fdS4AA3QfwsVk0UbtuRX
	h7bFKB7ovvWCpGUD/qmzrqP9zXoRRPRTAWe//7FbGDCrVObpt0H8FerAT0dJY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.344800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 432D76E0AB76A3DA8A8EB890A20D03AE7A0D2410D11F7E177E3842E2C73931C42000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT018:EE_|AS2PR10MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b207829-6b66-4ae3-31e8-08da9fdc9e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7mIrviH/UzXKq1zqhTKlVNGR4WC10DCK4ptlYC+PtEpSF5H19k2bOUByjqaaGomMfTB5u4omWbIk4UyT4EE8YDb+ECbJyrrEaQSQXz4QkhUTWwkmzIxrcPo01BTPcq6Xtih0l6ENYgLlInkrb880Id2YA96ZjDWC/7Ckj+WEQfslsg9jAsLarugCC7Oqg+Q1DGMpErgik7M8pmoVABYzhR4WgKPb8K9a8P+6vTmASA/r4m5oGlSWRq9NpoEmyzvU/4oXnokBymukVSnGqjYc3TjbiBq7iP7XxUvenREvXEVyTCEVD66ShKzsiV/Df5rSHcmXY1/f7RfW8FzzAfU6YMq6HCdvk95FMFpJbRAlljAufSvmk1TqcNn0B3bcFwwrpP9itmIkK/8D8Vfd2Y31amdDfhQI3RArBFL4rfZ6POpGvOOb7yZWukt2xd6jYvj6wZgxBnjzLcs8P8s9y9cE3WXrD2drfenIvX1pV7qQ4auTyMf6aWtvMOWppfBlJnHw71eFtl1ZqNgiVjrO61JEuT89W5H5RL6N4gmM1o+hq43SgmAkku+JgjcUH2ewzJ2CiRHIzPnuw1szAuqOh4+nt4NMla1sye7ykvQxThF2ocFiM1+Q7AeOTLd9YkEex2SiYPmdMMBEWKzzVk4j41m/5/T6Sc2g0CAcpIC2B8uRrPIIskho+sNla8zJ8iX1XqlwGtgziyc0DI3/XTMqovGkl3/5p7t7KKL+BzZ6HtQS6AyVgy/7+vc02gzhm82IKx9+wA3Q1HiGXZTJVfIcarW7gScU3DZiLhYflDavzLZvrg8hQhr/N8mit3u8xBIC0Z9XHcsq9HmMEs/h2c69C09YlvaHeCPj5v2g+X8IyvGREEr3rImEUYtG7VWT1bq8BTPlIt4Gq41VBlBEEJKluEYnhQ==
X-Forefront-Antispam-Report:
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(44832011)(4744005)(26005)(5660300002)(36756003)(2616005)(956004)(8936002)(2906002)(70206006)(70586007)(8676002)(41300700001)(31696002)(86362001)(40480700001)(82740400003)(47076005)(36860700001)(186003)(336012)(16526019)(82960400001)(7596003)(7636003)(82310400005)(40460700003)(356005)(966005)(316002)(16576012)(6706004)(6916009)(31686004)(83380400001)(478600001)(84970400001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 16:31:51.9138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b207829-6b66-4ae3-31e8-08da9fdc9e0f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7551

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README.md             | 2 +-
 ci/gitlab-ci-base.yml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index 5f6c4c7..392865a 100644
--- a/README.md
+++ b/README.md
@@ -13,7 +13,7 @@ from scratch.
 
 Install `kas-container` from the [kas project](https://github.com/siemens/kas):
 
-    wget https://raw.githubusercontent.com/siemens/kas/2.6.3/kas-container -P ~/bin/
+    wget https://raw.githubusercontent.com/siemens/kas/3.1/kas-container -P ~/bin/
     chmod a+x ~/bin/kas-container
 
 Furthermore, install docker and make sure you have required permissions to
diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 83bfe0b..065543b 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -25,7 +25,7 @@ variables:
   ALT_DNS_SERVER: ""
 
 default:
-  image: ghcr.io/siemens/kas/kas-isar:2.6.3
+  image: ghcr.io/siemens/kas/kas-isar:3.1
 
 .common-config:
   before_script:
-- 
2.35.3
