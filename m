Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E6296FC1
	for <xenomai@lists.linux.dev>; Fri, 23 May 2025 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011960; cv=fail; b=ntn8Al/n7iygXuVAexB1Fv1IHE0wFn/2hL2FDNytq06Vc0I4dEWp9pU84yYkSfg83LL6KsaVpVcgOJl0OZBFXEJEt3yT+ecolJm9D8gZpDM8IcMbGVpGL4ga5ahv4kLwFGDlmk5VXgANmJFRfuVztAFPzXMCc5G7c5U+5BIYKsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011960; c=relaxed/simple;
	bh=F50Dz+R4+ZoneYIp+sPSyu2eXfiQ1+Y88Rfv1Fu7xTE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=clCMm0P8YCx/RFRyaZwG2rXlSOWqvCtCva7e3hRIf8l32nTnVg0l+I3FOt/yAJMUZ9t/571tBNKyzOL7NwUuwt9beNdfnYg8vaf/npzaOWUN9Qh/V+MgQ2uVWEyBr1KIHN3A0aiW1zsyvRUyaw1+/2w7H9dhjykW7G5RSSqGjQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=niOs9R/q; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="niOs9R/q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GThpmEQBY4yoxGvgOtRU+7W9qBPe8yby6yYEwETOQ6rPTlpqjAVHJ4jQHnt1SRADqFkS2IO5BKBrGqJyDfpxFJGoPnDiEk1lhaWVBFG0fCWhLIGWPS9vGrWb9RtPrCxov/B5Xkb+a5Kv109r0bMPx9xu49IJKO5/VNb2aJ79g6Lfeh0K04XrynvbwIsjJTYiCGcj5p43l5gS/7dLA98pOtMiFTnjWQ3yERHjGAIlgeukRcPR6jo3Ew0okdXdQctpuEwG2FyjAv/aqR8VDBRApuz5EmdQIHdi79YLSYWal8hlXt7tFTTlXv8kDI9WpWXYzxZdTvOtbJZ1yuhQfQQ9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Bh/BmfM4f94eCvdle9dFR+gPGs664W/OEYF85+j2cA=;
 b=G2r/oOhwPyWznpGVAUSQaTjlkGobW+Sqvss6cOWZSP736gBXEoLcPRTB85m0m3e0Sm5CfafaXz7Uf/yVKFkzWuyMJY3dm1YC/sJKp1Rw5S1ogeS9gTR8JanE/9TEEYHK+NnHjbaWu+Jx6VvKCxCe02NThFzHs0s+EB0z1L7CkORRz6Le664qumkIGN4pqFx/g86Ipea4OEbQiMBAL00ft8xSgkxCKX+r099av1vp5N6fh3igLuttm809S0bKx5tANjAeO2N6ABhQ5eB0nLnWaUh6rwHlJ3YW1DIrILzD8oToJ2PF4RSGzzH0xFw3rCZT781waZ+vERebFhg/Kk7Ylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Bh/BmfM4f94eCvdle9dFR+gPGs664W/OEYF85+j2cA=;
 b=niOs9R/q2JMPXZzCm1qFr6nBsFO5z6XIA9hi5S22CG0ayzxHoq7qwQWIIi+vYdyLC+wPpXbdRUGeQ0Lp6bcRGTsz63l5B6N7kyOor7paS7xEo2Z0e9ZLeZ+C4mC4Y8PWhlxzuGIb6+EJAsiV0ZEOf+aTpP5o/ZAgbPS2FLN5Lwv5Ip1TNhx2a7bkESJVP27DPtlojFuwoZR2pWbrKVVkwOJlGvt1IExOfROwMB29Arxx4cez59J7ufqaRwbGUAa1lN5krEWUouECgk7i/eCRTuOkC33Sh+scIbcGb+xfGyEweNvGuIVy+PB4OfyNilXeix+E32x0Wzjf9B4aa5/Gxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 14:52:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 14:52:34 +0000
