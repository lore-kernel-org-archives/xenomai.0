Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1923C1876
	for <xenomai@lists.linux.dev>; Wed, 21 Sep 2022 06:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoqKVFK00CERkvLLpISddXTfcItZ9b/JMyBPWMjI4tbgY5+CEqgo9jK0Ly7n1o8/JOI2G0KUKKjwlAaaF+MY1HUXvdveceFGaOtUHzj+2B6PO+OWlDs1RJYJ06QUK4AGyELcObRZ91avQE/P4b0u5icHJOZQn9bbtSaKU9O/2g3rIYtQwl9FNjstXc7EakWAQrZKnIPptd91ceLfiYTB1B0PAWMhsu7BHEkOp7JomuHTqBGk1biH3qbiGB99VAc9vbMGX/BTSj9t/WDEAdTkyNX8ihlf63FBgguUcLQ70QYYwQ6TV5pIunfL71RrN/gmtmwwLI1auj5RXfU/vHfNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noIH1pzrczCFdCURuJhy1evzzNdBE1vkmszQlPN3Ddk=;
 b=f56Su8AjWfPN5rfiOKvTFo+4LGkDuciw9wexjW0x8KFf/GvcijdCOcthf28LgwII/nPrD3HMprOwMir05yrkTd5BngLlHs5BcGsGhxsHzPJu7PTrVqFyjf2x9b+y1uRE4qvUGyB1PUoWgf+rb/7+T2dtaKlaBWOgnqixPh1MmJN429N6vy8kTe/ITsrK3a9UJAzZfGpphh+pG80oE7wXemMx6BfaJwN9u6Iw2tVaB+0cWllQbNhq42sX+UH8HZDT1n6uVdloAo8ljgFyMLtQa7WVVUiMOKnixgzi9oLgdPj/1p5MHdNVCQ0iwPZJN3tKstGgLHzLPV3I+fvLK45zlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noIH1pzrczCFdCURuJhy1evzzNdBE1vkmszQlPN3Ddk=;
 b=BByKtSR/g6N8BkWK5z+hdKcGloyZO99+CPpnaUXfDGksSZiWd+/ZDJ3eHjgzPBn10RudiV8Rzj1tkeywKazdT9rGNFfIQ330BZLmPQIxii/WLOOKmBA2fhsAqBP7tQsXFquinLQbzX1bMBd83iyxh6rRGugYsdGd8MMfNcuqSmXa/heiYN5SPoj/hfvMW/V1U7lYChMxzm8eVRBaNi4Rom1z0JyPLw+jPDNiEWpCHEHDhSn+dMblsMkPfxP2cm/wSRGCDsL24QrRGOiyQ0okv343+7qHMbueGGg4Dp0xwaT3aKJ940taGfN6Y0vFa995/HCbRBkn8NuO4k51kRuHFA==
Received: from DB7PR02CA0008.eurprd02.prod.outlook.com (2603:10a6:10:52::21)
 by AS2PR10MB6517.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:559::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 06:01:33 +0000
