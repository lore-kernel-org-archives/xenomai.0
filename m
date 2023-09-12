Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41C17D0
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 05:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGuE69TjXzOlKYLpJdSYbejmL3H1J0Szq84MJL2ovLhf3gDrZYud3FNV8dC8F3gh1z/MKC2DZy2kfDlK7T8tmPEqfw6Z8aDMCHSP69g+sgN1crYbBfLtdlplv2KB3p94EpI78JZUeZuU4RP+zd8UzO1AQxho7GWbOpqkmudr2GdMYG4P+UYYNgliceOc9FkTEhw7cNH0ontCft4Cd6Ayp8X3aBuiKppADuzB694uYMdlGn/EwDncFOCrVay2QMqy5bNmpopBJAzxjGn+B2rmdEIhGdpvQQ8IDN/zaW/a0jyq1JZTQo7aDjvmp5SK6FySfnYGfjf446vXZM2tnjvPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V464drur17H4HXTgFbX1rUZX9CeOx0IPYFfiHOfgxAs=;
 b=HDqB8wJbMeGxSrjMmNF+1uTytehinsACOvOk3zCOetkgRb6KmqSpzYAU/+ue/uXFGiMcVzD+SZ8BQbcypJzoySam6R7FTc7b4slrhda3mvNISwHeYOjRq6tIu5Z6rp3KowIIFXfk35BPAwrvWUHfA+10Q0XBr5vtwHbc9oPXxccPW+nCk9ZEpNtt3Lw9p0uvDlH19UUTeDBFrVd8ePhtJLQL9JJ0mA3UitVIe8mE921nasXdltDq1RcumgNVeIiBbLmjXfiTRr7puTyWjewI+L7E0xRrO1Su5Kr8yJ8UFEJfZNNuYyZ23ImowzDUhWVTFFRSeR7tzLS0JmVysMupRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V464drur17H4HXTgFbX1rUZX9CeOx0IPYFfiHOfgxAs=;
 b=yfq+5wZVGqjmvcmSswO3PDE9mCrHXXiPa+wdFdDIMWjpqWkeAul6lVv6e5Z+834okQDVMKNHhbFUoOyJYE7KssDl4crLerzcbb5JEgoTvAtKXlm5eBbYdLtgBtYn8L5yzOHIKzqnXqdNp30vyr6o30VAaJBgXkFFwCFYvysRMw0PuQ0WNSD4TlOHcyM8tqYmFp6Z4PXpE5wTlLvCiJ4gMW7KSp8T05qRymhUc6h0wumLZerbQ06l1VxhnmwONavMpIGkveJ35r0qXastGMFHHawOeY/figoOMSJM3lnF5MF1rMkIljJwq7j17nHzWNzOFDek2tNNEGvKQotZAld76g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6886.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 05:30:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 05:30:27 +0000
