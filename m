Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE36124
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 07:38:44 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 1412E1A0003
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 07:38:37 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0613.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::613])
	by spool.mail.gandi.net (Postfix) with ESMTPS id DFBB1D80477
	for <xenomai@xenomai.org>; Wed,  9 Aug 2023 07:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQLvXrYM+ualpoS/pJeYMTJOywSaJaMBbs8sUiRpYi87Y96SCJYgw3vJEaxKedDlnesRRXvpumxSjeGxjKFVHK2uKRyHqr2yMVx2pG6TRSHhqgxroPtAKm4NDIONZpj/9CJbARybHSGiwDAyp9hDymlF89MtcfjCTa52A8p3e0KWz+rF6j6oel1ufCC9XC14wGMUnBkmM3GaDumZ2KY2hY0TvG+ePwdd9E4U5HalNlAfTfaLWYv7n127lTNdSf7U2QWUHftvCAVF3ynHlB07TBmJN7swJ0oYmqjdURIjWiCgu/HESQ1qfuZU6Gp3p/x5oZx8D0gIGXPfc1TD0ANHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvZqU6+UNua8n7q64BlThxZVeydnm3uFHpqSqf/mHHQ=;
 b=XxEKAgMVfJSITvo3lMw8RB1Pauqywp6Mc5Sx22WoH0TTdoImiKMCf2Y+6ItVL0zK6EqXTxaJa6+90urmBJfZicHizPTwHthg0zK+epvFZc5eC6FpNdiNiIg2UDWIU07ybQuy2wCbiUJ1iLFLiNK0lUUf5h+pMYdpiNSHZrvmRukxByA+1pBNKPUdq5RS5HUauC7O3GkGJBVlhMJyLCZyUz4cVGg6+tUakNdSh4h+mxeEciaGCpwetxlLZELdKmT87eIJuEKY3CYA7CPEqHAhqno3Gtr1MZNVvZGUek2nI0viWaSfqnnyZ7RpNGOi0m4+bL+nNWvZgl7nIoAcU/Vmsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvZqU6+UNua8n7q64BlThxZVeydnm3uFHpqSqf/mHHQ=;
 b=UcmAKVJbk6iCH+fQNHRc4cV3WvLOe6H0686dISoE/f0Uz0FpGX41PGj6bIxVGbiT+70w4iHVqFhW2HJwi6ou6AXNl+B9XumKq7J5YGtigcgyvSd3YEMejMfc7Mc7bmhy5lnYJUuDuWNndCC4n69Jz1E0HWeLKv7pZdHlddsHTzDAlZ4hC/sAZ2P1igYCCrgvQsq++prheUgsKMYf6Je95sv9+SR7I89beeQI8DkMmWEp/U6SSkPmzV70M+FpXNvmaKD+h3wpXwBE2Jj+W6oj6r1RjC+/g2g1S8FT1rh8Y5vUoRuUd3DSy+B0vw6DFD+fsRkPM8Sr/BE5QFO9PEyBjg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6688.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 07:38:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 07:38:33 +0000
Message-ID: <94d3c359-941d-a745-6551-fe4a94f83939@siemens.com>
Date: Wed, 9 Aug 2023 09:38:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: XENO_ARCH_FPU
Content-Language: en-US
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>,
 xenomai@xenomai.org
