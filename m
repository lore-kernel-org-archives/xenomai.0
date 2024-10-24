Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98821AC887
	for <xenomai@lists.linux.dev>; Thu, 24 Oct 2024 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729756799; cv=fail; b=hVVhYjzgCJGy5tdBBFWYqRwhidCcpdBYrbeHc5lm8/Kf4VC0R/Do45xAu1V9+bxVuVZO0Ze7x8nxoarPQF6FqKduIY580fNLe6RPb/Xlkx8b+DVtmHbu/OLqqmzb0zACcL9yWDakMOhd7RJcOBk+sTqeeNwX5Ptala5O9OesKvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729756799; c=relaxed/simple;
	bh=gOXuZou/074hAACnfQwZ4RjDjP9pj38ZBAcm1s0Xc+4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ai2TnGvK3iSu32lRHG/ECIKW53kD46FaEXrpR3HwbBEZB06AFSIcbuqD8MJLZiWs21VNy5Cad0Dkm4cITMD2wfc1HJGUALb/W730qcrp+uGNkwqDmQvyXAOxXkARZtDLkfDhH3pTuD79UGs/SAtv3kFNRnpeeH2yDzAlmOwuFW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=s5TE53uI; arc=fail smtp.client-ip=40.107.247.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="s5TE53uI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJcF00gJY2LqtRxOyS0EpXgXeNWfBh5m96GUAsuANI/iTfhKPTbmHsW9aZpXaAVOwylQBO8IpByaAE2Fy/eUEI94X0juCIBxwLgWO+lBBXSi7OGnOawgqkMTEVA5OE2mNq9aGnypKiaewA8usM7xETLi7/TrWvGvhrLEFyudqCXHAe93Cb0VOV7CH+3P+xyaK+IoJW8Szb9Sxj5CHjTeOd3AL/zwfG4TiqaF4Kg/tiQJXwSYqZenZy+/vsMueuCHVQFr7aDZCa2+O14KPvL+fpB13WhWuIiKZZrffoWjKs5TzXHA3zGaA3yAol6uoIp6ro8KXvpybXwgXL8c2ThrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIvEvRXjuY18yoMwYNW9hmYXFt+N3MCv9Qzt3cv0iEk=;
 b=cUkIIhZ2VnFAnQm/OsheCMZDM5p037I+JWCgl3y8FojgqpzWvGOI1qdWqmw8kgtR1Aej2g1sjKRVzKA2T1ebEuFC4Zi71tO7XASdceNNXSjaDtbqnHujBINOyep3XQzvQBtZY7mimKQ6YK2LIGnnO/UsBE3GgedC/zxfbWQRSlD/aU3eWpdJmjdUK50E2VAy0q2oC5H9D1l+pybcqZzjZMNDWAH0vWfR7zJGejCdYp5VQbfhAOSBvH0SAhCDU56jg7rFhaNEFvEi5UNpuuW+Xn8l4EvpF7AqOazlzflmH05qJL89xjQn3jnG/2A2XSZbQZAR0i0JuIsd8BOouwGNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIvEvRXjuY18yoMwYNW9hmYXFt+N3MCv9Qzt3cv0iEk=;
 b=s5TE53uImRPTrcWORW7F6mHzm3yfJJcE8KT7tfpIaSqtyvu6l7LCQoogZ+TkW8O3UwPa9rupxMOiRaaiY18hGrcPB8DlZDFgg5wrPel4YMtm2Nk3hvFu9CYTC11TGsS9+nAFAizdDgaqbb2QkiaZyStmXgtRr8kA0qQDyi47x3MPM+TzN7uddjMWDERzfrC3td+eJvuAJBSktukBYoXsnYTymhdCKxhvkTWELRld9//KdppaAbMN6cbA7r4I82m/eUhylz4+FSzPo6z/UbFidvzn9lREQfkJjBlDr5430X4BHuCllzu042xMbmAtIb+yWc3RvcLiuZbXRzSX07BfxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5938.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Thu, 24 Oct
 2024 07:59:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 07:59:52 +0000
