Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E537720DD42
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805568; cv=fail; b=PwyFSvi2Es7IDeNG2DzVUpFiCwwkD1rPz0EQ0tjbKz3JKwEVMLFo2HjgmVQQ2xHhTQC1IVrF2LkmRKHikdwrwjii/p04loGboiL/AwXTT1A7kPZCqPpCScat3B6U2ZBul+Gywl2u4OGkhXt7XU9MJ9PAkTKdnvVbVbvSqxDCVpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805568; c=relaxed/simple;
	bh=auVuOJBB8F+6jTbusJGrprfFE78zecq2Z7tt6xgr99E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P9Dn73Ej0BkPU3ZRkMNC1FPpAQzPi1x0i1iqWq7lVL8MCjeKOUrE/6VtXxmE3KaEmhaDufvyd3ZwW2t66sPXU36Z4gHL2zRUGzx22D6/35XSlm4h2+ZyQ0Gfn6iKk96km7eYKg9pASw7+87QM4QZnK59qgzJfhXhPNuD+Z6DWOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=THVV/y4E; arc=fail smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="THVV/y4E"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 1BEB243C5D
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 13:06:04 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 39841D8065A;
	Thu, 25 Sep 2025 13:06:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJsPigxXy9omS6KK4nzlnNGIgZI5DIcl2MF2DvF6D4BMcg1nn7FEaYLu5KvnVirLT0iRRvf6Qz+cqu7akrme7M3cWNXxWVUbi2IhgIaNekwlxACSlLRoPsrNyxPXHzEOnYhwvzQ9io8Kn0kYXLlyU4oNL+D+txmovGzBKtZljXQoSMJRgV2FJX8MIomkL1cRKBSResE1nuH2IK0y646NYNQuBXVwperHdStNT7QsdiKKwi03KIgcVztMtsYPQbBOCj7Jw3/R+e44yPyABFJMeMzaj1PPbhEEBgctenxGlxvSC/D3q+q/SqF7DfUrv1SoF2Tgr3LpPxbNS6P2tHXg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG7sKAHLk+8ynnOyUL5fY7lVsDZr3XCg06Y0S8TtdMo=;
 b=jf/zXLxFBILUlBEr60sCta7gztQ64OynE2XqWNNMNLAHTcP8R+z06tccIEfTMowKbd91Rjm+TjM/t1pYHIHopMpMBEjM//KrDt9UwXzMwnjqJzdmxPlu4MrpQcTDgRM+lACaIRYwVzSt5AVxJHQpFAO1IqaODTl9GNYsl6hlEfnC/7+qN8mfQcWlN0VrnRLGPlbhLjQorQ/ETSj2uzfwOi1+6bzBZVOoiiPBaZgQurUYMX86SwZhZIlSrTD+ixWJLIf5rfKVVI0Eem0k5BvXHOKlvHYnZaTsfdo2ARJW0b/XJ1DNXqtsK8WNUVNz9eLrFRfr8DL0fugJ3WqbuNGqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG7sKAHLk+8ynnOyUL5fY7lVsDZr3XCg06Y0S8TtdMo=;
 b=THVV/y4EKbN/VHymITH2O2hTOxFf+c/9ZFF9b4z9hh8rH65WdQEfdP2il7fPM4fCc0QzeaHCdUstFFMfSycIxlaBOaOhGT0+2973upOswYmS+UwbN4b7lKHaz0/9TweFP0CbKAPgUZwkYWg8dgpXzuROXx8PHuEwqHHC7fj7HjWlA8+xn9JSkVs5793k6LOiMXHbpHfByLZoj94KBfH6Gqhaak8Pb2vwqj1h7K94JYUuR78+03/43sLp09aSia4+rM15465M+QRuuMztWdDAuVwnMphllnvlE17cVWnF8NtyfEWL8h4cQt6yL7YJJWYa5vJrpQJk5qTG1G/+QE7A+A==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3166.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 13:05:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 13:05:59 +0000
