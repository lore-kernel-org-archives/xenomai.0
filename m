Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013037.outbound.protection.outlook.com [52.101.83.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18F43F210E
	for <xenomai@lists.linux.dev>; Wed,  6 May 2026 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778064789; cv=fail; b=qanFvLQWlwhuPwPx1lngLO20gD+LfO2ZmnfSlQA21jhC2os9Np9GLFTbGYicUNoqD0wfv2tjklPJ+a9LYVRNGWfUwEY8T0JRSvFDERWrw6Oy39Z/m69TTEptmqR7hl2lTeqM3ensW1YZLae3ZCFm9AFQQDqma2nr7zz19vYKxJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778064789; c=relaxed/simple;
	bh=3thZHayC5N0m6v0ghjBvu0XB8+ErgptC7L13ABnfw8g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fDyeqv8FZY7zBpAYG5L0ebXWdq3gu+mvJWNcKgAksteCbuvrT2vgxKDazOvVHPoZ/2hdCTdqxdzgNdRcHlBLXsWYwIB3aUGL+otd5Ou70kGb00g9skwvdoNY/bPtMjuoPL5e2/gmPHvWFhghTmH1AbX+L84+AC2EjnByN0Kb8+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hivIAGVS; arc=fail smtp.client-ip=52.101.83.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hivIAGVS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSMMhlgvezduCnbcHrK+mrl+b6osHIej2m+xtBkc4JQGx4e4J8Vt0KY2lgpyyC8bwFJzDs3PpHNO+yX/ZqwNuukwx+WVYFTtXF5k3A/ZW1G2tOVhMs4hoJh5ZjS5eNONt2yP4uM3lkP5S3q94zUSm78sOACk65Z7SjnXVM6GZj0doBz2v/fjg257ZF26CZ88wzGCBJXQm8+7wwyaH5IMgDs2Z5aeZ2LZ8JF0mrB+E4t/KkpFoLZ9HuAsTkSQQ9nCffrxELaKmZKcgppmd96XPC84Nk0/arBC60GOHG2WpzZqAJ1xy7XtHRjA/jyvdLeeSzK+EtNtDeDJeCPofLtwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHkKqNaXPrRY+R1g6LqBhJdaCshHa0mfH8Rz8gFIIUE=;
 b=X6aCVS8579LBnpKnzBP2kNmFsdgDrIBKcACcgSwPhxY2hZoHW5XP0HxX4SSD9K9Rmnc6sd7hrNlPoxJtBpDNigZgeKwwbrTG3caQBfygM813XIrRo5iyqG2WrBR0Coh6vxOjtuvKssWc/aJ3rmM+QJSY3Enzs5OOhEHoNhBEVP3O3ghaR0Lf2FaQye4Q2ORSk5AdTINziljGShWSrLTD587IqdOdghk7MKmgmuhFY5fGe3luUq8yb/4uB14aGGwfsWZ+0TviRjQbmlEr9ib467QfQjRdqOBYLKymJbWfdTXXAL+oKwCAWETkPmasEFbgY9DIo67icsZymnqsmIQ+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHkKqNaXPrRY+R1g6LqBhJdaCshHa0mfH8Rz8gFIIUE=;
 b=hivIAGVSvb+tj/ZoFq7KQOTCa3Ybz0jt+O+H68PLcqhvVVHqoecYJQ3UOqBNWuCg0PRTdt40fKGD8GlluFlgippNwDoZqXfh4kFf1FH/b/Pa/RbBFqupVTRmG5QcQYFjo8+v0tOEoxMniTC+5T7SMzPDQY1R9bTb4zklaht3WaLh7Q+u7bRvypaggqkGUp2hn23CR1ux6nvUoFOOg/US0ifwoe5VAkAryw7n5w/XlO1IDJoxEGA4mMgw9qX/6dR+XwkOCwNwpqiB6mkuoY+VDBAd9eSHAqkDfP+yHhdxDgIR/svv3p3rmvBg5z/GB+QsViiBO+A3OJECfSnDsFN/cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8678.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 10:53:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 10:53:04 +0000
Message-ID: <dd48057d-34b7-481c-bacd-6a0b33bac6fc@siemens.com>
Date: Wed, 6 May 2026 12:53:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images v4 0/3] test riscv in xenomai-images CI
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, florian.bezdeka@siemens.com
References: <20260506084142.190854-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260506084142.190854-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 20681cde-d9bf-47e5-29b1-08deab5da609
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hgG+9YLt387WIXzuIIz7MCvJ79tzptGaaIhunMzKFnYDem2dBsjuo9C92D+rRQZsP5unHqxTy71NApqeR0f3uoNBU57NVFvC4oQHoat0vWBVU3csDUg6zsHtgXtc1wold46wmNc63C/M1PnJ8XygeyToUiqMpH71kvrlgoKmYCfGb2KgdfMAGPOMmQGRHSFEmliVxCv3DQf3Ala7GtdjZUjkNCD14i6x/O46JbhTRU0OqvE3VR7ucipJcdcU5zU3cAN/tVqINpk167a+YJHQoVtgFeKkQvXe5A6C2CbxFN0H8Ksc0kB4fozHbQI+kGdIWZKBm9gL7FzwLp3j6oyZNUKLt4xs35Ur/LGVvkTGamrXdQjyyn/qzuusH2E2WLjuRVLTcw72dJtOMN7AsbrIkrC15n0D4pi0yXRQqntsWUnvyWLS3aIHSUWc20d3BnWKdyfTvaFSuFuMNxiH9pnMBBL6FVvy0Zsub/k2hFxKpw9NYwnh8hxK13dhGpSShO+ng/OZEnu4TA1OIf88qZ02WPUOqLy1XBhp533Q/5XjG7/cA0z8FDZhVo5FAfHIcNhDjG+0Ppz9IsDEtgbgqffkotlgtK+vgijQlS9PrsxQz09KrgHmc7B5OAX1i1F7Yb2Wh6+coFP/fm8/pFaTZe8ybvv+C2nfykV9Ji3b7A8s9He5yinDJbdRELuRImeqmTKIYEpkmPRwn6hc1Leo2qXkQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ci9FRnVvNGVxblZ6QXp3elNSTFl3R0U3OFJZR3lSbmx4ak1rUWNjeDNXaVAy?=
 =?utf-8?B?VnJtbTdSZzB6dTlRbnEvMlhoTzJPRXVLRUFyZkdlMFRPVFBLdGhNK2ZPbFBQ?=
 =?utf-8?B?T3pNMW94azR4QndaSzUyK3Z3UldWRmNoVnRFaVY2Qklyc2VGOUZoMC9KQVlt?=
 =?utf-8?B?TTR0K0hjczNUK2RGSlRLd0N3RG1iZVFpeUhlaGNSejRIQ2VKeVZDdFVzZ1E2?=
 =?utf-8?B?SjY4Y2J6WUJHblBjVjd2UDcvUXFRRGJnc0RkS0tJRFhRZmRlNEYyNXg2cmJO?=
 =?utf-8?B?TWgwRFJuamtzMmg0WFBITVpmV3Mrc0Z4WDAwdmpEbkF5cEl1dWJkUWhCVlFm?=
 =?utf-8?B?bDBXaVNmTWRyQm1RUXFjYTlyNUJKQU9WK2ZTbm43WmFLZVFPQnlYRXY2YUlP?=
 =?utf-8?B?RjV2Z1dUK3NmSlZqWnlzOFlpbjlBYk5vTzFWTFg5V0QxcVc0VEdxL0JmeWxQ?=
 =?utf-8?B?ZUpwbnB1bldQSzExNGV3bFR2ako3czZwNnUyS1lBbzNlenA0NjJlako1OUNN?=
 =?utf-8?B?ZlZmc0NNR3JrOVpIR0k4MzYrN0RUUG43VFRwMFVRdFRGUG91WW5qY2ZzYUYz?=
 =?utf-8?B?MW5QeUsweEQ5dlhOby9ndWdqNElaR3Bndzl1SFFVUE5IUThBOGFhNW54MnhJ?=
 =?utf-8?B?d21RQzQ1MGtVaFl4RnhYRmIybWQrVjFiZzhIL1FPOUhGSkFzdWpwbEZKUy8r?=
 =?utf-8?B?ajErUWRkVklhY3dtdHBXNnVjcjRGTVRXMzJMSmxnOUQ4SEpXVm5lRlQxVXV1?=
 =?utf-8?B?bW5iZCtEOUEyQzdSVlp3V0NHL1BDeHBxOXFIY1dxdU5pOVRUSndCc1V3Nnp6?=
 =?utf-8?B?eDI1WHNGMDl4SWs1OUZTajhycU9sT2MwVy9GcjNPdVJXSCtzYm9Ba1lzNlB0?=
 =?utf-8?B?RzU4dGtSWm5nR1crdGh3dGZRdDF2SWw0elhiQUpRQ0UxZHpsNktFTWI3OFlC?=
 =?utf-8?B?bnlmdWNKcEs3K000L3dKZGxCRFl0WG83QkM0S2J0ZjByR3FJeUpyNFhOTlhG?=
 =?utf-8?B?RUU4VDlBVHMxSXBXRnNxZkRzalFOeW0yeXVhOEhlZHBsRnpBV3FsaXl3UDQ3?=
 =?utf-8?B?Nm1xWTkwS25BVnN1ZHdrRm52eThQVUh1SEJzN0NxSFF0bVNwUU9FTXIzRk1C?=
 =?utf-8?B?citweDhSRG93T0tMZzRoT1RSNFdhV1o3aW9QOEdLWjFycVNNN0drS2RaUStE?=
 =?utf-8?B?Q0hqUE8yV0c0UmZoT3BPTHppUG5ITVhld2dpeXAyc2EwZFMvcjNZQlk4K1BT?=
 =?utf-8?B?b3JBc3FBZVJGNzl2ekFHSFBnY2h1c0ZKWk9xeEpBczlNWGFYSktGemNaTVVT?=
 =?utf-8?B?Qy8rYmxVdE5jUnk4RzZkZU5OSHFId2E4Uzhwakd0dTk0Ump4US9WblJ1aXQ0?=
 =?utf-8?B?Snd1L2dmc3p1VmpqS1FOWThCbjB6MEp0a1R1QzNZekxOcHFTTTBZM3R1dUJV?=
 =?utf-8?B?eVp5Vmh5bUQyVTdlcnhtS05MRHNDNTllT2doRTV3ZUxNRlpOK2p6Ulg2ZkQz?=
 =?utf-8?B?YWlJYmJDcE9EakJLaU5zNU9wb1BZMkhMRmkvR3lYcytqZlIweHMxWGhISlR1?=
 =?utf-8?B?blQxV3ZpdGI2TGtYbWJDdDRxaHhWdWdtTjFUMldxK3hhSzRwWmRGNXMzaC82?=
 =?utf-8?B?RjVaZVVZMlFCUWlSQlJhQjVDcGlRa3ZVeUlNR1pmV3F6a2tiRThTdFd2Z2hj?=
 =?utf-8?B?QitYS1FtRWxFVk4xUlVTMk9xNzdQcWlQemFxOVl0MSt0MWNScTd0elhIZnQz?=
 =?utf-8?B?TFVBN2daRkNvZUdYWUU1MmFmQzZPVmlXNkNFY2hNOEwwZHpQOHRmbzRQM2ls?=
 =?utf-8?B?bFo3WWR4d2FCb3duSmJKaXJsb2gwcldrSVlOeFlEK0N0RmcvQjZlc0JZUmFF?=
 =?utf-8?B?WkNSMTdPaFBhSC9kelgwZzlDNmZ0ekFjWjlYOE5NR01JTWhtQXRseTkva3hF?=
 =?utf-8?B?S29qUHdUV25NWHh3U010MHBidmJxcVpnSUZhR3BtdktiK3FQK2tlOUVVbnkr?=
 =?utf-8?B?T01WdVhXOTRiS0UrTlgwYXJrOFhWRkJGSmhSSzZzYVhxZzA5aHZwS3VZemdi?=
 =?utf-8?B?M1dhTXQzYmhYUEpSdlFKLzlLZjBkLzUzZGJGVVpLbjY5ektRL2VLbHh2bGJ4?=
 =?utf-8?B?ZFBzOGJFdUgvMTgyR0ZicCtzZWVUNUZ6clpBNUJoZVBsN3VjWlI2NjNuNXdG?=
 =?utf-8?B?b2lqSnZUS3l0bXUrK2lLeks3b1dCY0wyVHRnTGdjT29aRmJRK2VITmliMDMw?=
 =?utf-8?B?dUhtTnF5RXRzdEpsMnJ2aUM3bG52ZXlCUFBtU1FDTlBxU1VEYnRyckNxMUdS?=
 =?utf-8?B?Q0UzVHZXQzltM1VtRkVqUEV3ejhxOEtpMWhrQU9ZY2RSdUFDeU9aMjlUbkM0?=
 =?utf-8?Q?Ihmds3X+23xr7JFU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20681cde-d9bf-47e5-29b1-08deab5da609
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 10:53:04.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qt/nvc6RfdoQXmlZc57g65saJTBVlV8P5UEYu5oNkEzgdKMLNZinpeJanSsjh0G9INk/TrSfhy5Sk8n6t2ol5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8678

