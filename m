Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F3D2040BA
	for <xenomai@lists.linux.dev>; Wed,  8 Jan 2025 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357455; cv=fail; b=iVleD2nyU/rK2qCe18t9OEblsDrtzt6jav8Q4lNhX8ZuZe4nroA41SoWWFEi053dHAU6z5LkrpDZz60vEE+8+PuNl0Z6UQN+lmkDZ11QexpwelDiYFTA0HICVc8P0Z3EUoK5uOmGSK5anVyaOcCrKSEY2pGLcYzqLx11P93+R4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357455; c=relaxed/simple;
	bh=jTjlT01W9bK4B16IV2S8bJycq69ttBwEQGKsa9P/2Vw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kt9MCJ/PihwYWtW7PBtNPhJJ7XThkAjib7KyMXNKHUMPY7bshYIvvsGDP7XF4AxKulKfeM1VSwVocgpiZJB4v5kV9gLZjdyM4ZVZnKihL9eTLEPLfIAZFtR6qOiA1CT9hA+2EaP0+LFrMkMZfE96GP4wv9QDSQH0FxaPcFQhZPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Tv/uxoUk; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Tv/uxoUk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXW6gOMH17utRNL+ejSdjIyVEmSH7Qvu7x4fAAaGElyRDyAvLQfN/9gWk8v672MFxYzS68hpQkVfrttm7TCBERUj8fJMpFHEd/LQ22u8AsFll5+QeWU3xWEL1krl1iUF1N9PGT/+qZGBfX2bwrhcopB4tTQMGCHUWg5/mCAmCKYe36om4vgF0XjbU9/HTuvSY3W46tywX9g4iGgWuu33B1BX3d8xjrD5TAtGz34ovGtEeD2i5njN46NO7Cgq1S9DO7pdpYZZxRz+5vDI7XNrBMuy+UTOnMZraawjgmGDavLhLokh3ujhILlhpUCGNa1VQ4IWIIm8Jryw3vdZXYF3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lGqqJAmRWh5/TvQ0JDxF0d6HnjIZFo/yfeABgyNvzw=;
 b=RtFBwvguwWHqqNlOGz6Je3ePpZnJIlSIYYteI3MkgiXUFz/Y9NgHlfXXuNX9prglBf+972qbgCTVtYOtwstBQzloaRfqkKCFI6zk6pEBH+ueMHK9nXqbGpyU2Snat81zjfjpMvQBs6f9yuv7Vf2fxx/HJchccmLGxm55QPYrZjfP+M/tbRrC1SVBVTrYZ9wSQtYfw1szSZS+XfS49tbip8eWG1Ra0yVMFt2K+o5Qd69EYWQQROMGMEpjrZHt8NH7SeveDRGsXVkKksKaIFdegecpowMCkm91HOYXHbXjpbnWCZVeCJE5Y0qjQnkpTmFeLjFs7YrSsFipwkUsRZJqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lGqqJAmRWh5/TvQ0JDxF0d6HnjIZFo/yfeABgyNvzw=;
 b=Tv/uxoUkjLUBxOA/Mp61SHdzfptFC+FgvSX0PQJyReFA6fcgnfdRe3p5PLK4HaksHs+JjZ3GsCJHNSpH/pDdPlHocAzcsKBCVgBqCVspEuAc14fk61Ixd74mOFrVY4Stvue2HKrHPSkb1j0RhQHRg4mJCB2guRbJPKgH7vI+HDG6X9SSc6eOJ67df3437G/J/W5dU9gU1Bb0Ut0tdkLinljeoyMLNx46ztDvepje95zd0nHnSjbCyBFh/QhRKyRsPcRQUWcOVyppDe+PxJ/5mCNlgrGw9q44ONXRDUVo3hymZlyFHcorYOeuLbiyFK3Yyu9H5jnh/J1KFeioigdt9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4115.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 17:30:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 17:30:46 +0000
