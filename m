Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011039.outbound.protection.outlook.com [52.101.70.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192B274B28
	for <xenomai@lists.linux.dev>; Mon, 27 Apr 2026 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303170; cv=fail; b=BgGXOlLF8Ld8oCJMAZYOa8DSjRYkj4ZZLPMxd5llIUfspo7dWvhmq8A/0Pu8tgPCFbCu3ieK6WQuR/ikXhD1sHm70cNwIxt689xfnTqFpeQUAAPFZjhWd02HYMPzLuEvvFZ2LG1xcHERhyDmYXQYdjkZVVVEYQ6YGYviBPOXnWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303170; c=relaxed/simple;
	bh=Ldpx/3kzsYvZ2YDHVjw3ooXqJX9BbvDTowBPtVUnlsQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NAIu0qwvBQwd0+Bg/rexGK17B1r3qmIU3Wyb36dTACKB059ZTdsADj/w5S4P4DjdiXGhVMPpqutPHssC0uXcy6T/9EnP6vo4qDvn53EwSWAqleHhQ46IPhEtlweLvXzUGaRiiIFuBWJhdTpmfx2pBd3SwWEJzZJVASlIIJxncS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bQFjORBa; arc=fail smtp.client-ip=52.101.70.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bQFjORBa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRt3RED72ofA6857fWxZDfZlfP0Z7qkkoh6DIIJb93rRTdln0ujr6Po83mrtBeu3GwlF+EmJ1oNX3/wyDplnK6vk2S9i5P+xei265fnaTxrYjsEAYSXyowHlX/m9CTdw2GElUU5UQ972yOnPyN8CySTEYckP+y7BL3TXK26iyo+/0ByWsTIYNAsyPsxcOI/90GrfwxCONWq1IdCbWl0emgskCX0bczzHWIHeDabqlZKz14C0mqzw1sJXYndAecnKSTDxs955vW35perVMQwm2rz2Q9ynQT9KKM3YhC2JjtXk26XX24TTYiwVGuM1cTtMP2uukpZTkgWz6e4V6VuuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTNLftcuhJ43sGsvXHwi7GdAeJmS/M26nlhtQUtby08=;
 b=DXwCbw0G4ZLuX4ZcnjDxvEpys2ZHogDiAKEk26iSD1eWAIKGc+PrdDIOCRNdKGBqhbTR3B2VWSQngOqa+gAdPt2RPoKvds/aLa3ssfZoa04C3EzGUVydAvVC3OCQlYvn0oCD5Ssx1yB2dCLYIoVYvnfFr0LQfYX0zkL/9GVVxmLx/nxR8Amqw4FoPXmNGD5EywehIownjGIKJ7uCghAjgJ0xjYfB/DV0VnlkKZdENSVqouGhWnvBxmyov5hddpueQsjClg0JCUqKy4n/x3+6Jl963baJ/n7EEJLl1cLczzDK69HoRQeokzSwf+MUKgwB5KcXmscIjsNUgWKjHQAKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTNLftcuhJ43sGsvXHwi7GdAeJmS/M26nlhtQUtby08=;
 b=bQFjORBawZ/L237yQggQRHWuPRQhl5dgcPX5ENC4OZvsA6kAyJxqm1xLNaFiWPqugT/FkG3vljmfUdp6jw9eDY+o7OS7UntdYqgV9DsnQJvTba8yl6V7rpnMF18eLxx7rf7GiIh1homYALL1Qx5FlZUA3U4/ng7GQApgu0QrFLDTo3iQl6gbvvjT7l1Xq4UyuESuSVNjAtJfRiC2DVF6q98ZLve9wQ1D8HNu1YdGGN5cbOKCmj7G/VOSrOqqzTrDumhvRhbv6kvBrxeVsghpeZDZ6Ec297lSAaG61Lria54Wk7wVx7MIWUsSOKkxKPNAMKmGJAKp4pD4wkZYUVo7+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB5806.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:509::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:19:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 15:19:24 +0000
Message-ID: <3861418f-90af-460f-9899-98a07c64e08b@siemens.com>
Date: Mon, 27 Apr 2026 17:19:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Update the e-mail address of the Xenomai mailing list
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260427-wip-flo-update-ml-addr-v1-1-624b1c285126@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260427-wip-flo-update-ml-addr-v1-1-624b1c285126@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:208:c0::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 7115a3ff-4fce-4245-c243-08dea4705d6b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	BobDVtiW/7AkQmcGH7d2lTSd5QmNC05zjRWPWYxa55e9/aAu7SmVBf1S33uhQS3D5XmEYp7lGwdsqyyTXKV8NQDX9AyG3qAB718cX32/2xLOxp94yVqDyi6ewd3IK47k8IlqckXBGwuUGfNAhx0rKDtBDjFEQd0EHZ8YxqsOC+Yp/BxpI5OZh4rLkY+O6UaQmnjR1YHcbi5014BZZjW1nVwcgAonXEM3TEAhGytQktez1+2mZqTqtYLW9G80BeU8K6iMWguoSU/nxIe0wjTwy/HSePloGleXEfWOSje17Dv18mE0Hh43UdnZAi0n4wjPXyaI1OQGR7yIUZke1UD9cIABpZsU8Rc7UoOcJQFbbc+j7MiwjecDQV35J/kOB3hCrwXAGCwJOpOBY3xXrE0ZKxbcFf+XkeEGT3COBN0a2Ij4Q1OrwPiHIZEozsC08UKLnFvuQeMlogSYy/q5biiaV3G2nD0T+ThQB3xUwfZz18JI5eNPXw5XGGDUovlu4VqhkEh2g+kkgkj8lcHmRb8Nfaszmre8AX5cWH5eN6IMfRMsejnE27cxkAXWzPl9Kq24iHb4ryKVU7N2dP0lBh/F5JupH7dEQA3h8BMugL/iRqPV6MyGBiCY1wyAh8mb12z0ptq8Nc6Ky5PFkAHGJTM9+Hsn2Xr3c+AZLmtm4Amhq5WK/JFt60ZJJD7K32bXGWl8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTV3S2tvdWFvTFFFbGRTMVgyV0Q4YVJFTTY3QUJ6U3I2aW8wQTVXRCs3Y2k3?=
 =?utf-8?B?bWV6elNzWnhLZUI1Y1EwdXZGWVlRK0ZRYVl0SDFURlN2Nmc5MGJ1cUdodDk2?=
 =?utf-8?B?Ui9DS2FRaFdDNFIvNlRONVYyZ2tnQkpSLzBYc2QyVkNNb1FBNUVvemVOVnRX?=
 =?utf-8?B?TkhxQmU3NDBnWVFYVERaVzBqWU5ndVNZSDZUbkFhbW9EVlpJSVFHTEJ1eFFT?=
 =?utf-8?B?MjdkREpibWl2MFRrNlFkcWxkbXhxd2JxUVBzWStTT0Evb0xDYVFVTmhvVmJI?=
 =?utf-8?B?Vkx6MWZHQjd0L2dEU2FiUjZubGhUUFVXeVA2SDdKTWo1QjZlSjBGUU42ZzBO?=
 =?utf-8?B?NElWNnQ5dmcvZ2J5SExLNGNiL3F4aGhpNm1tenB1bzZTVC9ZS3Ezc2dzdmJv?=
 =?utf-8?B?VDBFMi93dnpuN0V6WGovaWF1RE1nak1QR1VFSHBzclVEazVjZ1g2b3BDU2F6?=
 =?utf-8?B?bXUxOHdoeU9TZkNYNjZQbndPTExma3JRaHhwZDRnMVJaMmFFU3d0UkpIUHFw?=
 =?utf-8?B?VVlmSjh4bkRoSEUzaHVVb2dIclJJMjVWZGdCY1ZFRnZIaTVMS0lMeHRiQkR5?=
 =?utf-8?B?eFY4eXdnby9VWnZ1RG5la2EvS3QxdlFwQTI4cnVuSjYwTWhZbUpES1Z3VC9Q?=
 =?utf-8?B?QngwZUFDdmNvN3A4eHhFaC9HQVNad2ZLVDQvL0p0dHBycUs0YktIbG9JcG1z?=
 =?utf-8?B?RjlWZUwrVDhkY2xjZlZiUWhqVWhabmd5Q0k3cXVaZlpiSS9uSHI4c2NTVGdM?=
 =?utf-8?B?bGRVZHpSYyttaitoZFhOSGxaQmthNmhFRVZsdG1uT1NKTllPTHNwb05yQ3kr?=
 =?utf-8?B?M2pGZWxNbUVaTDhwQXpLREJtakRocG9YTk82MjYydThsdjJ3UkY4bXVWYUFO?=
 =?utf-8?B?dVI0U0ZXUE5MQ1NGUFZJM1lkWklkUGMza3lpUEV1aC9YM1JlY0l5L2JZNDFM?=
 =?utf-8?B?d3NRWXorME56Ty80ekV2a21VVzNHQXZicm5WRWNKY0NTUFNza1VnQ0ZacGJk?=
 =?utf-8?B?QkZSVTN3MGlBVjYzWTJQdzJmdmVBVnE0QTN0eUNmcmgzdkJUdTlBNDI5TENP?=
 =?utf-8?B?S0pJbW10ektJcitkNmNmZUc3U0hObmJ2SHlYR3N1NnVCSXdOZTBicnVmWEhT?=
 =?utf-8?B?WGNvUmM3bUZMVEdDM29Bdi9kd09xdEFNc3dTVjI4VEpJU2ZCRml2dTJPd1RH?=
 =?utf-8?B?OHRReWJNK29oTTJNeHBya0YyTzRxbkxXWktlNFcxa2psUTBGWkxkbXhIdVZP?=
 =?utf-8?B?dnp0WDVMN05kYUN6TEVRSlRYMGczNnkzUFNNODdqcDRBcU9ScjVWd3ZERWFU?=
 =?utf-8?B?bmtTdm5SQS9DNmRESHJRc0V0MXN4V2xyNTZpaUYxa1Zxc3pBN3NyZzhZb3FX?=
 =?utf-8?B?VW5ub0dsMk5qL04zR0FmYU1uOHNXZ1BGb2FYV1VFa3ZkYlp2N2o3RTBNaEcx?=
 =?utf-8?B?U0paT2YvalNVS0tpbmp3dUNxU0NDdDZ3Nk1aT3l0SVFSemtOa2ZReHVJeTdY?=
 =?utf-8?B?K0hqOVdJK3phOUcwa0UvdWZsV1F3VFdMVmJQdm5vcHNBUVVJUDdNZGEvUWVI?=
 =?utf-8?B?cjMwTllDZEJjQnFZSVkwbmVOenlzdHpuRHFzS1JJY3Z4UHVwQWtWaHIyQS93?=
 =?utf-8?B?QmlBUWxIM1FyTkQ0a1JDTHZmNnZYWm56aFFucHZlMk1FUTVuUTN4Q3RBV2gz?=
 =?utf-8?B?Q2pwdUdJNDBhZVVBVm90TjJjVXBHdC9FeEdGMmQzUDdydmxWVmFxdCtSRHBT?=
 =?utf-8?B?RFNsMllpcEQ5UTJmaDAwdHJZYWFnOU1BZmJvcE5Id3pTbGZqNXZvQ1UvY1Fz?=
 =?utf-8?B?VC9yY042NzdJZXhSY21qbG1PTHVqR3RTNlJaZ01vSWtUZytWUCtIbVZuOGhr?=
 =?utf-8?B?QnVvdzI2MlNpcEpOalFSQk91TXNBYmtqSG84WWFtU0FPNjlWRERyN2FUTkpE?=
 =?utf-8?B?N1lVTi9jeGlCdjVsNnp6cTlLZDZzNEY0aUFDNTlPanpaTHhmUlRha3YwSFM5?=
 =?utf-8?B?WFQzdWVsYThUT3Z6eEtMY2JsaGFNaElEOENmTUtHKzdZbnNqc3hEbWs3TXhC?=
 =?utf-8?B?bnQ1Ukp3S3Z1MUN4YkVyMjZlSCt6Njk5T0xwREV1eXJ3Sk9VanJmT09OYWZs?=
 =?utf-8?B?T3hFdmF3WWIwSEdaQXAyc1FLK0prS3p2cjFtNUh3L25PMWk5Vko2TW1TK0dh?=
 =?utf-8?B?ZGs4VjJlUXAvcWIwU0RrRHRlSDJuK1BXV1N1TllmMDlNMDlkQi92bGdkMkUy?=
 =?utf-8?B?R3lGREhYK1NMcnVjZ2luL1NvNFpnMGt6VU5vaThMOTh2OW5RaXhXRmlqNmxF?=
 =?utf-8?B?bHZHMXNNaVl4MHZScUhRTnFBN3lid2syRDhYRElTb25QSWJRV0V5dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7115a3ff-4fce-4245-c243-08dea4705d6b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:19:24.7604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tP2/8Z4vGkMn3RADUgj6LB5AgOIW1FJ+bYJH5xkz7ND8E6z+F3LHx5zxQaGdTLI3YYuoA6F70zqnrHVrtj8bZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5806

On 27.04.26 17:13, Florian Bezdeka wrote:
> We have two working mail addresses for the Xenomai mailing list:
> 
>   - Historical: xenomai@xenomai.org, still working and forwarding
>                 mails to
>   - Current:    xenomai@lists.linux.dev
> 
> The historical address is still working, yes, but we're not sure if
> the forwarding is properly working in all cases. linux.dev has strict
> anti-spam rules, SPF and friends. Moving to the lists.linux.dev
> address should provide better reliability.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  configure.ac                             | 2 +-
>  debian/control                           | 2 +-
>  demo/alchemy/altency.c                   | 2 +-
>  doc/asciidoc/TROUBLESHOOTING.COBALT.adoc | 2 +-
>  doc/asciidoc/man1/xeno-config.adoc       | 2 +-
>  include/rtdm/serial.h                    | 2 +-
>  include/rtdm/testing.h                   | 2 +-
>  kernel/drivers/can/README                | 2 +-
>  lib/psos/README                          | 2 +-
>  lib/vxworks/README                       | 2 +-
>  testsuite/latency/latency.c              | 2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index a9da072877658382cdd54a5ecb42cff4c5d0e018..22823756dfe907c3b0df4dd8f6cef88d22854088 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -7,7 +7,7 @@ AC_PREREQ([2.69])
>  # implement (which actually expresses the revision level of the
>  # Copperplate library).  The kernel ABI is Cobalt-specific and is
>  # defined for each architecture in the asm/features.h file.
> -AC_INIT([Xenomai],[m4_normalize(m4_include([config/version-label]))],[xenomai@xenomai.org])
> +AC_INIT([Xenomai],[m4_normalize(m4_include([config/version-label]))],[xenomai@lists.linux.dev])
>  
>  AC_CONFIG_HEADERS(include/xeno_config.h)
>  AC_CONFIG_AUX_DIR(config)
> diff --git a/debian/control b/debian/control
> index 9855de1982008ce4b7707cb60f16504a25a67940..fb54392e206ef39742a321b2b3970ca4573e902d 100644
> --- a/debian/control
> +++ b/debian/control
> @@ -1,7 +1,7 @@
>  Source: xenomai
>  Section: devel
>  Priority: extra
> -Maintainer: Xenomai <xenomai@xenomai.org>
> +Maintainer: Xenomai <xenomai@lists.linux.dev>
>  Build-Depends: debhelper (>= 8), findutils (>= 4.2.28), autotools-dev, autoconf, automake, libtool, pkg-config, libltdl-dev
>  Standards-Version: 3.9.3
>  Homepage: http://www.xenomai.org/
> diff --git a/demo/alchemy/altency.c b/demo/alchemy/altency.c
> index 072d68f8e86bfe66d407b42bd450e8045707932d..43ce8ea4a890ef0446dde1a02e9208af00d7fe6a 100644
> --- a/demo/alchemy/altency.c
> +++ b/demo/alchemy/altency.c
> @@ -423,7 +423,7 @@ static void cleanup(void)
>  	if (max_relaxed > 0)
>  		printf(
>  "Warning! some latency peaks may have been due to involuntary mode switches.\n"
> -"Please contact xenomai@xenomai.org\n");
> +"Please contact xenomai@lists.linux.dev\n");
>  
>  	if (histogram_avg)
>  		free(histogram_avg);
> diff --git a/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc b/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
> index 6e9550aadfae5b64380a3dff67e220eb0a8f7e35..fb11f7f3f45f9a2a14350cedd05abb8ac6f50080 100644
> --- a/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
> +++ b/doc/asciidoc/TROUBLESHOOTING.COBALT.adoc
> @@ -59,7 +59,7 @@ first.
>  
>  If nothing seems wrong there, try capturing the OOPS information using
>  a _serial console_ or _netconsole_, then post it to the
> -mailto:xenomai@xenomai.org[xenomai mailing list], along with the
> +mailto:xenomai@lists.linux.dev[xenomai mailing list], along with the
>  kernel configuration file (aka `.config`) matching the kernel build.
>  
>  === Kernel boots but does not print any message
> diff --git a/doc/asciidoc/man1/xeno-config.adoc b/doc/asciidoc/man1/xeno-config.adoc
> index 0416a7fa5f34ca7a2c46aaab4231ea36560c7079..79474db156320a8255fd74f7164bb6476be2c319 100644
> --- a/doc/asciidoc/man1/xeno-config.adoc
> +++ b/doc/asciidoc/man1/xeno-config.adoc
> @@ -175,7 +175,7 @@ Dump information about the running Xenomai-enabled system. Unlike most
>  other options, *--info* is aimed at being used on the target system
>  running Xenomai, for retrieving the current setup information. The
>  output of such command is valuable information when reporting any
> -runtime issue to mailto:xenomai@xenomai.org[the Xenomai mailing
> +runtime issue to mailto:xenomai@lists.linux.dev[the Xenomai mailing
>  list]. The command exits immediately after completion.
>  
>  ENVIRONMENT VARIABLES
> diff --git a/include/rtdm/serial.h b/include/rtdm/serial.h
> index 232e96dcc10c519a760f2c30de5851b632fc4b4d..2068bc9ddb8ac43ef93f68c74a20f50c61ac68f3 100644
> --- a/include/rtdm/serial.h
> +++ b/include/rtdm/serial.h
> @@ -30,7 +30,7 @@
>   *
>   * This is the common interface a RTDM-compliant serial device has to
>   * provide.  Feel free to comment on this profile via the Xenomai
> - * mailing list <xenomai@xenomai.org> or directly to the author
> + * mailing list <xenomai@lists.linux.dev> or directly to the author
>   * <jan.kiszka@web.de>.
>   *
>   * @b Profile @b Revision: 3
> diff --git a/include/rtdm/testing.h b/include/rtdm/testing.h
> index 2eb813555fb5e10c993cbb790b1175818b7c0522..be629f4fa0f326e8fe2fd1162f8e738b4e2217cf 100644
> --- a/include/rtdm/testing.h
> +++ b/include/rtdm/testing.h
> @@ -30,7 +30,7 @@
>   *
>   * This group of devices is intended to provide in-kernel testing
>   * results.  Feel free to comment on this profile via the Xenomai
> - * mailing list <xenomai@xenomai.org> or directly to the author
> + * mailing list <xenomai@lists.linux.dev> or directly to the author
>   * <jan.kiszka@web.de>.
>   *
>   * @b Profile @b Revision: 2
> diff --git a/kernel/drivers/can/README b/kernel/drivers/can/README
> index 44aff9b1cde5c00f09b2ecfa92c3216b2d993fa9..54a9d5bba84ad08f2dca15a2eb71901ae26f25dc 100644
> --- a/kernel/drivers/can/README
> +++ b/kernel/drivers/can/README
> @@ -122,7 +122,7 @@ Feedback:
>  --------
>  
>  Please report Xenomai related bugs and comments to the Xenomai mailing 
> -list (xenomai@xenomai.org).
> +list (xenomai@lists.linux.dev).
>  
>  Please report CAN related bugs and comments to the "Socketcan" mailing 
>  list (Socketcan-users@lists.berlios.de) or directly to the main authors 
> diff --git a/lib/psos/README b/lib/psos/README
> index a76170e83ed4a888730aba17aa590f907d04b62d..d548a822485f83557099ab8f2afe7419f12b768b 100644
> --- a/lib/psos/README
> +++ b/lib/psos/README
> @@ -10,7 +10,7 @@ Known variations from pSOS
>  
>  You may observe some variations from pSOS. If you find such a
>  variation and you think it would be easy to correct, please mail to
> -the Xenomai mailing list at <xenomai@xenomai.org>.  Here are the known
> +the Xenomai mailing list at <xenomai@lists.linux.dev>.  Here are the known
>  variations:
>  
>  - pSOS task priorities are restricted to [1..97] in the current
> diff --git a/lib/vxworks/README b/lib/vxworks/README
> index 0d0dcefe7a692f531b41f40730240cb0ab32a556..4b018a49050fa2bff420e8097c47de46eb726391 100644
> --- a/lib/vxworks/README
> +++ b/lib/vxworks/README
> @@ -9,7 +9,7 @@ Known variations from VxWorks/WIND
>  
>  You may observe some variations from VxWorks. If you find such a
>  variation and you think it would be easy to correct, please mail to
> -the Xenomai mailing list at <xenomai@xenomai.org>.  Here are the known
> +the Xenomai mailing list at <xenomai@lists.linux.dev>.  Here are the known
>  variations:
>  
>  - VxWorks task priorities are restricted to [97..0] in the current
> diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
> index 0b6964bb97bd79d140a96458a8bb48ee4d6f8737..bb97711a42db212f761b6cc02bebb51ea69d2366 100644
> --- a/testsuite/latency/latency.c
> +++ b/testsuite/latency/latency.c
> @@ -529,7 +529,7 @@ static void cleanup(void)
>  	if (max_relaxed > 0)
>  		printf(
>  "Warning! some latency peaks may have been due to involuntary mode switches.\n"
> -"Please contact xenomai@xenomai.org\n");
> +"Please contact xenomai@lists.linux.dev\n");
>  
>  	if (histogram_avg)
>  		free(histogram_avg);
> 
> ---
> base-commit: d4929cf0ee285dea62ba697f2729c6d3a2ab1639
> change-id: 20260427-wip-flo-update-ml-addr-36cf20598d06
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
