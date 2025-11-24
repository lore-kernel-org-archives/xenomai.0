Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8091A1F78E6
	for <xenomai@lists.linux.dev>; Mon, 24 Nov 2025 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763967738; cv=fail; b=VgmloMiyDCDTNRMKgGlGWQkHcjdz9ez7XMFNphNtPj07IfCBbbkqaG7cxCv0WJEPKbVhjKC78ZT+pIldwbxw3k/anMiBWxT4/HYw9JNb7Z5pp9rNvMJcfAAaGkwc+n7iBsvjbMXseUkeSm+GRle29KoG/nmXdv4rzZsxz80XUew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763967738; c=relaxed/simple;
	bh=GfQualMczmuL5Nz7SwSZ57CDdKtPwtm/GQ2zpvTqTVk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A94gobZ5TEJtIVTk0KeSR0rycMt2eRwChb8Z248d5OgieYrdrMdYUBufIwoXvzpwbKDAIMalizFu0xVMjziFpUojkWqT7g1zdMZUQb1HtRa3brIZkQjH+ZBEfTI7SEQruZFiPYI0XEoXzkphlTQRHVojnQXHJs3YtUvIH1jHl3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iz5L/Pyc; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iz5L/Pyc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6mS7k8I++ibNm/KovwF2xBvV24kTnaHKsFg6Zt9nKUqNUybyh6dmr0oVQIBM4h591NkRn5hMq5GhD40Pa3lid9knBHWZP4liduQTbPGS3jshO9pgWt7mtFMCDVlUSMXub5RsD7kPYGiHbGYHGflYvNkokvU/NeinF809ESgPGfWQPVGd2BZd+h38+V+Y0ZnDYhn5XgvtJMyjZSlGR86oM3aa8WDU/ZFcZKvkz9T7czsyvc3UI+Yca8n92IpVpXLGGlUMIM5iok14lkkrnMaaq7fso8cxeJZIx0xTyIyZS1uboVpTEwIi5a0JFOwNYgKIxAi0Ptv07wSFnXlspWrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7ZWeuW32asf2ZbmX9jITVdQufu5z5XbNP23UZS74bo=;
 b=BPk8lB1idvmVk2tqfTcX5kifRaxOEmDB7aG1Y2LAY6bi0A0OmuQnhcx6r2LDAuQwTryWC65/JGnYZjkhjn6IMKAA7NQWpRIt1lfqzqJNI6P48MQhn8i2wZ7HYm5uZ896qMMoV3WmmIcZ7S3NhQSxH+XGewuq3b6E0U/hXUYDTA2D9dadDOE5mH7gah0GJgiS5AL4T9YMCFRd94ljU7Tj3f0pnCgk4736tAA2wcqE7jcRGOheLQW5VSVNSqGP3g5hFL6tyfdZDB/7BWNHsULAALiJJtmRsQ5YWwSXn4LXcFcNill9alXX6iP9TzkhF/3zEajaG/fj+R53rOnPkhBm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7ZWeuW32asf2ZbmX9jITVdQufu5z5XbNP23UZS74bo=;
 b=iz5L/PycMGBVXOfRMJDdL2RNqNB/+w1BK58J37nV0rhg0uY22Jrwj8LWu5Y8TYEZeEg5TxjvyIFD+VgsWwRhaIeFWibLO4Sl03WLSOvPlQrH8TnU1JjVAhHqEAdW7THHblMW/2mAuP4V6rr2gfLuEFBWj+clLgSJxTYv66nJfRRBf4MUv4IVfF5aRLg/vHI9jq12EAd3Lh8VNDbMJepwzYFf2DkhYg8+ZeKfBP7Qh3P33iZ4wJvAUMkAiuxPZFf0bUhsmneOaGaU1NyFvBtzkZfACnJ7dJ7Y0d3ROUVIRVocmlxZPFK8z23PNc4SDpYi/txIQA3PkTMV72GatiOmgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7593.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 07:02:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 07:02:10 +0000
Message-ID: <f7d9a1b8-000b-414d-bb79-a4e89e21c293@siemens.com>
Date: Mon, 24 Nov 2025 08:02:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Kernel Porting Query: Xenomai Cobalt on CentOS Stream Kernel
 (Dovetail Patch) - Boot and Latency Issues
