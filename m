Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42EC54EEBC
	for <xenomai@lists.linux.dev>; Tue,  8 Sep 2026 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883416; cv=fail; b=vBBuH1erlbe4ktdK8PKVtlw6D1bvOjrjuq/PGF45uiBwz2mbhNBLZGLYiBedfRfPwdRJKYkhDfUsjzSAUCfGBbO9D1wsJ/vCWgCJ7NpUyw2dOlCMMonojCaiHmWpHGJIsNBlBWtwfw5EITBujDZxbNRMWjS+sYOrII9pmnbBZzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883416; c=relaxed/simple;
	bh=k80DUw0ZefeTPD1ekzVjtkBvTMgXy3jqQoutjRgmCKY=;
	h=Message-ID:Date:Subject:From:To:References:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=jcgf3xDhl/+GccJPhkn1oNpDIofM+isowAzaZFSc2nIBO3XUpR8G6shG7mGtIYMcFkQQgGgsbIr0MBpJoT32z7EEBnEl0iQSL0VV2eiOy2WkOBIZGa5uWucl4IQYOETw2wrDnnxvgm2TvBWSddC3LpmFiln5AuulzXACu85kh8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Wop/JS40; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Wop/JS40"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYS42gzhZ1kkhHfnOrm93Vbdl+yy+rtkyxILHfWTXu7B8M4HvknHf//7oMbq0jdt9z5fOM5grBFIb0lBa31ccTQ15cDdqhCF26VpHtwUs4yyrNaTR7893rSofbjxhGv3bULKvpm6QCvrgiuMkzQ9OfLLBDLdesuXETKTc8Y7mVvx/1X5eMFK86XJRDsaTo5Lks1JWrBdriXo0/jPUO3FsBCjJ90+jTkRiHpZxB6nEhxYHu3hmTEvYbPvD7wtF399nVGcAOCcJ7jgbqt5S34B3X9VyTaVl2TwVo8FRrplIkkvel30tnx1TixPMoJSXZ65gz97pFzO10XNr+zn+ZgOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3L6FqbSbRlXEsP6hNov/BpfcqmpRkPgIqmb3jct1MY=;
 b=RZn7G/VWK+1S4zpbW2tJIeVOn5p0QRMUpFI4ADFVvCid9CFhhN7ctPgpKhk0rqcxhBv9hb6hQrtHoqatUB7Zc+L8499Ap+bJTa7OQAuFTyGWgR5hIFgIM5FyHVVffCUisoqac5IitHfwv8SshTq1r6P6gcuvcAZQTTfVYmW9XZ85z94auBsCKp6Gsiyo9skq+v6EA9R9hCfFC9GcgvJkEUBCQb8CAu1mlRxmEiVeqzYM8jZMNMVpUh7prJrM+GNkVD6rfELKpb2aIiorh+/EFeraaCumL5XiUrFR1JndABrG2wwpRwj+XVRXGiGpbmvDJaUwWKkxj+CrnH4W6CGm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3L6FqbSbRlXEsP6hNov/BpfcqmpRkPgIqmb3jct1MY=;
 b=Wop/JS40cDFbG8AkSQWaZBJykEMXtzZXx63+ct3Kqhe0v+9MoZVLC3jCD6qhU085ncc6vVCUj37GIYjwAqMTSXQqyHWpxmLymQ+xkR1T94xeaNeUnKO+tlx256OWxw7EBLYZNFi5ikK/fI5ONsRrQduE7dXcZolTSsWs9lWSZYMCMJlOLDls1Y1IzyyQB2cuw0ApYVJ4IXkFQ82kTA+LADrcis2/bYpiXvIRa6eek0yf2XZIYD59yP1zX3VWEp9+DeT54vun4y810KzkFzZJH5AXgn/aklM5o8tNdJ4Rxs5KKw9hgk4fF6nFEK9S0UHfB4vqkNZycJAkOSwR/Woe4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3568.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 16:03:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 16:03:29 +0000
Message-ID: <2cfdfbe6-8c90-456b-bfaa-0798a514fdff@siemens.com>
Date: Tue, 8 Sep 2026 18:03:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 2/5] ci: Allow riscv builds to fail
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
References: <cover.1787931296.git.jan.kiszka@siemens.com>
 <ee9837cbadd5b4e2b20a0ca2d68f33e6303185f5.1787931296.git.jan.kiszka@siemens.com>
