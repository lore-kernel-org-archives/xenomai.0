Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2770123D6
	for <xenomai@lists.linux.dev>; Thu, 18 Aug 2022 07:31:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQTDrwhAF54Fo59mvxD1Br0pfi/3Gn+pQwdU2h/p9ptt9jVG0eLAzqVsbPX9wTKWoY3hIGpDF1Bbx8s+jEaIhat1nWlDBCKQ0OCBMgelc9M+zlzC3jLQq3Ti++m4hyke54HNhnnHceUJkAUby1FlSqovabIJvvCdNya7LsU8IUHblm+zetQYoZDg4t2WiGhG0pzr3G8hOAYI+mkS1qTXnZNBoIuk4gDDy1dol+myw4JC64wmnNP8cv83B/xVRTC6sRySgPdshNIo/FyadvUPZg0SYjiDR6zOuqzjAjdOdr4itwxAbqwvn5dpdpZK2rVUz7HTsnRf1E3NJdodlmMtmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UB82+w0dxSW1GGjGU+h3BURu3Z4E06rJMQoGQm6D1+c=;
 b=Xx6f2F+htGc+q8cEcwSJ9vr+FRRpMYpy4rBSeeb4KH5NMvtw3iChidrZRua0w5CNL0/wk6+c0BODhJ4SpI36U4RII9WroVBxTSo3ocMcmYNsr5/DQieh4D5s8ajEx+vUutuXalO87q+3d5EPrrAZ93doLrX/20Op3Tlv1WokVvUuCahhHj/+HwbnVbY/LF64UqyZx8MBsz94mR315G6T3UyF2APJ7o1Fn/E13KZIytJVLhEv9Ekq46jbx9YHWfJyq8K7LlBYJZP1dY91j0wB1uBaKNT+RERtMJu51MoT3tUXekcjRQPZCkWSAKbeeKGjdV7siCniuocNxSICViAn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB82+w0dxSW1GGjGU+h3BURu3Z4E06rJMQoGQm6D1+c=;
 b=SigBXOVBCpd52lOLb3oYEAa+F+a6lJJE46zNZYSXwGvyjKcOZDns0L52dOFPeJsDOz+6J4pFA4tYKODJ/wkYQ0tmN83uo1NvHo/JJAhQKdJtR1Idqgdfccip08VRp3T4jQV/7DTe+7uR0mCchz1pxR30DKLYmCiuxu/4JoztZiu0SwKiOX29GDqGfJfjsxKZaINaRvAgJ/MhD1lewSeR4XgCkLI0MjWiuZito1XRVQSxjkEXaG+7VJghBartTFLQnKjsziopjbtgYRgS4L8T67HpR47BxdAZDtx1RRo86a1xuKjNnv6wdAC7m0QRyC0CNnThNONnHMcGORl47OTzag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS4PR10MB5342.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Thu, 18 Aug
 2022 07:31:17 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.027; Thu, 18 Aug 2022
 07:31:17 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images] [PATCH 1/3] linux-xenomai: Update kernel from 5.15.9 to 5.15.57
