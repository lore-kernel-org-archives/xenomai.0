Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013022.outbound.protection.outlook.com [52.101.83.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D354B30B532
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223307; cv=fail; b=adNju1nSHtZtrzM2IdEB2xpy6Y8NF/vkHjPY7ML+WG9KG3doSpxZlohsdUd49YokFasCLhNOEeUnLB+jWsxbhuvucJ3gNYrorAskKAQvg9Km15yU/j0Wj48GtQUVVBUGVy39q44uXU2DM3CMcao8wkzcp0kzgRYMQmWGz52LqT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223307; c=relaxed/simple;
	bh=vMJ/5rLHFMzlrEvK+CEO5UXZLAkaRiDEZb427esxFzs=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NFNewQqQ9/r3HtQfDZ+PwkBDK0B1JLjvR54w+1Srb6uEAKezwEYeDLMJIIfdgrqe1f2jsozhenm+30+Ni6tNTMUVFEA3tW8yvXf+H/0sSx0mAPBPRPOPFX+Fc/Mk5Ku6VWvZhD30xQqGrdfcj+Z4hDxxPHVVXbOUU3CjhQTJ48c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OJMQ4nuZ; arc=fail smtp.client-ip=52.101.83.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OJMQ4nuZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IurH/qbBhMzB8sJJ731UzTOIJJZwBacl4UntPEAhqip+SlQzN1CkvNMN2OKHFhfUsBWRIJxrzHA+7ZY8kBeNn7NnZRDpQsKB1rjOv47MlOzfzH1zKyuLRPlG/mcnh0gAWPOxxPteBTt1F1e6Gu5dvdgm976jPZykQdIsp+ULGPzTfdg44InzPiKmclTGJ8ISWRR6HQS6wkPBI0/v89cjkOvkaNc04MGCxCAkP4iK/YkDEFrp/CGFoCe0C/YO4seBphrHfDcTD2DeOWYkiVkmmP7zS3Rln4E9pfoKhdUVQSdNDUfUjxSQGc8Lf7IfzcmbNpyaePLZtdegYV5Z1901fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyrNeyRxhrXBXdkU/+e077w6vKIXvb9OzmVZ13OwHEA=;
 b=PalhwDiJ5wMwaRs+XVrewZP5JKQBXUWSUL46iIw1BsaWlPxh/9iPX33gsw8DspVGx7xBIbf+Z4mOVytyBMBFLobmxIY1QLfTTeiVX6wqHTcfxt5LpJKi2VbVxnQwaz/YFbVO4EVXEy6ESnfE7QNmcKBnY+nsLiu4DIBoo/z48dZf9ZdKDbnQLG6UJoNFXtK/KneuxkwF9eAHBryHhm48T9gbyuKDeittaPTG6eiZRC+Q7E/O24s+4siyKVlXsScQDIxcWMtff5L5H2crIKs8SPYzKFbBGh5ht4fv6V4dmFazMqLvuPPRM+SouOvAfRGHoXohAKNrAEgFc39VT13Pzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyrNeyRxhrXBXdkU/+e077w6vKIXvb9OzmVZ13OwHEA=;
 b=OJMQ4nuZCTLIkW+MWXr56wdTN0yARTZ8t1TWkQ22cAuDmBw2wuVZq8SBuj1Yx/Na85kxYTobXP9oAoU24zsb7cdB3SLi5v/lS3rLfwlPArIaOWHSRjY4+vlOdribUJWsUPaPiBH8ZW9TkV6Jm2agEmwyfa+w8jOlTpPCWx7jWcB063bhrfWVOBKQ44vi5Dd3on5XslPPja2ptE4KaflD/EfQmr3bY6NvceQe2ldL5zN6llGeDzVV2w7VpAAxUUcRq1wEfd5xaIbCu31Q99w6v0GGz94mg4DlE+JiIXhUzgzLBOfBBKa7xO/yNZMHNzwRhysWZ70lIPCEke2AxYce1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Mon, 12 Jan
 2026 13:08:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 13:08:22 +0000
Message-ID: <290033b7-cf53-49c3-b751-d3ace550fca9@siemens.com>
Date: Mon, 12 Jan 2026 14:08:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v3 3/3] ci: Add CI for linux-dovetail
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260112123349.3945734-1-clara.kowalsky@siemens.com>
 <20260112123349.3945734-4-clara.kowalsky@siemens.com>
 <3b9dcbda-9975-49e5-be30-dd74ced848ba@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3b9dcbda-9975-49e5-be30-dd74ced848ba@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: e5dd9dc9-4bfd-470a-4f17-08de51dba9e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlFKdGRPb3pRL2tvcGRaWWFHa21MSGpOdjNWWVdWOHFLUDFodmVCSGpqam54?=
 =?utf-8?B?MXdya0pBampjSVpITVZXZnpTTyt2TjRDcnhhbDZUajB2RVpFdnhoUS93S2hs?=
 =?utf-8?B?Z25zamkvYWptK3c4cno4REhtY3ZtRXNGNTM2Q05Kc2ZNWEZzUDBCMXQzMUMw?=
 =?utf-8?B?bWVWcVp6ZTU0Q1ovRzNNazQ1bWJqNGMxMW9LQzNCWUJYMVRFYUtteEN4S1hn?=
 =?utf-8?B?VHUrck1KQjRtZlhvbnlHWDFSQWtYWDFTRDh6ckpCaVdNSkUxZ1ltMDNsT1p5?=
 =?utf-8?B?OVJHSGlzOWZyUTEzaWNrUHE5R1JpcHRhREdXQTBDMGxHaW1ORzdkUnFTQ0ta?=
 =?utf-8?B?T0Y0QzU0ZnU3a2RFVVI1N0NMZDh1OEpJYkpoNjFuU0laSmpjSDFjcFo4Y3ZM?=
 =?utf-8?B?OWpKT05JMVZsc28rc21kcmtyK3IrbWtHRTZvZTJzT1Z6VHI2anNoMnk4RzJI?=
 =?utf-8?B?R3FZc0RSK1k4Y2dJTW5pSXNBQUFNaE5wYWNCRCtPZU1GNlVUdEZ3R0xnbDd1?=
 =?utf-8?B?c2RCNHNiaE9Od09VM090V1NUQzFPNDh4N2IvWWt6cDdsSThMOVNUUnRldlAy?=
 =?utf-8?B?MjRqejBHd3pOMUVDYjBYbTcyV0wwUVo3UGFjd2JsRzJGQWV2OTJrOW15ZDky?=
 =?utf-8?B?aE1VREhtMmpPYnVNZTI1dGJ3a2xhRVRBQXdoaTZzMEt2dDZ5VXQxMTBHZ0hD?=
 =?utf-8?B?OG9MOExBVVVKSG9NaSsxbTg2WWJDamRWWFNnMUIycmJQLzI1UHhaZmZrN3Bt?=
 =?utf-8?B?RU5rcHpjRE1Ma2RZYXJRekJiTmU4L0VIR1ZZZElaR2NWeEJwaVJaMlJuemk2?=
 =?utf-8?B?RmFjZnRQenBaWE5CelhaWGVoR3BMckphYldhbDNvTS9xZHNjQ1hZK1k4ZlRy?=
 =?utf-8?B?eW1GR0JyUjJRSXZYdUJ4cFZtckFjRHE0K1ZGTjFsUmZ5Vkl4MUFtQTNPekV6?=
 =?utf-8?B?Y2FidUV1R1c3eXg5TlhvbGdEb0tvMzhta2Q0OWJZMXNldHJLdFBuNFFxZ1hN?=
 =?utf-8?B?VWZpREdMdU9jWnEwdTlaQzA3RXBleFQzUVoxZjBIcjhTYWwrME8yNkRFekxl?=
 =?utf-8?B?MjczdUhjYnFEUzJVK0h2UitSOTF3eGRRbHdvOU0zMEZqNzRjR3ZJaTFibURs?=
 =?utf-8?B?bE5ZdkxQbFhmVVFrYTh1dnkrZW8wY2cyYk4zRTNnNmxRQitLejRjSDZPZTZO?=
 =?utf-8?B?OW1TU0VUbFVBVEZXaEhlSkJ6QUdOVUlTdUJ2YkRuS1JhenJNWnhuTi9xSHVL?=
 =?utf-8?B?eG0rNFoyRWpBTGVrQ0NPM2oxenFsSEdlUlppZVdFUjJ3QTMvVElGL3IwUUgw?=
 =?utf-8?B?U2RocEpnaEppTFNZK1U0Z25QS1BSdXJPRytWOTNsb0FucFk2b0drRytMYmJY?=
 =?utf-8?B?Y1AwWTVLWDZlK0lQWDIyeStRTGFZM0FZcXFEZ1U0VndRQjNVRkVlRjAxcGJh?=
 =?utf-8?B?WUhJSlNRdWpXVkRjalFEQm1GUm9UeG9zU1pqRHlVWG1LdTdLQ1dwcnlKUmlx?=
 =?utf-8?B?TGtXaDdFZGZhMnBZSXJubTBUQTNJVXk3ck51UGhJSWZXSWhhT3VwSEpiN1Fr?=
 =?utf-8?B?M2JhNTM4M1gzbjM3aEc2U2R6WU1lREh4TzF1WGs0NmNRN3V4U29SNCtEQ1Fs?=
 =?utf-8?B?ZU5GN00xbTBmMWVvOUhxbGYrS2lwQ243R2F6VzAvakZxMnYzNnRINXJNNWtM?=
 =?utf-8?B?aklrZStNSzlCOUdaMUo0WXUraEs1d2VraTBKTlNaVmZkUHVLb212RThFMm16?=
 =?utf-8?B?OFdIa01FMlZPQ3ZvUXRFMU1hZlc0NTg3bnpqZ0t0eE02U3MvdnIwMDBlTzhF?=
 =?utf-8?B?ZXFHZG1OU2Z0dFZCcURXa1ZIcDFBRXNvVCttL2JDenNHWG9jM3V3MnpnanVh?=
 =?utf-8?B?dmNHTm5YbzB0OVRGYm9VeFJuL2lLcnJaR3BWYnVlOVBOUDBBbnNjQVJUMTJr?=
 =?utf-8?Q?mrqDwVgOaHj8XcoNHhK6WxAiqbyg8w4p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmhlT0dNNlAzbS8xNng5MXRRY1owQmxOcFA0NHpPSnR3aHlhSVJENTA5WEhp?=
 =?utf-8?B?RGtoM0xXdXFPYlRINzM5MnBETEpHdUtxQWVFVnE1d1RIOFlZNnplQ0lRN09Z?=
 =?utf-8?B?VFJoTmdscjREM0NPRXFGVVVwMGJ5Q0lMU1pHMzZiUUc2TXQ4ckc1b3ZIOFdu?=
 =?utf-8?B?V0xiOFdTNjZQY0MrVkxoeitNa2RWeFlvVnRkRldmcVJiMkNHZUFURjhKMFVM?=
 =?utf-8?B?QTRYMGlBa0J6cGQ5bm5YeFNCNG9NeURoS0ZqbjhvaS80cmlZZUcvRUcrci94?=
 =?utf-8?B?LzhuemN6cHBOQzZ3RGJiSTkvVmhZalJvc01DRWtOVS9pOWZxb1pWdStmWVFQ?=
 =?utf-8?B?NU15b0tLLzJlTXVFYkxKMGRzK3ozYzgzaFhxQ1R5VVN1L3VLcDB5Y1FOVDJu?=
 =?utf-8?B?dW01T3FpdjI0WjFOTTdoV0k1SnpmR3dXY2llQTlMNzJtWTNQM2JHWUpCMTRQ?=
 =?utf-8?B?c1lGNUtqNk5sMlQ2MmpMNFp6Wk1NbE9NZm1xTTBsWEU4ODRqTHNjS1FjMS92?=
 =?utf-8?B?MTVEbTBYd2xCZHpwTVBWZUJkdXdsZTNURjJhTzdMYWV6RGxrUTc0YTdsQXpz?=
 =?utf-8?B?RVljVnVLRVBUOUtxbVRuVCtRZ1BWUnd4SytIdFpmTkhxOG9iYVlxT1d0S0tL?=
 =?utf-8?B?S1pleHM4Z0VSS004cUZNK1AwZHhJdXV5QjVsMEx3VldhS3NaN1FRcElZSUo4?=
 =?utf-8?B?SzVzS01QSldJTEphMmZIMFBXNGEvbWpNVFFXTWo5aDhyamxZUWNsa0NBb3hs?=
 =?utf-8?B?WUJNWXdxa2tpamNpOE85bWl6MXFZNDVTd2d2T0duK1A1cW1iY2thcHprZTBP?=
 =?utf-8?B?enJPbVQzcG44aks3cVlIa1FManBNeHNLWmFmNGR0cHJOWXlZd1E5c1Ztb2sz?=
 =?utf-8?B?azh1OGdWQjZYOHQ0dWdtWlFOVWF4cnFBdENhRTlCZkxFOWM3YUZDbE14SnZG?=
 =?utf-8?B?Q0RvWDlwaUUrOWgyUDYwTUxQZm5yQWlDT1c0Mlc2eXYzSlcrY3Vncm9wQXR3?=
 =?utf-8?B?bHFyd0RxblhtTUNXM3o5Ylk4VFRTMmpMQ3JSRWN5SXJCa3BYd1RsRmtGUTZD?=
 =?utf-8?B?dHZ2TFR6QkxXYkNzSTkvVVFlSm5uTSt2cEt4aGRWWVJCaWNCUkxDRjNabzVQ?=
 =?utf-8?B?cTVEZCs0OGNwWVR5ckI2ZHhNSmRoZ3BvaU8xYjltVDVxbUpXbkxpZUtJRSsy?=
 =?utf-8?B?QnRVWWk0a1htcnFsN0RwMTZiZXRCcjdLeGNicWRWTnFEV3MwMjJFSDh2eVBu?=
 =?utf-8?B?ODlNeVF3alRWWlZmSUMzaWxCQit0Y01Uc3NHUXJnNTZOU0NkZDFnbzIxSmxU?=
 =?utf-8?B?cElyMnZJQUZYVHUzUGNFS2hGR1lHQSthc0lwcXNFREs1V3Exak9TR3Z2MCt3?=
 =?utf-8?B?ZFNFdnVJZlBPSXJDaFYvcWNKSmJLMVFmNVFvdlRsZ0lmNzA0MCtWMHlxTWFs?=
 =?utf-8?B?TUVVUEdpb2p5Q3dlVE00Zkg0YWFyMzRoKytoem5US3hPakxia1BsRkxDRXBC?=
 =?utf-8?B?MkxQdk5hQUtGWEg4YnlHbWtxdTczOUJldlFIR1lwTVNuTnZtcmNqa2R0THhY?=
 =?utf-8?B?RUJOOHJmc1AwbGNpWDl6NnB3T3pwaU9va1F1MmFCVEhXR2xmSEZXd2NNZzBL?=
 =?utf-8?B?aEpiU0tJcHRlV0RyenYzalJxeVpLcEtBOWZCMjdodk4wUFdPR054UVdWZnVH?=
 =?utf-8?B?WkppMzVoRWEvc3l3SnJyaVV1SHBTZ0d0ems4NlRXRUhHemQyanlSdnFzbVR4?=
 =?utf-8?B?T0xITHYzS3VEajRBbkZzRDYxUXdLdjJRZjBnWGFHNGdrMlVmNWF0ZDhFa1lu?=
 =?utf-8?B?TkFnK1VkdmJ4dkxLNzNvclJWZXVSamZHLzZZR1Q5UjdqZjZram9nWkpUcFJO?=
 =?utf-8?B?blFPajQ1VG9xYW9tNW5OS25iQVV2SzJhaVA3R0R5bFZ6UmxIMXhJY3pEbHU2?=
 =?utf-8?B?cC92QU9SMjZDNThwbUwwYnZmY0crZFFtTWtEMHhyaVlrTXFQZjA2a2ErbVFQ?=
 =?utf-8?B?NkFvZ3p3MlpCMGR4Yy9hU2ZxYkxMTVlSekpoL3lYTHoyRWs2a1JTOVAxNEVI?=
 =?utf-8?B?bExQY1hzQzN5UkRBUWl1N0JTMVlwWklsWXdTdm95TmFOam1XOUhUaDlZTjJx?=
 =?utf-8?B?TGJDcVA0czh5U0xnZ3R4MHVyckRyUUN4ajVEazZqNHBGcXZORFFBYnN3RXJF?=
 =?utf-8?B?WkhWc200cWZHYTgxWmg2czMyYnloWnBQWHdFTVByMUVLMTVVWndRc0gxLzFB?=
 =?utf-8?B?YlVCRjQvTUVKQzU4dEhQa21jQ1ljcnNRbHJ3TjlRbWRKWDllV0FoNXl0eWt5?=
 =?utf-8?B?M1Z3M2puR1dRTHpvN0hoaXFnUktDY2pEUjdHNThJM2hIZjlybVBiZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5dd9dc9-4bfd-470a-4f17-08de51dba9e5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:08:22.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yglXnNQZCU949WF5QfLaQ2KfZjnNtDP+o++YVhpQI76CqbrLPOCInfee3cvHb1CNSatvigzBsK/aNFTrr/vQuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7079

