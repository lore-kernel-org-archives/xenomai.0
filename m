Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B52217D377
	for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724323906; cv=fail; b=EZqvz9ZaRgai+Vnel8NJj+EqecyLygl5jCb4AKWL2UZWibUiZCE31A0SmT0cdwgiErFPiBhd1h/IqjheV3i6uviYrg6SngsXVrUzE/brxd3NM9sdgMlsLp2N4fazdGCSJw2r/enQdhljPM+My8qxZbKjmWJ0ew8oOqNVgemyv5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724323906; c=relaxed/simple;
	bh=YBlnV5PZ4QXZUIXpO+WowuFeQ9ZakUnaq2BuN4Ow/1o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FrG1uGA6AzMZhuQGynTC80Y0QxrDCifJafVWlHRrlLqT/x6Y2vMRFlrVqo7jaG1nGfgbcPJ6FSL5AEFA2ODLfJ8LPkpQJPXH+MPFAV14/eSuDdHUpfu0xmQocH34FFGMzvv6RMGr2p69+h8o9uvkfqZJ0geJfVXgSUiQriyNvoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=C0R9Mioj; arc=fail smtp.client-ip=40.107.247.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="C0R9Mioj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A55ZvbOB4MC0tPePG7F/CpuYAFZO66ZuWnzR88lC9hADE9WigurTZFdoIeuC4vtSKWoL/rMEXhZdolM7GCNvIFYwiFomUfiwXVaaSZLE7yspCVlywsaCIkj0udUl7TFN3cqZfQu0XZ/qjhQ7PiMLBhBAKSzNklcrz1AssOTyo7s51ELdhVBJNyeq1dC4swTB7jjiu/GAXZZVAt6aExWLhlaXeI5GPKIXgQW2A+dvM4Yma1YDaBBUM9mwbjT2aJsmAxc1xuUZMVFMgDlpp66vUbYxBu7OrdDKSN2R51Xhji8TzYZXirfOkxbpLUwadH0ECa6xWT7bmtc7Zsvr+Ku2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVuFCC/gbPij65hWlp9t7bf/nmbyu0h1pFTRlWQhY4U=;
 b=ZmtU8ZxmTWnVTLmRx9NlcPjvB1Bov5N2uJdqzk6XUaSnCEmmjWePZZOh19OGTnbZEfirGGGPPxZbMHK0mVkIvczEcpCU2+kxR2C2chN3sVZ68Uh5qnzKLXEAjVQlSwUo72o8fRkEYYnM7QnDzDHQ5dBzvrDQoviIqXpyUNriQPgQCuDM51TvlPRwjDo2GeOSglqOjTAjUE3rrPm1YaNKt1Iqutdahlj4hpu/X1XaieJA4eZKTaQPbuIluSLCSRzdRtIMwpiFcLHeXW+NZBZBrp4wXaLQaIqei8tHh2efjCe8T6hyz18rbF/PelnB/ZJ04dAA5DnHoMrHs0AsC/+s7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVuFCC/gbPij65hWlp9t7bf/nmbyu0h1pFTRlWQhY4U=;
 b=C0R9MiojgqALqDG6iKNfgEE7Dbd2GJCAzMF/kxM2WKMoXBZ5U3cujvBpLlflwl3wy2hiP15HPWxbWD1XvQ3E5UOolBWYPelsi7nSC8h+YeaEynyet7TXcvfNckNwKFSgvwYCP8kouPjpVLgqITtIV8AEjnMm94qypv72gjEVeX1OO/D7rscHBUMQ/tRpFvXLmFT/v0Gm5cSd+LtAxdw0V7gM430VBFg7L6cL+nhkDI87lFcK5wjMtzN2F1cqTkPzv54rMrtvdV7gIzuITOUJn5EqKx+KUuqlHTvEU9IIIqG/GZ03vep9odHiAOfijJRCEkS4Pui5anaQLsOOtIkIwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAVPR10MB7403.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 22 Aug
 2024 10:51:39 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 10:51:39 +0000
