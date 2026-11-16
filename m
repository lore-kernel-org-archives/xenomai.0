Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794857768;
	b=sf0AVzmikVISo6O6PCzPd/5VnoNNHBHGnKiddn8USgKM7Wx9wXF6W2uMJ8dJwXvtWW8g
	 WZ6a8REcxUWjrt7GSZnBKgDvQ2QV5kPVzXoSVypSkoVRsBXI9SigTO7iUlLiYWD7Bhx+X
	 yDyBim3ZnKK3ec3ssncSizf+Co+F3zJngXch8FYOx2KET10hNNwmhnX9xpxlhe/4asK1u
	 ccQhaqXZsjNYq7CmVBL+jGDaQzNa9QR+DXQtbYL9SXMcLQk8yDoGsq3rnxtVUD0lP5G37
	 QT19DZWq695k8XMf2NuYdHxXNcFAgClUVdVyDPGH08feXBgdaJt6pmuzH4W5jqD+0tA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857768;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:To:Subject:Content-Language:Autocrypt:Content-Type:
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
	bh=bkWeu+I0B9fof4PLRw788PblcUXSPHzKoOo2JbBrW9M=;
	b=RaNYFDEqyIvbfSLYyescwaiuHS7i8VU0PFc6LdGGIqJXEr4OPesnQP9JYtEK1qgCj6MX
	 6R7THkB9uwoB0QDEME1L1NkNWdlDCeyEV8lhj2tInZubD9uUrSB4s+pRGCZjz5nQY4utS
	 pisrRBhij2l9lY1YIy8vY2ryvjNqDvSKXvhMUZkUgvuYTS/OFo4FdxqRUfIpZv3AgU9vt
	 92LM5isxYfcJhNMFvZZ/CpNF/VfLFVtPatAF2xJ8nDVYl5zMTHVjbg1gBx9qcxpNe4HC+
	 8npsZOxkmrHLOxk55TUEP6+GF03Xs83jdus5vwyIvvjzpmFMmjpBKaZV8dX5hnUz+uQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=rd0pZCTA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.50
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46957606A31C
	for <xenomai@lists.linux.dev>; Mon, 16 Nov 2026 19:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46957606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=rd0pZCTA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfBtDvjBFU2nzhhFSpa9cra38+s7WABaY6gKbQIvCbBqPUypwS+LLlT36WGdmktes68kvoPKZytiBrIMO/ulvgoKmzYBhAT5uKaCnTzIKzATAwrtGTeYYsa+kTEIoS74lmnA4t1A5/gErAatnJ9Vyc0rEp5zmfJoE9ga98W4aNUrA7FmnhHcAafPFlYcjOawhU/ATgiJ9TUAsLIq0M1l/F4M+WDWtI9ashYfX0NPRTFd6swBswhfNeFq5Gthtd4v8/5n2pvFazP2ZVMu+stUoy3KWowZfpBimAQ6z3MOUrmM+jgks9Yoy596fkhRv17erQ2A+iK6aZumDQy8i2fNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkWeu+I0B9fof4PLRw788PblcUXSPHzKoOo2JbBrW9M=;
 b=d5+kzvL2RcpGQRqRmEv0hNixa28GzqSamxBMpY7BRQekFfPvj52A9jYA3cTAEc9vQ921u+aAagAkZdpliEhpc+IlBpb7+Yednnmv0SlvzOCq01p/PuJE09MrKECg5ISWTtp7d5s8lxMkvC0QG39R8JF9bydzbLmdTr17pnRu08UezjSkMM6q2Br8c49TjC1ST7oAJa8K80dinsd/Ypv3vzmCBffFG0jD3UciCfnRHGE+YAUk+GBbSEOVpCAZHS8Wf4KQGdDtcF3j+E8/YGTZwJgf+mqLU59ZOHINO5O/MwhRCFiw1EPh+J5oXCYcwvl4wM4WWFhkxko6bh9IMxCgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkWeu+I0B9fof4PLRw788PblcUXSPHzKoOo2JbBrW9M=;
 b=rd0pZCTA09sDlvD36L++dnK2ZPZHikdlpkTCINggyA7PsRSmjW2ecm3nMjlbjHDuoUQoUMCh96GFh0xkPwGL9N1sldfRYRSKvHnR70YAsHWLroLoqa0/DC2c7QlBPBWwU6UOJKM1TSYOGF/QWj6mGe4p/9uiVV7r3Llfzc2xQ4IEBIuJbZ+cBASYKETTgfNlVsTHd1swci9o3v4En7R/C+0k/BsdEpuHkWwlnc1zlbpSHI/IKvbqq2xqjRlT8ZB4sPNzFTAgSCNMleWeoeSE+sRIekUjG99Nc+2k2l+5LnuRNxVVH/SM1IBB24E8ic8WRsq0gbhTYPUwTEN8DWk4IA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA2PR10MB9020.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:426::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 19:36:04 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Mon, 16 Nov 2026
 19:36:04 +0000
