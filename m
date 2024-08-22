Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902818455D
	for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324406; cv=fail; b=TcozTlrlLKpYgpxOonjz1NI5nbNQ+GYmYhdkqy0CHZJg5P73r6Qh4TLSG6k08TKLSWE3zf0Sx5f/qbX+hKsZO6kH6zl/50+f8RqiApjHwajiKCrZXUnBWmMiLSfYQOPZ9lbjs2LhiWCCDzIN9JY8P1lpMMeQ7ZVNzfde29rn0/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324406; c=relaxed/simple;
	bh=j3/8rLchMrGNFG3k63VkXyW82jnWwdXzBKxMidlyanQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jLJGS18gDPsDC493tT99gblN68KT/JucPfGSZf2OQhQf8qrQKdn6Yhdq9Fyzee9YBip+EpxTfAAOgA3HAL7Ze8NcwvdUfRXrQ0Uf6RwX00HeQh65x+ogbOt+TQeh8YFGWBxeELaLsRqtU1CfYTKfmwhXBu3H55j/gfRvWTydODA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Lbr4UnNz; arc=fail smtp.client-ip=40.107.20.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Lbr4UnNz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUUSS5nIC8brotrNG90Vv4sceRgsiQ30a+na+yhKYOpFGU2ORmdLJxzyDxp1kx8BMjxDN8m3O46yitzPpbwnzV8XGCIsMewozTEa8fkZskzZP5I3js4jMO8wakYiPzbyHBHw0STbQagqkbLrorBCHgEkoBmPQYFFjkcafmK5AfVq4LiQXGMZfQK60ZxjSBzT7Ceoowoyw+heoEN0kyMimam6ydfkgaGYYrBkgyWJ8oYcO0bl/jX0jnYYOadT3LJdNQzmHXwdKEhrFhxFvi5OQEghdVLsyMqK7WgipXDlQzCF2/EFlDFZGsxyT07q9Z+WicFCivGukewE+N/2T2kPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8aeOzE0jhX4PCLi69a2fYWTWFGk/cbi08YkbhzsxqA=;
 b=n5VHkxiRetN3vbO9bPVZcYi2wRsiVYAIMLecicKubTs4ZIwpUP6tELaVHHfxYLipYqLlY4+a+by36CGZ+jjoJRDkgXwyd3iREY5Yeb95ClIJQE5qNNZeC7LBKPCZjENGGRuf+7RouOOgfC+eAi86v3xK34yWuz63FjcXo219+moinmBWrUL7nUMW8LNqRNXnjvOcG9mDYOWTpwkiTUaq/gC1iRtjaT7P/NoI+6PmfoSp6+zcJo3sbWsihvC3pREcGWz4M87qy1QK6wKFxEKyXvjb+fVWtFM1X2VoAVAk67K/lC6mGW5N0M2ErfxVCtIeBm4qlIUhBKvk0pOvku4ayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8aeOzE0jhX4PCLi69a2fYWTWFGk/cbi08YkbhzsxqA=;
 b=Lbr4UnNzbZcT1mzdAvM5h4SUImkZmAkJywlhbxiWRIanJxq++mc4HJSbsKzNRFCAEhKtEwwai75lBcN74Xw1SQmSK6zFQtShS1AWFEdvX3ELciYjMDFP/eEkqdwNQI9fR9thwlrvPP6nQRM7xkhd1xxlulRh9+zToOvy00F1gfbDr2b+jSwBEQn6R250wIyz8TcEO3F4Uh+sccECEdeZc0BEWhzj0AwLsbP34PbAEmFHZu5aJ5vXrtbgTm8OU89xwCZucHVQazuwjHmx66rQBbmp65GY4uL7zLSbm9fRdgrEW3QfWC8zbkjRSD7rinJR0E4aov+v3KanTlurWRPL1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAWPR10MB7820.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:360::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 10:59:59 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 10:59:59 +0000
Message-ID: <bbdd9183-fd27-4cf3-b7ae-358498aac6ef@siemens.com>
Date: Thu, 22 Aug 2024 12:59:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] lib/copperplate: Get session name from env var
To: Richard Weinberger <richard@sigma-star.at>,
 Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev,
 upstream+xenomai@sigma-star.at
