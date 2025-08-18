Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC2320381
	for <xenomai@lists.linux.dev>; Mon, 18 Aug 2025 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535479; cv=fail; b=F43RogqZC7dsPvqss0iAFqWVm6m1tUZ0Vmo97PLadrUwbZ6G2/JC2s72bsPgqfDbhtqFPmVgEEzyHPITMUAADiyWcwHFI/B80qJW28Y7D3zRbsnX6QNAWByMbB6PEh4GilmQVjbN02z+hjjDhOwLRzJMCPdgu8LTVD3/3v8JsDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535479; c=relaxed/simple;
	bh=7x8qgrYNiUJJJGjkcyKMLj9gbm7colnkPgohOuiL5gg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e7gF9ughAKHoJ2/Xl9rCQyGvYDzVaBRX1Dfe2iGawcQRJQzQOjFrflxMkimZPuVaULL7asE9doO+bbO4YRAHSplLF8sQgnTLEpRpMDjw1D61h0kKwjmRfaIWKxawfZSvR/3lDlkx3nCT/Gbnj1Re5d9BPyrCRFpRlLnniTimnGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KUbfFk0I; arc=fail smtp.client-ip=40.107.159.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KUbfFk0I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkJ17CXYB4XlGs2F+teFOq+R2+BSNR6euOy0AgmOxalNCdRW1GNCiWnujRZtWZbnYVZ7Dflk7kDzxqRxCD/9i6r1gM0uWcqEDALfPGhz8m98CC93ZYtN5L7xzSXb5WVV1ZWJbGtE/7nZrbiQj1LN2nmcYCpstaNlLvsmMjIFHWPrOVewl4HSTFJHWuCtpH8/vzBiAb+OTp7a0d/WAbjgo0mCvz71NiZdfMWHkmCT0jrvJgVYWz8TFkbd2GnvZtQZtyEEKZpL2wU4QDUSb22e6OwgndYvJxIm5NLxEnbvxQs9aRpnJd2oGuHaQBPnn36lWytROi5qLmHKyLwaSLbcRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kwOMPaR2NqwX4XU6k3NG7+Qgikx/KqEnaL5AytI2wU=;
 b=dku1tBFoCr8asIbZSCfsotANy0pFUKHAqFFrDMLw4I59Wu8iBCNhEOst4gr1l0Mi2oa/iOS6f7/tGPS0mzxcbn2j283LsON8AGKsl2WsCm+RFV7++gMyvkWqDA3JiYtFQMvHoxfSgumhAP/dEk8ryAOfKZ8bfQTOGhZaUOE8Mo8PHocpNhOgqrE5nfyHrUhr5RuqUIjVF9h+kQgmm1Rw2vFLFrR3ZyPnI5sc/aETYAOFmWlJVmL6Bx9VUqPgySR7Kl49g1HEQDm0tkl8bUGm8Bjlh0o47HyqdNNePWKoncJ5G/EfK8fuA0PpPkvfwf+J7xcHRVTnLidg5G4h1GS2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kwOMPaR2NqwX4XU6k3NG7+Qgikx/KqEnaL5AytI2wU=;
 b=KUbfFk0I81pP3J06LepAatcCy9gBUmEHXrntYP2i/dK7F+TN3jsreVCaB+KNthN53sj1CrgK09hmdhJr259Lqfv+yXU7uv/gOoabXgpqSkSLAJbjYv8d79GEALaJhkoLiOmxCxKBLEZ3WtMn92CK+ycWWMdX3bRjQfY5taUk3IwxdrPiMhshrmc2NkzonNf8AUsTdz47/PpfDXbRJdkyKsWU8BDAfZmPnzteSc/MraPyjhdBhp9qI1PrAsiCwsI5X6d+ibRfX1p56EKiwpHCKJEG36NmSXw1VcEX+C3Gi8crut89QZ0ot0pXQ7S8Gfu01I9mpX1J3zgIHvKuXIMVPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8839.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 16:44:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:44:34 +0000
