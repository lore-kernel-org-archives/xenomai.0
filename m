Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD01C302E
	for <xenomai@lists.linux.dev>; Mon, 14 Oct 2024 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728947529; cv=fail; b=iREo39yIljVfMYTXS8uU80Y/Th8FsQS3jTqqlD3HWM1NRmyb1MUJZ31zbNhog/m3KA9FdW31dKUWReAgw1HvViAE/WHJNN2f0qkwJ5rFsMYrXmEZ/aWSgntmDcLK5mRB8n2eiKLsi/F5Fp1vUnCZzxuDOEu/m1DLA22pZD8WAYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728947529; c=relaxed/simple;
	bh=97NYEpK6UYF4m9JPhHh4I0u5lTj05fYVgCu6C2YQxIw=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rdmxZzAeWKcsEegpD1KWXycMA29ZP6hu6gjRE7jnNnssdlOEdBRbA/0+OXRevRKsj6XP6QJfFpXG8MosTvWII4Q4v6jt/Th0kouIVm+8+LMApIFC5dH7dMn4M7e+exRjPbPZ0ZhwK46dEDmD1nGRrIW/FwbRxC17lvWUntNdkk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GeWIGBrN; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GeWIGBrN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNVsVW5aRzlWsWoBVFqJb26bfBS+WfRm7L4buFs1MSVI3KsiuI5bQzI6/M6DF/yj4RiRKfLPgN67KPnWZt1wsijtA3snDvy4woaSFHmCzbIEDcjI9wauafUKqLyA3osnDZEIgumPUCiPnK1XtuV9+V8FTfrqwmpdEZ6L7+9wTs+k7YDNN9EcgBrAynBVor0agN/L/n83LcwbvXpX2edKedpOxjP1PrfJ5o5jPI7Di1CEnMkRD08hNEKw90Ip0A/6Yk82uWFQaINWgANglH47UpXmn+ye4xJdFTb9Ep2wpPzqdCaVRb66xf/LpLhtz8P8b1Vol7zKQYyuX6W5KZTJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ga1PD0XQZrYi62Ihhv0J1UdztJGgzLXUtw7YhWlLYo=;
 b=rYQUkVsyZA5AeHBf+9VnEUZbidTji/xdWOn3azRp2l41atkWUgyqToFIKirkMyFEY7OfMyxypKVrIhfYVEi7rWZ1aAk98RoksYmI3shvado3AMFiIyfEONQR/1wnALGedYQSYJHwFZL8Noa9zVrgbbTmNgGV5cRV65M8K7UVFGlAkacfuc1O8dvTAq44xEHOMYyqN575HtoyFlyccboIz52iwRU2BE2mUsGAmSvHkRuHJgSMsRX8/HVQfToMvRb2LbZqurj0ZRIk5Ckdegtxl2e0jvStZyDSDGAOn6gD4VD4B71jrepjI+laQbAjja0lI7rT9NdElzial8MAQvPaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ga1PD0XQZrYi62Ihhv0J1UdztJGgzLXUtw7YhWlLYo=;
 b=GeWIGBrNAWmf1XUFGqdLXi2PcDvIkRgoTQFhvZ0+KtqX+640Uju4l1g1jmcUcWVtgw6xavRn/AKvp4sA/KBMI0RXikb9Y+4e+cDU6xD8D0R7u+m3Ot8aOFgw5X28Mr26c3x0Rz5PFW5gG7vuG7G3wc51QcgTpk2Oqp3NPxATKvOrWyb1JxhNLA48qBTFwUXq4pQcGVAb9KWlXavooFAfxwCdfSdAt4BCHeluonoDI9M1D92dDcbzhEWuCFyK6QVLWDZlNEYY6nrT00bUEBFPN/ZQGKeHyq+uAEeJtXA9pAsXsymh5KIiV+8L+j2yL34um/VUJCj7In+05bgmLeAElw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8413.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Mon, 14 Oct
 2024 23:12:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8069.009; Mon, 14 Oct 2024
 23:12:02 +0000
