Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F709448
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 17:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4pm4AU7ECyAwIXhroUokcO4KUeuzijoPNfZJ0n8HPO1798+2CLMWfp5YUbrRoh+DGQTRUo+6iUifl9pdQJWJJx6skRdasrB8bigZLSNCDrbM6mRsMNPtyKb7jUI4H6niKa2ovciH7DVtLw8mpennZy8LxBEq2jCQlN+IcoeklXnq3pjkuGzf3Ck8XMphAH9ICGwgKv/5NtAxr4/rWsnF0Xc2Jia8pt6fdRGbLV3zyYK7qTOPHOCQ0yRzM1x/31G6fTPdUN3ZWlIPPX6HcP6TW65+CY+D2iJR7YwzfvEmmjF/9kwErTtdHkas8YJbFUhK9L+KoEX9PMSlxUqeSmO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2DNyLbN7OCe8Y0YD9KBkSSuzvow3V2AtLw+FzizI2A=;
 b=K2jEUcIGhVJ5bgqjdaezi0gn0K8Mi25CSssbzlSEg2rz+WiUAEST8peTN3zgbJ5rwoj5HQGUXmXkNI7tmjLpGBOO2k+bUXrUTdtZflnwpDqvKWW1SVO2Tz0OjLZSzkoXBcWO0c1xzeynFj7xAg69eHZrJ0xyVm9xn30o8t4TYd+MFjscV5hgx97JYb+j+WXtIijIOpMd5gyUeUsCLozUCftt8LgdzDmR1ocTFqANDHQRB6U/7kvyHi4FN/myQ+Iqj7zVclvr8RqydW+3fpcD4WMAp+aWtMOZCk+WGj2CmSTgiv4BWDRQUPsGIKWjosAnuU3oqRXW5PlNgB+uvdrupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2DNyLbN7OCe8Y0YD9KBkSSuzvow3V2AtLw+FzizI2A=;
 b=f3r8BxRN/aPRfDQ/nlA+ciKTU3lwoXgzTnP3B5l1ibn1xLpnEI40NzrE1GUoIbug5cPgRQqwbCLaAYgZwBrgvsEwSF/vweUHsDJgPxAmfc5AYc8gvWHtLTlncI13Gjk5MkdYadcxpS5QgPCNmqYcb60F5CtdO8GACM/TKRE6Xfvie7MtFHEf2E+9THb8v/XLtG56WGVi+LJDXR9CrUakj3NbgYxROHGZrDroBYfSZLcKGevSjLx1TVHFq/Raoteik8mjosrDhA0u9dbiCxrM5G68q+sIrMgv5N8zTS1Jo2n+tdGnez8Z5NbNbwannoBk35GlMPsgR9SFbSiPHiohzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 17:57:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 17:57:37 +0000
