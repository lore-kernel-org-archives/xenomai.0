Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550F2ED141
	for <xenomai@lists.linux.dev>; Wed,  6 May 2026 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778046225; cv=fail; b=nrlo36Wv0YCWb32MLG9BBaBpj6yTiKxRRjx85Qulkh32ACBUTvweiDlIwN7b7LKEFYeWNtmcejI+2WJThieX9uiq6SuNWJStKmHMfcY3/Svzws5ChDj/iIOyyaVBVr62CyqN7LYLDN8N+v1ZU/5awVf2LeSyx37vCoXJ9GVi0xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778046225; c=relaxed/simple;
	bh=lI4H8Aw9mvfJHvgMqZZMMx8Db4ozuP2JXTiQFlw2skQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j4gRLtzN2cJsEg33Ay3cPZfQX/d6I563dxE5mD3N+B0B26FqMBqbpaKwQSBtLjFisqxQkhfGwA+ukc0rEZm/iWwCuqml8Mi4Ga8s/HT8qPnA6zXmqY6lBeOQWBn78IYYXXcS1oYVwCkdc6HOkl01Aeibd8duruTZ6ZUAjjyEC+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NaobNI8T; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NaobNI8T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXVefN+diXNW2/7DdfeTUnX/ju+oo2eYZOb1fOcz1s8pAo/o5Zzr20NjLGswIUdYeakeFNvDZEP8/fBpOrFTbO2d5UsCTu3aM/EddLpG/VcxDVkeR4Jzchi9k3RdxSSRwe2M7knAATWVy49CFKkPuioHCkuGhwjnhSNdtWjhdj8lhkL0+p0WuIIsIKFD7wmHm5G3gdSxVymqpKRc7mw+qckX+GP4z8vIW+NDqVfYHKpB5ehVz7CMx/K4+dd5Le9xg0qPnNQH+4C7wBfv6+jdhHJtcrFU0GTKmNPnGFUEP0p4SIsqhKTfB+kx22luPtadDZqEXtiUse24CdUTNptoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejVTqMXz2Sd0HQGYLsmTFlVBwXt2KLMVncINtu/l6WU=;
 b=i5EuVBEAVn7O0V4cbT8ALVKqgmxaScAtievCO3VKA+apb4JaWowmBylM72wGBCNGyD+DQMScU8yaxzffoWz55kkULikoMo5FfDO1/oVZTHcfk6rQlnTmIPKtAo8hNdWnj9/L4COzO6dF61g9hlxYPU9XeIYFJWS4zQhPbybW5ZpfSCeeE42bYIbDvLS4tr7LGqG0IdOxXn24VFTjyLiBtwuniHB6WfCSMFfwX9xTkHDp4zyhVkXcMPIBQvADIAhZfbYNG6505I0wbqh/jZbfUGD2QoOPV7U7nGYJrcaqk/pjNv/Q0Nr1rJOw0YZR0jSX7Uu9LlRDs2XKZShCYFaGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejVTqMXz2Sd0HQGYLsmTFlVBwXt2KLMVncINtu/l6WU=;
 b=NaobNI8TTwGT1HMasWFTx0mDC8k7d24eFgiH9X81Cc3+RlAPVbo82BJYOEbVl3wA1mmKxCfoY95HoZLeYIp2imTcfUbrb6aXohdcEWWuM5DT4Sadvrr46PlO14JU4PSpCszeswmggyr6/V1a9+1ecNLUDcUEoEzl+xYYFsLveJjsk1sAMG1uZ576dwkm9aGz+7TaCW9dn3eBegQAJlzUSPtJCn4ttpgB4oEcPVvlbTCkdSBHu49JJ3crO3GCw2DcaLPSa2CY3dh6fXx9i+hfAGAIo67LPUI1tSFePROGvyuL7ilJMD79qTiGMRh/T99Uyjo2FT0aQbWSc/4KuOvZXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:333::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 05:43:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 05:43:40 +0000