Message-ID: <4b024ebb-7d6f-4382-8427-f16024d2b387@siemens.com>
Date: Thu, 22 Aug 2024 12:51:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] lib/copperplate: Get session name from env var
To: Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240822080737.17939-1-simon.graber@sigma-star.at>
 <20240822080737.17939-2-simon.graber@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240822080737.17939-2-simon.graber@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:610:119::13) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAVPR10MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: a84dcbd7-d7f3-4c4f-6be7-08dcc29866ac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnlaNzc2aThFQzc3QkdvVTJ5YjRVMW5hcXpIVVB4QVI3N3YxT3lEUXZtSVdj?=
 =?utf-8?B?RHljalNqUTVPSG1QY2pLb01VSTVKNi9zcWxockNFZnlpY1Y2VERXS1dhb0F2?=
 =?utf-8?B?ak5tN0RpQ1MwVU9qaTQvWVJwOXp6eTFGaXBHMmJpS2hnaE9abmVaamxZWVBV?=
 =?utf-8?B?dFB3VnZtczhueGlqbmI1YysrK1BUWHRZS2tuMDJjSUNsS0IzZU83b3JVSFZ1?=
 =?utf-8?B?WUV2ZE1xYWY2bi9WMkFBbVNac1M0eU9sL0lyd1BHUTZmaW5RSC9Zd2VyWGNN?=
 =?utf-8?B?bHM2WXg5bDBQa0VOenVkZVZhRk9qUHhJUkhmbk5uZVhzUzEzR3NLejFuR2pm?=
 =?utf-8?B?WTNIS05KL2xtdlNUTmlmaVhDZCt5cjVlNWwzdVR6aHB3VUVlNVp5eDU3aEwr?=
 =?utf-8?B?U3hvbHF1Y0xlVHJNTnNOa0RjcFdjMTJxcVd3RUZyYzlSaUg2WkFHWVhVdFUz?=
 =?utf-8?B?bW1UbUtQWDZyQzUraG1pNnFSSEJiZldHVUljcFVMM0U3NkxsVGhjSTB0cGJB?=
 =?utf-8?B?cWhYQVF2MHFUVlREM0NtRE1oUE1lbElWbmtPeDEvRGd0QlI2Q1ZPcC9KbkhO?=
 =?utf-8?B?bkFPOWY0WWNCQ29DYTNNa2ptZ05aVGpnSU13Wk8zNmFZL2p6Sk5NVUlHWEly?=
 =?utf-8?B?K2tMcHR4VlE0UE5ETElsZFczMkpHUmxXYndGV0ExUmhaQVVoTEpBdHpNMXdK?=
 =?utf-8?B?V1IyMUU5MmF4Vk8yMTNHZFJzSEhrVS80MVhTM2Q1aWhWdkEvQ3FHR09tazZV?=
 =?utf-8?B?L2dlbmZiMHZjeGNaNlBrQnlsVHVPSVNnZXNtWlhCT3NCSU9tVzg4RWVnS3Zr?=
 =?utf-8?B?TWdEU2QvNFNaZVlFWjh4ckZzVlVaYkpZWEZiVDFwanZrcnRDa1ZBd2pJTlhK?=
 =?utf-8?B?VmZ0enk5TDRGRENudGZmN2tPa0NwdGJpNUxwRnl2U3o3Y1FEWjJTdHNNVWdO?=
 =?utf-8?B?NzVLemNWMXF3b2RpdERrTjJ4cUlJOFJIS3U1QVNsNDVRUTczUlZNOTBnMjlB?=
 =?utf-8?B?MHBRZGpqTjhRUUFadmtldVAwTmk5SnlaOWVxK0VqQ1VRUUx1bGNyV3VjZUF4?=
 =?utf-8?B?YmlGTm9qbU1EWVEyQzgrd2E3ZUN5ak01Z3ViRm4vQ0QvVVVjMFcwYmRYZmVv?=
 =?utf-8?B?Zko2TWt5RjlTTmJyWm53QVNZc1dVLzNCb1IxREVoenRZV1kvUEZ4UDFydU1i?=
 =?utf-8?B?dzd3eVVtbWlOSVAvT1ZoQmY3bi9kNVNTUTBhUHdRTWFTVDJ4emhIcUd2Ky9P?=
 =?utf-8?B?a21FT2pBb05JMDg1aVBLbFdPR2hHR3lyRVltSnJuWnhsemtIS3FZU0t3TlA5?=
 =?utf-8?B?OHJiRmw5SUI4bmlXNXpISnppa05vK2J1blRDdFM1Nkl5SHNYaUFISGlCYlNm?=
 =?utf-8?B?ZkVCc0x5RHV6TlQ0VXZ6Q2xZOVJEUDNDVjNCVEVNYlc1bTU2eklIYTkwNHB6?=
 =?utf-8?B?ZGN2TU13d1RoZnUvcjNvU3dEdXJVZEVjYkkwTWMxeFNRWVp3NFRTcHNCMmEr?=
 =?utf-8?B?QXN3alJ2eW9EVE9uOEgrM3BOVU4rckh6NWVibTdYOEwwWmJrdkhiaSs1Yncy?=
 =?utf-8?B?SUc2K05ERWRTdHRrbzc4anBxYk9MM01yZVg0R1VpcDRhWDFPeG8xRjhkWEF0?=
 =?utf-8?B?ajNCOXd1WEhLS01xcDk4YjRySGE1aXpBbnlvZjZqUkNmSUFhNnNPQ0pIMjVL?=
 =?utf-8?B?eXVtQlRxZVJIMnZ5TkVkbjRKR0dCRVRkWTVENDdnc3JtQU9HbWZLbmZ0TnZB?=
 =?utf-8?B?K2hPSXp6Y1JsVHJOanpwc3I1MmUwYjBGdWtCNmVzWndHRDdFWFpaRjdHMWxY?=
 =?utf-8?B?RVVla0ptOGJEa2tYajc0QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3lyYmd1bWNWVnY0cFpEYVN0ckN3bEJneDBsUGJQTFdyY0hhWGFSM1ZJb0cv?=
 =?utf-8?B?UnE2ditoMXlYQjM5L2lsRjBiL3BxeXJaR080UEhFWi9hRytmdVFWVXFrWCtD?=
 =?utf-8?B?ZVp4aEt2UjgvdGtHcklmUHNoWXJwcHcrS1VEYVNGS1NYWVNjdEJmaTQwc2Ur?=
 =?utf-8?B?cld2ZGNFNk4yc29HclBDb295alMzTlg2YU1SeU9TN3ZaOE94aFluN09qWnRy?=
 =?utf-8?B?ZlQ5VlFNcmJOaTBzbVhUdEgyQU5BVEVFTEdpa3huN1NvZ1BESWE0UkZVSGNh?=
 =?utf-8?B?bC8yZ3lVSTNucy9BSU9NNklOcDMwU3Fac0Q4MlRQaDV6K3pjNjZpck9ERFZB?=
 =?utf-8?B?S2c2QytSUEJvZ1c5WEE3UjFseXdtUlAwTjFoemNtTHVJM0ZZWVZDa0NOK2VK?=
 =?utf-8?B?SGpQeVRPNTJGK0hGNEl1OGczaHBLODEvc25rM0FxbFVpcjBvd3ByOTdINXNK?=
 =?utf-8?B?ZVBZZC9TM2xlOWVQRkFmTUpaUStzcGpVZm1MNzYwMDAvbGorK2d2NUlJa01r?=
 =?utf-8?B?WHUyUW5SbUNoQ0tNT0JONmREaFN4dVl6bTEvYTh4TjBJVjhVVkQ2S1VZVktY?=
 =?utf-8?B?eWlFK29EL3ZGUGJyZHZGd3Q3dFJWa0o5bDFsL3BJT2xUM0ZVUk50UHU5NjVO?=
 =?utf-8?B?SE1jTGhsUnA0bVZSN0diS2svM1krT3BTUmpGU1NwRjY0c2xqZVFraDFZMHcz?=
 =?utf-8?B?d012dWFHdFprZjM5R2dkaXpzVTBLamZlYVpQeDFoWmtORzU5bUQ3b1NuYnMy?=
 =?utf-8?B?OXpwQnlEeWYyREdON1VwYXQrMi94d01hMjVhOVcrWDBrZU5EeUtFblhWeGlM?=
 =?utf-8?B?R004UTNZMSs3NFJCRFI1NGh1YnBPRTVMZ0ZleDd0ejlYNDg2SU5JcktoV2Z4?=
 =?utf-8?B?dTFEOGdWRWhENXhzN1UxVWNDK053MEpMZ2JJYXRqOUhaUnpEL0s0bVhqQTFv?=
 =?utf-8?B?Nm0rVnp6Vzd6MVc5aGdqcHVCeFgwU1NiZDZXZXkxekhaQ2tEeUV4a29rZFky?=
 =?utf-8?B?cktxUDNsK1BqVENPckhrQkdISXVEODJmSmw2S3FCa1VBbGJLdk8wTWJ4VjBO?=
 =?utf-8?B?bm1pdmtrZGZGcXpPTHJWSTBsbVBjMVI5bmRKUmtJbExCdHQ5dk1YWTVBMTdY?=
 =?utf-8?B?Mi9jbjdseW52a3U0Y3hvRUh6VEZDa2ZzNENMZU04ZGp2RVAyV0dsejVWZEtU?=
 =?utf-8?B?bk5FQUszM3oxUEp1czdwUGN1VGQ1L0JXak1VenpidWxIZmE3ZGtCamo4N1Rp?=
 =?utf-8?B?ckxsdlROdE1OTFE1dFNlL2Q1NDBpZElaVlFjY3U4eS91Titjb1NHTEFQUVdv?=
 =?utf-8?B?dmJoNXBza0FtU2hrTjZXREsxNDFWajlkcWk1cUttakphZXdqc3NmN0x2YWNt?=
 =?utf-8?B?bDNpNExia0pmT1FhQXdsdTB5TGFkNXdkdlJaYVVUR1dCZjVraC9QSjNMZmdR?=
 =?utf-8?B?ajJwN0Z2eXU2dm5sWGR4ZUExVEZsbys5dDc4aTVUaEFlOVZ1MFBoN3NkdUFJ?=
 =?utf-8?B?UGgzZFlNS3VGWUxoVzNRcit4dEdLUWNLZjd6dFFneHBsZExSeUN4aG83ZFk0?=
 =?utf-8?B?R2xzN1pTMTVacldQdjc2cnBsdUxhS21KSnR5WS93R0cyUExKRDViZDlCZW9y?=
 =?utf-8?B?V21PZnp3K05abjJ5YThiYk15a2swNW9hOTgzWUpLSDR2blUzWnROVWdGcThJ?=
 =?utf-8?B?S0xVY3psWVhrWEQyNUxmQkE3NHdxdXcvM3pXZ2JDUmd2dk1WVVFPWkg3ZnJO?=
 =?utf-8?B?V2UrUVBqMGN2TmpOakF0UEF6Q0dwYm5qb3YxbjRET1YvSW1PK3B2Qmh1VzhW?=
 =?utf-8?B?ZGVuYlFvdzNXZEN3bG9qMmprNTBhVVlpaS8zRDJYditmSGxoMEUzaFFlNlBB?=
 =?utf-8?B?czkzOU4yajhrNDQxVzR3UldGeGlGQnlZcHI2RkxHWk9oRVZDUGpIdGJUZnRM?=
 =?utf-8?B?NzR0NGl1RnhnM21oU2ttNEVJZis0akRHNGZnVWxLT29nK01OZ0d1dS9zQURw?=
 =?utf-8?B?SDQ2VERHZzBuQ1NJNVd3Nlp2Mm5CRUJvOHBPVXJFaGF1RFA4YjRPU0dra1hp?=
 =?utf-8?B?czA3OElwMERVbElqMExmTVQyOGFEL0hLeVJnbGNHYzZLSlorNDBjZjFMSHJL?=
 =?utf-8?B?MGo2QmlsVzZrc0dYS1NIQllPa2JIY2hBK2hPcndOUWNnVlFzQkhzYWpqY0tk?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84dcbd7-d7f3-4c4f-6be7-08dcc29866ac
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 10:51:39.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akFpJvTZk0gvSa9E4wJx+TRBVfD8lxvhigWP+p7dch8m1W9OK66nFDbRiOO5Z/HDhCQYffGeWg8Jv72BHfl6iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7403

