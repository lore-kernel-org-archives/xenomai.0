Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011060.outbound.protection.outlook.com [40.107.130.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C354540928B
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525333; cv=fail; b=ng4/40YC7zYDNiI0ggz1+d9cfQSiziglb3uRIKAbXcWAfJHXbAfojQtWhw05O+eCDQ4X1kaRTfruM0bcJRZ3Cc3lOZ3FSL7kY5vSd3F6lvTZ0NiYoEeffaNxnlMlIJI+j82+zcFg2Kae0i/KD4571dfWLvCRFksBPIDmBj+pvNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525333; c=relaxed/simple;
	bh=xdk8GRjcfuFHsAbTIZ92ttQMNIImqL3vlMV09PTn/bw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q+zRcqOb2MlfwUqcGSZ5JlHvfMMl30meR8S/eztFoXsGMK/LZHqyCgdliUqNLp+e448Nc6TH3dIuPBuydmGR7QQItAdkGpRfzfvAZDD8NZdt9FGHefge3/d84TZDYBs2XB3tjbf5Paqv8kom0ikxw9U2DkWJFX5YIruwEpMxjdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kyIUDIEx; arc=fail smtp.client-ip=40.107.130.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kyIUDIEx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8w+edhlm7/D8ibe+UglncyoU6nMh0qgZ+55IIDm07MbqbDMrDw7KI+QFFpoRWkWaS2ks0N30IgZlmIOM3hRYgyoSjeyVQ/sEuqd9QhcF5Qar4p80P5Q7O7Z/0Hdh4yelZA1CpSwZsvCedSoyKdqQtff1IhSBUWwfRG0OTgPm30v7zucGmKIiSY2LnxMqvwQrjegP8TObnlJIhg6JE1jLYWOTrnMBNuzpWSYvPkuXmh02124c6Q6yHxAvtHvSulJMZp36kLzHTG87UROD+Y2ckxhYlUL/KJIercQJN4znC5EBNKIamq6P9OP9ShfnfEfqd9kFB37EfXXceR/SE7/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgEcILQBeGx7A0GfvqJICD7JTc8yDgCRoMjJi5oB4XA=;
 b=zIIih8jR5olqOBmFKXQvMdKWPDAgN8SVok1nz7zX+hPDnsTm1DNpZSyvjlbZayer+6R1fUW9a93vBMUoZsOWYa48EGHLjfU+IJ5bQZz8IiK0hrFUuUlV474V6IXBJp1QVUucS4L1Nv1KpMSmFAc9Xqp+EWHAuuatDUyEO3VdNVUJo4AGsH/o1oNRG0chhPKBCd12F3TFAjii3KVe2+jhqSABzb9hD2N9AjYeIflcDG7/sj2gjy88w+tJD6fE6fGMWJNG54TuexPlVDkT2N0WlANiqsnO6WQShYOfsV+rZ2cAUbLABCl2YT9F46NVc9iRsPxmAd/6Hm8ZvmSQWAiRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgEcILQBeGx7A0GfvqJICD7JTc8yDgCRoMjJi5oB4XA=;
 b=kyIUDIExpRygaHIzj8mi1n6bq69YekmMmWuXDmzUhx2YUxkC8xFDxN+Ix81OBHgsZoQW+cP+97+w3Xh0Cb8uphzgW+u4j28/24/ZYoxW6bRpazCN2S8fA31yogcZo6tjgo2RfmTvhjY9xkmhk69qywpraw4vfFZ7KELOhOVWChpqgT9SC8uhCYIJBPNy9ZamWsoZmLPzfuXtttQ8T5xWKzyxYXhMLeJyc46NY8r8aL2u9LzgWsmajmCKVXQTLcAGQaHPZ9l53//3aWLHrz2F77OYEmhny87G/8u8X9Exw5VGW2Z1lGjkQi4b71VvlbYBn9PwTq86sxgX4R+cxnCjcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM7PR10MB3923.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:172::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 12:35:28 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0339.008; Fri, 4 Sep 2026
 12:35:28 +0000
Message-ID: <fa095f30-c356-4c13-a47c-a0cc177ecfdc@siemens.com>
Date: Fri, 4 Sep 2026 14:35:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Dovetail + EVL: RISC-V + 7.2
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>,
 xenomai@lists.linux.dev
References: <878q5he1ei.fsf@xenomai.org>
 <0b7f0648-2b86-4932-aa12-e70df4da6aad@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <0b7f0648-2b86-4932-aa12-e70df4da6aad@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0281.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::14) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM7PR10MB3923:EE_
