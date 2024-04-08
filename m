Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2139.outbound.protection.outlook.com [40.107.6.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D05B1E0
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593085; cv=fail; b=SXGB5qnMnAN01x0Di9b4D7cCHSz9Q9AXL47Uq3o8c9nDrOplL5BprMF5uBnIkVkz+gAKJWmABgz+o0iz6H5YNV5CXxON2muueHp2r7Xw40mP8J2tIrElXOxY1lhuT/azOnfPmZmykIexSaTcO+2mFUD0Ae2DnX2x1UE44Q0uGJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593085; c=relaxed/simple;
	bh=b6frG4MdXgNeVye1ChTzXte6BMhw0zRXXAGyfi9WPj8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qSUHObgx4qj0+OjzouoGX3VR3O4pJBF9BKFFJ0JvJO9E4UUF/ND1IvyZndJpObPWh8T5sA4Id+Z/+HTBmvfOECVAoKoPnmvRYjji1HUQaAAGJ1AvBFZ4MxwUAyOLutguyvQtkmQPQSL4ehtmrhdj6dRxwvvUkmTmnNglGdvXLWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uAYFAVnW; arc=fail smtp.client-ip=40.107.6.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uAYFAVnW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/bRxdMVzuDs7Sb7kTdJV5bpxRmGfs8WOEWK2v9aojr6re5skCa40AKGWSTSF1H3aXJQtHAVp9JoN8BysBWaUdL9ht9gaG8r60iqddJlZloRJMQZ8YGhoDtbG0OppzPbTZYBqN9PiojGQq3oakSJG5a6hGvbJLCKUwqwjbO7l/DqgLi9dq+9rsLwVUdKD7zC7Zbra2ioaC0oPIEPZRJhpC0sB2CWkqk4KjgTwd2NESjpgncMGoB31JxLOojjLJzzqwy0zPeixyvTdpEM1uNq8lqxh55ayOw8gKEcnOT7IFs0wgLEbvKXTxIXOm4RaJAc7ZlRSj8UTcvyN49bK1hl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0CnGl7FFiHpYXsErb7FpwlefX3JLTDTpmvunt1tNzA=;
 b=NiFg+Llp74dtDhSmLEH+ixQAWV+aQCxEugD1Nbm0GmgmWyLD3q17a6OGg2vg9hou0KomCDBu9FZo6pmNnZCo7mGeXxA9ox1bzw6OIlZaLbTfbZwil7FBsXMmRUF17+jEG7A6u9zCBD6AJLVXa1/XNSkA0QzbMoQ8v6Y+NnkoIi227ZKGXf8LEMGeo/xEAtk5EKm5+wEGjp6cK0K5E8OmFIUTyHOSb28DOjK5qcAbIn9e1XFm9CLh5QpQCrFZ1DJeoY0b3chJ4dBCsy+7lNewZD7IalidZzbFJ6hVPCxxkMpXed9qyPPWIuwvuU3R41jkCXi11Kna5LUwGS/0gm+a1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0CnGl7FFiHpYXsErb7FpwlefX3JLTDTpmvunt1tNzA=;
 b=uAYFAVnWe2+ZedizsiqJ6oy6LYSXX5nSXmaieWlrFAKUpS/rnkHayHGDdb5QYl6IGt213NULTgfUlbUE0zT8XrqkG6PTyZwVvj8EqgcoSfDGIR3XNCHUzmoy9cG29Npt1C9jPuygBJpqX4qMg6RCZBYrGzciTfqrlh9gEYR4p8y7mMYbp4sOSZwoDLGf6ga0LePZ+IkYcBBR9/0Si+FqAwHEzxEpwD31Jwg+rUUs8x7o2ugUHvMpGJbwzeQ5oyoHHzV0ZoPVI5cR7T6zjSrGgttFpwJ1VulT32M7Mxfkj5uzG+fV9EWkq+yKw7hOK0vZL6tTqIAo8C3Slxidp8WUwQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.49; Mon, 8 Apr
 2024 16:17:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 16:17:56 +0000
Message-ID: <383dc8e2-ab48-4422-9ed5-41858aad88e5@siemens.com>
Date: Mon, 8 Apr 2024 18:17:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] prepare-kernel.sh: Fix typo in variable name
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <20240404093040.15605-1-richard@nod.at>
 <20240404093040.15605-2-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240404093040.15605-2-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5881:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bnlGS0tIT7x6L1qko93j72IHpN5r7DU/HV5gsov9nyPXfSgNJBEUGxuQonlnmND5BO5LeePIB/FnA2qUPUvKFXyenSrmz69lzEuKReG+9+BtByZ3hdYAlf4p89fLEhMwMtu/qwSzFz4PXGFeWfngfT5aXpy2kJFQ/qfvT7JI4m+SpWrnP6EZPNbuz3EGEPYfJbr4DPENH9itBvmlQGotbnz8PR9dt/QpaghSUWDajD7a3ZynehT1HayYbvM85000WplSe1tWtinjyjRitUD+immYKpHnpsXtRkn0MbTHQtnP5MKMQD8/86P7/LHLNRyg2OFxnpHpwG35Za8IBVioB2NldZOs/TBj3xtgRe3OFW7OepnHw0edHJ3YWR84fvQxxvXFYWXTYOyvMV/mPWN38ZTBDqFhM3Xdg9hpheXqgDgKctnD4tqaCzVOWeqNuZtu6eJbAO4DjcZfo6qAELIuwJ9KZ2Smc+McVGLQU2IrU1iZ0fziVNGMsqL+6hupbF+tozEJcbdPLLOGEw5a8VphJ869/yX/f0f8pR7XnjYakFi/dX2rAYZbV2hGHMpBt+7v/f+1hDAwaCvTdW8lyPdQr8TKoP5GUcIgmXwyeSp8+7rnMTiuT/qICqlOgymqDEbF4HM0y8UBykpEpzyiw3mvsPzUZamEUoa77uCEXKog7PI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1RmeE43eDE3REJKUi83WnlCSzhoZk1iSWxCVFZ5S0ExRDlkdlh0a3cwL2VV?=
 =?utf-8?B?cmtHM0RNRm5UYTV2bkJyaVpjZ0xSOHF3WnZlbVNNeDZlMzIxYVMvcGF2QWlR?=
 =?utf-8?B?dmdkN0N6RCtsT3FHaVdzd2s4TzJOTkRXRGVZd24wcTY1OFBpUlNJZEZwQ3pD?=
 =?utf-8?B?WG1KeXhtbDhqVndPSDRTNWFwenhMVTIvdER0YXE0T1puUVBialF3OCtvcXhy?=
 =?utf-8?B?NjZZUEJBTGZNRDBzeGZwcWpXZW1ZenZLSUZRS1ZlQkg1ZEtDcGx2WTkwaGVa?=
 =?utf-8?B?UW1DSzJ1cGVaOW11ZURPNUNROVdTSnVDN3BJTTFndUp6eVpiMmJWRHh3U3hq?=
 =?utf-8?B?Q05hUmRzMDZqRUtVR1ZTaEJBNzNFZUVJNmJNRDRHNjlEMnVNQTZKcEYydDVZ?=
 =?utf-8?B?QTVsc0NySEpqa1lvSk8vR1YzbFZBSThjYjNaN2FxbCtxMjIwclMrMnQxTzU0?=
 =?utf-8?B?c2ZObGJ0ZlZYWHUrdHhnRVhWeVJncmRMckYwWnBCeEZzc0FZY2lreE5HaFB0?=
 =?utf-8?B?Q2RseE9lRnpFekQwa0lVYWFYOUtaRDNNTE1HSnNDSDB4dWd0MklFaFlJNlBk?=
 =?utf-8?B?a1FlM2k0RHE0ZDFNekwraUdaWE1FdGlyMjJYOHZQeWZvWHpvTGhDQ3hsRy9s?=
 =?utf-8?B?NzY5OEoyRjdkTHdlakxSb0Q1L1lBazZMRitMS3Y4OEtVc2Q4c0VucFJNdExs?=
 =?utf-8?B?TytNekFaMEJSc3U2Z1M1Rm9BQkVIKy9Tc01NdklCektnVXJ5Z2xaOTlhY0Jx?=
 =?utf-8?B?dFVseU9Gd3dyK1diQytvUWJNalpQb1FzZmxWdXBNaUxUK0FtL0dOTzNKaDdV?=
 =?utf-8?B?dmVDVGxXOFhlWFpkZ3ZMcGhnRFVicEFnbnJRRGl2VG5PY2trVm53QVMwZFZI?=
 =?utf-8?B?ZmpQN3JRREN0YUNOTjREaEltN0NzbTNyN3hzaWtYVStXQUg2UWhQU0lTMlRm?=
 =?utf-8?B?K2NuRXZ1OUdEZU5IS3N2bnFEL09DSmM0QmprM1FHNGEzYkkvd1ZtTEVERWR3?=
 =?utf-8?B?dUYwVjJXQ3l3TCt4czJFM1hxMVExVi9sS3JkeDRNVXMrVlJsV0hKU3NyYXlD?=
 =?utf-8?B?ZDdaZi9ia1RFdnRuTlJoU2t4OFpTdThvTWN3QSt5SjJIZ0FzV2l5MlNibkZp?=
 =?utf-8?B?RlNIZ0lTMG81alhyb25nOHR4MStLR1EwT2IzMzltdkJ6THk1RHlqc3ovZTc4?=
 =?utf-8?B?Q2x1b2tNbGE1SkU3aHhaSnBuZ3BqWXc0eng0MUlKMVhnUjVqeTNvTFVNSUNH?=
 =?utf-8?B?VmdRNHhFSHpkV1hQcklOV25FZ1pYTFdZSTJieGVTaGFLamNJT0NBT1Bud21D?=
 =?utf-8?B?R2p6MTYxbFV4a28rYnBWdENCR0VvYVU1SGQyQjhyWkRJNFRNKzl2eUFRclRR?=
 =?utf-8?B?SWR3aUFzdGlhb1FkRzdnYTdkOFg5QW4yNXFVQmE5YTVDWWRIazFZTVJBU3hB?=
 =?utf-8?B?OWhBVmhha0FkQ0srd0htWTdSUkN1L1pOSjFzMlhTT3F0RlFvdDRTbmluSGtL?=
 =?utf-8?B?QkZPU3gxc3NUMDhFRjdNS0Z0RDlWSlV1Y2dUR0ViVEtUc09MY1ljSDBSNTRO?=
 =?utf-8?B?YmJSZ2UxUGJWNnV0TjFsbUZ2VFltNjMzVkpvZ2lyaTB3cWZGMzQxM0dhRlU1?=
 =?utf-8?B?a1U5ZXRzZ0lCUHpHL29YVGRzbzByRVJkWTdZVmFXNE1YcXpNb202aENVL3Uz?=
 =?utf-8?B?ZHBFaytOaUVDYmpBdi9CelpqNU1Sdk9aMzE3OFVNMVJ6U1FkQTVvSUtOQ1Nk?=
 =?utf-8?B?Q05EVDBtUU9OSDQwOFdWTUxNR1dUeUNSOWRQTkxLMCs5MmdzOTc0N1VKT3A4?=
 =?utf-8?B?b3JvQWVDanhadXlyaXRtRDEwRVozRHlhS2lTb0NCbEQvcHN4VWJmcFpWeWY2?=
 =?utf-8?B?WHkvOGNtYlhCWFZsSE9CdXMxMEg0TlFac0hHYzFjRCtCSjFVTmJFcjBVT2pS?=
 =?utf-8?B?QVYwNGpEUG5EWmJVRlVNSUY4OEtOOEtHWm5aZ2xva09RVlVUOUxaTjBpdjhJ?=
 =?utf-8?B?YlNJUU5CNHI3ZlNERmNybWJkR0F5a1Z4WVQxeWdVelFRN1ZvLytBTHRldzFu?=
 =?utf-8?B?dGEwdXZiK3JlSERXUmZmQUhzTlpBQTBONE5LTkNIdlAzeUxVMkZrOUN0Q0tx?=
 =?utf-8?B?Zlc0djh3Tk9jVG5uYzU4clBXd200T29MMnRzZG80dG1yNVp2MzNhQXM1eThG?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8510e307-0f31-47b4-4a4b-08dc57e77330
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 16:17:56.2194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ix/gI0qmqjEnA4LY0eYsfurVxz26H5dY8GZbrIhjkAD1/QuC8QW+GOrAUEOaOmNc3+Hkc98bZUlWI46SUO7EqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5881

On 04.04.24 11:30, Richard Weinberger wrote:
> recursive_opts was added via
> 3f4c56c74 ("fix prepare-kernel for 2.4 and mindepth argument")
> but never worked as expected, it's recursive_opt, without "s".
> 

And what was the impact?

Looking at where recursive_opt is used, both cases specify additional
constraint on file names that likely happen to exclude source and target
directory names. Right?

> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  scripts/prepare-kernel.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index d50680dba..0b11eca66 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -94,7 +94,7 @@ patch_link() {
>                link_makefiles_opt="-name Makefile -o"
>             fi
>             if test x$recursive = xr; then
> -	       recursive_opts="-mindepth 1"
> +	       recursive_opt="-mindepth 1"
>  	       dir_opt="-type d -o"
>             else
>  	       recursive_opt="-maxdepth 1"

Jan

-- 
Siemens AG, Technology
Linux Expert Center