Message-ID: <3485be3c-397f-4d20-aac8-d6a5ca7915ed@siemens.com>
Date: Thu, 25 Sep 2025 15:05:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail 6.1.y-cip][PATCH 1/3] arm64: fpsimd: dovetail:
 Hard-disable interrupts inside fpsimd_save_and_flush_cpu_state
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
References: <cover.1758264904.git.jan.kiszka@siemens.com>
 <b9ecf3458a5c8850edc16b46a8ef67152bd0d197.1758264904.git.jan.kiszka@siemens.com>
 <87bjn1m28m.fsf@xenomai.org>
 <e4b8990c-291d-457b-bf6b-3ca0359310b4@siemens.com>
 <f2339b70d34b7bd4c8e720428d860bc7748aec4d.camel@siemens.com>
 <8359c1ef-1c5c-4f99-877e-12804efc955b@siemens.com>
 <682e1128c6f0450f28db6234c032a3f25ec5d914.camel@siemens.com>
 <ed50d23c-fb0f-413e-b19d-284ee56bc0bd@siemens.com>
 <ab2fb1e6e11e2042c232eb7a5cfd7bd274f744e5.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ab2fb1e6e11e2042c232eb7a5cfd7bd274f744e5.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0027.namprd14.prod.outlook.com
 (2603:10b6:610:60::37) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3166:EE_