Message-ID: <b668b5fd-0ca5-4b03-9ff3-53a32eab12cb@siemens.com>
Date: Tue, 15 Oct 2024 01:12:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add f81601 support
From: Jan Kiszka <jan.kiszka@siemens.com>
To: liuyang <liuyang@sinsegye.com.cn>, xenomai@lists.linux.dev
References: <20241014015648.883157-1-liuyang@sinsegye.com.cn>
 <421826f0-0523-4ba0-861b-067a87301278@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <421826f0-0523-4ba0-861b-067a87301278@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6dc8fd-19af-42e0-7fc3-08dceca59c5f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mm5IUW9DTlc1MEJNaTdaUmdQVThzTnV6OFB0cUQvNE9vd3ZQKy9OeEhmcWZi?=
 =?utf-8?B?cUxjYkNzNC8zSVRlNXZFalBNVkg1c0IySXVkeGJWRWNocDVKWHprNDB3blVW?=
 =?utf-8?B?aGVMMXpqRGU3bm4waU5CRWVOaS9LRW55RytvWDlTN2Vob1NJQjlhUDltTU1o?=
 =?utf-8?B?cWVPTzJBcE16QmZVMHQwYlhrbFZzWWlIZ0dkWHlhWHVRLzZQRWcxeE4xOHBw?=
 =?utf-8?B?a2ZmdkY2ZlhrZkord1pjR1dydE1ZU056djVzSEFtS0UvVG8zZUt0cFNab3dS?=
 =?utf-8?B?Z1h6eVlZYUQ3SlBaVlRYR1l0eTE5M1NQZzZBZ2hqQm5XMC9YSks0NXYxNzJK?=
 =?utf-8?B?MUZIVElPc0pGTzUrVGxMaGFoYXA5VkhQM3BJcTE1QzdaMHdtNnNYQ2V5dyto?=
 =?utf-8?B?bmpqemgrODZ4enM3aXFoQWNlcmtwZlZML2FLUEdVbU1MZ0NpVXRzaDd5Slpz?=
 =?utf-8?B?TUJ4OFFSakFhaWo4R3dHYjV1ZHBqSDM4MWUzdDUvQzdUQTJOMGZ0UGJzYUpp?=
 =?utf-8?B?MTE5UnFJaTdBRGNBV3ZaOWRLbHRwNkR4SWhMek0ydGFmN3p4RndISk55Q1dN?=
 =?utf-8?B?cGo0UE1OdjhXa3RCakp5M3dpNUMxWHdzanlZa2syM3I2Y29UMmkrYUdrclhO?=
 =?utf-8?B?aVJNeHJ3Umd4blBIUTdZT0NGNHNXK1NSWTNacDFXZjg1dnBCeTFBMk9FUDZF?=
 =?utf-8?B?NlFsQXpWUGcyNWkyMGVqQ1J2Q0RLWGRjNTdNM2JwQklaamhOY2ErSTRjL3R4?=
 =?utf-8?B?Ulh6elhTOW1tcTdqbnZEeTNSeUNyWUdTcmJyREhZM3cxVCsrb1VFYkpoZ21i?=
 =?utf-8?B?ZXZFcjhWcFFpa0Zaa0dTYUNudDYxc3k1RTd2OWVzSkFBUFgwU1RNa3hkaXlh?=
 =?utf-8?B?amI1cm1iVHBueWlHL2VxYnBFVTBOWVo2ejloK1cwUStHUlp5Y3JZc2xrREow?=
 =?utf-8?B?NXI0WURWL2p6RmxLRlFtc3pXQkc0eE55WFVrT2p5bzVzTDRVNWIxWWthT0Fq?=
 =?utf-8?B?NHlnZVF3SUF2TmFxQ3I3Vk9vNlJMWmJ2OHZab3Era2VqNmJLeHJMak5BVGRw?=
 =?utf-8?B?NFB3S2VjTFIrTFBnTTlLZG16OGhxcElvT3NYV3JlNkNIVDVLbHlTcDVaVVdw?=
 =?utf-8?B?c1FPbTZNWEM3L2QybnJ4N2Ywb2ZZYVRNb0JzREVuZTNrdWFMRE9Bd1lCdHlR?=
 =?utf-8?B?a2haNW52VUFnYnpPazZONS9SdU5kWEt3NDdybjQvTkVqZmdpRjdmYVd5ZUt4?=
 =?utf-8?B?UkdKUVdwSUxjaDNybW9OcEpKdUJ1dE1ZcHJvaDc0NHFTSENtVTJxOTcwTi93?=
 =?utf-8?B?NVhFdUlFak4zTXJUNG9Wc1RMQ3luaThkRkFMNGJuNkZUWGNOdTRnemh6bGV5?=
 =?utf-8?B?YlB0N1JxOG5LcGRBSnRMYlpiTGlwd3laNDZzK0ZtUnhPVHZCSFNPSSsxRlgy?=
 =?utf-8?B?eUtZeTI5N0V2cHQ0KzRVMlpXa2lRQjMzSkVKMm9kVXdZdDhEcjdHRzFJMU5I?=
 =?utf-8?B?R0JOS2IyaG1YUEFGWnhNYldrdmNWWG1TbFQxT3M1ZllYdlB5K05qcWFkbFNR?=
 =?utf-8?B?cVRrMUplN1o2QklaREVHZldUV3JLaWZDU1NVY01TN3ZGcEdRSzUxWEZPTE5j?=
 =?utf-8?B?aUtxbWU3L0cyY3N0dERLOEExUndnMWxZMHo5cVNoUklZRVN1UGlpSURJVTM1?=
 =?utf-8?B?Z0JzNVhkOUFJcG1xM2x4ZmxVelBFSFVlTlhRd0lTdDFWOFpGMnUxMnFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEgxSml4cTlnQTZ2c1pjeWZzYTVteThoNWY5YTBIeWlabU9HOGthdVl4RjRr?=
 =?utf-8?B?YlpuLzZtTndsR2Z3aWtnZGpjVWxHdllZL1NxVzcvaFlja0JQclB5b2hiaUpM?=
 =?utf-8?B?N0s2eDQ1cndoekVlVWxzVGxNdTFmUDJLT0dkU05Oa0dXUTQyeVFmL095bWhK?=
 =?utf-8?B?eW92L2NURU1yTGw1ZUZGU0UzUFQ2RUwwOWh2MmwrK3V3ek9IWVFmZUFhN0dh?=
 =?utf-8?B?TVdwaFZtL3hzVUlnMHUram1NWDVpQWZaTnc2K29ySTVHMXFXM2VGZ2FWNG9u?=
 =?utf-8?B?eUExRXFhMXpubi9EYUxyUDR6aHkwV25FeHRtUTBGQ2dSMkNBRzBLTXZZZmxL?=
 =?utf-8?B?QmdON3h5WW55RDgwTUR4eFJ5RHlIbkpwT0tmK1ZZRGl4ZjlabXRESkRwVHhS?=
 =?utf-8?B?U0pDbjd3Q0oyUDNuZ0RQSnE0b2JJcEd3alRUbUNtSHo5c3pFMDZjNHlkREJv?=
 =?utf-8?B?UkQ1K2w1ZzdFMDhlRGVTM1hBN01FYUgzWlNiS1NkeFNCVnJzUFZUeHJJTFNm?=
 =?utf-8?B?V1llY2ZmUVIxRTdHN3lVOEtCRmpvdDd3Ymo5UnBtRlFUbnJvRkp2aS96SXls?=
 =?utf-8?B?WVg4MWVidG0rRmtSalo3dndyd3lYWVR1WmttTEd5UzQ1QkFiY0pjRzRyMFhT?=
 =?utf-8?B?STlJNFY0LzZQRGZ0SWRoTjU2RXlMcFNHZjBPKzVFOGkwZkRxYlk1Y2c4Mm5I?=
 =?utf-8?B?djJpcGg2azhaUEdsa1JJc2FtdFJYYmRBTk1PdmJheGJxRlpWWTd1UVNsTWpB?=
 =?utf-8?B?Rm9uK0oxbHRkTVZqR1cwbDE1YUNZc1hQMm5IcTNtMkFsQk4xMkdLZmtoOVhv?=
 =?utf-8?B?ZVRJbzJBN1oyT3EvVDYxQ2dMdUdQT2hjQ01GYVR6ZkMra3U3ZGNpOTVTRnN0?=
 =?utf-8?B?bnU1bmxGTEk0dU45QmpNRXpINmdNYnU5QmYyb1ZEZ29BZjh1UEVqcGRCZWN6?=
 =?utf-8?B?ZTJPWERiUFpSZHJFL2pHWUJMbEY5ei9rTzVPc2lWNHh1KzQrNi8zTCtUNmcw?=
 =?utf-8?B?bS8rMkhma1BiRytXclRYdjkrYnBpRy9EZUFJdXRUVzB0ZlVmV05XMXl3c0NF?=
 =?utf-8?B?NGZaQ1k0cnhLRFJLTkVXR2RXMDNzeUxoREpyWmNhdGZNYm1OaWtqbGJ2YlVm?=
 =?utf-8?B?d0M2OU92bmxIZkYyQ0NCOW5zeGczTGUzYmpHRDRlcXoyM3lZTGhnLzJUSDMr?=
 =?utf-8?B?b1krd3pWQkhJQ0pYc05udTVxMWdpZmd6WDljbzk3Z3V3RnEzMzNsZHh2Mmpr?=
 =?utf-8?B?STZpS0hJZGJiTGVsNUpYbTByREsyR1N0Yk9CMndXVExCMTFVdkx4YTJrQW1D?=
 =?utf-8?B?Z25qWlJWWDhaUzNQWmV1bUIycWdibzdpMTI1Y2MvNmI4V2dMNDFCai9SVkNT?=
 =?utf-8?B?TVVJYnJUR09Fdm9TMTRaZ29JdWNiUzM5QVhuazdZZzF2M1dEY3pRMndhcG1u?=
 =?utf-8?B?SlVLZ1ZlM0tXalJOUlgyTkVsVzdNdmdtMDNXMUExSXFjcnlRa2hkN0c0ZS85?=
 =?utf-8?B?ck9Vbno5REUrbm5HT0J6RzBraFlOZ3hiSUVua1N0Zm1kQ2kvaTJDUnRDSm9L?=
 =?utf-8?B?eUtCcTlsQkRYT3F3emRVVjQ4dWNLYVFvTXRJdVg3cHB2WE1vV3VYZDExUlFD?=
 =?utf-8?B?VmY3eWZEWE01NE9uVUUyQ3dJdmV2RENVWWlDVHo2ZzFOTk9tdjZqaFNVZTJy?=
 =?utf-8?B?NUxiYngrQ2ZEY01PZlYvY0Fud1g1RXNURTJ3WEtaTGtzMVZKcC82N2t2c0Rv?=
 =?utf-8?B?dWVWdG83UXRsVXUrV1hubVVMRUtWd3l4U3ptOHhpSjcwZFRueC9jMkYyNjI1?=
 =?utf-8?B?dTFtWXlSbU9CV2oxdk9ydmMxMTY1NnJmcEN3Znh0WjArek9tT2J3YitIVnlW?=
 =?utf-8?B?T0xSeE8ra0JqVERoVGhTZGtyR09xRVhtcW95MUp4YkhiSzFzcjI1djZOdExu?=
 =?utf-8?B?Uy9RWk5NUzM1YTZXazV3Si9zdXNZeExRMmhhVWlZU1hpWUxjWVF3SXc4Y0lD?=
 =?utf-8?B?a3lmTmw0SE1PVkh2UUk1cEdPTFVRMDlpblJtUG1uRDZ0Q1owRjRsS1pNWHFK?=
 =?utf-8?B?M2gzc05sTk1IV0w1Q2dHVk5Eem1lZTNYL3lRalN1UTducW5EWGtpLzZYdzJI?=
 =?utf-8?Q?K28zG1T74kXEvqWoNAUmlzaPt?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6dc8fd-19af-42e0-7fc3-08dceca59c5f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 23:12:02.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pvvFUUFoz8NhIAZQgND5F76qgU9TAtdZ1DNypaQ8jxkSVMkqYB+6IGWCFTD9UjXjJXnINCZQTCG2+vtGaxB+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8413

On 15.10.24 01:02, Jan Kiszka wrote:
> Some sentense(s) about the hardware that this driver targets would be
> good here.
> 
> And the subject should carry some tags, e.g.
> "drivers: can: sja1000: add f81601 support"
> 

Oh, and please version your patch in the next round ("[PATCH v3] ...").

Jan

-- 
Siemens AG, Technology
Linux Expert Center
