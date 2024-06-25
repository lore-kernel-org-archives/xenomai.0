Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41A6149DF8
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719353852; cv=fail; b=D/lRImgUyUOcVF2IvobMO6wVqYswTJhi5AsO7YjGZsBO35sA1TXC0nbhf2ogwPXGWzZFXvEhO+9mjU4788mouLcgpTu2wWkqBLRcYz7wjK4ytR/9WnA2FgDNKEbMwUyPPT0v5sOhDN9t3faO1UZzKCAKAljWN979T8HgwP48g3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719353852; c=relaxed/simple;
	bh=YxTgJwpxhIaYksIbxjhrXnIrbSeLR4HWjxnYQkTBznY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eMBal3dfYb74Lvn2sVa/0CUaIICGLzG5q8nbBaXRvTLN2LaAi5mEpp5nSZwcyis9Ed9f4srqxA4hztLrdSXQz3rFWL09YlqcxHhDxZbBcq824s2+Epok72oXN3Za/IPzmrriawuR13I1DW8QwHjWchNoS5JLtMXsiIZvG2kUaZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=t24FtvA6; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="t24FtvA6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMAOpbQRje77NAlj+T5q9+neGuIZ6gD8aYMjqgIzetWk79eigDHgW4BJLjabAHToIk8hj2Mrxw+1tKbVWdzMWnyEnyLcToTZxnSPomHEPh+k+4iGQ10ss3nM8JHCNJBeBtdv+vZ6GkkdyI69hnLzRMaVSwgOy/Cq8Q6Y0pCFj+sRu4MdtP8uOikuMqGV+1263h3vddYJ51/QTavLkwZhjQjqzN9RLdj9z+IX0yzyBlzH1qsO4fCma0A/8XYmcG6W9BGQ9kTvVPfsRIBF0z1H2O92fFI6D6vFTE/bCN6org7uzN/MWySwiEDH91atdLrplk0OuhKWzTyX6Fvam+slTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXl3nCqFOqtk2TfF4aPLx5bvPQrsFoUgK7lfOc/aX7I=;
 b=DSPBAvWL8jXLNhfZOkUxOqOiTqUw+WWLPa+MhEsDk4yYT85o+0P+aOKqjiHvVjQy7amm0Pb8ifZNYCS7hwxaIaKFgzQRRaEVwsGquyRwK3DECyaOn6heBxSv/ZW4vIfYOHMAU/W0chcg7SX1RFe3LD6v5EkGvMHb1+ee8DPH/iPgIOIReiHtgYyU3QQddqvjpNA6isL/3dHvNo0QlzaPN5LpYd/7Q7h0vL7kB7RqaZrWUOiXWC7MNb1Sgslc/AJzQIgKEYl/DPB9YVaNZo80PLKUPGcT8rj2AcCLg5W1gCFIld7grWfh2p4BkgsP4UN82v+d2m86wXuqCXnOrDKpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXl3nCqFOqtk2TfF4aPLx5bvPQrsFoUgK7lfOc/aX7I=;
 b=t24FtvA62kYZ1kWq08hm1pvk03LT1VtABANUVfOKSawJvPop/bf4pDzcP8OoLjLf2KLMg2doB4fbPYYz7lA5ch4AzkRxvnCrgg28MPbWF4wGJsrOG5eI0rQdycZlYsSA53yq8ler89pa2U2dxz/ygy+qA7ohOKsrKrGX1czSFI5tP+qQbDPJj3Suz8NM+7DxkMc2rDaD5SqYcmIwRSUbWrYk6PehIVk3qtoqJrv2Nxi7ENchhH9cN/sTANCYVK6W9eKeIBndYrlRWMACg9bNVzfLREgxzOtKfAryzPFovJ1c3qRdHCAqaC44/oKoAZCY9kA4swsFr4NqfD9EAufV/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3909.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:161::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 22:17:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 22:17:25 +0000
Message-ID: <f4bf09f6-5051-48b2-828c-bf770fe6f70e@siemens.com>
Date: Wed, 26 Jun 2024 00:17:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] prepare-kernel.sh: Add reverse mode
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240625214950.22728-1-richard@nod.at>
 <20240625214950.22728-2-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240625214950.22728-2-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3909:EE_
