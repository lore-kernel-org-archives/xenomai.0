Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B0FEAE7
	for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680238; cv=fail; b=t7ZWvoGTCBDuGVyCJS6Sf1ek2l3Vee2OqZY0fJVFRR7kLcTIrDIk3FsIX6Y70BZRUJ+BvhAXZIlTU7FOIWCkUgfsCl/3/neoRhuD3bBo5bSFnXdTYjvZSUIaQn/9AMTXK5rNibYNpylgQdsGfCAvod+y8L0/c8uXm/u1vrxlYts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680238; c=relaxed/simple;
	bh=DupHGkPnQiJQgU6c/pFQMHjep4+sYsGhkGy1pph5xvA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U3ggVw0iYAx8LOxoEAu55flrvzkI5DbkcOtQA3iAblUmiZTW+aP9kHbeuUXnuJ86uKIq59ZXbWQtJFT96KIHmaIeaWTMyHkAkUwF9jWKaCcKU+j3j+3C/ZDiubV5wnHydtrbFZjebJz9iBURBWhNmQ3N8gxxzhGKjlCddvixld0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Ruwkl0Vk; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Ruwkl0Vk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4AYOy4l8moIe+maeCzwDutUZVkRmYLXpKr4PQgTfnNAHe84hCzbh6oNCRW/9hhFofDHTmJ/Ddm6FkuMKzIsokhC6Rt4TXUY4nD1A1Q0gLRLib5IYtM3J4cYWINMwcNePe2sZeuVRr3rm0Dh2qDvGN2WCAp8q0Gm72UzRsJcNgBYbgiuaGy56GmXT/GXcD0NTPGnehYiEgPwF6slzZoSOVfM5ouLMSiyNSiSvqhS7m1/DlLdRgLn4oq7+6yQrwLOjgEuSZ9VE7ZxaQaOmjgnDyI85ySS3FIxOqC0Lp22LWyrLOZSyLNyw0QxD2RtU1hmAZClXcyyOvUp8gN6sfC/SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUfAZ4zRQlqd+YEOXhOslLT3rV7y6fzPVc/xUtj577w=;
 b=e6z5uGlb3I6StbRXqnrvFjIIHE0vUs6tlI1CWfXfGdAqwNgtyFwRiBGLHnDRWy/vlrOxIL2T3MNyeFifPnMB9Ea3sD7uyN/CXH7OgoaQ/ukMjlpzOqIu4/8dfoP/M+27MhmGq/RwuwmGZEa0gCPIJzx8ZitUxfRwzIi8j0A4pCy/1tdm52Pqp6djPci0FwszLwcvshJL7hV+q2Z+NopFX8YLtAgI7eHP2hKp/KCm6oegCTOhvoB0qxrB/cPmVlpR80yQhY8a5Ru5tu8RLXl4Cbc6OROdN+rnlDBn96B2xAvYZAexPXjwrntfbxhaQVG0tbi2iW2cOQKldtpkdwHk6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUfAZ4zRQlqd+YEOXhOslLT3rV7y6fzPVc/xUtj577w=;
 b=Ruwkl0VkEBW6dLW0rFbianJdQYCQ6wEzZsVim4kG5rZKvWCK9HQ1wFrN9EemJId906kLX3Dd+hVgNFwl1EP9u+wgMzoInDXbEzcDAtunIHgB5H5lVfnnvxPHLgY0pmUeWRUMp8P72XzYCEOUxWZ9omNLkviqBXDc6EoBvKrQEfYbzC1mWgMKHxC21dHjiEKmShdQSfLmVnfdfGO4NFRtze6fY02Yb2DTFy5BnTNvycdK+2ROVUBC0sqWe2D70yfdOtpbDi0rhRQoelDWN0EbU6GU+9bbvq3tMvpl28a+foZ5eUGA0/5avrxh1BqztQ0eL9OqUyf0YShdspF8i4P8mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 09:50:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:50:33 +0000
