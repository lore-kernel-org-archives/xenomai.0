Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E13211F
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805267; cv=fail; b=c19lCVEamfck+2hFzTHqTivpE2iDwK55zEn3ZuFr5L7I0lhkfqKQ1wqNQ3HxxQ9R6eAN25MuUUa+y88+MeCmAh8KdeO/RuhoLAT+pROcpEDHxAB9/Y428HiG6WYuKlkiwUfQbNByL5FhjAEk7bKZ/YggW7LCYYPW+IKCgVmnMr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805267; c=relaxed/simple;
	bh=qpHRcqI7lhrbQpX0MJX13L14JHoBPbnu54xgm4tOhS4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PgxuiJgg7Y6CBqdxRrELtwKI8T/xIJg3Emw1UClOy9i5iRy1dEeGQB8z2/qeyct1vLx/e+PIaDSAcswhaqBtNT8TUBTabBb3cML3bnUGzr3zZBFUda7JuTsRDV7T5F2dAkV6X589rU2h2oIEA1+D/d84cNeeclCJL5iYcMYiFAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gCw8aykm; arc=fail smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gCw8aykm"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id 257594379B
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 13:01:03 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 84B1574005C;
	Thu, 25 Sep 2025 13:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsDJxveIlrWQdN7eZ98c+D2rUVY1jGPEnCgrqyP087UjdT2524lkJJgPaYBlcooyYA4e0PLhinq5ROwycVIFRB396cXshtIw1mo1zU1Js1bRxYX3Erp0ZQgIMw8Jqa/KK8MUqHYiOTs/8krRbU7KjFct786FU5cpne1OC2IUrHBqeMyzbfy643cWIf5xrCt5spx/mYSJqx3bgDq+LAdcGFm2OIkXxo/TVgQkluwE0v9lBFpUV1dGDdFFtlqYiUMA7dD9WUkQGtDoZ4n3JA4n07vxcuAI04LMXnW7xT/XWemybhqTP5r2w0BptMauRZax6d+5DWHmvoP32kha19sJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0X25mmgZ8m4BtdCahwPdQPwk8D6O63fwJIz+9UgiWhc=;
 b=CtLMpp+iCkpO8MpNLPfE/9hYqSttyHCsZAbFHKYnFsOmHRdEfDBK7n/ts34B6a2B05oidED+QCBmqKNOPw28y92z0l8Iejv4/fnfweckgQaODMyqMvRBkhWc/gqwtmWPmTiuxbmLT4j73jiSSRIXEcB4F4zwq1R2qVxScIfUa4ZCP8j3aUbdmKJ4Mn8VGQG9th6Wm5Bm0UlcLhEkfnQskJXopyDf0WJekMXxGgaP4VqR462ByNXdUr/znk9nXtZudi4VdIDTX5VWWwMQxN6aIyca4/VGzoT07SLWlPgJbm2igEehiNHqCbbVJD7utrsbW0OIIdYlNXNMUV2dak6ewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X25mmgZ8m4BtdCahwPdQPwk8D6O63fwJIz+9UgiWhc=;
 b=gCw8aykmH5Dh5aCyLKburPHno7F0YcDx3kePSSfgVuBt6b8GVZaJlvpkHzqGn7bOCwD5ateC/kmD5FROxp/H+wSj5YYaZiEyZJTRTPVa5c9r7kGHmYwG1Nd92xci+yZuNY8Pae2Z7sv8BVL/FDag42Q/aHO1A8kSuG8vU3R5MO+iZM3I3mdor7/F8EIDUmTd5JqrSAaNs8NL1vZxQ0ksuT5a0VhFZbaotZ8sKj4tjSkPcV+6F/JgXyEh9sw4Rhs/zm5z5wiUWh427yhf5eWH8i6l4tvZbqtWnmrE27PyYOQH2tAf7N1yj6ioA2l0Umwy165cjmamUf+tpgHD3Z4Q8g==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5392.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:48d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 13:00:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 13:00:59 +0000
