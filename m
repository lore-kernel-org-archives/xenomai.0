Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F014189AE
	for <xenomai@lists.linux.dev>; Mon, 20 Jul 2026 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558309; cv=fail; b=USEROHOvAsYG5517H1FE94YHMqe5z11zMQWEkxZ3QcmYwdgx5pkj13YAjPDjKQ/hdEVvIy0XcFdQSaMLJ8AdlR4YC6+rmPWwNa2t5wbo3nK/M0Fz74/yPr9GtlDxjUttjvlkW4PkuECn11/14fpev8zbRGLexN3U0Wwl7Tq/6QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558309; c=relaxed/simple;
	bh=U7tfhMaxDfVU55QEFgU7a7KvuqYAGs5Mq8B+Coz66Gg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a13W2sN2ptn1cpypgorlag/CUSPeTQl3KkR1g7ULms3L1SBsIEuKufg9iSV19JuDn2jl1Djr/vFR0zMHfdB9sE5TH5RsUYxCjNkaEqUYtenJFjzTRLy1r7sYMWEm/wnPkTPmw9l8g8CN+cpm9hCQ5h54gai22k/jO2YylHlqd5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fRvVv8FR; arc=fail smtp.client-ip=40.107.159.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fRvVv8FR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gILa2CAytK9fHdP2QAK992hD4bn+7GuJWp2kp9Nr5LPCjgXy8onk/oTT3x/KXv6iEIfvuJxQupQXars9Aocn6XS06K9bFqh0ngyQJFBN1npCppkSgIAo8lxc8grZY9CLakmfAJFztraw9EVpRo7HzAXqcD9M5ijIaeoreJCfRgIqUn06HJsOzOj4/CMGtsOKv8bSlHyHUQwxLGxWfK089xrC6lKCnHSEYfQotgpV28SaeSv7xNlWPpbtNL+Kg28TDvEzNYBBnPZF/tKYjn5DC9Q7iqVlb9Ve1HfB7UbvEvgpRe95mazTS/D/n9KbJ/f3ajk0JlbVZmoSXKv2WsBM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aufx/sjf3r+O/5J8Ot8rczOqClaydPb0jj3PNrz/zl8=;
 b=lvGQenBIPngizuXUIubv1ASuDLvgjHgYfw7xByNqajQQX7L+CthDTAN/ke+9NGbk2/EvOxZ/rlKQHQFxv+jOXQ094Tzc4PLccZa7uH3JfhCJDOWTyws476foNxVxZQ6pzlWL4QUVyBoJKMdTHIoDAmD4P8KZBgaSqACXoKHNxjQtXAvQWuuxhgJoU6GTUCA+1mt2hEbnX3Ez45nW4yDLSb/UL0V1svcf0MRjnTe2d7+/4p6+qpC/IB3qVg1z82kIZGT9MEII2Lgv3BmR+89QjrER7GKpFzMx1+pgPEu0op4XuEISPetbw+59ipiabM/iL1y2UH7g3SQfqP9w6Kqyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aufx/sjf3r+O/5J8Ot8rczOqClaydPb0jj3PNrz/zl8=;
 b=fRvVv8FRDfFoR1tGib3NW06DCNx+I98PQWpqIR21BBnAgeIo4V81Z0hbxz5CLi4fNPu8Q1d7P1qIc/i3Sfj/fHt1YcDBX3KoF4CKUxXKsQHnQ4wbec7QYor/h/xNoxCTQyXmDb0QZvtzPd6ddzDKnMQk0Jc7vhSZsyPGA/pVHV92cjsr440umkA2gv0lWPPLCjrof2djRSOvLSQMOrsjzWkDzdTEwJjG0/hqiKFalgD1N+gQ9bLmPxYpV6rQGKUhBLMN5QROCoxqAW0LuwOKq1GRZNqtYDrhkOHLzet6N3QM9W90Lj9yjUChc+/BUOOLW2fS6uYPNsZzKkQYeqV7TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PRAPR10MB5201.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:278::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 14:38:23 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%4]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 14:38:23 +0000