Message-ID: <eaef51c3-ca97-444c-b883-4ca8ef6e3f00@siemens.com>
Date: Thu, 29 Jan 2026 10:50:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] Warn on unexpected RTDM task termination
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20260128112821.1232-1-richard@nod.at>
 <20260128112821.1232-4-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260128112821.1232-4-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0380.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3759:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad713ec-f493-4e1d-807a-08de5f1bd84f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TllvakwwMG9SaTVES0pkRGlIbHRxUmpIRGJuZjl5TVgwczVwbDl5bHVFWE5D?=
 =?utf-8?B?Q1NnMlRsckNJOWNSSnZ4ekFIc2hubWtaYUxmK0kxNXN4cFhTT09JS2xESCsz?=
 =?utf-8?B?SmNMZXZPeWxRWGNxOXcrNVk0QlhZbTFPOFlhM2M0aExRcjdiUkt0VjdRR2N2?=
 =?utf-8?B?ZDVsR0lKQXFGeTVmSHhGRGMwN21aeStCdlhPZ1NsNjRDbXE4OERjUjRSWEpC?=
 =?utf-8?B?c3V3OER6c2oxK3dUVDBTcENkWllkVzRCMGMwaGQ0TlpqNWZ6V2xsTjBYZzRq?=
 =?utf-8?B?ZHFOeVQrVHNPRUJKMUw1bEpiU0EwMlNTRnVrbGdzUkFQQ0ViMmJCWkRGQTJX?=
 =?utf-8?B?Zm5rckNza1kyR3dVTlYrSEJWeDVha29rZDdNNS9td095R1VXYkdqNHYvNURM?=
 =?utf-8?B?MFhBNCtnd1g1eHNVcS9tUlAyRlVuZXArVUpsNmwzY04zWmxnVVdOMFdsd2RJ?=
 =?utf-8?B?M0R0a2RkSS9MY2tCMis5aUpwNDlxMlVXazE5cEpCNnlXVlRnaENDL3V3ODNJ?=
 =?utf-8?B?dVFhQys4bWxlYVNXTGgvVjNWZXNMc0dvTFFpalRCVUZWYjdWTTY0dk81Z3lI?=
 =?utf-8?B?MHo2eFl6c1QwMG1ZbTkwbzI5dFVZNjZieE0vM2drTzZISFo4SmtwWUdhUmZi?=
 =?utf-8?B?TkdCTnV1akd3Q0diTmR3Nm5SSmNoM214MWU1bjkvSURuSmtMRllMUkE2ZTho?=
 =?utf-8?B?YjlERTJ1ZHo5MWxXRXgwK2NhelBKekxhT3d6MW5WVkZXTTB6RXBkZFZJWmU0?=
 =?utf-8?B?UVk4YTZhWndaVVExN1dXMWhmVjF3dHFDU3I2VTkrditzZVl1bG9SL3d1N04z?=
 =?utf-8?B?NkVzS3B2ME92cGtPWkQwMTdjd0NaLzkveVJJSWgzSUZEeXprM09IZWFnNlpj?=
 =?utf-8?B?WmNjUzN1STF6ODRwT29jQ0N3blNDNzVLaExKeW1Fa2FJeDVPUzc3cVF4T1B5?=
 =?utf-8?B?ZWRIZHMvcmFnejBWcmx0QmtWVUcxRmJSK2wrZXVSZTBMQmlMK1kxcktUNEpJ?=
 =?utf-8?B?c2dOZXR3TnhZemRDdkxNckI0WnZMaklJbUc5SVozYURTT1JqY3I4dzBQdFRM?=
 =?utf-8?B?Mkl0ZExQYkxRZzZ4U1dZcnZLOEt1MVJTVzU1bXlrUnQ3SFI5R3FNVUl0Q095?=
 =?utf-8?B?M3NFdk5zL0JXTlFDWTFpTzV5NWNaRm8vVmpoUUJUQUV1U3R0WjAveWdKT3pX?=
 =?utf-8?B?QVpkTXptbkpsRGtNRjFrWlNRVmRFVGZ0ZElyOGJ5U0hSNTJ2ZjFGeG8zbnQw?=
 =?utf-8?B?NmYxUU9MOEUvR09vU0I1cFJ1SUJ6SFcwdjBXSXdwRm5tcmdJemZMNkFTMjgv?=
 =?utf-8?B?Ykw0TGZmekhMZDVnUGo0YVUvYjV3SGpRQzJCTE91a3FmcmZiT1UveVBhZjls?=
 =?utf-8?B?eVRrUjZZdjljeDFpNnhUd2xraEtoVVZwRnkyemhua1dHcU5hVnQrbDRuNHVO?=
 =?utf-8?B?S3FldVd2d3AyOWpudGFUdWdZY3prakorZVlseU5IZzNKKy9SWVl2L0I4V1JC?=
 =?utf-8?B?VEtxZ3lJazU4U0I1a0FHSGhvbjQxazhLZFJRYVNLUFl2R281WlYxU2o5bmlo?=
 =?utf-8?B?aGdMVTdPYW56UFhQc1NnQWlSZjlCR2NCOThVQldPUHRHRDZpWng4Mm5BdFRr?=
 =?utf-8?B?RkJpUndwSTJ2ZXhLczZSZmlJdjJEclg2cXptTVFpall0a3ZSaGlWTGxYRDkw?=
 =?utf-8?B?RzAzY052bU5Icy82Wmp0d0gwNGtXSlg4eVZLZUw1Ykx3QmFYTUpVUFZwZStM?=
 =?utf-8?B?OTQzTDk2aUUrL0w1QnNzcDFhREltUWxXL1NjN3VtczVBWjQ0cS9tcWpGeTFO?=
 =?utf-8?B?WkhjbE9PK0x5TGF0aUtxbjNBRXJyd0M0dzR0MVdQSm9ySkZ4cmczQnVCMkhz?=
 =?utf-8?B?aE45a1ByZS9ZZFdGR2F4dEdCazQ0VEFqR3FPU0VZb2FRRFQvUnR2dkxsN0dY?=
 =?utf-8?B?dTcrVi9MckhFV0tCaVBSZGUxSWMrVytKTm9KdWl2WkFXRUlLOHgzZnIzSGpW?=
 =?utf-8?B?UEFoTlFwaTA0RGxNWVJVOWpZSy8ycGt6MzZMbytmM3V0WUZ5ZjZ1eHJrbFhx?=
 =?utf-8?B?cUt2WHY5TVFuOE5iRHNRR2lxaEswWjhjcTJHWHFVREpSTTUwY0dQRW1Lbmpv?=
 =?utf-8?Q?uqPo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1VYT3Rka0RZcndybmRtTmU3bVZJaTBibXVLenpuMFJPNllleCs4dnlhZGsw?=
 =?utf-8?B?N2F4L0VMbGJRcDFwZk9iOUdmYTQ5UzZzZHF4a0pVTVk1RTR4YXZNVkpXYnJY?=
 =?utf-8?B?TXpCY3BsQ3R2alpHcVRnM3A2ZldWT25pb3FnT3FXOFBLL2NnVUl4SktkcVRF?=
 =?utf-8?B?RFZ6N01teU1mWElRVFZoOENqY2dPeFdwRytpN2xhMHRUMjFQSEdPSmswUjAz?=
 =?utf-8?B?V2lJcEM4REJUalBpSFpTNkVtSkYyU0dEYlZJWS9HUmU1N3NDMXJLM3VLSEd1?=
 =?utf-8?B?bGk2NnhwcXM2MG1QbjBJY0w5eXJQNm5Pc2FKWmx6ZUtlekdIZ2ExOVMvUm1T?=
 =?utf-8?B?YjFjZTViRkF3K1lSZ1c1WDBtckxjd1hEbVBhdCtTUE1lQUU2N1BDdmQ5OHB2?=
 =?utf-8?B?M0hWRGJBMUFxRmNyZDAycWlmYVJwNExHamdtUmV2UTNmYlZOWGxtYkk3SjNn?=
 =?utf-8?B?SHl3cUNWK0NPa2c2UGJ4M1hXbmtBNGkvQlpQTUpxMFRiOW16NkRHSW9iN0xy?=
 =?utf-8?B?Nk5TSWhCd3MrVm9VaXZqUUN4amdFdldveUkzbUJRdTRHZGUwRnA1dEgyN2pH?=
 =?utf-8?B?M2Z4c0dHbEdMTENYdmZRYlg1UVJodVc4TEE0UzhhVW5oWE9VZ1hscFBTUDlq?=
 =?utf-8?B?QmFJeXJKa29DdnV3MGRrNEVSV2NvQkxhSUhsUGxQSTl4dGo4NTNyM2YrOHc0?=
 =?utf-8?B?R3FycWUwTnlFU2xGY3BHNldWZEoyZ3VXOE5hYjhnczBJbGVJbXJzdTdISUUr?=
 =?utf-8?B?WXFPVXI1RXBZM0xSNGIvdGkxUk9IYmdRNFFGeEZodEgwQ09VRUpTYVYwRTky?=
 =?utf-8?B?aXp3aWxaZmZMQ1pYNHA1MDdRWThoc1pqQnNBTlNHMWRvY3M2dVNEQUtjVUFI?=
 =?utf-8?B?ejlFUmM4K0lqT2ErQzg2Z3UzZkgzWmNuaTl3QUt0M01Vd2p1cGc2V2dNVjM1?=
 =?utf-8?B?bmgvWkdZVU04bWhCWDZ3U01XMjR5U2l2cGNYb28yS0tmMXZ6cUtBQ3pxdUhQ?=
 =?utf-8?B?WTRzdkRPaEdhZEszMEJNWkd0MWdkbnlmZGlWOXkrT1BBR2t5WHIwamdRT1Mr?=
 =?utf-8?B?dzRQZlZXT1VzWittbnJpaEp4MXRad0d4Ym45Umsyc0tmcHJRU3cxamROQjBX?=
 =?utf-8?B?NTExZkk4b0grbWx3RTE3dHBQU0I4T3RjMXZ0TkszVVQ5U3RmMlVocEZvMnh6?=
 =?utf-8?B?N2NPRCtOMXB3K3pUQk9hWDhvR1loVVFIM3RtMFl5V21tck5VczFQUmgrQnZD?=
 =?utf-8?B?Nkk5dFR1d3RpN0s4Qk9JU0RYUks5cDdhLzhpMG5SaDJza3FlTXVZeXZycEtY?=
 =?utf-8?B?bFZMWlFYZmFsRG1jL1dQUHBmZ21PdFcyU3JzRDd1SExiMFNkb3R6RkdlQ0RW?=
 =?utf-8?B?NENSeStueDFENkFTK0dndUhZVldNRFFsUVgwYXF5Rk1yeThOMG1zdTdzM0U1?=
 =?utf-8?B?WDdXS0NXTDE1Z2ZSckZyTFNFQ3ExbHhMWWxLa1pNeGhVUTBNandUblBmdW9k?=
 =?utf-8?B?ZFRDQjJvcWpTczJrOG5jWDdqSWJ2aXpjM2hkWGtZLzNaTVlra09wVTVvRnNa?=
 =?utf-8?B?NG05UTZoSklUTGtrNUZFcW5GOE9QZ282cGRKS1N3dDlGVmloS09rVGVmTXpD?=
 =?utf-8?B?MjJvcnh2bFpRSGtmT1R0TnlUOU9qQUJpOG1lb2NRV2FSaTVCekJPa1JObEdC?=
 =?utf-8?B?bzFLWWFMQTI5Q2dhbjg5SWVXSU1XaTJvVTV6c2RiZFJ4NUVhNUEvWTFCMFhh?=
 =?utf-8?B?ZmJTYUpqNW15dVBWeEFVMWdXbjRRY0JjY3dKbjdjc3VQa2QwUndCZlFNUU9n?=
 =?utf-8?B?QTAvV0VhSHZ1ZFgyVFhrTVVuNkRKeks5dE1YbU5TZzZVVTk5L25lM2h2bzFx?=
 =?utf-8?B?bUJWVlIrOVFkUElRNTRWOVErdVRXZHVaUUdXa3NDa0pWM2ZIYUhZWHFYaDVJ?=
 =?utf-8?B?cjZxeHNVMHRiUitiOVl4cTd1aWN6eTNtdnFOYXFNNHN6eVkzUW9PSEcyOFJv?=
 =?utf-8?B?NGN6ZzR2YWEzT3ZqTktHWG1YcWNUMHlnT2hQbGNBaVRSOFB0d1QrLzJYdkRz?=
 =?utf-8?B?eDJwNW4rVzRSMGdsRHdRdW51MC82RlFqejFqRVBwTUw5RnhYd0wzd09QeWRk?=
 =?utf-8?B?RmFoNW15Qnk2a3ArWVhlU09FcDZBVmVWNWNNNEVEbXJYWWNBQjB0a0IrWXNY?=
 =?utf-8?B?VlJQakU4d2hoNEpQYmtkUzAyQXNsUXRmQU9tcUpDa1M3TzJ0eUV0VkJ1RmJ1?=
 =?utf-8?B?VVFnVXZSNmFNMUpTeVlFRitSQ2xqcHVwdkN4RitzOVp0eG5IcXBUM1l6a1FU?=
 =?utf-8?B?UlZ0NWZuYTZ0ZlFqell2eFlqUnhqcjFTTnVMV1doMURuVVkxcHVudz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad713ec-f493-4e1d-807a-08de5f1bd84f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:50:33.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxACeATzlYCOFL69LqNnWz9XwgHeV2+Qi2J1N2iq8SKjHBZrEHGaHx0rItGlENdppCQjHVN5Zot4OHKqJ+4dgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3759

On 28.01.26 12:28, Richard Weinberger wrote:
> Now that all in-tree RTDM tasks have been updated to handle termination
> correctly, introduce a check to detect unexpected task terminations.

They did this correctly already. Key is that semantics are changing, and
that needs adjustments.

> 
> This warning will assist authors of out-of-tree modules in identifying
> tasks that do not yet properly handle interrupted function calls.

Can you be more precise here? What are driver writers supposed to do,
what should they refrain from?

We have kernel/cobalt/rtdm/API.CHANGES, but that hasn't seen updates in
a long while. Better is likely to put the new task setup/teardown
pattern into the documentation of rtdm_task_init, also explaining when
the warning above would trigger.

Jan

> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  kernel/cobalt/thread.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index 3f0ed98ef..fb7190cf3 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -210,6 +210,12 @@ static int kthread_trampoline(void *arg)
>  
>  	thread->entry(thread->cookie);
>  
> +	/*
> +	 * Warn the user if a thread chickens out.
> +	 */
> +	if (!xnthread_test_info(thread, XNCANCELD))
> +		printk(XENO_WARNING "unexpected thread termination: %s\n", thread->name);
> +
>  	xnthread_cancel(thread);
>  
>  	return 0;


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
