Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B652F34
	for <xenomai@lists.linux.dev>; Tue,  5 Jul 2022 09:35:35 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 50C58240004
	for <xenomai@lists.linux.dev>; Tue,  5 Jul 2022 09:35:33 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 17DB99415F8
	for <xenomai@xenomai.org>; Tue,  5 Jul 2022 09:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixNbRZITqzqJL4noPUEkLVGbAbiK460mmGY+SxLx/BkJWhmAp4Edsuu7zw4Dnu/e1YjjexTp9o/+icnRiiHwWoB/wDYzqoMxUKN/4d1ROXOIOV7uAchB7w1X7M3DGCZn9d9crzeVHcaJ8E6ENkYCF/g3pruM3mVA2SWMNyd5MNbzzwNZqWudpDxQjrEiKSm+sjwPu0eaeV7+AcGiOycgW/tn33orE3OICcj06mnhKYkh0FDB2lsr+zocvA6XC/cv+CL++dSCKyWlb+4XiH6MyAG40KW6sRBnz5AWY965K1Nibflccu/fLPozpHAsZUaPx6esJFOunQP6N1tz7kus4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBNKF7dIgN4VBZ9VjYKLwEd3qhblcYZQHbsN9zZ1Qew=;
 b=RqNqGFcn5ZmCzL1mFxRSkdTt/A4iCDPn5tMy1qik3KY4FaX429gKaIFCtXwTrv/oegtqQ3BEpYW5qD7v31OdqdER85PENxj1Xri7oVKCxcZ43m3DjOS4hNaV7MH9flnvb5msFTCI5N6yMT1MDI43fBacxRdhmPP4lA4bNJnu8APNTZbg6Gt/03yB2BT6CcZ4ROvD9UoUnDkwuOd484ld7PEGHKzhTNpA8vWZrqbSKoO5pLSM3+ZDxWEDqBXpPVFd+ytv07VvpjtVPI2BW6jjCyHEhzB+W3gd9cenqDEK4xWoJ3DSI96SWImIyG1XgJAf8lCOyBIaJBrEVzfQstfFow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBNKF7dIgN4VBZ9VjYKLwEd3qhblcYZQHbsN9zZ1Qew=;
 b=izxPMCjtoKz2/mo4buk1ZSzU+Y+L/sQ1oFvZaC6YukkHrLPLDbxvmfmBkks7KHqpH/WMPCXsbYDWwhU6r98JWk46SsGKl6ep0as/3bQe4HOd/oEqmHK/5AYsmay0V+gwdRMrBNDWYyN4FXGaJljFcB7MMt6PmmZppnoaCeJa1hUfR/8l70e9tTw5yxYZuk/ArpUz+pS6vzF4lpXcLsn+Lz7JCv0TIS/Z1hUZZ5OxEKkkRstL0vKW6MZ/orfkWTO4l4ONctovPUExrqNEHU0i9Y0dl3TgN0WXki45fnNZX38pDKffyym1oLkL0y5ePzibefZWWLCjMjDXQMBjUfkQPg==
Received: from AS9PR06CA0292.eurprd06.prod.outlook.com (2603:10a6:20b:45a::23)
 by AM9PR10MB4008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Tue, 5 Jul
 2022 09:35:31 +0000
Received: from VE1EUR01FT027.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:45a:cafe::4a) by AS9PR06CA0292.outlook.office365.com
 (2603:10a6:20b:45a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Tue, 5 Jul 2022 09:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT027.mail.protection.outlook.com (10.152.2.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 09:35:30 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 5 Jul 2022 11:35:30 +0200
Received: from [139.21.19.13] (139.21.19.13) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 5 Jul 2022
 11:35:29 +0200
Message-ID: <0ff7d375-cd40-c9fb-5ae1-45a829e8d255@siemens.com>
Date: Tue, 5 Jul 2022 11:35:29 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 05/15] drivers/net: Switch to dev_addr_set
Content-Language: en-US
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>,
	"xenomai@xenomai.org" <xenomai@xenomai.org>
CC: "gunter.grau@philips.com" <gunter.grau@philips.com>
References: <cover.1656940114.git.jan.kiszka@siemens.com>
 <fed48b9dd1275fd788bbbc3571608b07b88d681e.1656940114.git.jan.kiszka@siemens.com>
 <6d01cd44f4a10f771b47696de3bfc7c159819f00.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6d01cd44f4a10f771b47696de3bfc7c159819f00.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.19.13]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.921300-8.000000
