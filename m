Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2054.outbound.protection.outlook.com [40.107.247.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB4D33C7
	for <xenomai@lists.linux.dev>; Fri,  5 Jul 2024 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167057; cv=fail; b=V18HlkKJauscFk+0JLS1zOejBbwQDpJg82F73qTR6ib9xy8yvQhHYsiAtyLDiVgYTLNiZgpt1S9oXtBEOj/9Bpd+KvKPZXXpOBVdP6tDAWUIMjxriV6rAuUo3VKzYBE1mOLW3xfIF74ujf6v0x6esI+0TowAQQ46zBjAAxX9OHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167057; c=relaxed/simple;
	bh=VaFSl6RtLDsTj3l+35OTPDENcdPmrHQWjPu6A8HhYIk=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=i8KDr3iBoc4X8ZrGNZZ/701XXlbeQLdOh+aWHMOaCzlwufhM2tWPqaXvpDDMGEqL1Elk4RfkKVAunyXfC3QS7oqtR+ouQheN5vTO1/m7vDnluVcU30jfmim5PhtoaHxPA9K5GegiZLkQ86AwyydIQZHEIHbX0Wa4gSPPq/dHqHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JgWaRT0/; arc=fail smtp.client-ip=40.107.247.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JgWaRT0/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYTuUZ/an0YdYBSq8vzpLTRledrtFK6KTP+QR8qjvUVl7nCykAj8vFw/FDX7dsLQ4Xcc34+PbLK5d0zswB7gLni0ytlDgMUwcnSM4vqfUbpnubpHTcuBkd0o4+MkS96kUC6VCeMejmEE2KKDJf81Wnmrr7FR4x6e9uDhXgSaYV6/2wWpCkR5TXUsxQRvcFrnRRx1KlPq4rSbrUvXYfOYT7hdSjr8oen5QRTUj/7EEjwCUVfRw5awY2JCQyM+J/EB0xhHlpbOrlMcjEUzvoUSvyqvcsYBgV1jRDiVLvQeWoSisPtfSqFTimVWZ3494ZngMZqgtu6wzc1M8y7AKXkP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sn+A9WngJ1HVydN+oZr9raUSZc4Amg0bB612KA9J37I=;
 b=DDgShaZ5MIIRHiRiAxi+gieXL2Ec3+BGIvlGBM9Q0Jl+R2SvAJ1KADbspH7CAFENQPNfh7OGdkzWconv+tp4p79M4us21PGdG8JPWnxhJTV4l8IaFim7g762D7x7BFyE8Zb59DfS0iE8vgch51td2+p1b0yM1G6V90CUERnYHBlEJAy3M3Im3YAy4wQkVIVnS5hNuYTukjpGi1EWDMNyKCFEHq054DzFKSH2hcpBBgtIYwqEDlXlCehm1LAjTq1COGitDLLI2qIvH6Y3FWm0mZcXF3X9z/N+bNBSUMLT2VsZHRU1b2vatAZMyIkBE4ceipt6yWEop225ispea9XTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn+A9WngJ1HVydN+oZr9raUSZc4Amg0bB612KA9J37I=;
 b=JgWaRT0/NEpfzp+IQZ8IQf8QCPTw/6C0Him5VdSbXVtxjvo7f+REeBMfMnap4C04MKsLzWNVJevmbHlf8p6hfzfLu8LXBn0JHl4CYXnf5VN4ye3DzhhHWLAQYIhdVttLTSbrxC64rVWgFQ/eMLwIBJmNsT0ILMI6dNKjwMqeJruTOu3B1p3zlJuakzkkXJPRidR2oaW8VCRvgOMLXLoerfaZ+pHBp3mxfO/q7qFFO162dspuB/hiByDoR8ZFa3wRWU/49sMpqr7YEEB2R8Y3Gvh37ngiHOAGhovCZ09ery8R2Mllot8iWHyEwydwGc2o7JoBxvM/Is9O/Mpi3pZcDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6282.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:74::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 08:10:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 08:10:47 +0000
Message-ID: <99e08c53-5a7e-4006-82eb-33ccb6a61fc7@siemens.com>
Date: Fri, 5 Jul 2024 10:10:46 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] scripts: run-lava-tests: Print job URL after
 submission
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 10dfa542-920b-4541-4605-08dc9cc9f9bb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXgzSGVRNkRvVlpQTUpkOG03L2w2YnFKTWtGVzN1bUZqc2F4SjFVcjJHQmR2?=
 =?utf-8?B?N05vc1MxSEhqWkIzUkhKQzhIMEFIaklya2g2SFRBSEpKRjFCM3pXTFJHMk1B?=
 =?utf-8?B?clVyMW1tSkk4bmplQ1M2RFZwZHhxM0pzM0ptSFFhUTZXSi9Da3J2N0xDdEJj?=
 =?utf-8?B?T1NuVXFJcEd2NHJJaHpTWXZBemxjZksvcUNFQU5iRWZ4Ri9LaHZKVGhHaysr?=
 =?utf-8?B?ZCtiU1hScFdDSnFxT1VqendoaUVxajJTL29tazV4NE9tNW03YW9YMm5KT1ZN?=
 =?utf-8?B?bDFtN2NWdzV1aDdTWEZrTXNFZE9IYTZZRG96Zm9LbzFrYkF1NVNNVllJSThZ?=
 =?utf-8?B?V3p5SEl4M3lqdWFJUHpZMnlrWHpWbDhtbHR2QXR3aHl2L2NTdUgwL1hONjdG?=
 =?utf-8?B?THNPV08rSTJ2bGJvdmp6OWVZdFRudCtNRkZaTWtmWmRET3pSVEM3YzlKbG5j?=
 =?utf-8?B?cVNyVWsrZmdpcXUyYldRbUhKajRYUWJCZFdZZW1uUmVuckVyR2RTRE42Q1dP?=
 =?utf-8?B?bytaZGZrK0pmbDc1dDJ4dGhVbFFBWlVUQythOHdCdG5JUVlEZEpuMHVkRWxu?=
 =?utf-8?B?QkZMOWIzZEJiSm1QVitGaTV0K3VJR0FiTkZrcnAvaXJPeDB5SG56a1VZaXdz?=
 =?utf-8?B?VkpyZVh3RmlQaE1ZZjZ4NVV2bVpSY2R4UWJWVlVlWk9ld1lteWtwTS9neXVs?=
 =?utf-8?B?VFVYQUpqaXRPWk5vL1dtZW1XR2VVZDVvOVhLc0V4Qi9wb0hEUmRYZUYrV0V4?=
 =?utf-8?B?Q0hrQkIraUVvYytFLzd3bCttK29ONFllOHkzNkM5R0d3NiszbCtVblkwOEtD?=
 =?utf-8?B?WHEvUHFIMEdZby9ZWHVsenhMdFJicWJybHM0cjF3RTVIZDVTWEVmcXBNQzFB?=
 =?utf-8?B?NkRGaVh0SFFpVlkzMFhuTm5PN3RqYVdWVU13YmoxU0dtaEhVbXdXWmloWFZh?=
 =?utf-8?B?YmZUZkNnYjZ2aVlqUFo1eWZxOHlFT3M0VGtUYXVXSHlrOTk4ZVFFTU9QTkJz?=
 =?utf-8?B?NExoMnI3dTFxWVcyQkFxckxXTDE1c010Wlc0c1cxd1N6YUE1TDk1dTJkbEFx?=
 =?utf-8?B?d3RJNEM1TDV0NkVQeG4yZ2ZQQ3F1YjNCNkFlcWV2b3lJU2dBaUQ5K1FlTm9v?=
 =?utf-8?B?Z3RpSnIzTmFOODc4cVMxTEN1czFhL2dvVWMvdU5mc0ZnZVdqWnc1RzhoSGtS?=
 =?utf-8?B?K3NKZm9pdzFqWTNMRHY1TG16VGd2Z3R3OGc2QWx2c2ZHQ2VQOC9Za2c3YkVk?=
 =?utf-8?B?dWxRNy9aOWZRWG1pSHd1MllrUG5EZDVEazJSL29WOHFTeHFibFkzZkdsZ0VB?=
 =?utf-8?B?LzMrNzZMT01WUFpHZVRlVDRvN0NZWjNDNkVYTzc3eXVFTnpZSTRsMDkyNWlI?=
 =?utf-8?B?eHU2am9VUEpUS2NtdG9Ud0JUUUE0NDVJQUpvT1FWMmZXam5ZK3haSzlBazRV?=
 =?utf-8?B?WVJITGkyOFQ2bE52a0RCTnV2bEszSFg4bElMVWFhVC9jeDExNUc1eGhJbzd0?=
 =?utf-8?B?NGc3VGVrQVZ2ZzZGYytQOUs2OEwrZG1NOFBWaERXSm16WlBHbEk1b3IvOWhY?=
 =?utf-8?B?QUY4dTJhK3NrU01pS0lCS05RK0dmUnNTcTlIdURSa1lFYmh1UU9YWUs5VVN0?=
 =?utf-8?B?R25NSkJxem1OUUdIaXFuWHRXVCtVc0NrdmFjbGYzZjEybkFvZnZ4R3BVelhv?=
 =?utf-8?B?cGRJdFduZ29MdGVrK2x4UzJWWnM0alZ2T0RJV0FOT2xWRU16aVRpSUhud1p6?=
 =?utf-8?B?a0t2Y042cnlIaTFrc0Y1SWZ1T3hpaU1RMUMxZktHdHVIa3U5MjBVaUVCUXZG?=
 =?utf-8?B?cWkyTG5TckVPV2V3VG92UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFBsSFFJbGIweWk0Y0JRTTE1WlI4QnhRTzZGalJveG45eGZ0VkI0czNIVW1x?=
 =?utf-8?B?aWhWL3A5MHVyUU5LeTBSaEEySVQxTWlxaGg1ZVNGU2FPUmdYUzd3WDhEVyt0?=
 =?utf-8?B?U20ycU1EZkUwTlllTmFnd25RMkhiVkp1UzJtMlByL25lMHVmcGFWZmhBY3dU?=
 =?utf-8?B?cVdLR1BnSTY2bWlLTG1EajNMcXZHWUtIcDJ3eDhlNjJpMXRvUjNSTVc5WGpE?=
 =?utf-8?B?K2xzQmM5T2g3YWFhQ3JhalZ4ZkRnTFhkVVVEVjZDbFlKNWg0M2c2Wkh1MXBz?=
 =?utf-8?B?TU92a3BlcXpjbGJZSStQcS9lVVJtQkVobTg5RWxyNmtPVCtjVGcybEF2SXNr?=
 =?utf-8?B?WjZiOXBKdDNrbDhwUFh0akJOY3NQUWJHa3Q4WUFrMVZvTjdFSzlWL08zNEdv?=
 =?utf-8?B?UUpYVTVQUEYwQXZqSTdFNDZyb0RNN2ZpQXFXaXE2U1NDRnFpRlRFMzRXeklX?=
 =?utf-8?B?UVE5RHBYamsvS09lVkhpdE41UGNtVnkwUjFyeEQzU3J0WkJITXRzWktLZWlZ?=
 =?utf-8?B?SStxeXVNQnZ0ZE1NOUd5bHBDU0RUSlNUT1R3MEN6MXdZamxRdVlQRkZhSVhi?=
 =?utf-8?B?bTZra0dUREZUTnBqZGFHKzVuZVdrOFVpd2VNQk9RakMreEl1QW1md3JybEo3?=
 =?utf-8?B?SWJUWnE5TFJjQ3hISUVzNVZoNUo0STltN0tBaGFsV2RzOUhIUDh0RUllM2lP?=
 =?utf-8?B?TE5KZlFxUSt5cEdvUVMydThnQlF0RElsM0tpcnhOWTJQdEpIeE5JN0ZtZEo4?=
 =?utf-8?B?cEhzaXpWM1ZsMnprei9ZaGJLZlQxN3VmZUNGYkN2bVh3bXhMaGc5RCs0T1E3?=
 =?utf-8?B?bTgreXo4cTZya3R6cnE2eGJRWk5yWkh1eS9YVmNXWDBYODM4NFd2bjFEV20x?=
 =?utf-8?B?ZFpuQlZzWnJkYnVMaWQ0S0RlQ1crWWM4UFVpMjlUbGNpS2RmTnNmSUs5MUVx?=
 =?utf-8?B?WFZWWDI1M2lob3FWaGZYT0JRM0NGdXc0L01WUytPRVlXeGtQY1JvSTR5Yk9Z?=
 =?utf-8?B?bjY1cXdPQVZNRTRsdVJxeWZ2eG1FRzBqdVdZSk9pclByVHlnNXgxMjltZ0p0?=
 =?utf-8?B?RWdVNk1lUWs0RzJjaG93MjdBZ2VUaWxXNUlNSERNVDNRMzF3TUxReGVHaTJ6?=
 =?utf-8?B?bFdzaUxkOEV6YTNFMTRkeTRkYVNTS2kzVk11S3A1dkhXVmVxQlF0Nm1MWFB1?=
 =?utf-8?B?OTUrY0U1TzJKS2twYkFvdEZaS0wyRXVsMmczUjFmcDRvcmRWMU56Q0pmL28v?=
 =?utf-8?B?emhPRWdoa3ZaY2MxM2dTbE1kRkZ6OUdBYWxTWmpYTURKdU0vSjhESnY5cngw?=
 =?utf-8?B?Vk9HU1V5ek9STDgzWWRoMDc3K1ROSUNuLzl1dU13QmlIT09saU5Za2Nzd3Nm?=
 =?utf-8?B?WVBUS2x1OHMyT2ZxQmFLWVBudUdCNVJvd0pxQjU5SzcrWUg3eEV4TlZ4aVZ1?=
 =?utf-8?B?cXc2eVI4aEVqNTlXN3VPQmZFdko2M3g2bUVUemJmN3pzOHYyRFA0TFdiM3NY?=
 =?utf-8?B?SnB0azlHTFhTNSt4Z01YQklLWC8xOEo3M0pYcG5KQkpEaHRRL0RmTEFvR1E4?=
 =?utf-8?B?RHVCWnE0OXNMclN0TGtxTFhSb2ZTVm5Tam1qRFRxdDBKOUt5RCsxK1BFMS9M?=
 =?utf-8?B?clE3elRpdUlhQldRUDVNaHNuOGpWUUxCeWZIKzFjM0Q0Y0NGOFF4cUtNL3RD?=
 =?utf-8?B?NzRiektJVnN4emtVWS91bEJDanVXc2tXWmdveHNYL0NoNWkxMHpZZGxCMFdE?=
 =?utf-8?B?RWttTGkxTXlmSm0yOTZZb1ErWmRTV3FSOTg0MVVvNk0vWVE2TnJMMFBhZE9Z?=
 =?utf-8?B?UjllWjZYUTM1N3VZMFlnQnVKTFQ1akI0ZG9nYldtMmt2ekIzSEsvS1RrNVQy?=
 =?utf-8?B?RUdBVW1BY05DQ3lhV3hpS293SVZTSXdMWWZpNkl5R0YvYkh1WTVKV2ZRbEcz?=
 =?utf-8?B?SG1LLzNDYkdqbU1RbVhyU3N1ZmNUOUZ5Zm91RkVHMnlHUlV1ODJiTFBBZzFN?=
 =?utf-8?B?RWhvbHR5Rk9KMy92a0pxUVcxeWxJWTcxMUJobUxaRks4WDVPaUF1cUJobmIx?=
 =?utf-8?B?aGRaK2RPYkdwbkhnYTROV2x1VVFxdXpVY2duNWQ3dUJvejEwQlVBL25JUG9L?=
 =?utf-8?B?UEhDUTcvZ3FaY1Y5MmV3MjVnWUtFOWRMK25sQ3VkbHpoOTFmL3dabVlSS3pD?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dfa542-920b-4541-4605-08dc9cc9f9bb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 08:10:47.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wD7QV75kEQzyiB1ttXSibvLb7vIomIqUelYPZejVn1jQ7PIpDEhmaAoSlIETn7eKhBX+x72rVJ0zHIYvZVsMeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6282

From: Jan Kiszka <jan.kiszka@siemens.com>

Makes it easier to follow the job also on the lava master.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/run-lava-tests.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 10c60bc..046d56b 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -45,9 +45,11 @@ template="${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml"
 
 cat "tests/jobs/xenomai-${TARGET}.yml" | envsubst > "$template"
 
-echo "submit lava job"
+echo "Submit lava job"
 
 test_id=$(lavacli jobs submit "${template}")
+echo "URL: ${lava_master_uri}/scheduler/job/${test_id}"
+
 lavacli jobs logs "${test_id}"
 lavacli results "${test_id}"
 
-- 
2.43.0