Message-ID: <99a11fe9-3a89-4ef6-ae4a-b710113ee92a@siemens.com>
Date: Wed, 8 Jan 2025 18:30:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kernel: Reformat all Kconfig files
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20250108172406.3640115-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250108172406.3640115-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d3985c-f874-4fbf-b175-08dd300a2f87
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2dZVEt3QUdUWUt2cENxa25qWXBBR3NkYWxLOFNzdnBLVmQxbGRtekJ2Mkwy?=
 =?utf-8?B?a2Vmb1I3c2pCUlJJdzNxM2tHL3d6YkhZNERuQytrOW5NNlR4WjBLZHdBWXl4?=
 =?utf-8?B?NWw5ME1KTURsOWp0WnVBN3cwTUUvc29hcldyQ3dHZXRKUWdtZUI0VklyaTZ5?=
 =?utf-8?B?ekJOaVRsZXlMTU5mY0tIVnNxbW5Fb1ltKzVPYkwvSS96OFFnSjlzSDhBM2lG?=
 =?utf-8?B?Z0JFSTRqTE5zTkxPckhSNmw4TTlvejVKOEgwaG1ienQzNk1oWjY5Rm4yQ0pV?=
 =?utf-8?B?UHFnNUI4eGlGQnVjbjFTZjNqWU9ncUo4d1BrcUNWSStwMmRQZ3I3Ykk2dWgx?=
 =?utf-8?B?aVVoczkzbHlYSkF3WTZ1aWF3LzIybmQ1OWtPTHYyQ2R0UVA3RHhJbTRSOVMy?=
 =?utf-8?B?U2NYSnNSOHJkU0d6NFl1c09obGVSZkVOK3QyVDFnZjUyTHNhZW44aHh5bm1I?=
 =?utf-8?B?MHRKdG5NWjBZNjZWWUo4aWtYYkdqdlhGazhscnBqOGVHaDAvQ3pqSWRBamI5?=
 =?utf-8?B?UmpxU3dYRUYrM0ZMYzEvWXFHQ3NhYm4zMkFWOHF6YlBZOWUxMkhwNWhZRlU2?=
 =?utf-8?B?Y1ZjQzA4emNtUFRIZExXVWhZcm9SUDA4ampZUEtiUEo2TmJ2MUR1b0VFWVNp?=
 =?utf-8?B?N3NwejJGSkRibUVEMzZxbTYwaElIcWtFdGZBYlg3Zmg0dENLcXRFMTVyYXpR?=
 =?utf-8?B?WW5Ob2xHYS91bmdsVWU1NmhhbFdNdWE0M3VDamZxUEt4ZnQ4WWVNdFpLV3Ro?=
 =?utf-8?B?b3c3VEhiaFgzSnFNNTdwVEgybnZtSVA2MXlxRUpEdmVHcURIV0dsc1BiYzV3?=
 =?utf-8?B?UGtUZmdNdEppMjZid3VmckxaTDAwb3Y1aVpUSWVISm1CYWl1NHdVM1Bud2Jw?=
 =?utf-8?B?M2h0NlBkRlZSU0IxeS84NU83bEtkZ1pxNk9RcFdCdFJiU1hGcVlOd0E5aEV5?=
 =?utf-8?B?aGdiWjdEWVBCajY1ekxqSmNsM1FFODMvY2RsYXB6RlpTbGs4SGZFVkFMUC9J?=
 =?utf-8?B?bFFpWTF5VUh1LzBWSFpWN2dhSHNWQkIvVTdvMFlxb041OXgxZUY4K3BGS1dG?=
 =?utf-8?B?U1VGU2FoUGlVSHZ0L1diZ0ZKa2xJcnNOdjZYTGFnL0x2Vzc3OW9senRtbmlu?=
 =?utf-8?B?WFFBSitIVVBHbm5veHJDai9jeVowNVUyU01CVUIvQm1vR1pHVXlJait4angv?=
 =?utf-8?B?REpnbE5ibzljTFBJUFBBY0haN0xKSEJhOHFGVUxGTUxFa0FzcFY1OTU4NExy?=
 =?utf-8?B?Q1J4emtpalMvamx5V0ZLTG1idmdNSjBIMzZQYktFemE2b2NxT1hZcWIyeVp4?=
 =?utf-8?B?V3dYVTBILzQxby9YQ1ljNW1MK3lVRnVIOFVYVDJVOEJZY2FvOHhJaE9GT0JY?=
 =?utf-8?B?UHh6cXFZcGswcFkrMmMzdG9kaEduU1AvcitmdHBoTlpqSGJsTDE0S2luSmFq?=
 =?utf-8?B?aDNkcVZ1Wlg5WFVjb1JQdjg4TkpQRS96VUpFYVpQcTJkbzBpbUR2K1lNU2Q4?=
 =?utf-8?B?dDh0WTVtby9TdFNZcHVtU09Nak5nbzBWQWhDb0E5MlZWcWJJcTJGZW1lakJo?=
 =?utf-8?B?T08veWZzU3F2TWhHWEJGTzY0VlRYeGJMWk5rMHRTU0hqVXZBdlhvU0dZMFlJ?=
 =?utf-8?B?eUY2VTZNYWRYSVk5ajhCOE5KaCtmSGpZUkt1U2pTTEltS3cyN2QxK2dEMnk1?=
 =?utf-8?B?c1FpUjhOa2lYTVNUdldDRlNRempqOFlyMTI0TTRuc0VaeGxvRExydUkweFNy?=
 =?utf-8?B?K1dDNk5oaHNUMkxXSEN1aEVSaVFCQlF3MkI4L2dBZk9QbnBVVkIwWG5UdUJw?=
 =?utf-8?B?ZXZER1lsZ3g3eitxaEFMaEI0dkVudG1nTlhnZHBMcndXeFpaNnNnSVpJRGhs?=
 =?utf-8?Q?CfVDReCUzoqOM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFRtZklnNHFkSkJLR1M1WkVhdkZ2RkU2L1dEUmhOelBnQWxuMGhNL3lacHVC?=
 =?utf-8?B?VCtmMWs2QWZkM3lUZzRhVVh1WS9iWEdyYzBqaCtsWU04RGp0UTQzWlJRSVpp?=
 =?utf-8?B?WUdETkozeGxHV1NwQjFmNGRUOGVIY1YvRUZKbDFqajNIM3B1bktyVHZNNTkr?=
 =?utf-8?B?YTBWT3RBWko2dzNBbWtDeEpydzNRekJvNTc5aGZqa2RPWHdEaEtGclkwMVR2?=
 =?utf-8?B?QjRRVnQ5RVFqQU13VXI1VklEandia09LVjZjdWFmR2lSaGtsWklFR1BJWjlL?=
 =?utf-8?B?MzlYaE5vRUtLaXo4aDZKMDVvSHYrcDNZU1hFU3lWeGh6VTFERjl1SEFuTDRC?=
 =?utf-8?B?LzdxZll5RXNDTnFUMmZtK2FhVW1QS2tMYXhiOFhrRkpReXMvUW5lR3l4OGF2?=
 =?utf-8?B?cDBUdFVkclpUMUhoRGs3QzV0NU8za2lEdy91alJwVXlxeXlMdEY0dnVTQ2dW?=
 =?utf-8?B?aC82bXEvOHRTMU15NmRkRlBVL3N5VUl0M2lOWG5IeTM4Nk9GSDRXdzhDSGZW?=
 =?utf-8?B?YkxGbUJlcFBRWUVIbjFyZ1NUMDlSYzBtTnl3bHdtWFpKUDg0WE5mMEZVUWIw?=
 =?utf-8?B?M1hNamtWQW41blpBWFBrWk1mODVnL1VzaHA1dEtFMU53aUNuYXZnTnk3dllG?=
 =?utf-8?B?L045NGsyb3JsaHBpb1U0ZStkUEJsVzRDb2ova1AreEtHb0F6a2x4S3NpYmZO?=
 =?utf-8?B?VjlycFpCQVRZQ2dnTjZBeGRuMk5KRTNBeGEvOWhXRGNYTjluMkdIdXdFN0I5?=
 =?utf-8?B?SGtUMXhKTGZ3WVpMVlpnSG90T1VDSTNLdlFEWlZuUzcwYXpTVzBBbnpVMTZ1?=
 =?utf-8?B?VW1PU2Y4S2l1UXMvUVI3YnExNXJTcGdIZjRLUXhhbnJheW9oNWE2SHhYT212?=
 =?utf-8?B?ZDRCOUp6U2FtU2h6Zk1KNFVjd2VzM3o3RUxOZUNQeXB6YjlYZWpmNWJ4aWRR?=
 =?utf-8?B?cW9rSGVsUUVrWTMzVlpEbXFwbXpEbkN4L052dFFMWHdld3M4ek5xd1k5Vkll?=
 =?utf-8?B?WW15dDV5dlQ5QkxXK0RwcVU5RW9IQ3k1TFExOTBFTXhTZTR0Zm9BKzFSZ0FS?=
 =?utf-8?B?Zy85bi9wcUxkdXZZdGNIWTVibGUyNUdpSXFCQWdVcXBnL0hBZ2xiOHNaWmcw?=
 =?utf-8?B?dDlLc2NyRjZONTRuNmJvbG9Nc3M3MEs2Slk4SzkzdFZqbUM3TFRZUGZIR3lv?=
 =?utf-8?B?VUQyaittbGg2WDdodUh2OFRQclBPdTJyeGNZYnRFZWFFZXV6V2EyQk4yQjVI?=
 =?utf-8?B?WGhiVnR3Rk9PSmpOTEpudmdkRy9tclRJZEFndjNESXcrOE1kZ3JPRnh1a2Y3?=
 =?utf-8?B?b1RNZGhKODRVWE1LYXNSTm43QzZySzRDd2pOTXdRWU1Hb25CREhiTFZTYkVQ?=
 =?utf-8?B?WVJ6TTBYdmQ5NElLbDV4Tm5MVkppVVBSbkthaThnUVY4NUY5dW1hUExpcFMy?=
 =?utf-8?B?UDhFZXVKdlg2dXJxM2tLNjJiallVNUNwSGlaYkdMRzAxZnF6MTB0elY5c3cy?=
 =?utf-8?B?QW8zU3h4RE1ZWHVQanZsQmp6bXBMMzVLeFRPQ1MxdGFHd2VINHAxa3NSSkZw?=
 =?utf-8?B?NGp5aDFpdDhxSVpLcWhzejVXalhDZk45WjlydG9QRDJxMVAyMmM2QmhYTVRj?=
 =?utf-8?B?ZlNVT3ZBMndtenpOLzdCYWt0R1VSZUVyUkR4QW9tT2JOa2tGdnlTN3NUNE5F?=
 =?utf-8?B?dTU4ZFduNE5SWndiWHlHcjFYSVhOKzZFNnhCTERWTDFLOVgwMTVVN2lzeGlt?=
 =?utf-8?B?VFNQT3g0OHhHRHNVNnJQQ0NNdi8vaGVZYUVmcUtVOW1qWnVKbDdVWWE1eW5V?=
 =?utf-8?B?aGVHUzRvT3hGR1h3NzZ1WXJlb0I0R3ltTVJvYUE1ckF5enhSdHBzeCtlYkNx?=
 =?utf-8?B?d0xxdDBZM2NpNGdDRy9pSy9BamFTVDJReVJkUlkzV3A5QjhZRTVHUmZ2RlZr?=
 =?utf-8?B?b3hldWZNV0FMRU12SUZpOVkzNXpiQWZsZjMrVUNhd25PbTl4QktmV2o0WkVN?=
 =?utf-8?B?Yk9XSmdTSklabjEvTTZDOWhJN01kcmlmYmJoYm1BRktOZ3VHblZPMjlaV0RT?=
 =?utf-8?B?TC9ZWFFSUUI4YnN2MXNuN2NKbDhCZndiYURPd1Q3ODk0U1ZsNWdWaGN0QVZN?=
 =?utf-8?B?bmFLRllWWUtmcmdEYkRrMkhWdXFOenduNWZ3TkVpbDM4aUhvTTNCL3NPTWVT?=
 =?utf-8?B?blE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d3985c-f874-4fbf-b175-08dd300a2f87
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 17:30:46.3120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1rfoMvdTgZrPSur7/2rU/zofrLhyV+1jbUfIZ4/oT2lazwn1NiHSj3XYLXnyqF7ryy91H8F1bScvmF45XxGcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4115

