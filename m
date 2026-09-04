Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927143B95F9
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523201; cv=fail; b=XZStXLxmTa4CP+X/KC/tlOfETVXi5tLkMTITodDZ8iGFvGK1q0fpawo84Ks7qskbnpDqMaA7oS2BJ23mFyNHVSqhREG+q6JdbYGqrqqfN1SYL6US8iigWz40NRs7onOIIFKYaZ7c/NPD03TZLVuU0gsQtesFActiapUJDcy187c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523201; c=relaxed/simple;
	bh=Rszy5nYB/kW9hdy51RatDYpvTq36LcD41Z0WmKtB2Ck=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XO20qhez4oajo47wpIah9LtorCzpH8CJiNjlrrbR93HoelYECAZ1F1KJoZcx6AOvIcndDoFB6JM/r8HTX5bH2zzwhTomH85az79w86GLdWjgWOb0aEaOvmF4wDF9N4cts840o4LfeRhB3pHe7CfTGtPkgLR1yCS5yln/No9EEGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=r0tslrK+; arc=fail smtp.client-ip=52.101.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="r0tslrK+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljRf6i8s38GiQ418ha1RuCuVetuINg7TzNEaL+SLakHV7pksAb5uvC0NM0znM1AQh0ttN8HlKq610YUZRqSkTO69yPchl9t8RIaLqTZmF8ylSBn0GfEbKeh4MhkLdgMI9Xx5lxn/lWKt4S5FG39RbAmRd5qwgh5OwoGDgE3AU+7w5q5pyttKt/X+EzS8DpARjvM2xQ22yh4JZz+axQrtmyy24qgUYJfwWL83SSb4xeCQJvuFMue/1HBOMj65ygFuzhKZ2dkNcmuPdMGHu9MeIsgFJOcRaIWuMot8kuqJwwYcKRrsA6wbS5mDDO5LHsT82zkKPe+U1ColZuohGH2seA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfBMsIirM1xeYM18DzczOX/5v5VD8BZnLcqUhGT44Xs=;
 b=OkLKZdjKH9DT27Em9BLj+Nqgwyw+1oIQVU1Ryr4jCttezuNWQzduq4mzfD9Ek16bP89ovJn+9ue6M1gH/SDgTNVuD5o0j0++Q1676gUQW5ed3khdnENE2agKgesDkuQySopmAhi1Y+ShddD6ah4MgrRkYlOoXzbQIlRTTtGbpo0q0PvUg5rTtxRf/pNrfuyywKS5sutbmg+vbihY9ZDAxuo0GEl4QJleSYlrYf4ouV93RkwkM/IdCR3AoLYDoGnRRux87IcorVMeeExDpTHIiOxojT8F28XeTSUOpWSg6Abi6JjEHdeh+LagmR4w/NtoSvZGl2Q9M1QX5SudJ9gzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfBMsIirM1xeYM18DzczOX/5v5VD8BZnLcqUhGT44Xs=;
 b=r0tslrK+2evQvplipMUUOAiHu262JSbhVhdOLncJJxrmPTC+WWxo7Mom57qtj2sgGUDj6VM9Ji/mxU0n0vDW7AiId8USFNEOWJXRS5dMkzJofMhNHU+t1V+DG+Jl1TfIzbQ9FvqgQsF9ZIntZrFUErQlxwQYBw6QNnV7jvIQSknnyZFiBbzHue5xevuQjuXahmKR1DeEIzC11hLEXeR9GsA2GrhofrIDcc8No2L+p61nvIxDs9NbRCH4b31zdF1oParsGkKncRXFis+lh6RvkxBeY0KLMtgxXofyHkg4QBpDjI3mTecvxYkXON4Oh6Bbo+RZFSr5y65y3+QY28IYvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6850.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 11:59:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 11:59:56 +0000
Message-ID: <0b7f0648-2b86-4932-aa12-e70df4da6aad@siemens.com>
Date: Fri, 4 Sep 2026 13:59:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Dovetail + EVL: RISC-V + 7.2
To: Philippe Gerum <rpm@xenomai.org>, xenomai@lists.linux.dev,
 Tobias Schaffner <tobias.schaffner@siemens.com>