X-MS-Office365-Filtering-Correlation-Id: c8452039-6470-40ca-aed2-08df0a810028
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|10067099003|56012099006|11063799006|22082099003|55112099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	USvtP/cC5L/FS6tjJZvvthHkaZlljr2yPzFOG+2wV80gE06lIzsAGKAzLLIY5JAhDQ9Hfqe6+NJXT+b1KE1wthnKOAOtYaZNsBVVPGR1A8xyRbTMbtGPxT4Bm1WPzpGr300rs2DhXP8Id/k0ef1rjPyMtIL9FYQxaSaAV4ux5R/Z4s6yRED4g31iWN1SfAK6tN9mmb9936CgNuzsieE+b9aB2Ki9ePX06cfy6lfadQ6NxlImtjFZcDe0SeAmGjnQI7lprTMk7InSkDIBjHIwTqW89K2fnJ86j/X5ajJhV8I66pSzlf/WmUXciD7LJ0FdadkqGTMJG5wEq80exuPCd+VPMHD5N8iMyAaFOpbgA1RG9UxOcgfAeu0edbm9/AU3xqhBKRNaSB6Gbc2Fib97kGLFmrrS5Uy8FxnzNomLz/+6Z3GSOH6MujmjvPvq4YgDYiWYc/a2D+/EjlTlhs9NKyjUXipPCIbo+i9h+Uvx5hTOO8SiCOCdDiO3DHBNr7MT969yhg4cN9Qup+onfDlvpq5j2jE9m2E7w7ccY0X5nvkSweb1E+TQDlqx3LU51XirHY/lHPmGkCsMq9s9WpgGYDSWnDrQusjKgxKUAzt263KuIpyKwIFl2mamxACmsqe86a506zPWYoNQCHQIR59wsaItYGDQsZl4FsSYCs35+nw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(55112099003)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXRVU1F0Y0JaUTF0ZzA1c3NOeUJqazNUVVVTV010VUJxRHVMamNzVnlFN05l?=
 =?utf-8?B?Zk40V2ZOM3R6eDVTNUtTQ3ZZYytyK0Y0RjlTUFNzaXdFblRNVmVyNEdVYXhh?=
 =?utf-8?B?aUd3RWFhbmVtcnljdlQ3SXIwWmhuUVJnMEk5VzJwbG84RUh6UnJHSkRIRklr?=
 =?utf-8?B?K2VCZisycmJrT1RSeVpGU1VGcENtdGhXQ25QeER6RDVBRURvSk9sdElRc3BI?=
 =?utf-8?B?UWNZbnkrSHd0RnpRK2hOZFpzTTFEZTBWSzVZRlN3b0l4My9jYWdQT1IwcVZV?=
 =?utf-8?B?V2J0b2lTcENQTm44VWVSS1pjUlowN0xWTElYMmlUMmhQSDloakhqQXNlUkQ0?=
 =?utf-8?B?SUNqOEVtcnQ2R1I4TGtyTlRBLytqdHE5TTU2RS9lWUFkam5xemMzYmZhc0RW?=
 =?utf-8?B?Rjg1aFRwdE5LeXRWNmllMUtuZ0lmRlRDL1lic1Z4MC9ONm1zY2R3TlJnL0tO?=
 =?utf-8?B?Y2Uwd0EvaWpOZnpYSmhrYjhkTjdxc25jMVVyTk5JRVJ6Nnl1RUVJOUpIMHk4?=
 =?utf-8?B?TWdabTZ3QTVPR244TTdzNkJhMkpJRUxGNGRnblM4TTgvY0pGcG5YdWxCZm9h?=
 =?utf-8?B?WkZmWjJZTnZWTEszbzZHWEFxbHNHNVBaQlJhemRRdVJ1Ymh4Vnl4TTI2WmdS?=
 =?utf-8?B?alJiWUViUjNGZ3pIS0VZYVRhSWFqZjl1SW9qdmJzZ0FFbXMwRDJ2VVFSRmRO?=
 =?utf-8?B?Uk1odnNkUjNSUXIxN0JSZEtRekJUSWZRYndiT0lzY1dWWXRWVU5WdjU5WkFS?=
 =?utf-8?B?eWd5YnRuK2N3c2JRb0F2am5jUzloSWllMGptZUdWMk9GNllQOE1Da1dWcFhN?=
 =?utf-8?B?TldBemQzOUZNZkFNMjI4OE9JeUJSMncwcDAvczFNVEk0RWZBMTFycG5nRFhT?=
 =?utf-8?B?Umxoc0JGWVNXQkc0b0ZtNC9xVUZBaEQwZ21rS0xSdlpFQzhwMWpReHdvVEJM?=
 =?utf-8?B?OU9ndzlZWFJWYTUvalZKRmVMTU1RM29hazB0K0tJaktiOVJoMnVjV1hMNkRH?=
 =?utf-8?B?OCt4MWVyWVh6Zjdsejg5Tk1TTTFnN0xXenFleUxNQ0dzczhoVEJ6RUt4NWFV?=
 =?utf-8?B?bnRBa3duSDFTenJpSjFjZFd4WDFEdXB5VlUzbEN5WDdMMkpJS0ZGa294aHJY?=
 =?utf-8?B?T0QveVBBZFd4M2RieUt1UHZETTVBWFRwc2FOSjd2bDA0RllwaXdVRk10Vk5Y?=
 =?utf-8?B?ZFNVOEtUSjhFUS9xYTNRc01MZWV4SjFNWnJHNjNrMFdQR3lKTjVERXZ4RE9z?=
 =?utf-8?B?V3FGMGJkVGdhNmgvTTNkRzJ1eWZxSFJwd01CQXBXUG9GdUFTMEFYYzA1WThq?=
 =?utf-8?B?d0EvZEt4clNFa21BZDRUVlAyUldyT1JDM3VBVk9iWXBVTXVReERYcDBodEVU?=
 =?utf-8?B?d0w3TEtkV2lRK0hxOVR0UEo3RXUvTHV2ZUhIakxqelZwSVFZNTZtQzN5WFZK?=
 =?utf-8?B?aGZ3ZFN6NUJFS3BoMmY1UWg2SXM1WEZQelp2NzQxV3lCemhwMk5LVW55K2V1?=
 =?utf-8?B?dWJZWEJlVU04cjhxVS9CeWMySmtSZ1JoM2F1eDJOdzh2aVVzWjdIYnE5SFRj?=
 =?utf-8?B?T2hvQ0JKbE1nOE9hWG01eVdLaTRPR3NUcEJJak45NldqUGExYVpGL2FDQlNB?=
 =?utf-8?B?dlVwZUplbEcxVHk1Z1NXM0hRWDlpWXdVSmFMMklQOWRDWmRaajZjaFdnYmZJ?=
 =?utf-8?B?TFBBSjhDdjJBbGR3WERHM3NvMk01cVRHWXpMRUFNRXh3aCsrOUczU1hnUVpU?=
 =?utf-8?B?SzhZM0pLeHZ1VkwwT1VFN01sVkxJSitVbUpFNzB1bStaVmhYUURSVTI4R3U0?=
 =?utf-8?B?dVhyVzlxaDN4OHBYTGtZYzkxT1Brd1ZGMW1ZTkMxU3ZFTUxwRWI2WkhySGtz?=
 =?utf-8?B?ZVpLdVhld1hhUWQ4TDE3V1dWUUZpaUFHTm5hOUFnUWJlbW50Z1psYisvZ2Qr?=
 =?utf-8?B?MlU1aTFqbXJNajk3Q0MzYldqVDVBUTdSQ1N2Njl5dm1hWHNMbEk5SGI5TTdZ?=
 =?utf-8?B?NWZKZXQ2NUgwbGd6YXd5bmgrQ2hmakVpSGRZZWxkbEpZNVRaZklBVjJoN3R3?=
 =?utf-8?B?dE15M0xsY0pnZjhnU3pCMjNhUkJ1azUyUk10Uy9kZUEzcjFNWnVFOStGQWJI?=
 =?utf-8?B?VFhxa2Zhcmt0NEsxVWw1MXkzdCt0aytNeDh3N1dkNjI3OGtoWTV0UWlWRE16?=
 =?utf-8?B?c2hRbmY4bzN2TmZSRHRkVk04YUw0M1lKTnBWalY1eVloNW1TSXRkb0FEb1dC?=
 =?utf-8?B?T2lHSkNwTTIza2R2UDhwaGVRY25LeXpsSjJjR2liZkNIRE9UNFFabDMvT1Fj?=
 =?utf-8?B?V0U5OC9pREJTb29SYnd1eXhIcnFoS0FybUE4TVcvSTJlcFREejNrdE8wby9w?=
 =?utf-8?Q?oVMMW5GaIkniPMirAbasnSTgjKID1zrwaaCgXGe+RYFME?=
