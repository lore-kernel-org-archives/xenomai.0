Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70043.outbound.protection.outlook.com [40.107.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6941320B
	for <xenomai@lists.linux.dev>; Mon, 26 Sep 2022 15:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAITcxPQ2s1DEwxIxMkCsU+QcAL5KDohOxOAqqnKq6Kqgk3dMGd3XrsbHnd7Cb+IHV+O2PiPdufPkKHjvE8pDwx/n2cikHmRuzG55FrVh6aJ49gW7vBk19xp2iK2mCDZLsL2Jc7jSLRTBRTl0BFQoNFSsUBSuMeONeZcUHITl7RykdHMwYtEQ7ugdb4m172U396wn7kh4pYwQHcMB3Oabll6HHDL4WBQTt8OKlUaQ6IKl/l8hWdrO8FH1vsubSVmG7YKMMh9MdT5mHGOpsLAaOv7GtrPKJ44vOlVLuxOlXTcJkEJQ/q77LguJj9Mowb74kgFm6x5V2iJk6qHwmzbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L27JqA8alvXQ2H0HL+Z2FJbaiOR4Yeil+y5cznHGCUw=;
 b=aQ4Xt3SfoE/nyRPOr2qCSUe7MLCkTURjjxhm/kDU6nVl8zfVgcGaaXx4wZEzJ+g66Rp2j9twKuCmggG86nPRJzWENwR91Xc4fM6ivggfuKBnwI43G1fNaknE021Fjc7rB+dKUnhHY1zQXTEUurfO4a4BERWYP8O4zvoXJNdJyjSQ6OUfTncZIoZmZL4odDA2OmlwZJvfSG3hk/ZK8LeA8cFkRugIRtFmqImuacS0gKQIdWUcGgfdYvB3PZif/KW2fWuSp3M3zndqMXTdpHm26pG/4mkizclLynKmu9C5lzC5IvglyaKaWu5smpEI/FNFPp5gI22DWg9n/ipOb7q9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L27JqA8alvXQ2H0HL+Z2FJbaiOR4Yeil+y5cznHGCUw=;
 b=AlmiICzcSP0ZxjM99IiNfDLaRksJazUbWylRuDCkYMzbYHz49UXPEIi6VqH+yjVz0ir8ZsZ+wZfBakbPgWfbS4gqXVXYvzck+PqdHq4kdjaCQREkiVScsPlaKM9r1wMa2GHAPqQfxQEdpg2JjNiqQQANTNEURiBLxLVFWzFMBgtQ2dZkpYunbyNWM/eQpve7JCNGM7wfHJOydYz7py+btiq6eH6E5u8+QehZfLchGg+lFsIBi2337QdVvJw7sy9AtSpohIkc1fTQ7csUDfqg68ZFanJwiCLwVFiWebzdGVu2anHPnchBnGnV6tJXH7XvRzhRMUgnMMl4Tm1MnrDvXQ==
Received: from AM0PR07CA0002.eurprd07.prod.outlook.com (2603:10a6:208:ac::15)
 by AS1PR10MB5579.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:477::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 15:00:25 +0000
Received: from VE1EUR01FT021.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:208:ac:cafe::50) by AM0PR07CA0002.outlook.office365.com
 (2603:10a6:208:ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Mon, 26 Sep 2022 15:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT021.mail.protection.outlook.com (10.152.2.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 15:00:25 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 26 Sep 2022 17:00:24 +0200
Received: from [167.87.17.23] (167.87.17.23) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 26 Sep
 2022 17:00:23 +0200
Message-ID: <a3e806e6-8f9e-6935-561f-b05ee7be88e5@siemens.com>
Date: Mon, 26 Sep 2022 17:00:23 +0200
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
X-Originating-IP: [167.87.17.23]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.296900-8.000000
X-TMASE-MatchedRID: Cc2Ao8tLfKA5QaOxwNGfvo9bHfxDWoibO5k/PxBAvv6JUlmL3Uj0mA/o
	5bNHEsCTvn1ivDdpAIflfQ4dEl5mF4HPWllJx5O/dPhh3aRUoXu1j71uqD+zcoS/TV9k6ppA4Sk
	IdSwphgbfUY2boz4kpPcwyVYGZr7IHz45mzJ+08UsH4a1ASijvcmq8U2/MJXWPaBTJyy84wV6i6
	96PjRPiNzONa1Rspx3QBzoPKhLasjWsfhGDQA5PRmGGSZ2LT4ZETQD7c8+Qlq628cXbnOhTzZJJ
	00SAjewj1UOAOjhpZHIcj2m+H71byvn27+DO/kwtTOrxEGQm4ZJI5ZUl647UDl/1fD/GopdWQy9
	YC5qGvzKU1cWyI3gWkkpbiYOUmwxIAcCikR3vq9aj38qurhZDCWvK2/QE5c8lOSbMqiQNRa7pCp
	1GSYKZN+593VBrcaD
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.296900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: EADD44E7D2D87F5AAAC5A7821A0E53B6E96807D00B0730A5B1908B3B32E7930A2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT021:EE_|AS1PR10MB5579:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa622a6-a663-40f6-fedd-08da9fcfd7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FihS57KNmTEI4x3AOIevAh1imPrOjKDzXbUK3nBx0yVMKQ6PvdaxoEDSCCNkBA0+LZ+oqsmuVtHHOg6SPD6CAhd+XVZkpblyIpLgdJtogtPSpSL8kdzZs/tg5du27AoI6f/obzriuqvHcDVoDPO240sfqRFetx/hnqC3rsLAthz0Fc1rYxOTxT59V/lVXhQta7QJZ/TJsujjv84E0izz3OQxFgGgCx4EllrUBn70mV0NA2pWsrpnwaGAQhhswn9dJp/ENhFwPn9C0cjg+mUf2UPAz1jsyspfAoJjRsofZ+ol7EtNaNMMtCsarYKg7WckS6S8S6k7+yGEmZVc8/DqIi0H5LR3ZNVX6xKvLD56KCoe/6Exay1jTlaglzf7mL1FrALs1B7+0+hyIRke+zh+mVL3NruXm7aN0C0ZHLli0rPN+zHo3azCG5USwuZDkzvQTWkN620CXU4WwQBWojMyuehtRcc8jRgx/bNVxN+yFbZotnC3Jte4rLLPOx4SOtYEGIyRGlUQwMe33Mg3Zf812BBNVXLb3z08ydw57Oa4lRYkWHz/a88GlbUG9h1We8DFH/odDdu6wwy/e2/k8R6uKr2uYU3a/w6Bi1CQeV6qUXyE19/YU9WQmvSgC5hQeDUR/Ewgh+mTBveH5ALq+YPhpaTVdMi5cdcbMbu0t4qgsrHotbW+Dil/dkwW3glKpm+wSUbHzDAEXICJpTEwAUz9lavzHqPhT9Vy1KMPPGA4jHT48fiEm7WiDZTH9NrxRHO+pkz3mTui8POrRgL2+fyJHaVuJnVKjs0DzsHMgdCPQREXntxcnVrhAPIt5sP6DAklj+fhg/lKwdm2d9y/sW5wGceBVcs1ljYRUJ6VDzuwH/8=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(31686004)(110136005)(956004)(36756003)(2616005)(31696002)(2906002)(44832011)(186003)(86362001)(5660300002)(8936002)(16526019)(336012)(41300700001)(70206006)(70586007)(47076005)(4326008)(8676002)(356005)(81166007)(26005)(82740400003)(16576012)(40460700003)(82960400001)(82310400005)(316002)(53546011)(6706004)(478600001)(83380400001)(40480700001)(36860700001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:00:25.4050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa622a6-a663-40f6-fedd-08da9fcfd7d5
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT021.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5579

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
>  					    ALIGN_RTSKB_STRUCT_LEN +
>  						    SKB_DATA_ALIGN(RTSKB_SIZE),
> -					    0, SLAB_HWCACHE_ALIGN, NULL);
> +					    0, SLAB_HWCACHE_ALIGN,
> +						0, SKB_DATA_ALIGN(RTSKB_SIZE), NULL);
>  	if (rtskb_slab_pool == NULL)
>  		return -ENOMEM;
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

