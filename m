Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CD948C8AB
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998991; cv=fail; b=TohOH0QmRqPEV7w/FfDWpMABWfF1PtS6rAW0aR+9FLbrMuD2p80WZc/DmALJuPa9ElkaVMLFMBws3yPwXhU1+8yd9eNBTB7yo71TcgvtAgaWWXMizDCXPjKMWfFoPeVoORVOWIoW10fMB3KtDJ/+q2PpFy3efo3pzBMzI0xlR4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998991; c=relaxed/simple;
	bh=LpjiEOJIsRsgxnJ4yVvVgOyE55ssqWqFDwx64btOjWk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nu6rEBFFm4xEDBpT6FbiCXlcF5CTHZlvjADB7r2ULGvDz3iXRgcUq5P9QFEq8Yr/GVzO3U1XvnqoYvjUOAzp5EkcSFjojne2d9MlruzNdhDU9iRnW64NyKIuZ2Oc2CGG2FyKkW+M4FOaDcJTw3zDL07Zqb4baEGtkx5YY8JkkJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oLBrJ0i7; arc=fail smtp.client-ip=40.107.162.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oLBrJ0i7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmfjPskS6HamcKEKtcpfDeKIfIXQLG38fHPJNqfNLUgThEPciPaEYuU+PJ0+jcu+1rMLaSpPGdFf0loiel0jugakW3feMd27P2Npg8j/tYk7myJZMly1otmuzO+VbRER2CruO7Xpls+QQvghmNB0Kw82dRZktwetLMDwzIQ3sHdRTdMMqAT+jKXl7cdWDNpvrFLxHVoIb8oXvt8+TLQcYn6u5luQp2KpsxJD/06/W6YsRIaAxXVys0zmRfpv4UWdrtrSv3WMY54st/u5qTA084O7SoMCStBzdu/3cW8ahnhhzO5OLPA+63zMmeGVkaRTgs4ki0m8dwJAeTpKx9MGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgtGpMJW1fuxotXLTVVDHaTXfYz5CwRgr8r7M6Fc5bg=;
 b=lGGzh4+UEXXwfx84twA+OEvKCLRrstaBxXqHGqNE8moWSF1xFDdSBqUvc1g6kLR9Z09yjfUeV9U35YURMiCKokI2LwqAz/0lOXdbH7BKcJk1fPAnMz2yZ0PKU+9qK8qBjLde6JEzLKuf4piiuIzDwtw60QYMPkh10Ir32lcYWJpQuRcSjB+l/pu3lltw6zKFdMyNwjmoBUKBCcgI/6wlaYZdCK48RoGXTqEl+2LJnzQNh3OOhBbcp4Td3/8BgseZAIxIvwkhPRC2BtV0KKY3MrOwRKG5QByGSU4ZieTwV7AYvpkrt4DglkfO0F9LoiCrhA09DVx2ondPamCHA6spbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgtGpMJW1fuxotXLTVVDHaTXfYz5CwRgr8r7M6Fc5bg=;
 b=oLBrJ0i7DRQdLCvENpdbaFaciso6wtbovR7p07zRqwilFpYa1Nmu2T3yBlvFfIw7FWuXlOUqJa3MDtCf5JRtwyeimqgl5KTCkDGB9M28vfGwQBN3nUA/nXOeVbROi9Zs6WLvIWxdyuU7kpa7d1oVTIOkjcLn4FCGU3IqC8/vZ+6Cn0Q+VcZqJiTy9Gh1krUbS/y8bkKE817ATUNSPOTlv85yp+4CI4B+4qEMoxENBA6vdTD1RDlnfNQhXtxomhfB9da8T+iHViMoUAUtEFb4o1SEfv6Bb+2o7CXjbNHj/p+zgv++PfZOV48B2kOuAizIEZz6ZsizoQFuBYpAWatmZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7904.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:648::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:36:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:36:25 +0000