References: <38a527-64c12200-3-647b8480@101120884>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <38a527-64c12200-3-647b8480@101120884>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: e587e174-b642-4e7c-2941-08db98aba230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OfzuMDdq0cN4Y+m0rsxeWJN+6zDkpeWTG4OVEoZvQZzKg3dgHYnMH3xeKqjBEoWRV/JQRPeMRTxI7vbjLo7s3CoxmivOshCjyV8fZuaVmEgD3Yj5soxL9aaIkjIjuF18prRx2xVScFt8u/wwjgvbr+ZTsZ7dkwIs+jB4HG8mDXdXcVxsHQMHwsZoUF9Xx5N242lQNffhg9dlrZtkqhp5j4wojIy1nxRe2OagpLTRkjc5Kv7ifPvSwIDUkOpDLM3GX/9pyY4YKjUkbInRcR9QYs0bQTjicdf3L3GeJKNS+ZQ451BC+/dQtySsPHn998rG8aA0XwrTqFaFSoQlu1U6Kqp2jJglLO0pppo2+HeuooeFYmV9L7rVLuj67t72T53uY/XY4oZMjnVEHTJ8XmGUIPO3Od0q7j8tKiUCKHO39i0iIlCJLJoCFNah3b9CLhx9kzJrTFe9nUNOOxdVntnBy0br56MimkP4FvKmQoL1GN4Li6aOBX7wIcS5vvSLJD4RuVpsj0k3HQ3sBSfjmCfX+2hvOyozY3lI86kZrmkbPEXcBRPH8sM42mLZN2dGmWTMdZBEaPVT3BsswvoVLWItNJC4n34mpFeEAHmhPrbfS6ovLXaGr1Qgr7/sOqmhYw8vHlM6KbsElUjbvf5r7oLsDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(186006)(1800799006)(44832011)(8676002)(7116003)(5660300002)(2906002)(82960400001)(8936002)(38100700002)(6506007)(26005)(2616005)(83380400001)(66574015)(53546011)(31696002)(41300700001)(66476007)(6512007)(316002)(6486002)(86362001)(36756003)(66946007)(66556008)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2M3Y1paWlZmT2JodWhsWTVqTC9OQngxaEM3dGJNWXZYWGh4YmxCMjhuL3BW?=
 =?utf-8?B?elBrUC9hMU5yOFB2U0dVY2R6ZjMwRUJKbXU4djZyZDE3dVMweDFnMTRzOFVx?=
 =?utf-8?B?RGxzOUpNWmhWd2Jld0lPQ29RSzZ2NUJjMmE2NlFMYTBSQ3hWOWtOU3p5cGNo?=
 =?utf-8?B?Y2NhUmRGOE5GSlAxRS9qK3BqeXpLRWR3dFdsM3dQN0xzckpOMCtEVTF2UEVX?=
 =?utf-8?B?SThoSXM0SC9OSUZTNTF6Y2I0U3h6cm5OWGlmVldmOURJQUpjQWpUbFppTEZM?=
 =?utf-8?B?eWpwVGFPOVMzQUtjcmpIUldXdU1FcEYvUk5HTzRNSEVrWWFxWE9hckgrU0tG?=
 =?utf-8?B?Q0ZXNThCMWFNc0VzUkgzVGdGSDBySk9NdWRhS1JEdVRPVnpBdFI4YXFHM09E?=
 =?utf-8?B?RVpGQXJjeVJWZ2xRcUFpVUowWDUwSmRycE1OSDBpbnRCUm5HV3NteUlIWENw?=
 =?utf-8?B?Q0xheFR0alZxREUveTh5T2c3Wi9vd2JhSGtYSC9XcUROejhGamM0cDQzdVl2?=
 =?utf-8?B?a1pCdnZ1ZFR6RnBRNEFTV0hQTTJVK3UyZ0lwVThtZkZuWi9nRmNTKzluRE9h?=
 =?utf-8?B?VVhHTmF1eUtmdU85U0dBTjhsOEtVcTFVVTBxVzZWVVRveDlGS1J0ejJxNVpo?=
 =?utf-8?B?QkZENW1uZmxnOVE3WVY2KytaK215ZzF1anV4aXFnRXJNWWJLcXVGUmY5aERz?=
 =?utf-8?B?aWpha2tSL2grd1RCaE9MQmZFa3l2TW9CYzExUWJEdXpDNjIva2Q5YXBwTGkr?=
 =?utf-8?B?M2VxSmxVbmx5NFdYbnVIbmFqTGpINjBnZHkzODFxR2NMZjJGRHpvbFVyOE9Z?=
 =?utf-8?B?TXRZSEFoaHVST1pJOWJGc3BFRDBLeGRNOFpETVg0VGNxN1BEdVJneEh5bCtv?=
 =?utf-8?B?MjVLdXVmMlZxT2djOStlU3ltZzczL1l5clgzckxzVjc5YjloaXpKMXBadUJH?=
 =?utf-8?B?alNya1pIc3NOaW5aR3ovVTVMcVRnRnZUMi9mZFZpWTdoSlkwRFVUUkdvQ1ZD?=
 =?utf-8?B?dWVrdE43NHAwbWdDRHBWTlE4NWV6Vit0Vk1BZGQyOGxadUZtbE9sazRiMHls?=
 =?utf-8?B?L1RHbm4zaU9xRkN3QWIwUU5ZaXRmMi8rQ2QwTndjQUp1WktmNGgzQ3pHbklT?=
 =?utf-8?B?cGZYdDh0Yi94N0szaGxBS3U5UXlTYXVDakpVbzIrRW5OamM0THFBUit1YXFp?=
 =?utf-8?B?cHJzZUxZRzVadFQwZjliTktEalJMRHlQOXNwcllNVjhEOHh0bHg4SVl5Z2th?=
 =?utf-8?B?TWFwc3Q5NnZ0cENsUExTZkNEL3BzL283YUtud3FnTStRNmpETndMUEYxRXN4?=
 =?utf-8?B?VW5yY0lzUEpTNGRBNUw3KzhiY1pGelJ1bEhiZUFCaG9uOURFdUpOUlpwempU?=
 =?utf-8?B?V1Z3cFRFeUpxUnZZR3UxY1VDVzRNeUJDTnc1VnVjUUQ1bmZVczkyZzh6eGlj?=
 =?utf-8?B?VVVqSXI4OXBRcHBLWjdDVnNydjJIM1djN3Fyd0tLSlBqd2liSU51NWFYU3Nk?=
 =?utf-8?B?eXQ2cWZoK2g1V2dWclJ1VjdLOWc0L3h5ZTRDVUhrMmlReUJYc2RabGxmOEFX?=
 =?utf-8?B?MWdPV2YrM29KVVdVUzBRVDhUcmJnbktHYTJ1UnFaNXkxeXNKN005bW93ajQy?=
 =?utf-8?B?MjhqaHJ5clZGdytYTG9nclRwa0lQd1dqZUttMVUwZjlNSE9iQVpKQWkrZFhx?=
 =?utf-8?B?U2Q0QWExbktVSHA2TXplZW1RYWFIYUlrN0lQNkpPVUF0aUJpd1F1SUZDelZE?=
 =?utf-8?B?M09OS0JlM05lZHVNZTAwcVRXZjRyN2w1S2ZGd1diSUR6KzBDODhXSHVEcTZK?=
 =?utf-8?B?YXBnVkNXdlBFSUpGNzlkd3lEQjdjU1V0cmpVeUx5b0p6eHdsaEtJeHFLQ2FZ?=
 =?utf-8?B?Y2Y3S3hvQkZqL3A4T01tRStjL1Y2ek1ja2hsdzdRdlNLRnFGdGRHdzRhY0x6?=
 =?utf-8?B?WEU5R1VhaXlQaDZMTkwzYnNUdXR0UFgzTS95OTk0ZTY0Mm1UT21hRkZRYVVu?=
 =?utf-8?B?bVQ0RXpSdlpGQTFzUWVqNUFoNHJrMjJBL1hibUVXU3V1bUFTV1pVWmFackpU?=
 =?utf-8?B?VmM5UnFyYnBLcTIyWWI2YVhydjJCeVk4dTFtcHNiSU1sYmNjU3kvOFZobEtO?=
 =?utf-8?B?MTVJeENMTm5FZ0dUNW82RUszcFF4SlNVcnhaSDdtSURnbWJITnNoYnArQ2Nm?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e587e174-b642-4e7c-2941-08db98aba230
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 07:38:33.3603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mJ+NzXsxEqpHthK3ejNQzrdEApufn/HK/vW5PIplPJJn+a5ciRyTYVT9m3wdOEQjQQdBunRK+drxx6IkhhhcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6688
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=UcmAKVJb;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f400:fe1e::613 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")

On 26.07.23 15:39, François Legal wrote:
> Hello,
> 
> upgrading to xenomai 3.2.x for ARM arch (zynq7000 target), I have a build failure on kernel/cobalt/ipipe/sched.c :
> kernel/xenomai/pipeline/sched.c:97:9: error: implicit declaration of function 'switch_fpu'; did you mean 'switch_to'? [-Werror=implicit-function-declaration]
> 

What is the kernel version you are building against? It's kind of a FAQ
by now, but 3.2.x is only supported up to 5.15. Newer kernels need
current master / future 3.3.

Jan

> The problem seem to be caused by CONFIG_XENO_ARCH_FPU not being defined, and in this case, the switch_fpu() function is not defined, but called unconditionnally in pipeline_switch_to() and pipeline_leave_inband()
> 
> The fix seem straightforward, however, I could not find any place where this CONFIG_XENO_ARCH_FPU gets defined for any arch, nor any Kconfig menu to enable/disable it.
> 
> It is however the same for my previous xenomai 3.1 setup
> 
> Can anybody help on this ?
> 
> Thanks in advance
> 
> François
> 
> 

-- 
Siemens AG, Technology
Linux Expert Center

