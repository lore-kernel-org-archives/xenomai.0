Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B136894F
	for <xenomai@lists.linux.dev>; Fri, 15 May 2026 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853523; cv=fail; b=c6owctR0flCr5wUPycrno3kUmLETOtZ5hmlYXKSy0lV9zQts8ApEUlBoTNDR7A4HApiw41Uyv5mxwDeIJWbU+QmWFJ6BzfMUZ17QEeNl6asMr2mzJU0LIHclQAB+13saEnDOBw7u45hAeQ7sLFE9XPycsoupotCgLF/3QpYxuxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853523; c=relaxed/simple;
	bh=urBOsUQmP3sUyvGZhgUh5jFgG8Y8lWf0DMil8a/K+kw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ddxvLF2Lll+/yzxKO9wSSQgYG/Rpf5ql3/UuSHdzl7lt6FAsScPD+3FkVRIMIxwQGP6tQ8UZSgQBBCwSL9kq9CI22xgHa5OkwAW/tzd4ByGfr2odVmN4gbV+dFMj7grNL+TbclYbSeF1hN4s1D3sVRalD3pRrq3a9C6eI/zepEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZBG/CeQL; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZBG/CeQL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lz04ldWQ2iJz/6lxb4QPa8gmS+0DFQf2ipO2cW/1YoYWbIELS3OCDQqaO2HVm3mvSA1Gj52HZrqjswCFup2euUhhfDiS+l+VlwJy3sCKknQp2lZSSRI0+qVAp7f9X3zXOSF2l6ZmDJTNxZ5iHTMSEGo/3Cj9JDY9cAB9kA60dK8twdHg8bYFVKX+6HbZQxpbnV2IxKIZ5Dwv1+ufkCZfX/7bwMJVVTZz1+Fht/OHJrDPvzlDGIGWjuwvlzTKphxi/S79i/q14anXS2TGvRnMfgBZqmzyFYN1yVUzInWJdXLIgl2QMumBSo+KyWlkL0WMT2mKA1HHTIsv7gnKeRNhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHP584fxB7SpGrCY+8zQGWV8O+HMwYewRbE6U02JqDQ=;
 b=Azp2Pp2OdwOBP2pF+ESmGNb9SVp1aLACaIZDFqoWPLjoldx3pB+UBGGVQzoIrwhbsTnPdohesp2xgL46n5H4a5tDS3z2BqKdZ8zEu/JNHmz83hREYfS3f0AP2F65dUx3b0/eC5lp4EyGGK9pMY0f9XPudLy6SvdZ4ivP0NflulHMbM9VATJC/1qIvdC5fED0NfdRsHEIgUWOj8DefJHfamizHdAYPF+3N4LNKekg2nffYdJrbXw7uuWHOkYlmBlF39ggUU4RKNpZWsLkPtuUT6AdI8ns8MSfMS7OGwRYxRjAYaIrWZOgvf3YihwJ7bOj0ocEFMInzjlUgvl/GBED6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHP584fxB7SpGrCY+8zQGWV8O+HMwYewRbE6U02JqDQ=;
 b=ZBG/CeQLAwKd2jUZcWZWVmLSS2G1J8t1Q+rsvHd/I4h4RTDoZUG/Lusxkirr4jK4a4xetxVcZ22bnrqudZTGFT3YPJvxW1sbmxCT4pVjqDI1KREOeM6qGrJ1qrjzPo25RUjFffRjswYSJ7lYWPgUIERjpIW/MQREWw0sl3I1hogFlFRvsZonicbWJYAGgfA1icRmYrZhf4FKODYm9toLO3rSop1cjUVEKiIo4ebCr5Xk5MGErqLuehWpDYfKPYeq9pm1R/dCBEglbCtHWZfTIkflvNrGJeXYxfd40+wxzfxXOXOunRMDLw564mrl1OPWC0nLIQ3ze+e9dYcoDRC8rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5429.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:328::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 13:58:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 13:58:38 +0000
