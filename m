Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3DA45BF9
	for <xenomai@lists.linux.dev>; Sun, 17 Dec 2023 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IicbhzN+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkecH0PJBOp88f6L0es2wzzMv5AL9Vf5A0eiHWDC5Iip54n5w4qA/1X3RtWrgWPQd1B7OPnEu7Cus4kjlBOrSgSIja8UC3i6GcWcAW6uqlOMF3imHyCa/pXXJ7ES0rnSI7/oc2nXapWmrgkgQSKQ4sFiMlnfM5hqFWVYthDtYLtwHbx4kyZWjbvtP2gv1FFtT2thZT06VAyuFFN8Y3bn4vDtmSB4IvXzcDkO8QN40VETGngCCKQ7GaolDlBADqlTauo9mLMcejCKrlcnPmWsxR1q/61E1u/SaowVPVslgtkfcitA0J/q+0Um7UUBiz6+HlDPVBquzUrwaV7ELxVo5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bl2gpYbzUHcVXMXuPS4z/d+AHTXeyYocRjEAM4/Kzwk=;
 b=CO3D2yzi134ic49CfYAt0vL0kMMQhESS0EQLljTje2EunYXqjfJoHBh7EhfxfI3waDal/J0QAPYrp5fcIK/n5XxCyme/O734tGOp5rPfJ2xFMzErJjWC6AliDoDM71ipuL7JBZ5xk+gBhba9pSQUitkYNgzVaxTqYwkIa+jvQr1VtpI5WA0gyqypIxDsv1ZkIFeOi8fElzE6V/P59XsdBEt1GOdSWL9NlSZ/8wY2c9CCMdX8p4JGO6YFbCtVBpEJ/i4U0EuvX0MLwuwqqICbT12a8VCJNcRKV9miWpZxpT4hqfYaknzdB7cIXpfgOKd3wk5YB9nQi3aNYuA1FN8oEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl2gpYbzUHcVXMXuPS4z/d+AHTXeyYocRjEAM4/Kzwk=;
 b=IicbhzN+mZJsO5AeJT33xE8mMrZcjX2DCLJSzgV15QpuaO3ZmPm0y0fFcXrK/pnPlwhE138VWaTdr7ltktE9/YB04cf9P2jQ5J5S168W6kr7jP8y/DHcSmg00Rpi6L6ubbwFnUeHdqc9N+0aueDlSN8qMHGYWO/4VMgqaYNhFM3YQGjYJGXdqVRtI5b05hxDWkM0PTdG1G9RboVIHY6KSiZ/vamxhtE8RH6z+wf/xO6+EWBPzcBjra/gyavvXc4H5BPFyQ08Q12fuAhxdx1fSqjZJGjJDDYFUhKgNRWRo3E2YNNg7YqkMci/4yt1Z7L4Qq8rMvMh+pnthwBnYYcw9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Sun, 17 Dec
 2023 16:24:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 16:24:35 +0000