Message-ID: <311cf304-b306-41a3-bce7-0c25ae026419@siemens.com>
Date: Tue, 12 Sep 2023 23:27:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] Enable stable/v3.2.x branch to be buildable with
 6.1 kernels
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3144:EE_
X-MS-Office365-Filtering-Correlation-Id: aacffef4-12d8-4799-6c5f-08dbb3b9bfd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V/aOfsxjgTl27f1Evwhl2/GXcUGt8xA3c+mQogk/2ju5fMObgRgv4ev+CH23JfZAlj+v16rdn7wDcaqwJy43SAKABgj7yfTebzyI/gXNve8YivZUWePXJazVn9KfK4EDuszNEYI1D0UWJOxtHQHZhG/UP1Csg2JTnXsck4xC1zywyof1odaPdTTZA5yCxgpNeO1SgWgiAMB0JRG9J25J2q643inYcq7wtRAPQ8o4ccp8rWXvN8z0BQQYElJXYOVIpYtccpLX4BlHX9y1g82zpzlSkGz00CRq0/qoag0t0GFMVf6q4xGO3anLkJa1SBz0cAyTI3E7tKgmpcVyIgvSxzA/IHemoCraZQjpfbhKDvLk0ScgOWCgxmyB6Frt+Zw8lJl9WcsbBilSIdpz9oe70K1t8NbV8gF/jc/H995fQyxgyZFg1gT9T5mDKrrgpzlu65A8bL9AbW6enfYNhSP2D5L/0Mrr6DdPbo6wd+6p4vpKVylr4icMXfusiEKS/HacwpPuvI9b4x2KmBq3f2wpZ+klnGuEe5o6ceEy5Kvk6Jl5CJhp83+2h1XzWRNCUXgEZNoCLyQnKJ/Qi1fjl9hG7Mg2IheveY2s8eHFhkkh0zKDZygv49nLdERrDgJ1XrN2x+gzGOR5pGYlQNfTAh12cw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(451199024)(186009)(31686004)(6486002)(6506007)(53546011)(6512007)(36756003)(86362001)(82960400001)(31696002)(38100700002)(2906002)(966005)(83380400001)(2616005)(41300700001)(44832011)(478600001)(26005)(8936002)(5660300002)(316002)(8676002)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmZ3Z3gvaytjdWZ5elg1Y0M1bnlpWXBIaVpsREo4clAvSThTRFNUditUWjlr?=
 =?utf-8?B?Wmxvc1dYU0IzSHZQdVJ1VmNPbWl0NTdsbnpNQW1vMVBpOElSZ2JneUw3Nm9q?=
 =?utf-8?B?bkNNYURZQ25RZk1NQVN3Yk54b3RPTkROZUZHYWc1VGJCNDJzb1JkUjd2Vitp?=
 =?utf-8?B?SWw4R3VpR1QzOVBGRUFNMlFjd1A0MUlvNE1ZeHd4Wmx2Q1JIVWNrZTAzakdV?=
 =?utf-8?B?SWJZRjFRdjFubDZBSDlzTnFKUGpvc2RxRTlTOHducVBKMkY2MGMzNEdXejdk?=
 =?utf-8?B?QjNqUmRwMlQvTlZVdENyVWcvSUxFWnpFR3BGNjhzMW42d3IrWGNlSy9tR2Vn?=
 =?utf-8?B?bGsweTdyR3Ivemk4Nk1ET1VzaTduSmNVMlVZZURUaTE4ZjFLemYyckRvSDVw?=
 =?utf-8?B?NEdkS29Kb2N1R3NqeWtwcWVRQTFvdklrY1JjYkozeXJ2Y3BESVdvTlAvS1lT?=
 =?utf-8?B?c2dVUXNJQzZtUUxSL0N2ZS9td255elZlY2RLTHQybkozaklKV1BpY1BiTDc3?=
 =?utf-8?B?dGExUUQwSkJaV1JmV2RNUlZXbUw2SnJSUy9ZcFV1K3AyZVB6S1VTUStYVktF?=
 =?utf-8?B?SjNENURNVHIwRzZneEZxL0xJUERPOHFkVWJ1UFc1eEdqNWowaWZFZzdKcTFO?=
 =?utf-8?B?NGxIekJuYkRSclU4Zk9rN3ptNzVwNS9KN0dwZGNpd3l0blhrSVpLMWJhdjl0?=
 =?utf-8?B?YmxMZTZUUjNDYmlISm13OEFxUEZxTUxoUkJ5L3JvandsZDRPM05GKzRXL1pX?=
 =?utf-8?B?N3RWdlprYURvVUViS0xLWXpPOStMcVBEYmdCNWMrSGwrRVRIcGZzVDQrcEly?=
 =?utf-8?B?WGhxc2ZEdUhLeERDaUVTOUlIak5KL1QrYzVnbDJnWGtzeHo4OERGNElhcGZm?=
 =?utf-8?B?aXp6NC9uRmV4Y0k2VHQ1b1FkMVBGM2hYc0FIOFEzMS9tY3luVEt6YnQ5clg0?=
 =?utf-8?B?N1hWU0d0UzE4VnV6Njk5cFFrVFBEZWZpUnVyOURHcFZpdnM5d0haZ3p6K1Na?=
 =?utf-8?B?SGNianh3Yi9jZmV4WFNXZjFVb3QxRytoKzlBdXdkK3ZnQjN1c0laOEhzMEJt?=
 =?utf-8?B?NHdsVEFFSXhTUVpscVc1OHpSOWpFNzhtdlZNcWFPM1RQOGRHMjBRVGpKRENy?=
 =?utf-8?B?WlhnTU81cTFRUUhmRC9PVG1jMllTbW83ajJxZDZuakJTQnIvSkQwcksrUVF0?=
 =?utf-8?B?MU5RbDl3WUx5d1BXckFKTWtTTHFyTU5JK1R0WnBnRDc2L0NqNlcrWmNwRUhG?=
 =?utf-8?B?UjluKzJPMFhvaG1jalhGQ2RBbzhQUDdqL21kR3pSZEFpK0dKaERLaXRQVmVS?=
 =?utf-8?B?aUpXTVdEa2g3TUwvOStCdFhQVEpXR0k5ZXhhczZPVXBDd2ovTTl2eWdXUDd6?=
 =?utf-8?B?N3lHSnQxeW95TDZ0QzhKNkQ2akRUc2t6LzBQSlVzMkNXcjlGK0pKQ2lQLzl0?=
 =?utf-8?B?WEFCdlhoNElOaXM3d1RYUW5yVk92bVBZMWhQVHJhRWZEY1ppMGtiblF1VTA2?=
 =?utf-8?B?N2xCRlFqOHhScVF1Sm1ON2hBRW1md3FmN3dwL2xUb1Y3TzJVZnRGNUhVeUpL?=
 =?utf-8?B?enJsd0FOb0xweVNyTTRndGJBVkNJbFg4anNkWExtUE5XK1FLUHRwRXA0eDdJ?=
 =?utf-8?B?OFpzRWV0RXVCZWZjRllBSitSZnVOWHhBNGdVdk53L1RSZVM0bjBGTUU5YU9F?=
 =?utf-8?B?RFRFcStzcXRXNkJDQ1lFb0o0UVk3T3hSKy93WVVmSks2ZVdrT2JFR2xCQ3hI?=
 =?utf-8?B?bzBDdXk0anpKQXo4U2htNWZrd25BZWxtZnJXcWRJTlNxcWp5REZCUWhxYVJG?=
 =?utf-8?B?Z1krRHhFV0lFZ3djZE1YU3ZPdkpXaTNhOGZ1MGN2Um1yT2dkdlBja3E2K1Fo?=
 =?utf-8?B?TmlELzNwaGI1bHBhOEFNcGRXZ0dnSkdzWEFiQmZ6Y2hkOGplUnhMS2lYamI5?=
 =?utf-8?B?cjJBRGJQR0pBM0pjLzhiVWgzN1IrZ1BvdG5CRHorQTE4ZFdOWS9oSkZIbk5i?=
 =?utf-8?B?d2VPVnpJdjFOSTIrakwwYjNxdVhWVkpKWWRBSnlJMUFLUGN6cFBJWVhibVJD?=
 =?utf-8?B?N1I2U252ZFNmeW82U3hLQ2hoNHNzVS9HbDlBQTZCbUp2QnIzK1hOT096V3Np?=
 =?utf-8?B?cDRJK2hreXVXUDZNQXo4c3dRbDlGaWQvOUYyZTR2U1Y3cHY2bGtNc3I3SHRM?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacffef4-12d8-4799-6c5f-08dbb3b9bfd4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 17:57:37.3046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o46vgZDcN6difUA+tz0Tmh0vNzm6v2gEliBG7t7ojrSaajjBw7cdHD+ff05pJlcDzYzeEB3QZ1R5hDEY5+2ffg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3144

