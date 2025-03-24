Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A525E461
	for <xenomai@lists.linux.dev>; Mon, 24 Mar 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742836694; cv=fail; b=uKhF5pG8QyenjGtmgPTrS/9komaOOEylvHrj1256l//0+Yg+Zr/06nliG4YHXf40EqIlhf1DqcKVAKIja4IHlfBXie1NENBgAAFxAhf0vnPfPzNAVuCFEolvhetqAoqeeQlBWZ7Vbvo+iJqGKKeTLs1Y8NUtLUyYOZq/USeUlqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742836694; c=relaxed/simple;
	bh=aDTu1kqMkv0w9jpOQNMSNjw74qGiRHdZ+isguoblUYs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hfMjj0FETCXgqlq4n9LNj/QAd1AQJcQeolOEi9Jp1ll5uFspEBPZXkJnkR66c8z5/veV0SsScDA3O83UcZl82SYXtIgHieoYgBnhTAzJ0YZLfkG0w48+eon28fZorMdm6rk5ePMwV2w6muBf/GgBFQNxSkj/lyQ7VVfHKjXLFd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BZD/fkn7; arc=fail smtp.client-ip=40.107.247.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BZD/fkn7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOn1Xnp22SqLUYLjnTIgKSwP67T5FFc5Qo7s9z+mYkn4+LfjblriGhSqs8nf6rSho0DXihDKao2QIXHbBWMOXKE9u9ZKh9Hr8Die8jKXLjdmVg+Pl5xryoufs2PoIHMtV+rltTSXkHw4eyf88mSFYRYBx4t6h5tDFOdCWmueAK1DMBOYy6cFjv8CV9tU48H+zRwgzRzEwLzRL7LpO/eNARvU1Nh8H8NfAVz4t5PTXeF+9HxuKsmSvK3taCypne1uSJ/9UUYHR5IHYsv5Gcwux9sTB14vQV/d/VCA3nQymeabCRKZC4hQ1JB54uPXn7EGn6LIo0SJlpqQ6gIJ13PLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd4xNuttiM9LaK33HDbKhDX3d6aP0fyrkulaZlgfHvc=;
 b=r0ZGkB8WIYgbdeVRdWgoUfIg2YXOnUw1JewTnr1WaSQMgNsfmbXfEJc+BZxBhesNx26OK5nbsN+4G7c0h0gXQ9Sno0Q5UpFAL05Er7amhymhD0cPehCFlYMmSV/U8jvr6hT/HKNod4pMZ4QxoPbv21RNiMD+QQacMFAkFdoGmjbO4JDh1rODxk72c2TtLtO5S7MHFx3OoFnJRzSLMnxRcm9FVjSpyP5yKpxUt5d4sYMcTgs+/bIRjpC61hsQe0NeVPzie5dhtNJG0ETMNHw5wAbQuKdUwMMA9mrNW28A6JsVm3zu8jU7RuKy2Bg1XWlhE8ZR6HeF64OLiW+jNhm9yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd4xNuttiM9LaK33HDbKhDX3d6aP0fyrkulaZlgfHvc=;
 b=BZD/fkn71V3BtdMO2QrIdajPDUjRR57ZWkmbFdgt41a03YIGrYYImXKbyIjFwJjfOkY/vEmbY4JuIzyBGP7B0BiFky47m95/Ia2cot9rwWl9URJl0SJBrgX9zIBFUU4EJa/LlVLZiXZlRStWgwmi8hGwKZeqN/aj430VfDOrpQReh/JFqrkzaQ/On1Q53waroSHzDl62Mh0BOucX9DaOMtg8AoQY5cVJg2LZq3T2cryojl0ok6xQf2EQeuwrLSgHKGfQY5rI8TpT9KjXhUPu20JBP/T+FQnZGflQDSRAT2PlRPhqMMorkhvn09Pa1mTBSo0NgRS6OcpQiQkx2PZFVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7197.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 17:18:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 17:18:06 +0000