Message-ID: <ed7a0ed8-0c96-48cf-9eff-1161b9a2e244@siemens.com>
Date: Wed, 6 May 2026 07:43:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images v3 0/4] test riscv in xenomai-images CI
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, florian.bezdeka@siemens.com
References: <20260505201617.148513-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260505201617.148513-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 65da9db2-d506-49b8-7d7e-08deab326d25
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|55112099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iyhZBQjNZ5GCNrSA/UDQsam4JibACwzjdfBnwJie9Hbw71GpyYwuNt17qfevHx+3EG5dmHxrDo5LJEj8hQ0LZPfZBhGjSsH/36USS+nhbQPEYDc2/gD3vc+t413qWSop3cmp4AupSPzSo2nr81m2/AVq2CeVVF/S6N1zJfP8E6fs/waIcA6pdh9i2JU55tnRLSUKB+a8T8IAVatyue4n5q+EJL+8K++T3uVHnH65GCNdEVlqwvWQJm/YRxM6or/tzVRnXuNxbehPfrOMPIifJfsX10hvyJTcpzy+d9b77vgdGoptrTlQ/1Q+1hg8u+8MdpmzzBCpTXIM2UlkZ1n6/rDn9Nl0aIfVoZnAxL2tbMNpuclQn1RaKgOj23cRO81u9Iy+GTNLEBj6BuOyTJNm/GLyUPq5PcG5ZoI2mZQPnmAvryTiKZY2cx0bHqS+3BRjKVxCPhEiTXIgHbUVPr78o7wDq4XD1gJCp8c6OmD8Tl5W0gTmUpvawVAHE38JIwPzmLXmOGfDW+YtYWwAOz2avp8coC4IYZIGOYwflFG7EWF0CQRCQJzsKnbrfXxOPbgVwnliJjsNljYpU2WPK8R0II17TjTt3G9DkesrxwJZuxh+6ZeTuKrMormKZ5k9mEOftfIW2vXOhFVmildg240K62qRjbwbH4LxH6ntheXWWQbM1LitxeXleOAAJHJoYmNMA7CjO1aiB3EkJuifo+OEZQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(55112099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1Nkb3ZRem16TEwxTFBPQ2xBTHM0bUVKUVN5T1NKV2lLeGJud0g3T215RTBK?=
 =?utf-8?B?MitMMG5Kb2h5TlM4UTVOVUdJcWdKUVNXOUtKcmF6OCtkblZrM1JFTTZCdEI0?=
 =?utf-8?B?RTcwUDljdnpaVDk1ZjgrcmdkT3ZCL1A3SVUzRER4OVAvRHFUZDBRQlVYejls?=
 =?utf-8?B?MXlvVGFoYjMvamNZVm9PdFJVWEN4K1BFUDk4YlJFZFlpZTBhd1pibEl2cXcx?=
 =?utf-8?B?Smc1QmNkZTRFQWlKTERwaisvQlpIQTdKM0N3L0FDZEdQR29zVEdiby95YXZm?=
 =?utf-8?B?WXY3Sk4yTHc3d3FoSm5pUGljYSthOVl5YVVYK1Nld09QOGNkSFpDL0JLTktk?=
 =?utf-8?B?Y0xGTXJNYzU3YVNIOW4zTWZVU2psdnpqNEFETXdwVkx0L1c5VG9RU1A5Vi9O?=
 =?utf-8?B?cTZrcGlDK01nNGpybUxIYTMvc0pTTzdmSUovdVVXMlI0TXdCWjhmekNIZnRI?=
 =?utf-8?B?MS9nT3NNb0hFbEFMWmxsMlA3c2ZIdUMzL0ZiMU9zSVpNOXBjK0o5Mmx3U3Jh?=
 =?utf-8?B?QUlxWmswaFhNT1JxajNoUEdKZGc2aHJOOHhBd0dTclB6ZmRxbjdRRkNleGxq?=
 =?utf-8?B?djFrOWRKWk1WcXNiSHZOSGVLdGtCcjNJdFlvTTErOUQ4TlJnVWZ4bWtXKzli?=
 =?utf-8?B?aGtxYVF4U05RWEdlQnZrTld3MVhmK1FPS3VUNVZ3V2pUVDNzaXhtT2kyMTBx?=
 =?utf-8?B?RDZyazhrUlZRY2wxd2tvRlBrVUtuQ1NzNHF0ZWtmVDhsTTNMQ09wYlAvVTRW?=
 =?utf-8?B?cTJUcllkY04wOWJhcFR4dVZXU0hjUi9sd1ZubEs3bVkxRjRuMFdhUWZyRHZk?=
 =?utf-8?B?THRRa1NtN0p4MUpQNDRObnVNekxyY3Q5NU13U0gxaDVwaDNOK001VFY4eGpv?=
 =?utf-8?B?cVVvZGVwYlg0SklscTgvaFRHSXExNWRpWGdUZUVLRURpU2NyZTM5eTQ3U1lw?=
 =?utf-8?B?d2ppQm9wWkxzZ0ZldXg5cWUwaFNNblA4SnN3OXNSNlZKN0t5cldReitmcEw4?=
 =?utf-8?B?em5BN3VMb0tjakYwQ0hPNzhNaVBheDBoWk9sdS9RVVh0WWNzZXNZREVHZzhJ?=
 =?utf-8?B?enZRNEZHOW1oUU1lYWFxbGZtdHZGa01tOGtqZlFWZzgrZmZ2U3c4dFVZTWhy?=
 =?utf-8?B?NldVaFVFOUw5dS91WjFoR25hYmJ1bmVlTUhGNmZwcjBQWHJTVWNkOGdqN1ha?=
 =?utf-8?B?Z0ZiMWliOEN4R256MEd6TGQyMVgzVjJFZWxzNUkwNThNSTBxdTR3bmxIZGdj?=
 =?utf-8?B?bWE1QktuZkFNWnhMWEtjdXZwb1ZXRnJMMGVxSmpLQVdKMUZZd3Zvd0p5QURv?=
 =?utf-8?B?NW9sRFRUbUdtZGxVZU9IejZIcHBqbFJmMmxReTRXbHdjRHh6ZFFkY29hL2w4?=
 =?utf-8?B?bE1kUFU2a1pzZlRRUWxlNHd2WWlEd2R2NUNLVFRSRnZWREQ2TjgxL1NQdkNo?=
 =?utf-8?B?TEZIY2IyWlpTeCtVaFpTQ1NuM1RXMmFKWkhHRTZvQUFBMTJXK0s0QzhJOGRi?=
 =?utf-8?B?dVAwbnIvVXRyWm5Qc0dUS25KRG9YSnRPNkpYeGNZQ1FMZ0NpL3VsTzVkOGRG?=
 =?utf-8?B?bTRFSEJtNlQ1cmlQejZTMHdBNFFUZDROTFhQRjZ0dGVoTFltdVZlK2IyQ2Fu?=
 =?utf-8?B?cVIzdmVTVXJIZE1zOG5BQmtTTHpialBDY0hHbURFZVNzUXNGelZTSEJndWVr?=
 =?utf-8?B?WTJaT05NYlJPNlduRHl0YTZkdUQyVXUyOXRkWmxGR2IzTWlCekJLcG5uSFZO?=
 =?utf-8?B?aXh5L3JGS1JTNkk5bDlXL2w4Mkt1RE1KS2pDdnhKNVpWVUg1cGUzaFRtV0RN?=
 =?utf-8?B?Y2NwWFZ4dTJORC9RTlBXTmMrUURuRkFaOENyY1BWN0Evd3gvVTQyc2pCbWFC?=
 =?utf-8?B?S0E1c2ZBYTBnQWhiMTZnVmJhY2FxWVZHblhiYkQrd3pOc1ZOdCtveFl0R2xl?=
 =?utf-8?B?RTJPM0NIa1J3RCsvcjVxU3B1U096RTNiRUh2TWJjbVRRbE9qOFZ4Rkk3TGVp?=
 =?utf-8?B?VjVsRkRzK3B0eVM2Z1BEbmw0Z1E0bm9VZDZVWU5EVWVOUk1SRm94TWROSmo3?=
 =?utf-8?B?MUM3T2pTNlp5VE02WmJwK2hNb3kzYUpPTVA4V0hzZW5OMVNOaXBOTHJka0ty?=
 =?utf-8?B?NStkREdOS0FkSUovQXlERUhWR09LT2VLOUFwOUZTZHlxdHhrenBpUlJsWHpr?=
 =?utf-8?B?Um14czlyUmFqNW93U0l5RDlTV0xZQVpmV1NoVkRPWEJKOFlWWVl1MFB6YUxT?=
 =?utf-8?B?VVhmOUZpd1BtcFJGN0dCNTF6QnBPLy9EajVsWm5rRCtyYWlFOFU4UjZVZGti?=
 =?utf-8?B?VmFtWFFhR3h1cUR5MW9DWFFMbFRYbHVaaUZEay84SWttemFrRXRtQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65da9db2-d506-49b8-7d7e-08deab326d25
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 05:43:40.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvzgNrxSvnVelzLZ9V/X1/uXsmKESsWdLqei/xOkjCKooUtTB1fB6pafemuaM5Iu1aH7nRe5q5+vouiMTszOGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6759

On 05.05.26 22:16, Tobias Schaffner wrote:
> Hi all,
> 
> this enables RISC-V testing in the Xenomai Images CI.
> 
> It runs the EVL test suite on both qemu-riscv64 as well as the StarFive
> VisionFive2.
> 
> See the last successful run here:
> https://gitlab.com/Xenomai/xenomai-images/-/pipelines/2500187079
> 
> Changes since v1 (the RFC):
>  * Do not depend on meta-isar but add the visionfive2 BSP to xenomai-images
>  * Use the latest openSBI version but stick to u-boot 2025.07 which is
>    unfortunately the last version that supports booting from SD-Card.
>  * Use the risc-v defconfig of linux kernel 7.0 and add the needed debug and
>    nfs switches in additional sections in the end. Factoring out the snippets
>    for all architectures can be discussed in later patch sets.
>  * Only run the tests on the qemu05 runner (tag: SIEMENS_ERL_QEMU) as long
>    as qemu01 runs on the outdated qemu 7.2.2 which hangs up with riscv
>    workloads from time to time.
> 
> Changes since v2:
>  * Add information about the used board version in the xeno-lab to test file
>    and commit message
>  * Add information about the used u-boot version to the commit message
> 
> Tobias Schaffner (4):
>   ci: Build and test the evl risc-v port on qemu

This was already merged.

>   ci: Fix deploy script to handle multiple DTB files
>   riscv: Add StarFive VisionFive2 board support

This one is still lacking Kconfig integration.

Jan

>   ci: run ci tests on StarFive VisionFive2 1.2a
> 
>  ci/lib/gitlab-ci-base.yml                     |  59 ++-
>  ci/lib/kernel/head.yml                        |  26 ++
>  conf/machine/qemu-riscv64.conf                |   1 -
>  conf/machine/starfive-visionfive2.conf        |  21 ++
>  kas/board/starfive-visionfive2.yaml           |  15 +
>  .../opensbi-starfive-visionfive2_1.8.1.bb     |  18 +
>  .../u-boot-starfive-visionfive2_2025.07.bb    |  30 ++
>  recipes-kernel/linux/files/common_nodbg.cfg   |   2 +
>  recipes-kernel/linux/files/riscv64_defconfig  | 335 ++++++++++++++++++
>  scripts/deploy_to_aws.sh                      |   9 +-
>  tests/jobs/xenomai-qemu-riscv64.yml           |  95 +++++
>  tests/jobs/xenomai-starfive-visionfive2.yml   |  71 ++++
>  wic/starfive-visionfive2.wks                  |  23 ++
>  13 files changed, 694 insertions(+), 11 deletions(-)
>  create mode 100644 conf/machine/starfive-visionfive2.conf
>  create mode 100644 kas/board/starfive-visionfive2.yaml
>  create mode 100644 recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb
>  create mode 100644 recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb
>  create mode 100644 recipes-kernel/linux/files/riscv64_defconfig
>  create mode 100644 tests/jobs/xenomai-qemu-riscv64.yml
>  create mode 100644 tests/jobs/xenomai-starfive-visionfive2.yml
>  create mode 100644 wic/starfive-visionfive2.wks
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