Message-ID: <7d1df6ce-21bf-4a1c-b8cc-ff2c449c6575@siemens.com>
Date: Thu, 24 Oct 2024 09:59:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] y2038: lib/cobalt: Fix __STD() macro usage for some
 services
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20241024072656.179803-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241024072656.179803-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: cccc6426-bcd7-4dba-dd6f-08dcf401d6f9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tmo2MXg1RzBRMlpYVnZTRHlmdERXUnBJZ2xOU2FHcEN6RUJTNTQ2UXFlcjBa?=
 =?utf-8?B?dWJCcE9wU0RSTjE4Rm9MS0RtbWdTWkFtTUdjaVQrRU1SUUVDZHhJeDJZMTgr?=
 =?utf-8?B?N01JMTVuMXZia1J0ZWMzRnJyUnVma1kyS1ExZlZTT0F3RUVMSXQ4NVVaV0h2?=
 =?utf-8?B?M3lLZFZBRlpPZlA4WE1CUUlHVWZaMFYrSDNWSXhqeHg3QStZcU80VHI3bzJu?=
 =?utf-8?B?QzhhNHFiamNWNnJZeTREV0MxbFVKZFBOb0l5OWhqa0ZrZTNaUDJabk5xaWRW?=
 =?utf-8?B?QU9tV25ZTk40cXNXbFRrRzJlU1pQQk1JNmpNZXE0aHd6SldVdkk4N1o0VXhS?=
 =?utf-8?B?dWxLZUlYdncxOFBMUkVlbGRSOGhLSGx1aloyc3UybTRMRnZpSHFUUVcvdTRO?=
 =?utf-8?B?QVNrSWxIV1NUYm95ZlZrelgxZWxwbFFwQWNmTldMQVB1VFVkQTc3bFMremlh?=
 =?utf-8?B?cTEvNlBHbklqTWZLdHluekFybnVFQzV2cks5czNMYWZJZDV3T2tONVRxOUFD?=
 =?utf-8?B?RGFJNENjZ3pvb1hsSTFiZWxNNUhDTnkveXRhaGR2N3FZT2lQNTZOZEFWR0d5?=
 =?utf-8?B?SlhZcTgyZ2R1ejh5SlQ0UUdlYUt6QWxBYnM2ZmdEc1ZwYVBDL2RZVFJkZGgz?=
 =?utf-8?B?SEU4NEt6YkQrUkJBMFk1clU0RVN4T2Ivd1k0Z1EyODRCN09BV29pSU5leVha?=
 =?utf-8?B?TldCbiticU5jek5HeFFoT3BiUlAwT1dBR0hTVitVbWtEcWlEemtYNkJYRm5J?=
 =?utf-8?B?RHhKWUdYWnBITW9PRnl4UTVMV2pQUytDR1QxNFJuOExRQ0F4eWtPQjN0SnBu?=
 =?utf-8?B?VjhrSVdoRXhBb2dOQXFHTjNRakNhelFybWw5YVBTS3BMcEJ2TndZTXNDbDRm?=
 =?utf-8?B?MWRBcHpQRDVQc1BDSEk5YkpxQVhVdlpFbjlYWWVKdk5vR2pUallrMXEvZUk3?=
 =?utf-8?B?Q1Q4WDZMalJ4S0duVkxxbisxQndUbS9QNWE2OGlkNzRYaWhLaTRmanFHalc2?=
 =?utf-8?B?OFAvRGJZWk83VCtZM3dBM1p4MW1icmgxMzNKZE10YjY4dkl6UFJwNElMRHN0?=
 =?utf-8?B?a2VzUzNuQ09CZ0JSN3NVeVptUVdLckVnTnAwTnYwa3Rhck9JSWpRYlpYWGVx?=
 =?utf-8?B?eE12eDR0VkV6UjZCeS8ySVo2SHNWanRZV0N6cDNWaHhmQkF0MUl0ajJ1REkz?=
 =?utf-8?B?eEtHRWQ3OE4xeGswUG4wbUJaVUhqUEJXcFpGVU5pTHVaS0VpMFJMcllxOFR2?=
 =?utf-8?B?dFBjVEZlWHVZNkFsRGRRK2ZMbjRUcHpCQURBWTV5QlM1Q1BWZ0g0VHhHRThO?=
 =?utf-8?B?OGU1ZkdZeU94cy9WaGorTStMTFdRRDhqNzJiNzZNbjgzR2J5Q1hyc0J1NExj?=
 =?utf-8?B?Tk1wVG5pTUNocFVVYjdXc28xYUNtbC9rYm1tLzRlN08xbHV6MW8xQ09yUmlj?=
 =?utf-8?B?RDNkUjN0VW5lKzJBQWNnRG00RXJFaElIUTA3cmRUckJ6K0tZak14WTMrd0o3?=
 =?utf-8?B?M2oxTDJvMVhMMlVRdWlVNThuZm43eEdCdE5MNmtaVzVkUE13TnZYTmdEM0ZY?=
 =?utf-8?B?QStiL1ZpMTNUYjN4bGM0THdxMVN5cGhGaTJkWmlzVFkwemFZMXpTSnlmSWJw?=
 =?utf-8?B?WTBqQnBKb1p1OWxwZUs0b2svYkVpTE50QmRtaGo5dU9ZMjZQejhONjgxdWMy?=
 =?utf-8?B?VCs1ZDhHRjlmUmVRdENmT1ZOMFo2U2E2WFBnYkZZajkvSFV2Vi9mV0dvU2tZ?=
 =?utf-8?Q?7cKAOvl8PwsVlxkoAUOGgEejNssRurjkrJ6AuyS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWFvdm5FNUI1THM2REdrbnNBa3RmQkFNd2V6YmFYM05ITTYzZWM0N3hDOUFJ?=
 =?utf-8?B?eGdkZzVsNHRxak9ETGlGanFoSU5TTFB1Y2xGMm9KWXp0YzVCTjMzV2ZhU3ZU?=
 =?utf-8?B?ZzlqcGh1MkkrTFBpQ3dRNlJFV2ppVUloNFpSOTFjS3ArbU9oam5sam02S0ky?=
 =?utf-8?B?dzVqL0xhOXowM2xTR3ljbFlWelJld0tBN3lIQVlVTlQ4ZlhuUCt5TTluU0pr?=
 =?utf-8?B?TWN5SE14UFNBcEltcEdMWmdYa0dMOWliQUl4K3AyMWpqa3BXTkcyWTdlMk1o?=
 =?utf-8?B?T0FudzF0OEJZQWtiUmpQdnN3NlZXNS9JWDFadzdoaGRFVnVSUHl5MHVZY2ZX?=
 =?utf-8?B?bWoyaEtjMHU5WHpLNEcrS0pBbXBsOHVFanZFY0dhNUlPV1pXZXJHNm1jVm9F?=
 =?utf-8?B?TkN5V291R1pTanRDUnJjdlRSQzY3MWVhMTdNRzVpcHQwS05aVlhOdEhXeXZp?=
 =?utf-8?B?NzI3NGZHaVhoeG0zVWhBTStublcvNXROWnRpTTB1eTBhcXEzeVB5VkpLK0ZY?=
 =?utf-8?B?eU8zNk5Bb21Ga1h6RXJvOVdSZEpuVVVMaldkODEzMEJoUTZqbTYzUUp4Mkgy?=
 =?utf-8?B?YTBBWDU3d1pxWDRCd0x4b2hZLzRtUExLdi8wNWpOWCtTb3BOOXNaMlRId2VX?=
 =?utf-8?B?ZUU5TnptdFV0Y1REejgwTkRiZlp4dW1ndlI5bkdFOFRDclpHanVEMnFRd01m?=
 =?utf-8?B?K2doNjVrZG5IaXJsWDNwQUdXYlFnYlMrNkhMMjF1UG5BWi9GN0tJSDJ3YWw0?=
 =?utf-8?B?MU42LzNRWGJBQlJ6MERFUXFTTkRjSzMvTlBCcC9ZLzFKMXc3L0RXZytuV0t2?=
 =?utf-8?B?bkczZjBxNHB5cFZoZzhsd3JBMmNBYmhja1Q2QTNid25NK3JlaTZXUVA0SDhY?=
 =?utf-8?B?OXdDTGpqUWkwMHdtV3ZCSUJqbnV4YTRjNmU4bm02TDdHbDAwQko3VW5YUzR5?=
 =?utf-8?B?SFdDRTFGeENiOGorMUFhM0ZPM1AzczFaL2dldTRHNzU2L3BabSt2amxMNTRu?=
 =?utf-8?B?RmNOVWtFQlFMWTROU0F3am8rdXBuQVF5SnppamJNZDhhMzV6MmpOZ0tVWEVu?=
 =?utf-8?B?RnVkcWgyRWFVVU1wWHJodjRKTkJYVlpBdU5IcDlQU29xdlU0czhNZjQzenIr?=
 =?utf-8?B?NzdjZEV5dFc2ajFVLzBKRnJ1SEh3Y1l6TEZTV1R2cktTZU1Ra2NKVWlQS1Bq?=
 =?utf-8?B?ZXZlWHcvMWVNUDVSWXFTSFBPOG9oc0NGSmNsVGpHL2x4NmhIcU5yazJNc2VE?=
 =?utf-8?B?aXZrRjB5dTVVVVM2V0xCbzdUV2pSYXppbXAwMWZJeFVjcWYvR2tGQzlvck1W?=
 =?utf-8?B?OFcrVWdxbWc3UldYZFM0UlMvbytoeGE3UkdraHBZSzM1TG1Fd1FJeitHT2pm?=
 =?utf-8?B?V3ZTR2hPZVhMbjZZbm51ZmZaSEREY2dIQkVSWmtYdGVKeW1mVnFiSXYzYkUw?=
 =?utf-8?B?R0FJc1hSNkdGWkt2aC9hT1gwNjYrVncxT0k5RXh0eWtyeGlmZEFxWVdMOGpF?=
 =?utf-8?B?cWgxdXdUcURXRC90akV1ckRIWDEraUhibU5yZXp0VDVHbWEycU1MWngxQWw0?=
 =?utf-8?B?ZVBjdlJTcE96QXgyMWI1OWx6WGQxOE0yamR4SUtIeG4zaEZjRzYwa0dZV0Zx?=
 =?utf-8?B?MGFwNCsrdXY1dkk2S21MUS8wY1BLaGRzWjdxTEdkaC9aNnNhNDJ0MHIrWFJ3?=
 =?utf-8?B?T3paYndwVm1ZQ2R0SkdJN3RLZjg0UkxiczhaOE1jQzJCb21GUWZURzdsRTRJ?=
 =?utf-8?B?NERPeEdNczhBeGdDYnJhUFNNRXU1cWJhdFpCUmJJOTJ1OXJiNnR5QjNFZkRN?=
 =?utf-8?B?V2RxYUpQWk44QVI2aWRmK3VMM1BVZUlhb0FRdHBza2JlUkFVYlhrZ3BPWGs4?=
 =?utf-8?B?ZlBaaUFyUGtMMHFic3QzbjB1d00rQjJ2RjQwQlpFemNuTWc1S3gzbUhzSmpI?=
 =?utf-8?B?aU9WM2wrS2VmczlZd3hycmozZDhWZ0pPUmtzKzMvZ0t1N1IrN080ZENzU05G?=
 =?utf-8?B?K0NaTGE2WW9GcjVSV004NTB0bnZTeEF4Nm5VUmhPRndXNDZxc3Y1UUlMOWtn?=
 =?utf-8?B?QjBxb0hoYlAyeGEzMVZ1YUR2TjBiK1l1UUh5dWd3RXVLRnFUb0ZBZXJJc3FD?=
 =?utf-8?Q?0zdW4NhkvCvQvEDPchZqvv6UJ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccc6426-bcd7-4dba-dd6f-08dcf401d6f9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:59:51.9866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7k87RSByiRTObciBLOgSQ0lNCcfg4Uwxf6PbQSwjriyPoA8ga/y9c+OifLKBiZl/yrwBHDupvOBh1XK2Ey5KlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5938

