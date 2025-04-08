Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A8B676
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131489; cv=fail; b=AbbzYw9obFuXGsqU1ZhnVr62XhtMyvLgdpcP+tj907YEd1RktZMYM+ZXYo6Gna9tQrtI5r5ttYqiQdliYDP6go6F8MvvF+uEoXt7UYyElhmn7LFy48LBszPx8hoMAyeK2sGTsKvPo+ahNGsVABWIJgRHNQj7bCrhvG8XQKgg76I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131489; c=relaxed/simple;
	bh=nlyK3OG8Zj/YFhLToH9YsX5VwBErDmi/2Hv3grhJ0qk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l139Br8NzTqp4LlSowiun4q6a2Ym4iO2DKeT6NsFDkiPxQ4PdGr0xXqSRP3cqBwDjEstGMG6fpVlul8lpWRWIItgWkrfIfShmR5SwkkiLHBSk0VVzgYH1MTDTdRvTfTzgI2hgdGsjCrxbSJFosFcT06WTuiIJwX2yF5lvjZPQOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IHLdIbyE; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IHLdIbyE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvjH1LfOpM4QBjy8kRy4j86W6W4OzcTorVybEPDCX5/W8iJTz0/44Lq4Eqk7ewIRNKOuMVdagqKbygTQY+sGciZ/n3WHT2s4ZfpkmP8hwOdshXZhYVbOjp09h/3YGM16BpKfyP1FLNCArUDkEokanCavd9S1wGCNlDqbETegImmcIhM3CFnT/unX636ZeTqZ68TC+Mg6qRKD10gsqGHFpL0JvTVriR0SDt/vcA913hHM2FkIUFG0xG6oAhCw1AbIbHTa2vFIc5ye9zPXb1tNpeB0PBBG0LEfC8mvWBUE0zvDdVQzZtRLPb5JzIaREv5tCMMqfLAT/Xlenqg9npAHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUnLEMYolwgk8WUr/kxktOz/tsGADTJOt4Joe7utCCI=;
 b=e0UzylQhXRBvcf0VLGlJ6DoeJRIELfzDTvOZLvPJysNTOoU53ZxwicJkym/D+qqB3mx3b9dc0mmtVv4HoTamwpZgRhNFoPVeZhzZZvGZ1Bmn2aFAYtT0DJvr9smtvUBbYFCIWUjLku4ljzjzmWizGzW8gtW+5JQgou76Rne/v5Ms9RzRc1G27seNqHnZBjZFYUqMGZvdqzb8idULSXVHDz+zSRofUQVBo3x5drO6I9f6qTZhwq8f/DhJn5GLQbXqlHZ5L/Y1WSa1dscOe6magKolG5FSD+/fZt4bDlwzPrKnmhW9G5+vFEwXM7D/sRhno6gleL1d1xgVzY3S5gY/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUnLEMYolwgk8WUr/kxktOz/tsGADTJOt4Joe7utCCI=;
 b=IHLdIbyEusS4DeMNT+do8q8BrvS5rDKZRCnGmgTrRa9sSBp7zRkSc6ct8P6tebjZppMWtjMC5BtLKgdgaVaqpKZqTh8lETcmoGa/Zzkr5TgoNXF2DcAAaVojVG0BxERsHAwQ1ajji+RsEwOFWX9fmdSGRqe0eSY7B2WwG2go9agTeIhbHf3gQLaJuyGlfWAg5QJZZUTKzYc3/+i8Y3pwbkdOPaCHCHd4aN7KsK6DNOuUfaZ7/XOPPAgqreAij/g8xZssMtXVNt+WgVSqF2BSlbjnBjfhA/yOFjjDItLB0a/c1UBm2QInW4SOix5a3kZvBapDAcqTWw5O/yTMRz3BCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:568::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 16:58:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 16:58:04 +0000