X-TMASE-MatchedRID: FdhKtQVb1Tw5QaOxwNGfvo9bHfxDWoibUlQrLabIzZNo9ddFVIEGiwEP
	JrYlsf/6sygHZqjWBas30EeCx5K2K7ekBxozLGXcWqEBIOyGYiks8CiT+sAz65V3j1zTOBYzP6T
	ki+9nU38HZBaLwEXlKCiv9uudOLyHhlDeaT5RhrgkrgMnNPRaLgw9tB9UvQcI9Ib/6w+1lWSGek
	ObROGwdBj4eND0g8+sit7nFRMRubeIi0Yt2qmJZTxzNYQaDhqe7eZSSeRi7OEyIyttzvQ999xWL
	ypmYlZzV+Wy/X6EXDCv+pB16e5dxc4/1guDObJnfAF/IvTqMoBiSBKt6/PPs15hVZTm4dD8DKvL
	dahoIESbKItl61J/ycnjLTA/UDoAoTCA5Efyn8CNo+PRbWqfRDsAVzN+Ov/sM0Dp9Tots2mZhKI
	Zqi9u0CqZIORiRf/LonOwdzinfr5wxGJIO6BEzQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.921300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 BF4C9EA05F07877193AE7C929721A5ED9C29D1A88455E0C09C8907CDA5E6BF6C2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 552512f6-3683-4112-705d-08da5e69b3d0
X-MS-TrafficTypeDiagnostic: AM9PR10MB4008:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uFHIlTfN9/My9zgIQKzPW7tMcL0mA5E0wp2KRuVyHv/XeEV2PBeP9DU6T4Ba9aopTK/Rji1+jqalp/W1NAj82Y94AUoF2QW7ytOCWnDsB813tgUcuk3mqymlIxVtBTmFiernB61wgc0Z6yy8hUVUpdb0Cw1Ru7geB8PlPJnVTfdxvxbvGaHwhhndeq8Vcw56pwWAztw7XtiJGQ3a16SRbj6jFDel9U3jSiNSFuz/IsSfsbikPYIIb/7ovGUJ/C1CX5Opcjdnag+emkKP1nFsj79RpbYSNgZIPwz8DBDcRv8KpPV4wrwvtsfdkPvHxfFtJn39hISgInWzFRIVjIWGpohyuyJjbMzvuJ4BKTauXGqoFFbPI/EDJIPJNwyK9Ina0x43jLEJ8lOQAkC9PpYjgWhn5y/t/Xj9q+zD04F3Uj3B0VOLVJM+wykIMDkn8lFWKl2YMFXYrsuZvHGPVkxBMDERyv/AFWrU/nYsgTh/Ysk/ccYLiEQKjYRgyL4PEvsrn9lxWGZ1XnqDwYrGV1Mydgo9poUDfnX4hh/0vM9ucnUj6jZ+qou6T0iQVaRvAK4Wi7qLCRkSrbRI9SFOB9zd+H/cF3mK8ymOlHjAhG0V0B6me4+A2PO0DqB3VM39FxJx1KKMucFweDuXXLuUJDGMKCRHAu5f7XrFbNZqmq8XYubWLYyyXHGBigEtY+xQEQkRHftXsjxvB4VcCI+hHFZTHGRa5FN060dn+nzqmW/45rqepcxTHOlE9V2w/irqK1PgoP5SRU4EgxHWZWCSzkWYqFcnoT7htLo9Q0/T22lhJFzExdKrb1/dQKV2qvRLrLlbHJDrBFrDiMETdRYPMG1pD3uYdGCmluaxYbKtAhAvkcJx8yHBBMA1zwAc2c2T0xOK
X-Forefront-Antispam-Report:
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966006)(36840700001)(40470700004)(6706004)(70206006)(40460700003)(70586007)(110136005)(316002)(7636003)(16576012)(86362001)(26005)(40480700001)(8936002)(8676002)(7596003)(31696002)(82960400001)(83380400001)(82740400003)(356005)(5660300002)(4326008)(186003)(16526019)(47076005)(956004)(2616005)(36756003)(336012)(478600001)(36860700001)(31686004)(44832011)(2906002)(82310400005)(53546011)(41300700001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 09:35:30.7080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 552512f6-3683-4112-705d-08da5e69b3d0
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT027.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4008
Received-SPF: pass (spool1: domain of siemens.com designates 40.107.21.86 as permitted sender) client-ip=40.107.21.86; envelope-from=jan.kiszka@siemens.com; helo=EUR05-VI1-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=izxPMCjt;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.21.86 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

On 04.07.22 15:57, Bezdeka, Florian (T CED SES-DE) wrote:
> On Mon, 2022-07-04 at 15:08 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Latest kernel complain about accessing dev_addr directly and push us
>> toward the accessor functions. Use that and provide a wrapper for
>> kernels prior to 5.15.
>>
>> CC: Gunter Grau <gunter.grau@philips.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  kernel/cobalt/include/asm-generic/xenomai/wrappers.h |  4 ++++
>>  kernel/drivers/net/addons/cap.c                      |  5 ++---
>>  kernel/drivers/net/addons/proxy.c                    |  2 +-
>>  kernel/drivers/net/drivers/freescale/fec_main.c      | 11 +++++++----
>>  kernel/drivers/net/stack/rtmac/rtmac_vnic.c          |  5 ++---
>>  5 files changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>> index 88152a25e1..6489c82c8c 100644
>> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>> @@ -54,6 +54,10 @@
>>  #define close_fd(__ufd)      __close_fd(current->files, __ufd)
>>  #endif
>>
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0)
>> +#define dev_addr_set(dev, addr)      memcpy((dev)->dev_addr, addr, MAX_ADDR_LEN)
> 
> The wrapper for older kernel always uses MAX_ADDR_LEN, see below...