On 06.05.26 10:41, Tobias Schaffner wrote:
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
> Changes since v3:
>  * qemu-riscv64 testing patch already merged
>  * Cleaned up the mixed up commit message (sorry for the mess)
>  * Added StarFive VisionFive2 kconfig entry
> 
> Tobias Schaffner (3):
>   ci: Fix deploy script to handle multiple DTB files
>   riscv: Add StarFive VisionFive2 board support
>   ci: run ci tests on StarFive VisionFive2 1.2a
> 
>  Kconfig                                       |  5 ++
>  ci/lib/gitlab-ci-base.yml                     | 21 ++++++
>  ci/lib/kernel/head.yml                        | 13 ++++
>  conf/machine/starfive-visionfive2.conf        | 21 ++++++
>  kas/board/starfive-visionfive2.yaml           | 15 ++++
>  .../opensbi-starfive-visionfive2_1.8.1.bb     | 19 +++++
>  .../u-boot-starfive-visionfive2_2025.07.bb    | 31 ++++++++
>  scripts/deploy_to_aws.sh                      |  9 +--
>  tests/jobs/xenomai-starfive-visionfive2.yml   | 71 +++++++++++++++++++
>  wic/starfive-visionfive2.wks                  | 23 ++++++
>  10 files changed, 224 insertions(+), 4 deletions(-)
>  create mode 100644 conf/machine/starfive-visionfive2.conf
>  create mode 100644 kas/board/starfive-visionfive2.yaml
>  create mode 100644 recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb
>  create mode 100644 recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb
>  create mode 100644 tests/jobs/xenomai-starfive-visionfive2.yml
>  create mode 100644 wic/starfive-visionfive2.wks
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