Message-ID: <4c59337c-4cfe-48b7-85bb-2410e71a642a@siemens.com>
Date: Tue, 8 Apr 2025 18:58:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] Dovetail: Real-time Exception Handling
To: Nikolaus Funk <nikolaus.funk@sigmatek.at>, xenomai@lists.linux.dev
Cc: richard@sigma-star.at, Richard Weinberger <richard@nod.at>
References: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a02a962-36cb-4d36-5a18-08dd76be8793
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU5DSytCL0p0ZkpZYk9IK3JHVDdmeUZvNHVwMi9hVkl0OFFmdmpBb0h3S1Vz?=
 =?utf-8?B?SFF3R2w0TUtvOHhnT29TY0RBV1FiUUZ3TG9ZY3JyTGVPUEV3NWgyanArNWVU?=
 =?utf-8?B?d3dzaDkyT0JlMUxDQStDckNHbWU4b0NxSnJNRVVjWVdQcEovdXNJeVJsYWZ3?=
 =?utf-8?B?ZXlsK3R2QlJOclpCRDJWUVlaR0dxU0Q3bFlIbE55MU5ZcW9MVEdQaXFiUk5h?=
 =?utf-8?B?T09XRUxvb0F2QzRsU2pBT0xHQjdhNmFuZHNwNTFQWlNYaktJS1ZKNGo3bWhM?=
 =?utf-8?B?MjJndmtBcXg5QW9jWFp6Q3NCVXFhMzM5ZXFJY0pDVG1UOEx5ZzNKTXJWVCth?=
 =?utf-8?B?cFlhNWhoMjZ6REtsalVpdGo4b2FmRWhIbXlIenhqWlBWKzhuWHAxakZnREVH?=
 =?utf-8?B?ZmxIQTAxNDAxV2g0alBQUkc2d3lQSnNHYVc0YzlNaFNDWExFUXZEY1FIYTRa?=
 =?utf-8?B?UGl1TXhEc0ViUFB1d0NiUjkxVVdZTENiSWVXd21jNGVBSTRDSm9HYjlrbUE1?=
 =?utf-8?B?WjZ3WG1uNUJZRTdVc3l0UC9TbHl6VlRoUE1wMTUzSTRoWGl1SDZjUHZWUktk?=
 =?utf-8?B?WStBZzlWZ2Z0MVIwTHlyelVhSjlnVmpIbHdtUldoblF3Y2NHSGlWT01nT0F0?=
 =?utf-8?B?NTZlMDdsbVRIV2xLejNnczZSbFZ5aGlsRnVaamNBZTc5b0VUbzB0MGtzd21C?=
 =?utf-8?B?QkRyR3cvM2xyblJiMlpGVWZSYjRrUGN0YVJUaVlQc0x4Z0lxZ2pzT2pHM0U2?=
 =?utf-8?B?UlpnYWdESWpWb3ZSeXhpMStpaXo2Tnp0cGk3RHVLS1BNQTNMNkErdTRMbW5u?=
 =?utf-8?B?NTRmaXlhOWdMQUN0V25oemU4Zkl1RzF1Y3ZiampGZXZIKzJEa0lXdDNmWi9I?=
 =?utf-8?B?eDNDZVBrdlc3bWY1eDVwVjZQRmR2NXZndXdhSy9XcEJvRkhBU3RVaXp2ZjUr?=
 =?utf-8?B?Z0YyYkQxdndHZ0h6N1ozWHFUM0VqaUF1VHJRWXdOL0lVVHYzaFlFZi9taDJK?=
 =?utf-8?B?NUMrekhobEp4bEhGNVdkY0wwSkp1aFhxcTF0SmgvUGtvUlBBZUFuOHI4bGJz?=
 =?utf-8?B?eXpSZVBIU0s1anNtWHlKS0d4RmVKeDM5TkMxcDFnVWdFOUpPQ05iRXZRYWth?=
 =?utf-8?B?MklpUjJZdUJLTlpSNnFJY0lvUFM3TjNaYVQ3TllMbm5BYzF3MzJwMVNHSEd3?=
 =?utf-8?B?dlFLUk5rY0VFSUlFZUp4M20rTDlIYkVJaEVBSmVQb29TV3dlaGJrWkgwZ0lh?=
 =?utf-8?B?N3VBUW1MclZJcjF6NHFSaFZ6U2JSUStVRXhXb1pua1hRcFZnalY3aGVCdVZY?=
 =?utf-8?B?MVgxTGgrK3IvR0E1bHY2cDZPZm94d0xUdzBsNUt1czVRcXQwY1dwNmc4N3ow?=
 =?utf-8?B?ZEl4bVNpRFBKaDJmQjZXOGhISHFveHArclhNUFJhVWFkZFg1Z1BFMUxJUElp?=
 =?utf-8?B?aE9UajJwdUZxUUk3Q1VkTWVwaVc1U2tWVjVXdEkyS2plazliWGh4bjhibXVu?=
 =?utf-8?B?K2J4aGw5Z0libzJiUkc3bk9kRlRaV1ByUzNVNEdSQ3piemtkclZ1Uk04NVZR?=
 =?utf-8?B?c0M0Z2VjWXlZMFhXMjZOMjk0eUZXSFZLZElsZndackhMOFE2SU5mbStaaC9M?=
 =?utf-8?B?aVpad2lYV0dnd2l3MzAwUVlwWDhOVzg4eEVJY3h0WnJ5bjhHWHZaUG1EWllo?=
 =?utf-8?B?b3pGZnBzWHphWDZKTitGMUZsT1FwT1FTTDhmcVNXYy9LakRFMEVPL0tuM3Q0?=
 =?utf-8?B?MXV1UGhVWnpKRFVXU1Nub1dtUG1SYnk1ZENDWnV0cEZ0WmU4OVVDcXdYbTRH?=
 =?utf-8?B?MThDQUg1WURrbUNWdVh5ZWJDR2RidzM1cm9wdDNzTWd2dE5tNEpVbS9iSlhk?=
 =?utf-8?Q?95X9545IuOBKp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STltdzlzOW81L3FvRVRpVXBCbGlnOExjT3R4WnhxUnFqNll1cWI5MThUSDFR?=
 =?utf-8?B?Z3IzMlJ3amhjNWVhelJZWkRyY0kxNU5JSDcxMTYxS09QOVJRS1F1cEpsNkMx?=
 =?utf-8?B?dkFnb0xKY2JCSElXZEY0MTlhM0dheEMyM2NpLzZueFJ4VzFGK2dBTXVMZ2Zx?=
 =?utf-8?B?YzJqdmErOHVDallRWis2NExpbks1YTR5MlBtQUJZeGd1R2tzdGZ6ZExCUjNB?=
 =?utf-8?B?c3FrNWJKZm9KQk5xR0RERGFNVXdRb2Y3NTZtREN6d0xxaC9PZGJtQVAvME9j?=
 =?utf-8?B?N0VOcFN2TnVGUnBtYkFwSmIyMmd1c3BORE1uRnluaFRqK3d2R1NTeThMaVc0?=
 =?utf-8?B?c3NrdzkwTnd6VnVyRzhQV2taTEZFYWFYVFVJczNRclA0VStxaGlyT1k5OGFa?=
 =?utf-8?B?Y0trOFQ4QVMzaE1QVWZFUExJSlBKWEludjlST2V4OFAxSVB3dy8wRmsvV1N4?=
 =?utf-8?B?c095enZBZDBkV0wrUDc4MGJXRjI0cHV2NllOTEk2SWFIa2JMMXRrYXpFVzUy?=
 =?utf-8?B?WE1HSG1oME1nSlBxc0J0YU94bDJYd2hpdVlhMEdSRGQrb1BEVWpIa2ZoT1pF?=
 =?utf-8?B?S2trQUphL3NqbmNDcEs5QnBhS0V6ZnFKbEpRdFBmN0N3ZkhYbU82WTYvS3BF?=
 =?utf-8?B?cStrZmRaZWVodVJDS0VrWUM3akFUVFFEYkV0QWVJcnlDQWR4aXY1azlnSkFQ?=
 =?utf-8?B?T3E4N1ZuOWNYeTYxOEVpRVNaZjIvUm1HUWhxRWhYWkhHeDZKcFlYd05KYXF3?=
 =?utf-8?B?blN1K2wrVWxyblVPUDNXWDFRV085U2FPS3VqQWhDelBZNlhmUHdqV0JXR2cz?=
 =?utf-8?B?dzU1R1RacjhKSU9nd2U4dWVWSG5MdloySUxUSEJuUHUyblJsLzdJSlk4ZUM2?=
 =?utf-8?B?UWdCT1Y1blJkNGJ5aDdCaVZ1elFIaDUwWWZQMndQdElYZ2htdFAwTTVpeVl0?=
 =?utf-8?B?UzJkM0QycVlpZk5jSk5oQ3prY3V6RHpWQzR3YmVVR3gxdkVYazhIOURzcm9t?=
 =?utf-8?B?WDdkRC9ZcGNJTzJISWpqRytNbGMyM01NNnp0Zi9rQXdGcnRpNGJOSm55V2hE?=
 =?utf-8?B?WjJTeFRaeFpseVRPTkVRbCsrandQL1VUNGlwSlEvalMyNzV6TDlnOVZBQUcw?=
 =?utf-8?B?ZzVwZDJMNTZ1RE9ZcUg4VjNUZlhQMEJsU3hoMFgvclVDYXlEbjArK1UyV1B5?=
 =?utf-8?B?OERGL3A4SEQ1cnprVGx3S3Q5Q044U0xRRzFsNk9YbmRvczg4aGdFZE9pVy9L?=
 =?utf-8?B?bE15dEJnV25RVk02WTNDWWwxdytLbDNCYjkzZ09JTnhGVXlSeThLRVlQbzdi?=
 =?utf-8?B?SFdhQ2c5K0RNTWxZak0zR2diQ3grbzFCTTdIT1lNZ014bnY4S0tlMVVtZ3gx?=
 =?utf-8?B?bmVMR3oyeWQ2ZDZ2ZjJzS1Z4YWo3RVRQMDF0YThZcmhXMitBUjRRWFRvY0hq?=
 =?utf-8?B?Q0gzWXdHY0R4T3ZRcDdHeXVucDJhUXMxa1dVNU92OE9TejZlQy9qVmp1V0xM?=
 =?utf-8?B?S0VsMVQwekxhNTNpcjFDUGVobEhqRzdUeU1lb0JtVUJsMXJrbWFkUU0rQTVp?=
 =?utf-8?B?QXJySFdwVmprSTA3OWdJVStzdGsxVzJ6Sm5DUU1VdXBvanpTYlBiYlF0QzNp?=
 =?utf-8?B?Sys3RkJtYjVEY2MwdGY3TDB2Rjhpdm5oNEFlR1g0Rk0vcmxGcVRkQTlTOGdV?=
 =?utf-8?B?OWdwR1dFNzg1U1ptOFkvT0huMExpanQzTnUvZzArQVU2R0dEdk5BYXJHS0pS?=
 =?utf-8?B?MnhSS3UrZjdDQ1NvbnZ4akRTamc3TjdjbjBJNlhBZWhqM1FKYWIxS2QzTkJ4?=
 =?utf-8?B?bHJLcVNuR2s2cVg5QlBETWY0SzdmemNvRlh5OEdmcllQcFYycFB1YXZseWdR?=
 =?utf-8?B?WWdCNldyMlowWm1QczBFN3crbitXNWtmdnBsVW5MWXZNdEtEdlFqQVRHUXFl?=
 =?utf-8?B?a1RHMXovYUl4TkJCQS9mSkZpOG9XVGljSTJucGs0VlYzS0ZjTFRscWN0QWRl?=
 =?utf-8?B?TVF1ZGt0bUxud3FITlJJT2xlTUxVcEV4UUhNZExwTUI2UThLMXYyYVlmMDlM?=
 =?utf-8?B?elU2dFdxZWRwTVFpbG1xTDNVRkpxdmtKME55a2JoSFlhK09mSjFiT21hZ2w0?=
 =?utf-8?B?RGpsL0xxZGpza3ZGZ0huMFNzcGRmZmZ3bWRIQ3hiM0krOVVYYXQyU2NjbkNY?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a02a962-36cb-4d36-5a18-08dd76be8793
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 16:58:04.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SS3L8KYtv1kHhwpFmV9ZjrhMLs/krzNAJyUVL+IY3gHF/m0v6JPudy5VygB0fN7dWTPL7tnKJVQMLowT4NVD1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8712

