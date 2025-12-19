Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6F2AD16
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766126950; cv=fail; b=WoCpczxdbZK57AEU/HnlYskWU9brYGBwC2wY2rqPzruJqCVTGOOCYVsdsxW1jRXD/saHpjS4Gn7nDvhnXBzVdNrPgvgy+5GwaoSGHQvOEKn/S0YNkZfUhW0qFMRs9938cMm7e3mewTSDpF69jawRz5vnP7ecwWh8QSiy14VkWAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766126950; c=relaxed/simple;
	bh=wQnQXUO0Y3vbZ84fkVKvRno6qSBtpFNO2ba77VzN4Dw=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=pl8DA1lwCtrbYlCtW3DoqycHT+HFyfFXORf14C8KVXk0I9P72z9oWluhDdlakqjqMeO5U5V42hKr7kGvMXugmtb1eIUIU5+iK7yWd2fhizEtrs88hg66BtzTnuFxlwMHkkMbnSHsif/Do4R04Zy7+9gjEM1zLMRpeyoSrOg6ruM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WSdncVJv; arc=fail smtp.client-ip=52.101.72.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WSdncVJv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsjthP6Ryaet/jlvHN4+xtI5oEKsWZ7S47hmKAjb+VIyXsv0Acx7H/c1T1gs7onuoS/NaNu89v1U1kv1IRq1MWEJdZRVYSDORNkGzQP1/Ty02PUyrlhD5oY1jJt8nlSjkLj5v7i8/pjSe0xaPlkYB3uGx8fc4DSh9+a7ekVMEz3x9f7JV8vnPfwnLdNLhvJjsO14JyC2QQ8yhJJW/mcFNr3EIQwlybPC+rbAf3S7HbkPWo566ZrkMVdNwKsNdaVqxsgdGvY4KvEFSMUOlty6w9Id6bzQ9obRtFSAwfsBl26qmi0VzUVkUtlkHuGNuCW4CzY35jBLcDMaLZGhy3b/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGmx6KfDDCoA38e/QQlE244ceFDSOxNcd03TxiYcF2M=;
 b=gHHhy4J0wdtLiwuuh93ro9ttG1enLBSB3qqpLLeCtz1NnsM8UWPt16SSDiKe4wjMFRPSndWda5hJq4ft9oaPo4oVFSUnXNa7Ul8BAW/JYbDjzWWGfgG43JsRGtJF0Noqx1E9KKE6rNxcB6i6li4vLRHKBDkofpp2IfbkM8g+iEfcCYV3zejSDEo89XH72+96E0853TV70h9D50ufszZpSRxK0NI5aBJgZkC0hkzLsAIlD86jZxCeV4FlMujPsJPsn5yCZWbf1gBzud2gds2cEoimh8mF7j8A1Jl9vq9GEUlNu3vPbEd9rhebkf8gKU1aFTZcdCBman5Xo1fuRkabZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGmx6KfDDCoA38e/QQlE244ceFDSOxNcd03TxiYcF2M=;
 b=WSdncVJvba2z3l5wvZtoYD107hAP34ATzGri+E7UTsQdms5HoaV24ZHD/Drytil2k+EUrcajh5qbqC+hAORKr3AsK/CBQO+eGG5OO6EMQbHfMAxoDhCAFojVtAJJimZwPdILvwhSS4YjNnU6jz+3GWdv1bzHoJeB0V3xZc5FwvuFvkEed575TDkJq9H/xm0FElTzc2hdS3EgyCCQd9BYpQmLqBJkGj+z2QW1AK7VbCE+CaVk1G2LTgWMmRz6weJsS0gU/GsvBV88WnUt471eace8VbJP1qkhdIzU1nfKOgcsIlAVszhrgY7MxOrMyTYsqcssDcJ/Yfug/nBtv6H1jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Fri, 19 Dec
 2025 06:49:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 06:49:04 +0000
