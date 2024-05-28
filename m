Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A90F4AEDF
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 05:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873894; cv=fail; b=o7KxPCaSXMdy3gUEW+dLoK6nYwwYA8zq174sR9Eys3zQxz86FklZuAtPG/SxQvFiJgH0RSETtrbNMnKQR++vBi6kEg2OKI2qkWkAW0RkhcA7rF2QaYOOsamULhOgOp7WgUXTIK6WrxhRqXF7/l7n+gTYJzuy/60s/o+yIim9knU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873894; c=relaxed/simple;
	bh=QgK/jdiFat8zXNVr77fE4fePI/6PFNhdWAKJSVX4S7E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hW1TxFzKpbJMwkJ/IATRFH7h21k97hkcHiC3z/gNPt3FB2b42QdKTXIzDJk6/3n9Z2Va1Fnx6xhMZVcPydn8BtjO955Bt71ZUWdmTtNjPHUax3RAHojRexaTRJ1nOm+fV5ejzau0ETaHw8glslxTwusFmnkxsQ7mBoP0TKg11qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QjJP9Ry1; arc=fail smtp.client-ip=40.107.104.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QjJP9Ry1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZnKvV4bAp9cK38J/Es18DAY5RRBndYH8HKt+0yLWxkHmKm2TWJ3kurdYWR8j3u61MerDh4USrqEsSYJYM87EnN4XSL31Yi2cZuab50o4Lf088I+prsoMcKMOFXeOeAap6qrxxxCm4V9B7phs8brSHB0L/Y5ibDXMdvML/X1mV7CuEpYtCJhcOIv8JYA4KUZcRNtgA6dYrXvTjQLhzjc0dd7L+tqPpbmlDLitAq9eInulhZqsd2z2xsW61tN1WZbZk/I4+HaKIsIE7R7RnkFPyqtAoctgAB3fEuvJ9sWEgWTjyxyRLPJmUWyTyMxFecCx3Nb0SqD+COedm/3dPyKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnwSDc+GRZCHiYXWvAQ8jY6HAk7Q/KykpVnCMEJqV9g=;
 b=c1AM9BK/xOATSRqhTtZh2DW3Xk97qMQadq5cCBFV3n4mBB/ib+3cNRRrJccMUrxlF4UVQMsHTz0krdsIjv9knwmASFL1dhRNSeGQrS8Ly514VEuliedQI9thu99Wmi5ErvwqUFoqDXte3cQPgoYVmt8GUFAMZegN6UTe0/chXydbkxDJwTJ2XIXXJdbvRpC4BK7EKzs+IMJxbetcbHZ6ReUFGn7lqw501HFR9PoIC//SIbt9LIK2iMAnoxyzDNbOmkBuBRpBrN2V645U09vd2croGZYXQF/5nWLsnmpANe+hQcZJfnXQ0NtiH7scbHLfK7MfEGmpyNPfORLM6s1ByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnwSDc+GRZCHiYXWvAQ8jY6HAk7Q/KykpVnCMEJqV9g=;
 b=QjJP9Ry1WvwiqCP+BQKwDCkiW/hSCsbGCr+EHzyuSSjzgwfnFtnRa8ptCqiNvvChGvbY8vSQGH+oPwFieImFkzy5kBVlkwl69joJGE+87MOJOHQN0nN0GTrDfUj4NzXgQSyMjRiwbKscs8GHEbURcLG88LoScrrObJQC77MXV8GtFC4ShJc98NAytGbA+5uGBazRi3DFURYagkGAbDMvfT9OSjfDf05WctzL502vaQSbi0rw9J801LwMWa/PjnN+7vqq2pVNCzm2xTM1WJ7DcGWUg+tCPXfJV2WV28iRMzXC9oOQHrkJjnbIO2NVvj0meUljgprWjbI4hL/71VS1Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3548.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 28 May
 2024 05:24:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 05:24:48 +0000