On 08.04.25 14:34, Nikolaus Funk wrote:
> From: Richard Weinberger <richard@nod.at>
> 
> This is the Dovetail side of the real-time exception handling
> (aka real-time signal) feature.
> 
> In its current form, it's a bit larger than expected because it also
> includes the signal frame helper functions. It's debatable whether
> these should be part of Dovetail or Xenomai.
> 
> The smaller, but much more important changes are for ARM32 and
> ARM64. These allow fast return from exception handling so that
> Xenomai can decide whether an exception should be propagated
> to Linux or not.

Is this targeting latest dovetail (6.14.y-dovetail-rebase) or something
older? Did you already look into how well backporting works? Just to
collect already information upfront.

Jan

> 
> Lorenz Kofler (1):
>   x86: dovetail: Helper functions for signal frame setup and restore
> 
> Richard Weinberger (4):
>   arm: dovetail: Fix user mode UND exception handling
>   arm64: dovetail: Allow early return from traps
>   arm64: dovetail: Helper functions for signal frame setup and restore
>   arm: dovetail: Helper functions for signal frame setup and restore
> 
>  arch/arm/kernel/signal.c           | 50 ++++++++++++++++++
>  arch/arm/kernel/traps.c            |  6 +++
>  arch/arm64/include/asm/signal32.h  |  3 ++
>  arch/arm64/kernel/signal.c         | 85 ++++++++++++++++++++++++++++++
>  arch/arm64/kernel/signal32.c       |  2 +-
>  arch/arm64/kernel/traps.c          | 18 ++++---
>  arch/arm64/mm/fault.c              | 15 ++++--
>  arch/x86/include/asm/sighandling.h |  3 ++
>  arch/x86/kernel/signal.c           | 80 ++++++++++++++++++++++++++++
>  arch/x86/kernel/signal_32.c        |  2 +-
>  arch/x86/kernel/signal_64.c        |  2 +-
>  include/linux/dovetail.h           |  4 ++
>  12 files changed, 254 insertions(+), 16 deletions(-)
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
