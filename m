Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A43438AF
	for <xenomai@lists.linux.dev>; Thu, 28 May 2026 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953911; cv=fail; b=qfux40FY/PYuszW6Wfq/6nOEu6RL4v0L714UqQG9TNXhJm10UfGEQe2C1kex5vaY0P4Z8/fHVht2TYnZ/6loq5a65iYLuj0zeZm0yrpPwIsTrz5W6gczvEknZBTJHlj4cZ1//dQTD6zOnhwE80hn9FBtKqkCs2/q2gYie04NAP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953911; c=relaxed/simple;
	bh=FTtGUvSW5kUniNs22JHReB+M8ysdLmEISH0HhzphB8s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jtTHRVAyUMnruNrYRATYJQkkflIquHL5JEdFznDrySQ0nkM1Al7+Mp/x59ZVYQxiHsNAUaKamRFR0j22/6AooFyyc3TdAO4XOXdCdw5BkhtJK49xIr7agt6TUMcH+EooNi+6eGokiGxW6tpDvSLF9qghQCCkGrxIIEqUH0NXkvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uSn7mfvF; arc=fail smtp.client-ip=40.107.130.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uSn7mfvF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tfsswbul31IX/huQnszbxo5WraX6M2VGei3b9GlpqIcEKR/DsL2zaCq0rqVDpmqstV8iS5ke4+pFhg39dSNpByJgNu3RbpY+WD5cG7aEaef7zfdXiy52tP7PhLuWiyuhs+nvyv3TkcepEOXx1R5ce+cwbyvdIiYiLI2JoxIIx/FRLFvXN+0wdPspWUEcRHuOsVX6wfkFKV57f4g31eE3N09spktwqcpzYGDxgkrZhkriAP4ty5xri5DJvSudEsQkNbN2HnFyLpKhFy9aFzF+SxPH2sAUVce8/eGU1LLv1NmW7E4Emi1qMBTVP+1YVkhKFvyfWfzqTSDveUCzn0zFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jeSmzrHJVF64vV2GH8uOHQ+Luy/HMVIrPQrS8JaRpY=;
 b=HufSZeuA2gYBl+cFn7QoIvTyy+diyOcEd92EmpIfnGEr4z3g0jbhdyTjG+N/Ln3krvsHcxC4k/zj844IqZEYeii76v4Ek08W/FCljHByWbqel1q/YwCOoj+4kTiSUr0wqE4ApGyDGlP1z3OpazIZuxbCQybBLVZWfmOnnrCxhGytTsl/Db1almYxrWZ2bp6uzz5/GA6V+uk4w4ctleK5YIaSlmFomOtaRsXw8QLi4K+JyON313+BLIc6CLN3cm8ZglVG9Nfhy94rz02iRLN3WteErkJCsqPw5xfFMt0Yj+A35KWI/8q+Fi+t4dBLnnnJW4Fp+9n0h1N/OEPXTH7Nag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jeSmzrHJVF64vV2GH8uOHQ+Luy/HMVIrPQrS8JaRpY=;
 b=uSn7mfvFkFtQZuPBvT/wUvlb7hgk+eB6BZxUQdJjF3P5002QSV1fIp/YixlbmkdfWFycvW/4eV7c9sh2Yc6lOEXKOLpqbP0MwL5jEaIAcFeR0srVtvGwUcQcNGPMYVuMweauMyHDTGfdQpheY0QpSuW/B10vuwuNTIIBL9GZAT/S2Nkx30xdieDY7qyl1WZ01wUUrQ5miHtu2hLZB2T1cXFs3QqmaFuf114D7MSDZfDNKKz+DWE4T9wpg8m5+kQ1yj8mhwmLU4iPKxZc1b600Dl2+ubTRqD8WOtS5fKIJG00MhQIdhwhUSCuClywgr70T57GjUitdItiX5InLJWKsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3559.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:142::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 07:38:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 07:38:23 +0000
Message-ID: <d4cbd760-17e3-4c84-b44c-249d7c4d7b71@siemens.com>
Date: Thu, 28 May 2026 09:38:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers/spi: Prepare for linux/of_gpio.h removal in
 Linux 7.1
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260527-wip-flo-7-1-preparations-v1-0-b65d1304bb6b@siemens.com>
 <20260527-wip-flo-7-1-preparations-v1-1-b65d1304bb6b@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260527-wip-flo-7-1-preparations-v1-1-b65d1304bb6b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3559:EE_