Message-ID: <88a17090-72d6-4226-9454-c9de5557da54@siemens.com>
Date: Mon, 16 Nov 2026 20:36:02 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] drivers/testing/rtdmtest: Fix race between deferred and
 enforced close
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0423.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::13) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA2PR10MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: ee38d399-0a8b-480d-b4ba-08df4418da4f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|10067099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0B5vJpdc4CNdYPpfpKByx9plCbvx/NPriwBbmMPSkG6VYhfifljfOPel822u5GVl9LPVHsJ6PpiYeMRd/pO6ylpnyASny+w5CefKp0RpftzkPBYcvbkrkKtURDvp7wkguWRGm4pqZE68NV8lABO4LDlnXgHnS/HLJ0yp/JQi3XRGhWY7Roy3gPEyHZGpKr4DIO8e7GOp/+oakQcKSmw5Ag+n0uw1TxDgCg7V+22z+sBPB/OGaRpTYePt5ibt1WRQbogBrIFkBig8sGV2dcT3zWd0cZen+Jbag4jt2QBDrtM2OE7i78qx2ceUoYmKPza/TEGrTNfV5Kjn2ndd/H08u2Mr4JQ5JKblHtEGlFbE7e3+3I2L4is6XA1vjZ6YoeJvGtv6Ie9Jvs3XVMb1OgmRMAUmypgnbGOuhaMWZ+R7T3OLcpnJpZXtkPWUzly4eV8kikd1874N9VXIK5HPq4HFq1/XnfbGllkrD9FsE0gQkSkLG3KUBL+/SEwPKyLTnrYU2o8dTxKh2fq5JGqT4LG8j6tWv7+zwP4MDdDSZZAPJMw4BmuTgQgN+ibZTV1csTEO0TklEo2hgX+jd0ljtbHFk5xoW6ap4q7iZsISStWWoLrXipxGTdnLENL3zfE/mZ2d2hcx/1dFM9FJmkx7wqMAIPiqsqGU69+KtcwaXjB6/L8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akE0UE5yKytIbHEyS2pEUVNVNE9wTFpKb1c1WXk5cFJQcnM3UmZObUgxdmxu?=
 =?utf-8?B?amFHM2prdlZud3dob3Y3OG85WW8wZDdqZ3VtelVZbE8va3IyV3dzdnppS1li?=
 =?utf-8?B?d3pUaVJ1ODZGYytyZ1ZYYVFHU0h6MElvNjZoUi9tUW5pdzVwbFZsNlBIUmhH?=
 =?utf-8?B?ZFNoaXRwNFpJbS9jNzZEZStMMG5mQml4MGNTYnpyVDdiMitVTEFEYjR0Q3lH?=
 =?utf-8?B?SWJrMloyNVdxVHdlRnJhckNYU0RzV01nQk9oaWxmQ3NLd21EMm9HNjgvdFJR?=
 =?utf-8?B?c0lzZFNkaktaVnJTb2U2V3hmWlh5NjllUjRyaDd4REdybGFjNEVoRHkvRWNU?=
 =?utf-8?B?NS9RcVRlVlo4dTJJVUxOOVRBVkVxeUM5L2JxWitTZ3RUM0ZBcEQxZjVyYTBG?=
 =?utf-8?B?aU56OWtKVlo2enJ4RUdOb1l3RzFucTUwbzN2REZIUUdyT3lWWllaK01pTE1B?=
 =?utf-8?B?R240dmtrRG4zNSszbHNQci9WcjJxWFA0ME53aE0rOFVLeVZqTFV4VGljV1Bp?=
 =?utf-8?B?bmlKalFSSTFQVUljNkVkeHh0WnQ2WHluTzVtNWVRdkFkU0REKzNsOXFLU1d4?=
 =?utf-8?B?bW5yeWZ5aEJaTnByK3JZSXlDUnN0aUwySXYrcnl2b2NQeENiSGg4ZTEyK0F3?=
 =?utf-8?B?U0N1TTRBdk1QbGd6bUxPSnlZakVyVjYzOGxLSFB2UjJHUDZvU2VaOW91bmI4?=
 =?utf-8?B?SGZBcU5nVld4SWg5a2s0NEtqRzdaR3RCL2JTT1pEYzk4b2xteDIyV1NvWmUw?=
 =?utf-8?B?MEdsNmFEQmRZSnVycXpXbjBiaS9BV3R1d0JjWWNCYyszenJxbXUyWnpIYnBt?=
 =?utf-8?B?a29IUk9SbDhDZ2VqdU13czA4MHNaRWlzM0tObTVpRzNCQlE0NWlLRjVULzN3?=
 =?utf-8?B?SkVVR2lxeExPaWpNTG8yaFoySHpPbWVadDBmWG0xRXFka2RoU3NNanJOYWdv?=
 =?utf-8?B?UW00K2RmT1I1MVhielFobElRamVOejN0eHdGei9iQnNEc0dFbDBzbytWVW5r?=
 =?utf-8?B?QUFDOUJNR1JtZnoxSTIwTmlMVHlFalFjbklzeFRRSVFONFBsRWlac1FVeU5J?=
 =?utf-8?B?dTZhQmRSS0tSWjVaUjZiUkdZMXI0MmRsQStZclJnUUNGRnk3dXRnd2NRem9u?=
 =?utf-8?B?WE5zZmYyTXBSTmoyYzEyODBCdzZaZzV4Yi9XMkVCam9VU1N5NnpqZzBVdTZW?=
 =?utf-8?B?dmRzNnhwaXp0Ulp6TXVUSGRtTWdSdS9FZEttWWo0NlFGY2lGVEVQcmhyK0sr?=
 =?utf-8?B?QUVsbURBNXBnendVbE9qQm5uNUYwZzd6QnVsUkZzREtpTVBXNGYyczJ6aDNm?=
 =?utf-8?B?SFJxQUxYNFVQMXRTaCtkK3poTG1IOGhLd25OMlZUMm45ZkpKMGg5bU5FWUJJ?=
 =?utf-8?B?b1pRMDl3anZFVXJFaXUxaWJLdmx3U1VTYTlnbG55NVcrdXBKVFFybWhrZ1Yr?=
 =?utf-8?B?N2l4V0xoWU41VzFGa2d4RHlTQVhvSjU1T1lxTWJTRjBYUHd3SFE3d1oyaDY3?=
 =?utf-8?B?bVcwNzlURHo1OXVTR0NHVXJ3enpiZVJyVnZzU014ZEJwMVZKK3gxWnl2Y3oz?=
 =?utf-8?B?VThueWo1eSswRDZ3TUZvVUVJRFB6RytGbGVPdGwzTXVBUWFScWt1SlNOLzJJ?=
 =?utf-8?B?Uis1Q3pKV01TZVVvSGJqekVIUk81NTBVQVM0REQwM3B4M2hmSnNHVjlNUHhx?=
 =?utf-8?B?ZnlkaTdoQ0t3Sk41TG50UXhvRHd3emRhVDl6Yjh3dndYV3pCZDZOWm5TRjBV?=
 =?utf-8?B?czVRaUJybXg2L0VhQmxsaDBzYmRrYzhJUnJXM1NGK3ZUTnNPVUo1YkN0ZDlF?=
 =?utf-8?B?aDVmbTJQK1NpSUlFNkk4dTBONldkODBCYmduY1Z3c0dRRnpHRFRrZGk5QUR2?=
 =?utf-8?B?NFFTakoyRFJXMUY4SytFTFFDTDNCdEEzZlBMK2RRbHhNbEJ6bmRIRCtablRu?=
 =?utf-8?B?V1ozOTNsbWdoemgvL1JEaHFqdFRPZEowSFNIVGFmZE9YaThCRzBTTklNWmVR?=
 =?utf-8?B?R0lEV1JuK0NrbnVDeFBHZnJIa2ZDenltOUVwbTBEM29Eb3NWTGVUenM4VTI5?=
 =?utf-8?B?SzBLcUhVMTBZMm1aOG9GM1ViVjlqanR6RlZUN0I1TUtPSityRUhXcDVLNkRR?=
 =?utf-8?B?Ulh6bm82TGxBdG15NkF2Rm1PYXlNUTV5bFVQelJtRjhuVWtwWFpqeU55dnpY?=
 =?utf-8?B?SmNLMTd2OWVuYXlyY1RGTm9CVVIvWjdRZ1NIa2ZDSG9ZaUZ2UU5Va0xpRmor?=
 =?utf-8?B?NjlLQVRmZVdLQitjRHkrVlZ0WVZDNi9vTzZwNWVEZjZhMFVmT2RhSnJpb2F2?=
 =?utf-8?B?L1pqSXlwVHhsVldDTC9iUkovZ2tLYWJkOGJneUVHZnJEQnJtTGU1Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee38d399-0a8b-480d-b4ba-08df4418da4f
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:36:04.3157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXjRWuSMUsEXBJbIlx5xtZkyeU3BFRMxDaivQdZthmMdxOjxsjPJnFkNSRB6pGnwAooRiLsOORRH7T4fH53iBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9020

