Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.230
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794483054;
	b=mRGL7rO+4TNbFvsePD7rbh6WahyGgyTOT9GPuL4HYDXgV2mjj98J3+krAL9hvNIQs6ei
	 YbEJba58RPMNq/H+rnVYUGQ0HuwxtJ7aSHN3wf54F3egkGT2i9xtYg6WNOKlYm2pbSdc/
	 9wFmSofvzLi2XNdcaHWZzhVQR6RUGWGoNbYhcuTyzWcc3soyOFMLIhtobvGY5rnMPj06s
	 UuqwzyysXIWiZffL4f64AMKLVrPehSqzU2458/9T2+J1erX8UA3qxIAmy90hxVHo5bWVF
	 SrkNOS5dg2n4qTT21AYwRX9rE7Q5iaTk2iXiqyilc8u+JJG0g8yd1dnm8cuy1ZKYKWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483054;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-GND-Score:
	 X-GND-Cause:X-GND-State;
	bh=TB4ixpYx5/JCHCFVrMXT9pDx96GsZUOZmO9tK+1KeJM=;
	b=g19SZIXmUoetTNUNjtThVyBG48zaVcWwbW+Y0acVx8+K07LxcOpqGkJWN5OwGLQn3Goz
	 Xps7Q3pph5uUCXLfkuYg3iYW1bRYfqXZqnscJ+/bhFOlEN0/Ys8XzBzzKiN1n0cacYP9A
	 MUNdMWyRgP+Dch/p0mFZnbEWPBtBsMbr2ukxb/AgBkjyViY5bWxEf50kraWi5FZpMc+IE
	 6YQ1Y0F7m9SxUDfJgDjxIeMg2igUMcC5twEEDWOKI/EfOnw9gsMZhuFEQ1niYLMxbMuwq
	 ILIgfUIU5zUvPmwZ1TtyMKcriBc7Y40zsDJAYNLKBw8daEo53O6H3Lq6qpUBgqrHtKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=redirect.mail.gandi.net;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=odj4vWkj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=217.70.178.230
Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A5D606A330
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 11:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8A5D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=odj4vWkj
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id EBFE73E95D
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 11:30:50 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 5E5CFC00526;
	Thu, 12 Nov 2026 11:30:50 +0000 (UTC)
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=odj4vWkj;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f403:c200::3 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R97Q1L+6SxHh5IHe3M1m0hE8KJKYtIiTvOKdZtkWqmjx0wHjFGWQH46N4fCJ2GQigPWnvIm+h+OIir0RSV6ZEgwUHWmsGXqkm/oj0RLMnPZDfsWSV3ixMp82MjKtwa6h9nNFuxtqJD4mcpJwOgvd3VBEm83CQa8p8QcOv/0oPoi9MfC+LQ8tmaGrbKyTF6zVoZuih2GHKkYFhVzrTGi8Paom8yKvre5UP7IdHy0G4FZFHHdnoj/N9xzqMGbbyqnPSWx5KVLCWG6gbrjIb2e1fyMX5eVir9pzh/OWo3hOSD7wNH9zuaq9YdIpurDemhysl02A4EBW0vQeuf3Qu6u8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TB4ixpYx5/JCHCFVrMXT9pDx96GsZUOZmO9tK+1KeJM=;
 b=pzhUMxfao79qj/ijjkerlgpyvTVZ1SRLkgbWv7edpunrKJkEjO0BFsL6QDLUJPsi4JvAf84I6ufO7gRomDuHMx9kVJqFgNPosWOoeHrKH7W6XdykFpBKrU6NjYRH7In2gcWXch9byA3YJzxeThFAtHuSQSv4D36DSUDuS7o4xgVUstRvgR02maX0rzbbIB/akd8SgU8rDdNAGFnOA/m7etP3IFtL85MUL2VtYqS9Bdk53UJaOBJ/OpLaD4zP9LJs8wGloTuYHPop9BI/zDpFEfsC4dZF6xK/DST6oxroxro7/nT2FjGfUOqDwuRUIny879+sHjsEIfyjfllFb+jwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TB4ixpYx5/JCHCFVrMXT9pDx96GsZUOZmO9tK+1KeJM=;
 b=odj4vWkj+deLR3l3Ebrr/dfXG6mpH9qIGCbE1Ud4zk6geeGDjmW0HqeKI0PKSQpBjuRyLMbvWf9QVffkTLJjCL5tizwSDeyogKSqnrMIEykqej2DP8Iew4Ff5ygza5ZHnx+k2UNMbGkvOu+riiyK3/aMcIBviu9cZaOErixd+fUsZPEMM8cqTYgfw44RkYDwJvnymygSPIVJmvJamWAUB3opvkayxpXMOVgU7L0h2KNpnLIgeJn5i5p2RZvGhRMMAQL5xy8c5oBlUyOIOSCUf5J+xBBrTZFq/vhyZOZKm8z46DTtqXEi0cOUkiGCeHIoAeCfMQS5waizPhGDK4pOUg==
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PAWPR10MB466209.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:4de::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 11:30:48 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 11:30:48 +0000
Message-ID: <6033b5fe-60d8-4032-ab43-58048673c71e@siemens.com>
Date: Thu, 12 Nov 2026 12:30:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [dovetail][PATCH v2 0/4] ARM trap fixes and generic handling of
 trap nesting
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org
References: <cover.1794399047.git.jan.kiszka@siemens.com>
 <87cxsa2vej.fsf@xenomai.org>
 <f91999aa3245c9e4759abb00d9113712226e884f.camel@siemens.com>
 <383c361e-ca33-4ca5-9619-8baa870ca3ea@siemens.com>
 <339734f5fd22b6c1cd01bb70e3e07d444f121369.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <339734f5fd22b6c1cd01bb70e3e07d444f121369.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::11) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PAWPR10MB466209:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5f9b03-b517-4f2a-d48e-08df40b06675
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|5023799004|11063799006|4143699003|56012099006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	l87EUiUFBoavlVoULuHufmHy0Q5yID1uAhAzU1O4MLgOAtczTqNad/1V9x7MYhAGVkL2d9nIQUUJ3xVvvT9Pc6TdpRqMRw4mP0jB3SmgWFyNDaqSm9dRK3/Y+ko1zFlKoAqcvM2HgF60X0P6kUY14A74uYKwbEiHMdwF+B7tewoVrrsGwitPLyj1X3botfvQ5QCZrAuL3mEi66Gqj33n7u2k7MxElXxl8lBmoGqV9oEMNYpBnOiFMeY0kV0SkimRZeRL09rU9xi8qyHSgDP3S1jawpD8NHQZsszeOHT2fCaQmfEInisGct6G9uDuZ7tWs5AivKpB5V4nS1kzP05r1t8zLdzyVm/2Jrirykk6Dp4bdhQEneKBnqwabzTr+j2HW+Fpb5+YkgNblQCcmv3zStc+C9EL3RtARnsAOBJolYXt2NmoTs6yrWTt6YTm45VGLEoGBx/5T5LUZqt3t9/iXXG3lFnephyb8ZONsJVxC/gHYurYqW81KUFi8SBuJp8aJPSBnHFMgaRNqLM5sKPhG8NOsIGlPw+3u6w77aLv3V3wU5u1emEfe3J/gkSD7eBl0kI3OXmSuabya+PgLsf3tUpOq7fa9jYq++gbbfNdWXfZZRQvyP/fkoa/twN1aE5ycQyrGLhUtULZIMbQ4z9DdQavYdNFzN+Xa9Nie55+b/4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SksyVnRUQVRYSkxLR3BoUENscHJodWN4VzZrd2hBMGtVU05CRlZWczdOcmxv?=
 =?utf-8?B?U3RLcjZwOENTVUlYZnlYZWFEa0lnbGZORERJaFJ1L2FRQnRVR0dSeDF4bmVH?=
 =?utf-8?B?NDI3TEVRZ3YwZ0pzZHVRUHgzU2FtQlcwSW9GMXBub0ljTUZuMDdsVDI2cUpn?=
 =?utf-8?B?cjBxOStMWFBvcm1ncExLQXVMNFNUcDErL3JWWStDQjM2VlMvRzc3SEpaNzBH?=
 =?utf-8?B?WWJubG9BcWZldHZEZ0dnaE1HbDZQcHI3eEVhZXpmc3E5eG5HUFlZR0V0VTZD?=
 =?utf-8?B?SnUvSXloeG9CdGZkSzJ6YUZyZmdOOEVTSVR0ekRldEpVU1BCZVJ5cGUzZ3Z6?=
 =?utf-8?B?d2FNdUcwWi80RTc0Qml0TDlES2VVVng5c3FGZTdkZUpzK29yQ0hhS083SXE1?=
 =?utf-8?B?L2tPelIzV0hwaVZSamVyM3ZuM3BTUGM4a1hBTkdWbEJMRVdwU0l2K0ZwZ2tr?=
 =?utf-8?B?eG1TWkI3ZDNqSWprYkJyRVZtNG9zZUFNT1RRQnVZa2JLYmJEZklvTXJweFU0?=
 =?utf-8?B?bzFsdHVqb2dFS24xZTljNzd1aFpqNC85ZFNtMHk5elFGclMyNHExYXpJSGZB?=
 =?utf-8?B?Tlp0eEVGSUlDTUFLTkIzMnI1N3poQTZLVlFKYUNxQlZrcHlOeXo5WTNERDVs?=
 =?utf-8?B?ak94cUh1VGphZ0JOcEYwQlRNZVNWdDYza0NnVzc2VTIzZHF5L3V1SG9rOXc2?=
 =?utf-8?B?TzJrSE9TUzlBeXpjZjR1Z2Q3QUdTaTRWZXJpS0hNajlQR0lUVFIwYndtcE9N?=
 =?utf-8?B?YXEySjhtL3FjTm9pL1lIVGo2dVBCYjI0MVAxOXV2RVljOFlFMFZBMDc5ZHFt?=
 =?utf-8?B?eVduNmhweVo0emxwU282eUcxdXA5dmJDKzlpYjlqRFVTdGYyUWJTQ3hlMC9G?=
 =?utf-8?B?bjVENTdOYzh5QmduWFVxN0JtY0pUSDZKUk12d0FOeFlZUGx5MUxMSjRpblll?=
 =?utf-8?B?ZW1XS1Y1UjltelM4bzRXMXVzT3FEcDJmQmVHVEFPaEpNVkcrTFA5bXZmM2tP?=
 =?utf-8?B?YUY3R2FXNHVpVUU3RldldW1Zcmg5ZjlPNU8xam9ybk95ZjZkSTBYQzRsLzUx?=
 =?utf-8?B?aHN3b1dXV3dOTDhpemlJUi9RbnNTa0pJYTJydCtxVTNVNjh5M1pzNUZsUVNZ?=
 =?utf-8?B?SnFUNkZIWnlkdEpqUkhPNnFBcmFScVZPcHovRjFRWmZUcVZNcVRPdC9tcllK?=
 =?utf-8?B?MVpQcWZOZGZoeEVTWVhHOTNNQUNFRjN5czVtZUxYalpnSTJ0ZWsyMUZ5Ykxh?=
 =?utf-8?B?bmlqcVFIT2NGUlpBQTEyZ0dVaXI2WW5kV3NvSHZjTmROQU5OeEkwcytRaVBE?=
 =?utf-8?B?WFBOSGFjMUJUb0RxeU5wMXJKeksvcGgrNmV6aHY3QTk2SURMVVArdE4vTjl5?=
 =?utf-8?B?V25tcnJ1SjVjOEpGL2hScXNUbVhKQ001N3dVSW5tdkV3YUtLYTBSV2Q5Qlcr?=
 =?utf-8?B?aGlkM3lWR0gyZG5PLzFwMU9GbGhPYmFkR1VyNlZwdEMyTXlwbUFyMjNBL0tW?=
 =?utf-8?B?ZjlZTys4ejY2YjNNZWRLU3ozT2JnUm4wU3FsM1J0bzRXRVA2ZEExbVl5aDdH?=
 =?utf-8?B?SGxFTGhkVVI2SUQwVHRBTUtpMmZvUlVOTCtNVVRFVVJsTVBPaW93OVdTT3R4?=
 =?utf-8?B?TmhrQnFqTFhRa05DZHorVGNlWVJEeE1RaStObHVQSTlORnYwQ1pvN1M2V204?=
 =?utf-8?B?c1JuYjNNRjZqaVRublZhZk55YnRaY3hnQmh2djlsbzJwcjc2MTlGL3ByMDBP?=
 =?utf-8?B?MmxTSXlyOVNaaWVhZnhSMFdOTnZQMTliUk52NzZoTUhZRjhSUTYzaVRqM2FG?=
 =?utf-8?B?NWRmaC94TGx4bWdpaW1md2V6ZXM4ODViVTZVOFJ4cXFSMjJsOHFBVXczTk1y?=
 =?utf-8?B?WjhjRUZOYmFkTkZhOEJVN1NqRytDWDM3Y0QyTjd2TlU2K2Z0dS81RU9vSzZE?=
 =?utf-8?B?Q1ozNytadkVpMHlFaTJ1YVZhTDZSWFNENXlwb3ZRTk1sR0MzN09rMitDTUlZ?=
 =?utf-8?B?NXEvNTlVb3hJOExCOWdTWk5kRUJBMEd3NDk3TWQwdDJLaDFyMmdjVzNGbGxX?=
 =?utf-8?B?dUhPd2hmUGwxaStCWlM1NnJ0V1hrN2w0YUw3U1YxNlFuSzhHajZOb080UVh1?=
 =?utf-8?B?WEE5cGJZZFE2ejZQblF0bC91U3dOZlNEVnd0TzBLKzJubFNRVWRXbzlNODZS?=
 =?utf-8?B?cXhGbU40T1B6NHZIcVcrSDEzYnR2UW9haFpjZ3BFY1Q2T2srRnRPVW95OXc1?=
 =?utf-8?B?MnNsRDZCQ2t4aElwZzlseUFaNTgvVVRCSGsvTXBlc3VNT1VpRnJZNjRSUXU3?=
 =?utf-8?B?L29wWTJHM2tuZjFwNGMwZG5ONmtudW9XSWFTdXRrVjVDTjVJMnN3dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5f9b03-b517-4f2a-d48e-08df40b06675
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 11:30:48.8243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rj2UUH53yLcLcbzrHjkHoqtLCnMWNqPUFnfp7QpVrMsGyc0LkWTNG/PSaXF8qUC0hCzaSERPTEJKHhM9zwe2uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB466209
X-GND-Score: -100
X-GND-Cause: dmFkZTFcnhCWB4D6leT6MLtAGkDUHmh0sEY1hmURyf2dlHttEwNKqHl9T7jNbWohkXTj8nqH1CStI17JIG670g0Dco/AiRje1DN7LJHW11qdJ+x4RGXrLwCKBSb2JwCs9UX/uP9tjOo4FkGRZGLlCSTkoJydg/mpBZP0fha+kI0YeMCUUP0U1xGjCuAQ+W5hCiyfR3RZcvr2A+QWHEH1XbuK0iFb+CxqbGLU6c6ypsHVjKZYO4mQFLb31larofdNiuj3z10XxDcg0j+3tQYJsEyjbDhncLFwMvdODREVWypAPROtK6/i8zThS6RJAdSdRjZr8XVGFlrIsgYx5mI7KiG2cIE/Vu8sFDnjq2foIBlUDTcS0IWk68G9fvI4F1QMBcuWQ+lFc5PIAUwmgfPRBc/lTggxLt7S4OAgWImSUT8qImuK0oqpLaGuhLjxx5GMGPgkpi2ZJfpwtLPyz0LpzfMjpYdePkIuFr+jAC2v1pvTpb/rGeHaC0mArnnM647E8BtEQsvqauBRnd62AtLIUac2nPD1qazSGh9+wuVikYnkMZGZMRx2vrZhOXgpulLi0ILj9hb4skoY6kfqdudREgIR3JuFD498TnHMbZv1wxU1bm3YQxvzZJzsVrCJ2r0AYiLhRGB3Q+JYosAlF2OJFZl1um5ddYhxgVxIgh8FYX1RBA5SXA
X-GND-State: clean

