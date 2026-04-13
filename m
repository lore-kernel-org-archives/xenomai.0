Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FFC3B0AC2
	for <xenomai@lists.linux.dev>; Mon, 13 Apr 2026 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776093846; cv=fail; b=VWlydqEw6FZX0qXP7aYyt3h0ggcCU5Zi/G0HIdq+Q+8+LPi4hpPkei+xvJkzc87RjxhOttNem35F+ytYhdtAUZlWo1mGrVm79bYNJpfMVphFVIr9CCeU8qgXZ2wuiGtnKqiqlPOfjc7W79nwZJCG4VHrQmcwqxOrvCZhQoOcfvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776093846; c=relaxed/simple;
	bh=xS96YumTsUoE0CtZVH9PkZmMOgUFhGdSj6bgLsM57Lg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bW8z3kiq50BQnfJsZTEkK/c0Tqf2ReTpciLdv/tvzbBBOA5CA+0RXLB+LsteJSbmDVz6qQRhMGz6DLvWRLFIK6fF81ckxUvU7OfqLWw91755J6uCjVncjqePIpmFpwcC6jvjA/yL4kLOXNLXl6vbFhVY/x7LShurnAN4LBgWrjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=w3ypBBiP; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="w3ypBBiP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAPyOlFU3unF5DqDxTB1nlejKdsBtQUD+PmyUG/osBAXxv0xujci78IatbDZEIzv6KPxWtzKClAOYbCQRCjlljf8YGIKwVbDWDGMbYUMT0shaNwloKiyKjbaSpzg+2r/slfsUroCnyDOwM2ZWZ3rN82D61UrrYUPVHtV/xKSR+y/s87xbo79k5KULMPNaOjDARXh6N7yYMOGDiMUtbM0fnpuwJwCQpTi3A3eLoo8NEsYGp56PODzxU4qsAS7E1XMhape3+ARPIvhvZaQQuO3rBaknEEd+MnKLOfnUr+R9TtK12qyq/0lGLCVNg14srd+tdGGkFJwHub27g91IoFeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTMJgA9T2+LuWf+XsFIjxtL7UpqI9AK6V8+hPfROlYw=;
 b=wTtwr2uKgyHJN6QR7wNyhEv9SiW//9VTFcy+5LI6Sz3Pu5U/bMrCPksEKwjKGlW7MZTSlyBDM+wfvovC/QIpVGFahS+X/cHp4MOsHSRLsiiPDdb9ijTo62ax4tkt2gHtnnO5pnmX0/PAc3hU1cIgFysFDoPHkMwpmv+0JZvXU9e1t5ZOS6KIw6g4lAleRV5QL4MKbalGcwGSxKrpEpin1HK6D9nHTqgjuMFISe498b9EQhKJ3ine04+l2bHgf8cjk1vrL0TR3GOe0njXPSKVthhfzXMZKrMMw0djjaU+AkRPKoohqO8jl+UxoySWRnpea3PP9eqqKv7C1M+89GxW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTMJgA9T2+LuWf+XsFIjxtL7UpqI9AK6V8+hPfROlYw=;
 b=w3ypBBiPs+uRS623DS95vPT8DYTfLtzMGBb5KSP3icnc9YhSJVE8tCYXTmeyQ8ZPh+rQz27HqciwEH/VMl/qYMwhRJd30JgQYqGuLSJobtjlcbbvo11VCXRSew2LSV+9I0vqkUhfjDC0dwqYrIjQhux/peiDPuzVRnCrlkvdCfiLzkMcOvGYbC3CZmuqnF49gvkBK4Phw3oNs0MB2pL6xFmIS8h0AeGRIt2V/FYFYIEk/sNsESs9JUXCiUvbRihnz1h4j7Yzbq/HDh9fwyZGwUErFIIdkqtCXrm1mUD3J8GBPCyE7E6M/C1F6CDrOP4ayg3VLRKSnpIz6lk/yoFg7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:425::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 15:24:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 15:24:02 +0000
Message-ID: <af74e234-327a-4b59-a33d-8d817e34eaec@siemens.com>
Date: Mon, 13 Apr 2026 17:24:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xnsynch_requeue_sleeper: Return early when !XNSYNCH_PRIO
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev,
 Philippe Gerum <rpm@xenomai.org>