Message-ID: <6e32ba16-81ac-4e6c-bb09-182f88b72b1e@siemens.com>
Date: Tue, 12 Sep 2023 11:00:19 +0530
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
X-ClientProxiedBy: PN2PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 018c6bd7-107f-4540-d44e-08dbb3515f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JXq2Qq54B3991+eUOB0gyDkPwHc59JR3cHEv7kpEvJXRfyyolc+iIoxPl9/3ciiTNZF8AcYg0MwIAwaB3qnmS4iGACrw6EptjbshjdXYP0qou2PlfHAmpa4PoNie3PHU3q5IuaPc6Juc+P2snm3+F9VPY+fNVk9VssiJJ/F+oYkHqolRJgCQqKxLbHZaU0BmI2mfOR3RyN0KJZzChk6tWNpSKOu3J/CxDabnfATPSWJ2Qw8zvx1563bxZxdk6SOIR6tE1Y4EbaR1lvi9hwS+XO/URXTKch8Wves8yfo+9MHRXsMcxnf3SrXl36rxHwHcrjvvEWG/z/C0l1hixeVK8zN05uj66vysbiGneht88SWGBrBwxVjkwReGr8/0J2hbb5GA8XWhcgfcNksVAjxFfmRx2MORALkVpSahvFawvtr8OrcL2TzsbzIZ9mzA19UtdOAG98NUkh4Lz5ODAi9Q0WFLua5ofkYnLvVqZwlpf1P0pcHGBIcG/4ZJmjld7x3qaCJBqzLkm9ZYrb3RTaTLYx2zxMJi9R5hcejuVBczubmGFoLr5cu+wGwtQahOqiDdRoNfh/MccMt5dFEeD2CnlWYJ1ycIZEWMj0sAOuG52+3C5uKU5dEihMiqueUEP/uLsurZkYPfzONmZhku0tOTRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(66946007)(8676002)(6486002)(2616005)(478600001)(316002)(53546011)(66556008)(6506007)(66476007)(6512007)(41300700001)(8936002)(44832011)(83380400001)(5660300002)(26005)(6666004)(966005)(31686004)(31696002)(86362001)(2906002)(82960400001)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXd5UTZMa05BL1kxUDg3enphTlppNzNOTmxVWVNocmdnYkFzdk9rZXNYNWgz?=
 =?utf-8?B?QmNEdWE0azR6aE95amEyN1pOdlYzQi9JRXhPNUlIQzk5YmFJWVJJbmkwcU95?=
 =?utf-8?B?UHV0a0ZCcHl4bEw3cTBDY0JtTVJnczM4Vk53Q3NjNDAwVEIyTkoyRVRmVExl?=
 =?utf-8?B?V0FiTElxYUpRSkNvUkJtTUFucGxDNlVMcDBQcmZoempGU3hNY0k1M2luZnVL?=
 =?utf-8?B?MFg2aFhGMlM0MVJIUi9KSWlWdEFra0ZHQWhhRmRFY0Y0YkUvZWg1WGxkSTA0?=
 =?utf-8?B?ZldPckxBSkMrNVc2K1JXMHFzTHJoZ1pEOUd6Y2QzaDBqd2k5WHBZUW1FYm4w?=
 =?utf-8?B?cUNTTnZIcDhjLzhYVWZyb0ZlWWMycHc4WUZHZUJrWmc0RkdEejFoTHlidEpV?=
 =?utf-8?B?TGcwbURhY1dZdnlNU2wwc0FZSWIyWXVvZTRPMUIrenJnaGFWRG43SkpyRTMz?=
 =?utf-8?B?bU8ydG5uTUc2ZnBzMU5PRVR3RzZOdlhmbUFrSVZSUVBGNTFBOTMrbnhPNWVv?=
 =?utf-8?B?OE5YdEhPVlZSZ21QUHYvSjFDdm0rclp0SW9TV1BpcTdiOGtaOFJBVGJZclRW?=
 =?utf-8?B?Q1p3Q1NWSEhiTDZYTW1VYUVNbFlvRlgya0MxaFFIUC9wRWp2MUdDdWFIajFr?=
 =?utf-8?B?T0cySlBxWGVzRDJuOUlGZVkzSXRlRE1ycVNiSENlMTBvUE84RGJrZUlQaDJ0?=
 =?utf-8?B?K0pwc0V3RkxIaG1Sbk5EUU1RUTZRd0pZeGhubWZHNUFSQ2RkNmFzNGlTOElM?=
 =?utf-8?B?QjJOUW11TzhONkJsVmpqRHp3bEhCTE1Ic0RoZUxQTzFtb3RXdDdIMlVzZFlw?=
 =?utf-8?B?SzFtekdabGlzTHdralRVVll3enk5K2l1YWdlSnUwUzQ0bDFTdkRNcjhJSzBJ?=
 =?utf-8?B?cmx2OVVKR3Q3SUtmTW5GSW15eThoVmR1enp2LzhNeEpLNVVjTnIvcXYxTnhj?=
 =?utf-8?B?MVNQWHluRk5pOVExeEN0VWIvc2hBSXBxTjBPc1FIRENKeG9tcHJpYy9vc0tR?=
 =?utf-8?B?WmZzUkVhOXdSSzlNOU5wRGFtZlE1NXNzVlQ2bER3MkNEei9JRU81WmE2V0ZF?=
 =?utf-8?B?YllsODVBdnZkajdicC9acXg4RGl4RnZhUHlZVlVkRjVuTjI5Q0c3UnFpdzd6?=
 =?utf-8?B?WDFZeStTcDRNMS9yZjIvQUd0clFOZDUzRUhaNVY1QXFtWjZRNjJTWTBVYkFI?=
 =?utf-8?B?YkpnYWlpdzRYdS9aWUhDb1hzMHloUEpmazIvQnIwWC9NWEt1eWFWZWVoQmlz?=
 =?utf-8?B?VDJvOENvYWlQa1BNMlhKSVNzWmxkeXRuenZJOHB6YVNPc0FEOWhBN0x1ZXl0?=
 =?utf-8?B?ZTJCUWpKK0w1ZGQ4WmNxdHFKOWxYNHNpTHBNMWRkaVZCVlloWURsSnFRWnRj?=
 =?utf-8?B?VlBCWFVlR3VkUnJVL25SQ01XNXlWTGlHWE4xU0VDb0kzOGJmbkJwNXVVRW5O?=
 =?utf-8?B?Snp0RVNYVjY1ZFByRUNhWGs3UzlyVVh0NndWbnJGUG05bzdXRTR4Z1JvbTFX?=
 =?utf-8?B?U1NEc0wySnR0ZFJDZ0t3NUx3bldaNjhUT0g1aU1CckR6YTFqSHRrdGtPcStE?=
 =?utf-8?B?TWt3NUd0WGNDZ1BCb01qWmR2cFRrNjdLck8yaE5VQjFLbGlIOE5UR2o2UkNQ?=
 =?utf-8?B?TVR1bDhZTDlKSjRScm4zcE5iVmt5Tnd6S1FnUUxaeEdPS2JXdllKNHY3by9K?=
 =?utf-8?B?VXRiMmhuMWZ2a3BIODJBdEtOQ1krNHJhS2d3OE5sNVp6NitxQ3JpQmdlZ0wx?=
 =?utf-8?B?djdTd0djWERWRGxLNTFXTEw3anVMSDFNTUt0cXVMUU9VdEtlbkh3enMwVHly?=
 =?utf-8?B?NlM0Wi9uenVVL0hJRDgrcTlpTW9QSUQ5U1dOb05KQkhza1p3aURkK0t4Y2tM?=
 =?utf-8?B?UlQrbENXd0NEdFU5alNmaDJpbjVlSDkwYlY0bFZGcUFwNUE5TjFxWG1DbDZM?=
 =?utf-8?B?VjVJUWJpeHNScy9qVDRIQkJGbWZQV3FqSjVNMXZkak9iTDVkaFd6U0VtdEZo?=
 =?utf-8?B?aWFuVFJnNGdta2NKb1ppOHpmdU92SnptdGhTaEJvcTlHczFPdVNER1kxSjlt?=
 =?utf-8?B?ZlRmYlNBVDUydWNyWmt2bnNmQlU4SXFaRytjbGpibzF2YnU5Q3U1N0toaE16?=
 =?utf-8?B?dXdPUm1xa0VCYlZVQXd3d2J0RGpPcWd4OHNsM1B6MS9hblJ6TnJ2TjZmU1ZH?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018c6bd7-107f-4540-d44e-08dbb3515f6e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 05:30:27.8989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmOjM4osckx2KSFS791NBlkXszrA/l0FqvmihaofQLt6jImB2gQa9fclHfr6mo/Hkfa/ABcjutH5M3uWSoTBkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6886

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

I've backported 5c838f761a8336d53f1cd7dcd1f6a8fdc94716d4 on top so that
we have CI coverage. Let's see what this will reveal [1].

Jan

[1] https://source.denx.de/Xenomai/xenomai/-/pipelines/17713

-- 
Siemens AG, Technology
Linux Expert Center

