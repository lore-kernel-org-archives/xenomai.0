Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D874138F626
	for <xenomai@lists.linux.dev>; Mon, 15 Jun 2026 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512404; cv=fail; b=j04SnhX9VeiFQerlCdBsyTV/KcnuUv2UeiB5oayPGdbTWCUQIOG129ziwg+Dfz2FDeKMfYLJ23m06/rwrMGm4QHo7QGFPDe/GZJ9VOGBaUUk/WHv9oE5RzJF2LXVrqWyOIiRbA9UQXwQKMjF4NefUTDlAuV7FASOKCdOm0AmsXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512404; c=relaxed/simple;
	bh=fSbYMpuIeeZM5b2+f0GT9oM/sRa4Ns1/OMLtQ3bC+28=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VMZw4a8Bi3jKKbbE4cADwdhahvia3aZ5bWK1FUTSHFjo+UmqsvdRc+4S/xIBtTqHLW+U/USAR6MJi2d4r4bU0iuOabtNUI+lh1dxx5MOG1ickISprtvsTMOG/KK//GqwDyy+FVb7blYZb1SUjKgeHGRmUkTHu6ZuDXh4LuSrgyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EZ7y1XnW; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EZ7y1XnW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtAT+1UKuDmD/oW96yPsYi4asg/9QacTxLhMNyvniSCBZDyGSQLD7jTnOAVV8h9gBWYFvHFaOOvXU1zKmUEgea5JxW+U4mpxHBwEjnKs1RRhX+TIYjrQnCX9Z3ETwNWqAvxu/PIPDcWlbO4EeHlViz0Yh8YAa93dbEkjjIXxZviyjTPIUE9VrLYfAk6Od4n85u1d8dzIKlLBxjUx6p0MDbp162UIMY7BD0UnSQPx3PSPRwzOhwxGk0fc/cotnQB/u1dJvb1FWJfYlRR4BHseF9Zf2ug/neXhzN2t1pZxYICGXAnWOA569PX8x9m9Ycr6X1WHAOZy067xHA2ZCStLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tB316hLvalanoZeJAwpy8lp+mqpioxpfpuMv6l3BG+I=;
 b=NZTPG3RPPl6JlO8utazPGqn/FGX0SJDPoyYw8q7qMy1TvdhfVSJvVeAdpL/6xS40fEbFJvhkdQLhECqSRpasSMiS5lmRG4R3FVagQjcwOjrnwAtKlYr7ZntTmobtQLULTd4WEmgz97yn0cYvz44oZVQ2+/YXMQtPLQ1YALrTeZ1IZ9qyoSnBqEy7Icovis2MbhrP+BqKlDES6J6uaSQYBRODrafM8Zc1Lge/WXonuUK8/0ncIeqPRuqw49bfRdpxATCCvcGmqB07gZVhXBbgpN37gmOd4ziIiIehkPpuazTXs7aIP7iYVNhWWvxxopuVIQ+qlm/YgODmNPnYnq39aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tB316hLvalanoZeJAwpy8lp+mqpioxpfpuMv6l3BG+I=;
 b=EZ7y1XnWQUwpkv8s77W/i1DbBN8x4eEHepD8ArCzFp/H3LWtHabhHyo3HF49fj9Ook3ON7MNJ/YSOYMcs8tGYM9dzwXWssKz3O6jYi+jUNxiD0UqGnHpj+5+23LkNHUvRlsTzBDZqmAnTh02pe0Kb6A1ECdfrJqsljbXqyQYi9+0i88myiJ75sX4YWJ2H+6CDT6U5Ongq/2ceajwAuLc/WFHaCkgWr5LAlpNMCDS5bEyX9Zk3W3f+wvbyaNTFSxbrq3hPgJD6RSHZvKHTZGvnrjfCGulyWtWsQidKoNkrShmIVEg2GhtlVSyZ4rblfFy3JH4KfwXeu/Aam2zCKD/wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6945.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 08:33:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 08:33:14 +0000
