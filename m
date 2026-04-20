Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013015.outbound.protection.outlook.com [40.107.162.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91BB212D7C
	for <xenomai@lists.linux.dev>; Mon, 20 Apr 2026 05:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776664051; cv=fail; b=NsH5RdX1BXPTivknjOVIs/jhTNqaAgWb8zqYl1f4STWcm5kJTVB/H/HNjInLwIrgAO5u1X/ifUMYyPdLi/SfYHLTsqDKRvyGRju3K1L05lyUxf2YmwhjWRj+Lo9jA6cxTCp2qRifMFvxNmwk/AoQ3BVZ5YKB7yBs19NymjyUNGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776664051; c=relaxed/simple;
	bh=Ft/bz3XXxB1koRpjhD7pygdWHZoQRO3d+8UxKpUT2qw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hXrARRpOX9ieqCBhMMks8sxonRGwegUW0e7NS9gaO8xGDHZh3eKLS98q0MnS9zzp+daVw99CxenkEl3qlWcy6JFJidSJQm7ZrBONI0cc5kwXdIU0ZEeUUqZ4BsPO+2yTrykbqCmibRekRbzYVwkDQC2rBbYW3i6I4AJMgmqtYng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ITK6Oc80; arc=fail smtp.client-ip=40.107.162.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ITK6Oc80"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPJ2DPFmA3ghm2hgcQtalUd1BsPDQU8sU8VVNXh2xcMGzi/oVahCGwKD4jBI3RburafIuRN7MvPPAS6ebUneVvU+pSl6W0hPUwEmpfbb680mlx5dziJH2P2mgD78rZBjgHs56Bi2reR64/f+L6zGUyDnEDH6kkkks/8oFBwkfA+kevpTmG/ftjJhbwM4GywBPwNAhjJm82l8LVMqUZf0ClwPGAo2pbHl/Kg/9hrcL/KV/OPykOuaNRBgKjBcVRDk5lseG/wTOwB0S7It7u91EUmKwWRGvS5qrvRNjynK2wTM6PKDCSkaII2lilON1xxKh9mT7BIFn5A3AO9suXwQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/cakMvo4EmbrNQY61afSngttBbBP/hdbZ53IuSWb10=;
 b=fDo8ugNuaT2gJ4DiD/wqvNZdSGE0eLyIwW7iqF7t3GOS4BD3fTDYbf5hlgXS2L0G/AHg6mursH8GDodCxSZ/S96YCihQ9JEmhjmksgfuE84d2hw9NP876Ja+/CX/WCOujVpfM1M0CuPCqHociPJRL2evVDH3oxuU92r8wOMqA1jyobgGdvnmVDwIZnZQNIdbFb+4Yc8cbYqTuIfjOEGxVLa4pePu0tcJM4Hu9DglvdMcs/AII0wOXcnVvcHJTuLqHu9gH3Ll1HPBRG2osQcOaCX2IPEFk5pXLvz46zCoe0HZ65FueuqL/7PCgFz59dpzWkef5s2kj+OnC50GdkU2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/cakMvo4EmbrNQY61afSngttBbBP/hdbZ53IuSWb10=;
 b=ITK6Oc808zzAWHmaYXTT6gDn7ahNkMKWMX8ZEI8whLpUtvjmr9939c1t7lJc8PV6aBdHvAPBonyQZBSRWAZl0NHE9JmXg4uQoP0dhRKKWi7G2R+etQtr3u4tnXCr3Mo2OqZJpmZrmofB2EXeVld0ERPJxNIHiUZGaAXOgfSgg3eLdFCgpHWjj9ZHbmnOSdD396cny7/tCjKWI7QQRYCqXn73GYIvTG0NiBuSLuHSJ6j+reRN/znpjDTKi0gnHBXv3wNFZiynppjlvgpsDK42hCVQetRi79xn4aGpe5iIh0creKpO1fCxfAnHbolIxsECtcbWKDp0XZAgswwfkHLIvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5516.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:271::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 05:47:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 05:47:25 +0000
Message-ID: <33746f3c-becc-488c-a2c1-22b52614107d@siemens.com>
Date: Mon, 20 Apr 2026 07:47:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC xenomai-images 5/5] recipes-kernel: add debug
 additions to riscv64_defconfig
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com, rpm@xenomai.org
References: <20260417205713.2290350-1-tobias.schaffner@siemens.com>
 <20260417205713.2290350-6-tobias.schaffner@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260417205713.2290350-6-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: da58ac52-1ceb-4fc1-fc7c-08de9ea04cd3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C607N2wetom8oYamp/A9gKfsSetDRqkGnwOe7deXrGrSU9NzGX6D2ZVCxQYgSDB6YKyykfgwoBJUBGCXsk550DhBzMXmUQ/jCdmdhHFDj5yocjaysyVtbQringpjKmXMnKvcU/wlZt//vVfEHBhPVOuEAIorecG7RCObHTDQWjwbRgMZI8r3BMTGyFcT6m2bFEAN9QA2DoFRUPGxXPXzaHe3vdTKf2IO5CUO5QTz24JKH2MSJTi7io6hryajkhbuI0GDDVvdxS7CjTh0onCzaMSK/S8QYQauHFWRgVZh8kN4TbO8jqVRv5k6Ph8ByfpuBdd1UNkainklDpB849P4MSnzlPIRfZpDDRYxXjhDhQzEHxQ2XypuzrG7rnhSKAkoMpQixv2Djhf5X4mLNPM+TdPGxH0QMuJQXrm+PgRI2SacFVtqWlN4NT0+nc/KM8vpOpRvgs/0gtdGMCmdLV47+2se9FOgSE9Zxp1wAP/QuFbbXwibnXMhgUrvLPMDbCQRXLykqXMj44mGgoKAmHACPQaUgeqX41Bro0bfkxyueY24S15rBQE6P6PHVfHqmsIg2b/WLfhWVgCXz1GYAhzXFEwFFhXQDru4XTivKL2SqZLSn9S/klkszRcytLvzBHgXZdbRHZaPyzqR/tWjI18abXRbvLhUE1VDuC5SfIJHCAhFPtZPiE9aKTwvJ5S1vLN25OLWlUMwd3HP8D9xEZlNN7lSgHB5d1N9dS+Y+7x86nk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHJsc3lSclpQN3FRdHhZWG9SajIrTW10V2RjNzV3SnBkZXpOOUN2ODFMbkpo?=
 =?utf-8?B?R01hTExBcWZnSmlScDArVUFuS3AyeVhPTVVmcnZJUmd3RndrV0JrcFQ3NFNo?=
 =?utf-8?B?Vkl3dmVuZU1Ca3ArVC9Pa0xpYXFhb2NNcnJwMEVLSS93Z1BZRFRZYXArSkRp?=
 =?utf-8?B?UlRvcHk0UFJjZ2thT2dMclRZZDk1c0NvK0FCTTRzSFZzV05rMVkyTDFMOVBI?=
 =?utf-8?B?MzV3WmZ5ZVYxVmQ2bXdpSU14U2JvWjRuRWt4elhzeGR2K29RVFBBYkVVeTZS?=
 =?utf-8?B?MzJ2Rm9keUtVTWhBZkJDT0UvUWJHMzVOVmI1RCtHMGZ4bU1COWNhMUtPdWp0?=
 =?utf-8?B?UjNON1YrVmFibkdGMUlDZHFEdUpUenA2MFdTSmtxRlZNMDB3RWFPWTh3RTJx?=
 =?utf-8?B?MGp5aDk5NmFWa09Wc21GU1NKTGI2dzBXTStDV2xhdC82M0RoSjZxMUhFc3pi?=
 =?utf-8?B?ZzkrRWVIY2luOUdxVFRyME5xNVRlaFh3Qm9sd0IveVdSTGhpU2pnOUlYYkcy?=
 =?utf-8?B?a290RSt6emQ2bGFIVm1IeW9NWkpVVEI3U2praHpFV2JtWWlhSVdyNDQyaUVV?=
 =?utf-8?B?STVmbmFOTkdFWVdPb05hdTVXemNCV1RXcnZiQ0JrZ29HQVFhOXhVeWFKRDJU?=
 =?utf-8?B?ektuUjV2VWgxcGIycnUzdElqTm1mVUJyUEI3WkpvZVlycm50VlpYWXVjeGVM?=
 =?utf-8?B?MUJiTlNUNzNLRXNXQTNqMWdrYTNDdlJQM21mNE96dHVYMzRBMnlUN0ZwWDBF?=
 =?utf-8?B?amFTRDZZMEx5OVp2VFdnVWF2SEozU1NYN05EZ2JScXVDTHFrTzNRNk9OMUhU?=
 =?utf-8?B?czF6Ynd2ZGlDdlZSV041NitnbUhVY09HckxXdFRvWmJnSHJWNTNXWW5FQlR1?=
 =?utf-8?B?anJ0M0djUmNOeCtYWVVQZ0xNbHl4M2FBQ1BZSEl0WC9Pb1ZCTldKR1hmbGVs?=
 =?utf-8?B?NjNreGJFNmJubktoZ00vV3hlc29adFdDZWRtblU2UE1pSXZqM0Q4dEFqUEl6?=
 =?utf-8?B?QlFNTXZqR1l3YmdNUmlOV2F2R0NxOENWTnc2eHpQS2ZjS0tYdVM2a3g3UENJ?=
 =?utf-8?B?TFUyVDM2ajIyd2hWdTBFYTc1Rk00YWNkTnM1cVdJNWZzL3B2U2J1K3VEVk13?=
 =?utf-8?B?QTFwaGhUV1ZXZFFWbFkzWmUraHdYVDYwak1kdjVPaTNjbjYzMmxsSDh5ck1F?=
 =?utf-8?B?cjQ0d1NsMkY4R3F4R2xJc2lnQ09RMFRYK3J2Y1FKUE9NdzNxQi9Mc0M2MWRk?=
 =?utf-8?B?TG02bTJaSHd2eWFlb01mSDJkRVVYZU5XeWw3cXlpczJqa3prcEY0aTB1Vnhh?=
 =?utf-8?B?UG5Zam5IdDMrd1JiNDJoNHJJSmxPOVJBcXREam92b2lkQzBQU0Q4UWFZVkJN?=
 =?utf-8?B?MEo1T24rcThSV29BVWp3M0JJcUlHdzRCSnhsOThsY3R2Uzk3LzdwYVVBai9y?=
 =?utf-8?B?Ukw3NDF4bWN6UnVlaDJlWkREQkwwRXpmVmZ3MUFVenpUNVRoVU5SUFMyN3Nk?=
 =?utf-8?B?TVljZ0FlaDM5QUlQMWJjWUVUenRFL3JwdVhUMFFqUUhPOTRRWGF0Syt3SVV5?=
 =?utf-8?B?QVVFSXRha0JpQ2RvRWw2Rjlxb2J5cmZSR3hGclRhL1M1MW1ENGZ5K3RQSTUw?=
 =?utf-8?B?MkMydlBqS29weU0vbnNHbFdyUEFlTjVFeStiNnZaN0Irb1pua3NoMlp3NytP?=
 =?utf-8?B?a3QxaVM0dDZzQitCbGNkTjZ0cTBvVkdqRzlHd3RxRytoRTF4UTQyaDZFU1Iv?=
 =?utf-8?B?eHZiZmtSbFB4Wk1jeUZtVnZRU2luZ2J2MXdtZ243NkxkbUwzbi9Fb1ZSZVlG?=
 =?utf-8?B?QmtYS1hrQmxFZVRSaXM3aFhNVkp2Z3B6ODVWcWFaWE4xNFNEM2NUbzJ5SUgw?=
 =?utf-8?B?bTEzUzdwOVZ4Z1Bla280L0U0Ky9lNVUrVjdhOXpvaldnMkQxYXBjek1uOUhE?=
 =?utf-8?B?ZmVBNW50UGp2ZG13ckNyRjAxVW5hZXhjeWVBL0xNd0s4WkgxYzVFcUxYY3d4?=
 =?utf-8?B?dWc0QjEvWlBodFc0aHJZalBKR01TQ3FPbGplaytFbis5SjVML1NxSDNWWmxK?=
 =?utf-8?B?czF0NmQ1eEplZ3E3eFJUNXFIUTBKS1d2eXdVcWdmOWtLSWV0L2M0WjVwVWg2?=
 =?utf-8?B?czBUYWZ2MXQ1Y3RIM0g5U0sraWZ0eXdlTlFIOUVtOHJrL3dXbVdFODdRakpt?=
 =?utf-8?B?dkhWRU5raU03VGcwcDdqNjhwMnQ5ZHhvdWcyaEZaRjFIbzJzWUlHOWVVRHFw?=
 =?utf-8?B?UGgwVElhdCs5KzdUM2tPOG5sZ3hGVXZpcnFRRGR0cHlwYjFTcC9rakFuSUhB?=
 =?utf-8?B?eTc0V2xBZ2VEVWhkTkFTdmNiOHA0YnZKcUtHY2ZhZndURjNBRWZTZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da58ac52-1ceb-4fc1-fc7c-08de9ea04cd3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 05:47:25.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1SO1d4IILGDiny+uvEtASEXbGJvKsPt8VI+x/nJoPWw7NH3AhaeLjDoFcbd/VdlLjeGc9dGxfxo/8zFu+swjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5516