On 24.10.24 09:26, Florian Bezdeka wrote:
> The macro usage was broken for the following services:
>   - recvmmsg
>   - mq_timedsend
>   - mq_timedreceive
> 
> The message queue services were forwarded to wrong libc functions,
> the recvmmsg was missing the correct routing.
> 
> Detected while trying to remove the function wrapping at all.
> 

Can you elaborate a bit on the visible impact for users? And it affects
3.3 only?

Jan

> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/mqueue.h     | 4 ++--
>  include/cobalt/sys/socket.h | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/cobalt/mqueue.h b/include/cobalt/mqueue.h
> index 89d4bff79..9fd502c04 100644
> --- a/include/cobalt/mqueue.h
> +++ b/include/cobalt/mqueue.h
> @@ -42,14 +42,14 @@ COBALT_DECL(int, mq_setattr,
>  COBALT_DECL(int, mq_send,
>  	    (mqd_t qd, const char *buffer, size_t len, unsigned prio));
>  
> -COBALT_DECL_TIME64(int, mq_timedsend, __mq_timedsend64,
> +COBALT_DECL_TIME64(int, mq_timedsend, __mq_timedsend_time64,
>  		   (mqd_t q, const char *buffer, size_t len, unsigned prio,
>  		    const struct timespec *timeout));
>  
>  COBALT_DECL(ssize_t, mq_receive,
>  	    (mqd_t q, char *buffer, size_t len, unsigned *prio));
>  
> -COBALT_DECL_TIME64(ssize_t, mq_timedreceive, __mq_timedsend_time64,
> +COBALT_DECL_TIME64(ssize_t, mq_timedreceive, __mq_timedreceive_time64,
>  	    (mqd_t q, char *__restrict__ buffer, size_t len,
>  	     unsigned *__restrict__ prio,
>  	     const struct timespec *__restrict__ timeout));
> diff --git a/include/cobalt/sys/socket.h b/include/cobalt/sys/socket.h
> index d5e81e5bd..9095594c6 100644
> --- a/include/cobalt/sys/socket.h
> +++ b/include/cobalt/sys/socket.h
> @@ -31,9 +31,9 @@ COBALT_DECL(int, socket, (int protocol_family, int socket_type, int protocol));
>  
>  COBALT_DECL(ssize_t, recvmsg, (int fd, struct msghdr *msg, int flags));
>  
> -COBALT_DECL(int, recvmmsg,
> -	    (int fd, struct mmsghdr *msgvec, unsigned int vlen,
> -	     unsigned int flags, struct timespec *timeout));
> +COBALT_DECL_TIME64(int, recvmmsg, __recvmmsg64,
> +		   (int fd, struct mmsghdr *msgvec, unsigned int vlen,
> +		    unsigned int flags, struct timespec *timeout));
>  
>  COBALT_DECL(ssize_t, sendmsg, (int fd, const struct msghdr *msg, int flags));
>  

-- 
Siemens AG, Technology
Linux Expert Center