X-MS-Exchange-AntiSpam-MessageData-1: SqimsBiiI2D9yl0HUKkPxiAhTg7BD91f/tE=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8452039-6470-40ca-aed2-08df0a810028
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:35:28.1023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvL0s29Mm+9wMDbtXUAP7RpzlxN5e6dYekwEeFCqbCvdP1/bpuN5U3n1ethE2/lG0shoddhyrE8lU1qCOu/0CqA0zbzXp1P0LytUb0fRybQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3923

On 9/4/26 13:59, Jan Kiszka wrote:
> On 04.09.26 12:50, Philippe Gerum wrote:
>>
>> The (slightly overdue) Dovetail and xenomai4 (aka EVL core)
>> implementation targeting the 7.2 kernel is now available from our
>> development trees [1][2]. Starting from this release, we support the
>> RISC-V architecture, thanks to Tobias's work.
>>
>> Building applications for 7.2 requires libevl r61.
>>
>> [1] https://gitlab.com/Xenomai/linux-dovetail/-/tree/v7.2-dovetail-rebase?ref_type=heads
>> [2]
>> https://gitlab.com/Xenomai/xenomai4/linux-evl/-/tree/v7.2-evl-rebase?ref_type=heads
>>
> 
> Great - and well done, Tobias!

🥳 Thanks for the support everybody!

> Let's see if the pipelines are green now... :)

I will care for the correct branch selection in xenomai-images.

Best,
Tobias

> Jan
> 