To: Noyal Johnson <noyaljohnson455@gmail.com>, xenomai@lists.linux.dev
References: <CAGx0mQ-_=vJh0H9mKrTBjpy9G+H8GHuSGmxJFi=s=nEAfoq=9A@mail.gmail.com>
 <1d41ef2c-11d9-4829-a491-80839ea02b5a@siemens.com>
 <CAGx0mQ8M_ynsrZur6CvownGM2nzhHU9h4q_=GCy0d-DP9QKC0Q@mail.gmail.com>
 <CAGx0mQ9zA9N1Rfp1FxGi-7bUYfynKf9ApQwOZDOPEzJjbGYV6g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAGx0mQ9zA9N1Rfp1FxGi-7bUYfynKf9ApQwOZDOPEzJjbGYV6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0231.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 1209c998-eb7e-4ad7-bcbe-08de2b276382
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzIrc0p6Z25rSWllQW1oc0NiR21xcHRlQnhWWmpLTytUbVorUTlWZittMVor?=
 =?utf-8?B?SDQ0bXFlSmxvSndHMTRlSHlFenRlVHk5TVZpRTdkUjB2YXpQOXA4aWFLdVVE?=
 =?utf-8?B?YjZqelJqb2VCUEtncm15elo5cWwzL2NweG5RQXZsZVkvMnM3Q2c4aExTY1dk?=
 =?utf-8?B?emhNbFhScUVmd1Myd3d3eWVpRnpRZmhYa09NS0N3S2ZhZDk2TU5qdHBtWkpX?=
 =?utf-8?B?bnhXbmR2UUkzVVJLSko2MVJtOXB0bU1LMmVyMDJIbEVJR0t1VGhuNHc3SUdv?=
 =?utf-8?B?OU5ZZEdFbytKV0dLVzlUS0ZtUE02bVJFa1FVeDRhQ2J6TTN1cFFUcmhrVVNN?=
 =?utf-8?B?KzhRd21GMTljR3lGNTlVNXFBdmhyWkVnQVJOTmd0aWxFS2VtUGc2QUlkN1Zn?=
 =?utf-8?B?ZzFrZ0lUY1pmZkR2QlpKa0dxeFZEVkJFZlYrWCtOeE5XcWJCaU83YkY2ZU5N?=
 =?utf-8?B?MFdReDU1YjJyS09BVWw1L2xhN1NFbVcrdmpmcHlwYTZPRGNleUFRSDNaUHgr?=
 =?utf-8?B?b05sTkg0bmZDU1BEUlRiOWplUjd1dy9hMGF6V0hCbjRZdUFYR2pBdk9iUy92?=
 =?utf-8?B?cVZzSFBURHczcW5Gc3JWNThZM1pJOGdmL0UvR3o2ZkR1L0VJWU1nR01IUkdE?=
 =?utf-8?B?b0NGb0twR3FJdkoveG04dkU0Zit6Y2xQN3ZIdjJUNElBY2JoeEE4LzZoNCtW?=
 =?utf-8?B?bDJmRVV4TisrYnFBWm5NV0FydVJvQnJmTG9qV2pSNzFaSnBYcnZyeW9McGNI?=
 =?utf-8?B?ZnJjT1luNDhMTFZjUHQ2aFNIdlVCUUdjS1AyMjVnbzgzdTMvTjN6TzM5bXNk?=
 =?utf-8?B?ak9jcnBFUWpES3pROFozSkROb2xxc3dvcEMwdU1yOENxamxlNFZ4WW91MFox?=
 =?utf-8?B?NXNJeTQyejFUb3NhT0QzbEdJcXFtWDRBcUNsQlRndG52bGFJYXMraHV5WGV6?=
 =?utf-8?B?WGVKNnlwUDQ4WEJZNHlhSUhMcXMxdWg2K3Q1YnlwaGVPR3EvdmxYcytOckRa?=
 =?utf-8?B?a3pmUnZlalBoaGhHaVpxbm90R0J5cEswcmRoUGIvZVQ3Q3ExbEcvVC8zd1By?=
 =?utf-8?B?WHRTSG1Dbmt0SW5MT0Z5OENqS0w4dEMyaktjVE14Q01wSUVnT0ZVMDRSZjJG?=
 =?utf-8?B?SUJObEZuVzYzOEs0REdPN1Z6MVJkM2VFekR5Q0dvc1l0Ti80cEV4YTVsZUhH?=
 =?utf-8?B?M3NHcm42UkNxNzJGWEU5dXNpZGJ5anMzZVRsTHNabkNEak1hZVArcjRVVWN6?=
 =?utf-8?B?eTV3dVRhNDZ3SUMwK0h3UzdaK3hTVUV5RDljWU8xb1FjQktNOURBb2c2QnBC?=
 =?utf-8?B?NjJMcXJKWmlnVGJOSUhHRUFCcERTZEpyVlVwN0N5a2pGaVRjd2Z5TmZQWGVG?=
 =?utf-8?B?cUxvOUZBUlJKcVQ0QitZdG5LYkdhSVQ1ZE1iYk1SL212WlptMmdBdHVFemg5?=
 =?utf-8?B?ZGh1MmNDZmJPU0haYTlnZXNJVGdSOEVVM3lYSVNRWHoyL056SUtyUXlOdDhm?=
 =?utf-8?B?ckV5c1JVR2YvOHZ3UEZOaGJUL244d20wQzIwblhpeEZLS2NjZ3pzZExUQjI5?=
 =?utf-8?B?Zi9IMG01SnpqM2wrS3FIbWlRTlJZTmF3aGtOSllzeHVEZU5wdW9nMmNSWldL?=
 =?utf-8?B?bi92WS9HbkZPaG8vNHNhQ1JmU0JRNUlyMmhRNVFYVWJZd0FPdE5LZVZJNG92?=
 =?utf-8?B?aUJiZTRicUFiRkNkbFVoT1lNTnBBL0xLVG5FaGJQUzJ3M3dsdEYwOTg5T0w3?=
 =?utf-8?B?Q2ZVcFVKblRTOTh0N1NoUzhDNmlJYlEvT0dJMzh5WEI3aU83K1NnRzAzV0gy?=
 =?utf-8?B?NkNQZnRkS3hSQTFNcFd4bW4zcUpNVWhNcmRISFVJQWdiekVzT05NdUxsRkZo?=
 =?utf-8?B?YmdGalNNVjNSU0RJaEVUWC8zNFllUGZkc3MzeGlxTE82NVhzbWNCL0V0eHEv?=
 =?utf-8?Q?TC/8zklSP87IjsbqwZ5nPs8k8D7Xf5vS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXlBeVNIeEVyTjJxZHZNalM0eVlLNkN4V0h1bzZRMk5GejZjbWFSdi9kUGYw?=
 =?utf-8?B?a1dxYXRrS1lZZ09wRjN6akVqeGNiMUdPekVLMU5vTENENi9ueEVnYkI0U2lv?=
 =?utf-8?B?b0tUTE1WYSswajJXNFRBdFlXNk8rN21NYXppUDFFWG55Z0FDTm1Eb1JET01R?=
 =?utf-8?B?RW1kWS84cHJxYkViMUhPVUN6bm1oZHA5UW9OYnV4SjE0ZVVWRHBjYU9oaFdB?=
 =?utf-8?B?N04rUnhHazE2SVMxcEJ0ZHBQNzI0eDVZNjJ6MGNBVWxUN0VZTmQyMG9oMnRq?=
 =?utf-8?B?U1F1MHRpd2I0czlTRnFkUWlneHB2bng4TGlyMmxuRmc1TTV6QmlhNkZxOTh6?=
 =?utf-8?B?K21QQk1RemZKMUNzRkVpdjZDYWp5NmpOTTREMWo5MzhlelRBSXNZRnF4ZmZL?=
 =?utf-8?B?NG5MazU4N1NOOXpZZVQycmM5anQ0MEhjUXRHTitzQWV2ZTMxaEJiMXRSZlBq?=
 =?utf-8?B?ellZbHU5Y2JjRXAwZVZBSlh5TFBxVThQZ1N5SHJjbkpZVEtVNTdsc3NkMU1V?=
 =?utf-8?B?dmhhdWFFSlVHSkUvTmZ2R0k0WkRPakw3OUd2Skl2M2RTYUhpMzhJbWJPaW9G?=
 =?utf-8?B?aXUrVTZlNGtZNHFsMkVXK0Y3c0hYNDEvalFzUFA0TWxpelRUQXcyNmdkL1BU?=
 =?utf-8?B?SGtWZXhtSExVOEpmVlpwMDRxOXpZMFh2SU8vUEczM29IOHIxdy9pcGhLTWsy?=
 =?utf-8?B?VnoxOEZ2MVdQS05UUFFoQzFKamJPWGdWbUZYK2FwMDBqbW5McWRUNXJMNXpQ?=
 =?utf-8?B?UDlJYkNJbDkwYXZlL3pEcVlCUVBXbmRlam1jaHhqNm5oWDRIQUVqSzVxY3hU?=
 =?utf-8?B?VDFSendXV3QwVXMzeldpMGpWZVZHWW5PVTZ1N0VFR3VZZDQ5aUM4Q0VUb0tH?=
 =?utf-8?B?K2oxb2ZDdlFUM1lLWkdKcUNDOFJyUzhha0V4VGRIbzByWktSZVN3WXEyK2Zv?=
 =?utf-8?B?Q2JCOHA3WDFGUXUwNEdRemZ3cXgwQlM1NnA4TEZBaStHak51eERxMWRiNlI0?=
 =?utf-8?B?RGI5YW5WQ0JwTWNHcFJzaFN2Vk9ZYjFZOGJWR2JJVm50T0ZTcXZTMjdESlhv?=
 =?utf-8?B?MWVTQnFKQjB4eGZ1KzAra2JHb004bVFTMm5zQ3h6aVJxNEI2eFR1VEhxVlRp?=
 =?utf-8?B?c3RidllNS3BpajZzVDA1L0tVYTR5eFErcyswUEFFclIyOFdvbVE4a0dRd0t6?=
 =?utf-8?B?RzJPOW5DVUVsTjBCMWFHRkdxaU9nOVVRRG1mRkNhOGNPQ0REM014YXFTN1g0?=
 =?utf-8?B?aWJ3VzBHZXpmb2dBYVVrZFRyT2NRTEhwY1l4bGhHZUd0d1dMMkxoclJQTURF?=
 =?utf-8?B?V2M1NEJwSExxcitOYUJUN2Q4bkRtWnRWcEd3UmNSU0lxdjdpZ09Cc09WTzZL?=
 =?utf-8?B?a0pjbmE4U2R0bkdFblR1K2ViQXh1ZTdRMmZwa1ZkVFVxV2dyd3YwNVRDYmVw?=
 =?utf-8?B?bCtkdlBzSkxhU1pDcUJDUUNQbTNmdUpkdEVialE2eU9rdUR0NXRJQnBNeHlJ?=
 =?utf-8?B?UmpHMmV0S2tkQmZLVmlDZmdLSEdQcEE4dEc4ZGRuS2ZpTTNDZk5NWGJzR25H?=
 =?utf-8?B?Mk1pMHpGTWdSQzBtZzNlcnVlMlEwNDlyZEdyZjZuaHJOdW4zNzFQRURVZWI3?=
 =?utf-8?B?MytrY2h5clRhRitrWlprazlYbGxGWlhZRVhOaWNqOWhRbzR6VnM3TFVrbjNu?=
 =?utf-8?B?RFFSUzBXWkxGZnFwRVdxZVpmeldvZERGWjc5ejZpbFRBU1lRTUp3aUd2VmJQ?=
 =?utf-8?B?WG9QTGxDeGF1ZlVZN0U2a1RWb2xEUlJxanlZaTFDMzl0TkhGL1htTW01Wkdo?=
 =?utf-8?B?bzc2RkNYL0Zac2c2UFBWdjRNYmhlRWJDeXpZdTJhUE1GeW4xeTFnZ1Q4b25u?=
 =?utf-8?B?WEFvY1Q0U25JMXA2czhwRVk2T1Y4RlRTWUpaN1dHVytVN3JWcmxZSFNMOGxP?=
 =?utf-8?B?NVlLUWQ2WFdZdjdPZDJRU2Nuai9QQTNEUENXb2NXZWw1REdEYmFWQ3hnOXQ3?=
 =?utf-8?B?UGtXdEt0MHlwSFlQRDlxY1JsZ2VBMjIzdWR2eGlNSkpVc3ZUNEJlbmN4eHNx?=
 =?utf-8?B?YXFBMjc4RVl5OXhvWDdISUxBb3JWVFhoR2g1Q2thcE9HYlFUVmZ6c2s4VGE0?=
 =?utf-8?Q?Zu+A+EhwMOdcT+qfM7XBzqUfN?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1209c998-eb7e-4ad7-bcbe-08de2b276382
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 07:02:10.8338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHJkn1LSCj7rbex7gCHM5PjikFdYVxPsFzdr2pgiKsI/l90SlPKgRT9kSZElwI3lPI0tCaeoiLwRyDaPkdIAFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7593