Message-ID: <48004331-648a-4f38-b8ac-49f415c18016@siemens.com>
Date: Fri, 19 Dec 2025 07:49:03 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH 1/2] alchemy/task: Initialize thread handle on rt_task_bind
Content-Language: en-US
Cc: Mauro S <mau.salvi@yahoo.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: 03588ba0-8ee7-428a-e6f8-08de3ecab311
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aitKTnRwVUd2dkpNK0hHZzltZHRVZ2hCRENHMFN1a0kySVA5czYyb3BaY29H?=
 =?utf-8?B?UjJpSCtUZ2JHUHZablMyeHZnOXJsd1laOVlCOXZNT3BCcXVyV010SVBrNGJh?=
 =?utf-8?B?SFV2SWpSejBJekhKRGRDVmxxQmpXL0I3M3h0d2xVaktZNytoVkJ1RGRFbTBj?=
 =?utf-8?B?VmNONm5SbThJc3IxeitqUWVTeW5mYzJ1azB0UjMvMHBJazkybDlZSDNHRzM2?=
 =?utf-8?B?MDRTQlZ5dk5PYmdPdUJqcnVKb0J0OHpXTjZibjV1QTc1cWxSVE9pVDhsc0t5?=
 =?utf-8?B?aUk2eFNGaDRWVlp5UnJpNE5EQklUdnRvWGpmS0pPMWNsNGtPSXdDbHUyNmor?=
 =?utf-8?B?cjlNd3pNeVZ3NUplVmUzWldJTXg0eTcwbS9GczJaWUtsSk50ZDJjNXdvTENl?=
 =?utf-8?B?WUExaGpUaGJrTjcyT0EvbTlpQk1uRm9UL1lXTG5WalVaYnY3L3pUR01jSnBx?=
 =?utf-8?B?TUh5TTlBZkVJSHpMQWdUcTJ2SHdGUGhFc0lEN3czU1VvanFNbWRweUF3ZnZZ?=
 =?utf-8?B?MHhBVXNoaCtnQlM3YVB3Z3lWZDRUSmxQY0d3N29TOEdwU0JPVmVoNTM2MjhG?=
 =?utf-8?B?Qy84ZEEwRHNyNnFmYXJnY01VMDQzanNvMDJnUEFLYWFyYTc3cysyMW9YWFFB?=
 =?utf-8?B?eUNpMjFXZkNZUVoxN0VBQ1VrS3pDekcrR1ZZSlFpRm83Z0ErdmdUUWErNmxn?=
 =?utf-8?B?eTJydlQyVDlqcEpTMy9WV1ppV1g5Z0pzbTcwWjB6SFQzL1hUeVVCWnlkTVQz?=
 =?utf-8?B?dzUzT1FiaHZuc3NoNGx6TDdLVWRzbGVtaEkvaHdOVkhLUjQyVlFOOWpMY3hR?=
 =?utf-8?B?M3l5VmNpQ3I3NmtKTG1hR2tzc1NOOEQrYk9xZ28wVi85aWkya1o3cXlyYnZ4?=
 =?utf-8?B?MXIzZ2EvRkNJeVdmK3U0VmRqc3lYbHdVZU1FVVRJaFdJbjVwU1pYM2IycStp?=
 =?utf-8?B?S0w1bm5Ydm4zeXBRbFhMS1daeXlmTUFWTDlJZ1Z0eWpYUEprMGo4RFg1MDhq?=
 =?utf-8?B?YXVXd2w2OEs2b3R6aUpIUVJGTnBRd2UyeVZZSDdRcThFVWxBMnV0RXBLWjc3?=
 =?utf-8?B?TzZlaXdyRHBrQVRQMTBhUjZkKzAvU3RUTmtyT05VL0FZTnNQRDkyMHlHeEVw?=
 =?utf-8?B?NXR2V015aEh5LzNXb0NMUWJzOEwyRVFSVUlZMEl3dHRoazVSSTRkb2tIYU4v?=
 =?utf-8?B?TEFpV3JSZlA0Q3hNVVZ2cnR6bndvYVBuVEcvZXRMUEFvM1FJSWh4YkJkSmgv?=
 =?utf-8?B?SXVmOWxsVjZoanNEOE44ZDlFR0hIZE9nL0R1bTJBbmU0eGxVdFJaZi85UEY1?=
 =?utf-8?B?ZC96UHk3eitKcVd4bXh4SmxoUk5UL2NUUnJJb28xcHpYSmQ3b0Nua2V4WDFa?=
 =?utf-8?B?NGdST0R2MnVieXpjVjg1aDZ3dnpsWnlyNERydndJSmJkUENSdmNJVVVxM3dp?=
 =?utf-8?B?bVRzbGl0dk5pMHdWMFZSS0FjVWIrQVdrU2N2a1NnL0QyenZHZURib1podHlL?=
 =?utf-8?B?ZWJ0M3hkQjJRSkY3ZWFNWGxvUmQrYXJIOCszOHRMQ3VNcGd3TmNTdnVucGRt?=
 =?utf-8?B?aVNmZE85VXRZL29ZNHRxZmdCSG9NQ2FHUDkvbTRKNWg2SDB3VW5Ud3hrSkp5?=
 =?utf-8?B?WUlPQnI2Qy9QNUthVjJJUzN1UW9nRitrcmo2dUNlS3hkc1FWQW5Db0xzbVRW?=
 =?utf-8?B?aiswL05tMkg0QU5YU1VuUzBNU04yK0lCdDJXUThtUHl4UXI5ejl0ZEh3V2Rh?=
 =?utf-8?B?OHkrUk1objJONHk5bFN4djhPZkNYLys2b25GUjJyTWdWcVRZb0VOaTNDOWg4?=
 =?utf-8?B?Snl1Q1diNnlIWDNLM3AzMy9ycTdOMUVneGQ5WFZ2TFdtZzNZam1BNkVtdURy?=
 =?utf-8?B?Vm5leTBCcUZTS1pINkV5SWRIbFhBRkRZdTAzMWNTWExNVzNzUjM5bjZVNHEz?=
 =?utf-8?Q?6tOENCQ7m3/MOZDHDSXbX2oaBJPD9LuR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amlzY2JqdzhwNEIvQzRJR3JqNUs5ZFFxZlpld2hpZUw0OEgxV0xHdVA4bG1u?=
 =?utf-8?B?R0tlc29NYTJvOXJUMEwxMzNrdXNCa1NpNEszd2tVVkRhMkZTWG5GVktFUjM4?=
 =?utf-8?B?Mlg1MU15b3ROT1Y3dy91b200b0dIdzNZYTNzMHdMdjlOcVJBblJKQTRnbGNJ?=
 =?utf-8?B?K3JsRlVGQlluWW9GaTFubHBuTTBqeTljRndyQ1BPRW1rdFdIdFZMSG1mcGYw?=
 =?utf-8?B?MVFTS0dLK2ZIaUFYaENTR1RBYWYxSnk5eXFxcWxHd2Vkd2F5bDF3UnM3T1JT?=
 =?utf-8?B?NFpZM0JZSWRYejlyT0dPQUVCc0tNeGVqRzlhQ1VZS2cwUGZHaU5qaW40VEZV?=
 =?utf-8?B?dFEvVzkxdi9jdHVFSUFqM0NPRGYxaTFtZnJwY2tBRXNScGJ6bTVWZGFxRDhN?=
 =?utf-8?B?eVcrUmVNMU54UG9jUG5IaFV4ODhkSDRZOW5jbnkxVWdmcWhrN21jclhjQVNO?=
 =?utf-8?B?Q0hJcDlnYzc0aDY1ZlYraExvcm4xaXNNNDZFMWpDRWNadU0zcEVsc3hWVXRH?=
 =?utf-8?B?R3ZuZXArVkd2V0IvaFA5WlM0dFdlNGFCM3c3L2FZS2ZPd21zcXZBcHVla0hM?=
 =?utf-8?B?RS9iRjY4WlRKTHBRNzJZd1lrMmhqaGdzb2ZhbG9MODlsTTNWeFFyMVA4Ylg0?=
 =?utf-8?B?WFRCVTF2RW1hdmZnMEJNTzRpZlRwRklxWE5QNHRQSEY2SUQybWpZYTl1UDVH?=
 =?utf-8?B?RGVxc1ZzNzhUb0dDQUxiSDUxbXpHdjF6b0F6TzlHS0U1SUxrK1BNNEF2bW90?=
 =?utf-8?B?V2FBSUFwZWk2SGthU21iZTdUbFhIbGJlczF0VHRUNmNwZ0VKQVM5ZXhEYXRU?=
 =?utf-8?B?TDBhaklhek4xeDB3aGkvSHI5ZGV1WXR0eVJFeW9Jb2d1MERXSE1BZzlJcUd4?=
 =?utf-8?B?cC84YkgzMXRoamJ5b3U5WXRacm5ha3NSb1BjakFvb1pHanh1RUN5N1ZSQlVj?=
 =?utf-8?B?Qk9zOWFEMCtXOHRNTFRPeDErUEFnSGs3OG9LNVpaNWJFRU82ZjY1UTI2SmdP?=
 =?utf-8?B?VEdtL2FrSzZVWEJjWFNwRFlveThTQWZCaGFpZk13MHhsY3U5Q3dBcHJ5dDhh?=
 =?utf-8?B?bHkvcS84bTdFT0g5UjM4b2xJRFh3ZzJTeVVWUG5GcFhrMlBibXJwaGxULy8y?=
 =?utf-8?B?b1RjTlpzcVFpeDBuTWxZNlZYN1hhQ1orQ3IvYWcvZWYwVmpCbmtPeHptWWpO?=
 =?utf-8?B?b0phSHhJMUhYMTFtRlo4M0xjcFgyNlhqTEw1MlFBeVROakp4RmFXTHFEZTcr?=
 =?utf-8?B?UEVRMzVDMWxhSktUclV6eEkrcjNLMTZrdFgwdG84UWxtNytDRDNPOXIvcHUx?=
 =?utf-8?B?UWRveFNiTjduUEdudE1XcUhEMUtYVFpwMFhYOWdKSlR0WUt6MlZ0UGVreStv?=
 =?utf-8?B?VWUyZVpuYitQenpUUjhKK1pscXVlK0lyVGlWRGNQR09OcG1OK1l3eWJ6Uncz?=
 =?utf-8?B?NnBMVFZXcFgrTlRTT2g1SnlYT08vK3crancveVNxSzhBRkdzY1NZbldXYWx4?=
 =?utf-8?B?ZURoRFJRc1d3TFIxWDRrUTZSYmd3OU50R0s1QzByL3FMWnJRYXpYMFcyVEVj?=
 =?utf-8?B?bW10cm14ZkdaWGFpYU5mMWxKczFMZ3hTdzZET3puR0JsMlVrUU9YejBuUXp6?=
 =?utf-8?B?N3BhcFF6UnVTMmdNaVhPSnNQTjVBZWN3NUhrbHhPcEd1K3EzQS9hend3WjUy?=
 =?utf-8?B?clo1QlMrR2hnWTgzYTdJVDJIeW5oR1lneVF5SzBldjFTWXUwSjFIdmhOM0Fp?=
 =?utf-8?B?VXo0U2MwWlcvKzdIOTZVekhRZjlLUFRzeC9uNXEwSXhJQXFCdDRXdm5nSjBs?=
 =?utf-8?B?aU5lZDFjRVZZMTNtaTFyaVlKbFQzcXIwYnYrWmJRWkFNbGtGSzVHTVdGdjZs?=
 =?utf-8?B?MnVmYTZIQnJSeHQ5QlFYSnJhd1QxN3haN2RhRnpucFEwaldvK3o5Zm9qNnRS?=
 =?utf-8?B?Rk5mV3VIYTBiMUEzOG1OekJyVk15QmFqT082aDJnbXBNVlQ1azIrUGxyOHlP?=
 =?utf-8?B?ekpnbXV3eWE0dEo4TVBNUkVLeG5lSnUvNTI3SHg2SThmcWlIblEyeGFQZmRk?=
 =?utf-8?B?aHhrODNNaDltQjNTeXdTMU91YWs1Z1lCUzlpWGhqbG45R3FKZ3o0WWEyM1pV?=
 =?utf-8?Q?jRMTwWcfw1geV6WW6HPXUZp6a?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03588ba0-8ee7-428a-e6f8-08de3ecab311
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 06:49:04.3302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TJbVrchpCr6eTfm9V86bcwqKAu8MWhDkwZq1b+jn2DGUsk2xHMa2MH0gka19WIIoJEv24Z3N1e6aXOAsqP/og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5311