Message-ID: <ed50d23c-fb0f-413e-b19d-284ee56bc0bd@siemens.com>
Date: Thu, 25 Sep 2025 15:00:55 +0200
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
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <682e1128c6f0450f28db6234c032a3f25ec5d914.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0042.namprd14.prod.outlook.com
 (2603:10b6:610:56::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5392:EE_
X-MS-Office365-Filtering-Correlation-Id: 6743a929-d62e-4a58-6b8e-08ddfc33928d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDVHbXJMWUEvNG95VlJaS3gzRHNuSmdYWDZJUUl3Mk1ldHQ4MStuQXlUa3NS?=
 =?utf-8?B?YzhrU2VrUmphWjYyVUdFN3FIcjNGK3dDVDBiZXFLVEFCZ2JHdnBlOVBtL2xG?=
 =?utf-8?B?TDlISEVFUGZyRzczOENlVThZWk40VUorN2lsMmt3aHlCVSttQlhjVUs0MWw4?=
 =?utf-8?B?a3RqMmk2QVRHb0lxZk1kRGwrTFJwY0lta2hWbG4yMHI1Nmx5SWZuMzJ6VHFB?=
 =?utf-8?B?Vk9VWGJFYkhsV2xrVTU1M3RHcythaUFOMHlmNkZtVVM5MFY0Zkdia09Ganlh?=
 =?utf-8?B?RnVzUzVHWnRHRWJtQjR2d3p2bU1qTXMrMjBsQjZOQ1FIeUcrUU41TXJmbkt1?=
 =?utf-8?B?Uno2VVZyRmx1eW8xSHhvcnhiTUN3K0k3dDQ3WUNzODZYZ2YzL3Vlb3lJSHlL?=
 =?utf-8?B?VzNPM2hlT0lBSmoxUWVDR2R2QTNiQVNOUGJiMXF3blVRdk9ORVVzMk82dmRr?=
 =?utf-8?B?bHZXaWY2YUJXdnhjYkZZMit4aHVHeWdRSFlPd1VEYUZDK3hiNFVCa216THl0?=
 =?utf-8?B?NGE2UERGclJGWVdaR0VrT3ByM3BzbDE1UC9MYXdSYTd4aEg0M3pXMXdXTlpH?=
 =?utf-8?B?a2s1TCtEUjZsU2g3L3lPVlppTEFPYllnNlNIT3AvWlhBYnhqUmpNTi91N2dt?=
 =?utf-8?B?Q2Z6dzZMbWpRb3Q4WnZQTitWL25MTnpVV1RyR0hLR25zSWFsUjk2d1orUWc0?=
 =?utf-8?B?V2lubXdyZitVcXpFejNCUVRQRzNhYk1iRStLeGt2ZWlqSVhkdTNjSHRTWHFT?=
 =?utf-8?B?UmR0WmRSSEMwZmpFdjlJLzc2MHBtczQyT0V6Q2NraW1hVjlzeXN1MmtFU0U3?=
 =?utf-8?B?ZzFjNTFMY3E5TGYwZXNIWmJkWmdTZDZkMFcrbjB3Z2hLaElzQy9ROE43MUJJ?=
 =?utf-8?B?Uyt2NVRac3ptYlhJUTM1dkxiL2JaYVRTejliWXJ3V0k0bjdOL1lzMllZS2Vl?=
 =?utf-8?B?TGdrVmlyMG9BYlUyZ0RBTU96a2t2a2NlUnFDeVhhVVV1Y1IzNEIyZEt0ZlpQ?=
 =?utf-8?B?K2pBdk9jMi9PTUtHNXlWRURQRmZEWlZSVG9tdWVTOU9VR0NaTzc1MmhlVkpN?=
 =?utf-8?B?bWJPWnVIMk5wdTRuNHVmenhDaUpSWHBMa3lXZDFYN3JHTms3WUJEdCtrc1pL?=
 =?utf-8?B?UHVUNzhlRjV6TXpEaWZmTTlWMURBc09HZzBLNzl5YUVVL01tWXJ4WnRVUlpB?=
 =?utf-8?B?cU9MeWJuT09xdXZhZjlSL0xSTkhHbTd3T01FUzN3RUZsWFVqWWRoY3ZTemkw?=
 =?utf-8?B?UHg1MHZqT2xQaUFxVXNSVndrN1ZzUHZoRnVpRlpxWVhtcUJpYXpBVGdySloy?=
 =?utf-8?B?SVpWbGtzSFR3TytWdnNONDMxWDRtZ0hIQWpOeW9oYWg2YlhtcTNXV0M3c0JS?=
 =?utf-8?B?Zy9kdmtwZXdydFNFbVlaSEc2YVZXczBLQlFOTzM0eS90aDZZQStjZDAvai9n?=
 =?utf-8?B?eW5KbTJFeU5BZkZ6cWFEQkJJYmFWbFhReG5MZFFnRXAyRG5ySkE0MTFOY0lw?=
 =?utf-8?B?YVA0eWVvenZRNkdrd1NyeTlzNkxJcGQ0ekJmV01uQzlDYVF4dnJRZkMwNTBQ?=
 =?utf-8?B?d3ZjaVJmVWlUTE82S01lTmxnbFJ3cTdqd0NsUHBCVnlvbHE5aDlRZlpGd2JY?=
 =?utf-8?B?N1hKK3M0UjZQS2RPR3I1ODNZczQzcjFRUE0yU3h3MSt1Z0FxdU9keWdsbE9r?=
 =?utf-8?B?Mmc5M0JRTWRVenZ2bHE0R3M5c2NpRC9KSTgrRkNhUm5jdVJhMkh2SGJrUnhs?=
 =?utf-8?B?WklhNDBvM0NSdTJWM0lGUnY1OE5lOHk5RnA0bVhKT1lDMDluenYrNi9oeHJs?=
 =?utf-8?B?TUdPc0tXU1dOVy9zVGlMdndiYXovS1Fhdmsyek9FQWU1T0lvM2h3STg2UmRB?=
 =?utf-8?B?MzhwVWpwTEVuQzd2VFhmc3hBdmZ5OHdoRzdYK2VKanNmSW4vNkl2Y1lIOTk5?=
 =?utf-8?Q?GVpTPrHPwUE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXBTZEg3dGUwMWlKZ3kzMmU4dzlNckVBUEhadDYyQWJWMWQzNkN4VGlGa0wy?=
 =?utf-8?B?T2Y4RnJ2SEIyVThZQWNBSFRhSDhnWHJoZG1iVlEyblNiL1BaNWFLK0NoZ0Qr?=
 =?utf-8?B?bWdETUpvTVFxVE92TlFqM09KajVjV2Y0Uk9vUXJxVzNtTVp0REZldVdPSlRH?=
 =?utf-8?B?cEtTOWNiY0k0WVJPWFE2T3lvVFF0RGJ3M3NFd25GZlJRYy9yQnVmWHQ4OUtV?=
 =?utf-8?B?YnQvRWd2SkN4RlpmVmVGNCtNc05yMzlIQXlUUWljRXdJTEV3WXlUWVBVSVYw?=
 =?utf-8?B?MDBTc0FybHJPY3VxWHNrcmxGZ01RTGc4VHhYbjdYR0loL25BMHFvQURVT1B5?=
 =?utf-8?B?d3EzQ2Zlc1d3L3A5QTNKaTNsSy96YXdLNnJNaTNORUltcFcxN3dPN21JZktJ?=
 =?utf-8?B?RGdqUTY2NlhKNXNFb3JwWmc2K3lOY3ZGVEJwcm82blhGQXNMK3dxQ0Q0R00z?=
 =?utf-8?B?Szh3Rm5iRHMvUVpRS0Y0Z281RHZCVlRIMVRGK0p2ZGcwY294MXUrZ2lvc0ZH?=
 =?utf-8?B?UVU0S1FGNDRUNXh6OVNxN0p1UFpVMDhFRXJUZ3lTMUswQnRpbHBiT1VrYnV4?=
 =?utf-8?B?cGEvOWtTTVB0MmYzcTBreEIvVy84VzJyVmRNVUJCd1pZVzAyNERTRmJvNzN3?=
 =?utf-8?B?aFZqeVZOQW5EQ1AxTURINmUxeHBHaWhmN0xaZGhXc0Y5bXA5bVRodnZTTU83?=
 =?utf-8?B?VDQ5K0t2YUQ5ajNJM1BzK1NMK29DV3F5cU9OYXF3MTlxS1Y3TmNuVlArTFJw?=
 =?utf-8?B?VnZZSjFaS1RlNzlDRlVtalBiaTdpTDc1L2NYc2RqNXI0VEU0MTNBZDAvSCtD?=
 =?utf-8?B?dG5YdkJlVmErcE81T1pHU05LSk1YazltM1g0MmJBVkVkRTdiTmJsbEt4bGtM?=
 =?utf-8?B?K21ZV0x4a013dnVUTEwzamJzQmc3Y3VqR09KMUVRcHF4V2dCTkRqdklaY0wy?=
 =?utf-8?B?enpqcTNjNlZrZGtyVVZNS3RiUnhvN2NFYmJXNDJhdS9uY1ZXb25FcmFpTDFv?=
 =?utf-8?B?ZlVydllHRWxEWEdrRUR6TjFPaGxkcGxieVNxVk0rZXdIUW9mVE80OFF5dlRF?=
 =?utf-8?B?YmxuQVZaMVlHaDhkNXJIbUN1R0hSeHpOMUt1OERCbHdPSHJWWmRRVk5tazUz?=
 =?utf-8?B?cCsrYzZSaFIyT3RrQmFsdUFyY0hoaklIWGJuTjlwQVRHeFM2ZDN2WkhiNjRW?=
 =?utf-8?B?ZmVZN293OUpRaVloUWlscnFXVy9veE1DYUd4ZGV2TWtwTEZSNEZicWFjUXY2?=
 =?utf-8?B?NHFXTUtDUXRGQlIwZVZzd1hhZTFPQUxjekpmVjU3TXJLWksxQitwTFpTZXE0?=
 =?utf-8?B?eTBGcUVyajdjQWVIdTRCRTRsR3hWQVRnMVErcTJ2Mm9PNXN1NVdERW5lMzFn?=
 =?utf-8?B?OVZCTjQreTFUM1IwOU9IcTBrMHZreHJFZzhNalhtSW1wUVVNSGVHU1RkNmJx?=
 =?utf-8?B?b3BpakVjamRZcllmUm5DK0RENkgvVnZtWTc1Z2Urb245RjlrRzRtZmJpRHFw?=
 =?utf-8?B?YkMyZm9OVG1YbEZkNGZPeTdoSkVnek0vUWErZk9YZTJ1Zm9ZRk0zakpjUlll?=
 =?utf-8?B?TG1ZbVBjNmNVTU1LekEvVnQwTkdEeElNTHNYMDFtczhoTmJja3lOWk56Qm1P?=
 =?utf-8?B?VDhpenRHTHluR1pRZ1hhVUhiZlhwM01pcXkxMkZzc285bGRtckk3MmRqVkdL?=
 =?utf-8?B?U3hHSEpaR05ZL1puNXBzamdHc1hWSm43WU5sL2hJcjhFSGtPZGNoU3dxWDA5?=
 =?utf-8?B?K1pXZlllckdpSEFGK1FXWkZvQnJkeXlNdUFFWndyTkJsYklrSWtPdndXYWhZ?=
 =?utf-8?B?d2M2Q1o5MVloK1Mxc1lna2dnSnp5Q1BJWDBqVFVLQ3ViYitKNzkxeDIzV25Z?=
 =?utf-8?B?VmtwZ3hwcjBwUFJaYWJ5Z1VINFhHWmE3MldJMkF6MXdTRC9DMkp5NFlBaTls?=
 =?utf-8?B?Z0MvZzhCd01tTUFzcWJRdnBjNmlVQ0tNOCswQkJOeHhnRVY5VnQ5MXBja1hJ?=
 =?utf-8?B?em11dnhiWEdSeGRYTnpoZ1QzcmlXSzJWVUJ2czVMSGVUM0pYR2tIWEhhWGpJ?=
 =?utf-8?B?VXlYNkRPNUJwUHovSjF4cHN5bjZPNlRTUzFSZzd1R3o4U1owZEpBTHlSdVM5?=
 =?utf-8?B?bGh2QVJJTk02QklPTTFHWnh0NDBQOVJXWHNqYmFyNHdxdDI1SXdhaXJ6UEl1?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6743a929-d62e-4a58-6b8e-08ddfc33928d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 13:00:59.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Yxb5N0HUSHLU9DbDkk8ZkhAnJ/OQxlwoPZtczIa5XJPgkaquNPmQKG9HStnVuGo66gkYguhmR0OdzCT/JFiZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5392
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=gCw8aykm;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:c201::3) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffffgfuvfevfhfhjggtgfggsehtjeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepleevffdvffdtteegleevtddthfdvkeetieejvdduieegtedtkeehueetteehtedunecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucfkphepvddujedrjedtrddujeekrddvuddupddviedtfeemuddtrgeimedvtdgsmeehkeekmeemudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvuddupdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

