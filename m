Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB5017A2E0
	for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744790363; cv=fail; b=p1ClA6TD8HUEWRgkWSXZdVnup53Mfnl+omKzPz9g+O04doe9ubVeUaNC/lXRfg8iWmk/W7XxNklxdU4nxJY7nVO1iDfycHOnEep4V4P2NoiQtxswRwUXBiRGK0+8pSiIqpSK9qht5jFJO5enL52cJZhtL0REy8t7UG/JWdhC8Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744790363; c=relaxed/simple;
	bh=/QhpM+6ui58vQly9YQkNBPDJYFCm6bR8/cfLQX/GlUo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UteFFT+GFO8ONvnAjEmTvDTnvrjV9XafqwJ/Fj6rhthWHwI9s0fjxOTVbvhI50qJQB5+xw1yW1/tmcorthZ9vIzI09oZGR6m/SpYavPFgq/rDmTXQe7r16khC7yHyNJ7z5F5VsB70m5i9xGc5CP2zap3yZR/SHeb1+Ovq1be4eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Mrk5mGPj; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Mrk5mGPj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKYOxwzj4QuPrjA62DGI5THwRFPktq8CzUxwUKe5nV7fdpWI8rPJI+sp/zuHM2kFe/bg4KbU11jtd+XO6Q8X9M9RKjCDRfyynNJ0tPNVphTBHgYQXOOYyKxIzCqP237/h4vw5D0R2A+qSl1O+zRk1jws2t2nNLr3Pl5npZ851Le1CXae1HFI3vTiXwNOt9CpxxrWOxhCSFDW3CAOskbbqP4pzNpRHO4rj3CnVT+XKK6c9wv70rnWxoog3W+cCgIyZcg74QIqgl0xMbSTBZsNfedF3E93VKZoBeR2m/Bbs8GgIdUU9eRiMX64Eb4/dxp9yqcfYjdELpJsjEdZJv3k6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MySB6Nd0lCFvfwJW0wASx0+yUgBV5vsYgGLfNi7Xbvw=;
 b=uSWvTJ2IsAnwHbLAT1NWOb8aN7wmKlR/SP5VAU+tnqR5yDVhxJ+dMbSefAXAthYkGysEOqz2rJrOASE9zDf/kVldtAkB0LR9Rsb95NW89rbTSvZuqA6ZQrKMgLkTyErPA7Ew9jcpuZve3CCuwRGrqodvZzxeKaXdg9u9O6Ad4JNKuEcdIScETCfR8cn367C+Jo2Jhrej87CD0NvdUrECON18EdVr2B45IpMtTTQ6RXhB+u/VB4Ya3V6yiCnqBrwnLnP/TgYl3cqm3Kqtubtl0TsQjP7Zk4S03xp/PMGlMJAuy1qIFIAS3PFe0QT4kV66Uv1+fsdvsLkbEGZYNtbdQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MySB6Nd0lCFvfwJW0wASx0+yUgBV5vsYgGLfNi7Xbvw=;
 b=Mrk5mGPjTKCZkZd584l+kOan1sHuzMdJrsq2+EHhrysVtWxF6QxDJWIXr9iB4G8UeR59/N4Arpe+7AGgnNi9rfyJGMRYJZ+Tjek2kzOPFOvQTUm1eu/PA2NkJq250sNnKCs4DhzTky9cNWm7uM97QbdEgyePy/ky5IPjm0VjadJM2wQHXLXuw3bejio5/E3EkmMnRrz2Ks26vLmio6xSa3Sm/d8YQiJP4qWVcBqlqTdspnAxfgFoYCHRZi7Nq580Ece+hloDsDeIqM17IRe21JQHRdYw0K8exxW0ZJ7f298GItHAtlAsQB1PS2sT63SACZ7FSfyWtxXeHImdb3XvDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8808.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Wed, 16 Apr
 2025 07:59:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 07:59:19 +0000
Message-ID: <61458c5d-1799-4390-9c2c-c6f44148e93e@siemens.com>
Date: Wed, 16 Apr 2025 09:59:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] prepare-kernel.sh: expand tilde in --outpatch path
 parameter
To: Haiyang He <aspirestro@163.com>, florian.bezdeka@siemens.com,
 richard@nod.at