Message-ID: <ef5be8f9-ca0e-4ea3-aa09-ad883884426f@siemens.com>
Date: Mon, 24 Mar 2025 18:18:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dovetail: Fix interrupt re-enabling after hibernation
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <68cf84b9-57bc-4a6c-9546-101a13c7acc4@siemens.com>
 <87r02qlt34.fsf@xenomai.org>
 <1b298aee5042ea0948591be9e5922f204fcc22b6.camel@siemens.com>
 <87ldsyldbl.fsf@xenomai.org> <87frj6ld53.fsf@xenomai.org>
 <87a59elcex.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87a59elcex.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: e34d226f-2323-49a2-0013-08dd6af7d77e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnNBNWhodE0yWUQ0UHpWam8wLzRhUndPcW04MzZ0SkE2VStqNm94bDl0N2JS?=
 =?utf-8?B?MU9FNzB4dkZUZDMrRW1SRThhYzc1dkxQR3BjZ2dNVHN3cUNuZC8rLzRDSHdE?=
 =?utf-8?B?amZHb2tzekdTbE8weW1zTzA0RGJFTElWTkNzTUlSRUlsaHVkVUJ4dEYyYzFV?=
 =?utf-8?B?UG5ydi9xZ29JK3o3cXZPZTczd3g3RU5KbDNuaUFnTnV1WUR2TTdwODFUeEY0?=
 =?utf-8?B?TUlDSHVBcnVJdXJYUklxZXZ0d0U0TGNsWHRUYzVYRGZ6VitDcEt2RTlMbWwx?=
 =?utf-8?B?S0diRWdIbzMyZWx0QlQ0Wnp4K2xDWmxWZ1F2SWk0KzFBaEZRQUNvL1A3MGk0?=
 =?utf-8?B?bVBUUnZLY05uRXhxeWJ3eXgyM29IbGttOHhEblBnRDByYXEwU2lITFZrUjd3?=
 =?utf-8?B?WHhTWWE3aVlFT05jajRIa1lMYXFPTlFGK2czSU92ajNuODdnUCsrdVZnVXdh?=
 =?utf-8?B?eEdwbEdGRTVHQ3h6RnllVy9DN0ZuY0M4Mnd6b21PTlNHaGdSOXNZRXBnU1B3?=
 =?utf-8?B?dk94UUhrWm5DWXJQMEJwdGZxVEVlcUsvOXR1QktkMEo3ai9vczRxekQzOXlS?=
 =?utf-8?B?QlNNbWVjcEd6bVp5U3VtS1FuRVFtWHA0bmtaK01TbDczOTB1ZUFJV0dZTVRC?=
 =?utf-8?B?TDJwMklBYUdqQVo2NmhyTlhQSzdjbi9qaVFwMzBFU0tnSjkzMk5PbGFvcmZI?=
 =?utf-8?B?V2tibFpKcTc0QjVmTlJsblJiRHlzM3d1SzcyVUNzc01uWUlZcHVDZ3JKZmRk?=
 =?utf-8?B?T0pacFlhN1NzbXNaWGFxOXI1RStiL0txdGdVeHN1YXMxcnFIYmI0RDBmNmZi?=
 =?utf-8?B?TXVvZkhjd3ZlY2pqNnBHcWZRaXNDS21Idm1ubWhZdEpMWE16ZHBCZVFDempD?=
 =?utf-8?B?ditXc25VWGZtcXRVd0FnL1ZPNENRM1B1MW5lc0EwK21INFF4cldUYUxiajI4?=
 =?utf-8?B?TzRPaXMrMU9DSTF4OGppbno5K0EwT001cjhxb21EMGVYNG16MnpMbFJCNUE5?=
 =?utf-8?B?YTVFbDU4c2FOWGQwaXBHeDZvQThOb2F6QklXVmlJWVJJMkJzK3VqMWJzRTBv?=
 =?utf-8?B?anQ3UkhGUmtHZXI4TjduQldFb290dHdwNHdRQ1NyZnZxa21wbzZOdXJvbUtt?=
 =?utf-8?B?QWFyVHR3N3grN0FJVElxUXdoZnFGZTRldHc1YW5MVlhybGxqcXcxclkydmZ4?=
 =?utf-8?B?VkpPT2J4S3lIUms0RytPRklUQ2w4bWRpeEM4MHdvQ1JKK1hCRVdiYlEvODNY?=
 =?utf-8?B?UUh4OTFuTFhLVzdzNWVxNVI2bmlIVmF1V1kxTml5NDNHSXg2MDJ0ajRqWkxI?=
 =?utf-8?B?ZmhMRjJwbXQyVVlaQzVMNkRWMUNUd0ZjWmVPamYyYWNFQXNoV1JlSi8yTVRI?=
 =?utf-8?B?ekVseC8rZXhzVTk0M3phL0VOUHZyMjl6Q0xqOGIrUWJVZ3hZcENRNUtweXhS?=
 =?utf-8?B?SW9YTUNod0FtdzlDQmg4Mjk2UjgreGwwcExlcW5mMEovcmFTOEU0NWhFZVZC?=
 =?utf-8?B?Q1NZUnJ0ZFJDdDJ3K1lFR2VzdGo2ZExLaXd6NTlXcUtzSHR3VjVxbnBBL2Fm?=
 =?utf-8?B?NnAzN1FuOTkzeStHTjJZcHdubDQzY3kwRnZMdStTblZsSDlzbDhvL2J6ODg2?=
 =?utf-8?B?UjAva1FPeUZQL0hvRmFsSVhpVjBtM25nS1UrdXo1bGJlZGlhREpkVnFKTmxH?=
 =?utf-8?B?VVFjOXNiMC9KSmV5WDQydUlhMk1jSUp2NXcrL1dNUVJGaGY1TmlGVVFTYXNV?=
 =?utf-8?B?YzNaSm5DaGdoSDF5dXlKR3hYeU5qOS9YQUtadmlUYWdpVy9ESjB4Y0hPY1Vi?=
 =?utf-8?B?QTRMQnJ5R09zd09OSXdwd3FZTmR6TjRTbE1SRzJFbHlRV0JubjRZZUNwQW1P?=
 =?utf-8?Q?nizNs5bI2hqqN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VndIcndBcFNsS2hYZjVENU1UbUhVTCsxdUFUUU53R0ZPNkkxdWVhQm9McGUx?=
 =?utf-8?B?Z2pjMVF6ckQ3Tzk5bmZzTFJINXVvZTlxZFJvZEpYWDhZeGpUUVBhOHY4dThw?=
 =?utf-8?B?MUp2Zmw5Q0owZ29ZNnVzWk5wQlkxQWFEZlZYeTZ4OHJ0Q2t4YzhZN1R6d3Rj?=
 =?utf-8?B?MHdrTHJreHgzUnl1SDByNXNnNy9RVEd0VDA1c1hpMVo5WkY5cGQvVUVUWThk?=
 =?utf-8?B?TS9DemN6YTFVM1VyTDJQMGwvSllvZEYvK091WStRekVqbTlCRDhBaFpNVllx?=
 =?utf-8?B?ckdrMk5lUXZZZFArWnFTOUo5RUhMdlBGeDA0bGZHbTBZVjBvWUp1TFloeDUz?=
 =?utf-8?B?VmRpa1E0ajN2cnhwYnhmOUFWekdBdXVtZVlENzZyNTM4a28wQktUb3ZScVRY?=
 =?utf-8?B?U3FPcjFkaGw5NVhBQi91TERwKzE4MWkwTXZLODNGWHRuRGtCOElkQUtjSlJs?=
 =?utf-8?B?NUwyYVllRG1WWWEzVHY4UFc3TmFjV0JNTDFOMGRyYzlkY0Y4dDRLL2FPSkNV?=
 =?utf-8?B?blRRclJxbWV1cHJFcjlXV3o3dUVZQ1lZUWpSbFl4cHRlK1hsWStQUG9vSDZ3?=
 =?utf-8?B?b3ExSmQ0ZEpKaE9GUElRdEhWbUZsNjU0L3N2S3JsZXMvTllwdGFQZXMxNGZU?=
 =?utf-8?B?emQ0N2ZkdjBjanhZZXJCcW5rSXBqRSs0OUZrQnJLV1JBZEd4UzdPa3Z1c3cv?=
 =?utf-8?B?V0dKYk5kVk4xM01LTWUvakREQTFIWUhOUzBiVkJ2czUvU0JKK3J0ZmV3VUJ2?=
 =?utf-8?B?TkE5VXZTR1VaSjBjVk0vWnpXQ3YvY2NJNC96YXpLMFdoVEt6N21CUHpQbTky?=
 =?utf-8?B?bS9YTUZNWnk1VTRmcGxaWWdtbUFmZE5pT2JMcDFmNDZ5NnVUdmp5WnJrZFZ0?=
 =?utf-8?B?Z2JJa0M0VnpCYVFMdnBiQmtpQVZmR0ZCU0FQVTNULzl4WGliS01CNERTNjNL?=
 =?utf-8?B?ZFUxdFpnOUluZys4VVBab2VLQlNPQzRNTWNERGttWkd0elZDYUFFVERSaXNy?=
 =?utf-8?B?S25qRmNnQnQ2bXpMTVJxeDRac3NFUEZxbHJhazRkelhWNWVSUXY3NE5kOUNM?=
 =?utf-8?B?YmFDbm14WXl2OFdTbENxeHZ0NTA3TE95eXJCR3FrVHdnNVczN0IxTThsa3J6?=
 =?utf-8?B?RVMwOWw3WmE4MG1OT0tVbG92MWg3cEJrNnRSd0V5RWlXODgwYUNsZUJNYjha?=
 =?utf-8?B?MVE4S3dlYzI0V1NmU1hYRHRKeHdsVldYRnJuNDEraENxNFV4Mk1USkNOajdG?=
 =?utf-8?B?N0ErR2krazRVYmV0b1N2ZUtSOVpPUzZMc3N4SDIwYVZWSitJMXBEZWZiRWVZ?=
 =?utf-8?B?Y0QrOGVqSWZoU1hjY0VhTFF1Rkh2VTlkOFk1RjNhYU9MQ3JkNDFRRWQ0VHF6?=
 =?utf-8?B?QTZVM1N6MGwzVGJxR2xnem9XZDBrWXVWOXFYeDMxVXlMMWl1bzkrM1lUL0ZG?=
 =?utf-8?B?TWdQanVFSkNOajB6ZDViU3A3bkF5K2plSUVMS0Jvek9XVmc5VTFlTzJqQkZH?=
 =?utf-8?B?ZndZbjRHdWNWZEx3Qld6bHdVNzJEdFRkZFBMS2RoaE5wTU5pUU1qTE5QYXNC?=
 =?utf-8?B?aTRaNWIzUG5DRXltb20xY0s3SWlnQmh4dlAxMVhQWGg5VHFpd3ErRHJnMUM3?=
 =?utf-8?B?dDhReEYxT2ZhUm5jOXBLYS9VV3pLNWZSN3h0OTl2eWF0emo1dHltdVJVTTg2?=
 =?utf-8?B?RlFtL2paYVZHNXpubjBpbENsTXR2dm9NMXpnMkVqbnlRNUtuK0s3aFVna3dp?=
 =?utf-8?B?ZFlMU2VOZzNsWXRIR01TNG9pTkExR25VblRnbXlzcVF3MzRsZU1RRHlUY21v?=
 =?utf-8?B?Mzlrak5kdnFGeURCbWNGWXZ3U1g1Q0VIMmRWckl2c1V4OGIzVG9QbmlOem41?=
 =?utf-8?B?bSt3NGhZdkp3MFdZdEc0bXE1R2ZOZ1Bnb28rSFR0QU1SUSswTUJpUUswSC9a?=
 =?utf-8?B?UEE0WXAralVyeURkanJIY0xxMEhTMjdQTUptdTFxcFc5WWRQUnJrVE5EVC9H?=
 =?utf-8?B?aFU1TlRtSDRpRG5uMllvNUpLVThhcWFTSlZSOXQvdXEzODdqSEZFZmVZaVRa?=
 =?utf-8?B?NlU2Q1llc2UxcENvalZ0ejhmQkdKQ0ZCR1VSU245aHlKcWhVTVh0di9aZ284?=
 =?utf-8?B?YzJDdXd3ZlNhVjB1TVZzc09rRUcwZjh2Y01LSW83ZkpIRDZnTnNHY1JUWnh0?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34d226f-2323-49a2-0013-08dd6af7d77e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 17:18:06.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwjgEcDIFG0iSkWXbrSmKBJE/QZrjkgO/pz3F74p85ZvQ7Sni8nLVBg6rVPDW7LkZt4u32xOp2EnaPuunwR/0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7197

