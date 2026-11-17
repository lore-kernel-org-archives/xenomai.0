Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794895591;
	b=NJtpoU1x8KmmxXw+JEt+peQmLZTJi4Z3QRnCgQvsVmDZe+sgXvUIuDxfzv1uEwsVyIAY
	 hCVpF+zsHOEkH1MfZw8zj24cL5BnVipoP7+voq9fRQ/WI6tzidGGhj4qLSEhR67OW20I/
	 0hCFXf/pEX+41q4N3PQFO58tnu4RBhKtpuPiQ5yuH2GSkrdVFQFbMftzVrVrid+FTQR14
	 pFMXkaVAu05CYvQYdkxPVBDbsCZ6HeGQvKAtLD4BaAhUD5wLf2j22XVU+iutk+Vlihl0L
	 +fqrJkLDKsfQA7ikiWpQpu8of7M35kRTv3DcHaSbpu2CGal4DTNN3NEjd0Vq1qAzK2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794895591;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=v9HkrPH1sTbM+/jMYkcFB5tx/z3Emj4wuFq3YVElPM4=;
	b=A2E7VXz56u69Wq9CUYgApUuattaYojbohL58h33q6OXNYFUCekh/VA3uJgoBzWhVQbel
	 ElDq3EPCbXGrClDHIz8t0pzpeJJ6esWao6sMUjwlEQ33fuZHmEJOignjmZa4Gmg0JmtfD
	 vYtHb64aTyTuAhJFBU2acyNc71XFXuje3SqlmpO9VUPjZv0EObvoCRAHqGs5BJeoz1DnH
	 zboeOjnjag782fVt62BBG6+UQl8ETtUVkM//BH3IiTXENX0AMiz0rvmKuxoreDLYQCkpG
	 PnlPffCM3noZw0HDOzcrL6+3AzKGvUx1/Z1aJYTM+pIyGkkIkb6Ilhj57Be1ax8jEbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=hYRdjQBT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.63
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B506606A31C
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 06:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B506606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=hYRdjQBT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7ZhCEp2QFXoQnqIq3NfKXrY8m1N9ATJtgf1zfAYYxGFvf9xf0DfrKjgzBNYsOYXiQzA76rAOdYePEHW72lGOmb2tMrf11wwxxQnufagdKzPb0Pua9/tVxo5tKWBIUBUxDHg59nocQPAlFySAkYV3inhvY+fkBA//eZRlJcwmuwprMY4WFY4G6MFEWsCNt5zzWruTCt3o9VykpBMqlFklmAsC7/YeNfLO4eBE2jTEQE5vMFgvDkEU+/xD1ASq0ZE7B9ltBjUEt1x12hnwMGztKYhAG4e3dYjKlaVPhOdiTKzKQrc3NwWDciaTxx8BN4DeDOeBVUzjuw0vAfnxs0eMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9HkrPH1sTbM+/jMYkcFB5tx/z3Emj4wuFq3YVElPM4=;
 b=UMO+VIj2xV7WJuFl0lvQeqkL6OWxTeiOlaAuEEGLmp6iSGxhSHyj0YCJlVP0U8mnQ95tW5Z/As5mavGFNEGJ84PlB/dTNnWtuY5joscGiapUS2uoRuSxSDrckTWs3CzhjwRxu0K1GLboE2KOJ58khPbttXuaYHTZwj+A8Qkk0GSUyugFoySC4sHokEp1x07OgKeWTj0GOL8AhapiMKvbTaj+zt+SH8EkKAYlPwgZHkOLS+8g82VyDcWOR/Wdu2QjXAqoHhyTT6xJf/scJlm0DQMTGsV9UyWgP98h7ejV1RY2v0XQiPROUsfQ58yJtUpzMvbtTBNALHSSc0q0TQCbZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9HkrPH1sTbM+/jMYkcFB5tx/z3Emj4wuFq3YVElPM4=;
 b=hYRdjQBThYB6nmVnFuKR3xVxt3TYvMQrO7WlGbTAW12rABlifJe1uIAMA3vre9bUet75wNzueyzsblW+vz8f6cKUW9yzMocAJgWnGpmePQI75m+XiKV0SOyG0fkoxG0lYJkPQYw6NZRCn/mjvQ/A/74DsbdaaXaTMKu3SRg2m4gSUDhw6CRqPVNwtBW0+JYjflmdsRk7//WuIlnE900UJGOb+TPFJZ/FkeolEXmwmjPfbYpZP4BmTBsJoDsREEY7p5qE03PxflOvqBUJyyUszwgpuk4AJ2+TvFyeZjvuRCHftffXQkhOpteiMUKjcsmLkxdWTengV4D8/tbMVzElnA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PAXPR10MB5232.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:28d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 06:06:25 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 06:06:25 +0000
