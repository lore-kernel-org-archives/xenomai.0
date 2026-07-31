Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB24735C19B
	for <xenomai@lists.linux.dev>; Fri, 31 Jul 2026 05:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476666; cv=fail; b=qqrytM3b/X2R6Z4ZQw/rJwmVim5FwCNB3zkYmZRi6tb9HF3tt69kDknDpO1Iy83YNKL6/pNplYMjeyAEdA4B4fHKWxhS2aw1FtwMnCia3rnuRxMYetSzfO9pK7YPJJS1Tf9eeFfz6V0/+xO0rsalCNwvLcGUpqd9Z7lyxuELdG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476666; c=relaxed/simple;
	bh=DwtNrRFUNhgOyIn8tH0elXXGNK3Upz9YzRr2+hKZEcM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=scpbP7h1RsoQ+3DXcgRsn3m/D1z60MDiwVkK8I/JIyLGBScOGh41W5y5nbh1aaKi0d+RlZpKEWXVIjD8/mrWDs37K8LLQxOKmbGNiWTryUkDkSmkDuJxmWAtV3DVRafNKqsNkxBAIBZ1zP6om9PQvGYkcGzTKPUR6GNVT/JYK8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=b7ulH/Kk; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="b7ulH/Kk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lP7I3gLS2OL0yz74RmdTeQeWV7a5H6gyoTwyI+bDmaUeGUyFatI9cncmMRRNaHsCi9guR61svP+Mtj2woy0N/I6WirRJQj5FX3g4SwclbUfBhNfDKjQoXl8kDuGBlJuSBRjbwcA6SICv8ehdr4WrC6i5vmOkvhsKLusuKVtpOPMEEEgLk7lE494JZdfJmqdgIIt/k/pjvHe/AuVl5Qsb+qBO9jkTcd4KxotO9vPwBEm+XoTMaProMbMj6IB7u6oNFQ37sk9oeaGAcFvBMExS8aq+W424O7/3j9fku0FEtKpUyD1Q0RxSn4nq846Pua1peU9QX10RpK0eYMrIiIsrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbdB5FiSt8pwEMh+/4kiao0ZxaZKwAi4aHXsU9Px5dc=;
 b=lb3ZqnnDDqbtKFpcjF4txdsGR5uy7OJUp/USRFBIIKgV0UF2bgyReUyvE1AJYeHFhNTCd09pBIV0+QlYwqS7LIxWn7JcM3pabt2vpztwZraAAgFCs+JrxIE8SeK5vEUvhrnktrKKV0UNz6qM0fqMEVuAuhEYc/FrEFTnSPTIXAKqNYmxShroeDDdmHgXAPoqLTvESSaAov6wAH/cf7t35LT89/jK4z2Y5UQ2z2+Ju6enf/3el+6NXV0rjhXYgQ/eIE4EdcbSQ37gDZd17doAy4kALYsFwKMA1j2NV19zWNCaTUnunCQsrBL8K3cSaAS90hZe+UG0QnUNeFeNWQTKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbdB5FiSt8pwEMh+/4kiao0ZxaZKwAi4aHXsU9Px5dc=;
 b=b7ulH/KkENyD8QzwpyQajmqO+7r8v91fBhlTo1MxI4lyBQ2uCEv+p8FHL4UhlfpGHC2wZULsLCmRGv5G5vHOTCu9MnCI7M1TubFCgB+F6s6REduTZX+65bYp4LDe5Ir2kwEkHP6iSTW+95LRPCdHWypT9yWY2AoC4NSOgog7LiDq9Ia1+IPOE70ZlCEh46IZzVL8rurqSy1FcdeTwKG9fH3L/Phh1j+wY3vUCDvwMJhWjM9eoHrBWWuHfAKoUKIPDcTgn4j6y1aFjYHbXEKQep8aOvocKQe30k9ufrOpPfbEJ8N3lP0x/D4Jo/tTRzjgCJOhdnv6PCc6PkEBJYLyAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GVXPR10MB9407.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 05:44:21 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 05:44:21 +0000