References: <20240822080737.17939-1-simon.graber@sigma-star.at>
 <20240822080737.17939-2-simon.graber@sigma-star.at>
 <4b024ebb-7d6f-4382-8427-f16024d2b387@siemens.com>
 <6235310.YiXZdWvhHV@somecomputer>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6235310.YiXZdWvhHV@somecomputer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:610:32::22) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAWPR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e47281-3f41-4b43-32df-08dcc29990a8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SC9CRTdiREQ0MkIrQ2NieFhrRkpoT0pjU2ZkL0htU0hOUk11dkRHT1pISlBM?=
 =?utf-8?B?RGwvWUdqVXcxMW5pUXIyeGl2KzZ3djlaRTdCN2xEak83UXhhQzhWRkR1WEl2?=
 =?utf-8?B?MjVBTEtERVY5L3NIcythRE85OWhwYkxweXVBR2Z0b1lBeWdQalNXdlhMYzhx?=
 =?utf-8?B?MElEMURORlVTUXFZbWwxR0JoeGYzckNhUW1CcW5KbkFIQm5VTmdyRWxPNUNa?=
 =?utf-8?B?cEpXNTMwUGN4RTB4U29wTHdhQlA1SUxTbmxYNjNNdFZZZy9PR2tjSkFVbDJN?=
 =?utf-8?B?SDFKaFlOeUNpQVNwWFVFeHk3L1hGcFRRQ2Yxcm8xV1d5TmxyYUVqSDgzdTNF?=
 =?utf-8?B?U09hWGlacTJOSmdVZzBsd3F0Q2NBWlhvRm95czZyL1lKM2Y3YWg0RWFKdXFm?=
 =?utf-8?B?bEZ0eHR0Y0ZjeU55cmdLZnRjYW8zcXJuSEpSVFBsSUM5bjhnV1lPSnJtV0dO?=
 =?utf-8?B?WGJJVnZ6dzNNRUhlOU9nM2ZEWkhRaWUyUXJpaHBKQ0J4QkRRKzNDc1EvU2ZZ?=
 =?utf-8?B?dWk3OWMvN0s0NytXa0xaUDZ3YVdEQy9XL1BsTzE5dS82NXlnUVZRK0xNNWpt?=
 =?utf-8?B?a2k2c0FpYWJLRmNLMFljNjM5ejMxOVlDbXB3cFJVMjJkVGxvSkJ0NE9UcmtB?=
 =?utf-8?B?UjFzc3FpazVVQXJFRXJmNE1UVWlMWW9Fem1jZ3pVT0lXUXpOUC9FbkliTFFp?=
 =?utf-8?B?R1Q1ZkNuVVUzY0tHT2w2bmtPbzdxU3RPU3pZSSswMjhwU0xjNWNReTI0akcx?=
 =?utf-8?B?Ly8yWHhseVZBYUZHKzZ4eVlKaWFwMWtuaEtzOXYwQ3Fyc00rTnBwTmY5N0xa?=
 =?utf-8?B?Ynk4YXdKcjViemxnREtXSmtNaUZ3ZFpBVCsybVIvamhwVTdodEFnaTZOb3p5?=
 =?utf-8?B?NGt5clp4ZVlROW44cHNvMFMzMGR2Ni9SU3VaSlNSeFBxalFPZktVRjlQbGg4?=
 =?utf-8?B?SFhVZFJQK3BQREl0cnV2Vk5sUW4xS09kd2h6QWhUZVpVOCtEZ1E1dDhvQ080?=
 =?utf-8?B?Vkg3ZExsUlhxYW9rODhRWUR0RittWXdTYzZkZGVNcHhpcnNPbGtEYmRFUzJu?=
 =?utf-8?B?MUI1WWo0dHFra1dENmZEd2JtUDhRdUltT1NBamZ6Tzhja0tkekdnVHFUS1JR?=
 =?utf-8?B?VUthNzI5UmJRc1Vsd3VaRTJNVVp6c2tDeEgrU0NySXFZM3VuNEJKYkRZT0x1?=
 =?utf-8?B?NzA3U2VZWGFoOEs4NDBCV3cxUFpUa29JQU8vZG9SeDJtSWpjNkxiMnVGZ1Yy?=
 =?utf-8?B?bis2K21tM2Z4aXJVN0NmR0xEdVJkOE5aN0U0dTA2d0dsdEFHUzdZcHFOM2tv?=
 =?utf-8?B?STdkbWF3RVRjRnh0MWZmNkd5RWpsVnNyajBGZjkrMURtNGlnMGhhS1JBc1E2?=
 =?utf-8?B?RUxZWTNvOWNTMU9Wd3pYR3ovQ1Z6R3BwVFpib3ZkUXU1a2FHZXJaOGk1Wllo?=
 =?utf-8?B?TDhWd0ZQbjlubXdnTFh0TFZsTlRSbitJTGJKRHFrLzZ0UjV5NXQ4emJ2eXVW?=
 =?utf-8?B?L2VTenEvYjZiK0l5ZnJPbDdoLyt3M2lkMkhZR0hTL2RONk5qdjkwbE1RQUUz?=
 =?utf-8?B?NG8xOHFaaGlsSFp1dGsvUGRWVm5CTjlVRGFlNlBiMFRCYVpEdm5NVFQzQVU5?=
 =?utf-8?B?Qy9Cd1hGeGlOMm9kd3JlTFVoWDBmTi93NDZCb1JXa3ZVVThFSHZPRy9qS2pU?=
 =?utf-8?B?WHZXVVVTL1VQam9jd1FqdElZUTFoT2ErK21VYXBWbmtGMExjbVkzN0hjQUhq?=
 =?utf-8?B?andwWm9DRlhvUWxKamdNRWlWWG5yT2FDRGgrYXJQUysvc0Z0VlYwMHhZTnRl?=
 =?utf-8?B?Sk1FTGdDZWNJWVhNK2kzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3VGcHRPaGducFEzOGJNY0ZEUGRLcmRrY0g0b3RldGJXY0lkbGR5VGpxamR5?=
 =?utf-8?B?U2pPTU5FbkE1bHROenhWcytjWmh6M0hNQVhqY3ZmQTdxUnVaWjgzZnp2TnRX?=
 =?utf-8?B?OGlKbXBYUGd6bEJ2UE1ZamFHRFR2WlRwNTFXa3hVRUZOOS9kQXZxM2xqYlBi?=
 =?utf-8?B?WHBENERKZHlDaUkzODkxRlhlQTNZQlE1bTRVWFJGNitUNDh4bFRSSEgyWklq?=
 =?utf-8?B?cEpsZGZtK0ZGVU5RWVlaZUwwK3JDakhROHFaeTRndW5IM3BHMmV0a0JYNjh5?=
 =?utf-8?B?WWUrUmNVM2hOWkF6UGovWlRzVHV2U0NYa1BVWGZpazNjYmhTOWFhc0Y3OGtL?=
 =?utf-8?B?c2RuSmkzMUxFQWNtZm1ZeE5waUhVOUxyQk84aDhMQWlLbFRhYjArR0k0NUg1?=
 =?utf-8?B?MGV0Tk55eWQwbWZ2eXBUMU5HL1g3S0d2dzNBU0hRVjNkVDFNTjZlRklidVFt?=
 =?utf-8?B?aS9XLzJrZGNsVmo2QW4zWjYrOE9VZUNmNWZUWE9kdWJYRnhMWlpBRi9Ya0lC?=
 =?utf-8?B?MkFkcm93TjQwV2lLYTJYMVFTZUMvWElGTnlmOGlKbDlVb0lxZkNaUXFObEZp?=
 =?utf-8?B?Y2hyQlpNNHBOQk16akQ4dTNZRUZSVkFjSVpqQ052TFB6VHZ4VVpVdDRyWUYx?=
 =?utf-8?B?YzBMekFYdjZMUU04UXh0Ym9lT0MzY0xPaWRUampCcWRaOHMxQTNISitMbTJz?=
 =?utf-8?B?T1NrY0tpTzAwU25WZjFzQXJFVjVzWVJRTEdRV3NNaVh1dXg2Vk9JT2lBVzFD?=
 =?utf-8?B?bnRVQlhWQUFubElUUkJVc2Fublg3TmtSVWlMZGZXMWpqR29RSzdmNFFocU1Q?=
 =?utf-8?B?bTZ2bE1IbGFHRDY0aHN0UlhyRjNJTWVsZjN3TEU0cHNyK0RmZzBaMmVlWG5t?=
 =?utf-8?B?VkozRk0rSE0wM2VuSDJoNmZFaTcwcnRucXBjZENyZmtaVGVLWXhjckRGYW96?=
 =?utf-8?B?MTR6RVFPODlTaTFTSlQ1bVM5NnpqcGRkWGlxLzl4N255ZUo0OTYxUnE5aktv?=
 =?utf-8?B?VEwwZVg4RnRISDJZRm5FSFdtejV1QUY4WHArQ2gwb1BJN01GSE1kOVFXR1I1?=
 =?utf-8?B?bVhVNFIzYnQ1Y2YzWjRqQU50ZlMxTDJpNWRGaEpzMVBod29zQy95Q0ltZ1Ri?=
 =?utf-8?B?bkU0bWN0N2ViN3d0MUtrTFRzYTB4ZEJhQW0rNFhyYi93YnNxMitIVG1FMmFT?=
 =?utf-8?B?S1c4Tnltd1NPVjFTVzBiR3JMR1B2OVprUEszU2xtMXhrZmNXRkxwOTAxVlNm?=
 =?utf-8?B?OU5qMnhJVVJNc1g1dHYzL2g4a3RTNE53REdyMU9NNWVJTkVXQm9rTnVnYVhw?=
 =?utf-8?B?NVJOWFlSVHVuY2NTUWx3NzBiNk5rZ1pUMVhPbFI5VEs2dVVzZ3B2bWkzVmU4?=
 =?utf-8?B?RUIxQndPK3NpUVhDQ2pVazVITmJIai9lR2RkMUJ3T3RNR2tWTEx4WG4vcDVE?=
 =?utf-8?B?aGozQ25seGhZa1N0UGFNRWpEVWZYUnRHaStrU3VBOEVLK05uUmVkTkx5b0N2?=
 =?utf-8?B?bkQ1U1VZcUN1T0RpcXZaMmw4Zjc4WEg1ZW9JQmpIWGZEdjNtMXRrci9yN2dF?=
 =?utf-8?B?Z0dnTnlvWGFyYlNDNS9GaUNTMTE0MUM4blNsRXkvQ3liMTArZ1hNVS8wTmNR?=
 =?utf-8?B?Y2lVRVhNVG1SQXdkMmNqbHdacmFGU0ZHTi90Qkp6ZFRNOGVaQmI3QU1IV3Ay?=
 =?utf-8?B?OUZLVkd6RllENHdUZGdsSmFrTy9NUGMwU1BCOUl0bVFaeHlJQ3NmWjYvY0dH?=
 =?utf-8?B?Y3RvNDV3MEU4Y2lPTEN2bUV4dkFuaTRKeUExQktQczNzVXBpdXZ5TzNEaVJi?=
 =?utf-8?B?bnJpQUhZcWNjZExtUCtoNW42YitzSXQ2QUJldW00bzd2SEM4V3l4VUNUWVJr?=
 =?utf-8?B?aGlZUWpsbG5ueEtNaGVSaW9uTlpyOEpVLytnNkNPTHpRNFNGbjg5ejhNeTlx?=
 =?utf-8?B?NWpDblQ5QzBaNXpXOStIR0ZiOEdHR2M4Q1hDMk82cDI1bGhIdkt4VG1GWitv?=
 =?utf-8?B?VU9XcitsaVFNRGsrb1pWb3Zpc09tVGxFSTNmYlNNQU16QkQxTDg2R1NnNXFw?=
 =?utf-8?B?ejF3emE5b2xvZi9FdzJaQ3lHUnYxTE9xMDl5NE9WN2dPSnJkNGVkQ00wMGtU?=
 =?utf-8?B?ck13YUZhNndIT0hSeDVYQ2Zkek5Ya2ZFWTRrakVIRVBOQzNYZW5zbXNjN09r?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e47281-3f41-4b43-32df-08dcc29990a8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 10:59:59.4656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o65s/IZGyjWQWJ1NoxhvxjrE7qp+W/9SD9egUMoVaqbxEtXP54lpcN0aJc2HAoMLc4hJrQhvFP8/VV/fR6CjFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7820

On 22.08.24 12:57, Richard Weinberger wrote:
> Am Donnerstag, 22. August 2024, 12:51:34 CEST schrieb 'Jan Kiszka' via upstream:
>> On 22.08.24 10:07, Simon Graber wrote:
>>> At present, for two Xenomai processes to share resources, they must
>>> be started with identical --session= parameters.
>>> This is cumbersome for extensive projects involving numerous helper
>>> processes. This commit allows the specification of the session name
>>> via a global environment variable, namely XENO_SESSION_NAME.
>>> The --session= parameter overrules the environment variable.
>>
>> Hmm, did we discuss priorities already, and did I say that this ordering
>> would be best? Then I'm no longer that sure, and my feeling is rather
>> that env should overrule command line. Still looking for other examples,
>> though.
> 
> I remember, but the other way around.
> Env overruling commandline seems not natural too me.
> Passing --session= to an application and seeing no effect is not
> user friendly.
> IMHO, the environment should be a default/fallback.
> 

I'm all for least surprise, that's why I'm looking for existing patterns
now, rather than personal (my included) feelings.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