On 12.11.26 12:25, Florian Bezdeka wrote:
> On Thu, 2026-11-12 at 12:16 +0100, Jan Kiszka wrote:
>> On 12.11.26 12:05, Florian Bezdeka wrote:
>>> On Thu, 2026-11-12 at 11:31 +0100, Philippe Gerum wrote:
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>>
>>>>> I will share the lengthy test case as well once I'm done with stripping
>>>>> it down further (if possible). What the tests already demonstrated is
>>>>> that unpatched kernels crash.
>>>>>
>>>>> These patches here are almost completely generated. One of my few
>>>>> contributions was to encode _TLF_OOBTRAP into oob_trap_regs. The idea
>>>>> of having oob_trap_regs as a nesting detector came from the AI, though.
>>>>>
>>>>> As usual, AI is still rather verbose in descriptions and comments. Some
>>>>> of them I already shortened, but most is still left. We can cut down
>>>>> further, but I would first of all like to have another review round.
>>>>>
>>>>> While doing that, keep in mind that AI tends to ignore issues left and
>>>>> right when being told to do a specific task. It may have simply missed
>>>>> further preexisting issues or even created new ones now. Watch out!
>>>>>
>>>>
>>>> It looks like patches 1-3 have landed into v6.18.Y already, which means
>>>> that you are confident with those changes eventually.
>>>>
>>>
>>> Those patches should not go anywhere until they reached the latest
>>> development branch. The common "upstream first" rule.
>>>
>>> Everything else will add a lot of confusion.
>>
>> The v6.18 application was experimental, to validate that the test suite
>> passes on real hardware when all issues are addressed. Nothing is
>> official in rebase branches until it is tagged, including those patches.
>>
>> Jan
>>
> 
> Why not just push out a wip/ prefixed branch? That does not require to
> temporary update branches looked at by different / more people.

CI is not picking up such branches.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