X-MS-Office365-Filtering-Correlation-Id: dd41bd19-a9a6-4be3-0683-08dc956497c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVdwNjl4K1JxMUZqOHpQUVVUa213NXFBWXE0ZXI3UkMyNGJEc21JWit2aEJh?=
 =?utf-8?B?c1dVbml1WlZoUUUxYzNpK1dMM2lvVVB5VHZ4YnFDOTRCV3hmNkVCbFBwT3hP?=
 =?utf-8?B?WndwRi9mdUIvTE93bzFhcUtHNmJJbGpvSTdEcFlBTFJuUm14TjF1VXkreHdP?=
 =?utf-8?B?VEd3YVBFbDRuMHNUM0k2TlNBRlNlSCtkT3dqZ3U1WmphR3hWUTZ3RU95WkFM?=
 =?utf-8?B?aXVDUWNHVEVXM3lnSnNOQ2s4bGJBU0RCb2lWMzkvbjB0WUw5VTFvZXdxaDBC?=
 =?utf-8?B?Wld3bnd6WXI4TWlrQXpHTUk3ZjBGbThnV202Q2lYK2VHV2NVc3pPdEtFUUJN?=
 =?utf-8?B?UXhuYjRmTjhJcTh5eEZmRzB5WlVueklXU1E4czNoS1ZpMWpUVDF5ZnNjRHZS?=
 =?utf-8?B?NGZNaDd5SFlJOXVycXplR0w1TjFIOENFeUV6eU1tWW1LU1NiUU0yVitEOG9Y?=
 =?utf-8?B?RnhWRDNRZml1bnN1YmU0WkpNVlZyRGJGTWs0OTFtOGR1UVdzRVBTYTRJaFJt?=
 =?utf-8?B?U3B4VGFUWXNYaElWTW5kdjgwU21XTWtDOGlrUzlpUzcrR2RVRFQwY0pUdnE1?=
 =?utf-8?B?KzYwWHkvZWd1dENTSkdGQWRES1hNcDhWMkw2UHF4SjZiM1QvQ090TmE2SXp2?=
 =?utf-8?B?Z2NGRHpORkVMTml2NjhLckw0MS9NZ0tNNU9MRDh2WHR1Wk9xL2hnTkMyV2Zq?=
 =?utf-8?B?MUdiWHMvZlAzeVI3NXRPYk9HL1NMV2w4TzFOSkRRd3FTUFJhejMxc0ZiSlE2?=
 =?utf-8?B?RUFTSTBhcFF6SHBLWFNlZ1hobXEwTVRzME43L3JVRlpUNGFtcVZyT0x5Z2Fh?=
 =?utf-8?B?YVFpVVl5clFjQjRYSi9URmZVVjM0bDZWVy9lbDloaW9DZlY5SFlsdWpJVEcv?=
 =?utf-8?B?eHdSR3ZmbE8yRzNxbENXK1BNTk1rNlRrVm04VVhmNm9UcW81N1F3V2x5Mkgz?=
 =?utf-8?B?dTJjWWRmc2s4Vnl2VnNzUDBraHpXVkIyc0VuTVUxVitEc25TWjFkZkhYcFVS?=
 =?utf-8?B?eUNSekNLeXJiT2ZraWR1U3VLUXBmeHFYU3hQUTE4Y0hBQ0dMVTJKM01GVHlH?=
 =?utf-8?B?UUFvMTFvYkhNVy96Y1ZPL1pIV1BRcTRLaGpVZHVWR3BsTkdxM3A0bVZaUE9V?=
 =?utf-8?B?TWJGbTVxK2xXMDNvYTZrVCtvaHF1OXV4THJJRHRJMHY2VHM2NStQclpta2tD?=
 =?utf-8?B?ait1UFgwZEtZYkdYM0xBeU9lcGJYU2Y1SjUzSStmbXpBZ0N4VS9yZFJtbXFz?=
 =?utf-8?B?UkE1cTgwVnczazg3WjdoWHIzNk1WVFZxa2YyWVZ3NUhmTDJUaFdiaE9NVHVa?=
 =?utf-8?B?dHFQUmM4QXhaM2lJcnhHUnh2Q1duYUZweDRZbEg0SVVnM2FSVTNINWJUQ0dt?=
 =?utf-8?B?SElaYlNDWHg1M24xSUQ3QlNCSjZYQUphSzB5cXluVGlWWTNoTlIxTEI3dWFk?=
 =?utf-8?B?anJvNTdOSVllaFF6SVVOdkpsNkV4UHpXcnp2ZUlDdjI0NlhEUFVhZHF2VTgv?=
 =?utf-8?B?RlhzTzF1OFZuSHptYTJTTnB5bkNaNXBOT01COGVRZERTT0N0bGJ3dTVkanp2?=
 =?utf-8?B?aG9nQ3V3ekMyVnI5eWQwR3Exc3piKzFpTjNTbzdPSlFBMTlxNHpWM2VUK3dC?=
 =?utf-8?B?Tk5UMkw5TVhsWmwzUE9tZHBYdGF2VmUxYVBUNkRKVWtkWUczN3JsOHlsenNE?=
 =?utf-8?B?ZjZmZml2ZjY4Zkp6eklHaGpUVU5zZXNjRVo3Z2w5eG9CdThQTzVhdTJNbm1Y?=
 =?utf-8?Q?piPDnE8KsTwzQgsP+xI6JfwLnubpWVKXa5uaajq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3YvL2xGelFiYXZzVlVUZlZOSFVwY240T0NHMVpvWG5oR0tOVFJtbmFwY1ZL?=
 =?utf-8?B?Y1lZSjNhMzBobkpQUER4YVA1Q0VwY2Nxb0tkL3MrTkwxWldaaWQvcTR2YXE2?=
 =?utf-8?B?d0xvVDV2RVM0U2RZSWkzUWExSjlKMzRWVGRrOHUvazhTaVZvYzFPR0FRTGJK?=
 =?utf-8?B?OGlGRW5RYnd4UHhxcnA5NUdLQ2oxN1g4ZHhQSlczSEZvL0RHb0t4OExYNUVi?=
 =?utf-8?B?TUUva2ZydW1KOVh2Zk9QVldLdVFERFV1UmVIVnMrT2ZtWWt2SW5ObWRmNFhC?=
 =?utf-8?B?MlVkTTJVRFUzZFJvR01tczY5d0ZvYSsrbjNZMUxnZnVZRWMyeGpscUVKemUr?=
 =?utf-8?B?RUV6SmE4aUJlRVlkUUVMSE9yK3o4UTFOcFBvK0ZyRU9tM3gzcGEveDRFZkhV?=
 =?utf-8?B?UjNuTW42eHBnWVdTSmpxZkZ6LzR0VGJBT2VEKzZNRjJTLzIyRWNEZmtVa3hm?=
 =?utf-8?B?SW5tcWFkbS9TMk5ydU5uS3ZhMllxQXVZR0J4QkE2dTQrdm83NVNvYTdTbCtt?=
 =?utf-8?B?UXY3SHBidnlEYnVCU1dEYXp5TUtPUnlnbkppR1BvN25lTmJWUkF4ckw4b1Jp?=
 =?utf-8?B?WmtDSTRXWG92SG5mT2NhakdlTzgvUnRsRXlOMFFlTXQycFhuclNyUWNUOGFP?=
 =?utf-8?B?YnVpUEpFR3pIcXIzR0hsRkdmMEllcUhwaTA2S0FTZ1BaQkNVeWMzSDBqa1JD?=
 =?utf-8?B?ZTJ6UDN1elpycGM0ZmlzNWtBSzFuSzNuS0k0aVh4M3ZPdHlvdTBGb2thVldD?=
 =?utf-8?B?MXQ4anE0b01uR3dudVIwWk83V2FiMDdYUTljNDdZbitmY1dnOE9ZcGEyQWRD?=
 =?utf-8?B?c2lxMGoxUFAzaE9DOFVteG5FeG4vRDZhUWNDOUNTNDBWU1pNdTNmOGdQZ2gr?=
 =?utf-8?B?NGs1TVNvSGJtVXM5Tkw2MkZuRkdubFFJbmY1SkQrVmZNeGlNc20ydVY0aFNW?=
 =?utf-8?B?Nml4WWRVVlZLNEIvRnZhSk1rNGxYNW90c2xadkwxWDk2bmZrR1BnT0J1ZTk5?=
 =?utf-8?B?VjBueU9QalhycUpsYjNhVTJIVFhxeXRueGtzS2YrenF0QS95dEFyMHU3MStr?=
 =?utf-8?B?K1VqQ1FPc3lZd3hYLzNLRktWSGsweVhFeUlOMkZwMlVub2l3UTlIL0NZMmF1?=
 =?utf-8?B?UlpaamlKcFZTQTF0czAwSkRQeWdhdHhsZytQaDNvL1h0NXlzS1RpcGl3aDY2?=
 =?utf-8?B?VkV3NUNpMjh5TTRVaWUyandRL1laUTZUc21YMVhSNTNhY1lHNytqSFVNeUta?=
 =?utf-8?B?Uno1Z3hZbHFqTG1yazNHYVFJM1d5NThHK1FnbE9UN1gxOUR1aHhYd00zOCtq?=
 =?utf-8?B?Qno2M2VKS0J2My9TYkNLOGJvb01iRGZBS0RWU2x2ZkNVMmZCRVVScURoVTVW?=
 =?utf-8?B?TEFJRmtmQWtaenJ6VzVyUHlZVnNPT2R1TnNhTCt0Tm9YVkgwMGZyUHRYSWZQ?=
 =?utf-8?B?b2VMWHR6SE0vUUh1ZDJpVUEyWU9tNHNhUlhJbU5UV2wxYjNrUG1NWGI1NDJT?=
 =?utf-8?B?NmkrY2lpS1cxWHVLNWpwQkJ3Nnd3MUtLUDB6blNzN0ZReDBhMk50Rk50Qmxm?=
 =?utf-8?B?MWQ5MmVJNFhGYXlsandtcjFsb1Q0Rk9TeXhObEVySEoxVEF1MEFDNkw2RndC?=
 =?utf-8?B?NVdsSmZudS9LUlRBQS9aYlY2UklIOE1ML0Z0NEtWRWM2RVByRVppVjgzVlVG?=
 =?utf-8?B?UDNyOEhpV3MzRGdjZTZvTWNwSmx4NUhZQis2bUt0MFUrN0lsQzE5VmN5eXhi?=
 =?utf-8?B?bDVJNUtabjdlNmlZRmd4YlNrNHkxdXhXQTZlSC9QUWZ5V0hiVkV1QVNYVUxE?=
 =?utf-8?B?YUJDenVMbWdxV2I2ZkVrQ0xoeEtIT3lIUWVVMWd3blV0RGhLVGwrQWVQd2d0?=
 =?utf-8?B?d0c2QlVacDVHdi8rdC9YMzNNTDcrZTFxSTRiU0VUdnRWTUpVeTArVVFVV2k4?=
 =?utf-8?B?YzF4RkxNbi9GbzQrSkljWVpjM1lTQUdBMzhla2RPZEhDTW1Kd21YZTFBbEdU?=
 =?utf-8?B?eUZCQy9INWlEZVdCdVhNQ1o2ZnphU09qeWg5b1J2SVhkSUltSU01andFaXp4?=
 =?utf-8?B?UjIvVXM2bnBlMnZ4K0FxMGZnOXVsalluWUcrMmQrYlV5UnhmMHZEWXhQcC9s?=
 =?utf-8?B?M0JxMkMyOFkwNVZMbnQ0UG9EUk5MTlN1aS9jQ2Y3MEdKVjNuU1FPOVNaVlJw?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd41bd19-a9a6-4be3-0683-08dc956497c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 22:17:25.6118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpWAcxz+FtBlg7mdHmBvDZXNWgvon7LLNRGfehZRFfs2X614bXhW/+fxaFAVDjChA1tYBaXnqyHcu9DpELwznA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3909