On 12.01.26 14:04, Jan Kiszka wrote:
> On 12.01.26 13:33, Clara Kowalsky wrote:
>> The linux-dovetail repo is configured in the CI/CD settings to use as
>> configuration file this file in xenomai-images.
>> This adds a CI job for triggering the xenomai-images CI if new commits
>> are pushed to a supported dovetail branch. By default the
>> build jobs on the physical targets are started for the corresponding dovetail
>> version.
>> By setting KERNEL_VERSION_WITH_QEMU to the dovetail version that
>> triggered the CI, the QEMU build jobs are also always run.
>>
>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>  ci/ci-dovetail.yml | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>  create mode 100644 ci/ci-dovetail.yml
>>
>> diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
>> new file mode 100644
>> index 0000000..c326c97
>> --- /dev/null
>> +++ b/ci/ci-dovetail.yml
>> @@ -0,0 +1,47 @@
>> +#
>> +# Xenomai Real-Time System
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +# This is the CI/CD configuration file of the linux-dovetail repository,
>> +# as configured in its CI/CD settings
> 
> Would be good to describe this - but also the existing trigger structure
> - in the README.md. Given that this does not exist yet for xenomai ->
> xenomai-images, we can also do that on top.
> 
>> +#
>> +
>> +stages:
>> +  - set_vars
>> +  - trigger_xenomai_images
>> +
>> +default:
>> +  image: debian:trixie-slim