On 02.09.23 01:15, Florian Bezdeka wrote:
> Hi all,
> 
> with this series applied the stable/3.2.x branch gets buildable with
> the 6.1 LTS series of Linux / dovetail.
> 
> Most of the patches were taken 1:1 from the master branch. The commit id
> on the master branch is mentioned in each patch / commit.
> 
> The last patch is a manual backport to support 4.19 kernels. The
> referenced commit in master did not have to care about such old kernels.
> We already stopped supporting them in master. Please review carefully!
> 
> Best regards,
> Florian
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Changes in v2:
> - Folded backports into the patches that introduced the need for a
>   backport
> - Link to v1: https://lore.kernel.org/r/20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com
> 
> ---
> Florian Bezdeka (5):
>       drivers/net: Switch to dev_addr_set and eth_hw_addr_set
>       drivers/spi: Convert to GPIO descriptor API
>       drivers/spi: Switch to spi_controller API
>       cobalt/pipe: Allow building with kernels up to 6.1
>       cobalt/x86: Allow building with kernels up to 6.1
> 
> Jan Kiszka (12):
>       Account for switch to pde_data in 5.17
>       Use linux/stddef.h instead of toolchain header
>       drivers/serial/16550A: Account for privatized defines in 5.17
>       drivers: Convert pci_set_*dma_mask to DMA API
>       drivers: Convert pci_alloc/free_consistent to DMA API
>       drivers: Convert pci_map/unmap_single/page to DMA API
>       drivers: Convert pci_dma_sync_single_for_cpu/device to DMA API
>       cobalt: Resolve cast-function-type warnings
>       drivers/net/experimental/e1000: Use fallthrough
>       drivers/spi: Account for dropped return value of spi_driver.remove
>       drivers/testing/heapcheck: Replace prandom_u32 with custom implementation
>       drivers/net/pcnet32: Adjust for kernel 6.1
> 
>  .../arch/x86/include/asm/xenomai/syscall32.h       |   3 +-
>  .../cobalt/arch/x86/include/asm/xenomai/wrappers.h |   4 +-
>  .../cobalt/include/asm-generic/xenomai/wrappers.h  |  15 +++
>  kernel/cobalt/pipe.c                               |   1 +
>  kernel/cobalt/posix/sem.c                          |   2 +-
>  kernel/cobalt/posix/syscall.c                      |   3 +-
>  kernel/cobalt/rtdm/device.c                        |  10 +-
>  kernel/cobalt/rtdm/fd.c                            |   2 +-
>  kernel/cobalt/vfile.c                              |   8 +-
>  kernel/drivers/analogy/device.c                    |   2 +-
>  kernel/drivers/analogy/national_instruments/mite.c |  12 +-
>  kernel/drivers/analogy/national_instruments/mite.h |   4 +-
>  kernel/drivers/can/rtcan_module.c                  |   4 +-
>  kernel/drivers/can/sja1000/rtcan_sja1000_proc.c    |   2 +-
>  kernel/drivers/net/addons/cap.c                    |   5 +-
>  kernel/drivers/net/addons/proxy.c                  |   2 +-
>  kernel/drivers/net/drivers/8139too.c               |  18 ++-
>  kernel/drivers/net/drivers/e1000/e1000_main.c      |  84 ++++++++------
>  kernel/drivers/net/drivers/eepro100.c              |  75 +++++++------
>  kernel/drivers/net/drivers/experimental/3c59x.c    |  21 ++--
>  .../net/drivers/experimental/e1000/e1000_82540.c   |   2 +-
>  .../net/drivers/experimental/e1000/e1000_82571.c   |   2 +-
>  .../net/drivers/experimental/e1000/e1000_ethtool.c |  14 ++-
>  .../net/drivers/experimental/e1000/e1000_main.c    | 122 +++++++++++----------
>  .../net/drivers/experimental/rt2500/rt2500pci.c    |   4 +-
>  kernel/drivers/net/drivers/freescale/fec_main.c    |  11 +-
>  kernel/drivers/net/drivers/natsemi.c               |  35 +++---
>  kernel/drivers/net/drivers/pcnet32.c               |  57 +++++-----
>  kernel/drivers/net/drivers/r8169.c                 |  36 +++---
>  kernel/drivers/net/drivers/tulip/interrupt.c       |  18 +--
>  kernel/drivers/net/drivers/tulip/tulip_core.c      |  51 +++++----
>  kernel/drivers/net/drivers/via-rhine.c             |  71 ++++++------
>  kernel/drivers/net/stack/rtmac/nomac/nomac_dev.c   |   4 +-
>  kernel/drivers/net/stack/rtmac/rtmac_vnic.c        |   5 +-
>  kernel/drivers/serial/16550A_pci.h                 |  19 +++-
>  kernel/drivers/spi/spi-bcm2835.c                   |  63 +++++++----
>  kernel/drivers/spi/spi-device.c                    |  61 +++++++----
>  kernel/drivers/spi/spi-device.h                    |   1 -
>  kernel/drivers/spi/spi-master.c                    |  31 +++---
>  kernel/drivers/spi/spi-master.h                    |   2 +-
>  kernel/drivers/spi/spi-omap2-mcspi-rt.c            |  20 ++--
>  kernel/drivers/spi/spi-sun6i.c                     |  24 ++--
>  kernel/drivers/testing/heapcheck.c                 |  14 ++-
>  43 files changed, 542 insertions(+), 402 deletions(-)
> ---
> base-commit: ee85e330c26c72974d57d4130c24e3369f1d85c4
> change-id: 20230828-florian-enable-stable-3-2-for-6-1-c0d84de8ff55
> 
> Best regards,

Applied to stable, additionally taking

- f13c59a957f6861095dd97ee4faaa45667470f9f
- ba1c3f30999b189ef19ee4149cff31490d7d9508
- 5c838f761a8336d53f1cd7dcd1f6a8fdc94716d4

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