Cc: upstream+xenomai@sigma-star.at
References: <20260412073425.956320-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260412073425.956320-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8680:EE_
X-MS-Office365-Filtering-Correlation-Id: a93b2eab-4fb0-4916-a5b4-08de9970b11a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P73GZ+/SApQO5NCnB5uRD1Lib+4Xivg6PdEPqm56yWs8c2A/hykj8Q/MsilZm0L4NcSFwg/tNVOAJ3EPuXnsDOrZ3hQbv5NAz0rCDFIyWS1B8KqZFn5tZ6zUItPAJ0OWtPulQw9a/E8OsM6ZhhKrvnoFq/urzNLKSW9yvdsdJgDeCyYes0hF/P0Kh7SXj7q1kIYsbTUPN44e+/i44IDGV0kC0jd3yX8YYgpIHBxfSz4xH95nLRmBGmD9oI41cThKZ0iH/oSgWPHIXxG9L4Wik7P9WStV+4AByQoqj4dvBn8QDyZlxC0mNJsr3nSz0iakJn7ZTEADFYOnMj7MlCvEoQeGisWnbqNFgxAOmnx5JNWVdts8vTzyrne9/YskGppIX97QcXDtVBVOHhOf3ZIvo/3CPC3JDNu3Rj0f+9UYutFDbURpOQOczRwv/QVpS4VslvhlzT8z9CaEJxYVS90KqDM6+g+r1q/SnprrAmUBpDd+p66x479oA3jhkyACgllQZmUFEnWQnadO+u0s+3JxN4mr0R4sn7Vb2ki2HnAeGY5k7Cep09VYyFtDLTcx43L0Xt4P4zPVYbuaR4PTZ3Xin94fCO7gKo6zDyQDz40nJBx0MFIB3qchNG3hDRe0YgVMfKaWJZVSQPd4iv1UA5/gEPopAne5fkPseLVbUQgdT6tkxIF/SnoT287gdvBRwcqE5LvFU385CmZdJ5haVa9zShGIf+mZcqTGB11xDxSV/kY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzlRWlFDREtTaWg2RERkSDRlWDBTaXk0Z28rOENVWWF4NXA2Zkd4Yk14UWJY?=
 =?utf-8?B?NkNnSWVTWFRmN0Z6OHdLNmNuY01OMVJTZ1ZiQjFKckRzczhCVDBjSjlnNDJB?=
 =?utf-8?B?Y2xnYTlqaG5XNFZOZzVrNlpUb0xXbEI3WERScUN1dCs3c2wwd1BqY1BEaCtz?=
 =?utf-8?B?RXNabktGcnlpckg4T200MWRaQjhhTmdGSlJwa2xCUEhhMThkcW00NzBiZ0Uy?=
 =?utf-8?B?eEs0UERqU3VCVEM3S09DdWgwWTVka3lVWTJSQWMvVlQrVngyRnphcytLblll?=
 =?utf-8?B?eVM4VnkzRVo5UkNqZ0FXSnBOcjdNNHFROTlDRFpXYS8wT1RZWEsxdys3ZkFC?=
 =?utf-8?B?dzNDNFFhV1RHUVlhM2U2NUwxZ0txN1Fjb2JIbERuUVRINzRVcHh5TlF0ZVNF?=
 =?utf-8?B?dGpnRWJKb3NicHJsamJtUGpnSTFaZG5obTdNckJXNG51Y1ovNXhaSytJT1Qw?=
 =?utf-8?B?MUpHU1FidjZPcFc5VDFLbG03aWpCZFliMnlvTXVMVnFCWWQrQVNjTWdEUDli?=
 =?utf-8?B?QjJyN1NuUUw4QVg1NkZsVEo2ZFVpR1lQa0E0Q0VhRXFJL0JJS1BqZlY3QlUw?=
 =?utf-8?B?T1JIWWxVamx2VnlxbU9vS1R6SHllcnRVUUFvbkVEcFVRQmNiUE9aQWlBNkJv?=
 =?utf-8?B?WnZyZFNVSG9yVzlITk5EcnN0K1d1eXNFTXZiWkd1SURPenA3TGV2RVZrc2Fj?=
 =?utf-8?B?ejBOMEpiK3E0ai8vUVg5TEI1YWFsT3pmcUxXaTdMV3A5Q0c4Q25oUkZjNVhm?=
 =?utf-8?B?bWFUSG9YTjliWWE3b0loSjFPb1g3ajdFczRteFRLS2FWVERqWEhBb2ZmcTBZ?=
 =?utf-8?B?b3F5bDdqVGkycFFjYjJrK0NVU2ZTblNhdTE4dzlMZldBWlJIYUdKOCszcGJn?=
 =?utf-8?B?QTVnTTc2MkM3d2xFWk1JYnVKT2pTeHhYcGMvUnprY0M0dFR0SzRtQk9FQTFY?=
 =?utf-8?B?QUhEb0FicXd0UEdXTmJiTTl4bW9OcFMyZmVPaDgzQmg4WGZETmdwWXZSRUdY?=
 =?utf-8?B?S2VhZG96QjhXOTVGdDg4d2hIcUNKaDF6Wk90OGJmajY3S0x3SkZhVFppMUNh?=
 =?utf-8?B?Ky9iaEU1M1RJSFc4N3Z6NEZXZUJoUmVURGE5UHQ0MUNxeENKaTVNaHluS0tB?=
 =?utf-8?B?SnVQVnZoNlRxVVJZUDA2VmN4cFBQV3RGRnFKWmQ5aURuT2tYZHJKYVNyWUly?=
 =?utf-8?B?T3RuWmdzL0R3b21IOWM0ZDZDNDRxWU11YWpOYnNIZEdoN2ZIeGZrU1Y3VDlU?=
 =?utf-8?B?bFVYRXM5bXRIeU5RTEdDRHM5LzRNQUNxKzc0Ymdtc2xjeVQ1Q2lWbThiQnUr?=
 =?utf-8?B?V29DOXJCTklIQk9Cd0J5c3VsZ01yZHJLZFZmcEtzdTV2cHNSblBGOWZodEFp?=
 =?utf-8?B?RlhVcHU4MUVha1Bic3QzQnNVRDFLQ09qcEtROWlQNGg3Y0lEV2cvWmFrazBJ?=
 =?utf-8?B?QjhJWWx4cWZzOTlQNmRPUFZ5NUNONFlUQTljdWI4ejk3NjJpSnQ4N2tUVFIz?=
 =?utf-8?B?YmdsQzJ4blpROURvY0dIb0U1cGRyNHFCczl3eUIzWE9jU2RSWEs5ZDc4dUdY?=
 =?utf-8?B?d2hJOU04SHg2U0cxU0RtUEhFNHV0K0ZweHV1SFgyU3J4ckgvRklGOGhuTVY1?=
 =?utf-8?B?a0c0QSt6bktza2ZGdXM4bW9wRTFEaFVjZytyRXNIS09QRmswUDV0MDRmRmhK?=
 =?utf-8?B?bnh0Rmd6R21nclhTMGpsOWFCQ2F2V3RkV3ZxVTc4UjZSWXIyZk5FYm5Mdytu?=
 =?utf-8?B?TUZZUnFBS0YwaUJkczB4N2FBVGN3SXJJMGgrNmJxR011YmIvTjZjVGw5OFRO?=
 =?utf-8?B?d28wUGJrUzdkL3Jpb0xtUkIzTGN2cEkrZXlYU24rNmxSSi9La09RaW94UFhh?=
 =?utf-8?B?RXIwZGVLMnY3U2Y5NHE4OEh6NnVYUE05QVRMd1FxTWY0L01VaXR3T0JtRktn?=
 =?utf-8?B?a2ZBY0hMclRIazlIazgrKzlHa2RzTURTV3hOeStQNEhWdVNudTUzTDY4RGs4?=
 =?utf-8?B?U09nbEErNG1paHBBN2E2ZHFCZ21nMGVidzZ2RTIrRkVId0ZielBzQlpCaTVS?=
 =?utf-8?B?c05wYzV3aEwySWR3T24yeSszWGk4SDBXc01IekNTZ0xzR2N1aW5QTWFjdW8v?=
 =?utf-8?B?RTFlVGc2eWRidWROdWp4eEpjM0NvdkRTNE11VnIrTmFteXVQK2hUdld5SUl2?=
 =?utf-8?B?ZVJCZ3B2WVI3SGloOVJZNXd1TzdoQ1ZkNldkdHBMcGhUY1N0TEQxREZCaW9o?=
 =?utf-8?B?aUZWaEtnbzkrMm9zZzcvVDN2VkJxQ3UvNXgxcTY0R2lxakNtK3N2UzgweGZR?=
 =?utf-8?B?NDdMc1FvRXZhYWpvOHRwdzMwWjk3ajE3SFFjZkNjb3BHZTVpamk0cVMzM29u?=
 =?utf-8?Q?09K/Iubofk8MdNnw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93b2eab-4fb0-4916-a5b4-08de9970b11a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 15:24:02.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GI79KZrO63WAgtFqGaaDDAFS/OYd0EV+mJdw32KyODWiRyx2CRwgnsDYVXBamIFLTzZmuT0ud1zThIUGvVLDsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8680