Cc: xenomai@lists.linux.dev
References: <20250414141034.1682520-1-aspirestro@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250414141034.1682520-1-aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 7548587a-80a4-434d-85bf-08dd7cbc9717
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFV5ZnpGbmtIM0FsVlJuNU1qeTBZRStGVVlXUmd2S3ZQRzRUV3FwMnhjdGhD?=
 =?utf-8?B?Qi9UZnBsdG9RZDMxQnlDdUZ1b2JiRkpJYnJMeGZSb3puNkZXZkpxbnlUWlMz?=
 =?utf-8?B?Q291RUF1UG85eW15MW5TMzkwMDBmdm1jYUVaUFE5aENlbDBWSmRtbEFiNERw?=
 =?utf-8?B?d0FuaHRCYTlPY2ZwVEhBcXlseDlrWmc5YjZ1bzV0RmNvaHV6aWVXamtZSnJw?=
 =?utf-8?B?WEcybjl0WVhrV25UbEdLaVhvUHNCeWhNeXZGUTRmV2szKzR2S3Vmb2pzSk9V?=
 =?utf-8?B?ZGtkVVNJR2NvcGVVY1NoTGVlOUNoaE96dmRxdGhaZzBpR2gwMkhVVENBa0g0?=
 =?utf-8?B?My96YmJSRlFNVHlycjMzUERmeXZ0ZzJoeDlFenoxM0d3bTRYQzBXYU9QTSt1?=
 =?utf-8?B?ek5KWnpFMnhHWTVZUDVSKzBObHNIeFBac0oxVWtiNnpRbVg0YUZLZWNmUGtI?=
 =?utf-8?B?QWhwQWFpUjY3T091QlJ4WTdZY0FOOVJIRUVjdzJtZUxnVFNMQk9pZ2hPenlP?=
 =?utf-8?B?bEU4SVZabTI2N2N2bE1vMjFZdVJiQjJtcFFXeFhuTGVuUmtjYWpYNkprR2Vs?=
 =?utf-8?B?QW1WTDhBRFdIODY0R1BjUGg0aHZkWHV2eUJodXlFS3Jjc1REaDBHay9FQzQ5?=
 =?utf-8?B?TTlYVHo2UmtjTGpXV0szaUg0WDF3bENRNkVERnJJQURINVVFem43K0Fqdktm?=
 =?utf-8?B?QVh0Y2Fvd1FTZXQxTENrZTQ0U3NkenRiOU96QjZyUUliaCtGRzZqVzhHS3ZT?=
 =?utf-8?B?T1Uyc2FObU5ZRjU5QjZqSGlXR1QzTCs0cksvZ2ZUalB4ZkY1UStRZWszbjNZ?=
 =?utf-8?B?a25XWnFhc0pCR01ZUDkrVWRDMXRPSkdlSE5uc291LzhRN1lHdGRQcmdiN1hu?=
 =?utf-8?B?TndIRmUxb2VJVWpMNXJGSmVUL1Urc0RWalpqM2oxQTBqNXcrdEltMUVDVTBq?=
 =?utf-8?B?ZWNWbi9KbzNyYksyQmMvdGRtUXBnTGdVa3N3VlVuVkF6U1dWTU9kaDVSQ0gz?=
 =?utf-8?B?UVhpQWlGbHNkWHhQQTdFeUNwWG84NWlwSDlGTWxGcnBXS29iRDhFNndFNnlE?=
 =?utf-8?B?d0FpdVVCM2tNUGlhY25pZzNiMjF4Y0JYZWNQUC9Qc1dsQzhRNDBQK3JJNFBS?=
 =?utf-8?B?S092ZjJaRDRnVFYzZXhUSzBKTnp6UStRb1IzSXJ3SjVJNVhVUElsRWxXYU9G?=
 =?utf-8?B?UEpLSXJSKzdDRjN3c2lGM1IyaHRrRlduNVI2RmJBSUp3WFZuelFaL1VFcmZh?=
 =?utf-8?B?eEtiUGE3RlpWMjZIL0txbnc0SVYycjhrdXhxT2JySGRQTFF6dGt2SkMvcklF?=
 =?utf-8?B?RjVEUUtnM1RVZmhtQVhEek50cG9rK3FWb2dkSzM1bTBLNEtpU1R6dEQvb2pk?=
 =?utf-8?B?OTNOc05XSnhWMTdnT3k2WGU4RjZ3WjZnTDFoNjJHTTR4dzhkczQ0T0RDUlho?=
 =?utf-8?B?MEtTcGRIN3VKSmtuNVVubWZQUGVwVXhKV20ycWtoS0lOYk11VVZvczVwTW9s?=
 =?utf-8?B?anBLSUZ1NzI0QTdhN3JGWWVJMWtSOHBlWkRWOW5CQ1E3b2pDd2wzMXFpOW44?=
 =?utf-8?B?anFndmcyek4rRW5wSzcwank1U29rK3dCNlp1dXVtb0FVNERnbDZHd0twRlhw?=
 =?utf-8?B?ckhNc0lWWUdJWjk5SmR1Y0NmSTg5eXVmdmR5cWxwd21VME4zalV3VDA2bTlh?=
 =?utf-8?B?V1ZsSW9GUm0xT3g5dVVITTZmTXB1Y1RWTGtwZkF5TFFlREpmcHhGRS9ibVVL?=
 =?utf-8?B?VU5ySC9iODdzYVZHc0pSNWdGMXFvTEw0QlZSbVF5Y01ySUIxajZJVm9XT1JR?=
 =?utf-8?B?cWYzRlJWS1BORmRrb25HQzJrTWZjcDB5TERwZmQ1RkU4ZzhUaVM0eU00TE1G?=
 =?utf-8?B?UDFZNm9JSDA2SmNTeDJ4SnJoYjdjQWdOYTdReWp3REdqOGYxY3FIUkd0SHlB?=
 =?utf-8?Q?Nvk/fH7I/Jg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlUyWnd3TlVkWHlmbThyZlY3WlNUTlY0ZE94OWtnVmw3Sm9ZMVJSejR5Y2ZX?=
 =?utf-8?B?dGdnUWoybmJyM2FDVTc1NXFjVWpIeDhscTVlSkUvQS91SFV2bnl3a1k0VVdt?=
 =?utf-8?B?S0ZzUUFGMmRxYnBxQ1lwUklzaGV0UGgzbDA0YjE4eS9EaitWUjRjTW13SE55?=
 =?utf-8?B?aENIWks3WnZKenFwZVNUQXVjbEhTVHlpQTJJZjBITEtjQlEzWCtPK3hsell1?=
 =?utf-8?B?dXAzNHBHVVhraWNYUFIybTIyTjJLU0lKWVpkVE8veTBBQko3eTNpLzBwTTY1?=
 =?utf-8?B?cUxscWl2b295NjA2RjJBdXJnUkI1U0xlNEZTVGVwVmd3ejQ3bjBsZFR6ekZL?=
 =?utf-8?B?MGNiOTVZdTJmcmxSbXMzWWhsd2Z1ZUVOUVBFU09uZ2JSRkpSRE1xVW5UcFR0?=
 =?utf-8?B?NW9jWGhMMlEwY29yZmRUeDFTcjF1RUVsdk9EcnpKYUh2S2ppcVZ6UDRLTGE5?=
 =?utf-8?B?cmNtQ3VDYWxWUXVYOGdSdUVOMitKbW5neVlYazcrV3lRWjZjajhoVkhXTFBv?=
 =?utf-8?B?ZkhzUGRkUW82T0hoMktzYWJtUjVEK1BkVytoTWhzUDc3c2YrY3BucFVJV2Fw?=
 =?utf-8?B?QVZPWm44MUZWTmt0Z0xJcEtsd08vUFpxTFI0T0VZcnhSM0YwWDF4VWd6dndY?=
 =?utf-8?B?cXFzaEtnWk4vMU9yaVkxQWZnbmZQU2lCeHJmdHA4eHNVYkEycU95Z2hQSTB4?=
 =?utf-8?B?TTdvckJrVGx2RWVJN3A5WW5iclJvRllMVm9XRkxvV0FwTE83VHdmbU1LSnEx?=
 =?utf-8?B?bnh3ODNLZ2lnRzFpU2JOWHRGNUIxdzlhaUhrMHkxMGxzclRLeGQ0K2pKcEhP?=
 =?utf-8?B?blBFdEUwWThQQmRqT0I3OUV0cGdqbFdWcUhVYTI4NVZXLzNVVllRN3R4bHJn?=
 =?utf-8?B?MFoxYVJYb0tFT3pkTnJCbG5ld1RST0lZbkVtRkVwcUMyc0FyU1FKQnRCMUJ4?=
 =?utf-8?B?dnk3Z3B0bHArVGZGRWxSb1d0Qmtxa3d4VFZ4c0ZWM3BpNXV5RVZpRnZBMy84?=
 =?utf-8?B?RlVBRVZpemZaWUZ4L2RpVTJYUVdTc3RhVlVveXl3RDJ2QWZCSmgrNzJTUndZ?=
 =?utf-8?B?UlhLcEdSRUVTaUlGekwyK3lqRWhmL3NTR3E4aEcyRWtDVEVSbzArWXhqc0Nh?=
 =?utf-8?B?NzBMdm10NzJiZkY3WWQyQlZzcjM0YitqeDRPSGw5S2g4MFRJR09sODZ5MmFv?=
 =?utf-8?B?dDhvMUp2MGc4dzhCMzZYSnFwd2JvaytSUGRlSng5V2J6MlFuNlVpek9wcmFY?=
 =?utf-8?B?cVVhRlRMRHRpV3A0WmpNdlorS1l1alZuTjJVTytzVTNwb2RpSnBmQWx2eFI1?=
 =?utf-8?B?QzFPZW5LaUxGSlh0VUpySmduMGtQSUZveWRaaE9LTllsQ0lIWkxTZzlxUWpJ?=
 =?utf-8?B?Y2JES21pTnBqTnVBU1Q1N0tJL2hiYzZBT3NiK0lRNzBXVkZUVjBlZ1VFeXBh?=
 =?utf-8?B?UW53T3l6Zm0wVzVaNVFqTmxOaGs0cEJVd1hYVTRkYUNHR1hJcWFVdTFHYllZ?=
 =?utf-8?B?ODVWSzFkUUZOQ3k0TzNCZlFESVYrd1JmS2dTVlpRZ3RmNmJtOXJPMVJnWFRO?=
 =?utf-8?B?azdZbnFPbmhBNVRLRkxRWUxZaUpoc25MaXQ5TkZ2SUFMM2FLUk5TeVZKNzZ0?=
 =?utf-8?B?cUtJdXhHNnlZckRSb3BnWXVYN0pqZ2FSc1N6aHZFVVRkVC9RVG1JaU50ZHlU?=
 =?utf-8?B?cUZ5NlhaK0ppbklRSlFxNUlGQmVubE5uNHJNdk0vSGNEY3grNWozYW05ZHpX?=
 =?utf-8?B?OGZ2Ly9teHNOYmE5cDBzTEg4eTFGeU1kclJDQjdUUVBFMnl5Zm9pSHRyNGNH?=
 =?utf-8?B?eHJjclJ2V0JHM1oyV3JLSG12eS80TVZWNDVkcVZ1OFpxNkQvNlJSN2VGNCtW?=
 =?utf-8?B?bitIbFVwMGViY1oyZ29GRzBiTDkvUkQ5N3IzMkNXQTVPeVRERysybkFMcUVa?=
 =?utf-8?B?Y0kvU3piS0ZxcmNNVEpoZk1JZmpkamJmTWRHTkdaUDJhWDJiN0ZvODF4bjIv?=
 =?utf-8?B?RUs1UU45OWdwOEcyd3Yyd2NYNWl5VVd5cUtDMitUVU1BQnFYUWNDUVVRYmhw?=
 =?utf-8?B?UlQ0ZHdwLzgvV0kzUmJsMVZOUVpoVm52ZzlxZVorNDE4MmZUUTh4NzNGRW1E?=
 =?utf-8?Q?bs/CPPO8lG19KK1YSRWgm+Fkl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7548587a-80a4-434d-85bf-08dd7cbc9717
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 07:59:18.9268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZXJN1uMskfjvICfXKCqCSAl+1oENfRZNsSQVckbv4jS0+BrXXawa8X19b4Cd0hl94E6H4hoEYG8vd9ZZrl1uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8808

On 14.04.25 16:10, Haiyang He wrote:
> Ensure shell expands tilde (~) in the --outpatch parameter path the
> same way as --linux and --dovetail parameters. This fixes
> "cd: can't cd to ~" errors when using home directory shortcuts in
> output path.
> 
> The issue occurred because the ~ character in paths was not expanded
> before directory operations.
> 
> $ ./scripts/prepare-kernel.sh \
> --linux=~/xenomai/linux-dovetail \
> --arch=arm64 \
> --outpatch=~/xenomai.patch
> ./scripts/prepare-kernel.sh: 1: cd: can't cd to ~
> 
> Signed-off-by: Haiyang He <aspirestro@163.com>
> ---
>  scripts/prepare-kernel.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index ecc830fd2..e15c1fe6e 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -139,6 +139,7 @@ while test $# -gt 0; do
>  		;;
>  	--outpatch=*)
>  		output_patch=`echo $1|sed -e 's,^--outpatch=\\(.*\\)$,\\1,g'`
> +		output_patch=`eval "echo $output_patch"`
>  		;;
>  	--filterkvers=*)
>  		echo "$me: warning: --filterkvers= is deprecated and now a no-op" >&2

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