X-MS-Office365-Filtering-Correlation-Id: 763596d9-4080-44c1-268f-08debc8c18d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|11063799006|56012099006|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PpAT8hS8if+sxQMgUHNk6guCG7a1V1mHcIiKKNQFljye6qHGTu/8V54JgukFKzFn7+VY7zIb109a4ZXJhkWKQUpHJ1VLFjSc/6VfUVV6Ye8jvpBhIr6aGP4vS3dV7CbZGz57Kvc7RPkH4wCKxC/NEucPPOBOBUTLwqRQlpVa9t73Sf640/KhOY/7E8/UOk1eLFySTqQzaCSc9N4pMD6AXtUEvE7tqn1NxQZLQ6ougQpDSIjOYx+UEczJc4Dq/DBEKZ2wRY1M0auGN63bNU+brxXkPSupLia3wbP6y1NZkWVubtm0ECsx5nyFAzJbpVXBUvw9uLhhwIzI3AoFWsM//k0lL2X1qmPMd1lVRKKfJEmM/7vvvaBhkxBZU7NFXPqh4LQKWTUS/1ju870WfzNOmXfjepnA9MbBimQkTLRyUyCoK3ebtuet9fdIXL2W4+7E7Vri0Chn/Uti54UzuPRR7g/57ArHuHVuqQqQLpoM9DRX0DCSKTFT8tRor+KICPRsi/yU1InWGnPN4kOErwNcWU9/yRyxS4kyhKnyNv4/567JIxcHqAk+dYZ/IpWOJh9isUsTGTM96ikTOWgcOonTUBHULxkc7M7Jhx5/YHq8G26uQ5MuMi5JqUKHWk5MdfcLo+KAkFpMRnZrBaoYVMG8KRHLTxFQZMce7MXhXz18dFsqZxGvgWpWh4NvVGcjerFE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(11063799006)(56012099006)(6133799003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0tncVUzUXhuR0ZHeDFEUWFPN2YxV0lYaFhISmY3eURTaEI2c0QrV2VOdU1R?=
 =?utf-8?B?S3Jia3lCUmgrR1RIYmZtUUlKanhvMWZrUTVBZ1lzWURMV0VTM0kwMU1KUmZR?=
 =?utf-8?B?UWxsYXNReWQ2NjFxQzYvdlFHSFVDb3JNckJKMDd1RmZ2QjFNT2JEaFcvY2h6?=
 =?utf-8?B?MzdqdjRLSWI3VkQ4OEVkSUhvajRnUzFhcVh3STFpTER0OVdnKzFHOFZqQy8y?=
 =?utf-8?B?eGgwOThlNU9JdVIwb1Z5b0xWT001TzlJeWF1VGFkTzdTUGZDaGpJRVlGRm15?=
 =?utf-8?B?NnhOblBkWUV6MlgwbEJJaTJTNDZCZ1ZWdXEya0ZwRno3MmkrN0RTOGxIZFJt?=
 =?utf-8?B?eVZ6THRwN2tkTVdHTjg0c2Y1WmNiYUE0NUtFSGx6endOQVdxK3RvUW02dlEx?=
 =?utf-8?B?L29PVkNucjNVU1dkNXcvNUpNZUNWM29BYmIyOTRoaWZnTXRPZlYzemlyd2Zw?=
 =?utf-8?B?aklvaVM5ZXdCQTZUemo3VElrUUU1TFR4aHFseldQZnNvZ1JEdnZaRkFwK21r?=
 =?utf-8?B?QVptZUd1UERkL21Rb2dGV2laZStlemVTN2Z4cEtHSDJzdUxZcnVDWFl3THdO?=
 =?utf-8?B?eHNNWFNFZ2xXWlRPb0NZd2RFU2RRZFpjZ2VBTWswWHFZMnRFV0xSOVhxSE9I?=
 =?utf-8?B?dFlPZHd6Z3lKa2VkTjNaS2JzcDVqMGpoeGRZTy84NWZIYU92RmNVSk1nK3Y4?=
 =?utf-8?B?L0ovWUtmeVpiMlduK3dUT1UzeHJUTStDUFNjdlZ1NlVVN0Zta05TVFFrZzhm?=
 =?utf-8?B?RlpOWkFXVlUxTU1RY3dvemVTNi9TeEV3UktnSlJjTUwwTlUrZUgyRGVUS2ww?=
 =?utf-8?B?ZVhvb1hjYVd1RUtmYUo4WEVReTVpa0xETS9aRzR2bE92NWJGNWVZOHhMcVY2?=
 =?utf-8?B?eUtDTTF0U1VobitINEJENW5yUlVxdmJPOFNEakxENEpuR0pRdG9ROG03Mk1s?=
 =?utf-8?B?bHdPTlNEbENNUVlONllUUHZRc0ZNZFp5TTU1dmpzVTh2c09FdWdkdng0cFp1?=
 =?utf-8?B?anIvZCsvU2RqSDhoQURyYlArcWxRc3BLbUdxR2xLb3E4d0krOU1mUnFFaW9s?=
 =?utf-8?B?NldpWU1zVmtaMFhYZ1JhbW1hamJLZVUwNG5veExOL2czT1pDTkFPTktYNGNB?=
 =?utf-8?B?MjcxOWc5cFJvUTJnTjhCUDdhMEl1UitUZ3JkR2lLdWY1bXY5TmpLQUo0R25S?=
 =?utf-8?B?Q3VHZitXZlBIZ3VFaDFOYk1aNDJnVEtVZnFyZTlsdWJ1dFhyeklIVHlSMlNQ?=
 =?utf-8?B?alJxWjN6UFErYW52NGY3OXZRUzczWlRjZ1E1K08zSzcyU1hmeEtHTys0RlMv?=
 =?utf-8?B?ZzV6SVhmREpEVjlDdFdIc2NsVnBiaXl4YzN2ems3UTVRaW1jTFN3L1ZkR1RT?=
 =?utf-8?B?SURYR0cxc3A2dmpmY3Y4TGZ5bmEzemkrdzVPYjh0K25pWS9EUFZGVDRmeUpw?=
 =?utf-8?B?S1dKdFZBZU5kZDBtVk9mblBoblUzM3RTNVF6NFNtVHFZcnRHdDdVQVFVTlVo?=
 =?utf-8?B?ajFtMmxWS2pMWWxqTkM3dmtCb01lYzcxeUFucUFERkJXdU0vZmVqeEV4OS8v?=
 =?utf-8?B?VkFGZkhZK29RSEd6eFRrQVRTZjdvQ3cxYlFHbEh0RTY0bVEvOGVDekE2ZHRG?=
 =?utf-8?B?eUtUbTRMSk1CUHZMSXZ0d1JMbmdhWjJGaFpEMFJsdzJSN1Vaemd5YkZkMmhI?=
 =?utf-8?B?R0JmbEZlSFVjdnNKRzMreXh5aWRVNk84TUdrblpqQWhnN3ZRVVJqcU1QUkNK?=
 =?utf-8?B?TnBVV2x3ZmlLMkQxRnR1aUFObWYreHhLT09CQWlkbFloRG1tQ2R2cGtWelg5?=
 =?utf-8?B?M1k5S2JpMXo5SFo4WGxJaEd1WUdjZ0p1Tkd6bkQ1amc5cW9ILzlnRjVCNDBD?=
 =?utf-8?B?d042L2pRelBUbjNoRXl0cFN6ZTdaTWFDK05DWmNQTTBvamVWdFczZGlmU3FO?=
 =?utf-8?B?TWFqbHk5NHVqWU9CVUV3ZHRxY1owNTJLQ0srK3VOL2g3eHNQU1JRM05uczhn?=
 =?utf-8?B?U1ZoL0RBdHd2OGg5d0VvWWgxeHVNMmZ3b1Nsd2VIazBRV1p5Vkp3ZFZqVXE3?=
 =?utf-8?B?NGpVcit3VG5IL0FHV2VzclN0VEREWTdUaDROWktSbEZ5V1NxK1Nkeld4R2lM?=
 =?utf-8?B?aFcydnhQR0JJYm04TFNpd3pvUVZNbnNZTlprQWVpMlNMUTVsMVJNZWl2TVRX?=
 =?utf-8?B?eU55TG5NNkVEZ25RYXVNVEJ6R1JOWXJwMEVobnlicDdkbUF4NlFiaXpXN1VQ?=
 =?utf-8?B?TGRDaHdLM0FYZXoyVE10aEJ6dTh5QUJzVWZoOUgxQ0x6cHhwRmFUeUY2THBL?=
 =?utf-8?B?Qks5NllLQ25wUjRJdEZUamU0ZjNsSWNkRVVwU1VXaXdqM3hqOFhUZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763596d9-4080-44c1-268f-08debc8c18d8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 07:38:23.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJdsy4tFlo/F+nBSJsNfoVAKzpe3scDcz0lCdIpiFEanQRiuJkpWr+2i3ITyn641MzfK796NDPNF/+s602Anyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3559