On 17.04.26 22:57, Tobias Schaffner wrote:
> Added to the defconfig to support the current workflow with a debug
> disablement snippet.
> 
> Added as a section in the end of the file to make factoring out debug
> configs at a later stage easier.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  recipes-kernel/linux/files/common_nodbg.cfg  |  2 ++
>  recipes-kernel/linux/files/riscv64_defconfig | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/recipes-kernel/linux/files/common_nodbg.cfg b/recipes-kernel/linux/files/common_nodbg.cfg
> index a57463b..6637d16 100644
> --- a/recipes-kernel/linux/files/common_nodbg.cfg
> +++ b/recipes-kernel/linux/files/common_nodbg.cfg
> @@ -1,5 +1,7 @@
>  # CONFIG_IPIPE_DEBUG is not set
>  # CONFIG_XENO_OPT_DEBUG is not set
> +# CONFIG_EVL_DEBUG is not set
> +# CONFIG_EVL_DEBUG_CORE is not set
>  # CONFIG_DEBUG_VM is not set
>  # CONFIG_DEBUG_LIST is not set
>  # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> diff --git a/recipes-kernel/linux/files/riscv64_defconfig b/recipes-kernel/linux/files/riscv64_defconfig
> index 8f9e852..6b991ae 100644
> --- a/recipes-kernel/linux/files/riscv64_defconfig
> +++ b/recipes-kernel/linux/files/riscv64_defconfig
> @@ -311,3 +311,18 @@ CONFIG_DEBUG_KERNEL=y
>  CONFIG_DEBUG_FS=y
>  # CONFIG_RUNTIME_TESTING_MENU is not set
>  CONFIG_MEMTEST=y
> +
> +
> +# Debug additions
> +CONFIG_BUG_ON_DATA_CORRUPTION=y
> +CONFIG_DEBUG_ATOMIC_SLEEP=y
> +CONFIG_DEBUG_LIST=y
> +CONFIG_DEBUG_LOCK_ALLOC=y
> +CONFIG_DEBUG_VM=y
> +CONFIG_DYNAMIC_FTRACE=y
> +CONFIG_EVL_DEBUG=y
> +CONFIG_EVL_DEBUG_CORE=y
> +CONFIG_FTRACE=y
> +CONFIG_FUNCTION_TRACER=y
> +CONFIG_PROVE_LOCKING=y
> +CONFIG_STACKTRACE=y

I vaguely recall an attempt to invert this logic to "base config +
common_debug.cfg" - what happened to it? But that's independent, no
comments on this change.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