Message-ID: <ac6d6c40-aac4-4568-8bb0-244ee293c5ea@siemens.com>
Date: Tue, 28 May 2024 07:24:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix rt_task_unblock for RT_MUTEX
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: lorenz@sigma-star.at
References: <20240524083642.19434-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240524083642.19434-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3548:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba22712-5ba0-4000-bc08-08dc7ed67e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L29ISjhsUjkwRWltRkJ0MGlsTFBseElJQ09JT0pwak5tcmcyYlhHSy92QTZZ?=
 =?utf-8?B?WTlIak5OVDVrT2NDK1plaUhKdy9RWUNjRlpFSnpSckpodUlDMktQaDNXRzlI?=
 =?utf-8?B?Q09URHVTVHl0ZDFIKzV5QkxmckUrSW96LzdzckJGN1lrWWE1UFptZm9mWG00?=
 =?utf-8?B?eWczb3RjSDBXWUFnT3pRVGFJUGFUUjhMMUdPMTJTWFBvSDh1L3FtTVRNYW93?=
 =?utf-8?B?czFLVUJDaTEyMFBNV3JxTGNLTFpCQi8yNFFyaENRK0hDNm0yd296RERxWm15?=
 =?utf-8?B?VlROVHlreWhFejFBUUlHWmhvWXFRVFNxUGRubnFaTmVZOHpjam9yVUZZR2sv?=
 =?utf-8?B?bTJTcGNqL1lxOGFwTFRBYUp3cUV6RHlvS0hRaHRydjY0U3psSDhEOFlvVUhx?=
 =?utf-8?B?UG9xOTF3dk92anVWZy9wMGdzRTZRN3RFbEVNVFFycXBNQnk1Uk5pTEhvUGpr?=
 =?utf-8?B?MEJudmVoRlNQYmF5a1Z0ZHpnMXpTUW9qYkN4N0l6UkEwU1JxNEk2cHZBVzFj?=
 =?utf-8?B?eHJnK1I0RTJ1eXJuY3prRHNiZndUMUNrQVpIL2VEVjVUR2FxK2xyc2RQUU1W?=
 =?utf-8?B?dVBTT29XZWxZaG1RVk1ZQ2pXd0MzS0d2VXBBazlwWnVzS1d4VDdJdy9UOTdi?=
 =?utf-8?B?OW1VZk9lVE4rRVBBbExrV1dNeHdjeHlvRDB3VERoZWZqdWRqbjVSSmdvcmVn?=
 =?utf-8?B?QUcvRTR3bW92QTNMRnRDQmdqMC9vUEVxN2ZCS0lFdml4ckpPRFlSc21iY25F?=
 =?utf-8?B?WmtkRW9Bd3dkVjJGQ3RibjF3UFVxQXNkbEZQcFBmb2h6R0lWZ3cxMkFkNktv?=
 =?utf-8?B?Z0JYVVQ4MDVjdGVoSldrTThFUCtnZTdJYjBPczIrZXBUdjNGR1RsWVJlNWJh?=
 =?utf-8?B?MVFRdkNvNzdUN2orMzZ1KzNCMk5EUmdQVDh3aUM1Yk9oWUxXWThoSGpKc2Uz?=
 =?utf-8?B?a0VGUlZ2UzMzdndMZ2lueDBDWUxOcFBXMHRaZTN2YTR2UTRmVVNEQmlwck9v?=
 =?utf-8?B?UlJ2azNHM0lFSnFTaHFxZDhqMlFmbVFyaXpnZGN6UE9DTkQxajAwNDhpUEhi?=
 =?utf-8?B?dmh6R1lyYkplMS9GblV3bUJBeW9mSlBHcnVkQlpQMGJUZDNxdW05ai9YNnFl?=
 =?utf-8?B?WUwzSlFrSEtpWVRPbUk1RkpGMWI0Qk5va2wyakJIMCs1MFRkZWxqbnRmV2Jh?=
 =?utf-8?B?US9qSlUvL0dkaHQ0WFEyQlBLQWloYllCa3RvZUVvdUlkR3NNeDNqdHh4enI0?=
 =?utf-8?B?bFRZYXhLNnFNSEQycStqWlRrUTZXUGxPdXNoOW4ySWExa0NpQkJrSFgzOFlH?=
 =?utf-8?B?NElDWFBRYXdSaTdoY29SMlg1R3pUVENWV3JhRkhMSHVZU1BtWkRnREx1SW9T?=
 =?utf-8?B?WG1rVTFaUUprV0o1OUtvcEVvTjk3WUE2M3RxdzBLTlNjVFZZTzRJV05JYXVo?=
 =?utf-8?B?SmNNd0FKZHJ6cTM2ZU1KZEYxT1ovcHN1OU96czdKNi9uMjc0dURoYUJqNW5q?=
 =?utf-8?B?VHNmR0dKdEN1Skd2TmhoaUNGKzlGRFNwMWFxNzYzenBCSXdRVFl6cjhxMEpi?=
 =?utf-8?B?eWQvNXNBZ3pIL2lTNy9sNjhLb0E2NTMyejRXbXhNNGExZWQyWWR0L1JMZ3ZI?=
 =?utf-8?Q?LbrOnIQb0rTA7Vfv+WP6ok7Hkpw7R4027kr9yJ6FTjqE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHF2a2hWNUJsdHY0dUFueTI4akJqazFBaFBYbHRFc2tPYThHaUN4NDhNN1Va?=
 =?utf-8?B?ZC9lVm9rLzlXLytNWXB4Z2lCQzJhRXdiczBleXFUdWpDaXVKVGl1UWwyZmgz?=
 =?utf-8?B?OVZTTUdyNEpJQzdqTjFla29oajMvN3ZPRmxIemVyOUVhZFhOd0c2Y1llUXZZ?=
 =?utf-8?B?Nml4aU0xMmRUOUN1MGtQZkFseE5ldVRpdUxYUjEwMXBYZThOTG1WTFZrV3RV?=
 =?utf-8?B?Q3Via3djRFRhSGxOd001V0VVaWdxbGNGenJiOUk5UWx2T3Y0ZjVoMkMxa0FT?=
 =?utf-8?B?eTdacnRqN0hMeS95NitlWWVIb3lMWHo3b1JGZFg5eU50bjltSWU5cE1pa3Jt?=
 =?utf-8?B?OEYwb3hJNC9WN01Yd2tKelZkV3ErOFRndzVPSWpHcE42Zmtkb2FIdVBacnVm?=
 =?utf-8?B?MjA0OHoxTjJYQ3JpTDk4V2o4Q0M1VUUrRzdmWnVzU1dIVHA0VVFBT05ORDgr?=
 =?utf-8?B?N3o2VDJrZWlJMUY4aHY3MFdQTElCZnV4a1lDbklBMU82bENDNExwWjZHb015?=
 =?utf-8?B?VEhZN01xYytUTEpkdjZTMitiS1M1TWRheDA5MlJERG44MUJ5ajNaS1k3THpP?=
 =?utf-8?B?TWxldEV6aVFLSlAyamdyQ1lOMmx4bkViVGVNVFI3S2p0MDdFcVZLMmtxTVg4?=
 =?utf-8?B?cWZoYjJlYXVKZVVYL3laQlJZL3JCVkR6SkpuWjh5ZmJYbTJJa1Jyc0Vvd09t?=
 =?utf-8?B?ODUrbDcwRE8ybm9vY1RxZWtpMXJEc3VSbjRVUGp5MkNCUmtsY1RZZGtUOXJz?=
 =?utf-8?B?SGt4QThVTHJpUUdvNkp4NVlZK25CMkVaSGRUVHVld2NWVlJhdHhZT3lFOERp?=
 =?utf-8?B?amQ4dW9zK3NGQlNITXd5SVpnaURlZCtjcEI0Si9nempzTW53OWtoRkZJZFo2?=
 =?utf-8?B?cEJybjgydXpLVFdnME5iVXBKdGorOW01UVc5T21ZVEpYY1U5Tk5GdU8yeXov?=
 =?utf-8?B?M3Q5TU9ybndWWjRzU1BGM1o2OG4vL216SHZHYWMvM2FSZXhnNzVSL3crWVJi?=
 =?utf-8?B?cWNTcWZXNzlUaU9vVDhaRUc2RzJCcWo5cVBFMjRQQnpLbVBWWXdIVUp3WUtN?=
 =?utf-8?B?V3dZcHcwbzU3c3lWN2hJNGhObnE4amJtaTl2Q0dSeUZjWnZxWEp3U0Q1QnBU?=
 =?utf-8?B?TTRVc1lMcG5ZNW9teWJQQytUS1VBVkY5eStqV2ZnQ0JERXRWTkJZWmRtZWti?=
 =?utf-8?B?NXNUWEZaQTAwWGM0UG9qTHVaQWtNZGhDcCtReTBBck5YemhXOE5PdFNWcEl4?=
 =?utf-8?B?M0tKVU8yZUJzZWhLQUlrOXdsVkNWcVZVS1BqQ3l1bFdmSWVEOW5FcHFxTEpt?=
 =?utf-8?B?UVQxZ01HS1pjYlpxL2NlcEtSdzBIdTVqdFhoS0Y1UEk4R1ZFbXA3TjlNanZv?=
 =?utf-8?B?U1g4T1RvRTVtaW8xdCs1UWhYK2ZyUDg5T2FSVWk3dFM5c2pSU3dTRjRiMlox?=
 =?utf-8?B?UFhCNys1ZWJIaDFXOHo2V1RPaHQ4YzNBeHB4aWxKUDdRVjlFNENSZHhkNllu?=
 =?utf-8?B?OXcwNU5XNEhMTU1ZZks2dFJRSXR3eWEydk1IbC93VUVLTDRiVGw1bDRwVlg1?=
 =?utf-8?B?cEpPTHVETERBY1JrSDdpQVN1TGdnZXorVjZkSHgyUlVCaDVKa1lEbnhhRGpT?=
 =?utf-8?B?dTBCbW1sMGZkZWJsdFNDc1ZHZkZGRlhhSU9XWGN2QUt1K2swVWpCVk82bFo4?=
 =?utf-8?B?dkRLc0l2d2NHcmpBQmFzU0w1Q0lxTmI4UENmQlpCQ0d1SEgvbFdrOXJrTENy?=
 =?utf-8?B?VC8vK2tvc3hMUm5xczM3ejJHYnpiM2VXdk42cytjaHJBTWg4Tm5VVFpVZ2I3?=
 =?utf-8?B?Qzd2bXk1ckVCbUEyVDdiTERod1dBSGRIQi9LcERNWndpSWR5T21yN0F6Wmx4?=
 =?utf-8?B?cjZ0OU5UUW5saEtWVWtEMUl4eHZuVzVrcG1rYkxyRTJ4VjQrQ3dLREpBd3J3?=
 =?utf-8?B?ajBkbE5sM0FVTEtweTBiR01kbktaRFFmSGczN0lpUWllM0xjRUZTeWtMNUJH?=
 =?utf-8?B?alFXR1RkQ2tJbWNMeUtSUTBkVEppdkgrWHlaL3N1UEdZMU1JM0VOMDMrU1pa?=
 =?utf-8?B?a0VyUk5VaWg4UGRTbjNNN3JGVkhJa3Y4ejc1cjQ0Z1JiT2JvcllCV3dtcm9L?=
 =?utf-8?Q?XDcY80hlJFkKGlTXdP2igm9Ob?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba22712-5ba0-4000-bc08-08dc7ed67e03
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 05:24:48.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmvE/7W2us0Cd8r9izVH9ev3cvGh1v2nPtRg5wy2tRONgEYP4RhdHM5/t3lMFdi4H+THDJmeuwj0Fw4KlMA4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3548