Received: from DB5EUR01FT089.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:52:cafe::69) by DB7PR02CA0008.outlook.office365.com
 (2603:10a6:10:52::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Wed, 21 Sep 2022 06:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT089.mail.protection.outlook.com (10.152.5.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 06:01:31 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 21 Sep 2022 08:01:31 +0200
Received: from [167.87.16.206] (167.87.16.206) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 21 Sep 2022 08:01:30 +0200
Message-ID: <2c0cff52-6976-713e-3285-f3215ac00d2b@siemens.com>
Date: Wed, 21 Sep 2022 08:01:29 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drivers/net: Make rtskb pool cache being an usercopy
 source
Content-Language: en-US
To: Zqiang <qiang1.zhang@intel.com>, <rpm@xenomai.org>
CC: <xenomai@lists.linux.dev>
References: <20220921031416.445763-1-qiang1.zhang@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220921031416.445763-1-qiang1.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.16.206]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.308700-8.000000
X-TMASE-MatchedRID: ObgwaKFsELA5QaOxwNGfvo9bHfxDWoibO5k/PxBAvv6JUlmL3Uj0mA/o
	5bNHEsCTvn1ivDdpAIflfQ4dEl5mF4HPWllJx5O/dPhh3aRUoXu1j71uqD+zcoS/TV9k6ppA4Sk
	IdSwphgbfUY2boz4kpPcwyVYGZr7IHz45mzJ+08UsH4a1ASijvcmq8U2/MJXWPaBTJyy84wV6i6
	96PjRPiNzONa1Rspx3QBzoPKhLasjWsfhGDQA5PRmGGSZ2LT4ZETQD7c8+Qlq628cXbnOhTwv/9
	UzFeXITQ5fRbB/aZHpaativxJpZNYqbv1UUAjl/LUIRG3/YCR/5/130GIFyR/lNbKGx4Q7U3WFa
	xVW7M2gZd7gTQ1EGOMhyPab4fvVvK+fbv4M7+TC1M6vEQZCbhkkjllSXrjtQOX/V8P8ail1ZDL1
	gLmoa/MpTVxbIjeBaSSluJg5SbDEgBwKKRHe+r27xehIl6Z7twfJUy+uOPzHOsfZE4nCemS/+8R
	p8DhNllmfTT0WPAJA=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.308700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: ED8F10C4528E318DEF70AB77C4DF4D3C76976B327E3EACCAA77258E94DE7591E2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT089:EE_|AS2PR10MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0105c8-a39c-4a23-e781-08da9b96bb81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZMwXeQmoGwrJXgJXF0jePuq9YCkNXn0CfxwMy99DaDOKY6bdSvBx67xpsmufVinZi6OdnCxHIpf5jZqP/JpTgb3jzasFUaPy5UkHpel9K/zr/1ROlK8vF8wZXtQO6hCoemXS6YAf6lay0lbZPc4tg+s/VDq1Qphy0zobSqWw+t7XloJUTS++10IKq5S1pcTUdkrwfvkvckhVil8VFUiP2nJXbJY4iWPN5LXtfsMBZdNJZqh2zNWYYR+aJqGJjljT8AlK+8mvZK+NkgRftK+akz5IXqeZ++fU2V364wxdyUMKzZf5zAWq04KIEvHI/3ZNYn4mnUCn3d7ilPAsboSm/xQOXE15k38q1XP6k/rU4og76O4Hycgvk94dsRhUiIP0dChzyrmgYSbxERZO3Db8OuJqErU4QPWXh5srokLYPBVxV/ZQPaxDhQB8400DaU7u4/5T60jt1JNpsB6QuRt26z/i1kHQrIFl/FZSw91sUg9PA/x3ynah2V5YRmIyN4wVGWxtNY5fkiGShT6qmF+wkQO6O1gLKc5hUFjj7eVoT+xciC9WaZqH5PxIynzNuA3PptG6vnfBHwGinUZCICLC3N7/VAtnElHUzg6l8uJ1GEoO1nE5+i/RsUSE5JlnHIacafiF4QrORiHOJKzSupRo/xxr9FHmo/KbbPz1kNEcA/yqqcymVtxg93R9nvIr9oI+/7MRlCQIyTP1XiyWnHZJz42Cv8574xLraUhEWjEHO6Ec2UIdD8pPJA1BKWbJnsZ7VWkLahdliqGzQLn/4nk0qTRh0kyzS0jK734TjPqebJHXZLYJy1xpzEJGLlIJn/A3bRC50ePL2Gv+WI/5Bcy8uloP3ng3r6V21C/IN7QEif8=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(110136005)(16576012)(6706004)(316002)(36756003)(31686004)(31696002)(86362001)(81166007)(356005)(36860700001)(44832011)(2616005)(956004)(82960400001)(82740400003)(83380400001)(186003)(47076005)(336012)(16526019)(53546011)(40460700003)(478600001)(8676002)(70586007)(70206006)(4326008)(26005)(8936002)(41300700001)(5660300002)(2906002)(82310400005)(40480700001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 06:01:31.8817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0105c8-a39c-4a23-e781-08da9b96bb81
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT089.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6517

On 21.09.22 05:14, Zqiang wrote:
> When kernel enable CONFIG_HARDENED_USERCOPY option, since not marking
> rtskb_slab_pool cache is usercopy type, will trigger the following
> calltrace.
> 
> [  594.413602] invalid opcode: 0000 1 PREEMPT SMP PTI IRQ_PIPELINE
> [  594.413603] CPU: 2 PID: 492 Comm: rtcfg Tainted:
> [  594.413603] IRQ stage: Linux
> [  594.413604] RIP: 0010:usercopy_abort+0x77/0x79
> [  594.413610] Call Trace:
> [  594.413610]  __check_heap_object+0xa6/0xc0
> [  594.413611]  __check_object_size+0x136/0x150
> [  594.413611]  copy_stage_1_data+0x48/0x70 [rtcfg]
> [  594.413612]  rtnet_rtpc_dispatch_call+0x151/0x320 [rtnet]
> [  594.413612]  ? cleanup_cmd_del+0x70/0x70 [rtcfg]
> [  594.413612]  ? wait_woken+0x70/0x70
> [  594.413613]  rtcfg_ioctl+0xa0/0x250 [rtcfg]
> [  594.413613]  rtnet_ioctl+0xdf/0x170 [rtnet]
> [  594.413613]  __x64_sys_ioctl+0x83/0xb0
> [  594.413613]  do_syscall_64+0x39/0x50
> [  594.413614]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> This commit make rtskb_slab_pool cache being an usercopy source.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/drivers/net/stack/rtskb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/drivers/net/stack/rtskb.c b/kernel/drivers/net/stack/rtskb.c
> index c9042db93..fa75ca6ec 100644
> --- a/kernel/drivers/net/stack/rtskb.c
> +++ b/kernel/drivers/net/stack/rtskb.c
> @@ -497,10 +497,11 @@ EXPORT_SYMBOL_GPL(rtskb_clone);
>  
>  int rtskb_pools_init(void)
>  {
> -	rtskb_slab_pool = kmem_cache_create("rtskb_slab_pool",
> +	rtskb_slab_pool = kmem_cache_create_usercopy("rtskb_slab_pool",

Since when (kernel version) is this function available? Can also be
important when we decide to pick this patch into stable versions which
still support older kernels than 5.10.

>  					    ALIGN_RTSKB_STRUCT_LEN +
>  						    SKB_DATA_ALIGN(RTSKB_SIZE),
> -					    0, SLAB_HWCACHE_ALIGN, NULL);
> +					    0, SLAB_HWCACHE_ALIGN,
> +						0, SKB_DATA_ALIGN(RTSKB_SIZE), NULL);

I suppose the indention should be done a bit nicer, possibly by
indenting much less (two or three tabs?) but consistently.

Thanks,
Jan

>  	if (rtskb_slab_pool == NULL)
>  		return -ENOMEM;
>  

-- 
Siemens AG, Technology
Competence Center Embedded Linux