Hi Noyal,

please reconfigure your email client to mark citations as such and do not mark your own relies as citations. It's hard to read your reply due to this.

On 24.11.25 06:10, Noyal Johnson wrote:
> 
> Dear Team,
> 
> Thanks for your quick response.
> 
> If you only disabled what the warning recommended
> (CONFIG_ACPI_PROCESSOR, not CONFIG_ACPI), it should boot.
> 
>> Unable to disable CONFIG_ACPI_PROCESSOR because it is marked as [*]
> (built-in). This state is imposed because the option is a dependency of
> both CONFIG_ACPI and the X86 architecture. To attempt to remove this
> configuration, I disabled CONFIG_ACPI, but the dependency persists. I've
> attached the menuconfig screenshot for reference.
> 

This is not correct, see the 6.12 configuration I have:

CONFIG_ACPI_PROCESSOR:
...
 │ Symbol: ACPI_PROCESSOR [=n]
 │ Type  : tristate
 │ Defined at drivers/acpi/Kconfig:287
 │   Prompt: Processor
 │   Depends on: ACPI [=y] && (X86 [=y] || ARM64 || LOONGARCH || RISCV)
 │   Location:
 │     -> Power management and ACPI options
 │       -> ACPI (Advanced Configuration and Power Interface) Support (ACPI [=y])
 │         -> Processor (ACPI_PROCESSOR [=n])
 │ Selects: ACPI_PROCESSOR_IDLE [=n] && ACPI_CPU_FREQ_PSS [=n] && THERMAL [=y]
 │ Selected by [n]:
 │   - X86_INTEL_PSTATE [=n] && CPU_FREQ [=n] && X86 [=y] && ACPI [=y]
 │   - X86_AMD_PSTATE [=n] && CPU_FREQ [=n] && X86 [=y] && ACPI [=y]