Message-ID: <12f6d219-f9e6-48fe-8be3-4cbb5374dced@siemens.com>
Date: Tue, 5 May 2026 18:36:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images v2 3/4] riscv: Add StarFive VisionFive2
 board support
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, florian.bezdeka@siemens.com
References: <20260505090627.65515-1-tobias.schaffner@siemens.com>
 <20260505090627.65515-4-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260505090627.65515-4-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: b7fd8484-7efa-40c5-b9d3-08deaac47296
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|12006099003|55112099003|10063799003;
X-Microsoft-Antispam-Message-Info:
	ZeayNhgn9QlLuzOh570twDHMRGXZVWjtEaLZeuSB9+6MKUz6uabnvo3nTjCKzH4d3vHQN+HiPag7vtL3NYqbHvK++uBClBtwKaNm2eZ53n43PXdlayAd1Z3bmVQnA5t8be+LLSYHEdy7ls8ZXkT1bVg2jQkqDCoIsD5VpiQGI3oSyBOtfE8RcL5N1uOx1TnjB+mmwj21lvMPyQptpOVTi2AnVMqj7YF0oLDGt1uBJcefURoM6Z3ga4sUJOu7H/eP+7sCQ/0vmSdBuqkid/baG5Od8a44JademA3NQkiHdGRASrz34uYnGTu0k+LKeBrrGT1ClcWPGGtwJoG2AjQSre8uiT+77oH//QbyWp5sa39BOkbqlFi3x3nr5q6iAhxfZVGUhNnmI5/iRT9CczwN9S2IvwjdcXyflmnM5S4W01aQtjo0ujh4FFFNEdERoquM9/phFRHo7A8aolRvg+5M2kMPpqYANLFHV7JBbjfFtEwhHDhv+VqXNXWUDF4YiDfuMhrPXYmM/gqzGltKbLw6e7aecfPmuUlqnyTqOLZVVK3o0jHDAgOMjBPIhVHqX9VdE73LpArm0y0NPLCdfBj5xKevrZAwVcNwYWl9XxS1/q24WHR5c4LGWg/BBskvAQsAHD+a6Rcws5ojvYwT3l3VzA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(12006099003)(55112099003)(10063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWtVcVZ5U05QaHQ0NU10WUpTVWpzdDVBdEtnVHpxa0JsN1M3aitDdGp1ZnBV?=
 =?utf-8?B?a1hhTk9INU4yNTZqQ2JrNVg3V0NYc0NKYUFmeVYvZGVESlc0MUtUOGdYR1dI?=
 =?utf-8?B?QTB3VmJTbVd3Sktvdmd3SXJUU01YcHVwT2FxTmlHemJPUFhaYzNTKy9JSWRH?=
 =?utf-8?B?OFZ0bGZFVVFPRHY4OGM5ZFQwejFRMS9qRXF5bVlvTnV6Qm0wUlhTY2RJZyty?=
 =?utf-8?B?dVhzajh5Z09yWWpGVldUY1BYTytlQkZkZnJ5TmI1Ymdwd1Y1akcrRkZVcU0x?=
 =?utf-8?B?elFWNFVjUFVrSmN1SjF5MUlRczFEV2hENXFlWVpINXBHSCtHdmlqSGV6ZUZW?=
 =?utf-8?B?YUZlM09ZV0l0LzJJQk5HUGNBUVpoOVU1TXJTcVRBMXNNdmhSSVVTeVpoNFh4?=
 =?utf-8?B?VjRkSTNUUnltSGdKWkJmSXpML1hZbUFnbVBBTklockdMaVRsQ0daMGRFUWty?=
 =?utf-8?B?Q2tmclBNLzQzd0RkWWpXYTlJQkNSNHBTMWsySktvcXhXMHd4WTBXWXgvSG5j?=
 =?utf-8?B?enNuVWF5QVhWRjBQYWREdXJkK0NOSTB0UFJ4V3BPLzlHMldFOThMaUk4ak9H?=
 =?utf-8?B?LzhMMk1PSUl3OGRma0NkZDlpMTJ0Tm5reldjcjN6WCtOMjFuWG9sY1BxMnlS?=
 =?utf-8?B?NlNiRVdGL2UwWlpEOGpybmF1b1ZIeDNmaVBTMHZGOVFrak9OcDlnVDVJU1RW?=
 =?utf-8?B?V3NBU1NodlNhRXJuRHZjNnI0dEJFZEVwZE1nd3hSQnJwZlR0bnA3Z3N2L0Ur?=
 =?utf-8?B?K3dnU1pEdlkwTFZXcklVc29BWXdWSExsSWRyMXlORFljdWlrZEpWS2drMnZh?=
 =?utf-8?B?Z21Kdkl5Yk03VityN2tzVlF1M0xVL2hXTWNGamVNcUZPK2ZXRndhMmJ2T2Zh?=
 =?utf-8?B?Ri9CMnVodXA3U0dDTFNCbTdNanZkWHo2MGJMdzJRVjNublZCYndheXR4eVV3?=
 =?utf-8?B?TFNYQVJRSXVBeWhCL1F2cTFKTGE5UEhJZmRXR2VIa21TYXVpekMyZnhqQVVN?=
 =?utf-8?B?M2xNTmFadDg3cXJJSWU5T2pBdXBhaGd1bW8vSjROckNFMmFVTGErMndZNTF5?=
 =?utf-8?B?ZjA3K1cyR3lWL1AydlU2OUZzQmYyaER5UndmeFpCYjBRVWF3MUQ4TjZVbFZz?=
 =?utf-8?B?bkptUC9CcGZpME9vc25GajNFNGttQStmR0RGQXJDUTgyRWYrcUVyOS9vbWc4?=
 =?utf-8?B?Zk1idVdtVkp0U3lVejg5VDdwcnhhMXZwLzdqNkg2eCtUVDVIaHhoN09kRDh5?=
 =?utf-8?B?bmdaL1lQZXFPOWNiaWxJMi9Ca2lOVWpEMUNiaEFuRzE5K04vUXVzclQyMUZN?=
 =?utf-8?B?ai96Y0kxbWxuSy9VdnEzWkxtYjlNS2FBUnkzM3ZQbnVQWFAzMmVHN1UxOXdn?=
 =?utf-8?B?OGx6RVN0Ny9OK0tNaEFLOXZ0YkxkSkhxOFZPU3ZnZVlOYmhNcGoyS1JWYWF2?=
 =?utf-8?B?aExOWm5oV1I2UGtrNGw1YUVkUkpCemxCVlJnbXhMV1dzT0M0d2dzOENobmda?=
 =?utf-8?B?TFZmcSthcWpMRXR4WmxtNHZIQUcxSEpuUTUzZEFrbzNTS3BudUhVS3pLL0l5?=
 =?utf-8?B?cnZKb1FLdnJmQmJmL0d5djF3Q0FUUzJJcDJOejVmRjhqdUVrcXRrQUJCOUo3?=
 =?utf-8?B?SDE1VkNJa0YwazFNOG93Sm9MUTBYRmprMVhVeWxiVW1qZTYxSEpnNEVaN2ZL?=
 =?utf-8?B?bVZUUnJlODFyRXA2TFBxK0NpWEMwMVJwMzArUGxFYmk3SWtEaGgyQnU3Y3V4?=
 =?utf-8?B?elZVaENHTEtuVjhyZk9JUlhQVERxbmdTcnlKZTlhNTRTSENPaXBwTWMyVjJr?=
 =?utf-8?B?YWZLY1JWdzV5S0tBZjBsVjdFWWpiajRPUHlLdi8zakRxWUJ2SHNqcGNnRDls?=
 =?utf-8?B?eVc0SmlvMDVUa3dlNEwwOGdreEkzQ1E2RTNoaCtYUVE5aDFMNjhIcDVuYWpS?=
 =?utf-8?B?YXIxaHNGb0xYaXpBYXhJalJRTDhWWDdad0lVVCt6bTU0YzVrNllkZTc1YnFJ?=
 =?utf-8?B?enBuOU9HV2VOQXdSOUVGMXJHOE9TYTlrYm9JK0xFUmluWWdIRHk4TUpUaUI4?=
 =?utf-8?B?dDFrUVFuSmdaakd3QnBFR1BQY3ZCL1owUHlQS3ZxVmlhVlg4bk9MVEcyREpR?=
 =?utf-8?B?UEU0ZStxUjROVHhwWUJxcTJGNGdXcHg1Z0ZXUE1CdDFqcUdSMXRoeVNPWG9o?=
 =?utf-8?B?emJCbldEdjF5b0xOdXZKR3dsODdyY2dBY2g5TzA3aUd5ZENYZ2dBNFZaV3JU?=
 =?utf-8?B?Q016aWZ1eXdVSjY4MktiZzJkMFFRbk9QRWQwYXQyS0VZcTZ4V0xZRUVHbE5Q?=
 =?utf-8?B?SU91N2MyUWorZ3Z2RG1JdFdyS0NhRFJ6UTFTdmpvVFFaamhpNWZEQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fd8484-7efa-40c5-b9d3-08deaac47296
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:36:25.1209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ca1sVcwBPol+F1uvXUzbkLEXE0o/gagOt2i2UKYcKpSjxUfOT95wskEpyddXtltGCUeu9vHkYs5ASNSw71QSvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7904