On 22.08.24 10:07, Simon Graber wrote:
> At present, for two Xenomai processes to share resources, they must
> be started with identical --session= parameters.
> This is cumbersome for extensive projects involving numerous helper
> processes. This commit allows the specification of the session name
> via a global environment variable, namely XENO_SESSION_NAME.
> The --session= parameter overrules the environment variable.

Hmm, did we discuss priorities already, and did I say that this ordering
would be best? Then I'm no longer that sure, and my feeling is rather
that env should overrule command line. Still looking for other examples,
though.

> 
> Signed-off-by: Simon Graber <simon.graber@sigma-star.at>
> ---
>  lib/copperplate/init.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/copperplate/init.c b/lib/copperplate/init.c
> index 16fc59f..e695c52 100644
> --- a/lib/copperplate/init.c
> +++ b/lib/copperplate/init.c
> @@ -114,19 +114,28 @@ static int get_session_root(int *regflags_r)
>  {
>  	char *sessdir, *session;
>  	struct passwd *pw;
> +	char *sn_env;
>  	int ret;
>  
>  	pw = getpwuid(geteuid());
>  	if (pw == NULL)
>  		return -errno;
>  
> +	sn_env = getenv("XENO_SESSION_NAME");

Why fetching sn_env uncondtionally?

>  	if (__copperplate_setup_data.session_label == NULL) {
> -		ret = asprintf(&session, "anon@%d", __node_id);
> -		if (ret < 0)
> -			return -ENOMEM;
> -		__copperplate_setup_data.session_label = session;
> -		*regflags_r |= REGISTRY_ANON;
> -	} else if (strchr(__copperplate_setup_data.session_label, '/')) {
> +		if (sn_env) {
> +			__copperplate_setup_data.session_label = strdup(sn_env);
> +			if (__copperplate_setup_data.session_label == NULL)
> +				return -ENOMEM;
> +		} else {
> +			ret = asprintf(&session, "anon@%d", __node_id);
> +			if (ret < 0)
> +				return -ENOMEM;
> +			__copperplate_setup_data.session_label = session;
> +			*regflags_r |= REGISTRY_ANON;
> +		}
> +	}
> +	if (strchr(__copperplate_setup_data.session_label, '/')) {
>  		warning("session name may not contain slashes");
>  		return -EINVAL;
>  	}

Jan

-- 
Siemens AG, Technology
Linux Expert Center