On 27.05.26 16:07, Florian Bezdeka wrote:
> upstream commit
> b6420bd5aa0c ("gpio: remove of_get_named_gpio() and <linux/of_gpio.h>")
> removed the linux/of_gpio.h file. We now have to include linux/gpio.h
> and linux/gpio/driver.h
> 
> This patch has to reach all Xenomai branches that should support
> Dovetail 7.1 and newer.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/drivers/spi/spi-bcm2835.c        | 3 ++-
>  kernel/drivers/spi/spi-omap2-mcspi-rt.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/spi/spi-bcm2835.c b/kernel/drivers/spi/spi-bcm2835.c
> index 7c3568d582dd24ca7686f6438907d12e15401187..b9c3a19f0bd55c77430c68f6689dae3364be2304 100644
> --- a/kernel/drivers/spi/spi-bcm2835.c
> +++ b/kernel/drivers/spi/spi-bcm2835.c
> @@ -25,13 +25,14 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <linux/spi/spi.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_gpio.h>
>  #include "spi-master.h"
>  
>  #define RTDM_SUBCLASS_BCM2835  1
> diff --git a/kernel/drivers/spi/spi-omap2-mcspi-rt.c b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
> index 88c5132b869f46c76efbf3e709bc7e7ed98d2862..fa56347b0d46623a854a0f668e587bfea888e8a9 100644
> --- a/kernel/drivers/spi/spi-omap2-mcspi-rt.c
> +++ b/kernel/drivers/spi/spi-omap2-mcspi-rt.c
> @@ -23,13 +23,14 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <linux/spi/spi.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/gcd.h>
> 

Did you study which kernel versions would require of_gpio.h? But I
assume that at least 6.1 is fine with this, and I currently do not plan
to expand the kernel version support of 3.3.x.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
