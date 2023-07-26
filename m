Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F11FAE
	for <xenomai@lists.linux.dev>; Wed, 26 Jul 2023 05:21:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uc7V9dO//h8RHLHb85ufUnSNHiq4ntx8pZJ5s1dyFTU22uf4hBlIZGEPaUhN5XIHj9gQUtVkdBx9u9I2XyIv1ngSu163tcHR6lU9CKxUmfVdVAXNa+WYiVsF0YMr+SxLwWDjpCtfWf2lCoWv6NDwSKrZyFAfT5hWZgyF/l9XpYldLl9LpnDrhKTEhk2NscT2SP0A/oytORS6EpJE/NLsbZzbSdS4wXdtmcEIaX9s6cUdW9N3pMo36KYExTM9MdpOziz+/jNFifktCkbyoVQPEBVgmavAEPhjqZOtNJeIj/zuCR5DGpmofcCG9PUXPGsaLxf0EEJyTK1ROVQAGk9QiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC2RFvzfLHVMYMGNmI9zbGA8LlYr3lXSWKPtc5wcvnw=;
 b=GN5iQAvVf2wKqnEY0X136LJ8M0l+69JkqmcKrQ3cmdPwN2PVOmWylalW4WTwAg13q82eF3INgqTlbHgMYmqaI+jl62FTM8kzPCpwNYbRwpDqPcZmzfBmQMIPqCgQwlx4A9V+uaM8bTr9kwm3crOVxXrUWKzWtvImSz06oXY1si1nk3nNgW+Rl9pm7/XoZVY0pUZ5dBuoR2vPVYgLAhM2cuFwQyVcUn7Lz9ymnRja12v5H9TUh/5RL+38vgDwl0IEDs3vLPoqyHWVbh35uF7laq/c62KXOzdHcuDj9393DQnCu8M+Pnsaz6/vixLBR8UAr6IokubaiKxez1g4NZev3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC2RFvzfLHVMYMGNmI9zbGA8LlYr3lXSWKPtc5wcvnw=;
 b=iJgyK7/e3iEp+UNxUTGjEtHJD/Ibg3KazU+8+oDgB++7WEfdQMylk5UL+hzYBolFJ7AApIq9cAddVRFNp+eK6zDn1/LOQdwugsLy3z3ddMaeFojdzSpVCmqlIeDESrgvJp/prebpTivfCZAb4+GKwa4GaqS9G7T6OqbKVLBJTFfXmEp8Xu9dygXkukTnhXxMdnDcSe0spwBM1eKpv3qZYv8JuntPyihhhGyrErp9K/mAgRjBdJPhqvpuMc22pju5Lvxc1EsEnaC8y8C9xi6BbJ231e7DVRtgD/ZOGmkUx8DOUbO4udK4m4aCcbWNVZ1OkdBPOB2jEsXSeGN0PExCZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6080.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:571::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 05:21:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd20:71c1:832f:f633]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd20:71c1:832f:f633%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 05:21:31 +0000