From: Jan Kiszka <jan.kiszka@siemens.com>

This field was so far left alone, risking troubles if a function
evaluating it using a stale value. That's so far rt_task_join, but we
will soon use it also for additional integrity validation.

So, first initialize it to 0, on Linux an invalid pthread_t value. Then,
if the task is a local one, pick up the ptid from the tcb so that even
rt_task_join would start to work for process-local tasks.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/alchemy/task.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/lib/alchemy/task.c b/lib/alchemy/task.c
index 42fca5a319..67f199ec24 100644
--- a/lib/alchemy/task.c
+++ b/lib/alchemy/task.c
@@ -2160,11 +2160,31 @@ out:
 int rt_task_bind(RT_TASK *task,
 		 const char *name, RTIME timeout)
 {
-	return alchemy_bind_object(name,
-				   &alchemy_task_table,
-				   timeout,
-				   offsetof(struct alchemy_task, cobj),
-				   &task->handle);
+	struct alchemy_task *tcb;
+	struct service svc;
+	int ret;
+
+	task->thread = 0;
+
+	ret = alchemy_bind_object(name,
+				  &alchemy_task_table,
+				  timeout,
+				  offsetof(struct alchemy_task, cobj),
+				  &task->handle);
+	if (ret == 0) {
+		CANCEL_DEFER(svc);
+
+		tcb = get_alchemy_task(task, &ret);
+		if (tcb != NULL) {
+			if (threadobj_local_p(&tcb->thobj))
+				task->thread = tcb->thobj.ptid;
+			put_alchemy_task(tcb);
+		}
+
+		CANCEL_RESTORE(svc);
+	}
+
+	return ret;
 }
 
 /**
-- 
2.51.0
