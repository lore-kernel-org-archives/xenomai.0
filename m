Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41AB26AFA
	for <xenomai@lists.linux.dev>; Mon, 27 May 2024 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807082; cv=fail; b=XLrP6CojMlW5HdenVR/KX9PVcarWaQhdd29cI4NlVrcicVb27CECt1RdVg56qfVSOhqpz0ZGaKOZD5qM8BXGcEmhpzy0qUklVzmzU/fBI+y6QfXQBfz8Fm0UaHsfx4dT66bRwXlKnTBmmkVhRsdIQOdgPH9WQ1bQxb6th967ulQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807082; c=relaxed/simple;
	bh=i8vH/yVIwSjkUA6qic9PJN3i1amBeiYh02fr9Kmc464=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pdunorPdKpIgYt3tzqd+1jEa2bosXFcm/Uqn8N9vFSsvfsTRpwLzVH0xXcKEG0JodK/5qXgllCJNpIOYi+w2wGO+LjMDRG5OI11VEKYmXLt4Vedacj5KuAZa154I8XHyyZd46eJy75WRaRTW4lRx4YOM9l7c0DglHnSD2lr0diA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SCgRjE5X; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SCgRjE5X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDh6NNSyh/a+Hn7y6N1hD9JCtJS8V7OVbI7pd5BW3NSUQ9pS64KIp7s4MS2rOQ1I2WiCZNdI8OYDU9V1pDmasvx8erSwvBpWRX8IZslCB8rnTYBSFVtD/57awOnxJ2MpZdC/I/AwdgwfC1imwxSFycn/ywW9w2TFkB97XpgvVymOHwH7cIVD0oz5kYtcZG/hMRY1AYo5lo3y4trUdYF+QFn58rKbzPath+nN/iIQRIFr3qgz9qQgpqsIJyfsPQFj5IdwQ2HgKYP6YjQQparjNCbJpsNGQABDnOUG77C8QfEwEIanDaMud7AlSM53+J8aG2ZiRwPixcH3qLI+qrI2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik5doDsxNCZLZX8iYwDpafl/jbcNsZrfihQ90CueOnA=;
 b=G0nzxJNIe4QMriRsDx7uR4Rf0PugeL7d5QV+2GsCbg8F7G84u7BwOH+fepzWYjM2kln91Bqu/p1RlId/5TWdNJSZzbLz2yMtY+j01w13zkRSG9x1ka57HJUqSu9g0DP/3NSWfGozwClUWe0m/p/HH0kmjUALFHND7flh/04QuZ1ccM9mvyWUeSp3i8yAJnWYCyyxqw+cAGFcdp5XCct0MxVvil6nt5ewLZEvaUMxXbO/VNWXA7klhrvIBWu5VBV4TCWIVrAuRgZxW2xHzV4wGfLAQh/CjckA1DS7yM0eTeiwIpjbSvXnGrmBAZFX+8OsiOd1xY6iW3Bo+g2sPmiqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik5doDsxNCZLZX8iYwDpafl/jbcNsZrfihQ90CueOnA=;
 b=SCgRjE5XVnF5eJYqwjyPLf1dKHjeABqy84Zs/7/yuLL7AX4vHicIZOvr10Xc1/fXpjdJfddheN5B9QifMteq+5VD9I4mdeNtg9HtJLgP/Niu2jQDQD5iDfs2+m25QW1c2qyVd27U4Q/CMTqqv4UZ5R4mlT32GuxmW0XyLE4cfwiVxneSmCvv7JSJAjJKftnD/Raa2YNE0HhXV9Xb25pqExYEOzifm37j+zfg1QyMbtZGmms27C5Aavmev1UVnSCMhtcUSBeDilMRhld7ayYEaZZBfFP79P2RrSxv1BquUsBuYmcbzsiEwRV7qjK5AlbGrDCwiT3xi4B+Fe9d2JehzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8131.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 10:51:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 10:51:15 +0000
