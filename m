Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2067.outbound.protection.outlook.com [40.107.247.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880C1A255C
	for <xenomai@lists.linux.dev>; Thu, 29 Aug 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946053; cv=fail; b=dwHHMmt/651S0WL8T7WrnGFbPtyWcBqjWI6RGLI7GK4NIArN868XV2kCrvyFeWDskLfGrbMIKykmYuDylHZXUI8w3YJnAxrCVtmIiu0JzKcVG50066CcSFNBFHbinWXkbrphipTszYB4rCgj20z87GoIZEkJs28wIOC7gcRs+zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946053; c=relaxed/simple;
	bh=7bjfhrfSceG1LY3RMme9FoaTTbV12tTd0iu5DAR6Loo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TKiPxPskKPoD0KK5QDRFPO2ld0gFUs+op20SUSqLh8PBIlPS5CQniicYocTMW0EBk4UJgtZz9KSLCj1ruCASwsUEcAaMOuoNAumoI6zr7EbLhGMECuPyU5GzgMsBe73TzGjcEsJqD3I98P9p6eBlKO3yRd4DKg0+CKhF4nZBddE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AGHqqBsO; arc=fail smtp.client-ip=40.107.247.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AGHqqBsO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufn27fuH1SBp5oJpj70RrvrcJd7EHsZi+e2m8teFUXnwdkX8i/JBl5HDwiPtveKOI7t/vh6yriXQscaUDhfXrXRDJOAaXafiPBbJ1Zjn3AMix3ARISiKVzICtpVb85/InVy51kaKgtsHMg/nyg8ega8ML8uVrJI2n+51e9r01gwJs0Uenb6j4Z0z4e0aQeV6hsPwUH6xfKiqIcX0WiMGjEoG9pbv75p2gGOtc4V35O4fBwfu12Gq1dAVnxJb9VLpfqxeAP/xfQgBmfDKGBJ5LQRDpI2UavahDbeRMbQkHp1LZquOeKOk8Noc2521D3qUJAritNDx1ATgPzrryTHzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9JgnBGQxfxpgZ5gaMIRgChRJtuawn5Q9fwhE5UlXAo=;
 b=ZOtmaKBYDP1gnz0g6MTlgXN+BKp3+bhVFEqZZh+Sg2aTvyUPxxNqHpw75mM7PtuUcFkLoB7382jhmuKIUlUVVWmWAXLPh4S3+02WuexX5taurXq92oG8YzJAPGpQTznpo8MaKUkKmMJjLMpdsiJ4X5wjclircb/032koBP7Ltb5d3ksKMRSlx0toCr6ywXBQn3EKyq1iHIQdL4zseva4zwvYjYXZP4VvIhg8X7jEDG+NRMTfUFKbz8kzBojfDTabYQqLXOrs/8GKytNkUoiE3NPXED5/wjHgc26cNGyrDysqJZgGnARWB/3VX6/8Hc+qPfVTc6SMC6WhB1y30+TrOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9JgnBGQxfxpgZ5gaMIRgChRJtuawn5Q9fwhE5UlXAo=;
 b=AGHqqBsOTrHvcxsrf/Onin7iNJBZiD1v1nz3urSm8TBOJhH6EV+RuwOwcsDfAuGoZLzzQbQNVU5iICeVJGrUwWTnFaSFxraaqf5vCCHZ21j9qyYV6gsHGKP16k1bfgzqT0bAd+i7EVhE/UMQp6ywPeLtgZzzDx9PssAG/6vHfypHjyWDEnyuwGzjeQLSdRCE1z2Ki18c7wLo12M+7CVe4TjzAgvEQVbwcb+AWpmDIfoN5bwb4yS1th/pDwYszJJkla2/8GYV3PwG7ar9+6p1RZjCdlVyId2OgMm3JQeBUX5/3tciNShlUQmaeA+Wajo9Guz9couh4p8TzGEKun2sUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB3PR10MB6906.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:43f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 15:40:47 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 15:40:47 +0000
Message-ID: <a44f53ed-cd78-454e-bc4f-e21e54d13ac6@siemens.com>
Date: Thu, 29 Aug 2024 17:40:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add env vars for session and cpu-affinity
To: Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240829083526.24536-1-simon.graber@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240829083526.24536-1-simon.graber@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0032.eurprd03.prod.outlook.com
 (2603:10a6:205:2::45) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB3PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8a90a1-f3c2-438d-f6c1-08dcc840f3bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHI4aHZTL3NWeXl0bmRFSEV3SUpYb1NXenYzbDdTOTZOMlE5RVNlOGNRdS8x?=
 =?utf-8?B?N1hQd0FQQVh3MEc0blZEYTJPUER0emtQMTBCMXF2MkRtR0Z6bmhOaFEzWjZM?=
 =?utf-8?B?NGJNNEJTQlROeGM2TnZsaGpYRU1QQnNXT2J1WktoRHk2Yy9Ja0txMk95c25G?=
 =?utf-8?B?bFd3Z0ppQy9GSGI1cmFZYVducWVGdXZDMFJPM0pKYkFEb3VWODF6dllBYnY1?=
 =?utf-8?B?RzN4U1E5OTFoYnI5Y1pCSUVrWmxCaTE3RG1maFY4UStoRzNWbGRrKzgzV0l5?=
 =?utf-8?B?QU1td3JyNjl1NW1vdzdSMEpGUGFIb1pDKzJnRXpuK1VTdm1ETWo4eDk5b3BW?=
 =?utf-8?B?aUs3UEN2L2l6ZGRiQ3hoNXo1dnpxMHZPT20wZkcvb1Fhdnc2b0lLMzhhTDBI?=
 =?utf-8?B?Sy83ZDdYMHBkNzRaL2lTc3Ezb3N6T2VLNSthcnBJbWRkcmFJdS9Zd3J4Kzdy?=
 =?utf-8?B?alNEQWp2SGZKb3k0NDE4WGZOSEZaUWY5Z1hPMmhuQjJxcWNnZ1ZxY2pSWnJi?=
 =?utf-8?B?OEd4Z21tcTl0eTVCWHZwa2x6c2N4TGZIcDdtSnRFNTZNVG5IM2NkQklQVGhV?=
 =?utf-8?B?MmMxT0tRRTlEbWxvWUhBS0lJUmdudmtJbnlkaFMwY21NdHJCSjVWNmsrdldm?=
 =?utf-8?B?ZnNtTTVJSUpaLzVJSGM4T1lCMDM5SzRmcFBUV2FseHhtNGpFZDZnV1BKaGVW?=
 =?utf-8?B?cWY0MlV0ek1mNTNCcnBCbU82blFualcxOFdrZ3hFbzNPdmhGVlllaDZLVDZT?=
 =?utf-8?B?THJVVDBpaXRwYkV2aEo5ZHcwVkhRckxTYUV4dEVOazZ6UXNyM0wyc3k3cDVW?=
 =?utf-8?B?UTdzblh4SVZVcDlEcXRMcTQxTm1XdnlweU8vZlh0SzFSbG0wYkZPYjFyaWpi?=
 =?utf-8?B?eG5nM1ErVmhST1lqMnVyRkUxTDBraTFQZkxldSt5U1pYb3RXb0pVUC9YWFZv?=
 =?utf-8?B?amZIcnhMWmRZdGNNSFQ4R2tJbXljMWthTDJzd1EzTVFrMDB2NG02Wm1NcGZO?=
 =?utf-8?B?Ujk4dlA4cVlvd3U2NjZXNllXR2YzeHNUSE5jMVNWeTAwT254WGZ4Q2c2eUQz?=
 =?utf-8?B?UHBMUlpBcmthUEpoSXV2YkVraVZzbTVuTy9YU1pPWnlSenZYQ0E5WWU1UnRU?=
 =?utf-8?B?OFhkNENIY0IzNExycU5lcFlhMC9pZVF0UzFwZytEZzhwZG94ckNWN0w5TFB3?=
 =?utf-8?B?Tmx0M01ocGVMOVV3L1RIdlFrQUlPbld2ZTBjY0pFWXV2RGlXNDIrbkh4VHJy?=
 =?utf-8?B?VTlqSCtLSG9hODI3bTkyUVhQMUpKb0ErRnhSSVRqQXlTMFJ6aEF0dFNadWpt?=
 =?utf-8?B?cDVyL3djcmR4bTE5dzE1RWtac0RPK0hRQVcyL2NSWHRaY3k2NkpnQVZ6Y0dh?=
 =?utf-8?B?MkZNckp5bW9KM3pqSVd5R3NXUmtXSW41dFRNZzlJQndBMFJwY2N4RHRKcGN2?=
 =?utf-8?B?cHo0UVR1SURlWFk4TGJJQURDNjFZSnppa25UU3d1M0FONlgxTzhsa3ZzZGJU?=
 =?utf-8?B?T3hRaTRYRlN2Njh6bFhHYzNsWWt2MGlxR3I5bXEyZjVwZExaREovS0pFMDJS?=
 =?utf-8?B?a05sc1dMM3oxUnNiMkF0cDZwc1dBU25USy9Ya25aL0x1RTRTeDlucHhEKzNw?=
 =?utf-8?B?Y2xYcDg3clFNcjZZSUI0OTE4aVFQT3ErL1lWRGdCM3Y3b3BQSmdlOElTOTlu?=
 =?utf-8?B?TzZZeWRzRlB2cjNJeCs5dWlqK1E2dUEvTndYYUVOVGE3czlvWklrRkdLc0lC?=
 =?utf-8?B?dVFPMGhtaTd2eERJenBxQzJ6dmh1eER3M0tpZDh5WTdkQzd2SjZ5WUdEYjls?=
 =?utf-8?B?MEh5TVN5YjhPY0tibTkvZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z25kL01JUmdhZTAwMGZlMWMrL2hiL081WHFZNndhRlJDUnYrYnVxelF2NDQw?=
 =?utf-8?B?K2tNcHJhZ0ZzaFJhSkJPQURkbjJNRDdxcW9rdVZSSG5tZjBmeW91c2JvSWdy?=
 =?utf-8?B?TVE4bExmdmlEWFJFTFh1ajhTSmJ6b1hCcEMveE1FS3B1VERGYXUxMG42Y3Rs?=
 =?utf-8?B?aXVnV012MnlNZEhyaGErbXErSlVaZnlPNzBYOEtXeldMaytJbGt2cXBVc1No?=
 =?utf-8?B?NUd6Wlh1dURDUVI1SXhraU5OcDcyRlhYZm42eG5ZZkFHLzhsbFRWMjJmMUE4?=
 =?utf-8?B?dm9GRGtvNk05ZVJUdWsxMDgyUHgvVVJWWElFYThiOWc5VnVKdU1CdGZKOW5S?=
 =?utf-8?B?b05MRVFqUi9jUDQrMktYVUhoTTFiQVVoZVgvOGc2L3ZTNDQzNzMrU0lRTEpU?=
 =?utf-8?B?SlU3UU9JL2RJeVkrQkxnUmN0WVo1QlhpUnFmTzJrRTJEYWRQNzJiNFlUMlFm?=
 =?utf-8?B?cFpRNUd3djdJME9BTEh3QnRQbWxEUUc3bTRQSUNXUTFrelNndG5NcTJLK2s3?=
 =?utf-8?B?dGdKSXQrSGNhS0xiOHpjdzdGcHNtWXdieFhyUEFyT1AzQ2hEcXlDd09qdy8y?=
 =?utf-8?B?ZUh2SGo4MkRsWTBPdU44cUlpWVFHZUk1Vld0b2l1bjRjQk9sYnJKY0RFMGRV?=
 =?utf-8?B?Y3YyWkExd2FsSEt6T1V5Si85dGUrUVBEaTdCWTBxSDZaN2ZPNWo5TFZGMUdy?=
 =?utf-8?B?UFJ4aFJrRzVtbUtEYnJWNk5kNCtNQVFxTllPWnE4Q0RWUllBTVRvSUVxNlBk?=
 =?utf-8?B?Z1hZS3I1MU9VN2VFQTJRUkFnR0hLajR3S2xKdW1WTXpMYThISzFUYnhNOHhh?=
 =?utf-8?B?cFB0WnNqalcxNi9PczNwWnhTTmJWMmo0Vk5DelZYRjNMRXAzL2djbDJDdUg4?=
 =?utf-8?B?d2ZjUERpMHlmV0JoSFc2eFRNdDZLVjZTVlE3dWNQSXgwR01JaWVIczRSUG9u?=
 =?utf-8?B?UHpQalNkZmdDbnZCQ0lCS0NCa2ZSTG5neFRtWFBVQUtJRjREOHEwcXdIdmVC?=
 =?utf-8?B?V1BFZGRsVXVPaVVMTGZrSjVlVUlieCtpSCtHYktsZUtzZEpTY2E0RXJQVUt2?=
 =?utf-8?B?Um5FVVQzVTVYaGQ2bi9mTDNuRGF5WUtiN0NYbUlGSDEvQTJqMitldVFBM05I?=
 =?utf-8?B?UStseEhkdm90NjU1b1NaYllEUlJEZ2w3WUx0Q2N3Y2ZiQmpWblNsQi9qWUxw?=
 =?utf-8?B?SmQ4SzZ5Z0tjM1A4T1pOd0xxWjIvRkRTRmloczJqb3BxRGt0WWtjZEdWdmtT?=
 =?utf-8?B?SWMwSU1MaURBY3A0RGJLY0tsVXRlZHY2YmNjd3VGWUhZQXRPZStFYUxhdnpi?=
 =?utf-8?B?MStRdHkrcVR4eE8xSFQ1Mjg4UkZhazRJZzZlRnZvSGdTRUFzR0UzdmZnbjYy?=
 =?utf-8?B?cWZwVHMxNmJZT0VHdmxZNWJOQy85S2dCOEJsNmVKb3JtQXNUUXNSSzFHSFp5?=
 =?utf-8?B?Um5OQmNPN3BITll0MjlrT1lmSS9jaEs3TWpPcDZTZHpuMitYT2ZkYmFlSWls?=
 =?utf-8?B?UHR3VzZXNnRIcUVFNldNWi9IV0I5UzlnUjZrUy96SGtvbEVRbTdaNGp5dWRt?=
 =?utf-8?B?UWVRR21LakY2bU9EaGUrRGw4c2I0aHA1QWNwVFQ4dFB6VlFpUTR5czRpWlBD?=
 =?utf-8?B?bk15Q3JEd0MyRVNpelQrSG1FT1JiM2VEQWc5N1BmMHcwL25EM25ZanZmcGNj?=
 =?utf-8?B?elR2RVlXaGdHRy9LQ05HOGJkeEVSNlExb1ZpbUZGbHQ5eTNKQnhNb0hKL0h6?=
 =?utf-8?B?Yk82OE1lS3dYM2k5ZEtSVzU4ek5aMHRGY3JROUZLMDhIaFIwVHVHSmtQbGor?=
 =?utf-8?B?aVpjWnNmZGJQVWdvQXcyaDNENFBHb2h3TmdQcFV4Y1Y3amVmNDVEcmtseDNa?=
 =?utf-8?B?ZDlXbm9yc3JCeTNld2lhVldybWdHeURBNVhTWUtxNEsxa0xxYkVHdUhQakNL?=
 =?utf-8?B?UUtPMUo4b2xUNTdFOHNyV1RtblpITXJjSk9rMTg2L1I2QVp3NDViM2dTV3hX?=
 =?utf-8?B?QTA0UkhVRjFmRFkzc1kvb0t1blIwU3BRRWFxajl0ZGkwMktTbHNtbmg5ZmNy?=
 =?utf-8?B?WmF1K0ZrZGgvQnRmMGRIaTZQeDEvNGZ4R3BPMUVXYk95K0hLMjZhOWhwN0JN?=
 =?utf-8?B?MnpiRjZwR0duVU9VMWI4U1BsY0Uyb3ZwZzhRcy9pNmVjWk1XZmV4MWRLMk1s?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8a90a1-f3c2-438d-f6c1-08dcc840f3bd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:40:47.4002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yljRzu3CIUCMulxpvSMfVRiwn5AGr2U458mAEQcyc05Z/voWp4KZFrxbQYXGF2C83I9bOGpImMDo9L4B2bf0cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6906

On 29.08.24 10:35, Simon Graber wrote:
> Hello,
> 
> Revision 3 of this patch adds documentation for the new
> environment variables.
> 

Please also put the version into the subject:

[PATCH v3 n/m]

Makes it easier to tell the threads apart.

Jan

> Changes since v1:
>  * Usage of environment variables is documented
>  * lib/copperplate/init.c: Conditionally query XENO_SESSION_NAME
>  * Reformat patch 2 to adhere to code style
> 
> Simon Graber (4):
>   lib/copperplate: Get session name from env var
>   lib/boilerplate: Get cpu-affinity from env var
>   alchemytests: Set cpu-affinity by env var
>   Add documentation for env vars
> 
>  doc/asciidoc/README.INSTALL.adoc             |  7 ++--
>  lib/boilerplate/setup.c                      | 39 +++++++++++++++-----
>  lib/copperplate/init.c                       | 21 ++++++++---
>  testsuite/smokey/alchemytests/alchemytests.c | 10 ++++-
>  4 files changed, 58 insertions(+), 19 deletions(-)
> 

-- 
Siemens AG, Technology
Linux Expert Center