Message-ID: <7a7c1161-1b06-409c-8ded-c03fa1ac4490@siemens.com>
Date: Sun, 17 Dec 2023 17:24:35 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] Kconfig: Use term "latest release" also for
 kernels
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3617:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9cb826-ddeb-4030-60ae-08dbff1ca893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g2oB3cKAykUH5tWj9efd/q1GWG9szxlAfoUZ//U26hxpT56jvTzzMyv6AbOuq+XrXGrLH5eZ/xyhskodChzxiFU3l3QFDy7SEEflnJgYpUKmRuePNVL3/Wtu3Fctg66kaVpQl9IpBhunIfk6zMwtr9+PG/UjIIewf4gUeyVsACLQUSMGJlhoNJMDa82eUZsm6JVuAd12goH+BE04Cvf7nIX/JoBpDZdHkDx/MtCfj2lQtheo10peJTN52qqzRbJHVPGmL1n7OIdmW+3ZSDGtSfT7FyOx2Ek8KvnvTtxV8MIMk9MMX6TTWUPUWpx+aA+JF5cXbOD6VQ8Pg/s4Rlt5eHweJ9BUwdSH+vD3QzxPM++mfHbyMR6DJU5Io0RsvSGlX7JX+H8n0foudMMGGe3bgykc9Ei8jhoL83XO8XWJ7VBj7H3d9Oo991tdmfnavdIlUKcv8GRK5Hm5emQxjLauDWGKexsOL7tjp2ZT75Wf8q/tjIDGw9ynxgfbp7FiBgBgyz3A6V2kEtJOps/K0foNu2xLlzTtFFqm2JE3qWTxGS/Q6lzhlqHyKVpb026DPWvATuQzzr8LoNdLnwtKMWMnsMeJUDfSjT/7VqXKHs9Exndyx/fDF9dhI0LtxWEcgqWW7rFimSuaF/B99K6V1nxmxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(26005)(38100700002)(8676002)(8936002)(5660300002)(44832011)(41300700001)(2906002)(478600001)(6486002)(66946007)(6506007)(6512007)(66476007)(66556008)(316002)(6916009)(36756003)(31696002)(86362001)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUNYbysvcVRJZU4rWUpQcXdoYVdUcUN0NHJBancrbW4yUjYyRERkaGVBSzJO?=
 =?utf-8?B?Mmd0R0VSNGpIVFl0VjhyVUtlZEVWOW5odEpIeTV5UGI3Syt6U1k4bk9yL0Uy?=
 =?utf-8?B?eFRXTFBteXZ6UzhQWEswcjZ0L3F6UXVJNEorNmRzT3cxRVl2L3p1TVB4R2la?=
 =?utf-8?B?NXRNUWVLMEZzQ0xOck5ab1R3bkJnT3JSaGlpMmZRTXdpTE0rMnEyanZoWVFD?=
 =?utf-8?B?TzYyVU5hY2J4ZFZ0VFhiQkNtTFB0OHl6WWUrMm5jb3ViM21zTXlLc3g5RHZE?=
 =?utf-8?B?UmdxTG5vbmN3VjJIaFRkZC92NDlUUTNteWhtM05OMmUwN0F6cUNQVllEd3F0?=
 =?utf-8?B?TWsvM3RPUGpUOHlOeCtaSWZONDFtcUlQM1ZHMkljcFNyUDVkMEhRaVNLM1l6?=
 =?utf-8?B?aWpZNXRmWnpUVzBqNFdndTZmSWZKZkxhWUd1NUNqY3RLa1lNUDhScVh0bFIr?=
 =?utf-8?B?clJGSk5TNXRHd2htNE9pRFRNVmkxSHpJSkZkZlY1aDdtR1ZJaDd6VGhXa3Jt?=
 =?utf-8?B?ODZ6b2JYblUybFJyVVMrbUtScmxJSi9JUTVnTCsydzdrZ0VrVytxOXVhSmll?=
 =?utf-8?B?d1hQT3dvbFZLcUxxMjNnTUFWSTAvbVhVd3dOUTE1T1p2L0dRWDdxbUhiZHYx?=
 =?utf-8?B?TlJtWndiaVdlWTVMMURWTHJycFN6bEduS3p2V1k1TDhZcHQ3Q2RFb0JaNWZl?=
 =?utf-8?B?dmJVaDdyamdaS3RuS2V6bjNFa01wM0VwYkxEQU1xNWZhc0JYRVVjUUhYU3Vs?=
 =?utf-8?B?VmM4RDkyM3RKNHJ6QUlCTEhzcGkvUHJVbUhJek8reXJxSUMrSE44NkplVjNG?=
 =?utf-8?B?alBOcWVLMTZmSjU5cEVmNEdTQ04rK2t6M1BJaUhCNlBvemJCWVlaaEphcmdH?=
 =?utf-8?B?Ny9YMC91VFowT29NNlVYTUJGc2dhdm9ZbUtkZmVFb1dMeWVLR3pFSDdueUlz?=
 =?utf-8?B?NUpabUJ2Vkx6dmhKRmsxUUJxdVoxWWF3UXJZNldrbTNDd05jeFMxc25iVWph?=
 =?utf-8?B?QkZNY0pFYkwwZ3dMQmx1TVhmZlJYenJ4ajJZKzhIQ3dHTURNQ3hjSk1sWGhT?=
 =?utf-8?B?TGRrd1hyMVNYZFMzK0lVaXFWV0NHVklBTjJ0VEZEVUptWDE4VEJLcHZhZmVZ?=
 =?utf-8?B?SEFGZ2ViSERwTDFxd0QzYlJkZmYwTUF1TE5rYk93ZFdRYjVXd1VNd1NEUHlV?=
 =?utf-8?B?QzVXVCtLKzZUT3VOSnBtaVFGVnVDeThBZ0NTN1BwM1AwQ0gzb1F6TStvbDlT?=
 =?utf-8?B?dmhnbmVUQUdXZFFDcFd1QVdRQ0VmemR4VktVcVpReVN1eWZ5YzJQR1oyNE16?=
 =?utf-8?B?VERGemJZTWtYK0tQL3E3elN1WElmNldlcWhzU2lMSFFYZlRoZzRLNHMwanVi?=
 =?utf-8?B?bkRQeGFLZWlITWN1WjhIUTVXcTdYWWlxRUkrOEtxKzFFOTFwbUJjNU9TekdZ?=
 =?utf-8?B?bVVFSG8yMjdQK2hmM000ZlMzNERYeTJJQTgwaVcwZXh6dThXNVlKbDc2ZWhM?=
 =?utf-8?B?S0Y5NmJCV2VJcWpyYmJSOGVKWlVzeFZDbzBQcHRaVW9HbnAvWm4rMm4zR2ZB?=
 =?utf-8?B?UmJqenc2clZNYUx5WG94R1Y4OEF0ZitieGxFSTczQXVtQm5JQ0hjalZXM2w1?=
 =?utf-8?B?aVRudWs2S0lnd2t3eUxhM1dUWS9kZ1VqeEkvWm4xa1cvYi9TVWc2T0pBa1No?=
 =?utf-8?B?V1M0dVBhWk5WNlBwS1A2YVZIUk94MVgwbE1JLzkyWFFCa0M3dUh3MWRQbFRS?=
 =?utf-8?B?RDlzNDdISmcrZHFsYkNuZmlSQUpwYWIyRHZwZkhYQ1ZOdXZCeWdHNjNpTTNj?=
 =?utf-8?B?dGhieWl0WmU2dmJBY1ZLNDIxSTdlaDRjU2tvdjFLemVOZUpyY01CaXFET2c2?=
 =?utf-8?B?cmdsOHBBUHJUeUgyOVFjMERSTWtlODJ5QWtPU2VERm1kSWo1SXRYb1dEbFFL?=
 =?utf-8?B?QklkOEJjL0J0L090cHBKYk1WN1lVNFdSL0JmM3dFRG1iWmx3bW5rT1BEUVNL?=
 =?utf-8?B?OHF3ejVpNWRsRkp0cVNlV25NVVkvQk1janFWc1lZZFNDdExwVWQyYVAySlpS?=
 =?utf-8?B?R0NxRGJKS002MkxKZVhPUnVoeTVqdlRKUU0yWnpaTldOREc1d1N5NG1PUlRP?=
 =?utf-8?Q?NZkrRdHKc8TzS3/cvB+ZLkV/W?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9cb826-ddeb-4030-60ae-08dbff1ca893
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 16:24:35.6507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pa9NEtUjoZ2R5+Q1cjU91ji+l05C1+u+WL6tox3xVYBMx8np3b6u9oZsgmIlY2r+S06TYvVYSahN/HS0pSFcvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3617