On 08.01.25 18:24, Florian Bezdeka wrote:
> A lot of white space conversions and reformatting of the help option
> according to most upstream files.
> 
> No functional change.
> 
> Typo fixes in the following files:
>   - kernel/drivers/net/addons/Kconfig
>   - kernel/drivers/net/stack/Kconfig
>   - kernel/drivers/net/stack/ipv4/Kconfig
>   - kernel/drivers/serial/Kconfig
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> 
> Changes in v2:
>   - Addressed review comments from Jan (kernel/drivers/analogy/Kconfig)
>   - Converted leftover whitspaces in kernel/drivers/spi/Kconfig
> 
>  kernel/cobalt/arch/arm/Kconfig                |  10 +-
>  kernel/cobalt/arch/arm64/Kconfig              |   8 +-
>  kernel/cobalt/arch/x86/Kconfig                |   2 +-
>  kernel/drivers/Kconfig                        |  22 +--
>  kernel/drivers/analogy/Kconfig                |  63 ++++-----
>  kernel/drivers/gpio/Kconfig                   |  49 +++----
>  kernel/drivers/net/Kconfig                    |  20 +--
>  kernel/drivers/net/addons/Kconfig             |  66 ++++-----
>  kernel/drivers/net/drivers/Kconfig            | 130 +++++++++---------
>  .../drivers/net/drivers/experimental/Kconfig  |   8 +-
>  .../net/drivers/experimental/rt2500/Kconfig   |   6 +-
>  kernel/drivers/net/stack/Kconfig              |  46 +++----
>  kernel/drivers/net/stack/ipv4/Kconfig         | 110 +++++++--------
>  kernel/drivers/net/stack/ipv4/tcp/Kconfig     |  28 ++--
>  kernel/drivers/net/stack/ipv4/udp/Kconfig     |  10 +-
>  kernel/drivers/net/stack/packet/Kconfig       |  24 ++--
>  kernel/drivers/net/stack/rtcfg/Kconfig        |  38 ++---
>  kernel/drivers/net/stack/rtmac/Kconfig        |  22 +--
>  kernel/drivers/net/stack/rtmac/nomac/Kconfig  |  16 +--
>  kernel/drivers/net/stack/rtmac/tdma/Kconfig   |  34 ++---
>  kernel/drivers/serial/Kconfig                 |  56 ++++----
>  kernel/drivers/spi/Kconfig                    |  21 ++-
>  kernel/drivers/testing/Kconfig                |  12 +-
>  kernel/drivers/udd/Kconfig                    |   5 +-
>  24 files changed, 393 insertions(+), 413 deletions(-)
> 
> diff --git a/kernel/cobalt/arch/arm/Kconfig b/kernel/cobalt/arch/arm/Kconfig
> index b0cbdc3b7..080f9df80 100644
> --- a/kernel/cobalt/arch/arm/Kconfig
> +++ b/kernel/cobalt/arch/arm/Kconfig
> @@ -5,12 +5,12 @@ config XENO_ARCH_FPU
>  	def_bool VFP
>  
>  config XENO_ARCH_SYS3264
> -        def_bool n
> +	def_bool n
>  
>  config XENO_ARCH_OUTOFLINE_XNLOCK
> -       bool
> -       default y
> +	bool
> +	default y
>  
>  config XENO_ARCH_IPIPE_COMPAT
> -       def_bool DOVETAIL
> -       select IPIPE_COMPAT
> +	def_bool DOVETAIL
> +	select IPIPE_COMPAT
> diff --git a/kernel/cobalt/arch/arm64/Kconfig b/kernel/cobalt/arch/arm64/Kconfig
> index 14e5fa1c4..2ea82ce48 100644
> --- a/kernel/cobalt/arch/arm64/Kconfig
> +++ b/kernel/cobalt/arch/arm64/Kconfig
> @@ -5,9 +5,9 @@ config XENO_ARCH_FPU
>  	def_bool y
>  
>  config XENO_ARCH_SYS3264
> -        def_bool COMPAT
> -        depends on COMPAT_VDSO
> +	def_bool COMPAT
> +	depends on COMPAT_VDSO
>  
>  config XENO_ARCH_OUTOFLINE_XNLOCK
> -       bool
> -       default y
> +	bool
> +	default y
> diff --git a/kernel/cobalt/arch/x86/Kconfig b/kernel/cobalt/arch/x86/Kconfig
> index 9adbbf79d..dd08a5a3a 100644
> --- a/kernel/cobalt/arch/x86/Kconfig
> +++ b/kernel/cobalt/arch/x86/Kconfig
> @@ -2,7 +2,7 @@ config XENO_ARCH_FPU
>  	def_bool y
>  
>  config XENO_ARCH_SYS3264
> -        def_bool IA32_EMULATION
> +	def_bool IA32_EMULATION
>  
>  source "kernel/xenomai/Kconfig"
>  source "drivers/xenomai/Kconfig"
> diff --git a/kernel/drivers/Kconfig b/kernel/drivers/Kconfig
> index 197a48eef..a0781c4bf 100644
> --- a/kernel/drivers/Kconfig
> +++ b/kernel/drivers/Kconfig
> @@ -4,21 +4,21 @@ config XENO_OPT_RTDM_COMPAT_DEVNODE
>  	bool "Enable legacy pathnames for named RTDM devices"
>  	default y
>  	help
> -	This compatibility option allows applications to open named
> -	RTDM devices using the legacy naming scheme, i.e.
> +	  This compatibility option allows applications to open named
> +	  RTDM devices using the legacy naming scheme, i.e.
>  
> -	fd = open("devname", ...);
> -	   or
> -	fd = open("/dev/devname", ...);
> +	  fd = open("devname", ...);
> +	     or
> +	  fd = open("/dev/devname", ...);
>  
> -	When such a request is received by RTDM, a warning message is
> -	issued to the kernel log whenever XENO_OPT_DEBUG_LEGACY is
> -	also enabled in the kernel configuration.
> +	  When such a request is received by RTDM, a warning message is
> +	  issued to the kernel log whenever XENO_OPT_DEBUG_LEGACY is
> +	  also enabled in the kernel configuration.
>  
> -	Applications should open named devices via their actual device
> -	nodes instead, i.e.
> +	  Applications should open named devices via their actual device
> +	  nodes instead, i.e.
>  
> -	fd = open("/dev/rtdm/devname", ...);
> +	  fd = open("/dev/rtdm/devname", ...);
>  
>  source "drivers/xenomai/autotune/Kconfig"
>  source "drivers/xenomai/serial/Kconfig"
> diff --git a/kernel/drivers/analogy/Kconfig b/kernel/drivers/analogy/Kconfig
> index 858762bda..bb838abbf 100644
> --- a/kernel/drivers/analogy/Kconfig
> +++ b/kernel/drivers/analogy/Kconfig
> @@ -3,50 +3,45 @@ menu "ANALOGY drivers"
>  config XENO_DRIVERS_ANALOGY
>  	tristate "ANALOGY interface"
>  	help
> -
> -	ANALOGY is a framework aimed at supporting data acquisition
> -	devices.
> +	  ANALOGY is a framework aimed at supporting data acquisition devices.
>  
>  config XENO_DRIVERS_ANALOGY_DEBUG
> -       depends on XENO_DRIVERS_ANALOGY
> -       bool "Analogy debug trace"
> -       default n
> -       help
> -
> -       Enable debugging traces in Analogy so as to monitor Analogy's
> -       core and drivers behaviours.
> +	depends on XENO_DRIVERS_ANALOGY
> +	bool "Analogy debug trace"
> +	default n
> +	help
> +	  Enable debugging traces in Analogy so as to monitor Analogy's
> +	  core and drivers behaviours.
>  
>  config XENO_DRIVERS_ANALOGY_DEBUG_FTRACE
> -       depends on XENO_DRIVERS_ANALOGY_DEBUG
> -       bool "Analogy debug ftrace"
> -       default n
> -       help
> -
> -       Route the Analogy a4l_dbg and a4l_info statements to /sys/kernel/debug/
> +	depends on XENO_DRIVERS_ANALOGY_DEBUG
> +	bool "Analogy debug ftrace"
> +	default n
> +	help
> +	  Route the Analogy a4l_dbg and a4l_info statements to
> +	  /sys/kernel/debug/
>  
>  config XENO_DRIVERS_ANALOGY_DEBUG_LEVEL
> -       depends on XENO_DRIVERS_ANALOGY_DEBUG
> -       int "Analogy core debug level threshold"
> -       default 0
> -       help
> -
> -       Define the level above which the debugging traces will not be
> -       displayed.
> +	depends on XENO_DRIVERS_ANALOGY_DEBUG
> +	int "Analogy core debug level threshold"
> +	default 0
> +	help
> +	  Define the level above which the debugging traces will not be
> +	  displayed.
>  
> -       WARNING: this threshold is only applied on the Analogy
> -       core. That will not affect the driver.
> +	  WARNING: this threshold is only applied on the Analogy core.
> +	  That will not affect the driver.
>  
>  config XENO_DRIVERS_ANALOGY_DRIVER_DEBUG_LEVEL
> -       depends on XENO_DRIVERS_ANALOGY_DEBUG
> -       int "Analogy driver debug level threshold"
> -       default 0
> -       help
> -
> -       Define the level above which the debugging traces will not be
> -       displayed.
> +	depends on XENO_DRIVERS_ANALOGY_DEBUG
> +	int "Analogy driver debug level threshold"
> +	default 0
> +	help
> +	  Define the level above which the debugging traces will not be
> +	  displayed.
>  
> -       WARNING: this threshold is only applied on the Analogy
> -       driver. That will not affect the core.
> +	  WARNING: this threshold is only applied on the Analogy
> +	  driver. That will not affect the core.
>  
>  source "drivers/xenomai/analogy/testing/Kconfig"
>  source "drivers/xenomai/analogy/intel/Kconfig"
> diff --git a/kernel/drivers/gpio/Kconfig b/kernel/drivers/gpio/Kconfig
> index bc9cbc5e9..94943388f 100644
> --- a/kernel/drivers/gpio/Kconfig
> +++ b/kernel/drivers/gpio/Kconfig
> @@ -1,11 +1,10 @@
>  menu "Real-time GPIO drivers"
>  
>  config XENO_DRIVERS_GPIO
> -       bool "GPIO controller"
> -       depends on GPIOLIB
> -       help
> -
> -       Real-time capable GPIO module.
> +	bool "GPIO controller"
> +	depends on GPIOLIB
> +	help
> +	  Real-time capable GPIO module.
>  
>  if XENO_DRIVERS_GPIO
>  
> @@ -13,67 +12,59 @@ config XENO_DRIVERS_GPIO_BCM2835
>  	depends on MACH_BCM2708 || ARCH_BCM2835
>  	tristate "Support for BCM2835 GPIOs"
>  	help
> -
> -	Enables support for the GPIO controller available from
> -	Broadcom's BCM2835 SoC.
> +	  Enables support for the GPIO controller available from
> +	  Broadcom's BCM2835 SoC.
>  
>  config XENO_DRIVERS_GPIO_BCM2711
>  	depends on MACH_BCM2708 || ARCH_BCM2835
>  	tristate "Support for BCM2711 GPIOs"
>  	help
> -
> -	Enables support for the GPIO controller available from
> -	Broadcom's BCM2711 SoC.
> +	  Enables support for the GPIO controller available from
> +	  Broadcom's BCM2711 SoC.
>  
>  config XENO_DRIVERS_GPIO_MXC
>  	depends on GPIO_MXC
>  	tristate "Support for MXC GPIOs"
>  	help
> -
> -	Suitable for the GPIO controller available from
> -	Freescale/NXP's MXC architecture.
> +	  Suitable for the GPIO controller available from
> +	  Freescale/NXP's MXC architecture.
>  
>  config XENO_DRIVERS_GPIO_SUN8I_H3
>  	depends on MACH_SUN8I && PINCTRL_SUN8I_H3
>  	tristate "Support for SUN8I H3 GPIOs"
>  	help
> -
> -	Suitable for the GPIO controller available from Allwinner's H3
> -	SoC, as found on the NanoPI boards.
> +	  Suitable for the GPIO controller available from Allwinner's H3
> +	  SoC, as found on the NanoPI boards.
>  
>  config XENO_DRIVERS_GPIO_ZYNQ7000
>  	depends on ARCH_ZYNQ || ARCH_ZYNQMP
>  	tristate "Support for Zynq7000 GPIOs"
>  	help
> -
> -	Enables support for the GPIO controller available from
> -	Xilinx's Zynq7000 SoC.
> +	  Enables support for the GPIO controller available from
> +	  Xilinx's Zynq7000 SoC.
>  
>  config XENO_DRIVERS_GPIO_XILINX
>  	depends on ARCH_ZYNQ || ARCH_ZYNQMP
>  	tristate "Support for Xilinx GPIOs"
>  	help
> -
> -	Enables support for the GPIO controller available from
> -	Xilinx's softcore IP.
> +	  Enables support for the GPIO controller available from
> +	  Xilinx's softcore IP.
>  
>  config XENO_DRIVERS_GPIO_OMAP
>  	depends on ARCH_OMAP2PLUS || ARCH_OMAP
>  	tristate "Support for OMAP GPIOs"
>  	help
> -
> -	Enables support for the GPIO controller available from
> -	OMAP family SOC.
> +	  Enables support for the GPIO controller available from
> +	  OMAP family SOC.
>  
>  config XENO_DRIVERS_GPIO_CHERRYVIEW
>  	depends on PINCTRL_CHERRYVIEW
>  	tristate "Support for Cherryview GPIOs"
>  	help
> -
> -	Enables support for the Intel Cherryview GPIO controller
> +	  Enables support for the Intel Cherryview GPIO controller
>  
>  config XENO_DRIVERS_GPIO_DEBUG
> -       bool "Enable GPIO core debugging features"
> +	bool "Enable GPIO core debugging features"
>  
>  endif
>  
> diff --git a/kernel/drivers/net/Kconfig b/kernel/drivers/net/Kconfig
> index 2e8032464..576627d66 100644
> --- a/kernel/drivers/net/Kconfig
> +++ b/kernel/drivers/net/Kconfig
> @@ -1,20 +1,20 @@
>  menu "RTnet"
>  
>  config XENO_DRIVERS_NET
> -    depends on m
> -    select NET
> -    tristate "RTnet, TCP/IP socket interface"
> +	depends on m
> +	select NET
> +	tristate "RTnet, TCP/IP socket interface"
>  
>  if XENO_DRIVERS_NET
>  
>  config XENO_DRIVERS_RTNET_CHECKED
> -    bool "Internal Bug Checks"
> -    default n
> -    help
> -    Switch on if you face crashes when RTnet is running or if you suspect
> -    any other RTnet-related issues. This feature will add a few sanity
> -    checks at critical points that will produce warnings on the kernel
> -    console in case certain internal bugs are detected.
> +	bool "Internal Bug Checks"
> +	default n
> +	help
> +	  Switch on if you face crashes when RTnet is running or if you suspect
> +	  any other RTnet-related issues. This feature will add a few sanity
> +	  checks at critical points that will produce warnings on the kernel
> +	  console in case certain internal bugs are detected.
>  
>  source "drivers/xenomai/net/stack/Kconfig"
>  source "drivers/xenomai/net/drivers/Kconfig"
> diff --git a/kernel/drivers/net/addons/Kconfig b/kernel/drivers/net/addons/Kconfig
> index e92f6d8ca..8215c39aa 100644
> --- a/kernel/drivers/net/addons/Kconfig
> +++ b/kernel/drivers/net/addons/Kconfig
> @@ -1,44 +1,44 @@
>  menu "Add-Ons"
> -    depends on XENO_DRIVERS_NET
> +	depends on XENO_DRIVERS_NET
>  
>  config XENO_DRIVERS_NET_ADDON_RTCAP
> -    depends on XENO_DRIVERS_NET && m
> -    select ETHERNET
> -    tristate "Real-Time Capturing Support"
> -    default n
> -    help
> -    This feature allows to capture real-time packets traversing the RTnet
> -    stack. It can both be used to sniff passively on a network (in this
> -    case you may want to enable the promisc mode of your real-time NIC via
> -    rtifconfig) and to log the traffic the node receives and transmits
> -    during normal operation. RTcap consists of additional hooks in the
> -    RTnet stack and a separate module as interface to standard network
> -    analysis tools like Ethereal.
> +	depends on XENO_DRIVERS_NET && m
> +	select ETHERNET
> +	tristate "Real-Time Capturing Support"
> +	default n
> +	help
> +	  This feature allows to capture real-time packets traversing the RTnet
> +	  stack. It can both be used to sniff passively on a network (in this
> +	  case you may want to enable the promisc mode of your real-time NIC via
> +	  rtifconfig) and to log the traffic the node receives and transmits
> +	  during normal operation. RTcap consists of additional hooks in the
> +	  RTnet stack and a separate module as interface to standard network
> +	  analysis tools like Ethereal.
>  
> -    For further information see Documentation/README.rtcap.
> +	  For further information see Documentation/README.rtcap.
>  
>  config XENO_DRIVERS_NET_ADDON_PROXY
> -    depends on XENO_DRIVERS_NET_RTIPV4 && m
> -    select ETHERNET
> -    tristate "IP protocol proxy for Linux"
> -    default n
> -    help
> -    Enables a forward-to-Linux module for all IP protocols that are not
> -    handled by the IPv4 implemenation of RTnet (TCP, UDP, etc.). Only use
> -    when you know what you are doing - it can easily break your real-time
> -    requirements!
> +	depends on XENO_DRIVERS_NET_RTIPV4 && m
> +	select ETHERNET
> +	tristate "IP protocol proxy for Linux"
> +	default n
> +	help
> +	  Enables a forward-to-Linux module for all IP protocols that are not
> +	  handled by the IPv4 implementation of RTnet (TCP, UDP, etc.). Only use
> +	  when you know what you are doing - it can easily break your real-time
> +	  requirements!
>  
> -    See Documentation/README.rtnetproxy for further information.
> +	  See Documentation/README.rtnetproxy for further information.
>  
>  config XENO_DRIVERS_NET_ADDON_PROXY_ARP
> -    depends on XENO_DRIVERS_NET_ADDON_PROXY
> -    bool "Enable ARP handling via protocol proxy"
> -    default n
> -    help
> -    Enables ARP support for the IP protocol proxy. Incoming ARP replies
> -    are then delivered to both, the RTnet and the Linux network stack,
> -    but only answered by Linux. The IP protocol proxy gets attached to
> -    the RTnet device specified by the module parameter "rtdev_attach",
> -    rteth0 by default.
> +	depends on XENO_DRIVERS_NET_ADDON_PROXY
> +	bool "Enable ARP handling via protocol proxy"
> +	default n
> +	help
> +	  Enables ARP support for the IP protocol proxy. Incoming ARP replies
> +	  are then delivered to both, the RTnet and the Linux network stack,
> +	  but only answered by Linux. The IP protocol proxy gets attached to
> +	  the RTnet device specified by the module parameter "rtdev_attach",
> +	  rteth0 by default.
>  
>  endmenu
> diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
> index 8ecd560b0..04362fbb0 100644
> --- a/kernel/drivers/net/drivers/Kconfig
> +++ b/kernel/drivers/net/drivers/Kconfig
> @@ -1,119 +1,119 @@
>  menu "Drivers"
> -    depends on XENO_DRIVERS_NET
> +	depends on XENO_DRIVERS_NET
>  
>  comment "Common PCI Drivers"
> -    depends on PCI
> +	depends on PCI
>  
>  config XENO_DRIVERS_NET_DRV_PCNET32
> -    depends on XENO_DRIVERS_NET && PCI
> -    tristate "AMD PCnet32"
> +	depends on XENO_DRIVERS_NET && PCI
> +	tristate "AMD PCnet32"
>  
>  
>  config XENO_DRIVERS_NET_DRV_TULIP
> -    depends on XENO_DRIVERS_NET && PCI
> -    tristate "DEC Tulip"
> +	depends on XENO_DRIVERS_NET && PCI
> +	tristate "DEC Tulip"
>  
>  
>  config XENO_DRIVERS_NET_DRV_EEPRO100
> -    depends on XENO_DRIVERS_NET && PCI
> -    tristate "Intel EtherExpress PRO/100"
> -    default y
> +	depends on XENO_DRIVERS_NET && PCI
> +	tristate "Intel EtherExpress PRO/100"
> +	default y
>  
>  config XENO_DRIVERS_NET_DRV_EEPRO100_CMDTIMEOUT
> -    depends on XENO_DRIVERS_NET && PCI
> -    int "Command Timeout"
> -    depends on XENO_DRIVERS_NET_DRV_EEPRO100
> -    default 20
> -    help
> -    Timeout in microseconds of transmission or configuration commands that
> -    are issued in real-time contexts.
> +	depends on XENO_DRIVERS_NET && PCI
> +	int "Command Timeout"
> +	depends on XENO_DRIVERS_NET_DRV_EEPRO100
> +	default 20
> +	help
> +	  Timeout in microseconds of transmission or configuration commands
> +	  that are issued in real-time contexts.
>  
>  config XENO_DRIVERS_NET_DRV_EEPRO100_DBG
> -    depends on XENO_DRIVERS_NET && PCI
> -    bool "Enable debugging and instrumentation"
> -    depends on XENO_DRIVERS_NET_DRV_EEPRO100
> -    help
> -    This option switches on internal debugging code of the EEPRO/100 driver.
> -    It also enables the collection of worst-case command delays in real-time
> -    contexts in order to reduce the command timeout (which, effectively, will
> -    also reduce the worst-case transmission latency).
> +	depends on XENO_DRIVERS_NET && PCI
> +	bool "Enable debugging and instrumentation"
> +	depends on XENO_DRIVERS_NET_DRV_EEPRO100
> +	help
> +	  This option switches on internal debugging code of the EEPRO/100
> +	  driver. It also enables the collection of worst-case command delays
> +	  in real-time contexts in order to reduce the command timeout (which,
> +	  effectively, will also reduce the worst-case transmission latency).
>  
>  
>  config XENO_DRIVERS_NET_DRV_E1000
> -    depends on XENO_DRIVERS_NET && PCI
> -    tristate "Intel(R) PRO/1000 (Gigabit)"
> -    default y
> +	depends on XENO_DRIVERS_NET && PCI
> +	tristate "Intel(R) PRO/1000 (Gigabit)"
> +	default y
>  
>  config XENO_DRIVERS_NET_DRV_E1000E
> -    depends on XENO_DRIVERS_NET && PCI
> -    tristate "New Intel(R) PRO/1000 PCIe (Gigabit)"
> +	depends on XENO_DRIVERS_NET && PCI
> +	tristate "New Intel(R) PRO/1000 PCIe (Gigabit)"
>  
>  
>  config XENO_DRIVERS_NET_DRV_NATSEMI
> -    depends on XENO_DRIVERS_NET && PCI
> -    tristate "NatSemi"
> +	depends on XENO_DRIVERS_NET && PCI
> +	tristate "NatSemi"
>  
>  
>  config XENO_DRIVERS_NET_DRV_8139
> -    depends on XENO_DRIVERS_NET && PCI
> -    tristate "Realtek 8139"
> -    default y
> +	depends on XENO_DRIVERS_NET && PCI
> +	tristate "Realtek 8139"
> +	default y
>  
>  
>  config XENO_DRIVERS_NET_DRV_VIA_RHINE
> -    depends on XENO_DRIVERS_NET && PCI
> -    tristate "VIA Rhine"
> +	depends on XENO_DRIVERS_NET && PCI
> +	tristate "VIA Rhine"
>  
>  
>  config XENO_DRIVERS_NET_DRV_IGB
> -    select I2C
> -    select I2C_ALGOBIT
> -    depends on XENO_DRIVERS_NET && PCI
> -    tristate "Intel(R) 82575 (Gigabit)"
> +	select I2C
> +	select I2C_ALGOBIT
> +	depends on XENO_DRIVERS_NET && PCI
> +	tristate "Intel(R) 82575 (Gigabit)"
>  
>  config XENO_DRIVERS_NET_DRV_IGC
> -    depends on XENO_DRIVERS_NET && PCI
> -    tristate "Intel(R) Ethernet Controller I225-LM/I225-V support"
> +	depends on XENO_DRIVERS_NET && PCI
> +	tristate "Intel(R) Ethernet Controller I225-LM/I225-V support"
>  
>  config XENO_DRIVERS_NET_DRV_R8169
> -    depends on XENO_DRIVERS_NET && PCI
> -    tristate "Realtek 8169 (Gigabit)"
> +	depends on XENO_DRIVERS_NET && PCI
> +	tristate "Realtek 8169 (Gigabit)"
>  
>  
>  comment "Misc Drivers"
>  
>  config XENO_DRIVERS_NET_DRV_LOOPBACK
> -    depends on XENO_DRIVERS_NET
> -    tristate "Loopback"
> -    default y
> +	depends on XENO_DRIVERS_NET
> +	tristate "Loopback"
> +	default y
>  
>  if ARM
>  
>  config XENO_DRIVERS_NET_DRV_AT91_ETHER
> -    depends on XENO_DRIVERS_NET && SOC_AT91RM9200
> -    select XENO_DRIVERS_NET_DRV_MACB
> -    tristate "AT91RM9200 Board Ethernet Driver"
> +	depends on XENO_DRIVERS_NET && SOC_AT91RM9200
> +	select XENO_DRIVERS_NET_DRV_MACB
> +	tristate "AT91RM9200 Board Ethernet Driver"
>  
>  config XENO_DRIVERS_NET_DRV_MACB
> -    depends on XENO_DRIVERS_NET
> -    select AT91_PROGRAMMABLE_CLOCKS if ARCH_AT91
> -    tristate "Cadence MACB/GEM devices"
> -    help
> -    Driver for internal MAC-controller on AT91SAM926x microcontrollers.
> -    Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
> +	depends on XENO_DRIVERS_NET
> +	select AT91_PROGRAMMABLE_CLOCKS if ARCH_AT91
> +	tristate "Cadence MACB/GEM devices"
> +	help
> +	  Driver for internal MAC-controller on AT91SAM926x microcontrollers.
> +	  Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
>  
>  endif
>  
>  config XENO_DRIVERS_NET_FEC
> -    depends on XENO_DRIVERS_NET
> -    depends on BROKEN || $(VERSION) < 6 || ($(VERSION) = 6 && $(PATCHLEVEL) < 3)
> -    tristate "Freescale FEC"
> -    depends on ARCH_MXC || SOC_IMX28
> -    select PHYLIB
> -    imply PTP_1588_CLOCK
> -    help
> -    For built-in 10/100 Fast ethernet controller on Freescale i.MX
> -    processors.
> +	depends on XENO_DRIVERS_NET
> +	depends on BROKEN || $(VERSION) < 6 || ($(VERSION) = 6 && $(PATCHLEVEL) < 3)
> +	tristate "Freescale FEC"
> +	depends on ARCH_MXC || SOC_IMX28
> +	select PHYLIB
> +	imply PTP_1588_CLOCK
> +	help
> +	  For built-in 10/100 Fast ethernet controller on Freescale i.MX
> +	  processors.
>  
>  source "drivers/xenomai/net/drivers/experimental/Kconfig"
>  
> diff --git a/kernel/drivers/net/drivers/experimental/Kconfig b/kernel/drivers/net/drivers/experimental/Kconfig
> index e6a5edb9f..3571f06b8 100644
> --- a/kernel/drivers/net/drivers/experimental/Kconfig
> +++ b/kernel/drivers/net/drivers/experimental/Kconfig
> @@ -1,12 +1,12 @@
>  config XENO_DRIVERS_NET_EXP_DRIVERS
> -    depends on XENO_DRIVERS_NET && PCI
> -    bool "Experimental Drivers"
> +	depends on XENO_DRIVERS_NET && PCI
> +	bool "Experimental Drivers"
>  
>  if XENO_DRIVERS_NET_EXP_DRIVERS
>  
>  config XENO_DRIVERS_NET_DRV_E1000_NEW
> -    depends on PCI
> -    tristate "New Intel(R) PRO/1000 (Gigabit)"
> +	depends on PCI
> +	tristate "New Intel(R) PRO/1000 (Gigabit)"
>  
>  source "drivers/xenomai/net/drivers/experimental/rt2500/Kconfig"
>  
> diff --git a/kernel/drivers/net/drivers/experimental/rt2500/Kconfig b/kernel/drivers/net/drivers/experimental/rt2500/Kconfig
> index 054412839..46cd4308a 100644
> --- a/kernel/drivers/net/drivers/experimental/rt2500/Kconfig
> +++ b/kernel/drivers/net/drivers/experimental/rt2500/Kconfig
> @@ -1,4 +1,4 @@
>  config XENO_DRIVERS_NET_DRV_RT2500
> -    depends on XENO_DRIVERS_NET && PCI
> -    tristate "Ralink 2500 WLAN"
> -    select XENO_DRIVERS_NET_RTWLAN
> +	depends on XENO_DRIVERS_NET && PCI
> +	tristate "Ralink 2500 WLAN"
> +	select XENO_DRIVERS_NET_RTWLAN
> diff --git a/kernel/drivers/net/stack/Kconfig b/kernel/drivers/net/stack/Kconfig
> index 996536cc5..bf151f3df 100644
> --- a/kernel/drivers/net/stack/Kconfig
> +++ b/kernel/drivers/net/stack/Kconfig
> @@ -1,35 +1,35 @@
>  menu "Protocol Stack"
> -    depends on XENO_DRIVERS_NET
> +	depends on XENO_DRIVERS_NET
>  
>  comment "Stack parameters"
>  
>  config XENO_DRIVERS_NET_RX_FIFO_SIZE
> -    int "Size of central RX-FIFO"
> -    depends on XENO_DRIVERS_NET
> -    default 32
> -    help
> -    Size of FIFO between NICs and stack manager task. Must be power
> -    of two! Effectively, only CONFIG_RTNET_RX_FIFO_SIZE-1 slots will
> -    be usable.
> +	int "Size of central RX-FIFO"
> +	depends on XENO_DRIVERS_NET
> +	default 32
> +	help
> +	  Size of FIFO between NICs and stack manager task. Must be power
> +	  of two! Effectively, only CONFIG_RTNET_RX_FIFO_SIZE-1 slots will
> +	  be usable.
>  
>  config XENO_DRIVERS_NET_ETH_P_ALL
> -    depends on XENO_DRIVERS_NET
> -    bool "Support for ETH_P_ALL"
> -    help
> -    Enables core support for registering listeners on all layer 3
> -    protocols (ETH_P_ALL). Internally this is currently realised by
> -    clone-copying incoming frames for those listners, future versions
> -    will implement buffer sharing for efficiency reasons. Use with
> -    care, every ETH_P_ALL-listener adds noticable overhead to the
> -    reception path.
> +	depends on XENO_DRIVERS_NET
> +	bool "Support for ETH_P_ALL"
> +	help
> +	  Enables core support for registering listeners on all layer 3
> +	  protocols (ETH_P_ALL). Internally this is currently realised by
> +	  clone-copying incoming frames for those listeners, future versions
> +	  will implement buffer sharing for efficiency reasons. Use with
> +	  care, every ETH_P_ALL-listener adds noticeable overhead to the
> +	  reception path.
>  
>  config XENO_DRIVERS_NET_RTWLAN
> -    depends on XENO_DRIVERS_NET
> -    bool "Real-Time WLAN"
> -    help
> -    Enables core support for real-time wireless LAN. RT-WLAN is based
> -    on low-level access to 802.11-compliant adapters and is currently
> -    in an experimental stage.
> +	depends on XENO_DRIVERS_NET
> +	bool "Real-Time WLAN"
> +	help
> +	  Enables core support for real-time wireless LAN. RT-WLAN is based
> +	  on low-level access to 802.11-compliant adapters and is currently
> +	  in an experimental stage.
>  
>  comment "Protocols"
>  
> diff --git a/kernel/drivers/net/stack/ipv4/Kconfig b/kernel/drivers/net/stack/ipv4/Kconfig
> index d5a6cd6d7..46c5d0f98 100644
> --- a/kernel/drivers/net/stack/ipv4/Kconfig
> +++ b/kernel/drivers/net/stack/ipv4/Kconfig
> @@ -1,75 +1,75 @@
>  config XENO_DRIVERS_NET_RTIPV4
> -    depends on XENO_DRIVERS_NET
> -    tristate "Real-Time IPv4"
> -    default y
> -    help
> -    Enables the real-time capable IPv4 support of RTnet. The protocol is
> -    implemented as a separate module. Supplementing tools (rtroute,
> -    rtping) and examples are provided as well. Moreover, RTcfg will
> -    include IPv4 support when this option is switched on.
> +	depends on XENO_DRIVERS_NET
> +	tristate "Real-Time IPv4"
> +	default y
> +	help
> +	  Enables the real-time capable IPv4 support of RTnet. The protocol is
> +	  implemented as a separate module. Supplementing tools (rtroute,
> +	  rtping) and examples are provided as well. Moreover, RTcfg will
> +	  include IPv4 support when this option is switched on.
>  
> -    For further information see also Documentation/README.routing and
> -    Documentation/README.ipfragmentation.
> +	  For further information see also Documentation/README.routing and
> +	  Documentation/README.ipfragmentation.
>  
>  config XENO_DRIVERS_NET_RTIPV4_ICMP
> -    bool "ICMP support"
> -    depends on XENO_DRIVERS_NET_RTIPV4
> -    default y
> -    help
> -    Enables ICMP support of the RTnet Real-Time IPv4 protocol.
> +	bool "ICMP support"
> +	depends on XENO_DRIVERS_NET_RTIPV4
> +	default y
> +	help
> +	  Enables ICMP support of the RTnet Real-Time IPv4 protocol.
>  
> -    When the RTnet-Proxy is enabled while this feature is disabled, ICMP
> -    will be forwarded to the Linux network stack.
> +	  When the RTnet-Proxy is enabled while this feature is disabled, ICMP
> +	  will be forwarded to the Linux network stack.
>  
>  config XENO_DRIVERS_NET_RTIPV4_HOST_ROUTES
> -    int "Maximum host routing table entries"
> -    depends on XENO_DRIVERS_NET_RTIPV4
> -    default 32
> -    help
> -    Each IPv4 supporting interface and each remote host that is directly
> -    reachable via via some output interface requires a host routing table
> -    entry. If you run larger networks with may hosts per subnet, you may
> -    have to increase this limit. Must be power of 2!
> +	int "Maximum host routing table entries"
> +	depends on XENO_DRIVERS_NET_RTIPV4
> +	default 32
> +	help
> +	  Each IPv4 supporting interface and each remote host that is directly
> +	  reachable via some output interface requires a host routing table
> +	  entry. If you run larger networks with may hosts per subnet, you may
> +	  have to increase this limit. Must be power of 2!
>  
>  config XENO_DRIVERS_NET_RTIPV4_NETROUTING
> -    bool "IP Network Routing"
> -    depends on XENO_DRIVERS_NET_RTIPV4
> -    help
> -    Enables routing across IPv4 real-time networks. You will only require
> -    this feature in complex networks, while switching it off for flat,
> -    single-segment networks improves code size and the worst-case routing
> -    decision delay.
> +	bool "IP Network Routing"
> +	depends on XENO_DRIVERS_NET_RTIPV4
> +	help
> +	  Enables routing across IPv4 real-time networks. You will only require
> +	  this feature in complex networks, while switching it off for flat,
> +	  single-segment networks improves code size and the worst-case routing
> +	  decision delay.
>  
> -    See Documentation/README.routing for further information.
> +	  See Documentation/README.routing for further information.
>  
>  config XENO_DRIVERS_NET_RTIPV4_NET_ROUTES
> -    int "Maximum network routing table entries"
> -    depends on XENO_DRIVERS_NET_RTIPV4_NETROUTING
> -    default 16
> -    help
> -    Each route describing a target network reachable via a router
> -    requires an entry in the network routing table. If you run very
> -    complex realtime networks, you may have to increase this limit. Must
> -    be power of 2!
> +	int "Maximum network routing table entries"
> +	depends on XENO_DRIVERS_NET_RTIPV4_NETROUTING
> +	default 16
> +	help
> +	  Each route describing a target network reachable via a router
> +	  requires an entry in the network routing table. If you run very
> +	  complex realtime networks, you may have to increase this limit. Must
> +	  be power of 2!
>  
>  config XENO_DRIVERS_NET_RTIPV4_ROUTER
> -    bool "IP Router"
> -    depends on XENO_DRIVERS_NET_RTIPV4
> -    help
> -    When switched on, the RTnet station will be able to forward IPv4
> -    packets that are not directed to the station itself. Typically used in
> -    combination with CONFIG_RTNET_RTIPV4_NETROUTING.
> +	bool "IP Router"
> +	depends on XENO_DRIVERS_NET_RTIPV4
> +	help
> +	  When switched on, the RTnet station will be able to forward IPv4
> +	  packets that are not directed to the station itself. Typically used
> +	  in combination with CONFIG_RTNET_RTIPV4_NETROUTING.
>  
> -    See Documentation/README.routing for further information.
> +	  See Documentation/README.routing for further information.
>  
>  config XENO_DRIVERS_NET_RTIPV4_DEBUG
> -    bool "RTipv4 Debugging"
> -    depends on XENO_DRIVERS_NET_RTIPV4
> -    default n
> -    
> -    help
> -    Enables debug message output of the RTipv4 layer. Typically, you
> -    may want to turn this on for tracing issues in packet delivery.
> +	bool "RTipv4 Debugging"
> +	depends on XENO_DRIVERS_NET_RTIPV4
> +	default n
> +
> +	help
> +	  Enables debug message output of the RTipv4 layer. Typically, you
> +	  may want to turn this on for tracing issues in packet delivery.
>  
>  source "drivers/xenomai/net/stack/ipv4/udp/Kconfig"
>  source "drivers/xenomai/net/stack/ipv4/tcp/Kconfig"
> diff --git a/kernel/drivers/net/stack/ipv4/tcp/Kconfig b/kernel/drivers/net/stack/ipv4/tcp/Kconfig
> index a69d34679..69f606c42 100644
> --- a/kernel/drivers/net/stack/ipv4/tcp/Kconfig
> +++ b/kernel/drivers/net/stack/ipv4/tcp/Kconfig
> @@ -1,18 +1,18 @@
>  config XENO_DRIVERS_NET_RTIPV4_TCP
> -    tristate "TCP support"
> -    depends on XENO_DRIVERS_NET_RTIPV4
> -    help
> -    Enables TCP support of the RTnet Real-Time IPv4 protocol.
> +	tristate "TCP support"
> +	depends on XENO_DRIVERS_NET_RTIPV4
> +	help
> +	  Enables TCP support of the RTnet Real-Time IPv4 protocol.
>  
> -    When the RTnet IPv4 is enabled while this feature is disabled, TCP
> -    will be forwarded to the Linux network stack.
> +	  When the RTnet IPv4 is enabled while this feature is disabled, TCP
> +	  will be forwarded to the Linux network stack.
>  
>  config XENO_DRIVERS_NET_RTIPV4_TCP_ERROR_INJECTION
> -    bool "TCP error injection"
> -    depends on XENO_DRIVERS_NET_RTIPV4_TCP
> -    help
> -    Enables error injection for incoming TCP packets. This can be used
> -    to test both protocol as well as application behavior under error
> -    conditions. The per-socket error rate is 0 by default and can be
> -    tuned during runtime via the error_rate and multi_error module
> -    parameters.
> +	bool "TCP error injection"
> +	depends on XENO_DRIVERS_NET_RTIPV4_TCP
> +	help
> +	  Enables error injection for incoming TCP packets. This can be used
> +	  to test both protocol as well as application behavior under error
> +	  conditions. The per-socket error rate is 0 by default and can be
> +	  tuned during runtime via the error_rate and multi_error module
> +	  parameters.
> diff --git a/kernel/drivers/net/stack/ipv4/udp/Kconfig b/kernel/drivers/net/stack/ipv4/udp/Kconfig
> index a23279411..79141df50 100644
> --- a/kernel/drivers/net/stack/ipv4/udp/Kconfig
> +++ b/kernel/drivers/net/stack/ipv4/udp/Kconfig
> @@ -1,6 +1,6 @@
>  config XENO_DRIVERS_NET_RTIPV4_UDP
> -    tristate "UDP support"
> -    depends on XENO_DRIVERS_NET_RTIPV4
> -    default y
> -    help
> -    Enables UDP support of the RTnet Real-Time IPv4 protocol.
> +	tristate "UDP support"
> +	depends on XENO_DRIVERS_NET_RTIPV4
> +	default y
> +	help
> +	  Enables UDP support of the RTnet Real-Time IPv4 protocol.
> diff --git a/kernel/drivers/net/stack/packet/Kconfig b/kernel/drivers/net/stack/packet/Kconfig
> index 4c83b73c2..bb2dbe886 100644
> --- a/kernel/drivers/net/stack/packet/Kconfig
> +++ b/kernel/drivers/net/stack/packet/Kconfig
> @@ -1,14 +1,14 @@
>  config XENO_DRIVERS_NET_RTPACKET
> -    depends on XENO_DRIVERS_NET
> -    tristate "Real-Time Packet Socket Support"
> -    default y
> -    help
> -    Enables real-time packet sockets for RTnet. This support is
> -    implemented in a separate module. When loaded, application programs
> -    can send and received so-called "cooked" packets directly at OSI layer
> -    2 (device layer). This means that RTnet will still maintain the
> -    device-dependent packet header but leave the full data segment to the
> -    user.
> +	depends on XENO_DRIVERS_NET
> +	tristate "Real-Time Packet Socket Support"
> +	default y
> +	help
> +	  Enables real-time packet sockets for RTnet. This support is
> +	  implemented in a separate module. When loaded, application programs
> +	  can send and received so-called "cooked" packets directly at OSI
> +	  layer 2 (device layer). This means that RTnet will still maintain the
> +	  device-dependent packet header but leave the full data segment to the
> +	  user.
>  
> -    Examples like raw-ethernet or netshm make use of this support. See
> -    also Linux man page packet(7).
> +	  Examples like raw-ethernet or netshm make use of this support. See
> +	  also Linux man page packet(7).
> diff --git a/kernel/drivers/net/stack/rtcfg/Kconfig b/kernel/drivers/net/stack/rtcfg/Kconfig
> index 38c484046..c1f9687f4 100644
> --- a/kernel/drivers/net/stack/rtcfg/Kconfig
> +++ b/kernel/drivers/net/stack/rtcfg/Kconfig
> @@ -1,23 +1,23 @@
>  config XENO_DRIVERS_NET_RTCFG
> -    depends on XENO_DRIVERS_NET
> -    tristate "RTcfg Service"
> -    default y
> -    help
> -    The Real-Time Configuration service configures and monitors nodes in
> -    a RTnet network. It works both with plain MAC as well as with IPv4
> -    addresses (in case CONFIG_RTNET_RTIPV4 has been switched on). RTcfg
> -    consists of a configuration server, which can run on the same station
> -    as the TDMA master e.g., and one or more clients. Clients can join and
> -    leave the network during runtime without interfering with other
> -    stations. Besides network configuration, the RTcfg server can also
> -    distribute custom data.
> +	depends on XENO_DRIVERS_NET
> +	tristate "RTcfg Service"
> +	default y
> +	help
> +	  The Real-Time Configuration service configures and monitors nodes in
> +	  a RTnet network. It works both with plain MAC as well as with IPv4
> +	  addresses (in case CONFIG_RTNET_RTIPV4 has been switched on). RTcfg
> +	  consists of a configuration server, which can run on the same station
> +	  as the TDMA master e.g., and one or more clients. Clients can join and
> +	  leave the network during runtime without interfering with other
> +	  stations. Besides network configuration, the RTcfg server can also
> +	  distribute custom data.
>  
> -    See Documentation/README.rtcfg for further information.
> +	See Documentation/README.rtcfg for further information.
>  
>  config XENO_DRIVERS_NET_RTCFG_DEBUG
> -    bool "RTcfg Debugging"
> -    depends on XENO_DRIVERS_NET_RTCFG
> -    default n
> -    help
> -    Enables debug message output of the RTcfg state machines. Switch on if
> -    you have to trace some problem related to RTcfg.
> +	bool "RTcfg Debugging"
> +	depends on XENO_DRIVERS_NET_RTCFG
> +	default n
> +	help
> +	  Enables debug message output of the RTcfg state machines. Switch on if
> +	  you have to trace some problem related to RTcfg.
> diff --git a/kernel/drivers/net/stack/rtmac/Kconfig b/kernel/drivers/net/stack/rtmac/Kconfig
> index a97b316b0..56f70af38 100644
> --- a/kernel/drivers/net/stack/rtmac/Kconfig
> +++ b/kernel/drivers/net/stack/rtmac/Kconfig
> @@ -1,16 +1,16 @@
>  menuconfig XENO_DRIVERS_NET_RTMAC
> -    depends on XENO_DRIVERS_NET
> -    tristate "RTmac Layer"
> -    default y
> -    help
> -    The Real-Time Media Access Control layer allows to extend the RTnet
> -    stack with software-based access control mechanisms (also called
> -    disciplines) for nondeterministic transport media. Disciplines can be
> -    attached and detached per real-time device. RTmac also provides a
> -    framework for tunnelling non-time-critical packets through real-time
> -    networks by installing virtual NICs (VNIC) in the Linux domain.
> +	depends on XENO_DRIVERS_NET
> +	tristate "RTmac Layer"
> +	default y
> +	help
> +	  The Real-Time Media Access Control layer allows to extend the RTnet
> +	  stack with software-based access control mechanisms (also called
> +	  disciplines) for nondeterministic transport media. Disciplines can be
> +	  attached and detached per real-time device. RTmac also provides a
> +	  framework for tunnelling non-time-critical packets through real-time
> +	  networks by installing virtual NICs (VNIC) in the Linux domain.
>  
> -    See Documentation/README.rtmac for further information.
> +	  See Documentation/README.rtmac for further information.
>  
>  source "drivers/xenomai/net/stack/rtmac/tdma/Kconfig"
>  source "drivers/xenomai/net/stack/rtmac/nomac/Kconfig"
> diff --git a/kernel/drivers/net/stack/rtmac/nomac/Kconfig b/kernel/drivers/net/stack/rtmac/nomac/Kconfig
> index e706d4a96..9e457cd3f 100644
> --- a/kernel/drivers/net/stack/rtmac/nomac/Kconfig
> +++ b/kernel/drivers/net/stack/rtmac/nomac/Kconfig
> @@ -1,9 +1,9 @@
>  config XENO_DRIVERS_NET_NOMAC
> -    tristate "NoMAC discipline for RTmac"
> -    depends on XENO_DRIVERS_NET_RTMAC
> -    default n
> -    help
> -    This no-operation RTmac discipline is intended to act as a template
> -    for new implementations. However, it can be compiled and used (see
> -    nomaccfg management tool), but don't expect any improved determinism
> -    of your network. ;)
> +	tristate "NoMAC discipline for RTmac"
> +	depends on XENO_DRIVERS_NET_RTMAC
> +	default n
> +	help
> +	  This no-operation RTmac discipline is intended to act as a template
> +	  for new implementations. However, it can be compiled and used (see
> +	  nomaccfg management tool), but don't expect any improved determinism
> +	  of your network. ;)
> diff --git a/kernel/drivers/net/stack/rtmac/tdma/Kconfig b/kernel/drivers/net/stack/rtmac/tdma/Kconfig
> index 4444661f2..3f806c68d 100644
> --- a/kernel/drivers/net/stack/rtmac/tdma/Kconfig
> +++ b/kernel/drivers/net/stack/rtmac/tdma/Kconfig
> @@ -1,21 +1,21 @@
>  config XENO_DRIVERS_NET_TDMA
> -    tristate "TDMA discipline for RTmac"
> -    depends on XENO_DRIVERS_NET_RTMAC
> -    default y
> -    help
> -    The Time Division Multiple Access discipline is the default RTmac
> -    protocol for Ethernet networks. It consists of a master synchronising
> -    the access of the slaves to the media by periodically issuing frames.
> -    Backup masters can be set up to take over if the primary master fails.
> -    TDMA also provides a global clock across all participants. The tdmacfg
> -    tool can be used to configure a real-time NIC to use TDMA.
> +	tristate "TDMA discipline for RTmac"
> +	depends on XENO_DRIVERS_NET_RTMAC
> +	default y
> +	help
> +	  The Time Division Multiple Access discipline is the default RTmac
> +	  protocol for Ethernet networks. It consists of a master synchronising
> +	  the access of the slaves to the media by periodically issuing frames.
> +	  Backup masters can be set up to take over if the primary master fails.
> +	  TDMA also provides a global clock across all participants. The tdmacfg
> +	  tool can be used to configure a real-time NIC to use TDMA.
>  
> -    See Documenatation/README.rtmac for further details.
> +	  See Documenatation/README.rtmac for further details.
>  
>  config XENO_DRIVERS_NET_TDMA_MASTER
> -    bool "TDMA master support"
> -    depends on XENO_DRIVERS_NET_TDMA
> -    default y
> -    help
> -    Enables TDMA master and backup master support for the node. This can
> -    be switched of to reduce the memory footprint of pure slave nodes.
> +	bool "TDMA master support"
> +	depends on XENO_DRIVERS_NET_TDMA
> +	default y
> +	help
> +	  Enables TDMA master and backup master support for the node. This can
> +	  be switched of to reduce the memory footprint of pure slave nodes.
> diff --git a/kernel/drivers/serial/Kconfig b/kernel/drivers/serial/Kconfig
> index 43dd5ec23..f6eadb152 100644
> --- a/kernel/drivers/serial/Kconfig
> +++ b/kernel/drivers/serial/Kconfig
> @@ -3,8 +3,8 @@ menu "Serial drivers"
>  config XENO_DRIVERS_16550A
>  	tristate "16550A UART driver"
>  	help
> -	Real-time UART driver for 16550A compatible controllers. See
> -	doc/txt/16550A-driver.txt for more details.
> +	  Real-time UART driver for 16550A compatible controllers. See
> +	  doc/txt/16550A-driver.txt for more details.
>  
>  choice
>  	prompt "Hardware access mode"
> @@ -14,27 +14,27 @@ choice
>  config XENO_DRIVERS_16550A_PIO
>  	bool "Port-based I/O"
>  	help
> -	Hardware access only via I/O ports. Use module parameter
> -	"io=<port>[,<port>[,...]]" to specify the base port of a device.
> +	  Hardware access only via I/O ports. Use module parameter
> +	  "io=<port>[,<port>[,...]]" to specify the base port of a device.
>  
>  config XENO_DRIVERS_16550A_MMIO
>  	bool "Memory-mapped I/O"
>  	help
> -	Hardware access only via memory mapping. Use module paramter
> -	"mem=<addr>[,<addr>[,...]]" to specify the physical base address of
> -	a device.
> +	  Hardware access only via memory mapping. Use module parameter
> +	  "mem=<addr>[,<addr>[,...]]" to specify the physical base address of
> +	  a device.
>  
>  config XENO_DRIVERS_16550A_ANY
>  	bool "Any access mode"
>  	help
> -	Decide at module load-time (or via kernel parameter) which access
> -	mode to use for which device. This mode is useful when devices of
> -	both types can be present in a system, also at the same time.
> +	  Decide at module load-time (or via kernel parameter) which access
> +	  mode to use for which device. This mode is useful when devices of
> +	  both types can be present in a system, also at the same time.
>  
> -	Both "io" and "mem" module parameters are available, but always only
> -	one of them can be applied on a particular device. Use, e.g.,
> -	"io=0x3f8,0 mem=0,0xe0000000" to address device 1 via IO base port
> -	0x3f8 and device 2 via physical base address 0xe0000000.
> +	  Both "io" and "mem" module parameters are available, but always only
> +	  one of them can be applied on a particular device. Use, e.g.,
> +	  "io=0x3f8,0 mem=0,0xe0000000" to address device 1 via IO base port
> +	  0x3f8 and device 2 via physical base address 0xe0000000.
>  
>  endchoice
>  
> @@ -43,37 +43,35 @@ config XENO_DRIVERS_16550A_PCI
>  	bool "PCI board support"
>  	default n
>  	help
> -
> -	This option activates support for PCI serial boards.
> +	  This option activates support for PCI serial boards.
>  
>  config XENO_DRIVERS_16550A_PCI_MOXA
>  	depends on XENO_DRIVERS_16550A_PCI
>  	bool "Moxa PCI boards"
>  	default n
>  	help
> -
> -	This option activates support for the following Moxa boards:
> -	PCI Serial Boards:
> -	  C104H/PCI, C168H/PCI
> -	  CP-114, CP-132
> -	Universal PCI Serial Boards:
> -	  CP-102U, CP-102UL, CP-104U
> -	  CP-112UL, CP-114UL, CP-118U
> -	  CP-132U, CP-134U, CP-138U
> -	  CP-168U
> +	  This option activates support for the following Moxa boards:
> +	  PCI Serial Boards:
> +	    C104H/PCI, C168H/PCI
> +	    CP-114, CP-132
> +	  Universal PCI Serial Boards:
> +	    CP-102U, CP-102UL, CP-104U
> +	    CP-112UL, CP-114UL, CP-118U
> +	    CP-132U, CP-134U, CP-138U
> +	    CP-168U
>  
>  config XENO_DRIVERS_MPC52XX_UART
>  	depends on PPC_MPC52xx
>  	tristate "MPC52xx PSC UART driver"
>  	help
> -	Real-time UART driver for the PSC on the MPC5200 processor.
> +	  Real-time UART driver for the PSC on the MPC5200 processor.
>  
>  config XENO_DRIVERS_IMX_UART
>  	depends on ARCH_IMX || ARCH_MXC
>  	tristate "RT IMX UART driver"
>  	select RATIONAL
>  	help
> -	Real-time UART driver for the Freescale Semiconductor MXC Internal
> -	UART compatible controllers.
> +	  Real-time UART driver for the Freescale Semiconductor MXC Internal
> +	  UART compatible controllers.
>  
>  endmenu
> diff --git a/kernel/drivers/spi/Kconfig b/kernel/drivers/spi/Kconfig
> index b48aaf3f9..2c5aea25b 100644
> --- a/kernel/drivers/spi/Kconfig
> +++ b/kernel/drivers/spi/Kconfig
> @@ -9,18 +9,16 @@ config XENO_DRIVERS_SPI_BCM2835
>  	select XENO_DRIVERS_SPI
>  	tristate "Support for BCM2835 SPI"
>  	help
> -
> -	Enables support for the SPI0 controller available from
> -	Broadcom's BCM2835 SoC.
> +	  Enables support for the SPI0 controller available from
> +	  Broadcom's BCM2835 SoC.
>  
>  config XENO_DRIVERS_SPI_SUN6I
>  	depends on MACH_SUN6I || MACH_SUN8I
>  	select XENO_DRIVERS_SPI
>  	tristate "Support for A31/H3 SoC SPI"
>  	help
> -
> -	Enables support for the SPI controller available from
> -	Allwinner's A31, H3 SoCs.
> +	  Enables support for the SPI controller available from
> +	  Allwinner's A31, H3 SoCs.
>  
>  config XENO_DRIVERS_SPI_OMAP2_MCSPI_RT
>  	tristate "McSPI rt-driver for OMAP"
> @@ -28,12 +26,11 @@ config XENO_DRIVERS_SPI_OMAP2_MCSPI_RT
>  	depends on ARCH_OMAP2PLUS || COMPILE_TEST
>  	select XENO_DRIVERS_SPI
>  	help
> -
> -	SPI real-time master controller for OMAP24XX and later Multichannel SPI
> -	(McSPI) modules.
> +	  SPI real-time master controller for OMAP24XX and later Multichannel
> +	  SPI (McSPI) modules.
>  
>  config XENO_DRIVERS_SPI_DEBUG
> -       depends on XENO_DRIVERS_SPI
> -       bool "Enable SPI core debugging features"
> -       
> +	depends on XENO_DRIVERS_SPI
> +	bool "Enable SPI core debugging features"
> +
>  endmenu
> diff --git a/kernel/drivers/testing/Kconfig b/kernel/drivers/testing/Kconfig
> index 88c043c82..a189fa19d 100644
> --- a/kernel/drivers/testing/Kconfig
> +++ b/kernel/drivers/testing/Kconfig
> @@ -4,26 +4,26 @@ config XENO_DRIVERS_TIMERBENCH
>  	tristate "Timer benchmark driver"
>  	default y
>  	help
> -	Kernel-based benchmark driver for timer latency evaluation.
> -	See testsuite/latency for a possible front-end.
> +	  Kernel-based benchmark driver for timer latency evaluation.
> +	  See testsuite/latency for a possible front-end.
>  
>  config XENO_DRIVERS_SWITCHTEST
>  	tristate "Context switch unit testing driver"
>  	default y
>  	help
> -	Kernel-based driver for unit testing context switches and
> -	FPU switches.
> +	  Kernel-based driver for unit testing context switches and
> +	  FPU switches.
>  
>  config XENO_DRIVERS_HEAPCHECK
>  	tristate "Memory allocator test driver"
>  	default y
>  	help
> -	Kernel-based driver for testing Cobalt's memory allocator.
> +	  Kernel-based driver for testing Cobalt's memory allocator.
>  
>  config XENO_DRIVERS_RTDMTEST
>  	depends on m
>  	tristate "RTDM unit tests driver"
>  	help
> -	Kernel driver for performing RTDM unit tests.
> +	  Kernel driver for performing RTDM unit tests.
>  
>  endmenu
> diff --git a/kernel/drivers/udd/Kconfig b/kernel/drivers/udd/Kconfig
> index 86b9a8258..9b9b0776a 100644
> --- a/kernel/drivers/udd/Kconfig
> +++ b/kernel/drivers/udd/Kconfig
> @@ -3,8 +3,7 @@ menu "UDD support"
>  config XENO_DRIVERS_UDD
>  	tristate "User-space device driver framework"
>  	help
> -
> -	A RTDM-based driver for enabling interrupt control and I/O
> -	memory access interfaces to user-space device drivers.
> +	  A RTDM-based driver for enabling interrupt control and I/O
> +	  memory access interfaces to user-space device drivers.
>  
>  endmenu

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