X-MS-Office365-Filtering-Correlation-Id: ea193deb-056d-4c3b-91ef-08ddfc34455f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHc1L2dIOGFEU0VRZFJwKzVLYnJTb1hEb0YyUWZWNFdYZ1laWnB0SUZscnF2?=
 =?utf-8?B?ZWhTMmUrK2k4bWdJS0hsdkFydEdGVDJEUXpIZjFyUmNXaVVFa2xBNEJSTmxs?=
 =?utf-8?B?Z1pTZHI1aklqZjFjM09nYzN4L3Q1TmRIWHNaU0NoZjFkQnpUUk5rMzZYV3Fv?=
 =?utf-8?B?MGplZFk3a0RyZ2tmVVluTzN1VzA2U0E3eGNkMXpuUlFvS3orNmtvSG1HQkRv?=
 =?utf-8?B?OExJYkNwc2lNL0dZOE9qRUFIb01ycUY4SUU5NkpFVzV2ck01bk10dVlBbzNn?=
 =?utf-8?B?NEZFL21yNE8yUm9OMGNYSmQxK2hNQjBBNHFiVURzSnU2NE1DN2c3MWtNZmU5?=
 =?utf-8?B?bWRwVzhJS2FWcUp5dHlEMDFnamVzRk1Bang2c09zMEhqajk0TVY3VTdqbER2?=
 =?utf-8?B?bERFdTRTaTU1WlNRV3pETGJDaTZleS9DUkZpMmw5NGNIQ1BtazB6alpqTWdl?=
 =?utf-8?B?TURZNHd5ODhYMXVxNWJjM2djaUw1U1c5aC9CSWpuR2hmODR5K0hWQjlxSG5W?=
 =?utf-8?B?S09GVEVkWGtDNW5ya0RpUkN2WFFPSUphQVZTSk5ML09LTkh3UERYOGxJaEhE?=
 =?utf-8?B?SldaQ2lHMEwzMzRxR0JlOHRHd21UTlJIRFBUd2h2aHoxMFZuSEo4czdqbS92?=
 =?utf-8?B?V2hLNERoVlVkRHh6ZlN6dDNWa3ZmalJpRFpxOVJ1OEZmOEdCcVBhd1dFZVN3?=
 =?utf-8?B?QzcrcEdRRTJ6dFhZZ3VIVFRRRE01dTJIRFlUcXFaekw0TDZkV1FrY2JaTTRq?=
 =?utf-8?B?VmZOZmNSNDhUMld5NXpSZUVUUlZNV3Vtb0t3SzBOblhhWEJrOUtHNWxHejJX?=
 =?utf-8?B?azh3eHZuMnJXMFZxdFU3VVZJSkorSnBxK2hNeDZmcmVVa0xkU1ZOcW9MblNF?=
 =?utf-8?B?WmFTb3g2ek5SNFVmOXN3UndVdU1rQnk3VlBnT3FpNXQ3QXFpbVQrSEd1R0Vl?=
 =?utf-8?B?RVN6aGNYZm5ySmltTTJNYkdrMlRXbXpYckJaRUliVmpZZUc0d2FNeVN4QUky?=
 =?utf-8?B?Rk8relRNSlMvWGJlK1JZL1RFOUNxZ3lrNGtwODU3UXIzYXpaTDY1c3RWOXZs?=
 =?utf-8?B?V3F6bFN1Qkd2UmVvU2ZEYXFYajlyZlJzaktRQ01QZ2Z1SUNIVmhtQVBiRlBO?=
 =?utf-8?B?Unc1cERERTdkN0tMQUtEbHVoWkdsK29obmQ1Z2kyVlhoSlFub2R1Z3g5RDNJ?=
 =?utf-8?B?UHUwOEQvbDk5NDBzT1VkRXJYY1Yrakh4ak1xbEVxMHNrSEZvZXBiNUwxRUt1?=
 =?utf-8?B?WG9KRElWckNmTTI2dnlhak5NOU80VTkrbTcrTUJhNTNUWDRSZDBudndYV2E1?=
 =?utf-8?B?Vzd0N21CclVadUlCbC92Z3BzUXpsZHlMbm1qNlBPS1d2eS9CS1haamNoTmZX?=
 =?utf-8?B?WVJic1hnM01HbGU5WmV5Q2pFNkhsS2Rid0NheThrZExUaDRjT3J6NDQxaDNV?=
 =?utf-8?B?cHZod0JUY05IK2d2KzFSWHNOSC9pek9DNVdUQ1YxZVhVNHZwSDM2Z3RNTkcx?=
 =?utf-8?B?YXRyNGpsazFuMXdBQVJoKzdKK01wZzFYL0xnb1pVNkg5SStoNEhIQ0Q4ZkRr?=
 =?utf-8?B?RWZ6RmkyZzZsVUxuQkJjNENRMHd0akxkcXFZaEN5RWlpOTVsNUwwQ1YrdUhr?=
 =?utf-8?B?QmdtZG8zTTBtUXgyZGJONitYTTZadWhDWGZ1SXNYS1hZTUMydEtGU3VFaUQ3?=
 =?utf-8?B?N1plMWhuTE8zTHBHdHJoa1NUV3ZJVjdBbzdPV1RHOVoxd2J1RFFRKzRhaWpu?=
 =?utf-8?B?czdzMTRKZXhWSzJrT3hocXkzMTI1amN2bkxCeDYzTS9Wa3ZBdllQNC9FbDdp?=
 =?utf-8?B?SUpZSCtGMTJKbnhyR2FscHdHNGpXWVl4Y0JsaG0rNjlvMzYxcVZqbDBtRVVo?=
 =?utf-8?B?dklBRlpNcTdKYjB2dlN1UUlzUHhBSnlnL2J6U3RFcUR1TGE3SW15ZXhoVlFv?=
 =?utf-8?Q?FDEUqoyGTiE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2lhQURHNGpSU3AvWFVKdDNNa2pNWC9EYWpOQXAvVU1mb1Y0WWIyYTF5blhx?=
 =?utf-8?B?WGtrUjVmL0g1bjJxbm1iTjZNZ2tYUDV6T1lKSXNxOVVrNUdFRGg3YUl4RU5D?=
 =?utf-8?B?WnhzZjQ3SWJBdE1lbll4eUUrdjlBaGgyRXJWZDVjSzk5bGh3ZHV1bzNaWW9E?=
 =?utf-8?B?RDBwZWUvTnoybEtDUDNKWTVIYUhHblZUSU50d2xJNWNvRTROYXB4aVcvaTF6?=
 =?utf-8?B?c29KV0ExVlhna210Sit1OTI1RmJDWXFab2tCVHNuOTFlWW1jcmExbkVYakN3?=
 =?utf-8?B?MjNSQmpWK0YvY3NKQTYrWWwydUZwMm9PanVqZWxsc1ZlbEdlUDF3dU0vWGpU?=
 =?utf-8?B?ZXdienBrd29vOVk5MnhoREZXNVpVQVQwMGJWQXdYSUFXeEVybm5HcDNqdHRU?=
 =?utf-8?B?c2Y0YkQxVG0wOCtOdzRVN1VVQm1qUXBBT09FS3ZHTVRvYmhvbzVoUEszR1VC?=
 =?utf-8?B?UVRqMU50S3FBcHRpM05IM2paK0JhU3gyWFJYRHpQQmZKaDhJSjhmZVg3bWR2?=
 =?utf-8?B?UFRXYU92ejAvZTBwZ3RiZDZsRjI1MXp1WVVVZ011UWhYa2tQNUEzRXN4alVD?=
 =?utf-8?B?KzE1Sy82cVJLWFpBbjYyMVBGaUpqVjMwSEhaQStyRlVmUFRibUNVa1lKV3JV?=
 =?utf-8?B?b1B1SHdvanhCSXhvRTlUVmRrWlJRR0ZrSnY0RGlhdXhmVzV3ZEcvYzJMNFNT?=
 =?utf-8?B?dTI3OXJYdXE4WnJXQmh3ekNoaDRwSU16eE9uUDV2SVB2eHdTVUR5UWwvbWtS?=
 =?utf-8?B?T2RlZldEZ3hRVmZtd1FGdHBmcHNyVzQ4M3FxWDA3U2NDNUREZG9mUG9lbUhu?=
 =?utf-8?B?YlFuVXBsN0JuN3BBK25ONWkrcEdhOElRbXFmK1pzTlFmbUJoTXRuVTk2N3c1?=
 =?utf-8?B?blkyMlY3WlpFRXVHYkY0dFVkQXJiYXErY0kxMUIyNzhWaDJET2I2QzVtSTVt?=
 =?utf-8?B?dWpocmFaUzV5eVdlTlAyVHMxNTJSUnpFdzhmTUx1VC9QR0FJenZia3dJYkRF?=
 =?utf-8?B?QWUyVHdhN1dId0diQ1FBOEZDVTY0eFFPSUZpNWFqVE5ySjh0eCtOZGkrRUgr?=
 =?utf-8?B?UlcwTFNvNzFockpOQlFGU0VVWE4vWG1vWnc3TTNiblJ1SndkZElZMDJPQWty?=
 =?utf-8?B?dWQ5cURkN3UydEVxaVBOQWpMMjdqRTNZOXpZcXdkbTBqY2xZYVV6N2Rud0tN?=
 =?utf-8?B?ZXRDR2VEY2J1NW42bEdJaUl4SEZrajJuTHNxUE1McWZjQ0grUWJQMkdPR0Yz?=
 =?utf-8?B?dm5YS3ZKM0hOK0dpcTZhcmo0bEd0RCs0U0VsVGtDSnhSUHY5QVA1RXd3d0pV?=
 =?utf-8?B?Ym1vMnNDb0x0bU1rcG9CRExVTGZrdlN2ZHNxUU1tdjZ1ckkveTMwdjdSNHB5?=
 =?utf-8?B?VUdDdVhSbVhkeW9pOTMxQ3dQa1VkdHZDaE9FUWNkS2FUaTBqMlRQYjhlVmwx?=
 =?utf-8?B?RnhQaG1oRmZtL2k0MWs5VU1OckNSQWlWd2tZSFRVeHFHZWFuWkNDMTQydXZF?=
 =?utf-8?B?UFpVZEt5emVFbm9KYWFqTUIxczg1emdiOGE4Z0JNNjdIRWRYMWRHcW5SWEdH?=
 =?utf-8?B?YUtkY29ubmxSdVdtTGVkN0hSa3NGbjhQQXhNcEtzdUJsRS82dVA4bi91clhY?=
 =?utf-8?B?MDY2ZTliM0xtSTF2RVhKV2NQVFpNS0YxaXcwZDlSNWd6dkZRTVJjY3NzRTBO?=
 =?utf-8?B?SVZjZzVSekh1eUh6dGFuVDVsSEt6UDI4a0NTY3ZPcWVIT2ZDQUZ3aFRGNmgr?=
 =?utf-8?B?WkZISFFobHJJMmprNVhiQUVUd1NMUXZiMVpvTGl1NzFCeUQ1WDUvblQxZldM?=
 =?utf-8?B?Yy82KzFOT3ZCM0h2bFV3TnhpZE5NbS9UcWNqVU1nWlZQTGhOOXZjT1kzYmNw?=
 =?utf-8?B?a0VVYkRwQVdMN0xxdnFaaFN3WmdRTjZJTlNuSFdQUlNKYTJOTzRielVrZGFy?=
 =?utf-8?B?c1lmYkV3OHVMd1RQdDRId000SmRPMnp2OUVyZ2hNdDdYdVVrSDcrS3dTSi9x?=
 =?utf-8?B?TUZaVXJCeHdvQVM0Vys5eWhmSTl4MUJBbjBEanN2VSt4eHNUU2thcmc3dW05?=
 =?utf-8?B?aTFIVlNCMUdHNEFrRWxFV0s0UTFkcFdSRWsyWllSNGRVT09jSTBKWll1RWFB?=
 =?utf-8?B?Y3B1a2xNSE1wd0EwdWtxVDQ0T1lwRVIxQXNjUTBlVlhMMFdXK3dZMGlBWHA2?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea193deb-056d-4c3b-91ef-08ddfc34455f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 13:05:59.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvFRT+u4N0V3p7DoCfpJuYLcCxwCNAGp+cpVOoG5ddzQXyMZbPR2HPEOR+9/NMouimjONa6cGR3WnaK3wh3HTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3166
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b="THVV/y4E";
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:c202::7) smtp.mailfrom=jan.kiszka@siemens.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffffgfuvfevfhfhjggtgfggsehtjeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepleevffdvffdtteegleevtddthfdvkeetieejvdduieegtedtkeehueetteehtedunecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucfkphepvddujedrjedtrddujeekrddvudegpddviedtfeemuddtrgeimedvtdgsmeehkeekmeemudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudegpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