On 25.09.25 14:57, Florian Bezdeka wrote:
> On Thu, 2025-09-25 at 14:49 +0200, Jan Kiszka wrote:
>> On 25.09.25 14:47, Florian Bezdeka wrote:
>>> On Thu, 2025-09-25 at 14:40 +0200, Jan Kiszka wrote:
>>>> On 23.09.25 20:51, Philippe Gerum wrote:
>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> Not all callers of this function do that themselves.
>>>>>>
>>>>>
>>>>> Are we 100% sure that kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp()
>>>>> would not benefit from doing that themselves precisely, to create an
>>>>> atomic section around their internal state change _and_ the fpsimd flush
>>>>> op?
>>>>
>>>> Is kvm on arm64 officially enabled for oob (-preemption), or are we
>>>> patching blindly here? If no one was looking at kvm yet, then you might
>>>> be right. If it was reviewed already, then this here is just cleaning up.
>>>
>>> We have
>>> https://gitlab.com/Xenomai/linux-dovetail/-/commit/028ad3b2c19ca8a3655577fb34cac7996f166d2a
>>>
>>> since 6.14 (AFAICT). At the time of writing this was the first kernel
>>> release that used in-kernel FPU. Maybe that changed (thanks to
>>> backports)? Btw: Which version are we talking about right now? 6.1?
>>> 6.12?
>>
>> All of them.
>>
> 
> In case backporting is considered:
> 
> Please also take
> 
> 97cb63af01de ("arm64: fpsimd: dovetail: Align with x86 implementation")
> 

No signed-off - still testing?

> into account. Just a "couple of weeks" old and brings some
> optimizations.
> 

That goes to Philippe then.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
