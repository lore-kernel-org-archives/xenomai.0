Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AFD132492
	for <xenomai@lists.linux.dev>; Mon, 17 Jun 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636489; cv=fail; b=Hxozniexo4NEUcrOom1/qbRHQGmoJAfCGE9E5PGWxOkyEyGP1n+yAK4OvLVJsHRTRqPbF63pyFumHp+R66VwlhNjmzy8zbqCzXVOogSpupM6/3eQsDgeoINtDq/rVsCe24Kdokjp3a12KATqCY2M7f2lsQlBvavH70iIdt93G4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636489; c=relaxed/simple;
	bh=mOAB6ED6DgSzTzCTCG1OeKSmM+Aum5g86ixKtjNp8O8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l4qidvHaZmlFYzLfM/jn3oT6R6931gVWYMmYZuyJJSzgL+KLxuRkR6B3Acfhd26QXGNiQw518x9XipUSMiHV2wBTvp+Ion3iT1UrkNAD6BepXgg38n720jl32AQ68szpwlEoYTELLe+K38Gs6K5iLIeC7tTHSieeZN91DI7TglY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=qbD9sOL3; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="qbD9sOL3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVaq1bVPqkmS8kjZjCgiEW1H25OjvD1I3KxHYyQ6IyAESZfm0UCT6YyKHEJ3BGtb8Mfr68Shj/NkpLd7nhgCTTs3zbnP0xpCa4K1x6RKJ4xWR4ATIINxWOB+4TFGp6mt04mWsMqTXK6SwC5ir1BmX5FzfnwgfM5umBe1zcUC2J7ipSqASyKYfE1Z0oRhbFvVzAVJ2epmLFn/1em640mc9srrDN2f/3NVNBpGM7mCK5qluYqEfuSm/3fNTywEx+QJdolLt/7/5DP/NADF1Kw+NNbvkIfMFbW1+d/8v3udwKDg4FmMtW4a5cJcxmXnaNAZyvH9MyRxxbC/jg8n4FlNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz4l01OG7oVFL4bF38i0iLBRHm/gT0ry55Ks4alXBgw=;
 b=XilxKVVEMaevt5KUPG8SQod0JE2osP5+pVXINaJuv3eZsaO7haEP8mvCUksxUScal7HwD6lEKVOuPCXPhg8PSkBqAF0ClfV00NpQX8fgWiC/OUyGiARTrU+zFKuxMRIUQJnXuaWDUjVn066w7SPG6diJTQblBPsp5giJ6XS+OufNzQ17g+/NYK23eLgBOwXh2H98hXGxXuuKhrdGA/63RA8WNRbORTlEI2ahMnOYMH8Z0kog41JCknklGjri+ZaX0Tq7hepaw1dyeQWF4/rzpX2LRUegFyPKinmPRqouB1FwlEb5qfD4iMcebYwFx+42G2T+DFqdzohJxcMsArV5WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz4l01OG7oVFL4bF38i0iLBRHm/gT0ry55Ks4alXBgw=;
 b=qbD9sOL3okotCty7BCKEaSCLTXlZW4NnNkNCjY5DmwiaWYOtUxbYmMwU9pcaKpd90VfYBMxZqq4MvFu+7AG7NWOrwf2Y/aZRMUNVrKvWlj7OruUA0Wn4I9uI5Iu1A2iM11Wj/Err1fbgM0/ipe8NqXZKAywhTcctoyiLMt9KVK+8i/SiFb8wiH+bdV1LrnzGOR/g894XcSJshi49P+crYKkojSvxUBWyz1hZQs3bTtaZl3AhE0anM2b1gn5cN/Lcns7HFX/WEWXPA7jqJuhsBHYX02iQ2Q1t49/8unY+w8oL+MliOoPVQBZ3VgeXef41wsqh/moYQkp0NiG7lkVgyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7446.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Mon, 17 Jun
 2024 15:01:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 15:01:22 +0000
