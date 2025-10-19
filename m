Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010070.outbound.protection.outlook.com [52.101.84.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F635966
	for <xenomai@lists.linux.dev>; Sun, 19 Oct 2025 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760886330; cv=fail; b=rFu6lwHxeYDrSw/5W29piN9s86kqT6i1eVqF/V7je/ur5p5tVVD7bxSPBlsAgSeZphGfUbZXOk6m/hOiU2GwbFmFrTILX8f8fDCfpDg427sjc7xuQiMa8HD9yYhKC4tPwkkJU9ObunP9Ysae+TL/G8dUHqYIVJJkp+UdaVCfckE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760886330; c=relaxed/simple;
	bh=P/1smx8l/VTm/ShqN207l1og5+6kxwii/Y3TwOrsAZ8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mM7QLXqlMYsDQYSKPib+Bu0OZf+EFWvRh/74z4th5vJRzaL7FAQ8wYfJ4VaELwzaRIjBYLif+mmn3KKwxC8EBcS0T2Wbz7/oFj7ZcUhjKxQOPWpWnwlstXexCRPCRPGo9S+pi+Rb9jPcHJlDiJYrzEwyRWaYouwdi0K2g0sjj4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qWB1tbI/; arc=fail smtp.client-ip=52.101.84.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qWB1tbI/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/+C5/8CvksnQX/GTTxU8RQgz+PQfsG/fpz5E10hQp03c8Ghc//ph+utoVWMbbi9hGVANy2jCZJaCkJmR7zK/WR6LgyofyJO3wesKf8Bnc0sP00+cNb96QUVCrLumPVqCahC4UBfbFEimoFIEsH5JL13CGp7Pzv1eXbE2Lq7xDWxbroqgtjMrJwJndFBEZpe2rty7XKZ9S6xeTHCzo+xpblFwye8y6gLw2zcACQx9HzwBkId3gJi2n0KirOuSzDsVITGfs+jK2u4/VdczahDHVGuH82b6EFxzGZAnpp0ojGWQzjcrUSDOFhA4PsHs94LXHiKVCb5DcZlln121X3u4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hN2ixEHwRj81ARSOmFJWikRVQp2LFel+oAXLIVRwcQ=;
 b=yiaNvkfIlI63UVUf+D4gK+kKY39U/IGxNr9yhbWO+gVk6fyP3S4nDp4mV6MLR8hkF/7uUyAPVV8tlxeQ3pog4GpJgAL69/GpaOiyH8d0+g4kjNUMfCFKTxtFe3EYDla01bTxHQ7WDiOQVRSe23dqrWHmzhurefiHRjwVtA3woKqAkchaNzTIOkLgWdHiThHYJndPNAwCc51r3AyAmqPwFV8THJd/svDsL2MnqhpSaW/CPNVyw9mLs8DQo2AjP+6HcqK2fOH7ZtzjzA1GbqIqINMrTvyVi/1yYA8BG5ovRVYzyhMIZPCaMM90QwFXjo4dSDcfyyv1gHtHBM21A10oMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hN2ixEHwRj81ARSOmFJWikRVQp2LFel+oAXLIVRwcQ=;
 b=qWB1tbI/vlbIOttI6qT2ckBXApNlmppxMEuRM3iv8BA5gRA9Fhssd5VDRpnR5bPT7hRD6FqFO6HmM+pgiYRTTqxzHpoApSBglNQvdiu7LUPWoL/6FZhs9GEnAwqyRlUBkOAYkhOi/CxUgdpVDe5shGb7Ln2R+luDAvaxmqxfmIvLyS+7rarfENSnrMt/yq0n2Tp0tDmo5NYRgt02SFsZzlqT2XHLy4afwUmZwbSwn/Ag31ZbRWvCbZMjxCbVKUsih6QmfzKnxAC7GU14IjvT1hSley99kPtK3aOLILVmes87Saq9urJS5//RbMt1I0dujI8RCxKVdyekgO4Yc/WTsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8943.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sun, 19 Oct
 2025 15:05:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.014; Sun, 19 Oct 2025
 15:05:26 +0000
Message-ID: <448abe6a-5fe5-42dd-8bf0-b9eb1ea6da93@siemens.com>
Date: Sun, 19 Oct 2025 17:05:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs(xeno3): change to client-side search
To: m.kurz92@gmail.com, xenomai@lists.linux.dev
References: <20251015225345.66662-1-m.kurz92@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251015225345.66662-1-m.kurz92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0340.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: aeed89c7-87c9-4f09-5b0e-08de0f20ef6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2ptQVBnL0JWNVpWYStBUngwTk5OOXI4SkdVeVpPQnJzK0s1aXlaZHZoWjYw?=
 =?utf-8?B?MHRIRVJUUWp4c0Z2UTZFa01wcmxJWlRISXZ4SDZVbjc0TGdpOTFoNEM2Z2tZ?=
 =?utf-8?B?UXR6eitGem04dlI2eHNEZ1I5a1RZOFBRT2M5bVpIaEEwY0FxRHdlcnlCKzFa?=
 =?utf-8?B?QlBqb2xkRWpIeWQ0V0M1dzJ2OXZFQ0Z6U29KWlZtS25iTXBTc0p4RDllT1dq?=
 =?utf-8?B?aWh1aEJrMkFNd1NWRDRZcUtjOU9YRmtpeHpiMWVlYWJDcUVvUE1RVEtKY05O?=
 =?utf-8?B?OFRydXh4SzZYeC91MFp0Vk5BbWU1WVJ2STMwVWFyeEZPRElpTDJKTVRuMFNk?=
 =?utf-8?B?RnhiUWlMQTBpWnJFQk9USVpxWTJFUHFidTRJZ05WUmZ2Z2Z1QXJneVh6cktq?=
 =?utf-8?B?VzhTbFhIbFFqQkl4V2haK281TUFUWFdCQS9QaVlzTVBzWVgxQnE5Q2Jwb0J1?=
 =?utf-8?B?WWxmUVJrNkMwdVIwV1NYS1NqWjBRa3AzUld0Q2dWeWZraW93b0l4dTE0ZzY2?=
 =?utf-8?B?bVZvRjFyQzhJb3UwNWZhODNJL0lIRzN3aGZGaS9FaVQxcDNCdUxWazNtRlcz?=
 =?utf-8?B?bklYTUJOWjdNSUNqUDRGaXRVUXZvQTcxRkR6R21UdklJYUc2SXpyT1FzTzFI?=
 =?utf-8?B?WENZeWdoTmkxdW53L0lqUTM3bXJ6T0tCL0MrUGhqVUFPWmwvU3E4TDFidVl0?=
 =?utf-8?B?dnp3MTdLUytVeW85MFZSd1VKTFluSXFmTGNPMjh1WVZ6WFZJZVk4dkxaWXRx?=
 =?utf-8?B?YWRLK2tMWHZjTnJ4bFhWUDhIM0xOUFNvcDVFWURsQzRwSDR3V09kVnppK0k1?=
 =?utf-8?B?WGJYRHUvSEcrWkk5aENITURub2hEWEtmc3JyYnZZdlpRN25ueWYyVklwZTZT?=
 =?utf-8?B?NEowYmFKQjd1ZDRiVll1WlZBRHdVRkFHc0gyWGt0WXdjK2puRkpuZG1LcFUy?=
 =?utf-8?B?N1VDdGhxN0RKTEZqekJRbHh2RS82bUV0YXM0d3BvVmIxTCtsZHlhNUVBSEpo?=
 =?utf-8?B?M2VCanA0dG5yeEJNZGczaGROZFQyR2xhdXhqSVVKR0pPNkFxYWs3ZEo5TXVW?=
 =?utf-8?B?cjFBWG1IVDhITjdodnlpSXJBTzArelZBZHIrNE1pUUE3ZDF4QkJCRGxOUjRD?=
 =?utf-8?B?amtrbngzNnk0RkxQejl6aDBaNlpydjZ2NUJEZlIyMDEzVDFlZWlmUzlldnFw?=
 =?utf-8?B?L3l2STlOT1lMcjRGeVFtQmxGV3ZYRGdTS3JvZ2ljcFl3MjRQbGVrcXlIM3Y3?=
 =?utf-8?B?Zk15ZkdvL3A3RGJrRTRWZEhodGpLRE5kcnh0VStDdnc4NUFhSTNjWENBRGZn?=
 =?utf-8?B?RU5WdmVHRlNGcklhbVRTNUk1a0VzRWFTbWV4WUhlWnFteVBKT2gza3N1NDJx?=
 =?utf-8?B?cFdSYkcwaXN3LzlnTFl1SStSSW03VmpVd2xndEgvWStVbmdJYWVOTGF2YXdH?=
 =?utf-8?B?WCtPc0FpbFJ1V2crVlRBU3hoMUcvZmE3b00wRXM1L2drMGZ5UVJsWWJETE03?=
 =?utf-8?B?VjlGcWhDWmZWVEdrakFNaXNCRXJHdVBsVTk5OXJpU2dpOFVHUFVZR2tUQng3?=
 =?utf-8?B?enZPZGRtNzhRVk8vQVZWcytNMmtlQllvZ0Z5Y1VVYUJickEzOTZRYmZRQnVO?=
 =?utf-8?B?QkNIRGVqOTVLMS9QODc1aUMzRHcyUWh3VkFWdnRZSldjYWp1Q3lRbjllRUll?=
 =?utf-8?B?UlJCM0ZaQUJwNGtuUzNaZ2h3UEwxcXpqWDF0V21La3U1YXpwSXkwV20yelcv?=
 =?utf-8?B?c2Zmc1F3Q2RsdmxCOTVmZ2IrUmsvMCtrM2kyc25pblk0YmVQdFVTTWpNZ1JQ?=
 =?utf-8?B?aWZvVTh0WVdQL1pSaWZnYmVnYW9aVE9UMUNZVWlGUWhFRVloRFo3MWNNQnVv?=
 =?utf-8?B?eE9QQU5WL25qRDR5aXFUR2FrQ3BGbG1ueXZlaHZTZEJBZnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THFQQno0d3RQNXlkK3ZEL2ZmUGUxaVViWHIrc2xIOC95QlZIaHpvSVI4Sklj?=
 =?utf-8?B?N0hsTHV0MjE5K1B4WnFTZStWNGQ2dDdTNndLTVlJWG5QTWpSSzl0RXpoUHF2?=
 =?utf-8?B?NUQ2QmhhdmRiZU4vMnF0Q0hlT3ZYTDlVU200RUdBUmFsd0tOR1lvTkpTOFZ2?=
 =?utf-8?B?ZThid3RVVmpUeURRMkFZdjFya2dmSXJSeXZHV3hnRFhmNkRXdjBqNFRrZ1FQ?=
 =?utf-8?B?SkJJNVBqZU00dmd4N1d6M1ZLYkQrVEpEVi95TnBEb092amxKTWpTVkJLeUt4?=
 =?utf-8?B?RFk1a2pLaXhKQWwvQVQ5V3FBT3dnNTFQZ3MxdXBZZTFBeGh4MmJlR0UyZWpQ?=
 =?utf-8?B?ZHI0NFZiL2VEWG9DK2Uyc2l0bWwyaExjM1g1bkRzUC83NEl4cVBnWnY2Ukxs?=
 =?utf-8?B?cGhTYnlTbm9KTm1QbzBiZVJ6Nk5FdXVPTU5vZkhvZy9FMStHZHhSY0lWY1Ev?=
 =?utf-8?B?Z3RNZzluWm12dkJHZXV2ZjBMSklzbUVJUnRpdEtjdDVVMVQ4RkR5ejhuR0hl?=
 =?utf-8?B?VFVmSGRRRzlLNkdKWUwyTlNsTHBYS24vSXZxL05ZMjNKVFErMjhIMTV1V1RY?=
 =?utf-8?B?MzBxYWQvZktTTGdKQjVGQkNIYk52V1NuQk51NkhCeG5TY09ackx6Q3psOUxl?=
 =?utf-8?B?aCtteks1Z2E5V2toSE9YdWZhOXNiaGZsSFZ3eXE3cEJnT0k1VElkUVVhbURR?=
 =?utf-8?B?d29xUzg2c2Q2VUVucmRwNjQ0UUJuYU5MTkE2RHl0NzEwVUp2ZEJhaXJVYTNj?=
 =?utf-8?B?RVpPbHBDZ2tFTEQwNCtUWFJDaFY1REt6bmFyYW9jNGlkaVg5UzJ2eXV3YkdR?=
 =?utf-8?B?YzlYdzNPRDM5UHRRT2NVaTJtaDV5YzFtYVdvMjJWbWVFRnRuUkU0L09PMzQx?=
 =?utf-8?B?eVlkMXZ2TEd2OTNXTmZHci8zRWpRUjBLbFlLYkF0SGFxTTVsTjNRWWgwL0Jw?=
 =?utf-8?B?M3FkaEZHL0o4aWw2RGdSN2ljdi9hMy80anllanNJYTJrNnc1cnNuSXlWS0tz?=
 =?utf-8?B?K0IxSXNwQnRESGFxM0ZUU29mSUlyWnk1czdXTHNPNEpCN1V1bTMxV3luQkJX?=
 =?utf-8?B?aklwalA5dDQrYUFFZjh2OE1GWXdOREdMbW9PNnZRcWdEWDZzK05OSVI1V0pJ?=
 =?utf-8?B?S3VEdndFeGFCMWZRWUYzdmp2SENueStsbmsrYzFuZmpocUplY2JrK2RHRjg0?=
 =?utf-8?B?aVhLcittTG9MNkx2K1ZqK29QQjNNdVpOLzNQSXBtRkhzUnZGSkxQa2gycFpE?=
 =?utf-8?B?L1Q3UGVaN3oxL21yOExlWktTc0lON0xXclgwYzJiTHZERTk3d0RQRGVSU09w?=
 =?utf-8?B?MkMvRkxsUWJQakNQWEJNUmNZTm15dkUxdTV0Y1RJL0srOTF0SVluV1VYbzNF?=
 =?utf-8?B?R0kybzArU2dTUEd0NDZEcm9UWUlOTEtaVTRsM0lEdzBYc0RkOEl6L0NBZTZB?=
 =?utf-8?B?TDYrYnF3TkZxS3NFejA1ZFVtenNSdXB4Nm9hdVgwWWdpd1JSSWYwU1l6Wmpp?=
 =?utf-8?B?bEVsdmthRlBJQjJ5UlpnZTNySGFsUDlzYWV4WkJPOG9GeHNQSkcyNjZRTGlZ?=
 =?utf-8?B?QSs5cnZPZDNBQmNBMHZFcllJaHhQQXY4cEV3QWhlb3RlL3JJRjBQeVYzZVVF?=
 =?utf-8?B?SDZTUmhpS2VGMUJodXArZ3YrWlFoM2dzV2J4L2pPWFoyQjZaM0YvRng2U2Nt?=
 =?utf-8?B?UWRacTFYRldURVkrd2dMUVlTRmFqUlZFd2d0UENlQTBxWGgvSkJWUkFiRDRs?=
 =?utf-8?B?S2RVVXBhZ2RRZEZITjRuYUZDNDB6S3BCM2FRYVZ5WGZyOEJYTUIzZGJ1ZXlZ?=
 =?utf-8?B?TUFHeVF3LzlNaE9vTDhCanBFS0ZiUnNvNlNqVnN6bFB2ZkF3NzUvcWZ0Skc1?=
 =?utf-8?B?cjRjNTl5TmRYbEw2OWVpNjYrWXVXQzBUL3BxSTJSdFJOMW0xR3ZDR1ZOSmxG?=
 =?utf-8?B?b2JrNzRHUFZmZStqMHdyR0dNNGFFa1VJTEFXYmEwNkNNZzNlOEUrYnB5bFpM?=
 =?utf-8?B?Y3ljMUowSldvM2FTU1dpdjVaQ0duc1hSNEVkelhzNDFqcGJuRmtONlJLaHRS?=
 =?utf-8?B?Y3BpOUJxcGJXMDdZSlVvdlJHZFUxMGVxeEh6RmlVczVqZU9lZEk0aUhRbzhV?=
 =?utf-8?Q?Q+R3JrH/NYIJtok4nlUgIpz0/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeed89c7-87c9-4f09-5b0e-08de0f20ef6f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 15:05:26.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJZFGeJWxN1PqHld0bI2JU2DHXhZE3etajQQ/tgmCt7IibowtN5yHWSve4AbZcntiFhKi96ztBrCkVCvSpnpVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8943

On 16.10.25 00:53, m.kurz92@gmail.com wrote:
> From: Markus Kurz <m.kurz92@gmail.com>
> 
> The Xenomai3 documentation is hosted on gitlab pages which publishes
> static websites. With the option SERVER_BASED_SEARCH set to YES, it
> tries to tun a php script on the server side, which just leads in this
> setup to a download prompt to be shown. By turning this option off (and
> keeping SEARCHENGINE on YES), the search will be performed on the client
> side. This makes it at least possible to find symbols and have
> livesearch enabled. However, it does not allow for full-text search.
> 
> More information can be found here:
> https://www.doxygen.nl/manual/searching.html
> 
> Signed-off-by: Markus Kurz <m.kurz92@gmail.com>
> ---
>  doc/doxygen/xeno3prm-html.conf.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/doxygen/xeno3prm-html.conf.in b/doc/doxygen/xeno3prm-html.conf.in
> index d9907b99d..d8f8fc397 100644
> --- a/doc/doxygen/xeno3prm-html.conf.in
> +++ b/doc/doxygen/xeno3prm-html.conf.in
> @@ -117,7 +117,7 @@ SEARCHENGINE           = YES
>  # full text search. The disadvantage is that it is more difficult to setup
>  # and does not have live searching capabilities.
>  
> -SERVER_BASED_SEARCH    = YES
> +SERVER_BASED_SEARCH    = NO
>  
>  #---------------------------------------------------------------------------
>  # configuration options related to the LaTeX output
> 
> base-commit: 1969b54822ea29c22e1944e450b0c0b34a33ef53
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