Message-ID: <b7eb0be4-c6fa-4096-a76f-d8d64cc21fa3@siemens.com>
Date: Mon, 18 Aug 2025 18:44:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: We are moving to gitlab.com
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <a1f7db9c-0422-4b1a-a762-d5ad2d9edf99@siemens.com>
 <bda4eb89-41d9-4b80-a332-194f1433294c@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <bda4eb89-41d9-4b80-a332-194f1433294c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: b36d1f6c-9e34-4afc-7019-08ddde7682d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWNGSzJGUEMxdnFpV1VVaHN5dTRhNjFqK3NESXhlUFcxajU5SUtrNWFZR01n?=
 =?utf-8?B?TDNxM3pYQ2hhcHhjTXVCVnNOY1A1bHNhRmZLUWpiY2dJb2xDVnBGbHFVb2ht?=
 =?utf-8?B?TG1odEh3Z0ZvTDZmN2cxZ2plNndscVFvUlRCaGU3UFhVeTNneHlmNE5Id0J4?=
 =?utf-8?B?aWdzYmQ1VjJDVlcyVS9uTzFBT0t2T1BsUFZYdkI1SHRqUVNpcllFREtUTHpt?=
 =?utf-8?B?TWlabExCL1FHYUx2ZEJ1bWlqTlJkaHNLYlpZVGxDN0lxYndNeHRZUnRRSDM4?=
 =?utf-8?B?cTNnWXJadXdHUmhicmkxZHlBSkIwUVk0Ly8vYVZWSWZlRnQweFh1RnhhMkJK?=
 =?utf-8?B?VmRMSzdoVXo1VnRnS2FFOVd0emF3RzA1TnV1ajlmUzdDNmsxVFQxL2Z2ZUpl?=
 =?utf-8?B?Um11cmVqQXlhSHVXWXNlTjZaRTNYVWJJTHJ4RnUxMWl0czdIVTZYZ1FTWTFz?=
 =?utf-8?B?Y3NMNytwME9LR29wbjg0Wk03dHNOOThMSjRDSm9MTmVjTHdDYWViM2xTamFF?=
 =?utf-8?B?aHB6THYzTUZEY2UyZHh1L3liZW55UHRRdXFSQ1BhalgzSHI5WXQvcUp6aGhY?=
 =?utf-8?B?VzAwem1CRUNvd3cvcWZSUkkxeWdMZUVLQjEzRG10eGZSL3FjaXY2UmhsRFdx?=
 =?utf-8?B?c3I0MjVxZndEVkNoeE1HZlBpamNkc1VLbEdNMG4vOEtIb3lmRjR5dnNUT3Ry?=
 =?utf-8?B?U0RsS1NxdkJkNlduM21CejVGcTk5OXRCbFNlaHJvOStaNkp4WGlDUVVyRXJG?=
 =?utf-8?B?M25GeWdKcXMveXdkYTlWYzRXRXk5QUZKUTZvMFVzWWNoNndzdzZ6SWY5eXh4?=
 =?utf-8?B?MFVrUm1weTArWU8rcnBSYzB5c0dvcmJyV1lDSytlUWsrU21aUzllbXM3dk1t?=
 =?utf-8?B?cXpmbnVqeDRuUDU3OGFNS3pISlllSEIwWmxHZlN1RzJHU2NHbUlSWThiVjNT?=
 =?utf-8?B?TTBnM3FEYlNGRHpjWjVBV0hkbHlDR3h6UWE4OC9aRXplbS90WGVSS3hMZ2FR?=
 =?utf-8?B?SXpFNVlRVm10Ti9Va05jK3R0cU5hL1BSb25JN1A0RmdWa2srdEp5QjBaNU9Q?=
 =?utf-8?B?enVkeWpoMzlJaHQ3Zyt6ejA1ZGFQRW5aTFB2MHJRUjNEdmYvTm9LY2doeW1k?=
 =?utf-8?B?M20vaWFqaEVLYXlGeGl1MDgwQ2JCdXE2NDUyNS9UOXVCVm16a2VCVkFQL1gr?=
 =?utf-8?B?Mm51MUFHSGtxc3dMM1RNaXVIQ015NGtMZDRrQmVTS3hSNFVOR3JuRWU2RW5z?=
 =?utf-8?B?ZkhiSUZvK1MxbFUycCs2ZHY5cGF4cWdxYnY2d2Yyb1RGZVFBaEFJL0FqSDJV?=
 =?utf-8?B?elVVUUFSZ2NxVkRCSC9INWovNzl1Sk81MEh1cEZWeTJHMjMvUVdQVGlIS2U4?=
 =?utf-8?B?eWgvT2RTTSt4Uk1pbmlSNG5nVFlsY3NWeWRoQ2ppRUVoYmNRd28vNjIrOWJQ?=
 =?utf-8?B?SkdvR3hTbWZheEZaMGQ4TzY2ZnV6QTJBZ1JWRmduK2tvWGh1cE1ZYUkzcWNJ?=
 =?utf-8?B?dFVnaFpleGZPK2t6YzI3QVZ1dmJIdDlNNUdtTFNNcCs4Zi82cXNrclZqdmhx?=
 =?utf-8?B?dWk3U0VYUjhMbE5yblJFUXNPdFY5ekE0MnNiVThSc1VUdjdUL0N0R2MzUGFI?=
 =?utf-8?B?c29lWnUzUmxIZWpuVVBISWZncFdaK2pQZXAxUnJSTXg3d3Vna0F6TitGTHA5?=
 =?utf-8?B?bngrZmJUMEV5TzdPN0VicU5ZOGNHWWhNQ2w1U3FxWk1iUWFaVmRGUjRRTFJT?=
 =?utf-8?B?WU9NSUdKZzhUQjJLM0tiSDQrSDlLam5wdk5KamhQdS9zc1ptSFVyMndYbU1P?=
 =?utf-8?Q?XHgOHIIOFKK6cS6R/J8PZSQSkaJcYAIA6+Lao=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXRqMjdMMVp2L0xzK0xaaHlXMVAzV2tQZm9VdmJ1N2JqaUJudVJHNHRORXZu?=
 =?utf-8?B?R2xzOU9tRGhFN0ljVzZ1M0lycE8wUURKeEFnYWZjOE81UU40RmF2Y2dROFl1?=
 =?utf-8?B?WWROMnovQjU4V2FCQ1J4K3Y5NCtlQ3lhSnowdXk3d3pPeTQ3T25rQlU5MVhj?=
 =?utf-8?B?QWN6OTYxU1ZOQmJDQkV6T2dtNmxqZlJ5VTExQ05PWnAwT3UweTJHa3FGY2Fk?=
 =?utf-8?B?Z0ZmUXRsbkE2dzFwaWhNbGFLVFRXaU5jVDJWYUJ0RFhDTG9tT3Vmc09qSnhK?=
 =?utf-8?B?K1J3bzNMazREcllRcnJEaTM2WWlhMnBYZjh4TEtEeWRtT2dYeFg4SU1lUE5N?=
 =?utf-8?B?RkM0VmtDVUc2V1Vyam1zdVN1NFFmcENqNmIwaGRrUnFNOVB5R0s4S3FhRDBt?=
 =?utf-8?B?di9mUGNXaFhzRGdta3Q3Z1hySHJ6R3FJamx2UFBycHJKRU1CdnowOW1aZnEx?=
 =?utf-8?B?dzl5OXo0YXpUcDkvSkx3azIwcFAwZnp1aDVBOVptaW9PWXV4YzZaOWx0dmgx?=
 =?utf-8?B?ZmdjTUFLWnMvMEkrMThVTFZqODAzVjBrdk1Nd1k4akVBMm1ualpZZHB1aExz?=
 =?utf-8?B?bzd0SldYcXMwUjRqYzNHRng0citiaXpRN2RLclM2MU1WTGhmQVhabkNTeGZR?=
 =?utf-8?B?Q1dwbXBxa2VBUE1ZRi83R25lR0J1SVNBOVlnODFySE1GeWppK0g1YTB3RlBs?=
 =?utf-8?B?NmxxN1c1Ui9saFV0dGJpNm5sRHVmaVk5QmJwbUhzNmF3dmNXSmxYTnhLdWhK?=
 =?utf-8?B?OFhmcjZOdnBUR2g3a3doL2wwdlpGZHExY2RnQytaTk5hakpEM1FWOGlVS2JC?=
 =?utf-8?B?TUF0TEJiT2hPaGgrdmdLSFpMUSt4Ym0wVFNVNHlNWUh3TzdGVHBRaFBqYVVV?=
 =?utf-8?B?ell1MzVTK3lJdThTd2t2bmJ2YkQxZGY3QnNTRlFTN2FvRFJnTklYK2xSVWNl?=
 =?utf-8?B?enhZZ0NibE5jamxKdk1RL1lBODQrVnhXYXhMakdRNzhlSnBBZTFqZ0k3a3Ew?=
 =?utf-8?B?NThQN2RBRElZSGc0ZmxNWjNyZkEwRHBsMDR2Vll1bnhHYXBYK0FaWHd2UlNJ?=
 =?utf-8?B?ZmFBVUlFcmVRM1dRWmQvNGd1SDYwZ3d5T1JmV0FBOE4rUDM4S2ZWU0VtaDlC?=
 =?utf-8?B?ek5kdVVsTkNhK1BsdXN1MFNzMkp0MnQvZkNyRVhtVllGVG0waWdYWWsrMTYy?=
 =?utf-8?B?NENlZkY2bjdDRjNVQWdYOVRHQlJjbW9hanBWU2RWNU9kb2k4TkRQdjJ0aUxJ?=
 =?utf-8?B?NW1GZVgwWmR6QWI0UXZrc0JTVmE1alFDZU1idFlFSkhzVW5vNWFacWIzRWUy?=
 =?utf-8?B?RDY2dlROMXBkbmxIQUZrd2hXRTRLekNiOWR5NUNIQ1NGL1FXcXJsc1lEVjdk?=
 =?utf-8?B?amtEazZENWFSaDJPWGg3Qkw2OXRuUmsrUEVWdFZjM09sZzBPaTJONTZESS8x?=
 =?utf-8?B?Z1h6V2JtamZPUnIxOTNnWnNCNnhPekJiclA0SzlUVmlKSXdSRnMvKzYvaERL?=
 =?utf-8?B?c2I0SXYzSWllQThpTWhCTlRzYlhVajFKTmJkV29ja0VGaHVUT2VHY1VHS0tV?=
 =?utf-8?B?M2VXSFdLN25VbVl2TjZlc25lUE1ZTnNYZEZ4OXd1eFFOUTl2MzJxM3h3T0hu?=
 =?utf-8?B?dDFkY25qbEprSkNRY3l5Y0tieFhqdGFnb1VSSHg1OUg0MjZyUFFjaWF3MVZM?=
 =?utf-8?B?bTRJZTlPWE8vbXNqREowanAyTXVhalRJbk4wUXN1ZVhXaE8xR0Rua2d6Rnd0?=
 =?utf-8?B?R1l2ZjNCRDgwemxJaHlxVDNLazhBYTJFS1FmR3pDelRhLytNVEJ1Y0ZJbkJu?=
 =?utf-8?B?QUZJVGRBd3VwNE1LQmZxenFQQy9FdmM2MG91OE0wU0haMXRpZnZuTmhFcG8w?=
 =?utf-8?B?R0poMXJUMm5qTG1tTFZWNGI3MkJITDMreXR5OXQ3SmxOMndSNDcxWGx4K3l2?=
 =?utf-8?B?SWtPMSsvWE0wcWRUSmlDYklGeGN0N2VqS0tac1VEa0o2ejVmWmw1emhBU1M3?=
 =?utf-8?B?YzdPcTVocWJYaGUvZGxiR3E1cjNrMG1nS1FIYkljZnlaSU5iUmxCakh0MEJw?=
 =?utf-8?B?WXpTbGcvanRTelBPR1gvajJUT3IzSXpSNW0zMXVKbGw3d3hxVmc3dmNBVDEv?=
 =?utf-8?Q?XyLlCeusn3U6wns8I/DDvIvuv?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36d1f6c-9e34-4afc-7019-08ddde7682d1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:44:34.1298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMfZYYZ1WMcqG8041e+tN4NfjLJiQTEOFHBdTs04M0g29GrlJG+ZaUNGwtRLtIT8GzlI96r7o0PVhyIbeb7dXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8839