Message-ID: <c7495f38-e917-4093-b283-c8fad9c9ba0d@siemens.com>
Date: Fri, 23 May 2025 16:52:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai Installation Inquiry
To: Tom <t93252352@gmail.com>, Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: xenomai@lists.linux.dev
References: <CAEzxD05xAJmeUeyFwcfqBDZMOqDfa1sL+iEUDknzmr6XwX5Q5Q@mail.gmail.com>
 <CAFc1U0vhiFvELw7Y0uxiASQspk2ZDkiA4G-1e_qDRZMVH3rf=w@mail.gmail.com>
 <CAEzxD05krv7gruQvkXe+-zpgjtbdrFOdr-ZY490uyp9ezcyDyQ@mail.gmail.com>
 <CAEzxD07g24GxEwV51QWa2SUg8+6xnXUteyaa_Vf9L97iVmX89w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAEzxD07g24GxEwV51QWa2SUg8+6xnXUteyaa_Vf9L97iVmX89w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: f39bc476-5b7e-4a56-71e2-08dd9a0973cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|3613699012|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzU5SnM4ZFZBU2N6Yy9BdzdwanBmRHVqZWtwNGx1ZCtXTkVDTmhjTzJFTmVT?=
 =?utf-8?B?bGppcC9ONmNFT2RUc1VSVHhTUWQ2aStCZEFkNEJwSlVjMEp3czAyNkpEelY5?=
 =?utf-8?B?UGhrQSt3VlNZa3hHbDVHVGZyaHZSMDRVcmNvRkdjTktyVFRQTzF0OXBrWEdR?=
 =?utf-8?B?V3BUWEJOYjZEeG1xNHB2YTR4VnVVTGRjY0FHOGpsZENLSEliNERqVHBnSUVC?=
 =?utf-8?B?T2pwZjNRNUFGNUhvN1lkRkJGS01EdW5kUGlCN3BJYUxtY0JLa1RYdjR2cGVp?=
 =?utf-8?B?Y3JpejRtODA3L1FrRzVNZ3dJMzdLTTRhdWJvODUyVHRLQXVCNXhsUUx1VGh1?=
 =?utf-8?B?OHFzYjF2WDZseUlVYzJoWWZJTkhEZGtMUCtlblJ4WndOMForZDBhK2plTW81?=
 =?utf-8?B?Y3pSdkNKU2crenVBdXd4UGdHK0ZTbWhrZHZBdDRGbFlBOU5wMTJEL1dQZFZF?=
 =?utf-8?B?Nkx0UzNoMEhpM0loRDdVK01lWS9zWjRrQlFMdjJVZ1pCcmdlWmpLOFJXZXNP?=
 =?utf-8?B?Rm1MRE8yNjF4Y2ozQVFEdy9xNVdVODRpTG8xc0ZRVm82SkJmK1RRWmN4aTZH?=
 =?utf-8?B?RXNtQmt5YmdQNFQwM0E1ODZaMU4xcXJxZ3p6RWpGTDhraStVdFprckx1TkZP?=
 =?utf-8?B?YkFRTnVicTR6UHpUZllBM2xSbExjNXhJMi95Mi82UjBzVUk1bHJGWE1kOWMv?=
 =?utf-8?B?TS9vWG5sa0dJdE9PVjNxUUd3QWEvbHhoblFYS0pYTG1Pc05iakl0b2RNbGdC?=
 =?utf-8?B?TFZXWXk3SXFUMk1tZVRmYjZEYVJuOUUwazlud1R6WHRCQ1lHc0VtNUtHQWRI?=
 =?utf-8?B?V01iblRiMUhEb0hDblVGV1NSRms4N1A2Q1o0czNsSUtINU5oZ2J5NlhlU09D?=
 =?utf-8?B?Nlhna052bHRsYTYrN0tvQWR2cGZRYnNFMnA4RGU3UktUS3EwZVNoakY2ZEFm?=
 =?utf-8?B?cWxmUmE0WVI1dnZ2SXl5djJNK2dnTGt4cVUvNzZvejJMTDNPSnVIejNqWkxF?=
 =?utf-8?B?aFRMWlNSQlZJNHpPV3AwM1RRK0NJU2xWZ0w2MWtiWEEyNkhlejQ3Z05WZENN?=
 =?utf-8?B?RU5xNFZyUlZFWW13dFVyZ1NaRWhPV2xLRExlbUZvRit3dGdlQStvOEdHdDYw?=
 =?utf-8?B?alZoajgrKytFd09sQ1pURWkwUVVFSTlyNFpJb0xzVyt0ejRUNlc1REtlOWJO?=
 =?utf-8?B?VXBCaVlCZVZmMHR1RU8vUmhJQlE4dUJhM2pCaHQyckdOWXlSeDhGS3Eyb1E5?=
 =?utf-8?B?UE1QVmRlMTRicXdjNSt2bWNtRkNScWt2dWpZNkpkdzV0bWNUNTFqeTZtcmNW?=
 =?utf-8?B?OWVWVFMvcnlCK3ZKOEZEN3Nob3V3QjFSYzAyRHpnNkhUOGNhd25TN1J5RnlT?=
 =?utf-8?B?L3BkK2h4RVJrd0dRYzhuYysvWXBTK21PYTQyMVZLOUc3cGI2TFRLbWNPUWhx?=
 =?utf-8?B?VUFxRHlLZWYyK1pwU2s1WlFJT0FhZStQS3hOOG42TkNvVXZpWkU3OGdEMFI0?=
 =?utf-8?B?bFpNS3BoVkpxUXY5dTFFcnpFSGt5ekJXUkdUNitubnZkbm5WRVBsQzUzcnlo?=
 =?utf-8?B?dEMzRlBKTkFRdU9pSzBlVy9NdlZBME5LdnFRTUovMHYvQWZjMlFkTVYrcDVi?=
 =?utf-8?B?bVJiRFRRL0NPSlUzTk1zbGd5dThMUURaUG5MMk1KNGJna2prOFptbm5KaWR6?=
 =?utf-8?B?c2gzT0U0MVovbndjU21Id2lRblpDQmc3aDdLVVJ6TjN6Q000aFVQTGQ4eW8x?=
 =?utf-8?B?anloaVl5VFB1QVZheUVoVE02dUNGYW8yZjB0ZkhHZEp1TlRQZXAwQks3WFQz?=
 =?utf-8?B?RlpPTEd4QS9xdGRnMHFvdGdIOFF2aEUzTU9SdFpwRGR4UXB6OW1HOG9udXMy?=
 =?utf-8?B?b2hmMGltbFhac3o4TlBRT0JoTHdTSjNzM2pQSkc0VU5kQ3FnL1RNWWhYaWlX?=
 =?utf-8?Q?+R8kKUlfVmw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(3613699012)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3JSdzdYVmpqQ3FPdFN4OWZYa3hZd3AvemErbDFhWXpuaHp4MDFsSjJtNVBi?=
 =?utf-8?B?eTNEVy9VZ01yK1dNVHJLSE50akZNaWJSaXkrcXJsMHlLYzl6aGxMcWFEZEVt?=
 =?utf-8?B?UTVEaWFaNGlCbGJVeUpxQVV2SkVJNlpMalNaRFJxYXc1ekx5ZXNDQmlKYjBl?=
 =?utf-8?B?ZEJFZUlIalJLVlZxOWRKN3psT3d3ajZubGRaWEcyRjVKaE5JaTZoNmx2ODU1?=
 =?utf-8?B?NS9NTVBoZU5WSFB0UlNEb3FIRlM5ZEQrcXRkbG9rbVgyNGZubk1ZNXRWaHhS?=
 =?utf-8?B?SjhNdndqanFrTmJqZ0ZuNjRNVWtkajFSMEVUVHhTd01EWjN0WHdTRFZiWUxs?=
 =?utf-8?B?ODRieFowdFhvWjhTeUZPblgrUC9xc3NWZm1ucmo4YStuTHBNZk9TNVIyVHV0?=
 =?utf-8?B?UGlFRU1xSnp2dnlFVXJEVi90b1dzMTE2bGt4bWxsdnRwdGp3NFgwQUdod0tu?=
 =?utf-8?B?TWkvR1puWHgrZVFMRUZxMmwrdWNZUEpzUmt0WEJCeHV6S2RXcWREeXdPcTIv?=
 =?utf-8?B?VEp2ekc2dXM0UFpINlMzWFhSU2hCWUZ3Vmt4UDRyUWtLM0ViWW5LWmZKKzYw?=
 =?utf-8?B?bHNJbU0vNjI3TGYzd2hhUU1WZW5TUThlR1FvSDhNcmZBRWZoRVpSL1pZT1Y1?=
 =?utf-8?B?TVRmLzZzeHhqZG5udi95Um9FRzVSNmRZWFJyejBVdldCK2Y2SmZXaWQrUnAv?=
 =?utf-8?B?UnBrck1RdXljV2tsUnh5MS9JWUIyQng2NHJVS1ZlcTNSTUVmT1dtZ3dzVGRP?=
 =?utf-8?B?M2xyV3IwNHVieW1OSTY2YlE1eTNPbWlKd0I4NnhaZWdJVUFuN0FTMHpkbC9m?=
 =?utf-8?B?YVI4MWUrM0t4ZFd6TXJnbHNQa1RyL0g1RWdSc2NPUld2ZXBmczNKVS9JdXVR?=
 =?utf-8?B?WDFKTlQ4N2Q4elpGZUVZL001OThZVTNxSEJTTzFpd0NLRUFtVkM1QitXN3pC?=
 =?utf-8?B?MGRmQmF1Qmk5STBieDdXT21kbStpY2sxZEkvYXZoaHVtb0RoVTJzVWtoR3Ji?=
 =?utf-8?B?aFllaWY3dXlITUVTemFSQVJlcnBGZ2xPM1hGc2pRVExoZ09BRE5YbkcrWUlQ?=
 =?utf-8?B?VVhtN1JSZUVvRXBPeWxaUHZmWG1DQ0hEUXMySWZST0RiR3ZxSzFmc01CQkJ3?=
 =?utf-8?B?WXFNRXBHbHMzT1lrMDFMVlRNWUJ0emN2ajg5d3o1ajRmS2s5SXIxdGpvd1Fo?=
 =?utf-8?B?N3BsNzlzdWU2bTUzQk9mYVp1ZExWKzV6dVhoWlFmY0hLdGdIVUM0UGxxUVZM?=
 =?utf-8?B?UzlrcmNDWjF6YUJnZ0txZ3dJelFwSytaLzMvT3g4K1pZVFBPMEpLWnhXUWxu?=
 =?utf-8?B?dXFqS3FCWXZKYzRFamhOYUFzUmZCMjZWSGl5TG5kVS84YWNrZnVHdlhGcThk?=
 =?utf-8?B?OVVNdVdtVDVUM09UUGFKbGxSeTl1dU1YdTlPdE5hZTQ4eXhpRUF3bHpPK21o?=
 =?utf-8?B?M0dBelFkejdkRG93V3VyK1FtWllxWVA1ZSt5M09nVUNIZ0JWeCtCQ1dlL3A3?=
 =?utf-8?B?dStZSldoSXdjbzFnNDJtTmdMb2JQRWpUVmpTYnZuOTgwanhCOVdQNzBwM2tK?=
 =?utf-8?B?a1VZSi9JVDNyY3BrOFVQbmR5R3NaVE5peG5TT2hmdzBHNVdyMFpJL2NMYUtX?=
 =?utf-8?B?RlJNazg3Tnh6TmoxOXhIb0JiWG1uaVNZcGZzZ2U0aWFCZ0x0eEYydzhWdllF?=
 =?utf-8?B?MHVrcUhjUGE0bnFkQVZ3UXJMY2grN0hCb2NBenowYlNBL3NLZDNlOG81Z1RZ?=
 =?utf-8?B?Z0h1MUVhU2ZiaVhCbysyYnl6WE9rUFhzcjNsUFZhSGc2elowa2RhYnpNc05Y?=
 =?utf-8?B?TDRmSlJob3hEVGRPUFgvYm5SNWdWd1huOVRVVHIrVHA4TU0xeGNQa2d6bHU2?=
 =?utf-8?B?MHBRWXNsLzdobEpkSkVZWDRib0YweTd4UUhmb2x4aExHUEFkOVl3NFlaZGJP?=
 =?utf-8?B?L1ZHa3hvbUVMRWlTVHhZeDl3TFFPSTY2cjArUWt1MkpCWUxOc1dwR0tYUE1Q?=
 =?utf-8?B?VC9YbU02empFRVQ0NWVLaDNuelhDalExS1JXeEQ2Nm82a096UVd3SnNIbmo2?=
 =?utf-8?B?QW5IWGEzcGorNTlUOG1KQXZ0ZTJ1NitZVmFZMXk3d2Z4YjJlazBRVjU0ZE9J?=
 =?utf-8?B?RTc2c2lILzZOYzBQRllrUVVvZWROcVUzS0Qxa044SlZPRjNtUllUbE5CVGRt?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f39bc476-5b7e-4a56-71e2-08dd9a0973cb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 14:52:34.6039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVjySI3UW3EFGEs2cpDFTpkLbVlTQrSS7bwbMNSjk0VuX/ef9ehUHfiO4Wdo70Ue/xvA1m0QoLtdFRtaK4qEhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8349