Content-Language: en-US
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ee9837cbadd5b4e2b20a0ca2d68f33e6303185f5.1787931296.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0331.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3568:EE_
X-MS-Office365-Filtering-Correlation-Id: 41066006-553a-4d88-20cb-08df0dc2b901
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|11063799006|4143699003|55112099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	L4rVaDXZG9pQgBhAdPrqaZYouL8YITkZ86pvoNWBFCIcYQZzkVAE4gCpi/SoQL44CCF0bLhBEvd26gbdqRfVUkiylq7F79DVTcNSnVciLUotJP7D2UpKxYkzncgxZwmLd221LuxtK2wHdaWmtVvaSEIXJfkP56THzfBd7auTvmmkMZpOjrQXZbu3bBByyfaEWFK+R7ceP81F62VTU9U7wCCj+qHDpjUzdFwhpbWmOKom1KDNPkJRRUZRbQSW+Di7FnqB5ooNRK+7aXZCjppUOeoRrsPubCySxQQFvNmLj1kYh/JNfy15EcByR86GwqGdNY0uZGWIE9eKfMBwWeLfgirgLdQvfk5QVaywIljZ0C2xrc07bP6G2R5OllPjh4vDjL2mM2yk8UPmLChhv9oPr/rQflvt88OBF8cWuj94g1i8+5QbLXEnXSUlr5DDozBS8ilAoIMYJtF6kzyOKDNm430qDy7XKSsqpjfRfr990MeZy5QJSvXP3aDslU5c/fkCxDva8ZEV/Jb+gG4/9CmHEgjtR1mHSHMFv5+7YNNUDMzd8Qny+fciQpaBe2ABAvT/ZbV9TrpTu9fG1Rqd3Im87pOvtUUlyS5+g/PVXXQIhbOvY+Gg5ZQa6Lj80RBtFOK+bLM0osAp+ZOA673nZo77B/g3zyS0zR9cHfbGmfipemI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(11063799006)(4143699003)(55112099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amNuek5EOTdLeWRDaXpid0FHcEtUNnk3YklYMDNZTStkVlZFK01pZ3paOEFl?=
 =?utf-8?B?aUxUWW5LU2lQaDYwY09hbExxSU1wVmZKU08rZEtSUmNNOG4yS2xtWWo1UnV6?=
 =?utf-8?B?VDdlaE42cC8xMitYbDlsMFdKMzUzd1hOY1k5MWtDMWJLZC9jVURUT3R0TTVG?=
 =?utf-8?B?M1czZEtqVkdyNUtiZldqdWIxRmZXSHJOblUycjhvOEUzMnh3NmhiR3lmb1dH?=
 =?utf-8?B?cW9QZVpYbmZnN3VSdUdzMWk4MGlMaTFwcGRpMmFJb0NsTE5SWkh2VWRSNzVL?=
 =?utf-8?B?L084TitVekxyZ2NPL2Z6Nnd1cjlmM0NzVENzdldPcEpsRmlVM3VhWUs2QUo5?=
 =?utf-8?B?djYxZExNcmJSTHc0UWdrQkVpSXFwWTcyRzMzOXp6MkRnS2NEOUI1TUpsV0JW?=
 =?utf-8?B?MzR6RUkwc2NwcGNHWTFPdGprbElhejZneWY5bVlzcmEvRjRsenozZ3BjQi9s?=
 =?utf-8?B?SmR3U1VXS2JZTzZ6bkcxdE1OWXJtK0hidzdRMktsL0VQeTJsQXhNR3U1NlVH?=
 =?utf-8?B?MjRtOGRQdkFBc1JCb3lCZUJWdkw1cjNDamhuajNXS3grUUk2RFBIaGNIV1VP?=
 =?utf-8?B?a1VOU1dXL29BRnd6TnZUYU1VNEF3bDhnaHVUWC9ES2xOZS9OWjFiWHVHYXc1?=
 =?utf-8?B?WHZud1QzT2xsRWVoamxXRHdlT3E0ZnFFeDBONUovZXlyZHFVMTgwNmM2L2I4?=
 =?utf-8?B?a21FVmpkVVdHUHZWazR1b0xtOVpsSkJycjR1VHRZWFZrOVNkQXhpZ2dmelAx?=
 =?utf-8?B?NXZwM0hyUFRDbUdDdzJ5czFOSklleVZmd0lpeHlhQ00zNjhVWnBSWmYremx3?=
 =?utf-8?B?bGZoMm0wU3FkVjJ4cWdobHBTdVVDUmFOVngrVmFlMktUeUtnYVhtWUNWNmRw?=
 =?utf-8?B?R1QwQnR5MTlWWTdoOUNkdTZhZWxwR3YvUTM4aDRwZ3ZwNVFiTWpYeitaR1pp?=
 =?utf-8?B?aE5OYlFoSGIwRWplcDRTNldZMzVpWXIxcE14NmZkbVJ4TEJ2TDhLSy9mOEhF?=
 =?utf-8?B?MHlWYjYxYTJheGxsOGEzN0twdkRNWmdIWVBBY09OZ1BKNVRrT29DK0FXZS9p?=
 =?utf-8?B?aGlyamplVXBwWDRyZTFrcWMxRmlKVWhRSE5Mb3RuRy9yTmVHUTZ2NUFxbUUz?=
 =?utf-8?B?VHFXRVdsZERPbDVQRmREeUpmRDZPZG9OR0ZKTUpZMG5kNmNJMk54NE5BakZK?=
 =?utf-8?B?M2Z2VzFoUTlSNFJhbm1RWitwY05PM3M2SC9aYnozckNnS3FHN0VpRUZkek1N?=
 =?utf-8?B?Ynd2d0ZHblhhOEh3Z1l5elNVcFdVdUtsdzlzbGp0QUpsRDRPVUhDSzdjdkFM?=
 =?utf-8?B?R3o3QzRkRFczcTdnTjUvdHAxcjZIMkJncDFJUGUxNDlkYUR2Z05IZUpaOU9z?=
 =?utf-8?B?Nm9VSGJaSVovRS9MRkEzUkJmaUE3dmhPdWN1dUtnQU5zUFQ3Qis5L1JRMXlQ?=
 =?utf-8?B?ejJDSk1RZS9kSFpYa2NaRVUrcVRubi8rejFQcjVZYW9kRmovdVdObVlqRURP?=
 =?utf-8?B?ZkhOaEFuV2tqTzNKRnJtZ3ZremVteFpRbStacTI4YzZsSFhZRXcrYWM4cjVy?=
 =?utf-8?B?QzY0Z2lUVXJjQTcwclYrdE5CMzlsNERQRlVzUFJITUJCRlZKY0RTQVdIaXBm?=
 =?utf-8?B?YlJKOFNzUVJydnlUcWxOZXpTSSt1UVU4aWxuNEJyL1RxdGlISm95QmRDMmZn?=
 =?utf-8?B?MFhoTFpZNkJMNStXbTZ4TVl4RVU0MVMrQURENWpjVHV0TUcwVmhmM3V6bThM?=
 =?utf-8?B?NGl4aU95YUtlTUVRR0Q1eDlmWFF5RzFEWlpFNDBweEIrTDM5U2lSMGo1SmdY?=
 =?utf-8?B?cXBMcjNMa3h5cWhlcy9weHpXeVViakJqTFlxVit1dHBnbFNHR1FxaFhwZ1No?=
 =?utf-8?B?N3BST1ZTQkxkRlBjS1p2UFhyZzNQMW00bnpEL0ovbU5oL0ZyZWR5dEVoaXg5?=
 =?utf-8?B?YTdmV1A4YkphR0ZNcmQ4K1FPS0lEOXI1TDhpUU9PS1g2aHQvVmJnZGdPMWJ2?=
 =?utf-8?B?UC9BczlMeXg2V0tCdDRUZ1ovUnZ3VHNkNThlMkovNWpSNEt6VHJZWlpJOC9L?=
 =?utf-8?B?M21tM2RDdW9GdGhPL083dEZrRWtyUTFrSlFyZThqVDN6MTFUanhoQmxPMVMy?=
 =?utf-8?B?dDk2OWRkN2dsenZJb09TSm50dHZuNUdNWUxUaVFDYURMNzd6amlDVDIrM2w2?=
 =?utf-8?B?TDV2R1p3TDJ3aHZZVGxMZ3hFTXlXbHdSZDYwWHM3TDZoUnZ5TERydGk4M01r?=
 =?utf-8?B?Qk9PNVFnTEVibkRNa2xneVpRYlJySTIvRGlQY3NGQjFQTGREYU83eENPTmZE?=
 =?utf-8?B?bFpTY3BXWFZ5YXZIV1luQ3puamFKcS95TkZmRTltVlNwSmJQSG5oa21QVTNa?=
 =?utf-8?Q?IYTSm7VGtgR37Y70=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41066006-553a-4d88-20cb-08df0dc2b901
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 16:03:29.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g06UNnp/mqflGGIaHP8szlBz9W4i2Gr4pGwiV3g1V5PoLuepHbcmdv/lKY8NOBx6hAA3Df2fqSihPEKCQP5YSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3568

On 28.08.26 17:34, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Integration is still ongoing, too many loose pieces are flying around.
> This may change soon again, but we need to shield us from unfixable CI
> failures for now.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  ci/lib/kernel/head.yml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/ci/lib/kernel/head.yml b/ci/lib/kernel/head.yml
> index e5af966..028240b 100644
> --- a/ci/lib/kernel/head.yml
> +++ b/ci/lib/kernel/head.yml
> @@ -54,12 +54,14 @@ build-head:qemu-riscv64:
>      LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
>      KERNEL_VERSION: "head"
>      CACHE_KERNEL: evl
> +  allow_failure: true
>  
>  lava-test-head:qemu-riscv64:
>    needs: [ "build-head:qemu-riscv64" ]
>    extends: .lava-test:qemu-riscv64
>    variables:
>      KERNEL_VERSION: "head"
> +  allow_failure: true
>  
>  build-head:starfive-visionfive2:
>    extends: .build:starfive-visionfive2
> @@ -67,12 +69,14 @@ build-head:starfive-visionfive2:
>      LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
>      KERNEL_VERSION: "head"
>      CACHE_KERNEL: evl
> +  allow_failure: true
>  
>  lava-test-head:starfive-visionfive2:
>    needs: [ "build-head:starfive-visionfive2" ]
>    extends: .lava-test:starfive-visionfive2
>    variables:
>      KERNEL_VERSION: "head"
> +  allow_failure: true
>  
>  build-head:rpi4:
>    extends: .build:rpi4

Things look good now, and this didn't make it into master so far. So I'm
dropping it again now from next.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