On 12.04.26 09:34, Richard Weinberger wrote:
> If the synch object is not of type XNSYNCH_PRIO, this function needs to return
> before it manipulates the pend queue.
> Otherwise we face subtle follow up issues due to linked list corruptions.
> With CONFIG_XENO_OPT_DEBUG_COBALT enabled, the issue can get caught earlier.
> 

Fixes: c6232b1f2bd6 ("cobalt/synch: add support for priority ceiling
protocol")

> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> Here you can find a modified version of xddp-echo to reproduce the issue.:
> 
> https://gitlab.com/Xenomai/legacy/xenomai-hacker-space/-/tree/rw/xnsynch_pi
> 

Confirmed that this crashes nicely - we need this pattern as real test
case, not "only" as hack of an existing one. We may need more cases to
consider, though, see below.

> $ /usr/xenomai/demo/xddp-echo
> [   15.888383] ------------[ cut here ]------------
> [   15.889018] kernel BUG at kernel/xenomai/synch.c:966!
> [   15.889021] [Xenomai] switching xddp-echo to secondary mode after exception #6 in kernel-space at xnsynch_requeue_sleeper+0x18f/0x1a0 (pid 290)
> [   15.892919] Oops: invalid opcode: 0000 [#1] SMP PTI IRQ_PIPELINE
> [   15.892927] CPU: 3 UID: 0 PID: 290 Comm: xddp-echo Not tainted 6.19.0-g2fa4f147d5ae-dirty #115 PREEMPT(voluntary)
> [   15.892930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
> [   15.892931] IRQ stage: Linux
> [   15.892934] RIP: 0010:xnsynch_requeue_sleeper+0x18f/0x1a0
> [   15.892940] Code: 49 28 e9 20 ff ff ff 49 8b 81 88 00 00 00 4c 89 50 08 48 89 79 10 4c 89 cf 48 89 41 08 4d 89 91 88 00 00 00 e9 02 fd ff ff 90 <0f> 0b 0f 1f 40 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
> [   15.892943] RSP: 0018:ffff976f00b17d78 EFLAGS: 00010046
> [   15.892956] RAX: ffff8f233bce6bc0 RBX: ffff976f006cf830 RCX: ffffffffbb83c290
> [   15.892958] RDX: ffff8f233bce6bc0 RSI: ffff976f006cee08 RDI: ffff976f006cee08
> [   15.892959] RBP: 000000000000000e R08: 00000003c88a9ddc R09: ffffffffba421a40
> [   15.892961] R10: ffff976f006cda08 R11: 0000000000000000 R12: ffff976f006cf808
> [   15.892963] R13: ffff976f00ba4e20 R14: 000000000000000c R15: ffff976f006cee08
> [   15.892968] FS:  00007f5f4f41e6c0(0000) GS:ffff8f2380525000(0000) knlGS:0000000000000000
> [   15.892970] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   15.892971] CR2: 00007f5f4ff28000 CR3: 0000000108832000 CR4: 00000000000006f0
> [   15.892973] Call Trace:
> [   15.893671]  <TASK>
> [   15.893674]  xnsynch_acquire+0x4b0/0x8e0
> [   15.893680]  __cobalt_mutex_acquire_unchecked+0x6f/0x80
> [   15.893686]  __cobalt_mutex_timedlock_break+0x392/0x3c0
> [   15.893690]  ? __pfx_CoBaLt_mutex_lock+0x10/0x10
> [   15.893694]  CoBaLt_mutex_lock+0xd/0x20
> [   15.893698]  handle_head_syscall+0x147/0x4a0
> [   15.893703]  pipeline_syscall+0x89/0xf0
> [   15.893707]  do_syscall_64+0x96/0x3f0
> [   15.894348]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   15.894352] RIP: 0033:0x7f5f4ff02a8b
> [   15.894355] Code: 45 e8 8b 40 04 8d 50 01 48 8b 45 e8 89 50 04 b8 00 00 00 00 eb 6a 90 48 8b 45 e8 48 89 45 d8 48 8b 7d d8 b8 1d 00 00 10 0f 05 <48> 89 45 d0 48 8b 45 d0 89 45 f4 83 7d f4 00 75 0b 48 8b 45 e8 c7
> [   15.894358] RSP: 002b:00007f5f4f41dd40 EFLAGS: 00000206 ORIG_RAX: 000000001000001d
> [   15.894361] RAX: ffffffffffffffda RBX: 00007ffc37f4aa20 RCX: 00007f5f4ff02a8b
> [   15.894362] RDX: 00007f5f4fceee20 RSI: 000000000000000e RDI: 000055d8735f0260
> [   15.894364] RBP: 00007f5f4f41dd80 R08: 00007f5f4f41de08 R09: 00007f5f4f41e6c0
> [   15.894365] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000020
> [   15.894367] R13: 0000000000000000 R14: 00007ffc37f4a4b0 R15: 00007f5f4f40e000
> [   15.894369]  </TASK>
> [   15.894370] Modules linked in:
> [   15.894374] ---[ end trace 0000000000000000 ]---
> [   15.894376] RIP: 0010:xnsynch_requeue_sleeper+0x18f/0x1a0
> [   15.894382] Code: 49 28 e9 20 ff ff ff 49 8b 81 88 00 00 00 4c 89 50 08 48 89 79 10 4c 89 cf 48 89 41 08 4d 89 91 88 00 00 00 e9 02 fd ff ff 90 <0f> 0b 0f 1f 40 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
> [   15.894384] RSP: 0018:ffff976f00b17d78 EFLAGS: 00010046
> [   15.894386] RAX: ffff8f233bce6bc0 RBX: ffff976f006cf830 RCX: ffffffffbb83c290
> [   15.894387] RDX: ffff8f233bce6bc0 RSI: ffff976f006cee08 RDI: ffff976f006cee08
> [   15.894389] RBP: 000000000000000e R08: 00000003c88a9ddc R09: ffffffffba421a40
> [   15.894390] R10: ffff976f006cda08 R11: 0000000000000000 R12: ffff976f006cf808
> [   15.894391] R13: ffff976f00ba4e20 R14: 000000000000000c R15: ffff976f006cee08
> [   15.894395] FS:  00007f5f4f41e6c0(0000) GS:ffff8f2380525000(0000) knlGS:0000000000000000
> [   15.894397] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   15.894398] CR2: 00007f5f4ff28000 CR3: 0000000108832000 CR4: 00000000000006f0
> [   15.894400] note: xddp-echo[290] exited with irqs disabled
> 
> ---
>  kernel/cobalt/synch.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/cobalt/synch.c b/kernel/cobalt/synch.c
> index 70c05c1f4..0a0b8e80f 100644
> --- a/kernel/cobalt/synch.c
> +++ b/kernel/cobalt/synch.c
> @@ -963,7 +963,9 @@ void xnsynch_requeue_sleeper(struct xnthread *thread)
>  	struct xnsynch *synch = thread->wchan;
>  	struct xnthread *owner;
>  
> -	XENO_BUG_ON(COBALT, !(synch->status & XNSYNCH_PRIO));
> +	/* Only PI-enabled objects are of interest here. */
> +	if ((synch->status & XNSYNCH_PI) == 0)
> +		return;

But XNSYNCH_PI != XNSYNCH_PRIO. PI implies PRIO, but if we enter under
prio-ceiling conditions, we won't bail out here, and we won't get the
BUG_ON anymore.

Please check if you use prio-ceiling mutex instead what the behavior is.
Add that to your test case as well.

>  
>  	/*
>  	 * Update the position in the pend queue of a thread waiting
> @@ -974,10 +976,6 @@ void xnsynch_requeue_sleeper(struct xnthread *thread)
>  	list_add_priff(thread, &synch->pendq, wprio, plink);
>  	owner = synch->owner;
>  
> -	/* Only PI-enabled objects are of interest here. */
> -	if ((synch->status & XNSYNCH_PI) == 0)
> -		return;
> -

And moving this block around may have other side effects that I do not
fully oversee yet. So far, the thread was requeued, and we only bailed
out here when no PI was in place. I bet that was to handle prio-ceiling.
Your change is likely breaking that, even beyond the crash scenario.

>  	synch->wprio = thread->wprio;
>  	if (synch->status & XNSYNCH_CLAIMED)
>  		list_del(&synch->next);

Thanks for catching this!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
