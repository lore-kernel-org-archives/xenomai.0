Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAD82AE68
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804568; cv=fail; b=qsGXMV8ZcSrKQBf7hMUIJK0lyHAQGniH1ihH/tqyJlXDmrDwgCtFeXgywew/Km6oN13MSB2+3ORgeGQfNuvH82O1TMkYnT8woMKTFR8GcUxBErVrNMYUjOv5pGZVGzPI9MzvNNY19SSOJO9JSuZb4cQ9oEUg9X1etUkEstmTbGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804568; c=relaxed/simple;
	bh=hspCY5yqRgKIsYiHIOjVbfaJjLMvybwGOW7rb3+VaLM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BTiui7pAZ/uhJawI1y0sWw2K+cO35WC/0uVNCxmw0PcWUD7wALSuIQKIUd6TUH+F3xf4x2QKBIMZE1jjT3sAh3Vwv6CSpeh55WMgMu1DwYU3QEYqKSZE8rMvtYujk5u72eGSM6Xsi90xCBrZ9bIamx2qFV8Dc1W6gs0aOJLccvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ayuc9C9A; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ayuc9C9A"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id C154F43539
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 12:49:24 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 3559778003C;
	Thu, 25 Sep 2025 12:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7+U54ijoWs9+xfNTjqcJAjJndq9G0ZlnjTpo9vIWqT8LNywML1/J61zc1CUhe4xaK2o32Lwjbw3g60ERtQ0SDDbX02GKTOg008SVIn8dJNQQ28QqfqOUsyDh+ChQOHJQSt785HSt1FUsO2zYHtIIo4KIJQWiyr0FnJSABlYalr5heTp9rBLphZZqHXZKxcVPlC++zhkROKYI5Zvjzf6ewIuYxqXUtvpuI0Vuoq//TrRz8r6EuY1NORubY3QAqeQ3Vh78u3gs8rOAPw+MruH1q+pAyQUzt5WxqU4MCt6AAzfAHmrPGJXdT6xeeHDyBvheo0JQfNgv9APO2kBjlWuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oH8p4Ni7NYX1gbXkPNo+3CXW5tzZQBSBdWLNykZrRvk=;
 b=N5Xt4b9yDa4ToGNT2b8LH8ehAGOpzuggDLKj2gk2SPEv6C2RprolC8o4jE3YH06pYiI9JVR0b9nfV1Msw/I3H2qC633Bcf2Mj+cKHSWK9SKhNjJeWneQZMiG8C+ANubz00iwvy7j6mFWSdnNbAZSENne7MMCG9G66nshjJVRMqb+KT6cdaK+C+GfNfzjaIpMthvdA/YUA1uCu4SilxPyyukO9MAS+zxnytXKg34cNzR+E/l0cTZqDVJJpF9edQdnASAHRcer3VcAZePyBG/G3Ro8+7q8b09iy9Nt7/BGn5DXxmLaVXO7rKBlQ/Z/VUhT0NfWvMMnefoi5ItWjNYI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oH8p4Ni7NYX1gbXkPNo+3CXW5tzZQBSBdWLNykZrRvk=;
 b=ayuc9C9ACybCvwCK9izVXvGvx9jMJWy271yRPN733CTcyIivoqIc5d4g85Cn7eFJ3lePFEvj18tm88Z03qw3sK1fhdqieXJFR0+wkn8/amWRbJo4zco65KEgPfQsiNIDDmXQZ/GidNpM4BAhQP0zHGcZ8sOYiwx0E32uklXkPb+rswYGrof5lHpARfj6g7k5lYRf4Kfmq0y8AgeoVJUcHcxFMbMUaEqUK/k82xCXi7fvnWYVWlzNX19TwQYU3/K5STMdVpaGjjex07SKRsB0vYxNlQC68OWX1oCn5B4H4ULUkFqRQzQbRSFo3A/JGZLPipoDGkLJSng6271SQmTPBQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7474.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 12:49:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 12:49:21 +0000