Message-ID: <72ecc56d-f02c-44ca-a5e8-4d112e9da99d@siemens.com>
Date: Fri, 15 May 2026 15:58:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] testsuite/xeno-test: Fix clocktest invocation
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260513-wip-flo-drive-by-fixes-v1-1-473a263268db@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260513-wip-flo-drive-by-fixes-v1-1-473a263268db@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: fe37468b-b9b1-4845-ed39-08deb28a1065
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|55112099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Ku8jCpN+zKHtZUFNo32LPW1lgOYh7a7sI6EGrPBa9QjmecOC5HN7hHxD1RNVEyMyng6rzElvxD5K7LWK3jv4jXR0oqxW+JYqzN77bEC8JM/EFWGjvzzy5Ihl+HLL7EcXbJkqIx4VtGi8gy6xPs1qKlYa2cfhfOkFP6bQJJ2+XoR9nboOcgkY1dnEPlTDOtKYFUpXtk9e09nhZx+HhRIOM7H/aIJl68OoeRd77AVtMIzsfbPgaeZbeTNGOLvET3SPLfgdExFtQc5Aezlb3fvO+bUp/U8CVDkuHTWI+Yv7Is3k3BTsemXRmR+6zELbMkKERuvUEsG06H2/RH7gboPtu4fD1qoqxD0rykguqwCcEKQeyq37MmKocDeLvo0yP2YYC+/28wg8AqMugQ3YZGbLTCo0hN98CHApSKyMDlMoboEcqcyDV9lv2is3jOq93ODsAJoEsTeIfZ3onulKiZSZQjI1BHk6Pkc3axSpT97XjGf+qUqLgSunjSRNTESTqcPdF4r8svwX9cszgyWzcQmb39CHsrruxp4t93Uuqo9S2ejGzf9lkUn/FwZIAKs1i1oGZP+AIfEVUuaK23qvumdvg6eeN+CGTrIYBc3Tm714JGzLvZQ5v3smJcn891pVG5gdvjO/p5RSuW0MkUOFwdRMq+K7nB9MAFAIinM8OtYAyEixwqlZYaZWoN0xS7JY0tnr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(55112099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SStwWTYySzZIL1JIOHNZUjlWRS9HNStsWkpCb0JUSkNhMDJ2YWRVTUdZU1p4?=
 =?utf-8?B?Sk9HaDBxYmc3RksvVUgzZkUxZDZQYjMrRXF5TlJQQk5oY1JFYjlra3JXQmJU?=
 =?utf-8?B?T084Mi8xR2o0eFFEY01YbVYyL04rRW5GVGswOEVIemFDZDN4OGh6ankvYmNT?=
 =?utf-8?B?blJJNGZSWmlFcS9hYkY3M2FySE8wbENxcWtDWkl0YmtnekNnYWFVS21paGFN?=
 =?utf-8?B?QkpsMldwcmN4Tk94RFlYd2VabUM4Zjl4NXpYejJmcGI2Q05DbUJwd1ZpeWd4?=
 =?utf-8?B?c0dXMXRFMEJrRWk3a1V0R3cwRzh4YmlyQ1dsMWlzUVBPRGIyczlITmtRcTNx?=
 =?utf-8?B?ZldxL0tXVnZsbzMybUE4VVIwOGRtQlpPbDZZeWVJV1JPREZ1ZTFPNVJyQ0ZF?=
 =?utf-8?B?SStQTGRSKzdjMldLYXhxZGxYeDhvWjdtcEpjMVVXVWJhYzFiWnlCTlZGTXRv?=
 =?utf-8?B?eklITlJNbFp2aVc1T2pBVnFoTGFuMzZGOTlpcFB4NDQzS1ZsZjRhSXpwNXNh?=
 =?utf-8?B?R2hybkVmcFRQYmxxMnZMbEpmRndsdzhEWThiTXhpb0l3d2JmQU1DUWNUWXhP?=
 =?utf-8?B?TXAxSGJMcWhMV0JML0JncFNsZWovN2N4aUdzbmdSWVlNQ1VORFhvWnRnK093?=
 =?utf-8?B?Y3N6R1VPalB0WDlPTERTaDQxeHVTS3dUaHFCWjBYVkRydkIwbWVDQ0ZNRG9U?=
 =?utf-8?B?UzNsVktnMEpDUFNKb01NOTF6L0hQRE9IV0Y1cnRaQ001bmk5dGwwK0hybzNo?=
 =?utf-8?B?QnlEWlIxaVFrMWpOUytYaEMrQ3c1MXlIQTBkNnZhZnBoNFhvNGk5Y1dKaXNn?=
 =?utf-8?B?L1Avd0VuNmR6ZzA0OGlPY2dmbktlZVJsQ05ONjdxTUQyU0FmbjEvRmdMT01Q?=
 =?utf-8?B?Q1JhRldYd1NTOW8yYXVsODZFMHMreUpVNWZtMVVRUmtJVUNHWWNLT3dwS01V?=
 =?utf-8?B?RW41U0xvSERSMlZoRXYzS3hEQlF0c3pQQVowMHV0alVLbVlxR2QvSE1pZGh3?=
 =?utf-8?B?TEllVTJ0dUhLWTlReU9uU1N2WkR0WkdGZzNvL0F6UkFjbzNmTER4c0RlbWo2?=
 =?utf-8?B?dWNBWXQyVytGcXErNS9mNWt2M2NFcURuZ2ppbS9uRXZ1QjVSRUMxTG9pa0xv?=
 =?utf-8?B?ZVVJWUtTNWR0eURmKy9FWGlKUlhzTndvZ1ZWeHdTSE16eUphK3lYMm5uR0Vu?=
 =?utf-8?B?Z0E2QWs5eEo3TjJ0VlRDS1QzckJvQUhjRVRodzk4ZmdRZ0k1RWpNM0FYSy8x?=
 =?utf-8?B?K2NZdTExeUd0SG04MWhhT09JRlhFYWpWYnNORFFoT2Y4UHNMcmY1Nmd2N0s1?=
 =?utf-8?B?Znh2cjRTalVXY0NpenNjV3VkVythRWZRR1BXcjNQcTJqUldUcHlMdkhFdktU?=
 =?utf-8?B?T1VjRXJZbUljV1VLeWRjeXdFVndDVWU0UlR4TnJVMzA0cDByMkIrNmNHZjIw?=
 =?utf-8?B?T2JMajV1QUEzbG03L3RKaE92SE5PU2MvaTRkZkx1R3MySk43d2RqUmozZy9D?=
 =?utf-8?B?U1BZd3BsNkFFWWR2bE9NNk5JNVg2dERodEt6dURsdUtBY2pWWWVGRFZuQkZy?=
 =?utf-8?B?RUJqK2plMEdpOW1JWHZyaXBhQjlVZmZ5VnhtVjV4MzVWZkRVMFd6MTllQU9J?=
 =?utf-8?B?OEdPdHdQOXFaSlN0TW1jSFZaTDZDTmlaWGhlK1B4TjFvaEtua2RsWFFySTVU?=
 =?utf-8?B?YUU2eUNPckRSSmRmZGx4dFVlMXF6U1VaOWh6bWVCVUFIeXVndTlYcE1uNjNh?=
 =?utf-8?B?aWNkWVNkczhEM3VJV29hNDFqR0RLL2hLZEREZ3FpTlQxOGdDTWN4Qkx5eGZ4?=
 =?utf-8?B?QXpkL0Zqb2NDMmU2YkpJa2NGajdDclpIZm9saUowelNOLy9CT0wya3FxM29S?=
 =?utf-8?B?UllWRnpkY0NVTEt6ZHQwT3c0dGZUcjFZdCt5OGMxZ25kcHhRUDJCYmNJbE9p?=
 =?utf-8?B?aUIwMWRqM1dkby93RkgxZEZUdUJvL1N3YkcrL1o0K3dCaVVGOWVUVCs4eklx?=
 =?utf-8?B?RDhvMUgvMTdRWENCUi91WGRCdG84aGtpRlc3TjBaWFgwRVpBbFJFQ1c4OEtO?=
 =?utf-8?B?NzY0QW95VzhsYWxSemYrL0tnYmNPTVI3eUlJeCtuUXUrV0hrdkVTSDdLQUp0?=
 =?utf-8?B?WjlHNE1nK1VMS2I5anVlbGN0VmFkaVlSTzZ3M2Y4Q0RmYm9PYjh3OFZVaEt3?=
 =?utf-8?B?bVJVaHBLR0M1TjBVRktMOENzbFhTSURnTUV1ZHA3d25nVzZMa2dNeW5RakFu?=
 =?utf-8?B?c25IVFd4ZVhyZWt3aVRjdnlMUlZTSWFpWW53U3Y5WVFHMExYeDYyUXpSaFdJ?=
 =?utf-8?B?MjlvemhmTEdjRUdWTnhaUEVqSVB4ZUZsTVh6MlByamNJRWViczMwUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe37468b-b9b1-4845-ed39-08deb28a1065
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 13:58:38.4861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0V5xKYJj1oWDl2DKVjzeM10368gRzIzqEwGBu8QbrFM5R/JAq0hQ9qKMDFYnfJeTy1GCpGOigQddQl0rooSEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5429

On 13.05.26 14:49, Florian Bezdeka wrote:
> The -D cmdline switch and CLOCK_HOST_REALTIME support has been removed
> in commit
> e3a3a3025b14 ("testsuite/clocktest: Drop obsolete CLOCK_HOST_REALTIME
>                and wallclock offset bits")
> 
> so that an invocation with -D resulted in the help message.
> Taken from one of our LAVA test logs:
> 
>  + /usr/lib/xenomai/testsuite/clocktest -D -T 30 -C CLOCK_HOST_REALTIME
>  usage: clocktest [options]
>    [-C <clock_id|clock_name>]   # tested clock, defaults to CLOCK_REALTIME
>    [-E]                         # -C specifies extension clock
>    [-T <test_duration_seconds>] # default=0, so ^C to end
>  + /usr/lib/xenomai/testsuite/clocktest -T 30
> 
> Removing the first and unnecessary call to clocktest to clean up tests.
> 
> Fixes: e3a3a3025b14 ("testsuite/clocktest: Drop obsolete                       CLOCK_HOST_REALTIME and wallclock offset bits")
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Hi all,
> 
> During reviews and some code reading some minor regressions in the
> testsuite came to light.
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  testsuite/xeno-test/xeno-test.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testsuite/xeno-test/xeno-test.in b/testsuite/xeno-test/xeno-test.in
> index 590eac1e0378309e5a8cfeafac3654bef86fd231..de2749c84592d218889a95cd7bc615aa3f0cae2f 100644
> --- a/testsuite/xeno-test/xeno-test.in
> +++ b/testsuite/xeno-test/xeno-test.in
> @@ -108,7 +108,7 @@ fi
>  
>  start_timesyncd
>  
> -$testdir/clocktest -D -T 30 -C CLOCK_HOST_REALTIME || $testdir/clocktest -T 30
> +$testdir/clocktest -T 30
>  $testdir/switchtest -T 30
>  
>  start_load
> 
> ---
> base-commit: 54e9c509863439614484b0bf939c32bfadb15423
> change-id: 20260508-wip-flo-drive-by-fixes-c51c8be9a7b1
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