References: <878q5he1ei.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <878q5he1ei.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: e383ca4c-9a2e-440a-4654-08df0a7c0954
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|6133799003|10067099003|56012099006|22082099003|18002099003|55112099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	jiV2e2SdhhE58hTCJpooP9dAS5yqEn7Ev7X64YMgRZh1Z8JowSYw2c9zUd+hZoq/U7wfSQ0xhY5jq9Qvb+ylFGlgAhDpqiiQE2xfMURd8g0Ges4yZPeIrrqTZS4ARu/J2qJkzvNN0mX0QoHzA+tueTN5AIgMXrFNeDmErkcq9cjQVKEwFGfv2vUWIl00cBmlMNvzDKf3A7c5ZYPyDH+gGrnNjKo1vpj/kU+T03je/YTzaC8pkk232CCEhot4bExLhdLPxtDv4Kl/xma6eEa88RZ3fWADYja5uxE2DVLAAxX+nqcdBbsXKiya/kldkDM5ugzUXe46DQLa5lNqlocFyXP6R+BjcarBn++ZtH3NGpR2IsQj2NqA5UFDKWhCbk8QeCjOvvZTLZ80CTd0FRcg1CWFMi4m/1Qm60snqlpgaIuqSZReIvHJPIbUVbRA875Q4luGM6CykrpAbtfzjCaD1C04OVcY5EC22EAKLvSVvX/gamOqVL10e2k6/YLmzjq/Ih7l2ZUj1HCCHHkbpfQHII+nWm1Ojf011kLiSIbCtmlX6rsVKyA1dJQfeR+LwbGQAmW1PKkjjNhNXsrN3HKHRI2EWuvbvJAthClfR3h3MWzNv8M5SBvB6QI7fTse5ew90MPWb8J2RHCL39tjwi3Y4EWR+JF/PWzqOItmGCRpcFA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(55112099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWhIZUdsNklaOWs0MGk5K0l4amM0dTdVZW9ON2VOK0wvRnA2clQrNDZVZVpN?=
 =?utf-8?B?SnU2eldHUFg2QnFmZVdzQjYxS2oxKzhiR21FVnBERjd0QmMrRXBZeVFtaXI1?=
 =?utf-8?B?czRlQTV2T1R2Z2RrZTRiUUxybHNHUXdlS0dmZlFCOEV0RUJqK0Z0OUo2MC9Q?=
 =?utf-8?B?T3UrVzczN1ZERjBWd0t2VnFKRlVUbEpObm8zYmQxSVQvSkhQaUN2dUYydDVT?=
 =?utf-8?B?RkQ0OWV3S1ZZK2xYMExQS0NNY09ITGdCdmE1ZTBqdnBWNXk4MkJEL0oxeDlv?=
 =?utf-8?B?L3FwWC9LanNMeC9raVpoTW5PU0RGR0RpeERJZklwQW1FUWw2a0ZnTVl1NWZZ?=
 =?utf-8?B?Q2VMNzVNc3JnWFNjaHhkeTU4NEdCbUJmbDJoMkFKaWJsbFpPQ2VIWEcwTFk3?=
 =?utf-8?B?d01MOHExSXJQWGRGZTJLRzJGejU5VEllUXNxZVpyYitueElrMEN5OWxTN0FY?=
 =?utf-8?B?b2s2Y3RtWmYwVEZOMlptN2VOTHJCeHVhQkhkOVBwR1NtSURPRDIwWTZoalpM?=
 =?utf-8?B?Y1dZUU5tK20vdE5rLzg1a3cxVm1QeXFwSUxrbnpHd1BweW5yNklHRm5JTmhV?=
 =?utf-8?B?Qm0xZGNBWlhUVzkwY1NNRXJYdnNSeEdPdEgzV2NlVjhzVmVYUEY0azVRdWYr?=
 =?utf-8?B?QnFUR3RuVnNudzRkd0RKeWJzYk10R3MvL3hXMFowb1o3ZE0xemxkNkM0ZHhn?=
 =?utf-8?B?TEFYZTB0STUxQ2pBbXpISFkvek1XV2lURW9LVXdBajdPNUJEcWZveU5WSDJG?=
 =?utf-8?B?S3dObWtoNStGR1p3WXVjQWkybjlHNGFlZGYwNHRQNUlrUEdqSXBEN0dNWUhD?=
 =?utf-8?B?a1IvN1hqYk9JT2JkeittL2htYXJxR1ZwOXg0aDZDa0xybWFGL0RrYW5wb3FX?=
 =?utf-8?B?NHVBNUlXUFBmM1Rmb3JvNDlDKzJuRk9IODRXbCtYaU0xcHdRaHd4SjY2MGIr?=
 =?utf-8?B?RjR1Z0dxSDNiM2FIWVRiNXV5Zm0zaTlzdldoYm9ZZmVPaEVPcU9nby9mUXdj?=
 =?utf-8?B?anRYVysvMUhtcmZPK0xHOWFhVXhncTlCaHNlL01pVnN6eVlNYUZzTFE5SjEr?=
 =?utf-8?B?dzBORHI2a0kyUUllT3JhRjNlN2FYb1ZwZGNrRTA1RGpOMnBvMEdSRHIxNW5a?=
 =?utf-8?B?cmw3TnlTRG5TNjRvQ2tLTG5MTVcrdktEemFmdVVmRVA0eFc4cXo4Nm1ZZzdU?=
 =?utf-8?B?ZDg1MXluZUtWSzNqbzBkVDE3UzJyaFVNNWhjK1lOU2MwSTdONmhwT29DdFhl?=
 =?utf-8?B?UkpaMUtSSjFsTVYvZmVyZ2xBOXB6akI0cHVjL2F3TnRUMDdEUXVkTktLNEQ4?=
 =?utf-8?B?Y0VqN1lHTzRkNm5RSnJpQXl2WTI2bTNPdUZ4dE8wdzVrNWl3MGZseVpCcUNn?=
 =?utf-8?B?T2NHU0lUeXV3WjRmeW9LMHV2YnhIWTFNVkErazdlbUt4V3FlR2M1cWt6bUI4?=
 =?utf-8?B?T2cxK2tNRWszbXVUbmxPWk1GSGpmUEFLS3NkeUZyQzFGb1pnQWVQeXVXK3dx?=
 =?utf-8?B?MXVUUnpqYnduMkJOYTBXZ1ArMXJrZVArL1dDR2pnamYrYXlENDErd3M0RHZw?=
 =?utf-8?B?Z3Y4a2Z4Tkt0Q0MwR2NMS1p0MXZoUEFwUFhMc2duYm8zY2REM3kxSHZBUnBx?=
 =?utf-8?B?SDFZRThCRHlic010UFdLQU5teFNtdWNCTWJYZElaVTd5ek44Y2xuRytQbkJJ?=
 =?utf-8?B?bmdoTlBkczRIVUNTd1VTbTFWSWd3Rzl5Vkp4a2lSTUNzM0t0MHZGekFnR25p?=
 =?utf-8?B?Q1h3amhXakJLRjJkSEFwdkxoOG1QM0d5Q0xoNm11VjB1aGtlbStXYmh0Unlm?=
 =?utf-8?B?MUF5UGlCMzF6Mm8wbGp3aXpqUTB5MEtSbHpiSGFMUE9tR3FVNDRYSFJkU0Zq?=
 =?utf-8?B?ZndYN0ZMbG5uSGgzbVlLVGxYanZ2SS9EVktRWnhWMGczK0ZZT3c5NFFpQVk1?=
 =?utf-8?B?THNtQ2pUTW55TWZNeit2N0pIWnpmSXhsRWhwcU8yS0RXT0F2aklDMjdOM2Q2?=
 =?utf-8?B?aE1kc1UzQUtCMm0raUZTR3pKYzEvTmJ1V3RoY3YzeWtPRStHSDNhNXdTOC96?=
 =?utf-8?B?dk9DbkM3NzRSbTFIclpmaXU1T3lsQmwrelBGZWtyejE5dDNweEg5VHdRLzdv?=
 =?utf-8?B?WTk1K0Q4K2RRZmh4ZHkzYzhtdTVDM2tQR0dnRGt6SGhyc3lodzZ1UnNEWXNQ?=
 =?utf-8?B?UkVTZkVtOEROVFBDQkVFVjdiZ0Y3a2p3Q0NNczBBTlpnNjNOL0lRYjJCdTV2?=
 =?utf-8?B?QmVIYnRYVEhLb0JDY2VzM1RKczR0QVhEMU1OVlpEVTdiUWV5YndMaUdhcEsx?=
 =?utf-8?B?UVJHNTFxeUxwcVZ3dFVsZmlMd1hjWUF1VmNmWlZDME5UbHg5S3RVUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e383ca4c-9a2e-440a-4654-08df0a7c0954
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 11:59:56.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFEPaLpn3jReN6hfRdHNhEecSMr4dRttjzqAdUQsOiN8to3WqX+fPMhII+GQgamVt8CdTSJcZvjwn28p7Oe6Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6850

On 04.09.26 12:50, Philippe Gerum wrote:
> 
> The (slightly overdue) Dovetail and xenomai4 (aka EVL core)
> implementation targeting the 7.2 kernel is now available from our
> development trees [1][2]. Starting from this release, we support the
> RISC-V architecture, thanks to Tobias's work.
> 
> Building applications for 7.2 requires libevl r61.
> 
> [1] https://gitlab.com/Xenomai/linux-dovetail/-/tree/v7.2-dovetail-rebase?ref_type=heads
> [2]
> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/v7.2-evl-rebase?ref_type=heads
> 

Great - and well done, Tobias!

Let's see if the pipelines are green now... :)

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