Message-ID: <c3e556a7-5985-71c5-26d4-6c60d6bdac80@siemens.com>
Date: Wed, 26 Jul 2023 07:21:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [xenomai-images][PATCH 1/2] linux-xenomai: Fix SD card boot for
 beagle bone black
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230724074035.81965-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230724074035.81965-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: e14bc27a-0760-44be-0b7a-08db8d982b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xaL3Ctfqy609nPu9kg8c8PbKeDm3yuWGTbPXy/o0z+J4mqLWxE2xLyPmIopw8pn0dV/SO1vOCrxN9oufiKmgAZP9sNQsqUXsCvd88CBJA2geHy6cH9WxEyr5D/WGFLJxYFDuyOQAmhn8peanMB8BKr8pEF3FXrQS14wCpcbPiaYDqcUwjjSZvx03u1D4KBFyaJEl8TkD8ozyP5RoAOjxnaH4+9eD3wkEUmFTcHoKM4k63xH1yIvmqJPGzg6A8WoVdBzSbrs8MkNJQ/rFZLwmMQIJMbiMWAtBZSO0fJiC1hnOspq6zj8Z9wAEbRS1EiN3wX56T0EAhXb8vf9fSgpWbi5u9kZZ6O5Oyt+5+dZliZqNwCh1anxIGQtp0iGaP0TYdN7l8Ovjfgc7jxgR9CNbbaYgpbjcIy90tneknBA28oZWl57CTOJDp5p/2uA9Eu6df3IzezJaIfGbrg9x1AoFKWJemQyqYkg7ZXNtR9bt0ZHlkvEreZ0bSOAZKBRMX1Xz6AwSDQXvUFSPUufNUj8p/qzgFt3s+UwSwKLQ50LwRADH6QWBjSP3CjTU51BIgxzThEcrd/7j6KIcjKwFgUnH5qlJtD6bP4PjQzLgMblpEYnkn7goeWv/mo+0FRCbTuLSRpJH8feGGRASstblJLJOeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199021)(316002)(53546011)(6506007)(26005)(8676002)(8936002)(41300700001)(82960400001)(478600001)(66946007)(66556008)(66476007)(6512007)(6666004)(6486002)(38100700002)(36756003)(2616005)(2906002)(86362001)(83380400001)(31686004)(31696002)(186003)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXJIeFZjUVI5cnk0YU9aUUhHZDBORmJwZzZwYUJqUmk4L3RKTWRRYlplc0wv?=
 =?utf-8?B?Vjk4ZlBRaE9Ta1JEVHQzRkFlbzdCWVBSRXVOQ0lIS2VKVm9YRjF3YzNRcDdG?=
 =?utf-8?B?UlJFajBhRDRVcWxkQ2lLK3EzbHdVd01CYmNsL0w4Y2RNNUh5bXVlZHcyaXpU?=
 =?utf-8?B?d0k1ZVlIOGdCbWJzeEN3Z2lRZVVIL2lBRGkwNmVLbnpHVXNGMUhTZDRlejA0?=
 =?utf-8?B?OHJtWVdONVcralduc1Q4b1IxVGtoWmJSUVlDbThjdm9Nc1M5K3pGNmZ5bEx0?=
 =?utf-8?B?MmRUb0pDeXR2MUlNVGZ2MVBuaGZLbDdDZmR6YTRJUjhiaklsbDJOU2pjT1hN?=
 =?utf-8?B?Wk1RVlNCQVBZKzJNL0tacWpsanRLUkF1TytIakphZjQvZlZrM3dlMm1DSFpS?=
 =?utf-8?B?bnZWaEswaFQrQzhNVVRJTVZGeEV3QnJmU0dYRTZuUEovbDZIWFpIVm4zRi96?=
 =?utf-8?B?NVJKWFd0NWxVdXdEK0ozT3o5bWNjdUEvQUZiUXo2MFBlTVlnYXVBcmJIZlhV?=
 =?utf-8?B?ZFR3TWtHbGlBaEw3Zk9xdG1rdE5DL3ZGY0tzUEV2OUs2YmN4WEsyTk1WZkZ5?=
 =?utf-8?B?ZnI2ZHp2QVBWbjArWTNkekZ1a2VJaUQ2OWNlMHBTeC8zYUMrWDFicUpvMWpO?=
 =?utf-8?B?bTFuTUhrbTM2Vlc3akduSHhERkdhOVFlMVFkU1lveFZxL3NQd3hoTlRsKzU5?=
 =?utf-8?B?NmRZRW82OFFUeHlWU0RyaGdBZzlheG9mSkx1bUY1TDU0SHhJTXk2Ryt6M3dW?=
 =?utf-8?B?NEV1cWNxUENzYURVQ3Q0eldZNEhGbVVlY2FmVXVjUXlodUhHZ2JTMmh5VnNM?=
 =?utf-8?B?bllrRm0xY1hOZGwwVStTTDZNcTBRZFdFa2Z1cmVYMkZ3dXFESkFTS24ydVRS?=
 =?utf-8?B?VWZNOW9STUdOYVZFVXRiS2l2SGFvdllRNXk3Vmk2RW9qOEhQd0VFMFB3VXpZ?=
 =?utf-8?B?MDcrRXFwN25UQ1VWWlRBaDVndCtVS3pWcy8zcVR1VUt5cUZGK3k1U05JaDFX?=
 =?utf-8?B?UGpySStyMDhuMm1WOGRXQkIyRkdZVStqZGpSeTZGM0V0K29VeFgzSmVWYjBx?=
 =?utf-8?B?ckJ2MEkvcUNYc1JlcEJDQm1oZGtPckVvbWJlQjd5NDNOTUpvbEU3elFnS1V3?=
 =?utf-8?B?eEM0WjlKSWZzRUd4Z29NTC9lRHZGVGo3TVVrUTJjQmNMZFVFT0Y0eStzMjhU?=
 =?utf-8?B?dW1yRVppRTF2cDd4dmUrVExNRzBuKzgwOVh5ZU5GNk45NXVMMzZXNHZTcmlV?=
 =?utf-8?B?N2cwTG1KelAwN2pzMHJHUWpZRWt1SHdqVm4zMUcrNFdmNjBVWUwralE5ZFJy?=
 =?utf-8?B?QVU2ZDRFOW9wdWJBV3lGeWRqcDh4enh2WUlmWjd6dVVaY0JXYmJVcVl6TFJo?=
 =?utf-8?B?WTNtT1NkQlZDbXFkTU1OWXJGT0JPR1dIbmxQTlRETkYxT2dBcmUzd25qUnBQ?=
 =?utf-8?B?Zko2RDN6NjVDT0xwY0VZbmdHZTdpRUFiQTV0S2ZySDlLVHlMUzZFVmd0c3p1?=
 =?utf-8?B?b2VjOFhSNlEzS3RyY2c3ZkhFMEpMaWswUFVQWE1hZjg4bVhLSXZ5dnFxVmZV?=
 =?utf-8?B?ZWJUOHkwc3pBRHd6UFVwc1RCSzNURWZnNXN2Mmx6Zm83ZStLdmhEdDEwNmZF?=
 =?utf-8?B?Y3ROU0xmR3l1TFNYWEttSG1DNnJMNlBtV0xpMStXOCtnVGJUYVNOZXBJM1g4?=
 =?utf-8?B?R2dZaDl2SW5tekw3R1BYVi9XakZHemZnNW0wOUpkQzdUd2ZRQm1LdjhEVVRP?=
 =?utf-8?B?WlJFK1llTWxyZnpIUm9nMWhwUEprM1doZnRBQWt4a3E3bG4vSlVUbnNMQlRz?=
 =?utf-8?B?clB1a1ZuSytYR1VDV1ZTY2J0dkp2d1lUNTNWQ3NCd0ZwQmMxQjBxS3U1Y3NB?=
 =?utf-8?B?b1VxZjVqQjVDeUQyUGo5T3dMSWhxRDgycmdQa09ZNXFzanBUY2JocDlKL3Bm?=
 =?utf-8?B?MlNNWko1ZTFBL2szWklWTkdVTy94UTFQdjZ2ZjlUb3J4WWpyLzg2Mkt0Tllh?=
 =?utf-8?B?bEdVSDNkaXpvWENFWnQvd1ZkS3RxYStseWlvdjhWZy9FdEZ1d3BSVHRTNVVo?=
 =?utf-8?B?UXZCcXVmMThmTDU0V3M2SUM5REFKb0ZTQU9CY1c5Z0t6dy9DZWgzbWtxVDho?=
 =?utf-8?B?amlyTm4xWmZrd2luVzdhVzJodUw5eit5dXFpQnp1cC9iUmhTMjRuZmRTc0Vz?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e14bc27a-0760-44be-0b7a-08db8d982b97
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 05:21:31.0000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxkWpD1gQyGnRADoMFPt6x4XNLJx4cZt7eJDOzfiT0Iigja13UKnlzq8t5it1jCQwBsQik7dNb5UR4RwJ+NlQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6080