Message-ID: <8359c1ef-1c5c-4f99-877e-12804efc955b@siemens.com>
Date: Thu, 25 Sep 2025 14:49:14 +0200
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
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f2339b70d34b7bd4c8e720428d860bc7748aec4d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:610:b1::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a1a8b4-f078-4e10-3bb4-08ddfc31f2a3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Kzd4eXl2WGxPbTNZMGdkVWhicUFIaUpkajZDbEdtRitXL1dqV1pvdFcrME9L?=
 =?utf-8?B?VVVKTGJ4OTdUUUFyY1dNL0JXLzJnSGZzWFNtSC9nUnVPanRsR0V4aFoyNVBs?=
 =?utf-8?B?Vk5zNzZ5c250WWxDNzRod3hhcW9XTXUyYVpoYzhQeDA5NkQwVlVLOGMrVXpa?=
 =?utf-8?B?eTFiSTFUZ0xQZGFNRFZRMkdWRzVDeTVFY2dQcXlLeTVWV2Y0V1hONkhKV3Nk?=
 =?utf-8?B?clZJdndGUVNSRzhmYnVOZEpPVXhsMjJ4MGp1N0ZZTnZqSjBabmxLUDVRY2xI?=
 =?utf-8?B?dFA4M2RpTnB6QmNNS2kxZ0FVNUhNUHlhR3l3NHVUalh3N3R4azlzWDNDVW9X?=
 =?utf-8?B?RXdsaCtnSEsyUVU5enFvTDlJMWk2VGVXOGtlS012dUQzU1FiTGFEOUFDdEJi?=
 =?utf-8?B?N3lZT2dwMThrNjMwWVZOVkl3OHFOcnRLbHpMY2JBVkpUQXZuL0psQ3laVGFF?=
 =?utf-8?B?c0VwZ0h3KzFwdzk3WjZVZnVkSE04ZWliUlovZHd3MGV2VjVlWU0zbHFoVUNV?=
 =?utf-8?B?bTZWSEwrOTdneEdWeXZkVWJ0bkYxSkhWRXlvOU5TQ0RuN21aOWREbEJRTUNw?=
 =?utf-8?B?R2w4eWZMVjhhcnVlYndpcktqR2ZvZlc5OUhFZGlTQWt3TGJxVGFhZFhOQ0xB?=
 =?utf-8?B?SXlDNUtGNGZEWE9MVTlOeUQ5NGU0RUdWa1VFQ0JwVmw5RmVjK1pFQnNMZ2V0?=
 =?utf-8?B?ME9zVHpITlFHejJrZmZ4aitHWm9lVUt5T0taWGhTUzYwTFBxRXFuT3JZVVBE?=
 =?utf-8?B?T0tjdGVqclJKRzVQTFhpQWhaTDM0T1NjazdUNHFETFdhaUdPdnBpRFFvZk9t?=
 =?utf-8?B?QS9iQjhRc1lBVnFlbjgzTzBWQXM1Y1FaeFhKZldKMm1hNWtKNHZOVC9mN3N3?=
 =?utf-8?B?ZkVubkZyeFBFL2txcHhOMnBBMlFrQUxBeWp0ekkrNlVBeWhyOWpQOHBCTmR1?=
 =?utf-8?B?Vm92dDZXTXJGUkJjK0dyMTAvSUhUakZxRnYxbmI3cTZlYzdDNk1uM21nanlF?=
 =?utf-8?B?cGVzRllmR3NOdEtmaFVqeXpFNGVTTWlLMStSdGhBekRHNG1rMkJmQU9Vallt?=
 =?utf-8?B?S3Zkem9lN0NvOVRKa3RQL3o3L1ZFUWMrZDRESFBPblNRbHJPNDByM2kwTHI1?=
 =?utf-8?B?dGY3RCtESXYvaldoUXM4emQ4NWdhT2NsQjU1MWgxS24xbXRuY01sMDlGR1FE?=
 =?utf-8?B?UXl3UDA4NklNNHVIUjlsVVpPR2VnN1hqWEJtWUhTQk9BTGxES2Q1WUdYRlNo?=
 =?utf-8?B?dzRNaHVQWC9PQittaE5sS2toUHEyNnJtbSt0VW9nRW9iN2dQbkRocjBIcE5I?=
 =?utf-8?B?VnAwTmdpd1dSRW53VmlQNURUQ1VBWExBN2xxcjA1K1lIeG5LakozRm9wa28y?=
 =?utf-8?B?dDFxc2o1TEs3eW0zRWZmTjRPeVlVdjRnRHJ4eUoxZGs5Nm1WdnZXZVJicnNC?=
 =?utf-8?B?cnhsYXdHUUxRMkY2cXBmTXllcHhlU1c0SkZDdEltd1lLTWFMMzlha0o0Zk9G?=
 =?utf-8?B?VG5rMWdFYkQ1RkVRTE11VEsrbnZIZFVuMVFhTlMyZ3ZoRHREb1B6aHdaenNG?=
 =?utf-8?B?ZG5iQVpqTVc4SFJGQjlzbGx2Ly9IaWYwV3UzWEh2Qjl1M1JLUDRNUjYyaEQ4?=
 =?utf-8?B?bkZNSjNDalZCU1hIR0hYdGFveW5EeW9Mb1VJeVo5d21Gc3JncHNaK29pUjJ4?=
 =?utf-8?B?NjA2cFZBMlFTUjRQaHdyaHIzR0M3ZUp4dlB6ZUdIVVlXcERKeUZNU0JFUnVH?=
 =?utf-8?B?ZXBYN2RYTWhRaGN6TldMRjdvYUpKVXdBMTFFTXlQeXFkNmJXeWRRaEU5U1Nx?=
 =?utf-8?B?bFQvUWtSS3VnbEFHZFcrWHkyenQ4bDBoUWZJeFVUOU1WaEh4MTJIVjRPU3ky?=
 =?utf-8?B?SnBYWFpiWmFsNTE0NzlzVm1lS3Y4amtneHk5Y0hpWTlFSUlwSWx6bWpIYno4?=
 =?utf-8?Q?BCJI0JS0J8s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDNzRDZPTUorUzFYYW5PcGxpd0haWkFVU0NVK1hheXVCN2ZCTW1ZcVZHV2Rv?=
 =?utf-8?B?UkZhS1FNN0lkNTZvdm1rQkZzek9iaDhxb1E2Y2lseDB4VmpBVlRqQU43ZFZH?=
 =?utf-8?B?cG93YnNtYktrQUYwSnczZCttajdpdlIwQm84dVo3TmdCdTEzUkx0V3c1WU9y?=
 =?utf-8?B?dm80c2o3MzlWNktvNDk3WnZsblpWRTl3VUtoMzVvNXNjSGxiRTVHREVyWFha?=
 =?utf-8?B?Q3VpRU5MU08xUjVIWGNWNmdkcTdIcEZ1bi9LUUtnQjlNZE5BQWhpdHlBbUxZ?=
 =?utf-8?B?QU1YRzA5OUZLRkRjbnVnSnpHVmhBUTRlVzhyMlRheHk3RkhQd0xsVG8yUU1D?=
 =?utf-8?B?SFRRcmlFb3V2TDFqTHVJeWMrTTJnSUxERjQ3R3hjKzdqRE9FbnRJVWhqVlV5?=
 =?utf-8?B?dThWKzBqSWZiWXRQcEhScWF3TGtVLy9QS2RaMGFMREdYbm9wcDFranBQQVpP?=
 =?utf-8?B?WVJ3RTZEekQ1WUM4cWtPZXVhWjc5S2huSmxMekgzWFNEMWtWOGFiVXlqTU5u?=
 =?utf-8?B?cE5TZ2NId1dkM091amJ4Vmo5dmtHWTVHL3RrbEJxMlptdEV2T3VNcVJVM0xC?=
 =?utf-8?B?MGJUQURYV1NpQVlIVTNtSVorek13dVN2T01lMTR0cEcyU1VlMit1b0FTRlVh?=
 =?utf-8?B?Qk40RUliVC8vSG14ZzJXQU5Va2dCaEVTWWwxS0ZITFpUSWZxdzE3dXNEeVNW?=
 =?utf-8?B?UWRnN0s3ZkZ1K1lEekhYczBPSTNzU2diUUFEU1FZRnAyMUFMVlh2cXpob2Ra?=
 =?utf-8?B?M1pWSnBOdmdYSU8wTWRReXhGUGRwMTlIRlhpU2xkTWE0RWNqVGdpdXJYQkQ5?=
 =?utf-8?B?UVVnTm1aRTJ3VU51VnQ4WWRZdkRoU2NNbnJuL2NaNm5Ga0l3bzJHK2NLUytJ?=
 =?utf-8?B?UzA3VXFKdGVDZ25QMExTRXBVRWZic01oVk12dWVvVVRCeDlrdHhqand0WmJ5?=
 =?utf-8?B?SlgzSjZHaytXb0I2a0ZUREFVamhYOUwwbkNhZEovdlZHQkFMd0VTUGcwRmt2?=
 =?utf-8?B?cm5RL0w0eGlBNkpEUzJFdm51bjNNQ3FrKzREU1hzSmpvM3ZjOGFCN1ZLbGlx?=
 =?utf-8?B?ZXZZMXlNMGtoMGNncFFwa3lGM0pYM1k2UktLYU5PNkRTMkRDR3BFM01SczQv?=
 =?utf-8?B?bDBlOVRyR1dSNDhzNTNjS2xnTCtsL29pTnZXMXF3T3NjbHUxTGdiVDNRTUNl?=
 =?utf-8?B?OFNLUTNMa0t2bVVnQmN4MzBpZWhzVW1vbVRSWDRwZVRmbncwMHpyeThGcDJX?=
 =?utf-8?B?VGRCSUZGZStaeXROME1MSGRWYTFSdXNCekxtbWp5RnFvOUdXb0ROM25lNUxa?=
 =?utf-8?B?MGlWNU9ZR1NpblVMSkFwYWw1TXB1dzI3eXU4YUpObHcrTHExcTVRZFVGcDlV?=
 =?utf-8?B?QW5sQWZDQTV6VUJqQkFpNjZReHB1ZTlNaTdYcndETGpickdzSjhvWnR2MXJ5?=
 =?utf-8?B?WnFzMUVkbE5zWW1OTG1UamdvU2R6akN5R0RYTE5jTWFGTk5pMHY1d3R1VlJw?=
 =?utf-8?B?bkdMVlJxNFFaOGNQSmxyQWpwUjNtYmM4V2tqMmloQ2ExUHY5SUJEbkloMml6?=
 =?utf-8?B?TytCdjdvcm1iYjlPalBPUzdrcVlyWTFTcDZaNHRXa2oyaHllZ3BaaUkxK3VB?=
 =?utf-8?B?aVJvQkZZcmVGQ0gwSnphZmxPTVFpVy9tWmNvTHJRZUNmcXA4OENuaGdnSVVX?=
 =?utf-8?B?akxKL0ZPRWVsTkpmTy9ZRTZJNmlHRHlYQm5ESDJqbjlwaXBXLzYvRVF2OE9H?=
 =?utf-8?B?QWdLblVSbzJuVVRnRUFKbHFjY00zdXRveFQ1LzNNanY0YXdxYll2d2c4eDMx?=
 =?utf-8?B?UEpqNzUxWG9hK202S3FPaWY5eU1MSmtpVndTZjdkVFhFYVlwZjNSRUh3ZlRS?=
 =?utf-8?B?aktnQnNXZHVmdlE0UGhMalNXN3FWdk53NGhOQy9SY1B6aG5rKzkwb0Jna1dI?=
 =?utf-8?B?YmhFNXlBR1ZMNTRiMCtrOExHRDR4ZDRlQ21WemtQTE9pL2YxRkl0MjZ2UStt?=
 =?utf-8?B?R0xXSTdLSDUrc2FMVjBPNHFUT1ozNHl0UWtqalVJcVpuWTNleDB1aEVKaHdh?=
 =?utf-8?B?cGx5S0tUT3BkNXBGMnFlUmFVZTdqMTE3empERU9aT0JsT3VJU1ZmNG8rQ3B4?=
 =?utf-8?B?VTNLZExJdStCRHZlOWQ4aGRvNUNtR0thVDhHV2hKdVA4NkNSNlVmL3RCR0sy?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a1a8b4-f078-4e10-3bb4-08ddfc31f2a3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:49:21.4226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDuNUlSVKE1WXop1N8YBVRVVOFU46JdQ+KqLOP/RXytwSPMYP5le8QyRC6TeAplp8k71MLsNlKGE8l4QgS8lnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7474
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=ayuc9C9A;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:c201::3) smtp.mailfrom=jan.kiszka@siemens.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkffffgfuvfevfhfhjggtgfggsehtjeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepleevffdvffdtteegleevtddthfdvkeetieejvdduieegtedtkeehueetteehtedunecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucfkphepvddujedrjedtrddujeekrddvudefpddviedtfeemuddtrgeimedvtdgsmeehkeekmeemudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudefpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

On 25.09.25 14:47, Florian Bezdeka wrote:
> On Thu, 2025-09-25 at 14:40 +0200, Jan Kiszka wrote:
>> On 23.09.25 20:51, Philippe Gerum wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Not all callers of this function do that themselves.
>>>>
>>>
>>> Are we 100% sure that kvm_arch_vcpu_load_fp() and kvm_arch_vcpu_put_fp()
>>> would not benefit from doing that themselves precisely, to create an
>>> atomic section around their internal state change _and_ the fpsimd flush
>>> op?
>>
>> Is kvm on arm64 officially enabled for oob (-preemption), or are we
>> patching blindly here? If no one was looking at kvm yet, then you might
>> be right. If it was reviewed already, then this here is just cleaning up.
> 
> We have
> https://gitlab.com/Xenomai/linux-dovetail/-/commit/028ad3b2c19ca8a3655577fb34cac7996f166d2a
> 
> since 6.14 (AFAICT). At the time of writing this was the first kernel
> release that used in-kernel FPU. Maybe that changed (thanks to
> backports)? Btw: Which version are we talking about right now? 6.1?
> 6.12?

All of them.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