Message-ID: <961bf35c-2284-4b02-9ee2-0e17cd94d8b6@siemens.com>
Date: Mon, 17 Jun 2024 17:01:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpi4: fix arm64_defconfig CONFIG_BCMGENET
To: Yi Jiang <yi.jiang@siemens.com>, xenomai@lists.linux.dev
References: <20240617145555.29385-1-yi.jiang@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240617145555.29385-1-yi.jiang@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b6d6b6-7e1a-4964-c4f0-08dc8ede59ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnVVK3loenNXNTQxTXREZHR5dWhLOEpGTm0wR21mbDE2REI4VkcvWXlOOUUy?=
 =?utf-8?B?akxaMncwcW5BNitqVTIvbHpTQnFWTHk0NWdBdDVEVkFlb2kwRzMxTmN6MlFJ?=
 =?utf-8?B?N2U0Si9RcFFkMVNuWkx2dktoblRsMzBDdHFSVVhwRzVTYVcyVVZtMDhsRDRq?=
 =?utf-8?B?YUtId011VFhGMnAwaUJvbFhsd1MzL0pvMDAvY25DaTgwYlZaNnJ1RHdiaklP?=
 =?utf-8?B?RDhWQ3FBd09OY1JuZndNT3Q2V2hkelR5UHFSMlVaRjczRmMyeTEzb0lFbEky?=
 =?utf-8?B?Q3Q2OGxNd05nZkI0c2NlTFpwSUZxQnZ4T3BuSWp6d2FHb2dhZG9wM1FHM0tR?=
 =?utf-8?B?VXFicnlCdWpRMXRYVFVPTnhncDRvMHpEWUR0bS9xKzlMVEk2bHVFNzlmOXlm?=
 =?utf-8?B?d2tKb0lpOVZRZlBua043VTJ3L2tRNnhHdENmQ3hCV3JDZmtGOVBodWN1V3dF?=
 =?utf-8?B?NjY1OXhQekdCeTFIdHdVanIxZmJ0ODhQRithemNEaHI3OE1aUHRMalZCUjJk?=
 =?utf-8?B?L2NtM3VIM3h4YlR0N1VteUVXRVR5LzFUdlVsaXM0Q3REWWI4eGZwdFNVaEpT?=
 =?utf-8?B?bnQ2MkdpQ2htcW1neXdtcGpFVnc3bXZ4bWFVd2Z2aEVyNkZtdC82QjZqZVMr?=
 =?utf-8?B?a3lFNktKWUd2bDkvbklBai9XNGxqMElYZE94MC9IanovZzYvUWpINXRCYW00?=
 =?utf-8?B?ZFhaNi93WXB3OXJzTHRaaU9XUmU0M20wOXhMVklaYTBvRTJNcEoyQXl0YnBH?=
 =?utf-8?B?WG1XYVdUVUhBNmk1YWdUOTBMNTVPR0lZWmFJVXJRdUVPNU4wUzhzd2ZaaURQ?=
 =?utf-8?B?eGN6ZC9ZTEMyU05FbE54R252YzVGbTJkRU1oaTM1YWNQZWVkbkMvSEVlNk1q?=
 =?utf-8?B?STdZa0RyYWYxOXI5YW84SEQ1MFFZN2NQNnVkb0pMM1YyZCt6U1RRU1N3bVFV?=
 =?utf-8?B?azQzRE4rUmdLaWg1a3pMVmRjRlkyMnpRaEQ3ejRnOGszc1d5ZUJ0bTBySklQ?=
 =?utf-8?B?ckhwT1lsaTBQSXNzKy9seUx4eVFWanRMclpyOG1BY1RtTlNXSHJCbUliOFI3?=
 =?utf-8?B?YVRvbGU1NWFFUDlGSzEwY09TS2RCVGJ4WStJRnA5V3FidU1ydXdwbFUyTUx3?=
 =?utf-8?B?TzhGWnJGT1RIZXZNQ0w1RGRiTDMrendlYzkrQm52OTFPWG1QV1IvQW5USkhH?=
 =?utf-8?B?bFFBa1ZkcEg0OTM1S2F1d05JQ0NlZHRxUHh4VGR0aFplaElxVFBhRjBtekVa?=
 =?utf-8?B?VVcrcTVTa3d1eml0NVRWc3hzaFNjeVhRcVFxcEZJM3NMdXZSUE52Lzk5WldI?=
 =?utf-8?B?bVhMVitmRm8xbVFtazR5aEhUeXNjNGtqajdsbzBwZ012anNLaFZMWWR4Yy9H?=
 =?utf-8?B?czVkUkpjcTBMUlZ3NnV0Q2FFakRuSnlDbTk2eUJYL3FFazBJenh0cTRtVUk2?=
 =?utf-8?B?Y2R1VGROZGJYVnYvdjMvQUdubStndCtjaTl2aUx1NHljVFlzSWo3ZUpJbTJi?=
 =?utf-8?B?Q3RDTVZFRlF1Q3BhVnhoNDR4N1hneDFVNkVuZHpGMjZEdmZVNUlJSVhMTnMx?=
 =?utf-8?B?YlpTcmtEWlNwL0dOOVZvc3hWSjBneDNXZ1YxN2ZLaFhtN0dxZ1A3NjY1emlC?=
 =?utf-8?B?WVRWaHhHeENwZ0t6RS84Yzg3Skp2MVRxa3BJYzRyM1gwU2N3Z2tWUkNSRXlJ?=
 =?utf-8?B?Z3pNMUV6d2FmWEM3eVNUR0s4VnFSNTMwM09waXdmVmpCdHR5RFBSbWdLMmJQ?=
 =?utf-8?Q?VEygif79qBPkYuGdk3a9O4gbrzV7lseCPGtMSjO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGJxWXBZK2J0WExXZDIrTVJDR1MvWVcrNzFadG1TeWM5Zjd5SlBOc2lXWGlX?=
 =?utf-8?B?K3dUc2gySWNnNVlkSVRUUGpTZHpxVW5XaFBuUGFQRkw3OHFwUm5nN3BGakxC?=
 =?utf-8?B?VnRsUDV2WXFSSmlEUXc3YkVmcnZrT0hiNTVyaHYrV0FIcXdaOFBpYTJmbUZ0?=
 =?utf-8?B?UzdZZVl2Y2VMalhUT1BmTUtRVStRUlVaWWFzZlZURlQyNHlXSEMxbFFkcTdM?=
 =?utf-8?B?QmlPU1JvSGNMRkpPN0FJM0x2VWVTUHNJSGxNV0JGTWJpMTN3b1ZLMGR2NnE4?=
 =?utf-8?B?ZHZqckpqbUVOVE1laDgwYi9sbTN1NS9Qekcycm4zYkVHSXdPRWx4ckxqSzNt?=
 =?utf-8?B?NlJVSnVPT1FZSGRxWkFubVZOQTd2eFNBLzl0MnY3QkVFWGtqaTVYL0VGeVFO?=
 =?utf-8?B?VGFVR0pweE1XRTN2WWFlYlZ5ZFl5Mk1YdVFDWUcvUG5GbDk5RXVxei9nWEow?=
 =?utf-8?B?WG1pY0FrZXRLMEV0V0NTSGd3UlBFYWhHenlXWWRPWHhIWFhnWlJ5UlIrb1Ur?=
 =?utf-8?B?SWdYWXdBRmZxeVYvR2lEVWtoYlBabHJLQTRTWGl5T3A5dEx2c0pCYzBnenRM?=
 =?utf-8?B?WWZhYnNMOURTdEdkK3VxL1d2c3FQUUYxWU83YUlqS1lXSFhTQ3o1K2hLWDk1?=
 =?utf-8?B?UFJYT0g3YSt3bm0vSFZidngvL21FWExpV0dHN1NUOTJOUm0wOHl2R3JqeFky?=
 =?utf-8?B?WU5NRUJ3NEd6c3RoaWZOQnRLVVpMN2Z5WUxvU1V0am13VlhTV1JvWFovVHEz?=
 =?utf-8?B?ZE1yMTd1U0lCM0Yxd0lQZStBb1BOZkVwbE5pemFjOVl1RGc1cmxpQ0VCNnRo?=
 =?utf-8?B?cVBnSjhhdkIrZzNrWnFKYjFURTVHWE9SUHBGUWV4b295dmdvaHlpUGo5bThS?=
 =?utf-8?B?MTJMY2JHVmkzNW01RHRocElZbll3d084TGorQ2Z2UU5ubW80OTVKeWN6dlM3?=
 =?utf-8?B?a2JYTGdZNTE2cEZZNVljY2lkMm94YU9FVnNpbXNxQS9SZmZkT1BSSjkvT3J4?=
 =?utf-8?B?Tk92M2pVNEVBWEJhZG1xQWRKbElXaU5uUFJ2dVRwVVRib29uckg4ME8ySVpk?=
 =?utf-8?B?UFVHaHE5UHE3S1pPMU40QWhKaUJ5WHpjb0lMVVFzaWtPZWhjWEQ0OEovYmQx?=
 =?utf-8?B?Y3pIU0QzU2sxeFlFUlQvRVJRaGV1TlVxSWIzN2h4ZkIvVXZGK0NFeDZEL3E3?=
 =?utf-8?B?cG51NWdkYWVBQUJ4NzJsSHhyQ3Uzd2p6ZWwvc0hrWkZqUlp0b3UzTG16bUYr?=
 =?utf-8?B?ZTZGcDgzSXhjTm1HUHZDOVRNaUJmOG1aTkVjendjd3FlSUtzUXpRMjVpemZG?=
 =?utf-8?B?VHVZNFdWVVVFdW9yRkxacUt6Y29MMkkveEowZ24rSlVFVis5d1l4ZDVzYjc5?=
 =?utf-8?B?cDJnWlpoK3A3em5SRzRPdmw2K09WbnBqbFdzQ3ZJSkRqc3VKWmtXbTJESzJN?=
 =?utf-8?B?TXI3Y1pHSzZpS3VvUnVxOFFGLy9Faml6VnViVGJvOGZPREFRWWkrRExkYzZz?=
 =?utf-8?B?T2dwaDQ5cGdJZ3JDSXRHNnJBVVZObEpBMWpQYnhINmx5QTFuN3Q3bXVqZjU2?=
 =?utf-8?B?eUNPbUJsSmt6S0lTcUFmbU9YYW10STliSUk5azlVTGVPcUQxL2lza0t2V3JX?=
 =?utf-8?B?dU83SXlhMGlQSSsvampTZWJxT04zVWw2WW4rcHBjeGwvT21aR1UxYlJOS2Fa?=
 =?utf-8?B?aU1iZmxtVjlEUDl1NUFwci85bkxHaERodlZ2MlEzUEx1WU5CSTV0c0pZbEhs?=
 =?utf-8?B?RlFMRXhjc0pyeURiNWhKcWVaRHlvMU5JYWFzTDUrUm14dStRVWhxNTRucUcy?=
 =?utf-8?B?blFNUmVYbUhYVm9xcFJqa1RYbTRUTjd0MHJGWWRzKzhGZlhINTBnS1hjT1pW?=
 =?utf-8?B?ajIvSU1IOHFUSzMrUWNYLzJMalIxNW00Z3JIWk5SODE3VDRuOWZHZ0tPU0JJ?=
 =?utf-8?B?c01INGFSWElsaEJnU2Q4QXQ0RXBzOEN2VktRUzViaGZmYWp2c0FhNG1TN0VL?=
 =?utf-8?B?UG1lQUZYV3djMExmZmJTei93eGRDd0Z0aTFwRVBOUlZ5aUhPamgrOU9OYnY1?=
 =?utf-8?B?WU5hUWRqQS83TENyQ01IbXBtYXFTRlVMU2RIWjZPd1d2UzBoRGc0TzFyQXJL?=
 =?utf-8?B?RVhwVkYzWTVuZ3BnWXc3R0hKdmdiT25tUE1EYlVidDQ1SVJQUEhKNHprVm80?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b6d6b6-7e1a-4964-c4f0-08dc8ede59ab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:01:22.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ls2VqdFLCXUNaKXV74Y93Va4PZlOWiISisIJR+N34xSsLVi1CeANskD6ix10zvWzpwugwFB1gqht89FUQdRNRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7446

On 17.06.24 16:55, Yi Jiang wrote:
> ---
>  recipes-kernel/linux/files/arm64_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kernel/linux/files/arm64_defconfig
> index 94f7b5b..1dc8b69 100644
> --- a/recipes-kernel/linux/files/arm64_defconfig
> +++ b/recipes-kernel/linux/files/arm64_defconfig
> @@ -1951,7 +1951,7 @@ CONFIG_MACB_USE_HWSTAMP=y
>  # CONFIG_MACB_PCI is not set
>  CONFIG_NET_VENDOR_BROADCOM=y
>  # CONFIG_B44 is not set
> - CONFIG_BCMGENET=y
> +CONFIG_BCMGENET=y
>  # CONFIG_BNX2 is not set
>  # CONFIG_CNIC is not set
>  # CONFIG_TIGON3 is not set

This patch lacks a commit message explaining briefly the reason for the
change and your signed-off.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