I'm also moving this under "set-vars", to clarify the use case.

Jan

>> +
>> +set-vars:
>> +  stage: set_vars
> 
> Missed this:
> 
>   tags:
>    - lava
> 
> is missing here, "lava" to get the smaller runner. We may eventually not
> accept untagged jobs, and then this will stall.
> 
> I'm adding this while merging.
> 
>> +  script:
>> +    - |
>> +      KERNEL_VERSION=$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+\.[0-9]+)(\.y)?-dovetail-rebase$/\1/p' || echo "unknown")
>> +      echo "KERNEL_VERSION: $KERNEL_VERSION"
>> +      { echo "KERNEL_VERSION=$KERNEL_VERSION"; } > vars.env
>> +  artifacts:
>> +    reports:
>> +      dotenv: vars.env
>> +  rules:
>> +    - if: '$CI_COMMIT_BRANCH =~ /^v(5\.(10|15)|6\.(1|12))(\.y)?-dovetail-rebase$/'
>> +
>> +trigger-xenomai-images:
>> +  stage: trigger_xenomai_images
>> +  needs:
>> +    - set-vars
>> +  trigger:
>> +    project: xenomai/xenomai-images
>> +    branch: next
>> +    forward:
>> +      pipeline_variables: true
>> +  variables:
>> +    KERNEL_VERSION: $KERNEL_VERSION
>> +    KERNEL_VERSION_WITH_QEMU: $KERNEL_VERSION
>> +    ONLY_RUN: xenomai-3/dovetail
> 
> Jan
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
