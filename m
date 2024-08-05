Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2066.outbound.protection.outlook.com [40.107.241.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E68537FF
	for <xenomai@lists.linux.dev>; Mon,  5 Aug 2024 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868846; cv=fail; b=WwAjHZtTOcDMEih+RhChfLBbthtNHaxKrdjsJcgoUneR0MoaoNDdQt0jWBSWhTfL8uNbC74JhGHhlSNIgl5e6ppHE5cbHnRhb8oihfiqavaDiZ0O+nE/igAC+S5SL0O7wB1ZxGT0yss+sczUGEXpu+I309kuR2xFR6aocE1gUAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868846; c=relaxed/simple;
	bh=6OV79MnF45YkyGy7G5q3oGOYyi+tzKD0CB3HnWltuv0=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=ute7GCYAfEOhvJJhIIahkLGlZj5Q9ISXLqQvdb03WQBfhd0wU2HbWk/AuJr/W2SAHYe9R6Wlc3zxvFvRTeDt18ebUdr8EAQYZlbs2PsLgHH7sZkEU3wspu87x6cjso7JymtlPNdkZWXYMYndWboSQON/7LEKKp+rYxSTLNSrtWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=g6p291JV; arc=fail smtp.client-ip=40.107.241.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="g6p291JV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ls/R/POn3lwIv0phvfWJbfHi7xkhwX0Tt2Wycsoh25D0q1uRvQbe/ub8ixOOx9DuOYgceDyoDob6vlfmgZKmRaUpeWX7xGAsBXjm38oZmOucy4Xe/4ujwrKhyTkjPaz2KYCeRc4sRToEgA8xNcoSagl5MJHAe5FR9zFDUNrbrtRbo3QL277nBhWpSiueGZoQOGmuiaV47uVCmNkWFUoXvvs3JoszGDgOzyE0/zykYZ3PjWEaDuWV3MWBHLj8CncDp/JsXShViczyfJEDMJ8yTTRap05VfuEYSAj0LJg9MEONZVedzdxsrZwEZZveJ0aNpK3Av6zYXM6hUEyuGCj3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksFYWrmXqb7+L0fBNa07geSGbvqx9fVifHN58CBx9rI=;
 b=Yv+28NtKVeRoAHBlg/bLiozOogGO7/sVN663aXexD1hlLARKo+5bGCjCtSMRYr+4g6r+Iy9esdSNyNczGgTd8k0QVEh+fqLTyA5KUJb3W891HdV7kyUgtKTeQM6MWrSD5yfMSQcNvUvp812f1ZeSkxCCVSUs3owLq2Ww3CIvz7MyVAmgJIYJG3OfwLPtor6OtqcV8dPFPLz10roZcqCa/TNllMXJASvsOs+IGdQQeCrZU3TKlkUBKfZ6PWLkCtrZqfmTQL/077+s7YlUeQ5NCiF7T0PY5OJdU5CnKq4sKCUkVOZS1sWvykFHJeZWyngD10PjMXo2Tsg6ooxoUx5e4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksFYWrmXqb7+L0fBNa07geSGbvqx9fVifHN58CBx9rI=;
 b=g6p291JVET4rdL4jA53Wk7l4bjx9lJOCiRkBmkt9c7YY5Q3dbdWFiLezbaROlpaJGX9zZLs+w46jbd2ytvggjH+Pw6GXy8HDfM37DDapE33osjcb3/wDjMEvgw9gUFz8cX81nX8ux5uyLxYBxe2/xCFn2LCC+hT09jVkiBCSchyS/bfTIYQrf5kBvuR+8yhzckVIHyfUvVLoRLGnuXicGneE+z9Ytq2rxNiMeBSQTUOA3ilaoOFbivQcDMtfzhzJv8VbEe6fDQ2TCrvfGlpYG1xNJSvu5aBTxruY/1MU3CtXp8K+nyLXc6Sy5pwqwIbOGSDPuU1rxZPUB9KLL6sUew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8850.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 14:40:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 14:40:38 +0000
Message-ID: <6fb4564d-3d39-4be1-838c-423a865638b9@siemens.com>
Date: Mon, 5 Aug 2024 16:40:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Process stuck in cobalt_monitor_enter
To: Mauro Salvini <mau.salvi@yahoo.com>
References: <9d5bb262-0646-451e-a5af-82c0473a3003.ref@yahoo.com>
 <9d5bb262-0646-451e-a5af-82c0473a3003@yahoo.com>
 <035a65bc-c064-40c2-9fcc-b3fd6104a233@siemens.com>
 <4572a391-4c06-4aa9-b92e-66e9da6c23ed@yahoo.com>
 <44ffbd9c-fc28-40fd-849f-a77fee15866b@siemens.com>
 <CADBp9x=310edtayP3nEeDSc2D318E=qA1a=5ceG0krd3r2VN8w@mail.gmail.com>
 <87e3bc23-4eba-43c4-bb5e-ffce9139c075@siemens.com>
 <CADBp9xnL46vC0KiYt2MSv+XxYcgb675S5X6geQWSv8KsKG9+xg@mail.gmail.com>
 <CADBp9xn_Gcu9TCaiZHZvo3hwT4JzzTxE4ueMH3dt81KJWF8qOA@mail.gmail.com>
 <67ce5b0a-1013-4ab2-9617-0723c0dc0809@siemens.com>
 <d1b99e9a-5bc6-414c-9f5d-972134f60c31@yahoo.com>
 <bea3518e-5d72-4a86-a5b9-ac71a59c235b@siemens.com>
 <e5efbf9d-9054-46d3-8deb-aa321146068e@yahoo.com>
 <1b8ec985-8ae2-4bd2-8964-23f97cac7ba4@siemens.com>
 <CADBp9xn4OGi99e57phnv58NtCbxzO62bhrkJhSns-FUbbt4_pg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Cc: Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CADBp9xn4OGi99e57phnv58NtCbxzO62bhrkJhSns-FUbbt4_pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: caa8a2a7-44a6-4159-f493-08dcb55c92a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzgvOEtoc3JnWGNsN2JSRlR2TnBsWkkzOFdjSzh3cGsrZFc0ZDErN2l1elhl?=
 =?utf-8?B?Tjg2RTlRUXg0K1Y5VWhVRTdsRjFna0phZjZkUTErU3R1QXJUS2JYTWFWbWZY?=
 =?utf-8?B?dGpTMW9vVmRiTHVmRWN6NmppM0g5Z0RLVVpLSHlObHNwWjVOcWh6N2hPU3Y1?=
 =?utf-8?B?YjdDYVVYeTNqelo2bGhPVjI2REpuTVdycXZPWkgraGZVYWVZcDR5YmVXbGpR?=
 =?utf-8?B?YWRxNlU0aUNFeVlVcjludFk2VXBJYlU4aUlmcjdsVXJnNTJWSGtrWWNCdmM4?=
 =?utf-8?B?LzY3Wk04dmNWTUxSdkczM0xFdDVRZEs1L0FrMVpENmQwOWNsZXpHY2hIWEhY?=
 =?utf-8?B?eDlOdzRzWVdaVFl6UVQ0N1JibXljQVNnR1JURXJDNzBuVFhKVFJFNEVOZ3hp?=
 =?utf-8?B?bXdVTi83eFYwQVpGbU41anlYeHZkL3ZiTk00Q2luaFN4dEZDOXVRNWxTczA1?=
 =?utf-8?B?YXBUVTg4QVVsRGVBZ2RxOS8wbmtTZkV1L2YweVpTa2FFZ1A0cWM2MG5Mby9N?=
 =?utf-8?B?b1ZPQ0pDZndONmlLKy9EOXdqSklsS2lMTlJnZExGL3JWclM2YTg1ZmRFN2wx?=
 =?utf-8?B?OHk5bkRxVnJLVm5TQWFUdkdPV21BM0RoWStkMHhpT1RzSDZhbHdTbm53ckhl?=
 =?utf-8?B?QStsMkFGN2l4cmYxekZoTFZmNjBmeGlhU2VqUFNLYm5PK1NNZmNNSXNXdmlq?=
 =?utf-8?B?QzlSZWV3WklIQkRJS0tuOUpHd1k1MXlHelErVnBEemhWUXFrQ25lN0JnZW1p?=
 =?utf-8?B?MUZheTdpT29ibzNKSmV2SGJwK0ViZFVKKzB3WDh3SUw3Ylh6RDJ0UnpkNzZO?=
 =?utf-8?B?dGtja1NLQ0dtL3NNSjE5S1B0eXhJRk5mN29FTlU4cHlLSVppWGZOcTE3d3V6?=
 =?utf-8?B?azY2bU9nSkx0aWgrNlNldnFGdzFUZWFkc1JHdjV6eVlvZTFoZWYzUE5SMVZ6?=
 =?utf-8?B?QldhenBsY3hWY2I5TTdwZUkwYzNlekdweUc3bldxU2FSRVBsTWRFK2NncUQ2?=
 =?utf-8?B?RnpTNTgyaWZCT2NaWDQzdlJ0eXBjTy93OGFaQVBuOWFDRmpMWjNiVGVCUmZJ?=
 =?utf-8?B?MFRwOVZIRU0rcXNkV3liamRKTTdkRVVoeGJrN0JGcmp1N3d4Rkw4TXovVGZL?=
 =?utf-8?B?cCtzNjNZWnJSUm1aaFR3LzgyZ2R3bDJ1YVVuaEpsKzc1VEtuNUlxbkRVcm9a?=
 =?utf-8?B?RUl2NHdPRjE4NVpKTko2L1dSRjVnSUdkalE1eXhxZ1FTcVV5U2lEamkzQ0hk?=
 =?utf-8?B?WGxBMGhxazIwcTV5TDNKWFRMU01raXd5YWo5a2ZJbTI1NlhVbnFkNnVSK0Fn?=
 =?utf-8?B?OFZiaHNuMjRpcndNeGp5SWhEeW9mYTYwbEh4RnpYZnZ1TG5PS0Z2THQ1V1VV?=
 =?utf-8?B?NjVkNC9TZ1lPR1o0UGxPTS9RaElwSXh5RDM4b250MDFaVER5NUlZS3F1MHlY?=
 =?utf-8?B?S3ljL0Y5ZVdlblkyVWpFMWtPZGZyT2s0TVNoMEVaVSsvdnEzN2YvdUdLbzRw?=
 =?utf-8?B?VHg3ZGIrRTl2ejZ2eEFoMHYyRmtYMmEvR29qbFo0OE1GVUFKcjNhMnlVNkdF?=
 =?utf-8?B?VDl6OFRFMmQzZG5Qb29TVWpNaVNVL0pTN2tGNmhNY1FWcklDWkxXYjR3emVZ?=
 =?utf-8?B?Nmo3NTU2dUlzS3NUQi8vYTg5dmlhRWNXaVFWdERBdUFzZHZkWjBET2oxMEVp?=
 =?utf-8?B?MWNTSmlZWHZacFZSS0JMem10OHNEMk5jUW1KOS9aZlY2S0l1YTlOOHFFMEJ5?=
 =?utf-8?B?U3BOSWhYRE5kVU1lR0pONHRTVTg1bEhLRU8vOWJybWRseDV2S1NCWXFnTHh4?=
 =?utf-8?B?UkJtbmVnMWZKeVRzaG9Ddz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTV3WFgxUWdsaEVQSjl4ZUcyL3dHYmNzL2E2Y2VFV2FtYXRHR3gycThFOW55?=
 =?utf-8?B?SVNFcllwWlJyaXRTSTluWCtzUXVnY0VkVVNwalUyaG1GYUJrOWxPbmFEMDZS?=
 =?utf-8?B?eWhZUGVyWUZ0Vjg0bFdyTjYxZ213cmwvaGYyMXdEZ3ArRk5YRzk4NUtYbXNR?=
 =?utf-8?B?Yk9WWURONkoydXdUc3VVUERtVlBka0ErR3JWM2dZY3k5RUQwbG5QNHhsOUow?=
 =?utf-8?B?S3o4ajJIL1lBcG1wMDJEc00xUWtTR05jM3FQNDhBNHRCK3lVblNMbjVFaXFu?=
 =?utf-8?B?c09RK3ovOEJhSTVtMzVNK05VUEc1QTVBV0xYMFZaUkJWRVRyL2pCZG4yeGJC?=
 =?utf-8?B?YXFXWllOcTBtbkxLS3JXOXhOUjJxSTRmM2t1bUpNVyttRW9UTGpnOHpSZUpZ?=
 =?utf-8?B?WG90eVBjalBLQnB4WnM1RGFTa2VXZzh2M2dVbitOTWFENTYvMFprTzRoVTVh?=
 =?utf-8?B?UFhRQUhUYnlYVGFlVWhUeFR2WGxsQkpvTEowVEVOa1VQcDVvdnZwZk1pSXlm?=
 =?utf-8?B?Y2pacnZvTTEvVkVjNVZzYW8xcm5XdjNjNnFxL3F1RU1BVi9Md0VlZVgrR2po?=
 =?utf-8?B?cWVzVkhkcUkwblllMHY4NjNPVDAzZ08yblJLWTdrTnllUGlJYzBacXd5Y0xN?=
 =?utf-8?B?Z2VzQ1htcEpXZ1pxa203UlFwRUFqRVZTUGZXYnFtV2d0ZEZvU0RqM2ZyRnA1?=
 =?utf-8?B?QnEvNjBzTWZ5UElJUlAvYjJoVnM3QmdaandVZUpTbTNnTzVQaWovTG1Ybjlo?=
 =?utf-8?B?RjR4aEVyb2cwMHhKMG1kTU5SdjQ4YjA5RGQzUk9CVFJwUG1JVTlrYVc4Wnl5?=
 =?utf-8?B?QVpTNVk2UGdLWUxyTFcrbkFiNFlLeTVQRTNGTGpkcEt4ZXJXbVp0cVIrcSsw?=
 =?utf-8?B?bkFId2RFV2dIOXRYNmd3eS9vVmpuNGhnL1JZWG5aSVJmWG92RDdmSmZtd0cv?=
 =?utf-8?B?Nk03Qkk2d0V2SlJXQS9qVG80YTJTU29XTTE1L05QRkZqL3pWL2JMaEh4QU5C?=
 =?utf-8?B?a3JHelA2TUFUcE43clFFTWR4SHExOXdRa3VXNkh0bXh6a04vejMyQW5DKzdz?=
 =?utf-8?B?Si9DWHZFZFZGb2dlb2x0Y2VQU0JkaUlqYmltWFNaNjJURGdKK1loYUFkR3Fx?=
 =?utf-8?B?d3lCTUdTNGFyMW9aNjlSd0RBSnZpZ2dBV2ErcXo5bGFsMDc1NFlnYmJ3NGpx?=
 =?utf-8?B?QUw4Q29LYlJRcDlXQ3FxZHBGa3VmRVdOSEc4b2h1TGpCZGloS3ZCdy90eklQ?=
 =?utf-8?B?R29ZS1VJZjdvOVpjaWg2STN6aDdHS2xyR2FtdUZmVHV3Qms2SStkVDl5elZD?=
 =?utf-8?B?UUVXZU9rN0pxMHU0cEhlcEdJMlpORDJPOFZFVkdnZHZOQlRrdVRsMUpJNU1z?=
 =?utf-8?B?VkhHL0NkeGxEQWpCMThkdFRMZFVCVW9VU0VIV0plNWduNUJBMmFkR1VFTXZy?=
 =?utf-8?B?Ly9FNFdicVVBNHBHRlk1NXBxWGc4TlVRM3J3L01MdHUrVnhWU1VnaDZyR2lu?=
 =?utf-8?B?bDl2NDdLakdzNFdxYTk2aytWeW00eHpoUEZQNGZRTWlqTVprVnJUdk1TeUYv?=
 =?utf-8?B?b1Bic2Z3MEFzQ3oweFp4TmRpZFlHVUZKN0cxc1l1VzdQQXR5RmJLSktVc0Q2?=
 =?utf-8?B?WTZubi9IN3BOM3NPVktiNHY1bFJRSHZ4MG1mSTVaYjNoNE5kZzBsUGo2K3gx?=
 =?utf-8?B?L3ZseVJTdTZueXh4ZEpsRThSTk9oQjM2RUduWWFYeC9PK2xIQjVlT01YN0VO?=
 =?utf-8?B?TGhVWGYzTUdwdDhsbVNzWFZmSVBaYlZraTgzcURmYkdMeW51TENUakdXQkJa?=
 =?utf-8?B?cG9CTG41U0YxazFueSt4OFp2U2dSVytUNWNiMmIveXlJdE1UMVduK0V4U1pi?=
 =?utf-8?B?R0hpMFpHMW9JcVphWUZ3QkVwbDBwT0MvY2Z4cHUxcEhnbS9PZUxqYVdmczBP?=
 =?utf-8?B?SSs1MmNtNFc0Rm1wVjZGa1VRV3pEdElHRTVxR05qa282M1J1WGRkb3h1QkV4?=
 =?utf-8?B?NVJSUzdzdkltVzhGVzdXMjR0YWgzVXB4czlXdVYveWJMU21IVmt1blJhQ2ty?=
 =?utf-8?B?OWVOWXpjVlgvK3NQUDNzMG9kTm1NTUhJajJGTkZwZ0ZmL01Gc2NsRUNSNDk0?=
 =?utf-8?B?a1cvTDFaamtWRmZ2dVlEQnAwWWFrQm1VWW82bVdLZ3F2cUdweG82L0VDcnlk?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa8a2a7-44a6-4159-f493-08dcb55c92a5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 14:40:38.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3lKklFFGCAlR7k/DbNBy1ZXQMBYduXxDzopsede0zWmWAh7wEPvALHqu9pukntzj+1ZM5FItYWQqof2YgBIAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8850

On 05.08.24 16:28, Mauro Salvini wrote:
> Il giorno lun 5 ago 2024 alle ore 14:10 Jan Kiszka
> <jan.kiszka@siemens.com> ha scritto:
>>
>> On 14.03.24 15:22, Mauro S. wrote:
>>> Hi Jan,
>>>
>>> finally I managed to have a piece of code that makes the issue
>>> reproducible. It's not exactly small, but not too big either.
>>> I hope that this makes the issue reproducible also on your test system.
>>>
>>> The zip contains:
>>> - a little main program (test.c)
>>> - a little library (in mylib dir). Some pieces of code are never
>>> reached, but leaved to avoid potential compiler optimizations that could
>>> remove other relevant parts (maybe cycles?)
>>> - a script (build.sh) to build the two components above
>>> - a script to launch the test (start-test.sh)
>>> - the configuration of the kernel in use
>>>
>>> After building the program and the library with build.sh, you can copy
>>> on the target:
>>> - the start-test.sh script
>>> - the built program xeno-test-session-hang-on-exit
>>> - the built library libmylib.so.2.0.0
>>> and create the library link /usr/lib/libmylib.so.2
>>>
>>> Start the test with "./start-test.sh &" and follow what happening with
>>> "tail -f log.txt": after a time that varies from a couple of minutes to
>>> 25-30 minutes, the log should stop on "~~~~~~ RECEIVED SIGINT ~~~~~~"
>>> line: the hang is happened.
>>>
>>> A small recap:
>>> Atom x5-E8000 CPU, Linux 5.4.255 with Ipipe 15, Xenomai 3.2.3.
>>> GCC compiler used: 9.5.0 from Yocto Dunfell 3.1.22
>>
>> Can you only reproduce with this setup, specifically with this compiler
>> version and only on real hardware? If you rather use xenomai-images and
>> qemu/kvm target but still the same kernel and xenomai version, the issue
>> does not occur?
>>
>> I'm trying in kvm right now, also with different compiler. Iit would be
>> good to align / rule out variables if my first setup turns out to be
>> unhelpful.
>>
> 
> Hi Jan,
> 
> Sorry, I never tried on an emulated system like qemu, I did the tests

qemu/kvm - that is CPU-wise not emulated, virtualized. It generally
gives similar execution patterns as on real hardware.

> only on real hardware (using different samples of the same hardware,
> just to exclude hardware problems).
> I can do a test with Xenomai images on real hardware if it would be useful.

That would already be useful to rule out the toolchain as contributor,
yes. When at it, testing in qemu-kvm would also be nice.

> I used also GCC 9.3 (from Yocto Dunfell too), with same result. I can
> share the cross-compiler toolchains in case.
> I saw the problem also using some different Xenomai and kernel
> versions, but always 5.4.x kernels from Xenomai repos and 3.2.x
> Xenomai versions.
> 
>>
>>>
>>> Some potential interesting things:
>>> - seems that application arguments "--session" and "--cpu-affinity" matters
>>> - seems that compilation flags matters
>>
>> Which compilation flags are you referring to? I was using your Makefile
>> now, will that give me the right flags?
> 
> Sorry, I was not clear. Compilation flags that seem to have an impact
> (at least on the frequency with which the problem occurs) are the ones
> related to code optimization
> (like -O3 and -g).
> Compilation flags that are in Makefile I shipped are the "best" ones
> that I found, to get the problem appearing frequently and in a short
> time: then yes, flags in Makefile are the right ones.
> 

OK, perfect.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