As you can see, ACPI is still enabled (required for modern systems), but 
I can freely turn off ACPI_PROCESSOR because also those switches that 
selects it are off.

You can find those information when opening the help menu entry for the 
config.

> Unless you have already a sound understanding how the dovetail patches
> work, how they integrate into the kernel, it is not a good idea to try
> porting them into a heavily modified downstream kernel like the one from
> CentOS. Better stay with a tested recent vanilla dovetail kernel then.
> 
>> Okay, I plan to try the vanilla Linux kernel 6.12.x from the official
> source (linux-6.12.tar.xz on kernel.org <http://kernel.org>). However, I
> also found multiple dovetail 6.12 versions on GitLab. Which of these
> dovetail versions should I use to ensure convenient and effective results?
> 

The latest one (v6.12.55-dovetail1[-rebase] - "rebase" and regular 
releases are identical).

> Sorry, we do not collect those numbers systematically. Rule of thumb:
> any timed-task wakeup latencies between 20 and 50 µs under load are
> reasonable for x86. Anything higher indicates hardware or tuning issues
> (only in rare cases Xenomai bugs).
> 
>> During the xeno-test latency run, I encountered 3 to 5 overruns, a
> maximum latency of 115 μs. Given these results, does the occurrence of
> overruns and this latency value indicate that the system is not meeting
> the real-time benchmark
> 

Likely, but as long as you have the non-recommended powersaving options 
still enabled, it's not yet worth to look for other reasons.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