On 12.08.25 16:19, Jan Kiszka wrote:
> On 07.08.25 11:04, Jan Kiszka wrote:
>> Hi all,
>>
>> we have been informed that source.denx.de will eventually be shut down.
>> There is no exact timeline yet but we better act earlier than later. In
>> fact, there were already signs that this resource is at risk. Therefore,
>> Philippe and I were considering options before and came to the
>> conclusion that gitlab.com is the most straightforward path.
>>
>> So I started to build up mirrors for all relevant repos under our
>> pre-existing group at https://gitlab.com/Xenomai. At this stage,
>> source.denx.de is pushing all changes also to the corresponding repos on
>> gitlab.com. CI and websites are still on source.denx.de but we will
>> likely change that next week. Once those services are running fine,
>> repos on source.denx.de will become read-only, will stop mirroring, and
>> all development will start to take place on gitlab.com. We will let you
>> know.
>>
>> Still, we would already recommend to update your git URLs, which is
>> basically s/source.denx.de/gitlab.com/. If you find any glitches, please
>> let us know ASAP! We specifically interested if Xenomai user in China
>> face additional access issues now. We already have some mirrors in
>> gitee, but their quotas do not allow to push complete kernels there.
>>
>>
>> Another change along this: We currently have so-called hacker spaces on
>> gitlab.com [1][2] which were created to allow any gitlab.com user to
>> create issues there or actively pick up todos from them. Some frequent
>> contributors also used those repos for pushing ongoing work. We also
>> planned to grant access to the projects CI and test labs, though this
>> wasn't realized so far.
>>
>> However, with the main project moving to gitlab.com as well, there is at
>> least no longer the need for separate issue tracking. I therefore moved
>> all issues from [1] to new main repo at [3] and disabled issue tracking
>> in both hacker spaces. Please continue the creation of and contributions
>> to Xenomai issues on the main repo [3] from now on!
>>
>> And if you are using the hacker space so far for pushing branches,
>> please speak up so that we can discuss how to handle those use cases
>> best from now on. It would be possible to grant developer access to the
>> relevant main repos, but it would obviously be possible as to push to
>> personal forks.
>>
>> Note that this move does not change our patch workflow which remains
>> mailing list based. No one raised the topic recently if we should
>> consider a merge-request workflow, and as long no one does, we stick
>> with our tradition. :)
>>
>> Jan
>>
>> [1] https://gitlab.com/Xenomai/xenomai-hacker-space
>> [2] https://gitlab.com/Xenomai/dovetail-hacker-space
>> [3] https://gitlab.com/Xenomai/xenomai/-/issues
>>
> 
> Quick update on the migration:
> 
>  - gitlab-based websites have been moved to gitlab.com, sources.denx.de
>    pages were decommissioned. Please report any broken links if you find
>    some!
>  - we will switch the primary repos tomorrow morning (CEST), but there
>    will still be mirroring afterwards, just the other way around. Still,
>    please update your git URLs!
>  - ftp.denx.de will be shut down as well, and we are still considering
>    what to do with the historic bits under ftp.denx.de/pub/xenomai
> 

So, the moving should be widely completed by now. The content on
ftp.denx.de is secured, we just need to re-export it differently (via
github pages as well) - a minor change.

More important is that we took the chance and reorganized the group
structure of Xenomai. You will now fine Xenomai 3 related repos under
the xenomai3 group, analogously to xenomai4. That means:

Old: https://gitlab.com/Xenomai/xenomai
New: https://gitlab.com/Xenomai/xenomai3/xenomai

The other repos in xenomai3 are just about the website. Thanks to
forwarding on gitlab.com, you can still use to old URL, but it is still
better to update directly to the new one when switching from
source.denx.de anyway.

Talking of source.denx.de: Mirroring from gitlab.com to the old repos
works now, so no practical change yet. But keep in mind that this URL
will eventually break as the server will inevitably be stopped. We just
don't know when yet.

What is no longer working, though, are git clones and fetches from
git.xenomai.org. That is because we were not able to forward that domain
to the right repos on gitlab.com. Please update your recipes and scripts
accordingly. And if you spot any references to git.xenomai.org in your
docs, please let us know.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