Date: Thu, 18 Aug 2022 09:31:11 +0200
Message-Id: <20220818073113.19382-2-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818073113.19382-1-florian.bezdeka@siemens.com>
References: <20220818073113.19382-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::22) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd8122d8-f4dd-49ec-e08c-08da80eba38f
X-MS-TrafficTypeDiagnostic: AS4PR10MB5342:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WQlu5ZpgxcLz50QMmBqAh2dfI7E7qMua/lRUF18pjRlYyN+3IpbLmtogWeAJIjvrqOO3Y7LDgJ0v5EBi5oT1Ha3BeyLJdXj+MDZzeeupAa3KcU5cs/0A2AQYvta+Kf/g/UqHr8qWJb2LqXOFBJf5sq/J1WnJgkOpwZ9O95cS3qbda5F2WnK0fQfXjSOEV72vnYaNquOXFNWRvtmioGti2t3EdWspfk0kpBjfqkZ0ijjHCDs83dJip7N9owldd8i6SRlmfg3aBkKheBGfux5VdY+8bvPJwxMwaNxDGzhQMgTFnl2GqffTRybhqokcNpeux9GK6uQq1HSGdH3pBss7oxC5tY0fTXRWH8BdKafxQ3s/7GNBeD/Mwot6aseaKUE8gzM50/qz7xXkpkrjRkX/vATItORmgk4E6ol/eh7Yi4T9mEiQGPecZ9IKljlqYPNUnCrF/NQywkQQ51zpbqUIYU2t/gq+aCEXUbF2r7ohHO+68pySE3Pz9o7hmGIut44efFyFaMUDGJdYYQY5N61kRoJJv4WNizrfeUcRK2HetUba3IpaiA6kRAlSNkk7xBw5Ddgn2xRiA3uP9lYTk6j43Ap4sDKeBz6sE2lvfcmZZ2NGoSAdk/OF26PjlTCFcX2MMwWULMEyPOopowjNV1qd+f5/TMnpBL9V/L+uVamWYk/16lXIF0vRSbJaOuSmiN+sitcCMW22lcDn6dTKJiwF+Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(5660300002)(4744005)(2906002)(44832011)(86362001)(6512007)(82960400001)(2616005)(1076003)(41300700001)(478600001)(6666004)(6506007)(8936002)(83380400001)(107886003)(6916009)(186003)(316002)(8676002)(66946007)(4326008)(6486002)(66556008)(38100700002)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kw8gvppQLmILGw/Gdo/gvmbVuD6Nl97zqgN6XWoQ475xY4K+WnuVF2t9+Cvh?=
 =?us-ascii?Q?XzEBL7Zcr1FelR20RuD0AQmW0O6FlVA6eG3UOutTT+SiSIAvZYpkj/GPfFXu?=
 =?us-ascii?Q?OYOTKaWLEXJX25Ng5k8YOKndh9yX5TnDImcXRWoagbJbIuQeQOEMFJd8Hz0V?=
 =?us-ascii?Q?Tn0fKjDgLty+JR9HKQx9XWZtG5EOoOavUWlioWn+QBQ3L85Ep2V+tcgM39NP?=
 =?us-ascii?Q?kBnEnzvHz4MWiivYbxZRjvWP1Ah5opGXJPSW/NoN7nQm+gOM/rL5jXM8+Zsy?=
 =?us-ascii?Q?fYf9aDWH57waU+FEuJO+M4trW0b8qXm6nLyGOG4Bnatr/ct2ONKfEEA7ei1c?=
 =?us-ascii?Q?mI63Ha8lW9Z45xInQyLzPTp4uWAIrVWHZzyUETfXcZp/WuHmSV8ufoGP8smx?=
 =?us-ascii?Q?kuBcuZ1ikOldJTQZZ8AL8jM4daOZNHkYftwq2b9+YLRnpcfjqdmsTJy4n9ES?=
 =?us-ascii?Q?67kmqPWYE3/Ibf0SPCfBqmenZxpf0z5qMwYAJHE+trHGdK0jGnPw8coNscrB?=
 =?us-ascii?Q?fZSBqjxQYAgG5NRXUdIv30eqJDKHThUCKnclmb+PT4BMTdWM5flIor8FfWVv?=
 =?us-ascii?Q?N1f5fwLhULuY6lUgxLG7ysfiqbzW4ImgX0Y1sp2m6wouSKxdDhSRptED2ND4?=
 =?us-ascii?Q?kW0hJk3q+QEZpZSYXsALpfZoGLHHr3SldWYwpx4ysiZu5qVPKutaGXfJpYmY?=
 =?us-ascii?Q?beJ5l5cUcIiRy8IfmZNH0gbdL1+tyRnWjRvZN9WSfHTbOnKLObWwlizFZ5qc?=
 =?us-ascii?Q?DXpUMJd4JRvRKd0m7sB6gze4SrRVqhzqf25umLscW4VvrI95qlcd6lg/U8oV?=
 =?us-ascii?Q?zgF2V4RFeeUisQ+HL1Ea0c1lmn5h3yld1jOiMNB5lPEDiIberZ7kcA/e+BaI?=
 =?us-ascii?Q?6G0QB73KWoY6Nv935PTadOnywhBwd1fyiWZQiz44GIleqCVBwWMvyQOVkGO8?=
 =?us-ascii?Q?yPlVPqVkC+1BSzwRGGKI+BpA4NGWYLyj2RH4TMVGwZExenPmEqvv+D4kdusP?=
 =?us-ascii?Q?NFnXbwdhaV8gDyHuVn1mppigaEuS6G2/U9ZqYIApFO3tHGgjtW6aA9LA6Tat?=
 =?us-ascii?Q?IidW4awwot3Cv8V+B064WJRZh0M3OxhHQ3sYjrcVeU7TT+N1p3s/wrmepahu?=
 =?us-ascii?Q?C1+vhivvwOr2knIO05x1r4s7EwPWBzONmD7ZGDRM+W91lGRz3SoRpuBfsmMc?=
 =?us-ascii?Q?fQaX16PTLm2GlGAPVwimYQhCqtShF2Sp5p0VKmuYY+y11FLEih3fJ15vvrYa?=
 =?us-ascii?Q?ka79Xd2vA6BT9cTLSAQYQmgn24uE1NJreSHLqHgSbYt/QacaRN4hlC0mL/LM?=
 =?us-ascii?Q?MGMq228fxwovFbCKKwkfS5CuTdYi2XO7ynhK3JDLRZEEjP5pjoBgRDsJ266W?=
 =?us-ascii?Q?K6YSuuHjwfP0o4xNOzNw/Ql1lsCWqndNKWC5mDcmEAHDHGEimCyltQIYTh1h?=
 =?us-ascii?Q?mi4Y/sTBDhD5xNCmEkzdRMms0y9bgpmOKKLtt2/aIJ+teTo6ejLRoOAT4/ac?=
 =?us-ascii?Q?dn0FD6+XVKQXtGWY8zziG50fKVJYZs4g2RpTztZlNL8/0bqlGa595cccnUU2?=
 =?us-ascii?Q?hzvyoHxhYXLd9SY4rjukbe0NGIUAQ/43sPzilQe5pT74DrGZ2DxQ+oBrOtXf?=
 =?us-ascii?Q?Mk5FbAhl5Bt79+6gie7OL0TTGMK7LnovEpbFzOavXTc+l849VeJv5GBB6Uzj?=
 =?us-ascii?Q?uAjfJw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8122d8-f4dd-49ec-e08c-08da80eba38f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 07:31:17.7069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7sDcwbjDwMRo4x0JSQ8QTGtx2XNZ8y/JMvFgZiy2DUwaj7oO29i/y6OH+S+qQSP2+PldRxzIWJn1AuvY0SmH3lG0HpR57qLo8n89KVpTkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5342

This fixes a test failure (x86io smokey test) on kernel 5.15.

The necessary dovetail fixes are available since 5.15.32-dovetail2, so
updating to the last available version 5.15.57-dovetail1 fixes the test.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_5.15.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai_5.15.bb b/recipes-kernel/linux/linux-xenomai_5.15.bb
index 9a3b12e..fcfc4b4 100644
--- a/recipes-kernel/linux/linux-xenomai_5.15.bb
+++ b/recipes-kernel/linux/linux-xenomai_5.15.bb
@@ -12,7 +12,7 @@
 require recipes-kernel/linux/linux-xenomai.inc
 
 SRC_URI += "git://source.denx.de/xenomai/linux-dovetail.git;protocol=https;nobranch=1"
-SRCREV = "v5.15.9-dovetail1"
-PV = "5.15.9+"
+SRCREV = "v5.15.57-dovetail1"
+PV = "5.15.57+"
 
 S = "${WORKDIR}/git"
-- 
2.37.2