Message-ID: <1c7d4293-6754-4690-bf73-aba6e17d0c0e@siemens.com>
Date: Fri, 31 Jul 2026 07:44:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Random system freezes with Linux 6.12 + Xenomai 3.3.1 on Intel
 Ultra 5 125H
To: =?UTF-8?B?5YiY5p2o?= <liuyang@sinsegye.com.cn>
Cc: xenomai <xenomai@lists.linux.dev>, =?UTF-8?B?5a6L5YGl546u?=
 <songjianwei@sinsegye.com.cn>, =?UTF-8?B?5p2O5bCP5a6B?=
 <lixiaoning@sinsegye.com.cn>, =?UTF-8?B?6ams5ZCb?= <majun@sinsegye.com.cn>
References: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.3e5e7d15.7682.47ce.94bc.841347b177b8@feishu.cn>
 <480ff592-a77e-4d9b-957b-aa856e41821e@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5571d0ff.0b5a.4df0.8cd4.bf262a5fca73@feishu.cn>
 <08769a2a-4249-4dc2-a1c7-ca402de19470@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.ce37a487.5a5d.42c0.8403.e19ea2d59537@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.53860c2d.1bc0.4564.872b.fffc828b78ef@feishu.cn>
 <5905a920-e911-48bd-9959-d8702b512272@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.2cdf3bbf.6288.45f6.b5d6.9760f144d99c@feishu.cn>
 <2b95f251-e2a6-4c7f-bffc-7cbc15d9eed3@siemens.com>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.09468bbe.a918.4120.abc3.991d1d35a187@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.06d37e0f.d9fe.473b.a955.bacccbca8173@feishu.cn>
 <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.8107967f.ab56.4b5f.bc5e.7ddd5ae2be4c@feishu.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.8107967f.ab56.4b5f.bc5e.7ddd5ae2be4c@feishu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::12) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GVXPR10MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: bda69dd7-faf4-4e58-ca10-08deeec6c528
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|11063799006|4143699003|6133799003|55112099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	YVcH72JnKjY9CfcMO/gclIUgMw1WZFaKjBs3yCVY47jgwfSqHgWmpOc2/zhw2l8nwzbuGX8mBB6Fe4EkkcXWfRI+G5b1sCydjNhoRgibX15MpZ6HJePwblbg88wa85uj/Qrk20bjoWf91d4vTQHosfTBu7nfPoEyzVdBqUokETIoEEdxIXGaDpJochJnSIBlagdZBnsZ+xBXRuesJFt9pyCbnkctIoFxvJhM7uKx4ha4QFrfc9UfYBzHXXMcBvEKbQ0kUdW+xW/J2S7hywuTPoeIqMkWQT06lxGOnRXRaPZj0rTRSCEdksZwUMKQsROEcOGH+BzqBdaL9BvUGW4hSzt/JLBD99QsnyCJCue58NDma69NKMAXjs/Pg42kRup5p37GjDtbFADWTZCnuebmCx50hNsNgALYbbKehYN0xp/da2Lq5NcmI5URZ9R2cd817MCYTj0zm8szFc9gx00+i1xakYV/jsgc8Ck1aLmVBaTtTA3puxKhpbsbCRud8nBC9Ln9OhjbiW5s07bS2dvqXb8YCgUeQrdMLoBEOmK4qmsGOczZMlFs5CnvqVcBou1R3gSgdCJnju/UiHYGeI8fK9ZJ4UmAkInfX2OYhirDMBg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003)(55112099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emxyNUJRRCtUT3NnVm9WeUhzYkZpNmg3WnBCSzEyTkRCODN4SWVDaDNVWVRC?=
 =?utf-8?B?RHNoVStIWEFZU1g1ajRlVzJCTE4weFV0RXZxZDFJR3ZlRHhnYno2dUhMdlpn?=
 =?utf-8?B?ZGVHU2kwM2V2Vi8reFNKV0hKSm9NMmZ5aFNGREZjcFlYVkhMLytrbmN2eTEw?=
 =?utf-8?B?YVFwV0JndndEV0p0WW9YZHIzTkVZdjExY081eFRNTGRqQndIOEw1cG03RkpT?=
 =?utf-8?B?Z0s3S29wT1QrdzhOMHlPei83K2RJazUxVzBuTk5nYnMrL1BzTG9FWHhzV2hU?=
 =?utf-8?B?NUJRZTJOeW1VaDVzWWlUeFJRS0RLMThGLytJdjBFTG16M0VEWXNNeEdkWEFv?=
 =?utf-8?B?RG1XUXZqRzlPZWUyRWUxd2doSVRZNDNwb2NPUXZXQU9ndWdkUkVaeFFHd1Fq?=
 =?utf-8?B?K3ZRZmJwYXorbUUxWWx5YW1qUGhLaER1V3VKeXFyUU1GclJrZ3BxcWZLanJR?=
 =?utf-8?B?d1BWdVU4OXhBU0Q0SHRCcWxjSmZWY1Zvd3VFU0IvdXNUV3c4dHlybzRyZWNs?=
 =?utf-8?B?YjBZYXdKUzgzOVFiRWxlRXZDOHErUU5EQlVZd3NjWlpJQ0FFN0lKSjJWQkk0?=
 =?utf-8?B?aGVObzdndWlqQllETXhxRXJiV2hXajVBdHpzSlJRS0RiOEpGZzVlZGJnWWdQ?=
 =?utf-8?B?Vm5Nc01FV2dCczN3cE5oaGxHUU9RR05HNmVoWHY3YTI2d3lTaWFUYXZlZTFl?=
 =?utf-8?B?MFp3aEQ5SUtwbEh1SytoTlpDTERNdVA3SGR5WU1VQWhoVjVBSU1jYUMyTXZo?=
 =?utf-8?B?OUJuWDlndUxoKzZocWdGNURMV00ycWVZaW5HMFlkMnhCMXFzSXRrM2R2M08v?=
 =?utf-8?B?U3I1ZnN1WFlBWjEwMFNOWDB4NHQzcitHRnRJeEFMdlFKY2tTY1BYa0syd21I?=
 =?utf-8?B?akhDdDU3SXFXcCtqdFpJemhhQ1lSVFYxVTZsdjBGT1JpSzBhOFltU3orQ0dM?=
 =?utf-8?B?R3Z1YkxiTFdHczQwdEkwWGRnV2NsQzV4SFF5bjBOZFI3TUxrVDFqMzZpM2J3?=
 =?utf-8?B?U1NZVTN2dElmZ2tERzBmakdhSXFGa1czbHVUTUVyeUpjWG9uQUFoOVVUWG96?=
 =?utf-8?B?SVRzWFdCQWJ0clV2d2plSzhMbXpyaHhNUzZsZ3NxNXBMSG5Ob1hVSm9kN0ZT?=
 =?utf-8?B?eEwyV2k4WkFjaWp4RDVKb1Y4YmYvS0lXemRDOW9JNWxkTVB3UTVySi9LSGdH?=
 =?utf-8?B?Q0xIOHU5VVVwWCt5cEdoVmh1aDJCWGgxNFB5eGJsa0thTnpLdWxGMVViWWtn?=
 =?utf-8?B?VHJMMm5yb0N2WXVvZS9uM3l1ODY3S2JISmcweUd6eTNQQWpicVU3VkF1NGRD?=
 =?utf-8?B?RE9ZUXZEdnpnQnptSVdLNFRBcVVscitTWDY3MnEvMFE2ZUlRUW9TVE5VQ0lo?=
 =?utf-8?B?Ukk5cXZGT01jRjZ0MXAwRkI1SUtJVVUyampsT0dmV29JVmhsNkN1M3hrMXZh?=
 =?utf-8?B?QU81TjQ0aVd2QXZtam5zOEFCMHVzNWFldjJnMUlJQjV5MmVVTVpPNW1JcDd0?=
 =?utf-8?B?Y1hZdElibk1RK1pnOUZLWXVGdmNTZEhFaHdrekZuZnhrV09VbmtpNnZzVjdt?=
 =?utf-8?B?WVlSa3R0V1E0aXRvbUpuN1hGTVlvcTd1OHMxdkNYWXZ5LzNVeWhBVmJoMWFq?=
 =?utf-8?B?WlBlREFPS1g3dW9qanc4VXZIWU83VGNnYVU1VjZuUi9aZ1BUY1JOUTY0NjBC?=
 =?utf-8?B?eFdWUmQ2ZndZNDJ4bVh2WVFMY3BpMWFxN285TXRjYmMzUkc4aG9QWkxvRVBi?=
 =?utf-8?B?aHhvVGlTZml4UkdLZEFva2VEQWpVeXMrdUEzZDlFdERJalpQd0VlNHRZY0kz?=
 =?utf-8?B?TVA5S3Q4a2U3WE1KNXFwM0xoNGpJQXZJNXpRU3FRc2g5OHN4M1Z4aURoS1Zo?=
 =?utf-8?B?WWt6NTZleHkzUUJuRk1qQ2wrc1NKbmdBYkZGZ0FSRkxTSDJRT1VSVmtEVVNx?=
 =?utf-8?B?MFRadjRRNFZoN3cydUtCQk1uY2RFaDZ5YVVZTVIxUkN0cjVGTjQvbldRbmJw?=
 =?utf-8?B?VVFrSmwyQ3lYTnJRSk11dFFTVG9kNWNFQWdQOWovdXFVZ0VEYnI0RzEzTlFG?=
 =?utf-8?B?WUFsb0FNbG83OGFUU0Zkd0dBV2kvK002NkN0aUphNlVDUHNVQ0tPN0pRMkRn?=
 =?utf-8?B?RFJ5dmFjVTd2TDF4SENOSkI1QkgwZkNvMHdlemhZODcyemZCOXMvUlRxajVB?=
 =?utf-8?B?RGh6TFRzTjhWVWlTRWYrb0J4QlAzOFU1YzVTWG1hYVdlZFp2N2xkYWJmeDNF?=
 =?utf-8?B?MmZaeU5EQk4zVXRWT2F3ZGZCSHUwcVc0c2RQYng2bmZkQTF3V3RiQU54bXBk?=
 =?utf-8?B?bFVlUS9TRnRscGVBSUNpWjBuOE9INStqc014V0pzOFJHYjI2VFBEdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda69dd7-faf4-4e58-ca10-08deeec6c528
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 05:44:21.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZSHVjaKXTyT0mwbnDzOnXtAtcnswjxl7eVlrEEUxOsh/Svwu2/tye4oq7QC4/dDQGtT+WdoEqFHwcFMjdGuIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9407

On 31.07.26 06:25, 刘杨 wrote:
> Hello,
> I am using Linux kernel 6.18 with Xenomai 3.3.1. I have set i915.modeset=0 in GRUB to prevent the i915 driver from loading.
> Since trace‑cmd logs cannot be dumped when the kernel hangs, I configured the following sysctl parameters:
> plaintext
> 
> sudo sysctl -w kernel.panic_on_rcu_stall=1
> sudo sysctl -w kernel.ftrace_dump_on_oops=1
> sudo sysctl -w kernel.panic=0
> 
> The full serial log is attached. Could you please help analyze whether the log contains sufficient information for troubleshooting? Thank you.

I'm missing cobalt events other cores and an annotation inside the trace
where the error was noticed. That's why I proposed a different recording
method.

Also, as the RCU stall detection may be delayed too much to still see
normal operation in the trace, you might have to tune the timeout
(https://docs.kernel.org/RCU/stallwarn.html#fine-tuning-the-rcu-cpu-stall-detector)
until we find an earlier problem indicator.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
