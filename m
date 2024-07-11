Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2084.outbound.protection.outlook.com [40.107.247.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA815F40D
	for <xenomai@lists.linux.dev>; Thu, 11 Jul 2024 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714467; cv=fail; b=YEiPXsg5GtprS83wWKWzFY5APjaLimOqE9UTdR0ctkqX80ibnQWcuA6ihoZZerW3sDWJNi5/4Ngu/wOkfN7L+EbUW1oylW95S4pwlyf109AYM0JMn6WFOcZSgykX406EzIIlqET1nWcFqxMoejj7vPlglSFI2vv7LUBbc3kOJdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714467; c=relaxed/simple;
	bh=TkDrcg6gEGMmVjLfWwxKBOmSOLFUYHl4vY7xJ1A43FA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WleeGWESGObsHNCGeFkfZyDkSjxjw+ZFDdCDsj0VFWUtWNO3hNISWvYcROAtE+3kfEBocI5IH96AGBMbwp4abvsuFwIE1FWIphY57TiBvjkyXitLq0JOkiil+ctMFC417qON6CRVxDig2ebWQeh78hmiRh08px0ip7AsD50fZS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uqTKevUM; arc=fail smtp.client-ip=40.107.247.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uqTKevUM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRzs2c2QZuHFov0gMWHRhuIQ9ynQSU8J561Osak9acDlAbdEmxKVw8TOf3Rw8m57I23cs2jz8u0rsJptz7ZcTh/751+yAtOM8Q3kgDdjvD04vBFYnXdLWSJtuegYFnp1Qe1gxaPNO0QusxRszmh6JFUZiX9FlC1Dy4qog9rRHexUs9Fwl1rK/DIu9As5A6CU9Ce4JTrbEiECnN3XVyhv5S7t/9Tiq2Yus8OE4CxJ55uL9DBaepVnW+AeCliCKkfVtYAeMm4xAvTzrTP/RPQ+QbUPEde7f9t4S73XCHd62XGzobpl+LUDfvHZ6HkoQiuwUmDoalFnZt5Tu5SDTk0nOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQRbszAxB0bhcPEUd49EXsEJCctjgDCmEfuv5Hz9wek=;
 b=xuQqJmkXbyzOmQ/nShRzYUSVUrplpHCQJ2UG/4kR6lAI73fUdDOz4EcpuEL7XDUSv3D6uL2/2PHMouIWvY2VIa1c3DXHDJQsSxA2yDs2ynGSZdFBV/z9bGqRNF/oYKEnJMVijuDxX2g3P6XPvLd+SCqIshA2RVGTJyUNR2I7LccRwA3w0VPlB7uFG9nDqvHS2/g1+0ruFJXy1CfaGRkS+AsCgK9WSMA04AuRVYwnsOvbwuplI0wafXREWRgr35ZiO9eBOSpVclg6P0px2FzfYk5C/SzKvS/uAfmZ/xuf1GAnUchKt7XxdD6b78gQPqtXDaTJYSiDUO4zN6zFJz9QKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQRbszAxB0bhcPEUd49EXsEJCctjgDCmEfuv5Hz9wek=;
 b=uqTKevUM2tLYmlJU6kIBowiorW8p0iApzJ0Pg46+wF4/wLzA8fz24qHji1sfW/hcO/2iBpZp+Y9p802a0eKppUUluMjmKbDO7mHhpPnAqqA0gshEmzNOcow2od8J3fKhbHywrX1Loia+d2xkM/AyUiyISyKzQHMsTEVaTsBiI6KvAcIH/rM1qIrGeLqv31Y6lCJZqHCVl40xo+fsLlLODaHe7TsSHXMv2Rak/UjO7LzpfzbqYLtooKjxEDpJEEENlL75KA0/7qf8drk3nQ5SzZ+vQjO1SkNBbEajLmkiwLDHzTFNqNllGSEVABHbYT/yQWOGFCXIiw7IZV2C+RM0Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:185::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 16:14:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 16:14:19 +0000
Message-ID: <e04882ea-4d3f-431d-9e7a-6c48dc4c82b6@siemens.com>
Date: Thu, 11 Jul 2024 18:14:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/33] drivers/stack/ipv4: Migrate from rtdm_printk() and
 printk() to pr_*()
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
 <20240702-flo-removal-of-rtdm_printk-v1-27-cc91bffdd063@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-27-cc91bffdd063@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0024.namprd14.prod.outlook.com
 (2603:10b6:610:60::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3329:EE_
X-MS-Office365-Filtering-Correlation-Id: c95f159e-c030-4432-ea1f-08dca1c48501
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUdkaG1FTkhZeWZyRW93NVRIb1Qvd2d6TWg3M0loTXplRW44OWVCREdYYk13?=
 =?utf-8?B?KzBEYUl1S1hBRW41ZjdPS1hJa05Xd1NZblVkWmRRZ0VFcE80bGtaakFtcEpW?=
 =?utf-8?B?b2FYdVdRV1RPNkpLYVYzWkpFdGdxUVlidllJTDFVeTlLbXlrMHM3QUE5ZWFm?=
 =?utf-8?B?MmliaFNlc0p2a3FxczlqOW9oczZmd0JHRUI2aGwrcitoWDNwVWhQcU1IT3Vo?=
 =?utf-8?B?K0lWeGFZdXZEUmovK1VGZ1FVUTBOQTBROVJrWDBvYUdLWEVuUXNBdkMvTUR4?=
 =?utf-8?B?SHpsS2JxU01UUVcrd0w2OTdJcGJYUzAzTENIa2Z5MklaR0ZVK3ZocGRpejZ0?=
 =?utf-8?B?OUxpYlQydC9iOGl4cVg3cnlwRkJ5MHJWeWxBeXZseE1ZM2E4NmpWRUREcno5?=
 =?utf-8?B?bkZ2WGFYRXJhVHEreFBVaDlGR3NIcCtGbUExT0M3Z25uajFwZjVZaEFDNGpV?=
 =?utf-8?B?NzdYbzhNeiswNDBoRDBxZGhsbzM3ME81R3pkWXFhWXk0dzNXRmEyRWZWK2NF?=
 =?utf-8?B?aGZSS2FZTDd6Z1MxSlhIbExJZ1VIQnA5QnR6S2dsK0FpdzNPYTRwYlZxR3Ay?=
 =?utf-8?B?bnFTZURNV3dBR3UyQlJWdVhBWXY2Q0ZHNC9FM0NtYWNaSFVWUFJ2UlhCQnhR?=
 =?utf-8?B?c2doeEZMTEFWOE1QTkxlT1BjMlVaTDhueHFZb3NEL21rY2FnbGh0RDVoUzRN?=
 =?utf-8?B?b1JzS0tFMSthWTNJdnRQOW5ETTQ4TVRaYS8zNUdpcG9oN1dJRlpiMWNKRkNL?=
 =?utf-8?B?TlluNTJac21FK3NGVmpudEplbVM1YmJSRDBqcjYwL3lzd1MzelVFV29FRnVP?=
 =?utf-8?B?OWZNUm9vbGdXN2RTdW91dmlmREtSdGg0b29mNEF3YXpDZmhFS29pUTUrZXJa?=
 =?utf-8?B?d1ZESDRJZUNVdzgzbzlVc3B3cTJXZ2dvOXNHUytYZ1dhUVpEb3VxaFAyaW5h?=
 =?utf-8?B?TG1OYm95Nno3UGF5SkR3VnpMOTFMSjhaL1lRZlBUcHcvelpPcHMyWUVpWmZP?=
 =?utf-8?B?RFNzN3BWZHRJSDRsWGJTZEw0WHQ5bHpWbmlkMCt5TklaZm54RC9CTm1rSk9H?=
 =?utf-8?B?SFdmMFc1eXZMMXV3ZzhuMG9MRTJoZUJieXNpS1hSWmVOZDUrdXlSTkdQc0lT?=
 =?utf-8?B?ZnVnQ25kM2JKaFNFNHJBaWdjbjdJK2hTd3k5bExwMnp0UHpCclZTbU0rMm4x?=
 =?utf-8?B?dDJrcGFOS3ByZUdFZ2M4KzZ5b3pxVjZpSUZQYnplMFlmRE1IUEcwbC9scWd4?=
 =?utf-8?B?bkkraEgzdDFFR3pYMGVkM1E2WTRkY3Zma0l2Z2w4bUg2YU1Rd2p5WTJRSGRN?=
 =?utf-8?B?Z3F1OUZLa0pOcWVrNS90US9VQ2RNODlxVHFiQi82WVV1UjJhUVhnZkVJUjJF?=
 =?utf-8?B?WkhjOU8rSSs1M3pVdG9VbkpHUDF4RG9SY1h6Ym9waEpaNS85NitCRldRS2V3?=
 =?utf-8?B?RzJudzNnM1NScnpKUnRNZW04QnNaZkorS0RYV1NKL0xNNVdrSTVHRlZ2bDE3?=
 =?utf-8?B?dmtnRjRqZmtaNWtQbkhJYmwzUzVKa2c4NEdxY2ZKdE5iS01VRXM1T2FJYUpL?=
 =?utf-8?B?WlNEQ05NMUJ0M2dPaWI2c2I4WmN3RjVkSUJNcGpzN20wM0t1L2YwNGFZSmh5?=
 =?utf-8?B?ZnJsU1RUenlNWFRHazlKNXlXczNONElieU5aRnI4ZkU3ZUVQTEhvcUpsZHU4?=
 =?utf-8?B?RjZDUnQ0WEVNbFJ6SFNSZ2ZwQjZaVjl1b3JGZnUxcUcxZ293enNQMTd0Z0o4?=
 =?utf-8?B?eXJjemJWSGVQU1ZkUmx2b1g5Nng0d0xUd1gwUy93STVYVmVJMGdnN2VubWZH?=
 =?utf-8?B?cnlTOG5NRnRUV2pCb2ZuZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTV4bWpvUUxFRFV2QmdpWXR3M2prYW45K05MWDdRcVlMcVRwY2RDY1pGRzVC?=
 =?utf-8?B?aFVSOUV3c1JzekxiN05FQUZEMjEwZXRiUUEvT2psOG41VnZMTW14K0J5U2kz?=
 =?utf-8?B?elVsK3djQTBRM3VNa0J1WDJjZWI2U09qRzI4L1A1R1Z4V1haSWZzWU1SYnRh?=
 =?utf-8?B?OW93cmxKRGRJa1drbDYyTTRBdWZZMWdwb2cyK24zZHJLdU1NVjVXS2FzS1BX?=
 =?utf-8?B?S3dQYitaVmdJTmhiOHYwS05Sd2RPcmZIWHJPN2wwaEVQZ0FTWXR6NFNXa3U5?=
 =?utf-8?B?bVdFRDBMN0o2eHJVbzRIdGhqQVozazJEWU91TDhyZitwTGlBN3Q3RU10K21G?=
 =?utf-8?B?SXJhQ3AwY0diRHBaWFJQS0xjaEdGcjh3YlhQbjVzYjFqN0l2aWk4TkNBN3Ez?=
 =?utf-8?B?ei9mQ21uenpNUUkzZ2I2Y1hpUm5mTkJXNXZqWVZvdG5zdUxoTVhMOStyYVJY?=
 =?utf-8?B?eGtEdzVRNUtKTHRMR2Jma3NJdzdadG55dDVGUzlQNlRjN3EvSzMyTmNiMm5M?=
 =?utf-8?B?eXRBUnJKaWRva0EzTFFwbFFjYXE1T3JvY0prZzNXajZ6dURCUUxxek5iNW5L?=
 =?utf-8?B?WHJYKzRZd3ROblNMRDYrdHR6WXgybm5PR1owY0R6cjRHRy9WMTVVbFRuaXlR?=
 =?utf-8?B?VXI3RmUxa3pKeG5sV2NFS3hyL1RPYm5rSVVQMU13UUpaUkpZQmxheG1OUkls?=
 =?utf-8?B?M1FteG1yeE8yK2wvSWJ1LzFVODg5N2tRSkZiZW5HNjRqdTN4L0Y0a0Y5VTZJ?=
 =?utf-8?B?S1V4bGVIYmtBMlhtSG5FeHUvV3o2NEZleEFtalZhWm4yVGp0NnA2RFZpVDl2?=
 =?utf-8?B?ZmxUK09SQ0xMQWZwbVpjUVZ5VERyQXQ0bHJSYUk5SUVoQ0ZOdWxDMEhENW9L?=
 =?utf-8?B?cXV3bitCbjE2b01uMHJJR3pyQ2dXR0Z5cHZaUzJRcENOM01PajB5WDJKRFBx?=
 =?utf-8?B?aVdCVkJoNzdGRTV5Q2hpZzE3ek9peGV0VTZhSUdCOExYUXhIQjZKNFo3bitH?=
 =?utf-8?B?ZDdQS2NTeStqYm5hSjlNMXBPajNNZ2ZWWDdxQW1zQ3loR2t1SnUwSldtSGJE?=
 =?utf-8?B?QlVuMkRmTFIvZWVkK2ZlckFpK2VBaGNqM1lGVFhLcXh5VHAyM0VIZy9aRzAx?=
 =?utf-8?B?b3FkdURGN1pGSGVSaWxyWXNTdzlOWlJYcXk0aGRTY2JlVTNqUk1kakFOcTU5?=
 =?utf-8?B?ZkJESWhPbWJlTGc3TEhkMlN4UkFHVldKZGQ5OFJIYmhIK3F6UnNoQVRqR2J3?=
 =?utf-8?B?dTNESlpEbUxwWkNTY08wcW44VXl4enpZVG9kSGFkVGVhVUVrb0lKR3BRaVZG?=
 =?utf-8?B?YmlLRXFYMWNpZTlWS1YvUzYzRmhTOFRsZFpxcEtuVmtEenZ6RzdQTk1PVjFD?=
 =?utf-8?B?NyszL3BBY1B3eGp5NnZxdW96ZkFaWnI1VGpna1pQMTducmtFTnJ6YnhMYko1?=
 =?utf-8?B?OGFZd1I4ZHc3MlMzS2VDdGlBZFdmdGhvQkRFTGZiZ3hWOXAyditXQWIzRXdY?=
 =?utf-8?B?cDVKVVZHTm9aNW5wZFo5VE5MOEhLUWhyeWNrTjA0WDV2YmFMdVllYU9xbTIz?=
 =?utf-8?B?U2ZmQU9HM1pBUzNBRk1jTFNHRFRrSG1aRDg5cEhxanFOOEdzSVJzSTZNbnZh?=
 =?utf-8?B?WVBQYUI0Q1RvcDd4RFRTSnZRZ2R3azNHRzZZcktnd2l6K25wbFd4dWk0ZXFm?=
 =?utf-8?B?ZmNSemNGUUVoeWxEUzlsekx2cE16aEhJdkxMRW9sWlV0RDdyZGRQUXM3dHpH?=
 =?utf-8?B?d1FZbU43TjlPKzRnSkJ2blJhRmVsalZCVG8yTi9xUURtYWc5REk0K2JrbjVo?=
 =?utf-8?B?ei90ZTNlaTFOVnN3YkRtS1hodUs2bjBYMldUNWs5aEZBb3QvNm5yWFVIRW1O?=
 =?utf-8?B?Z1QvaU1QVUQ5SzZlSjN5RXlMcnlNbWtNUjZITVZ5ZTUvcWZXRTE5OERDaWhk?=
 =?utf-8?B?YWdNMktyRFU4STVxRGJnaUZabW94eWljbEZWZE5FRkhrR0VNYllEd1dGK0ov?=
 =?utf-8?B?MjJ2bHZ6SFNLNXQ4OUZ1Q3M2Z3BEbkNRc2pjUnZIdS9iUnVOelRIUzdhL21D?=
 =?utf-8?B?UTFPY2dSVHN5Q2FWYWp6WHdVc1hhZzkyS0g4NDQ3RG5kN3EreVV1VjdkTDNy?=
 =?utf-8?B?NXowbm9LUVBzNTlENnBJNytMcm9UajNDTC9CZ0VBSEJQcGdPUjVmSis5WEEy?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95f159e-c030-4432-ea1f-08dca1c48501
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:14:19.9284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXgCwwiJtKgqQep+q5R92RP+UE6tHUmQeuu1gctfaj78Qi0E0oZrtSfKA3oWety9eP1NifASwgHmo/oFCA6RRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3329

On 03.07.24 15:25, Florian Bezdeka wrote:
> Some (rtdm_)printk() calls were missing log level information. The
> default log level (= warn) did not fit well for them.
> 
> The missing log level is addressed by migrating to the pr_*() API.
> 
> rtdm_printk() itself is just an alias for printk(). Migrating helps to
> remove this function once all drivers were updated.
> 
> No functional change.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/drivers/net/stack/ipv4/icmp.c           | 25 +++++------
>  kernel/drivers/net/stack/ipv4/ip_fragment.c    | 17 +++----
>  kernel/drivers/net/stack/ipv4/ip_input.c       |  4 +-
>  kernel/drivers/net/stack/ipv4/protocol.c       |  4 +-
>  kernel/drivers/net/stack/ipv4/route.c          | 21 ++++-----
>  kernel/drivers/net/stack/ipv4/tcp/tcp.c        | 62 +++++++++++++-------------
>  kernel/drivers/net/stack/ipv4/tcp/timerwheel.c |  9 ++--
>  kernel/drivers/net/stack/ipv4/udp/udp.c        |  4 +-
>  8 files changed, 73 insertions(+), 73 deletions(-)
> 
> diff --git a/kernel/drivers/net/stack/ipv4/icmp.c b/kernel/drivers/net/stack/ipv4/icmp.c
> index c3b80b18d..d96b4fc5d 100644
> --- a/kernel/drivers/net/stack/ipv4/icmp.c
> +++ b/kernel/drivers/net/stack/ipv4/icmp.c
> @@ -24,6 +24,8 @@
>   *
>   */
>  
> +#define pr_fmt(fmt) "RTnet: " fmt
> +
>  #include <linux/types.h>
>  #include <linux/socket.h>
>  #include <linux/in.h>
> @@ -184,8 +186,7 @@ static void rt_icmp_send_reply(struct icmp_bxm *icmp_param, struct rtskb *skb)
>  
>  	rtdev_dereference(rt.rtdev);
>  
> -	RTNET_ASSERT(err == 0,
> -		     rtdm_printk("RTnet: %s() error in xmit\n", __FUNCTION__););
> +	RTNET_ASSERT(err == 0, pr_err("%s() error in xmit\n", __FUNCTION__););
>  	(void)err;
>  }
>  
> @@ -254,11 +255,10 @@ static int rt_icmp_glue_request_bits(const void *p, unsigned char *to,
>  	unsigned long csum;
>  
>  	/* TODO: add support for fragmented ICMP packets */
> -	RTNET_ASSERT(
> -		offset == 0,
> -		rtdm_printk("RTnet: %s() does not support fragmentation.\n",
> +	RTNET_ASSERT(offset == 0,
> +		     pr_err("%s() does not support fragmentation.\n",
>  			    __FUNCTION__);
> -		return -1;);
> +		     return -1;);
>  
>  	csum = rtnet_csum_copy((void *)&icmp_param->head, to,
>  			       icmp_param->head_len,
> @@ -435,23 +435,22 @@ static void rt_icmp_rcv(struct rtskb *skb)
>  
>  	/* check header sanity and don't accept fragmented packets */
>  	if ((length < sizeof(struct icmphdr)) || (skb->next != NULL)) {
> -		rtdm_printk("RTnet: improper length in icmp packet\n");
> +		pr_debug("improper length in icmp packet\n");
>  		goto cleanup;
>  	}
>  
>  	if (ip_compute_csum((unsigned char *)icmpHdr, length)) {
> -		rtdm_printk("RTnet: invalid checksum in icmp packet %d\n",
> -			    length);
> +		pr_debug("invalid checksum in icmp packet %d\n", length);
>  		goto cleanup;
>  	}
>  
>  	if (!rtskb_pull(skb, sizeof(struct icmphdr))) {
> -		rtdm_printk("RTnet: pull failed %p\n", (skb->sk));
> +		pr_debug("pull failed %p\n", (skb->sk));
>  		goto cleanup;
>  	}
>  
>  	if (icmpHdr->type > NR_ICMP_TYPES) {
> -		rtdm_printk("RTnet: invalid icmp type\n");
> +		pr_debug("invalid icmp type\n");
>  		goto cleanup;
>  	}
>  
> @@ -467,7 +466,7 @@ cleanup:
>   */
>  static void rt_icmp_rcv_err(struct rtskb *skb)
>  {
> -	rtdm_printk("RTnet: rt_icmp_rcv err\n");
> +	pr_err("rt_icmp_rcv err\n");
>  }
>  
>  /***
> @@ -492,7 +491,7 @@ void __init rt_icmp_init(void)
>  				   ICMP_REPLY_POOL_SIZE);
>  	BUG_ON(skbs < 0);
>  	if (skbs < ICMP_REPLY_POOL_SIZE)
> -		printk("RTnet: allocated only %d icmp rtskbs\n", skbs);
> +		pr_debug("allocated only %d icmp rtskbs\n", skbs);
>  
>  	icmp_socket->prot.inet.tos = 0;
>  	icmp_fd->refs = 1;
> diff --git a/kernel/drivers/net/stack/ipv4/ip_fragment.c b/kernel/drivers/net/stack/ipv4/ip_fragment.c
> index 113a71238..d20cbf52b 100644
> --- a/kernel/drivers/net/stack/ipv4/ip_fragment.c
> +++ b/kernel/drivers/net/stack/ipv4/ip_fragment.c
> @@ -19,6 +19,8 @@
>   * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
> +#define pr_fmt(fmt) "RTnet: " fmt
> +
>  #include <linux/module.h>
>  #include <net/checksum.h>
>  #include <net/ip.h>
> @@ -96,7 +98,7 @@ static void alloc_collector(struct rtskb *skb, struct rtsocket *sock)
>  		rtdm_lock_put_irqrestore(&p_coll->frags.lock, context);
>  	}
>  
> -	rtdm_printk("RTnet: IP fragmentation - no collector available\n");
> +	pr_err("IP fragmentation - no collector available\n");
>  	kfree_rtskb(skb);
>  }
>  
> @@ -132,10 +134,9 @@ static struct rtskb *add_to_collector(struct rtskb *skb, unsigned int offset,
>  							 context);
>  
>  #ifdef FRAG_DBG
> -				rtdm_printk(
> -					"RTnet: Compensation pool empty - IP fragments "
> -					"dropped (saddr:%x, daddr:%x)\n",
> -					iph->saddr, iph->daddr);
> +				pr_err("Compensation pool empty - IP fragments "
> +				       "dropped (saddr:%x, daddr:%x)\n",
> +				       iph->saddr, iph->daddr);
>  #endif
>  
>  				kfree_rtskb(first_skb);
> @@ -197,9 +198,9 @@ static struct rtskb *add_to_collector(struct rtskb *skb, unsigned int offset,
>  #endif
>  
>  #ifdef FRAG_DBG
> -	rtdm_printk("RTnet: Unordered IP fragment (saddr:%x, daddr:%x)"
> -		    " - dropped\n",
> -		    iph->saddr, iph->daddr);
> +	pr_info("Unordered IP fragment (saddr:%x, daddr:%x)"
> +		" - dropped\n",
> +		iph->saddr, iph->daddr);
>  #endif
>  
>  	kfree_rtskb(skb);
> diff --git a/kernel/drivers/net/stack/ipv4/ip_input.c b/kernel/drivers/net/stack/ipv4/ip_input.c
> index 26642ef6f..933e38b56 100644
> --- a/kernel/drivers/net/stack/ipv4/ip_input.c
> +++ b/kernel/drivers/net/stack/ipv4/ip_input.c
> @@ -21,6 +21,8 @@
>   *
>   */
>  
> +#define pr_fmt(fmt) "RTnet: " fmt
> +
>  #include <linux/bitops.h>
>  #include <net/checksum.h>
>  #include <net/ip.h>
> @@ -102,7 +104,7 @@ static inline void rt_ip_local_deliver(struct rtskb *skb)
>  #endif /* CONFIG_XENO_DRIVERS_NET_ADDON_PROXY */
>  	} else {
>  		if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG))
> -			rtdm_printk("RTnet: no protocol found\n");
> +			pr_err("no protocol found\n");
>  		kfree_rtskb(skb);
>  	}
>  }
> diff --git a/kernel/drivers/net/stack/ipv4/protocol.c b/kernel/drivers/net/stack/ipv4/protocol.c
> index f56177da8..bd74b05ba 100644
> --- a/kernel/drivers/net/stack/ipv4/protocol.c
> +++ b/kernel/drivers/net/stack/ipv4/protocol.c
> @@ -23,6 +23,8 @@
>   *
>   */
>  
> +#define pr_fmt(fmt) "RTnet: " fmt
> +
>  #include <linux/socket.h>
>  #include <linux/in.h>
>  
> @@ -80,7 +82,7 @@ int rt_inet_socket(struct rtdm_fd *fd, int protocol)
>  	if ((prot != NULL) && (prot->protocol == protocol))
>  		return prot->init_socket(fd);
>  	else {
> -		rtdm_printk("RTnet: protocol with id %d not found\n", protocol);
> +		pr_err("protocol with id %d not found\n", protocol);
>  
>  		return -ENOPROTOOPT;
>  	}
> diff --git a/kernel/drivers/net/stack/ipv4/route.c b/kernel/drivers/net/stack/ipv4/route.c
> index d9a9c8b9b..0863c9d03 100644
> --- a/kernel/drivers/net/stack/ipv4/route.c
> +++ b/kernel/drivers/net/stack/ipv4/route.c
> @@ -22,6 +22,8 @@
>   *
>   */
>  
> +#define pr_fmt(fmt) "RTnet: " fmt
> +
>  #include <linux/moduleparam.h>
>  #include <net/ip.h>
>  
> @@ -479,7 +481,7 @@ err2:
>  	xnvfile_destroy_regular(&rtnet_ipv4_route_vfile);
>  
>  err1:
> -	printk("RTnet: unable to initialize /proc entries (route)\n");
> +	pr_err("unable to initialize /proc entries (route)\n");
>  	return err;
>  }
>  
> @@ -588,8 +590,7 @@ int rt_ip_route_add_host(u32 addr, unsigned char *dev_addr,
>  	} else {
>  		rtdm_lock_put_irqrestore(&host_table_lock, context);
>  
> -		/*ERRMSG*/ rtdm_printk(
> -			"RTnet: no more host routes available\n");
> +		/*ERRMSG*/ pr_err("no more host routes available\n");

I think we can get rid of all those archaic /*ERRMSG*/ markers at that
time. I don't call why exactly they were left behind, but the fact that
these are error messages is now documented via pr_err.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