On 24.07.23 09:40, Florian Bezdeka wrote:
> The sd card boot was not working due to missing driver support. CI did
> not recognize this as we use NFS boot, so no sd card inolved.
> 
> While at it: Convert a DIY machine check into a machine override.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  recipes-kernel/linux/files/armhf_defconfig   | 5 +++--
>  recipes-kernel/linux/linux-xenomai_latest.bb | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/linux/files/armhf_defconfig
> index b9342a5..dee6f5e 100644
> --- a/recipes-kernel/linux/files/armhf_defconfig
> +++ b/recipes-kernel/linux/files/armhf_defconfig
> @@ -5192,7 +5192,7 @@ CONFIG_PWRSEQ_EMMC=y
>  # CONFIG_PWRSEQ_SD8787 is not set
>  CONFIG_PWRSEQ_SIMPLE=y
>  CONFIG_MMC_BLOCK=y
> -CONFIG_MMC_BLOCK_MINORS=16
> +CONFIG_MMC_BLOCK_MINORS=256
>  # CONFIG_SDIO_UART is not set
>  # CONFIG_MMC_TEST is not set
>  
> @@ -5204,8 +5204,9 @@ CONFIG_MMC_ARMMMCI=y
>  CONFIG_MMC_QCOM_DML=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_IO_ACCESSORS=y
> -# CONFIG_MMC_SDHCI_PCI is not set
> +CONFIG_MMC_SDHCI_PCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
> +CONFIG_MMC_SDHCI_OMAP=m
>  CONFIG_MMC_SDHCI_OF_ARASAN=y
>  CONFIG_MMC_SDHCI_OF_AT91=y
>  CONFIG_MMC_SDHCI_OF_ESDHC=y
> diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
> index 7d002f1..e5348c6 100644
> --- a/recipes-kernel/linux/linux-xenomai_latest.bb
> +++ b/recipes-kernel/linux/linux-xenomai_latest.bb
> @@ -74,4 +74,4 @@ GIT_BRANCH:arm64 = "${@ \
>  SRC_URI += "${GIT_REPO};protocol=https;branch=${GIT_BRANCH}"
>  SRCREV = "${AUTOREV}"
>  
> -SRC_URI:append:armhf = " ${@ 'file://bbb_4.4.cfg' if is_xeno_3_0(d) and d.getVar('MACHINE') == 'beagle-bone-black' else '' }"
> +SRC_URI:append:beagle-bone-black = " ${@ 'file://bbb_4.4.cfg' if is_xeno_3_0(d) else '' }"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