On 21.03.25 14:51, Philippe Gerum wrote:
> Philippe Gerum <rpm@xenomai.org> writes:
> 
>> Philippe Gerum <rpm@xenomai.org> writes:
>>
>>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>>
>>>> On Fri, 2025-03-21 at 08:51 +0100, Philippe Gerum wrote:
>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> We had unbalanced hard_cond_local_irq_disable here so far.
>>>>>>
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> ---
>>>>>>
>>>>>> Minus one hunk that is already in current 6.12.y, this needs to be 
>>>>>> applied to older stable versions as well.
>>>>>>
>>>>>>  kernel/power/hibernate.c | 3 +++
>>>>>>  1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>>>>>> index 733b1a196f09e..e1c05f276a453 100644
>>>>>> --- a/kernel/power/hibernate.c
>>>>>> +++ b/kernel/power/hibernate.c
>>>>>> @@ -352,6 +352,7 @@ static int create_image(int platform_mode)
>>>>>>  	syscore_resume();
>>>>>>  
>>>>>>   Enable_irqs:
>>>>>> +	hard_cond_local_irq_enable();
>>>>>>  	system_state = SYSTEM_RUNNING;
>>>>>>  	local_irq_enable();
>>>>>>  
>>>>>> @@ -522,6 +523,7 @@ static int resume_target_kernel(bool platform_mode)
>>>>>>  	syscore_resume();
>>>>>>  
>>>>>>   Enable_irqs:
>>>>>> +	hard_cond_local_irq_enable();
>>>>>>  	system_state = SYSTEM_RUNNING;
>>>>>>  	local_irq_enable();
>>>>>>  
>>>>>> @@ -628,6 +630,7 @@ int hibernation_platform_enter(void)
>>>>>>   Power_up:
>>>>>>  	syscore_resume();
>>>>>>   Enable_irqs:
>>>>>> +	hard_cond_local_irq_enable();
>>>>>>  	system_state = SYSTEM_RUNNING;
>>>>>>  	local_irq_enable();
>>>>>
>>>>> Merged into v6.12 and backported to v6.1.y-cip, thanks.
>>>>
>>>> Sorry, but I have to highlight that this patch does not help at all.
>>>> Testing shows that we already "hang" when trying to hibernate. We never
>>>> make it into the "wakeup" path.
>>>>
>>>> I think the "process" we followed here is broken. First we have to
>>>> implement and *TEST* things in latest development branches and once we
>>>> are sure we fully addressed the problem back porting can happen.
>>>
>>> The point is that this has never been a new and/or untested feature, we
>>> may be seeing a regression on all versions of a feature that did work
>>> for ages, the story does not start with v6.14. Now, the tricky issue
>>> with hibernation is not necessarily in the code paths above, but most
>>> likely in one of the many suspend/resume handlers, which are per-driver
>>> beasts. First of all, we need to define a test configuration with
>>> suspend/resume code which is known to work.
>>
>> Known to work when irq pipelining is enabled, I mean.
> 
> Food for thought: since the weak point of hibernation is definitely in
> those suspend/resume handlers, a way to make any suspend-to-* sequence
> stable without incurring a truckload of changes sprinkled all over the
> map in those handlers, would be to temporarily switch the implementation
> of the inband stall/unstall helpers to hard irq disabling/enabling
> _while_ a suspend/resume sequence is ongoing. A bit like Dovetail's
> so-called 'hybrid' spinlocks (hybrid_spinlock_t) are working for
> irq_desc->lock.
> 
> i.e. use static branching in __inband_irq_enable(), inband_irq_save()
> and alike in order to pair virtual masking using the stall bit with
> hardware-level masking in the CPU.
> 
> With that scheme in place, interrupt bit virtualization would be
> actually disabled while traversing the sensitive paths during
> suspend/resume.
> 

At least in qemu/kvm, hibernation works in the way that linux suspends,
quickly resumes again (might be a virtual firmware issue), and the core
is still working afterwards. But I found some bug in a WARN_ON_ONCE,
patch will follow.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