On 24.05.24 10:36, Richard Weinberger wrote:
> Changes since v1 [0]:
> - Better names for EINTR capable functions
> - Remove want_eintr flag and loop around __pthread_mutex_lock()
> - Correctly integrate mutex-2 test into smokey test framework
> 
> [0]: https://lore.kernel.org/xenomai/91a15d69-ea68-49a9-8daf-d52ae31f6d49@siemens.com/T/#mf76a46eaa5ec033bacdfc63ca219af3bb84356b3
> 
> Richard Weinberger (2):
>   Alchemy: Fix rt_task_unblock() for RT_MUTEX
>   alchemytests: Add test case for RT_MUTEX and -EINTR
> 
>  include/cobalt/pthread.h                     |   5 +
>  lib/alchemy/mutex.c                          |   8 ++
>  lib/cobalt/mutex.c                           |  44 ++++++--
>  testsuite/smokey/alchemytests/Makefile.am    |   5 +
>  testsuite/smokey/alchemytests/alchemytests.c |   1 +
>  testsuite/smokey/alchemytests/mutex-2.c      | 111 +++++++++++++++++++
>  6 files changed, 164 insertions(+), 10 deletions(-)
>  create mode 100644 testsuite/smokey/alchemytests/mutex-2.c
> 

Thanks, applied (just not yet pushed - our lab has some hick-up).

Jan

-- 
Siemens AG, Technology
Linux Expert Center