From: Jan Kiszka <jan.kiszka@siemens.com>

Aligns the kernel version labels with that of Xenomai ("Latest 3.2.x
release").

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Kconfig b/Kconfig
index 3cc4e5b..9f73d79 100644
--- a/Kconfig
+++ b/Kconfig
@@ -98,7 +98,7 @@ config KERNEL_6_1_LATEST
 	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_6_1
-	bool "Latest 6.1 Dovetail version"
+	bool "Latest 6.1 Dovetail release"
 	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_15_LATEST
@@ -106,7 +106,7 @@ config KERNEL_5_15_LATEST
 	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_15
-	bool "Latest 5.15 Dovetail version"
+	bool "Latest 5.15 Dovetail release"
 	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_10_LATEST
@@ -114,7 +114,7 @@ config KERNEL_5_10_LATEST
 	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_10
-	bool "Latest 5.10 Dovetail version"
+	bool "Latest 5.10 Dovetail release"
 	depends on XENOMAI_LATEST || XENOMAI_3_2_LATEST || XENOMAI_3_2
 
 config KERNEL_5_4_LATEST
@@ -122,7 +122,7 @@ config KERNEL_5_4_LATEST
 	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
 
 config KERNEL_5_4
-	bool "Latest 5.4 I-pipe version"
+	bool "Latest 5.4 I-pipe release"
 	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
 
 config KERNEL_4_19_LATEST
@@ -130,7 +130,7 @@ config KERNEL_4_19_LATEST
 	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
 
 config KERNEL_4_19
-	bool "Latest 4.19-cip I-pipe version"
+	bool "Latest 4.19-cip I-pipe release"
 	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
 
 config KERNEL_4_4_LATEST
@@ -138,7 +138,7 @@ config KERNEL_4_4_LATEST
 	depends on XENOMAI_3_0_LATEST
 
 config KERNEL_4_4
-	bool "Latest 4.4-cip I-pipe version"
+	bool "Latest 4.4-cip I-pipe release"
 	depends on XENOMAI_3_0_LATEST
 
 endchoice
-- 
2.35.3