Hi Tom,

On 23.05.25 16:37, Tom wrote:
> Hello all,
> 
> Just sending a follow up message as I wanted to know if there is an
> exact number for the storage space required for Xenomai 3 vs 4 and
> co-kernel vs single kernel.

I would strongly recommend testing that yourself with your own preferred
way of building the base system (distro/yocto/buildroot, glibc/musl,
...). But compared to that system, Xenomai will really just be a minor
detail.

Jan

> 
> On Tue, May 20, 2025 at 10:30 AM Tom <t93252352@gmail.com> wrote:
>>
>> Thanks, is there a specific number for the storage space required for
>> Xenomai, including all the additional libraries and updated kernel?
>>
>> On Tue, May 20, 2025 at 12:50 AM Pierre FICHEUX <pierre.ficheux@smile.fr> wrote:
>>>
>>> Hi,
>>>
>>> The footprint is very small: some additional libraries on the target
>>> and an updated kernel.
>>>
>>> PREEMPT_RT doesn't need libraries but not a great difference compared
>>> with rootfs footprint.
>>>
>>> Regards
>>>
>>> Le lun. 19 mai 2025 à 20:55, Tom <t93252352@gmail.com> a écrit :
>>>>
>>>> Dear Xenomai Project Team,
>>>>
>>>> I am part of a research team currently evaluating Xenomai 3 for hard
>>>> real-time control on our system. Could you please provide an estimate
>>>> of the typical storage space required for installing Xenomai 3?
>>>>
>>>> Additionally, if the installation has a relatively large footprint,
>>>> are there any recommended alternatives that offer comparable hard
>>>> real-time capabilities but with a smaller storage requirement?
>>>>
>>>> Thank you for your time and assistance.
>>>>
>>>
>>>
>>> --
>>>
>>> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>>>                              http://www.smile.fr
>>>                              https://smile.eu/fr/offres/embarque-iot
>>> I would love to change the world, but they won't give me the source code
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