Message-ID: <9b439d13-7d33-419d-9d4a-2b224bf5db7d@siemens.com>
Date: Tue, 17 Nov 2026 07:06:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Dovetail 2/2] irq_pipeline: Introduce IRQ_TICK to obsolete
 IRQF_TIMER on tick IRQs
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Cc: Gerte Hoogewerf <ghoogewerf@lmi3d.com>,
 Andrew MacPherson <andrew@elk.audio>
References: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com>
 <20260909-wip-flo-v7-2-irq-cleanup-v1-2-825a908785ae@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260909-wip-flo-v7-2-irq-cleanup-v1-2-825a908785ae@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PAXPR10MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed8de7a-1f7a-4bfa-945d-08df4470e977
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|6133799003|55112099003|5023799004|11063799006|4143699003|56012099006|10067099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261009221727099003|261009221227099003|261009223027099003|261102130727099003|261009223327099003|261009220027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	fpcHRLoetYO6qZV8eXagWmclqb1dKT/hTtN6HhShYMWmsFCA1pRs6iy8+sbBeu9mAHHTDWXU+cqysQaRRA8O2OHaT1eNHA1FY8Ba+JV+4gGl6oPMoRnalpgPDVnORLRnM17PhIY3UHO87h4tFV0z57Vn3PcfMEJK1HXBnfEJExM+OZ2xSR9m81uvd+goehVuNqYo6U4qJ/RfQWKpelKkKVbvgm7Vx4SHLrrUPCYWGVHBAJtbmQayV5wVbkYqVeYMmr6efNpQiw2LId5M2rghJHDn5m7gniFR6H5vNH/y3lusrIIISjmkn7LAecsg6mJQssq9bsc4iXO0yPsv4LOgb2kUx5PQdzVmtEUTRt/tbr+hi45I1lWam+41InjAqZujZkEmFTwTqC129LTXq37Eejb7vdj8uvvVyUCvz+rcoZ34wLqWOjDzoaQeFlt9Pc6C1qqmxV3TiQl5MBoHB1dpQqIqrNnHPF+Wu5WdpP/9JoG+pAH57g92ES8xn29UIvMkpXcD8ekOmfTPMQpyrjozaEyoiSCuJxE/EXLTg27FEE42NclV4tAKuj9m4qMg+IgMCX/nzDFilktiULSloGP/pKuzS5383o3v4ylWrL027zAhwVuR75sm5RNPT+8XI9GrGIKqpk+GwNRgvkxpQx4vZMBGT/wwqzh8witrj4cEczU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(55112099003)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261009221727099003)(261009221227099003)(261009223027099003)(261102130727099003)(261009223327099003)(261009220027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MCtNOVk4ZElTMmJBSjVWV1ZlbG81WE5WbjgzbkRSSnQ4aHo4aTExZWwweWdi?=
 =?utf-8?B?SmIvYXFick1DTDZWRFpFYzd6d1RFc1BIUU5YekV1VWpYVFFVVEJFWVJSUDZY?=
 =?utf-8?B?WE44cDlETFIzejdCZjlCOU5tM0Y3S3hUVWtoU2I2T1BidkRFS2NWV2Uwb1o4?=
 =?utf-8?B?THNSTDJRc0VzR0gxbHFZOXRNTk8xbzZwUi9xaDZUcS90N2o0eUsvWmNxcnVy?=
 =?utf-8?B?MENQa0JKaHo5dUN5TXRmSFllVFBBRXgxblNnZHdKVmhwNHAvNkxLL2FmVkc3?=
 =?utf-8?B?QWZsU3J4ZTVKUjQ2OFpDZmlQWUxqeSthbmthcHpnbjJZV2Y1d3ZLRHBVWmcw?=
 =?utf-8?B?cXNLOW83Z3ppeEczY0NkM2gvTjZSTG96VnptWjhDZFQwQjdCd0tLZ1dTTFlj?=
 =?utf-8?B?VDI0aGpBYXlsMUE2SGc4ZFJtWXRVSU5aM0JWcEtYdXJQUHdOZSs0VjBTYVNw?=
 =?utf-8?B?a29iUkt5OGN0ZUtWYVVzVFpOZnIrcGlFTjEwY3RsRi9URFYwTFZnaEEyT0tB?=
 =?utf-8?B?bmd5azQ2aG91Z1Z1Z2ErSEpLQWFoZytxcEdEZTRoUFNrVFBhREtDcVdMbU5l?=
 =?utf-8?B?RTlWNVc1Q3I4bGw2OG9vb2FtMVdydVFjbnNTL3VVb0lIYVErczlHU3NwWHVT?=
 =?utf-8?B?cXZEeUNPd2pKaTZ3YUlhWHRvQzBoUHF0aEZzM0FQTStJRnBnYjhycENGMDJN?=
 =?utf-8?B?ZFpsZ1FCcklUYlJOZkM2NHJJWG5zb0Jxc0hqeDQvK1MyWkQ3R0tFY1JZUjFI?=
 =?utf-8?B?U045TWRPY1NRRHAya2pKbXczdWZTcDFGbFFnbE4rd293RFVmNVBCWVNONll0?=
 =?utf-8?B?bVAyMWM1THh2L1AzRU4wQXpWM0Z3RHNGS1ZCYlVrZEVFOFhZTWVxWW9ldmpm?=
 =?utf-8?B?Z2dIU2xKYUFVbzVIUDVnNkVOK1l2QUJ6am5CMk5EMUpoVUtaS3hJZ3FkOWl5?=
 =?utf-8?B?SHdaMmhJVGlWb3pNMXpWcjdrdUVWS0dLSWU3b2M3OGsvZ0tqckdyalZuYzFV?=
 =?utf-8?B?VHFhL0xYT0VYbnNac29MT09QeUNGWW42cWtjVmpNSkFlMVRMK0dScmxzUDIr?=
 =?utf-8?B?aytCS3hFcXFUYWRMNWFTdHFKODhyNUd6aUFzTGJvTTVLNEE5WHFBVXQzOVNw?=
 =?utf-8?B?Q01CQzFGZTU0RDB6eERpRVpYaElUd0V6Y1NvS05rV3doeTZacFRWNytwSitv?=
 =?utf-8?B?aUVWMktPcUdIMGgraDkxSnUyeWFoa0Q4MGVYTzI2bEF2b2ZoTnBTUnBPMHQ5?=
 =?utf-8?B?YW1kakdNbklwWGxwZHdkYjlXZVBNMW1NVVdPYXFFN3Zna213WTU1VXZLSkMy?=
 =?utf-8?B?cUI2SDFSSTZYYzVUMG0zT1FkK3VweEpLOG5ua0F0T0NaajNINGNRR09FbjNn?=
 =?utf-8?B?RFFoNnZXUWozMWh3OEhseSs4SGowdENYSWNTdkpmY3lFQ2xVNGVrcXZDZkxs?=
 =?utf-8?B?ZzQvTnk5U2FhUHpqUFV5NTVFc3lwYVNUb2JZMkFVYmJpSmJhUDhybDZFUWFs?=
 =?utf-8?B?WTNQTjl5UUM5RGE0WmdIbVdDaU9EMm9JdGFhQ2Rrc0swSTZCYjVHak5UOFNS?=
 =?utf-8?B?QUpSaWRpNFNSZDZPREd1WXFKY2h4L2xPdXU5Q1ZWcXI1aVd6ZXZmZytGMzUz?=
 =?utf-8?B?K2NER0dFVnBSY2ZvZGJjWTBiUkFWZnlMY2MzMzNJb2hlZVdFUFdzNWJVWGVt?=
 =?utf-8?B?cENWcnJvSllMbDVnd0xRb1k0UVl0aVBaeDFyam5oMHN4aW0zSlFXR0dLdnVi?=
 =?utf-8?B?ekdKNW5sVGwyZlN3WGl4VnBOa2t4MTc1cXZLRXZjSVp4M3p1cVZyZlg1bmxC?=
 =?utf-8?B?Smt0Z0JmS1JnWHJTMnNHK0JsMnFjOFRsNld6SGdQYWMwaUlPT25HSEVERFlJ?=
 =?utf-8?B?cFZVdTFpblFPNzdDWHpNUFB6ZnZKZE02ZTRrd0VFMEsxR1grbXZHbHNjeXg2?=
 =?utf-8?B?L3h0RU9FL0RZb2UwN1BKYjdPRktsT25YM08wZXVxRmJvT0JYb1p1STdJSVRw?=
 =?utf-8?B?eEhxTHN6SDFGaEVvc2ZjdXVoWnVpMWhJRWU4VkJ4c1VBa29naEQyK2FjajBB?=
 =?utf-8?B?K2pXbWJUZ0pHK2NMRVA5VWxjZGtHaC9QMFE0TzRSK1lGMUgyMXhCemxJTFlh?=
 =?utf-8?B?eHhMazk1REdYdzhDK0RaMm4yNk1MdjBNcHU1bmhBR3BVa2o3a3lPQzBPZFR1?=
 =?utf-8?B?bHF2TEt4T1R4dm4zMFRObHBQYWUzanNhVTBNU0dYK21EWjFKMXFoa0E5UTd2?=
 =?utf-8?B?b1FBYWNUZmdpbE13bG9JRG1xanVPTWl0T081cVBIYXU2ZDdha0toQ3lJcUwr?=
 =?utf-8?B?TGtreWF2cG1qWnB6M2NjNXJGTHVRZ0E0RzJZazRGVUdBNUNiNkhvdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed8de7a-1f7a-4bfa-945d-08df4470e977
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:06:25.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPiutrc75kVxQNTfwMndd5wyIsgdM/jLcQCwPnmLg/HPbdNciB2HiPPp7OlU9D4FHx151mVk4n7tyF9l7cJfyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5232

On 09.09.26 16:32, Florian Bezdeka wrote:
> Currently, all clock tick IRQs need to be marked with the IRQF_TIMER
> flag, so that the registers could be saved when handling a pipeline
> entry for timer IRQs / ticks.
> 
> It turned out that it is quite easy to miss that flag when enabling
> the drivers for the pipelining case. In addition, IRQF_TIMER also
> includes setting IRQF_NO_SUSPEND and IRQF_NO_THREAD, which is
> misleading.
> 
> We hook into the clock event device registration now and check for
> the CLOCK_EVT_FEAT_PIPELINE flag on the event device. If this flag
> is set, we mark the underlying IRQ as IRQ_TICK.
> 
> The IRQ_TICK flag is only used for that pipeline internal purpose.
> 
> Suggested-by: Philippe Gerum <rpm@xenomai.org>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/linux/irq.h       | 11 +++++++++--
>  kernel/irq/debug.h        |  1 +
>  kernel/irq/manage.c       | 11 +++++++++++
>  kernel/irq/pipeline.c     |  3 ++-
>  kernel/irq/settings.h     | 17 +++++++++++++++++
>  kernel/time/clockevents.c |  3 +++
>  kernel/time/tick-common.c |  5 +++++
>  7 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index b13e4e90ab18f027e43b4f892ca37ef482a6cf0a..5f7a2c78b3ca7a7a23894f68e16503c785eb5686 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -81,6 +81,7 @@ enum irqchip_irq_state;
>   *                                when pipelining is enabled (CONFIG_IRQ_PIPELINE),
>   *                                regardless of the (virtualized) interrupt state
>   *                                maintained by local_irq_save/disable().
> + * IRQ_TICK                     - Interrupt is a timer tick source.
>   */
>  enum {
>  	IRQ_TYPE_NONE		= 0x00000000,
> @@ -109,14 +110,15 @@ enum {
>  	IRQ_HIDDEN		= (1 << 20),
>  	IRQ_NO_DEBUG		= (1 << 21),
>  	IRQ_OOB			= (1 << 22),
> -	IRQ_RESERVED		= (1 << 23),
> +	IRQ_TICK		= (1 << 23),
> +	IRQ_RESERVED		= (1 << 24),
>  };
>  
>  #define IRQF_MODIFY_MASK	\
>  	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
>  	 IRQ_NOAUTOEN | IRQ_LEVEL | IRQ_NO_BALANCING | \
>  	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
> -	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN | IRQ_OOB)
> +	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN | IRQ_OOB | IRQ_TICK)
>  
>  #define IRQ_NO_BALANCING_MASK	(IRQ_PER_CPU | IRQ_NO_BALANCING)
>  
> @@ -1258,6 +1260,7 @@ static inline struct irq_chip_type *irq_data_get_chip_type(struct irq_data *d)
>  
>  #ifdef CONFIG_IRQ_PIPELINE
>  int irq_switch_oob(unsigned int irq, bool on);
> +void irq_switch_tick(unsigned int irq, bool on);
>  void irq_clear_deferral(struct irq_desc *desc);
>  void irq_clear_forward(struct irq_desc *desc);
>  #else
> @@ -1266,6 +1269,10 @@ static inline int irq_switch_oob(unsigned int irq, bool on)
>  	return 0;
>  }
>  
> +static inline void irq_switch_tick(unsigned int irq, bool on)
> +{
> +}
> +
>  static inline void irq_clear_deferral(struct irq_desc *desc) { }
>  static inline void irq_clear_forward(struct irq_desc *desc) { }
>  #endif	/* !CONFIG_IRQ_PIPELINE */
> diff --git a/kernel/irq/debug.h b/kernel/irq/debug.h
> index 4eafd04a629628553c11d639b4958d5007bbc012..9813c8ec66a447e4acde5ac2ca2fa1f8ab70021b 100644
> --- a/kernel/irq/debug.h
> +++ b/kernel/irq/debug.h
> @@ -34,6 +34,7 @@ static inline void print_irq_desc(unsigned int irq, struct irq_desc *desc)
>  	___P(IRQ_NOTHREAD);
>  	___P(IRQ_NOAUTOEN);
>  	___P(IRQ_OOB);
> +	___P(IRQ_TICK);
>  
>  	___PS(IRQS_AUTODETECT);
>  	___PS(IRQS_REPLAY);
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 1c1920f5fbc083ec299433dcddd4fae53e0d6ce8..a10d1081bea8c8887c61cb3ef5a87b274e1c9e08 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -949,6 +949,17 @@ int irq_switch_oob(unsigned int irq, bool on)
>  }
>  EXPORT_SYMBOL_GPL(irq_switch_oob);
>  
> +void irq_switch_tick(unsigned int irq, bool on)
> +{
> +	scoped_irqdesc_get_and_lock(irq, 0) {
> +		if (on)
> +			irq_settings_set_tick(scoped_irqdesc);
> +		else
> +			irq_settings_clr_tick(scoped_irqdesc);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(irq_switch_tick);
> +
>  #endif /* CONFIG_IRQ_PIPELINE */
>  
>  /*
> diff --git a/kernel/irq/pipeline.c b/kernel/irq/pipeline.c
> index 85ec0cbf5fb1e1fa38dee98d1f79a3ee4ae18774..88911489aeb632a00aab9784407f09ff835f7861 100644
> --- a/kernel/irq/pipeline.c
> +++ b/kernel/irq/pipeline.c
> @@ -1064,8 +1064,9 @@ void copy_timer_regs(struct irq_desc *desc, struct pt_regs *regs)
>  {
>  	struct irq_pipeline_data *p;
>  
> -	if (desc->action == NULL || !(desc->action->flags & __IRQF_TIMER))
> +	if (!irq_settings_is_tick(desc))
>  		return;
> +
>  	/*
>  	 * Given our deferred dispatching model for regular IRQs, we
>  	 * record the preempted context registers only for the latest
> diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
> index 27a37d992f237f6429f58b0b51eb9db39a62e8f7..c4b48d22d271a24e49951c4289784e44090f02dd 100644
> --- a/kernel/irq/settings.h
> +++ b/kernel/irq/settings.h
> @@ -19,6 +19,7 @@ enum {
>  	_IRQ_HIDDEN		= IRQ_HIDDEN,
>  	_IRQ_NO_DEBUG		= IRQ_NO_DEBUG,
>  	_IRQ_OOB		= IRQ_OOB,
> +	_IRQ_TICK		= IRQ_TICK,
>  	_IRQ_PROC_VALID		= IRQ_RESERVED,
>  	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
>  };
> @@ -37,6 +38,7 @@ enum {
>  #define IRQ_HIDDEN		GOT_YOU_MORON
>  #define IRQ_NO_DEBUG		GOT_YOU_MORON
>  #define IRQ_OOB			GOT_YOU_MORON
> +#define IRQ_TICK		GOT_YOU_MORON
>  #define IRQ_RESERVED		GOT_YOU_MORON
>  #undef IRQF_MODIFY_MASK
>  #define IRQF_MODIFY_MASK	GOT_YOU_MORON
> @@ -210,3 +212,18 @@ static inline void irq_settings_set_oob(struct irq_desc *desc)
>  {
>  	desc->status_use_accessors |= _IRQ_OOB;
>  }
> +
> +static inline bool irq_settings_is_tick(struct irq_desc *desc)
> +{
> +	return desc->status_use_accessors & _IRQ_TICK;
> +}
> +
> +static inline void irq_settings_clr_tick(struct irq_desc *desc)
> +{
> +	desc->status_use_accessors &= ~_IRQ_TICK;
> +}
> +
> +static inline void irq_settings_set_tick(struct irq_desc *desc)
> +{
> +	desc->status_use_accessors |= _IRQ_TICK;
> +}
> diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
> index 0ed4122d40986708bd57f32ebf825aef60756f7d..d8d2dd43baaa0053a73bb18764ece562e8b49024 100644
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -12,6 +12,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/smp.h>
> +#include <linux/irq.h>
>  #include <linux/device.h>
>  
>  #include "tick-internal.h"
> @@ -177,6 +178,8 @@ void clockevents_shutdown(struct clock_event_device *dev)
>  	clockevents_switch_state(dev, CLOCK_EVT_STATE_SHUTDOWN);
>  	dev->next_event = KTIME_MAX;
>  	dev->next_event_forced = 0;
> +	if (dev->features & CLOCK_EVT_FEAT_PIPELINE)
> +		irq_switch_tick(dev->irq, false);
>  }
>  
>  /**
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 90fae659e4ea68578a8ab5a739eccc1184ed5ff9..97e3ff40405dfbe670fe45aebdff015163cb6f31 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -12,7 +12,9 @@
>  #include <linux/err.h>
>  #include <linux/hrtimer.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/nmi.h>
> +#include <linux/irq.h>
>  #include <linux/percpu.h>
>  #include <linux/profile.h>
>  #include <linux/sched.h>
> @@ -244,6 +246,9 @@ static void tick_setup_device(struct tick_device *td,
>  	if (!cpumask_equal(newdev->cpumask, cpumask))
>  		irq_set_affinity(newdev->irq, cpumask);
>  
> +	if (newdev->features & CLOCK_EVT_FEAT_PIPELINE)
> +		irq_switch_tick(newdev->irq, true);
> +
>  	/*
>  	 * When global broadcasting is active, check if the current
>  	 * device is registered as a placeholder for broadcast mode.
> 

The LLM is unhappy about this, and I'm still not sure how to fix it
best. This is what it remarks:

"Several paths shut down a tick device and restart it later without
going through tick_setup_device():

 - tick_suspend_local() / tick_resume_local(), on suspend to RAM and
   on suspend to idle (tick_freeze/tick_unfreeze).
 - tick_broadcast_control(TICK_BROADCAST_ON) while the broadcast
   device runs in periodic mode, undone by tick_setup_periodic() on
   TICK_BROADCAST_OFF.

In addition, per-CPU clock event devices share a single interrupt
descriptor, so shutting down the device on one CPU clears the mark
for all CPUs, including those still receiving ticks over it."

The simplest approach would be to refrain from clearing IRQ_TICK
(irq_switch_tick -> irq_enable_tick, no disable anymore). That feels a
bit strange to me, though the LLM claims that it "is harmless". Asking
it to come back with a disabling approach, the LLM had to introduce a
tick usage counter to irq_desc - fairly invasive.

In addition, we now have to keep an eye on clock_event_device::irq to be
properly initialized by all drivers, see my two patches of today. Given
that the goal was to simplify driver conversion, I'm not sure this
change actually achieved it.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