On 25.06.24 23:49, Richard Weinberger wrote:
> There is currently no way to undo preparing of a kernel, except using
> --outpatch and reverting the resulting patch later.
> But in link mode the kernel tree needs manual cleaning,
> which can be tedious if a git clean -f -d -x is not possible.
> 
> The new --reverse flag offers this feature, it removes all previously
> created symlinks and directories.
> To be able to undo effects by patch_append(), keep a .orig file link
> as the script already does for symlinks in the linux tree.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> [Jan: add missing init/Kconfig reversion, fix indention]
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  scripts/prepare-kernel.sh | 75 +++++++++++++++++++++++++++++++--------
>  1 file changed, 60 insertions(+), 15 deletions(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 7a1c4d923..c9a02583b 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -55,6 +55,8 @@ patch_append() {
>  		if test -L "$linux_tree/$file" ; then
>  			mv "$linux_tree/$file" "$linux_tree/$file.orig"
>  			cp "$linux_tree/$file.orig" "$linux_tree/$file"
> +		else
> +			cp "$linux_tree/$file" "$linux_tree/$file.orig"
>  		fi
>  		chmod +w "$linux_tree/$file"
>  		cat >> "$linux_tree/$file"
> @@ -66,6 +68,16 @@ patch_append() {
>  	fi
>  }
>  
> +patch_reverse() {
> +	file="$1"
> +	if test "x$output_patch" = "x"; then
> +		if test -L "$linux_tree/$file" ; then
> +			rm "$linux_tree/$file"
> +		fi
> +		mv "$linux_tree/$file.orig" "$linux_tree/$file"
> +	fi
> +}
> +
>  patch_link() {
>  	recursive="$1"		   # "r" or "n"
>  	link_file="$2"		   # "m", "n" or some file (basename) from $target_dir
> @@ -90,7 +102,7 @@ patch_link() {
>  		find_link_opt="$recursive_opt \( $link_makefiles_opt -name Kconfig -o -name '*.[chS]' -o -name '*.sh' \)"
>  	fi
>  
> -	if test "x$output_patch" = "x" -a -e $linux_tree/$link_dir; then
> +	if test "x$output_patch" = "x" -a "x$reverse" = "x0" -a -e $linux_tree/$link_dir; then
>  		cd $linux_tree/$link_dir && eval find . $find_clean_opt | while read f; do
>  			if test -L $f -a ! -e $f; then rm -f $f; fi
>  		done
> @@ -102,11 +114,15 @@ patch_link() {
>  		f=`echo $f | cut -d/ -f2-`
>  		d=`dirname $f`
>  		if test "x$output_patch" = "x"; then
> -			mkdir -p $linux_tree/$link_dir/$d
> -			if test x$forcelink = x1 -o \
> -				! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
> -			then
> -				ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
> +			if test x$reverse = x1; then
> +				rm -f $linux_tree/$link_dir/$f
> +			else
> +				mkdir -p $linux_tree/$link_dir/$d
> +				if test x$forcelink = x1 -o \
> +					! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
> +				then
> +					ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
> +				fi
>  			fi
>  		else
>  			if test `check_filter $link_dir/$f` = "ok"; then
> @@ -118,6 +134,11 @@ patch_link() {
>  			fi
>  		fi
>  	done
> +	if test x$reverse = x1; then
> +		if ! find $linux_tree/$link_dir -not -type d | grep -q . ; then
> +			rm -rf $linux_tree/$link_dir
> +		fi
> +	fi
>  	)
>  }
>  
> @@ -133,8 +154,7 @@ generate_patch() {
>  	)
>  }
>  
> -
> -usage='usage: prepare-kernel --linux=<linux-tree> [--dovetail=<dovetail-patch>] [--arch=<arch>] [--outpatch=<file> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose]'
> +usage='usage: prepare-kernel --linux=<linux-tree> [--dovetail=<dovetail-patch>] [--arch=<arch>] [--outpatch=<file> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose] [--reverse]'
>  me=`basename $0`
>  
>  while test $# -gt 0; do
> @@ -170,6 +190,9 @@ while test $# -gt 0; do
>  	--verbose)
>  		verbose=1
>  		;;
> +	--reverse)
> +		reverse=1
> +		;;
>  	--help)
>  		echo "$usage"
>  		exit 0
> @@ -219,6 +242,13 @@ if test \! -r $linux_tree/Makefile; then
>  	exit 2
>  fi
>  
> +if test x$reverse = x1; then
> +	if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
> +		echo "$me: $linux_tree is not prepared with Xenomai" >&2
> +		exit 2
> +	fi
> +fi
> +
>  # Create an empty output patch file, and initialize the temporary tree.
>  if test "x$output_patch" != "x"; then
>  	temp_tree=`mktemp -d prepare-kernel-XXX --tmpdir`
> @@ -227,6 +257,11 @@ if test "x$output_patch" != "x"; then
>  		exit 1
>  	fi
>  
> +	if test x$reverse = x1; then
> +		echo "$me: --reverse and --outpatch are not compatible"
> +		exit 1
> +	fi
> +
>  	patchdir=`dirname $output_patch`
>  	patchdir=`cd $patchdir && pwd`
>  	output_patch=$patchdir/`basename $output_patch`
> @@ -353,15 +388,18 @@ case $linux_VERSION.$linux_PATCHLEVEL in
>  			-e "s,@SRCARCH@,$linux_arch,g" \
>  			$xenomai_root/scripts/Kconfig.frag |
>  			patch_append init/Kconfig
> +	elif test x$reverse = x1; then
> +		patch_reverse init/Kconfig
>  	fi
>  
>  	test "x$CONFIG_XENO_REVISION_LEVEL" = "x" && CONFIG_XENO_REVISION_LEVEL=0
>  
>  	if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
> -		p="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
> -		(echo; echo $p) | patch_append arch/$linux_arch/Makefile
> -		p="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/"
> -		echo $p | patch_append arch/$linux_arch/Makefile
> +		p1="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
> +		p2="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/"
> +		(echo; echo $p1; echo $p2) | patch_append arch/$linux_arch/Makefile
> +	elif test x$reverse = x1; then
> +		patch_reverse arch/$linux_arch/Makefile
>  	fi
>  
>  	patch_architecture_specific="n"
> @@ -369,11 +407,15 @@ case $linux_VERSION.$linux_PATCHLEVEL in
>  	if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
>  		p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
>  		( echo ; echo $p ) | patch_append drivers/Makefile
> +	elif test x$reverse = x1; then
> +		patch_reverse drivers/Makefile
>  	fi
>  
>  	if ! grep -q CONFIG_XENOMAI $linux_tree/kernel/Makefile; then
>  		p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
>  		( echo ; echo $p ) | patch_append kernel/Makefile
> +	elif test x$reverse = x1; then
> +		patch_reverse kernel/Makefile
>  	fi
>  	;;
>  esac
> @@ -381,13 +423,15 @@ esac
>  # Create local directories then symlink to the source files from
>  # there, so that we don't pollute the Xenomai source tree with
>  # compilation files.
> +#
> +# Keep link dirs (4th parameter) descending, otherwise --reverse
> +# is not able to cleanup these directories!
>  
>  patch_kernelversion_specific="n"
>  patch_architecture_specific="y"
>  patch_link r m kernel/cobalt/arch/$linux_arch arch/$linux_arch/xenomai
>  patch_link n n kernel/cobalt/include/dovetail arch/$linux_arch/include/dovetail
>  patch_architecture_specific="n"
> -patch_link n m kernel/cobalt kernel/xenomai
>  patch_link n cobalt-core.h kernel/cobalt/trace include/trace/events
>  patch_link n cobalt-rtdm.h kernel/cobalt/trace include/trace/events
>  patch_link n cobalt-posix.h kernel/cobalt/trace include/trace/events
> @@ -395,14 +439,15 @@ patch_link r n kernel/cobalt/include/asm-generic/xenomai include/asm-generic/xen
>  patch_link n m kernel/cobalt/posix kernel/xenomai/posix
>  patch_link n m kernel/cobalt/rtdm kernel/xenomai/rtdm
>  patch_link n m kernel/cobalt/dovetail kernel/xenomai/pipeline
> +patch_link n m kernel/cobalt kernel/xenomai
>  patch_link r m kernel/drivers drivers/xenomai
>  patch_link n n include/cobalt/kernel include/xenomai/cobalt/kernel
> -patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
>  patch_link r n include/cobalt/kernel/dovetail/pipeline include/xenomai/pipeline
>  patch_link r n include/cobalt/uapi include/xenomai/cobalt/uapi
>  patch_link r n include/rtdm/uapi include/xenomai/rtdm/uapi
> -patch_link n version.h include/xenomai include/xenomai
> +patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
>  patch_link n stdarg.h kernel/cobalt/include/linux include/xenomai/linux
> +patch_link n version.h include/xenomai include/xenomai
>  
>  if test "x$output_patch" != "x"; then
>  	if test x$verbose = x1; then

Thanks, both folded into next.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