On 25.09.25 15:03, Florian Bezdeka wrote:
> On Thu, 2025-09-25 at 15:00 +0200, Jan Kiszka wrote:
>> On 25.09.25 14:57, Florian Bezdeka wrote:
>>> On Thu, 2025-09-25 at 14:49 +0200, Jan Kiszka wrote:
>>>> On 25.09.25 14:47, Florian Bezdeka wrote:
>>>>> On Thu, 2025-09-25 at 14:40 +0200, Jan Kiszka wrote:
>>>>>> On 23.09.25 20:51, Philippe Gerum wrote:
>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>
>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>
>>>>>>>> Not all callers of this function do that themselves.
>>>>>>>>
>>>>>>>
>>>>>>> Are we 100% sure that kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp()
>>>>>>> would not benefit from doing that themselves precisely, to create an
>>>>>>> atomic section around their internal state change _and_ the fpsimd flush
>>>>>>> op?
>>>>>>
>>>>>> Is kvm on arm64 officially enabled for oob (-preemption), or are we
>>>>>> patching blindly here? If no one was looking at kvm yet, then you might
>>>>>> be right. If it was reviewed already, then this here is just cleaning up.
>>>>>
>>>>> We have
>>>>> https://gitlab.com/Xenomai/linux-dovetail/-/commit/028ad3b2c19ca8a3655577fb34cac7996f166d2a
>>>>>
>>>>> since 6.14 (AFAICT). At the time of writing this was the first kernel
>>>>> release that used in-kernel FPU. Maybe that changed (thanks to
>>>>> backports)? Btw: Which version are we talking about right now? 6.1?
>>>>> 6.12?
>>>>
>>>> All of them.
>>>>
>>>
>>> In case backporting is considered:
>>>
>>> Please also take
>>>
>>> 97cb63af01de ("arm64: fpsimd: dovetail: Align with x86 implementation")
>>>
>>
>> No signed-off - still testing?
> 
> No, just realized that as well. Must be a glitch somewhere in my
> workflow. No idea how that happened. All other patches in the same
> series were fine...
> 
>>
>>> into account. Just a "couple of weeks" old and brings some
>>> optimizations.
>>>
>>
>> That goes to Philippe then.
> 
> Would be nice to know upfront if that would fix the actual problem...
> 

Which problem exactly now? I'm currently juggling so many...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