Message-ID: <a14ab4c5-0fbe-47da-9669-f0785fe8514e@siemens.com>
Date: Mon, 20 Jul 2026 16:38:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] testsuite/smokey/vxworktests: Fix compile error
 seen with gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com>
 <20260717-wip-flo-gcc-16-v3-3-5429c866bcca@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260717-wip-flo-gcc-16-v3-3-5429c866bcca@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::12) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PRAPR10MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: a399da52-43e2-4c68-5b95-08dee66c8cdf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|55112099003|18002099003|56012099006|11063799006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	mS/+m/MkgcW0jlTIwxU6CqpUlwqHV3BBj1vXUsRA6Ap0xGxH4EJocY5fqvQ1LoI13Y8lOrPQAqVRc3bNPTExt+7jSNv+wgvfbw1Ytrty1KlrI0NeRd8OED9p+S2AixT6hujVoc22PDtrO7a/JEetmxjU51xY5G0TOwCvgIC4VZoEfxaihmGbmK1iVwoVHZleUcYWOrtyc1a9rGjCYYiujs5adTPTteh2Aw0kJ/NoYw98bi5mBhuMXPEGVo3V5f3i4P296xKPMgE04AWp6ckkkDrryBO+HdrHE5iBEsNEFXl9VbdotduY+bqBM7fR+U7gwX5qGCQC+jL3XvMx2jLboH58V+ZCRXvHJ/OhYZD3DZEb7fmRZRuIEhuB+WQ1l8P+2RB0yYPdnmucUE0PUgHtq/xA6XMjtEtvF1jv5eS1qpnVDX5WDT2yquDhnmHaONEG6dZSnVXDezI0rITx1mtW0TOaEddGP59OvZ8fNoVfU8DFKsqkZAHPHGmKpmgNhgTYcYpZi2zXmNyv+8i7u+w+pRt/acaklqu7OTtWhzfeNVZK6inn0Qlcu7h07FZDTmBHlLKIkm3SRsQaqh1B4Sw+ikEo2K8lyF+9lSComv2giK8Iz73iHEu1ZzOkb+1rwbSrvRn2AAGnZ0VqDLpavxVLLXiR9MUYRZHLUBNM5mz5XYU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(55112099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXJuUDE4UU9RcWdoem16MERSKytFSSsvOGVsT0NMUlRmMXhrd1BQN3phVFA4?=
 =?utf-8?B?YTQ0UG5wRS80ZW4rUjdJZEx0dUI0U0U0N25Ib2ZKTkJEQ0JXS0tiZEd5SE5O?=
 =?utf-8?B?SHE2cFhXNTJNSFN1NHNqcmVjM1pEL2lUK2lIcnYveVVQRzdXNGVraU9URDB0?=
 =?utf-8?B?d3NTVFhJRWt6OUNvclRiNmord201a3N0WVdtRlMweEJoWkFaVlhGcThLQjVm?=
 =?utf-8?B?STBtUlF3bkg0ckNnMjNxOGhGQXhXVVJpSEZHck44M0NzTitKYXhsekdxMTVV?=
 =?utf-8?B?Q1pHT29GeldvRXJSWTV3ekUvdXcveHV2SXdYQi9nQjR4M0ZvdWZhYzdCVTNi?=
 =?utf-8?B?eHlwS01QN3lVaGp4Z281N0hxZ2RtUzdpZDdYc25kdlhDbG9kOHFXeEtXWTRs?=
 =?utf-8?B?TnpLS1BJMXo2MHRZQk1QbnF3ZlBjNFBkYTVTVFN1eVBySTZWQURzNWhqS2Zl?=
 =?utf-8?B?dTY1NkppbDQ0cGxTVmJIZ2ZjV2VVVVVFdFJ3d0dSWHRuV0tYMUxMSjhUOVpn?=
 =?utf-8?B?SHVvNnFBZkhXeWRNUTJRTHdic2FtRytnam9XYjdmMVh4cjJiSytUS2EwNk8r?=
 =?utf-8?B?SjFKL3FlSEZzNmErc2hoSVV5aTM2YXhSREZ5eXB2eExXU0NYdUdvTkszUzBR?=
 =?utf-8?B?SDE2TzlMRGg2SGdtUm1qTUlKMlRzdFpKbFdrTVBUcEQrbnRTZTV2UC9kOFM3?=
 =?utf-8?B?aVdLalRVTVFRb1drYUxLUTdFb2twZktORGFibC9uYk9kSnp6TnB4SmdyZEVR?=
 =?utf-8?B?WkR2LzZ3WnRsQVpYZVlXZVpiZk9GUkRnZ1dOcVhuRkdoeVNDZ0k2Wm9ZSjJa?=
 =?utf-8?B?a21BZm4zSkRZVlFZemxwM3YxUThOc2NTZm50dTR1bUxxQ2sycGJ6bUpUVkRn?=
 =?utf-8?B?c0pGRVhiTTYxR3R4SWgxdFRXTHg0ZFlCUW9QRGZkVzRDcFdWY2ljcHhXL1dG?=
 =?utf-8?B?andCNGRKcUxSZXN3WmplUFlIanl5VWdVblM2ZGFiNVRTNnp1MW5OSk9TdFRC?=
 =?utf-8?B?ckFrR2Z0ZWJ0UGdZZ045WUI1RWNNdUhEMmVZMDJ3Nzl0ZlNKSUkyTjBidUJE?=
 =?utf-8?B?UjliK2Y2N3VYSVUralhLYVl4YWE3T1JqRFBqQ1B0TWlQTStJaWN2WVBsMzNR?=
 =?utf-8?B?K1A2SWsxQ0J6UU1SSGw3eHF5NnBMODk3UjZ4cGVSWkZEWjQxZ2ZoUUVzaUdh?=
 =?utf-8?B?R0ZsMTZYS0NNREZIN0hOZzcwUGRjL0NhcFVlWTVpaDF1Umtyd1ZaMEc2UG5V?=
 =?utf-8?B?U282WjNCYlA0M1E2aWZDc045bHNFZkVTWGg3RUtzV3VDTE9TZWJtNU5Lamho?=
 =?utf-8?B?azFtTDZnRFZUOWt4L1pQM25wZEpmRmdBMDE3b0FDK3FHV2psNjhmcXhLZmc1?=
 =?utf-8?B?bnYxSnFIL2NhWms1L21JdlYvenZqY3NFZlB6UmNUUkxIYkVYZG8wNytzUXp5?=
 =?utf-8?B?emFkYjZ6aklSdk9GNnpucDlXS0tJTHVWbWovaEdaM1dxTkN0THZaMllqSTdO?=
 =?utf-8?B?OExQNmhOUGdaWXl0UEt0NWRtdGk3REpuSGpldW83ZUZSYVowWGh1MjloOG1o?=
 =?utf-8?B?SE5rRFlXWHdiMEpNOUd5NmptbHMzYk5oZTRXUjYycEU5QTFsK3ZLMFpsM0J3?=
 =?utf-8?B?MThBcDdOdmlBSDBhSDNOdkhZWHlnbDBvcjIzV2xBSXVvRkhZTzR1ZVBwMXNo?=
 =?utf-8?B?Q2c1RGVmMDMxR1MzQ3E5Uyt0VHd4Z1p0VUVubGJBSEQ0cHFWY1h2T1Nkcjh5?=
 =?utf-8?B?bUI3VWxubFprYzBhSmV2UmhUVUhNdTNSbXg1Nno5dG5oQURFaXhEZFdRVGYz?=
 =?utf-8?B?UWtpcENQc2g0UzJKMTVUUk95RHVJTi9kczF1SUY1UlFoZlBnb1hObmNsMTRU?=
 =?utf-8?B?cTlDNVFVc0xERk8vOGZaK1NJOS9WQ0UyMXB3ZVNxOWdIeUpHUjZyZmNsek8v?=
 =?utf-8?B?bVNkSU1QN0NheEd2NUczd2Z6azYxY0JCYy9SSmhWbTltcUlsZXUwZ2NoeHhx?=
 =?utf-8?B?QnFzSjVMZkJIclZuUEU1MDdtUFdSSlM1TlNLWkFoYW1pUDNtNDdLRDgzenMv?=
 =?utf-8?B?VHpiT1FlMUhqMmZWaEdPZ0k5ZDYyUU9tK1lacGJmZEV3NWJ1TDVTV3hwcEZQ?=
 =?utf-8?B?SnZyMThrUS9yTW00YzlYNUIwVHMyYXVlQTkzVXpvR0prcFVtYkRiNWtzSWQr?=
 =?utf-8?B?STZra1FJUE1wL3NLZGxuR3NNMjk5RTd6c3NHMlFneWxjY29CY0NVUEJpeHJs?=
 =?utf-8?B?MjJVd1gzS01wWGtNSmxNUU93UzdaeGIrSjdXczM2VjlRLzYxeTlsektQL1Ir?=
 =?utf-8?B?UjhnMGw3ZGpjNC9RYlJ4MmlsUnBHckFBWnozeE10OUlUeE04RDJqQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a399da52-43e2-4c68-5b95-08dee66c8cdf
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 14:38:23.0047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7a4FxCG02MV7pWW839NKpQwlEpH87dFvXextDFXEQypoN1sgW/a/xrQqaphfwHZvx1ZmDcZh7M/2B4LRFymnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5201

On 17.07.26 09:45, Florian Bezdeka wrote:
> Fixes the following error:
> 
> task-2.c: In function ‘backgroundTask’:
> task-2.c:26:42: error: variable ‘count’ set but not used [-Werror=unused-but-set-variable=]
>    26 |         unsigned int safety = 100000000, count = 0;
>       |                                          ^~~~~
> cc1: all warnings being treated as errors
> 
> The busy waiting loop is keeping the background task alive, so that
> the foreground task is able to call taskSuspend() for the background
> task.
> 
> Replacing the counting busy loop with a call to taskDelay(), which will
> be time based. We will stay in the RT domain while waiting, so that
> taskSuspend() is called for a task part of the RT domain.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/vxworkstests/task-2.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
> index 0cbb9e18a13383418c4360241ef244b8a24da975..feda4ff7054346331de0b0cf8f6d53bd07e04c02 100644
> --- a/testsuite/smokey/vxworkstests/task-2.c
> +++ b/testsuite/smokey/vxworkstests/task-2.c
> @@ -23,7 +23,6 @@ static SEM_ID sem_id, fdone_sem_id;
>  
>  static void backgroundTask(long arg, ...)
>  {
> -	unsigned int safety = 100000000, count = 0;
>  	int ret;
>  
>  	traceobj_enter(&trobj);
> @@ -35,8 +34,7 @@ static void backgroundTask(long arg, ...)
>  
>  	traceobj_mark(&trobj, 2);
>  
> -	while (--safety > 0)
> -		count++;
> +	taskDelay(5);

That is not the same, you rather want threadobj_spin to avoid that the
task is only caught while sleeping.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