Message-ID: <28f40baf-6a24-49f0-bf15-415e7ee6e34f@siemens.com>
Date: Mon, 15 Jun 2026 10:33:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Possible Xenomai 3 latency regression on arm64
To: Philippe Gerum <rpm@xenomai.org>,
 Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <8ed28071-2341-4322-bedc-df1929e3a125@siemens.com>
 <87tsr4fe74.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87tsr4fe74.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: daf9af37-596c-4a74-6f00-08decab8bdef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|55112099003|56012099006|11063799006|4143699003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ux9TTzlK1P2Y9zL3GZtgSUI4Sesw7WVRiDtMoDW0stoO7z97zYtMvZ2BHrE0w5aClFHrItS4Siv2kOx+h10cmoVFtKdJj56SQkfE2bPieqgAa08pMkjDF8Udq4CBUAEc0UAgm0TJXEMzn8anNWwNPdqDryfb+oaSp+eKKr7hRuPeMPcRkMPUjqn++4uCyvi2QeFfRnQNmd4daWqg1sqeOvbdbs+QlrJinDeRAEj6qVr00bRB/A5Fmahb31EzEmsreA0imtEX+ImGdORAx3nvAVcGMgCm1TzcPb+kpf4TkVhZWofv4dZfTNBFOnIGWcnNmLZtMX8jzfb8dh85d9c1YygZ3W17YZ/Lxy+SsmJ0QxHfCELiOtYtXIpe+CZ5Z9kIeRn3OSmz6rTDY7p7WFdousreP1iJzjRWkiXWf72OGBntVMUE+EVO+kqIdtNFfi2GeatSAYi/DKY+o5OzQWKO2Bv2i9k6P2Fxa85W3YYOob3Vslz3bjwFraFE8zInP4heqGlGX9bLjsYx/9Uu7BwKBzSsq7nUbSWm03rjK8o3hutxH24NVz3GxMwrrQnUd1KZtFmQBRvMDOv91+sUE1lAsW7BqXH+EBCvu0ihHZf7LygPDGpAZG+KSqymtr1MQ8I84vKAJrU7PfEZUUPwTdDFuTPdehSMxOugGld0WV7aZwQmvZZRLnWjRC6nn4GMhPFV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(55112099003)(56012099006)(11063799006)(4143699003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnBOZnpVVWtLSit1ZllrNkU1a1llNXdha1FhaEhSMGF3UGwvM2pjaUhFZkdR?=
 =?utf-8?B?SU1WQnowSnpUWHdBa0ltd1BHZ28vZVd1YXlLRmpEbmFZeTZYQjlINnlKMGk5?=
 =?utf-8?B?NHNMTWh4NWJlU09kT1VaYTRLalRiby9EbGFtOFRaVW50S3ZSbG44YUxldEF5?=
 =?utf-8?B?VUpYOGVUeFdqbE9jT1BFdlZZOHQxUGhjM1JnZ3M4bXVkODllQXFCa2FHWVE4?=
 =?utf-8?B?VE0wOUZwN1F3LzdQVlZiVUNiZUVwWStXdGtwS000SXZhanREODBOZ0tNMlJ5?=
 =?utf-8?B?Wjg1Ym0zbXVUZlg0MVhBcVN5YWU0eUlab2V4Ly82UXg2QzNMMGU4VHhRRFE5?=
 =?utf-8?B?K29ZblNkOEc2MUQ5REgraStEeTZSNXV4Q1VQY0UxWTBlT3RuVVNQRy9veTY2?=
 =?utf-8?B?MVRTVGtGMm9UK2FQTm1CSVV6eDc4Y2VxaHpRcVFML0ZHZWk5VnNHZjQ4Rjl1?=
 =?utf-8?B?dUo5emhsQlBSc2RDSEY2bmhYZVcvTnEyOWRLM05mYk9wTUdYa0pLdDUzYVZx?=
 =?utf-8?B?RmNwZzE0dmRRRWVQSXBtYWZ6dURsUUdneGtmYjFROEFlcWUrLy9CRExtZEZO?=
 =?utf-8?B?d0hqd1p1blluMFkvTytxTzhqOXNWL1hjWEtTK1ZtWkNOQ0RsVkxmbGlWVS9E?=
 =?utf-8?B?Z0JJTnEzTHZ5a2FzbmthcVhycEZnK3AxTTVHK2dtWVpYWmFMZU9zY21qeVg1?=
 =?utf-8?B?MFRmT1Q5bk0ycnpOWGZmdW13TnhkOExSWWtlY00zNnM1Q0lwdkhSdVZjaHFG?=
 =?utf-8?B?L1dRcXA2WEtBSlJaaUpDTnpPM0FvandGSW4vNXlNSm5CTUpKV1ZrSkczNlFJ?=
 =?utf-8?B?alAvSTZITmQrWlZlODJHdVFFd3IvbG9yTXpOMnBHODJ3YWNLQmY1OEpRbm5F?=
 =?utf-8?B?NG9WYlNENkxXb2VMK0ZPeFZXMW15U2w1dmJ5SCtZK1E1aGIzNUlLQzlMN25x?=
 =?utf-8?B?YnZUaUQwbHhENHppQ283TGFxK0dwNVgrdWVSdll6aHdCWlkxc3h2RnVXRVo2?=
 =?utf-8?B?MnpwNGFueEFWZUwxL0JxSWdVLzd5V0dzYlVyQmQ2dnVFR2t5dDFJSDRVbFMz?=
 =?utf-8?B?d0YzTHdSSlB0WHdnWFdwZzg1UnBYSlNwa0x2RmtMTk5ITHJtNXZiUk9rY3Yv?=
 =?utf-8?B?WjhOc3FqRXE2QlpCV1FxZkU2YWIzSm9wcjhlNzY4UVMxUytVRzYwcUlLeVlT?=
 =?utf-8?B?c1ovdVlra3N0ZkVrbVJtYnQ3MDRGU3J0MkoxczAzdEo0Qk1aYTNTWkpqMHM2?=
 =?utf-8?B?eXYrQkZMNDE0S2x2TjF0K1FVd0cyOUJVamxVWllFOEFPZktVb2dwTzFtNkhY?=
 =?utf-8?B?ZDE5SXdPV2RWdEd2R05YcDBWMGE0MlpqeHNsejIzeEQwNTRvZFY2bTBDcmdy?=
 =?utf-8?B?UVJTQkdlTGE1cStCWWRhT282MXhXQWE4UlRrdTRZTW12eS8yQTdoc1E3SU51?=
 =?utf-8?B?TTlTWXVOZ1NaTEUzSzdQS2t0ODI2MDNmRGxrc3JzVWw2VVRCeDl0UHhnQWxj?=
 =?utf-8?B?ZFpvSVJPSkpQZU5WcDh3TE5GN1grRWhnS3h1WEE3aUp4UitjWHA3VHUwZWFY?=
 =?utf-8?B?dmRKMWR5SVNuRjVtdUJyQk04K2xhQjJpZ0o0dmFJanU1ZFp6SGxralhrSzVG?=
 =?utf-8?B?ZWpPSFNUVkpTOUhKK3lDMk9IeFlPSjZFRmxISnlIQ2ZDRGtSZXRCVk1LL2ox?=
 =?utf-8?B?UTgvZ0UwTW80U0d0TExHdmZJWEllWkNENG5ja204ZHRSQ05lRi9HSFgvejkx?=
 =?utf-8?B?WGRObDNWVXRnckZyQXovbkdsNjc4dlNtV0diamRLdXNNZEdyOVJIWFB6VWZn?=
 =?utf-8?B?eXlzckFrV0dvMXJJbWZCZjVmSmtRb2laMklhRTF2QlNmYlhVZU5mWUhCUHdj?=
 =?utf-8?B?TFI0b1R4UTZXcUxtTjBJTDFBanU2QmpmbGYySmVZenFxaUhER1FRV0pVQWxK?=
 =?utf-8?B?UVBqMm9uYmZiQmxKbjJUTFFyYktPcmpnNEpPS2FGR2pMWVJjSEFoNXZmK2dp?=
 =?utf-8?B?UElmMWxaTnFJNlBnSTFLRVZwRjRTTTlZNjJuNUltUlV4TTYwTGFOVXhIc0Nw?=
 =?utf-8?B?VTM3azhPbTlXcTY3WkVvQzFvVnFIdkZzOWFFUnJUbWtveE1YM3Y3MUs4VmxN?=
 =?utf-8?B?c0xSSDNLRDBJT250TFUwemtjQkpoazA0WTJueDhMVWZ0VWMxY3ZmZVFzRlhT?=
 =?utf-8?B?dXg4VkcrUFgxSk5VcmY3ZjBNMno3L25uL1ZuWTlKRUdmUWpyblZyMnlhbkZU?=
 =?utf-8?B?Uld0czMxU3ZGWk9HUG9YS2x2bjdLQVNyRm5nYi9HTTF4NVhZSTg0T1prL1d6?=
 =?utf-8?B?bzYybFZ6SGtUYVV1alh5alBCRWdPcWVkOWUyMDJpaEdEK0dWQlIvUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf9af37-596c-4a74-6f00-08decab8bdef
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 08:33:14.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLdM2dlUWdJ/NkrG5KqR6s63Y2whHIvsUZ/1si1BUNyrC3LNA09/mr7pV+TwqykuU7MzbDaDST3N4AvBYLCVKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6945

On 15.06.26 09:35, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> Hi all,
>>
>> it seems we got some >10% worst-case latency increase over the last
>> month with Xenomai head and 6.12 - that is at least the setup we use in
>> our long-running weekly test.
>>
>> Tonight, the RPi4 test triggered by exceeding the configured limit of
>> 150 µs [1]. About half a year ago, we were in 130 µs range with it [2].
>> x86 and beaglebone are apparently not seeing this change.
>>
> 
> My rpi4 fried. Is the issue visible with x4 as well?
> 

We do not have long-running latency tests for x4 yet, do we, Tobias?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
