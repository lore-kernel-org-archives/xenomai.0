Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794892010;
	b=fv799/UeaKQlz4DN9JrsG/3/gHREfYswPnEIieR8Nt+M3NfoggNXA1fkqVCL3gRyO7XJ
	 s3QB70ER4F2Yy8baow5aszD2zDsdqjdjkCYSOwH6iG91reXGTFj8MJI5QDwvMH9Bg0Kg7
	 x+o0eyLPS/uWvZBUP1I7oL9koe0iOP3BBRYTIUYLjhDqYaJxKxlKLY6/KiH5AzSFfqRDT
	 otzvC6mXkRHKvzRY/b9OG9/cwj0zcYt3iYnbrqlf1dPEIOq+A/dbe7OpWU4JE95i9NgF2
	 Ny0olY42hSox0UgKIfbJPODRyvW6eN4AOr4emRJdhJ78v0Pa9Ys7jJU/0PeMV7r4y8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892010;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:Content-Language:To:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ayDfAPKD/Zb2jJQ9eyPdXUNqr+K3WNB3fZyMaE8oynQ=;
	b=rFRyStdCvDSEXTEpb6i9YUSVWadhAJBlcs8KroAOi+V0NB8vtVzC4slpr8eLa6QBpQog
	 rWNCyv8Mpvv+bSpMKN1CyCPKCeNP01g7Uqi91Ff9+AaXppyqfhnSbhRPN5/Rr7WBfO1wL
	 6dwxVJcgE75JLPbSqbjzzQ7yFEHVaJ3PrcSuWY2wn9T0vLLNbZaf0tHVW7g6qoTxvCIok
	 elVhbIxwrdOLRY3Kc8Pxd2mhVeOneMxNccoRdPF+4N/tMrYOtjnli6oaeTIwOO0+JH7EM
	 6YouIoKS75cBhQDpesedwCwv2HeW/ZiDnU0qnWrKEJdso+l+LCA6DTs8I3s+0kV2ZaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=PqDx40pA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.28
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010028.outbound.protection.outlook.com [52.101.84.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C99C606A323
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 05:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C99C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=PqDx40pA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbxCLxRY5l7Ep8LLDW8nfbw7dIQnvPpGIOs1iRjnAN0CNPqaM9+jmqRepQLOxdsvSQrdXzC1P60yEvjB9C3akX2z6ujt0KFIZG+7Opokb0p9/unQWuyy5N1/M4wYwg04RemOwv/3jgewH1lAnNKmlBYcqad2iuSIKOtq49VFCFlvADH3SvdSDt85Phac0smzT7ciPdhaynsAt1yDfUdcxV2Vfjhj+ukt6eJDThPaGJk6PxloeaoDeipVX2faWtG40IRL77NvkfkXeANGVojWPbXvI5YLBlmDuqik0RgnNuvVu9bW+LuHuqyiFPrujUcnlcBXn+kcMLuX2DsY9zsQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayDfAPKD/Zb2jJQ9eyPdXUNqr+K3WNB3fZyMaE8oynQ=;
 b=DjxU7hyJX9MCVqrEjvLtmSzqYDVqshlWEBIuYA1U1pUvKqCAdO/YzAbKp7R9vi1+XcPRsQ1f5uFGIN+2JSJD81sflED8idVkcu0+brzwmVliUO+l0j2CsFodssO4LKsCtZCLyyYmFaaGuSoP+eAuNspRkMlaToliwKOGLMMNAIXNbkaBGKzdl3xizw0aJnchi6H+5VSjrq+5WY3niKBcB022nyBMs4nbhoU83YaDWb1UwoMsvO4+kUOAtuTFs/5w+p33u95nlhBHR7sqXbO9Qxj3XO9ECu9KmSCFHnM4LNUVLS+UH+bmd+3iBz2Wule5XouV04yhSS8PDj3JlCoFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayDfAPKD/Zb2jJQ9eyPdXUNqr+K3WNB3fZyMaE8oynQ=;
 b=PqDx40pAw2qL4l8TS0Hah77cPdnyyfTPqcG66ZMtVeJSLV5I5vh4y1wEBI2PCJHqSrreYCFHRBjNWHBSw3FxTnLqstuvo0AI0bTteIGttxiQD/Pn/G7gNOZT4u98dvGzptXjMpiV9iLnv7ThHB6UX9nM/T7YysU3mPugrF3qw2Q3v5tUrvKv6XNsX7jsnmtSXbSBW+c5bwkS4O7kg2HF/vQWtjmObMcObaU8w1ukMuVL/5ajhbZsxAv8pPD54hBaDuaIwQXwfWG5fYMGFOlAsisWHPrnlBYGuAccsxviESv9D1JrDsSatoLNzEgFpVlt11ShrcW2DtT0ucqG/f6Glw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB9PR10MB5504.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:307::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 05:06:47 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 05:06:47 +0000
Message-ID: <5a8651c3-9f93-4ae2-b1b4-0fcbdc5a1501@siemens.com>
Date: Tue, 17 Nov 2026 06:06:46 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH] clocksource/exynos_mct: irq_pipeline: set
 clockevent IRQs
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::9) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB9PR10MB5504:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0f6d4c-5d12-4ea8-370d-08df4468950c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|55112099003|11063799006|56012099006|10067099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	4wGHvsN1gJ0VTg1spM8QwKuC/RF+kYwMhwMfAVt7bbR8pEGEQNjomZmTM4pA9ErTdtBDd6v0R/Fgizs1QNaYCeIMKfysPnNvp33XWUrm5cwSqtAm5F8FMrM5sfli1MsOWYNespulSLmA0okz3l9usHzX86A52KPR/fJ992Mor2b4vIcqW7UhwV2kU8GE9TJRRbwx1pHi3thhm5dGlje458XSDzjuT6nPmbB4JFZ8Dw24E/eYIPl42ebVbCrh28ZPs0W2hvXnn6CBO3KPw2Cw3TXxbToivNU4QE7xDJSIQwRCiMKXWd7/ZbcHzpW7gOxGLiulcmeHVndJTf9bSsPu2wfrA4rqyC/KdwvHrVha1TWex+xXPyd9zBXnisj17dK7SGdiTs0ObUjd3IJvNeF5Sk/UrAHaphis4TRpw6kmQZzi+zbbu7D/BXvctDfwvDAwOMtz7ibzKcaYbJpGiJyM0yqY2xM4IXnD89IInyKwKJGdGiV357TIw4/mDDYDqeFJD45m5BUwcywAcdMkM0gpOsl2JcvPXuiYZrRDbYOnkY4gAPbqMwSugz160amPJzTugExrZvhnN+4ufiIdTwVTLO/urAT9P7UvYCF8m6m6RU88hWmJipRGEU5UHMCBwIp4S+R6oHkruDBm9pmIS5vfruqTcnVJZaJ2l9MeJXBDp3M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(55112099003)(11063799006)(56012099006)(10067099003)(261021121427099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTV0K2xMWlJSKyt1am1ZS3lyZkY2SnhCc01pVTRCVWJOVlF1dENpWGdlR0xK?=
 =?utf-8?B?Yk1tMjlyajgyVDJ2a1RqM1NIVTBidTJDVlIycVFHalVsTHZIZ0pkSGRvL2VD?=
 =?utf-8?B?MnlKMXZjV1lHQnF6WEpmL3I3bVYzeERZb2hZaXlNS1Q1REI5dW9EYWt5REpS?=
 =?utf-8?B?WHMzSy92L0paU2VqQmZIc2VyN2pKYjAwYVc3V2orWGwzcTYwV1dDVWdGK2J2?=
 =?utf-8?B?MkVWWmlXbUJoUDBiWUZxTWtUSm5jYzcyZWFxNVNteTJ6VHZLTjJINVdOc2pa?=
 =?utf-8?B?am10Z01WeC9PeWpmT0xheUt3UXhFTlRPd1d2bFJmbHQvZFJkTFBZajU2bFV5?=
 =?utf-8?B?eFhENS84d1ZuL2duMmR3UmZHYWZZTi9FdjcvWGsvSVBXRUt4OThTOHdJL2tu?=
 =?utf-8?B?aEh0ODlNNHh3d2dXWmkxaTlUaVBrajJBTHpqdFdhZjgrUW5XK2ZWbjQzNUMz?=
 =?utf-8?B?RHNJVzgrcldEVFNLWkI4cEx1aTdGZVZ5VXF1Zmk5OC81bWZLSytHVzA1NGpq?=
 =?utf-8?B?QmxUc2toSkM2MHZCblFHRzZjT1NDa0FtUGcyTzdjbHFBdHN0VWd6dFI0MStD?=
 =?utf-8?B?d0E3ZTRMWkZpVTBSMVI0cDdyQ3VpSTloMkFrbE9QRjcvdFlTZndSeWlKNGJw?=
 =?utf-8?B?ZzRxWXZUVGdGSUVrbmhvTFk4VWFZcU1tK0NUaW80RVBWRHZ4SWRaVnR1Sncr?=
 =?utf-8?B?NkZmRm5WSXh1WkxGbUNFUVBFMmh5Q1hFaUEyK2dXMTZDTVBVNFEyZjJFQUtp?=
 =?utf-8?B?TEFxT0lvSkRhME9RRkxNVkpZOWhHRzlQUm5sNmVCamcwcXpKU2RrQWpVemUz?=
 =?utf-8?B?c243R2hvLzFMaXgraW9zSU9Ya0dUcmFEcEEvY0t2cSt2N09BSjhUQ01HMThP?=
 =?utf-8?B?K3A0VW1WV2x2a3poTng1ZkJqa0Q5aHpRYmpQb2ZoWmZ0YWE2eTlhOFp4S0FE?=
 =?utf-8?B?Sk84c1cyVDZ3R0U2L2RYUGsvWUNYQ28xcHFWTm5saHVlSDhpWjJWcFd3SkNI?=
 =?utf-8?B?aEMwOHA0WmsrVCswYUdIOG1Fc1RKem1CMlBBZmtDZnVHVGc5QWRlUXVBRmJ1?=
 =?utf-8?B?am0rMm90bUFTV2hTaXh3THArTUF1Tnd2WDJnN2NRRG43cnkyejFBV0dYK05M?=
 =?utf-8?B?dE5OTnIwNVJUWnloQzhRRjEweE9oYmM3L1NrNXJ6Q2VTTyt5UFNMbS9GeFhM?=
 =?utf-8?B?dE9FUE5pNFV3VkpRTlNVMWtyK0J6N1FybDN5anNRS2JKeXhsM0N5T1RhNm9I?=
 =?utf-8?B?eXZlN2kxbmNudUhVZGkvVUdtbm5sMmFlTUUxODVOdFgvT0x3YXRhd3QyQVpE?=
 =?utf-8?B?THhCL3NkNFMwMnh4c1lZTkVHR2w4c3BtWTBTSXphazVJa1ZNWFgvUkkxVmQ3?=
 =?utf-8?B?R0JMYUxnTnE4bUZjL3c2UXF5MElhUkVTa2ZnN2d0TnU2YXI5Z1FLSWxOZjA5?=
 =?utf-8?B?ZGtuZVNGSk1ZMEZRQ1BzcjgzQ2Y4U3d0YjRiSDZCZGJ5N3ZvQjF5M3BmZjVW?=
 =?utf-8?B?eFpPZ2F5R3YwMm84TEdNYzNnbXRwcmJVM1ZLWUZqTFBVU1R3TnlBMHdmR1N5?=
 =?utf-8?B?ZDlKVE01Nk0xcnNRNmtsMkd1c05oWFMrN1QvM0ZSWXA2ZDdSdWJ3bHRuNTlL?=
 =?utf-8?B?UVg4ZFd6TXhWZldLNEE0TmVCSVppcmRVVGtXL2R1cTFuOW1SclpQMXNGazIz?=
 =?utf-8?B?aVNJM2N3OXpDNTVEZ2w1MzVBL2J5clhqSkh6TFhJSDdnd2lOVjdhczFHZDd5?=
 =?utf-8?B?N2xyenJlNGxqYzY3RlNiUSt0aExzWm1jOGM0Z1JGZDdxaElpS0J4bE8xek9X?=
 =?utf-8?B?V1JVNGJLWEpzcnlWb21rYUlYdGlMSlROaEZpNkdkUEREeGVUU0NqRmhjZmpL?=
 =?utf-8?B?dWNwclloSW4wZlNnb3c3V3N0eUdQNFFHeEdZblYvR3ZaK0QxMFkyMW10UWpV?=
 =?utf-8?B?WXhYdXBWZFNveXR6c0VuQ21FVm5nQmY2WEJYYmF5bzY5RnJjTVorZURvcXJK?=
 =?utf-8?B?cDFvRldyb0l3cmNHK2t0LzFDcGFwK0xRam5TOEVlemlHOFhGSVlhcUdZUG04?=
 =?utf-8?B?a2pYWEFXOVlPNDZKOFY5ZnE3YTc1T2RwV21VbmVuK2lSbnhvdU54dnY1c01H?=
 =?utf-8?B?TzJUVk1qVjJiWFFwZUZ1aDVVcGVzWnkwd1I4OWFHMzVRenJTd1ZTNEpob3dp?=
 =?utf-8?B?cGpRdmcreXR4emRLaGpjYW1LYVY3TWtqS2hVTmczSVJyUEsxZFdEQitqQTlC?=
 =?utf-8?B?MS9Mb0RKMDF0RzlSN0FJeTE3QnFJdlU5UllKckZ3ZndRUHd6bk9pUlA5dEM1?=
 =?utf-8?B?TFNGeE1sYUQ3aGg4dHV5ZnorZC9wTEpJNm1vS0V1eUhnRCt2Zzl2UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0f6d4c-5d12-4ea8-370d-08df4468950c
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 05:06:47.8253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/x9GM5GnyjJ7tTXaWJnepzHqiaq1PuZhmIjJswI9zIlSkmR5i2z99PcCOrSPW0cPIRc4uLUsPejJOV/mgYr2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5504

From: Jan Kiszka <jan.kiszka@siemens.com>

The MCT driver only fills clock_event_device::irq for the local timers
in SPI mode. In PPI mode (samsung,exynos4412-mct), the per-CPU tick
devices were left with IRQ 0, so the proxy tick device never switched
the local timer interrupt to out-of-band mode, and the in-band tick ran
on registers which were never saved, making every tick look like a
user mode tick on ARM. The global comparator device had the same
omission.

Assisted-by: opencode:Opus-5.5
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/clocksource/exynos_mct.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 23d39bf9bdaf9..a548ac338f3bc 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -350,6 +350,7 @@ static irqreturn_t exynos4_mct_comp_isr(int irq, void *dev_id)
 static int exynos4_clockevent_init(void)
 {
 	mct_comp_device.cpumask = cpumask_of(0);
+	mct_comp_device.irq = mct_irqs[MCT_G0_IRQ];
 	clockevents_config_and_register(&mct_comp_device, clk_rate,
 					0xf, 0xffffffff);
 	if (request_irq(mct_irqs[MCT_G0_IRQ], exynos4_mct_comp_isr,
@@ -487,6 +488,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 		irq_force_affinity(evt->irq, cpumask_of(cpu));
 		enable_irq(evt->irq);
 	} else {
+		evt->irq = mct_irqs[MCT_L0_IRQ];
 		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
 	}
 	clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),
-- 
2.47.3