From: Jan Kiszka <jan.kiszka@siemens.com>

If closing is enforced on device deregistration, rtdm_basic_close may
race with a late timer shot. Avoid this by terminating the timer first
so that it either ran already (close_deferral = normal) or it did not,
and rtdm_basic_close will perform the cleanup (rtdm_basic_close =
defer).

Reported-by: opencode:Opus-5.5
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/testing/rtdmtest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/testing/rtdmtest.c b/kernel/drivers/testing/rtdmtest.c
index 87aef8ee65..b688abe85e 100644
--- a/kernel/drivers/testing/rtdmtest.c
+++ b/kernel/drivers/testing/rtdmtest.c
@@ -71,6 +71,8 @@ static void rtdm_basic_close(struct rtdm_fd *fd)
 {
 	struct rtdm_basic_context *ctx = rtdm_fd_to_private(fd);
 
+	rtdm_timer_destroy(&ctx->close_timer);
+
 	ctx->close_counter++;
 
 	switch (ctx->close_deferral) {
@@ -85,8 +87,6 @@ static void rtdm_basic_close(struct rtdm_fd *fd)
 		rtdm_fd_unlock(fd);
 		break;
 	}
-
-	rtdm_timer_destroy(&ctx->close_timer);
 }
 
 static int rtdm_basic_ioctl_rt(struct rtdm_fd *fd,
-- 
2.47.3