Message-ID: <25810d15-a929-496f-b3c1-6ca60caf0242@siemens.com>
Date: Mon, 27 May 2024 12:51:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] prepare-kernel.sh: Improve kernel tree check
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240525115806.12101-1-richard@nod.at>
 <20240525115806.12101-5-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240525115806.12101-5-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:610:b1::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 642beba5-9c7a-4dde-5abe-08dc7e3aee87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEprVktOV3dvQU4veFJyTmg0QkxwemxtNFkxSk9qSW5NbmNVWUhEWGtId1lH?=
 =?utf-8?B?UXlZN3VHalF2TXZqUVdCU085c2VEZnlPQVRNVVhyUmkzQTkrTlRFbFlmTVh1?=
 =?utf-8?B?aEFQWlFvY0JGMnNrekZ1a0JxWnQvb0FUKzBlbk5LaWkyOVd4SXRablcrVW54?=
 =?utf-8?B?c281MUplTS9lQmlnb1A4S2NTclBZZGtiSE5JNVBKdTlPanVWR09KUm45THYy?=
 =?utf-8?B?RExvekpjdTdZYkxqeWJDWTBlZkVsd3hvVDlQSmZ1RVJtaFZiMDR5dVM5MTB6?=
 =?utf-8?B?clVEdnhhWktSSHR1bDRsMFRCMFRJYkRtclNIb2JDdHMyalZPdHpiY0xOalpu?=
 =?utf-8?B?NnlEemJaSmI2SmtzUnVwNG1ObVhxdlBOcXpUNytlb2RDZ1NvY0xXSTYzS0dE?=
 =?utf-8?B?ekExT0RkdC9Qa0FnaDVtQ3RLM1A4UStwRTJ2RGY2NUYwT21ZM1dhenYzZGJC?=
 =?utf-8?B?QVVEM1R3SmZoMVQzbUp2bm9ZUFVGM25TYllZZXZUQ1RJeEFxU29Xd3FjeXRz?=
 =?utf-8?B?QThLTVFmQ3RPbnVScitHM241WmRUbzNUYVlDRnVrb3FPb0lBSjEzaytYNUc3?=
 =?utf-8?B?WG1LYXROdk1CRFJvb0RRM1JFMy93UEJmUGR5RUc0ZE16eWwrK1FjcDR4aEpt?=
 =?utf-8?B?SGVTR0Q5YjhoN1ZaYW1DTExFenp0S3JEdW5vYzhySS9xZlZ2aG5ueG11NklH?=
 =?utf-8?B?cFBOR3dRS0YraFMySCtyTlllenR6VmY0aEY2TFlVZzFYYkljeWFhZHJQYzNQ?=
 =?utf-8?B?UmVaWDNNYmpYdWRYK2lEOWlSTXpqVkNCK090UnRIa1ZFbWpQdDdqdktGdGM1?=
 =?utf-8?B?bERXUE9XNjZCQmZ4UlM1OXRjdC9LWnJKNmsvS1ZiUE5lelpGOHd2UExsZVcz?=
 =?utf-8?B?azUrakU4azA1cGtRRUFLblJJZVk0RjNjNUlyUGMwUXdSdlpQdGpDUzEvU0xx?=
 =?utf-8?B?cjNjUG5jTDNWMnpueVNkUzdNaE0wWElJQVE1N1ZBWi95bW9uR0Z2L0MzL2Jo?=
 =?utf-8?B?UnpkSVJrc0tTeGtoTnVLcUVqemdqa1ZLVDZrdmFSdjJmVXQ0TU9GLzFWazhR?=
 =?utf-8?B?aG9xRU83WENLVmE4UUd0Tnh1NWR3Y0IzRjQ3L2pJWXVSbjdBNThIU2l5Rkhp?=
 =?utf-8?B?RUttb3RJbkdPaktSTmlrMHNjVi9ZT0ZlcjdxcjhTQ3FNL1FNL1B4L2Y3eWFz?=
 =?utf-8?B?OElpR2x6LzNJeTJRZjl1YmhpWC83ejdYM1owampCeEg5Q3V3cyt5VGtIdGg4?=
 =?utf-8?B?aUFQajE0bUZXcDE0SnBFRi80L1NieFliNjdjMDdHNnVCcitRL0tXOTZVMnpT?=
 =?utf-8?B?d3lZS1FlRGNEQlE0MjZFTExEMm0vQXFWL21DV1dMOC9PdERHeDN5K3Q1QnNU?=
 =?utf-8?B?OWFmOWlQMUJKWTIrVUR0WHF2WE5RS3RwQmQ0Nk9ET2RtSTNCVnpiVTFlaEVM?=
 =?utf-8?B?azh3bEgxNUkzcGRBLytuZDZtaFdxZFBIdC9ZRnJ6SG0wajlnY21jMU1HWDJl?=
 =?utf-8?B?U0MrQnVFWUx4bWkvd2F4MXphRlh0dlo5YzczSjFrOUVjRllmczVBN2FjRFdx?=
 =?utf-8?B?VGtzTW1jS0JpM28zL3gvZlJoOFJaRXB6cWJOUlZ1MGg2SnVwQUlwSHE3SHIz?=
 =?utf-8?B?bFBBTFJwaUxxK2VOMmtwbnpNdEJLZWVDZTB3ZWR6QkVlODY5T29CZlFBeTFF?=
 =?utf-8?B?c0Q3NzNjdU1HY2FONXVlNUhrd1FPN1BDWDM4QXAxMjEyNEFnVjFZQ2t3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0hPYUVySWtTZFNBbnNhOWlwMDhTTU9iQ0JPTXE4RTRNNDFITjQ5R2hYKzZ6?=
 =?utf-8?B?SU4ralpaYURTN1EyeDVEVFJtdmpMb1FOUjN6V3NjYTNKTGJFQTNXaEtjZnlO?=
 =?utf-8?B?TTNYOTFXUkt4VW1tY0ZIRjg3OWNOdEVobkNLODZ5azBqY1lVU3JRdjFRSjNL?=
 =?utf-8?B?aXlwU0pMTTRyUVJSaisvMzhMbUEzc0xtWm1IU0V2QTg5OWRabG44N09kWUxY?=
 =?utf-8?B?SG1OdWN1aDNoRURVVXhBeWhLSUVqWGp5OEdobG5hQTAxVDVVUHZacWlsUjYy?=
 =?utf-8?B?TzA3bGZycnBac3h6cHczYmduN3BQOE9xRzdFWndvQ2xsU2didWFOUVlOVFVH?=
 =?utf-8?B?bm9qNUhuZjdDVUg5RVdCMmlyaWhmYU5Od0ozTVZLcVB4MDViOFV0MDE4clhP?=
 =?utf-8?B?U0NaNkZXT3pUNWVmVXVaTE1HZ1VzRm1sTlFndVFIeDE1ZUc2OHZXMHRLbGxE?=
 =?utf-8?B?RkVINVNrSkdpczJEaUlhYmpyeld0Rkc3K2FmL1g4cmhBbmx2YW44VmZGYlBs?=
 =?utf-8?B?TjBqWmt1cHQ3TGJIZ3pmNm1HL2xwUE0vOVhuWXNZaUMrRkpPN0F6aExSSnll?=
 =?utf-8?B?clIzY0VzTkFMbFVhRmFJWThESm1kNktQc1pWOW5wVHVYcWc5Zk5rNUZzbzdj?=
 =?utf-8?B?TUpJTG1UQ0c5TVFpb21rMmtpbDI0cTduRDNYRXdSVmJCajF3SE9tTlBxcXda?=
 =?utf-8?B?aWhPUndHV2tnc3d0aVdaeURwOUlOU1BjQS90WnVmcWVYNU91dHpTQktodS82?=
 =?utf-8?B?UFFGYWQ2dUIzTTFsY0hJcjdaWGxRMFVrME9LUHNHVUI2Nmd0LzI0enk1RmM3?=
 =?utf-8?B?SUwvYW9nV0tndHdYaHhDKy92NUtaTW1VbmkxZ3h6Ykd2aDJoSDgrQk9MYVZB?=
 =?utf-8?B?RzArZkpJV29hTXlJSGdsRFlZUnlYdXErY3FKdCtqRGVwS3lXS1h6bE42ZUdu?=
 =?utf-8?B?ZGFGS0dwcytZTWptZzhtQW9rY0gvLzNFWUJYZlNxOVE0NnJOVDBmQWMrMVJr?=
 =?utf-8?B?T3AzMVlkQm53OVFndmp4M0ZCTUg2TUV1QW91Z1U3NS8yL0E1Q25DcGxqUVB3?=
 =?utf-8?B?SEpoUm80MUVKenlYUE5kYWk4Tks5TDhXem1penkweFNLYjBpMjZWMjhlMzAy?=
 =?utf-8?B?OFplWkRvZzQ0NHY2ZlNQRlNrOE5vZ1UyaHg5SnBpeFc2RURVU2ZtcDdkaktP?=
 =?utf-8?B?M0ZRWUYwYm1BMXN1Z2NtT1hFUDFqWlhYeFI1U1N3VDRnZlpNT3M5VHJYUGd4?=
 =?utf-8?B?V3lWWnE3L0x6K0thbzRaT1dFaFY3b01CMmNra1U2TFdLMnFHZUJ2enBWSWNv?=
 =?utf-8?B?MVRjZVRVSXUzWmc5N1M2dytIampmVG9XaHlHV1FoNlhvT3k5amo2LzdWVG8x?=
 =?utf-8?B?cGQrbDREbiszeU41YkM4RWFhWXRmTE40dGM4VEVJTVBaN1F3TkF1WkFzbWE5?=
 =?utf-8?B?OVBiTXJyRlN1SnVtNzFSZ092SVJuWmpsVURyZHBkQmdtVEt1aG01OXZqZjVt?=
 =?utf-8?B?eHh4LzVueG1aUEVlc2Z5VC9jc1I1dDF5eXdUazVPQUE1U3JPWEZMejhLQmQw?=
 =?utf-8?B?czJKV2c2ZEdnekhCNFRNbFZnRlIyYWhLdnBiYTc4OTFiY0VxTUh0YXdQVUVF?=
 =?utf-8?B?aFUzQjhmSjZCQ1YxVEtleUxVbjRzYVFRYmUxQXZIdnlZR0hhNFpJcm0reTVW?=
 =?utf-8?B?ekZiV0RuOWxYeDNzTVUzMDR4SThuVkxuc2NUdHpRT2ZHRjI1b0cvcjRWS2Js?=
 =?utf-8?B?a2I2VmkvbDQwam5NSzZic3RFNm1pam1zczB5K1NidThNSFZwVnJXQUJPUHNU?=
 =?utf-8?B?Kyt0YUxOcERqTnQ3eU01WU1BWEpoMGF2WEsxUkEwbk1QSGxWbzN0NXZFcWVF?=
 =?utf-8?B?N3hueElORlJEKy92NklhQ1VXTnpSMkFNZzFmc1doVU5zaENPeDhCSURwNVph?=
 =?utf-8?B?T2gydVIwQTVmWWUwMkhqV1lRYU4xY3FqbnpjQkxDSHdBT2pkYkFXbE56TlBr?=
 =?utf-8?B?UllUblVSQ0NrdFJyc2EwSzZFdU80c1VaeW9qbmx3cW9yRE9ocVVNclhhYytG?=
 =?utf-8?B?b0hvVldZTXozYUJCNFh5OE56RS9uWGg5QTAyNi9Da09ENndreXl2ZmtEanAr?=
 =?utf-8?B?eU9CNkZIVm9XMnM3NWNEMzFKUjU5Z09VV2hQVTU1R0krb0sxVEw1aXRvT1F2?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642beba5-9c7a-4dde-5abe-08dc7e3aee87
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 10:51:15.6975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gyybh+Dycrenoeut6mSOMHL3v8K0oIBHrbsY8TAPWmbUArnyAQyXdMtJ99CE6zYpkm82MB7OjZlY0QhZUfN2TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8131

On 25.05.24 13:57, Richard Weinberger wrote:
> Currently any directory that contains a Makefile is treated as kernel tree.
> This causes strange errors when calling the script without parameters
> within the Xenomai tree.
> 
> $ ./scripts/prepare-kernel.sh
> ./scripts/prepare-kernel.sh: line 298: linux_: command not found
> 
> Fix it by checking for a more specific file in the kernel tree.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  scripts/prepare-kernel.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 534531e2b..800528058 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -237,7 +237,7 @@ done
>  
>  linux_tree=`cd $linux_tree && pwd`
>  
> -if test \! -r $linux_tree/Makefile; then
> +if test \! -r $linux_tree/kernel/kallsyms.c; then

Fine with checking for a real kernel, but this here is not my favorite
method. How about

test "$(head -1 README)" = "Linux kernel"

instead?

>  	echo "$me: $linux_tree is not a valid Linux kernel tree" >&2
>  	exit 2
>  fi

Jan

-- 
Siemens AG, Technology
Linux Expert Center