Good catch. We should likely use dev->addr_len here, just like the
function in later kernels do. That /should/ be initialized according to
current user's expectations (and provided buffers), but maybe worth a
second check.

Jan

> 
>> +#endif
>> +
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(5,17,0)
>>  #define pde_data(i)  PDE_DATA(i)
>>  #endif
>> diff --git a/kernel/drivers/net/addons/cap.c b/kernel/drivers/net/addons/cap.c
>> index 1e86440699..3784b65226 100644
>> --- a/kernel/drivers/net/addons/cap.c
>> +++ b/kernel/drivers/net/addons/cap.c
>> @@ -263,9 +263,8 @@ static int tap_dev_open(struct net_device *dev)
>>       if (err == 0)
>>               return -EIDRM;
>>
>> -     memcpy(dev->dev_addr,
>> -            (*(struct rtnet_device **)netdev_priv(dev))->dev_addr,
>> -            MAX_ADDR_LEN);
>> +     dev_addr_set(dev,
>> +                  (*(struct rtnet_device **)netdev_priv(dev))->dev_addr);
> 
> This one looks good. MAX_ADDR_LEN was previously used as well.
> 
>>       return 0;
>>  }
>> diff --git a/kernel/drivers/net/addons/proxy.c b/kernel/drivers/net/addons/proxy.c
>> index f70587678a..b37b42c9de 100644
>> --- a/kernel/drivers/net/addons/proxy.c
>> +++ b/kernel/drivers/net/addons/proxy.c
>> @@ -321,7 +321,7 @@ static void __init rtnetproxy_init(struct net_device *dev)
>>
>>       dev->tx_queue_len = 0;
>>  #ifdef CONFIG_XENO_DRIVERS_NET_ADDON_PROXY_ARP
>> -     memcpy(dev->dev_addr, rtnetproxy_rtdev->dev_addr, MAX_ADDR_LEN);
>> +     dev_addr_set(dev, rtnetproxy_rtdev->dev_addr);
>>  #else
>>       dev->flags |= IFF_NOARP;
>>  #endif
>> diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
>> index be0ed0c51e..72ee4de738 100644
>> --- a/kernel/drivers/net/drivers/freescale/fec_main.c
>> +++ b/kernel/drivers/net/drivers/freescale/fec_main.c
>> @@ -1315,11 +1315,14 @@ static void fec_get_mac(struct net_device *ndev)
>>               return;
>>       }
>>
>> -     memcpy(ndev->dev_addr, iap, ETH_ALEN);
>> -
>>       /* Adjust MAC if using macaddr */
>> -     if (iap == macaddr)
>> -              ndev->dev_addr[ETH_ALEN-1] = macaddr[ETH_ALEN-1] + fep->dev_id;
>> +     if (iap == macaddr) {
>> +             memcpy(tmpaddr, macaddr, ETH_ALEN);
>> +             tmpaddr[ETH_ALEN-1] += fep->dev_id;
>> +             dev_addr_set(ndev, tmpaddr);
> 
> Remember: The wrapper for older kernel uses MAX_ADDR_LEN, but we only
> supply ETH_ALEN bytes, which is a mismatch, isn't it?
> 
>> +     } else {
>> +             dev_addr_set(ndev, iap);
>> +     }
>>  }
>>
>>  /* ------------------------------------------------------------------------- */
>> diff --git a/kernel/drivers/net/stack/rtmac/rtmac_vnic.c b/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
>> index 138e276ad9..4b41785db8 100644
>> --- a/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
>> +++ b/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
>> @@ -114,9 +114,8 @@ static void rtmac_vnic_signal_handler(rtdm_nrtsig_t *nrtsig, void *arg)
>>
>>  static int rtmac_vnic_copy_mac(struct net_device *dev)
>>  {
>> -     memcpy(dev->dev_addr,
>> -            (*(struct rtnet_device **)netdev_priv(dev))->dev_addr,
>> -            MAX_ADDR_LEN);
>> +     dev_addr_set(dev,
>> +                  (*(struct rtnet_device **)netdev_priv(dev))->dev_addr);
>>
> 
> Fine again.
> 
>>       return 0;
>>  }
> 


-- 
Siemens AG, Technology
Competence Center Embedded Linux