On 05.05.26 11:06, Tobias Schaffner wrote:
> Add machine config, U-Boot 2025.07, OpenSBI 1.8.1, and WIC layout for
> StarFive VisionFive2 RISC-V board.

"U-Boot is limited to the that version because booting from SD card was
dropped from later releases." - I would add that to explain this choice.

> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  conf/machine/starfive-visionfive2.conf        | 21 +++++++++++++
>  kas/board/starfive-visionfive2.yaml           | 15 ++++++++++
>  .../opensbi-starfive-visionfive2_1.8.1.bb     | 18 +++++++++++
>  .../u-boot-starfive-visionfive2_2025.07.bb    | 30 +++++++++++++++++++
>  wic/starfive-visionfive2.wks                  | 23 ++++++++++++++

Missing Kconfig update.

>  5 files changed, 107 insertions(+)
>  create mode 100644 conf/machine/starfive-visionfive2.conf
>  create mode 100644 kas/board/starfive-visionfive2.yaml
>  create mode 100644 recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb
>  create mode 100644 recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb
>  create mode 100644 wic/starfive-visionfive2.wks
> 
> diff --git a/conf/machine/starfive-visionfive2.conf b/conf/machine/starfive-visionfive2.conf
> new file mode 100644
> index 0000000..9f8b67d
> --- /dev/null
> +++ b/conf/machine/starfive-visionfive2.conf
> @@ -0,0 +1,21 @@
> +#
> +# Copyright (c) Siemens AG, 2023-2026
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +DISTRO_ARCH = "riscv64"
> +
> +DTB_FILES = " \
> +    starfive/jh7110-starfive-visionfive-2-v1.2a.dtb \
> +    starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
> +
> +IMAGE_FSTYPES ?= "wic"
> +WKS_FILE ?= "starfive-visionfive2.wks"
> +IMAGER_INSTALL:wic += " \
> +    u-boot-starfive-visionfive2 \
> +    ${SYSTEMD_BOOTLOADER_INSTALL}"
> +IMAGER_BUILD_DEPS += "u-boot-starfive-visionfive2"
> +
> +PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-starfive-visionfive2"
> +
> diff --git a/kas/board/starfive-visionfive2.yaml b/kas/board/starfive-visionfive2.yaml
> new file mode 100644
> index 0000000..406ed07
> --- /dev/null
> +++ b/kas/board/starfive-visionfive2.yaml
> @@ -0,0 +1,15 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +machine: starfive-visionfive2
> diff --git a/recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb b/recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb
> new file mode 100644
> index 0000000..bef5b04
> --- /dev/null
> +++ b/recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb
> @@ -0,0 +1,18 @@
> +#
> +# Copyright (c) Siemens AG, 2023-2026
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit opensbi
> +
> +DESCRIPTION = "OpenSBI firmware for StarFive VisionFive 2"
> +
> +SRC_URI += "https://github.com/riscv-software-src/opensbi/archive/refs/tags/v${PV}.tar.gz;downloadfilename=opensbi-${PV}.tar.gz"
> +SRC_URI[sha256sum] = "fb1ae61a85e966322101acb1c982f84d9eaafc4de7dd474a7d7546d9bb321c6f"
> +
> +S = "${WORKDIR}/opensbi-${PV}"
> +
> +OPENSBI_EXTRA_BUILDARGS = "FW_TEXT_START=0x40000000 FW_OPTIONS=0"
> +OPENSBI_BIN = "fw_dynamic.bin"
> +
> +COMPATIBLE_MACHINE = "^(starfive-visionfive2)$"
> diff --git a/recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb b/recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb
> new file mode 100644
> index 0000000..d5c8d92
> --- /dev/null
> +++ b/recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb
> @@ -0,0 +1,30 @@
> +#
> +# Copyright (c) Siemens AG, 2023-2026
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit u-boot
> +
> +DESCRIPTION = "U-Boot for StarFive VisionFive 2"
> +
> +COMPATIBLE_MACHINE = "^(starfive-visionfive2)$"
> +
> +SRC_URI += "https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2"
> +SRC_URI[sha256sum] = "0f933f6c5a426895bf306e93e6ac53c60870e4b54cda56d95211bec99e63bec7"
> +
> +S = "${WORKDIR}/u-boot-${PV}"
> +
> +DEPENDS += "opensbi-starfive-visionfive2"
> +DEBIAN_BUILD_DEPENDS .= ", opensbi-starfive-visionfive2, \
> +    python3-dev:native, python3-setuptools, swig, \
> +    libssl-dev:${DISTRO_ARCH}, libssl-dev:native, \
> +    libgnutls28-dev:${DISTRO_ARCH}, libgnutls28-dev:native"
> +
> +U_BOOT_CONFIG = "starfive_visionfive2_defconfig"
> +U_BOOT_BIN = "all"
> +U_BOOT_EXTRA_BUILDARGS = "OPENSBI=/usr/lib/opensbi/starfive-visionfive2/fw_dynamic.bin"
> +
> +do_prepare_build:append() {
> +    echo "u-boot.itb spl/u-boot-spl.bin.normal.out /usr/lib/u-boot/${MACHINE}" > \
> +        ${S}/debian/u-boot-${MACHINE}.install
> +}
> diff --git a/wic/starfive-visionfive2.wks b/wic/starfive-visionfive2.wks
> new file mode 100644
> index 0000000..4b0fd69
> --- /dev/null
> +++ b/wic/starfive-visionfive2.wks
> @@ -0,0 +1,23 @@
> +#
> +# Copyright (c) Siemens AG, 2023-2026
> +#
> +# SPDX-License-Identifier: MIT
> +
> +# The partition layout is based on the VisionFive2 example image:
> +# https://github.com/starfive-tech/VisionFive2/blob/JH7110_VisionFive2_devel/Makefile#L394
> +# However, instead of booting via ubootenv + fit, we boot fit + efi
> +#
> +# When booting from the SD card, make sure that the DIP switches are set to SD card.
> +# By that, the board reads the u-boot firmware from the SD instead of the internal flash.
> +# This is required to boot efi with the correct device tree, which is included in the fit image.
> +
> +# SPL
> +part --source rawcopy --sourceparams "file=/usr/lib/u-boot/starfive-visionfive2/u-boot-spl.bin.normal.out" --fixed-size 2M --part-type 2E54B353-1271-4842-806F-E436D6AF6985
> +# U-Boot FIT
> +part --source rawcopy --sourceparams "file=/usr/lib/u-boot/starfive-visionfive2/u-boot.itb" --fixed-size 4M --part-type BC13C2FF-59E6-4262-A352-B275FD6F7172
> +# EFI - DTB comes from U-Boot, not hardcoded in loader entry
> +part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot" --use-uuid --label efi --part-type EF00 --align 1024
> +# rootfs
> +part / --source rootfs --use-uuid --fstype ext4 --mkfs-extraopts "-T default" --label image --active --align 1024 --exclude-path=boot/
> +
> +bootloader --ptable gpt --timeout=0 --append "console=tty0 console=ttyS0,115200 earlycon rootwait"


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
