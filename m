Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F22F34
	for <xenomai@lists.linux.dev>; Tue,  5 Jul 2022 09:41:35 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 5DD4310000B
	for <xenomai@lists.linux.dev>; Tue,  5 Jul 2022 09:41:33 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130089.outbound.protection.outlook.com [40.107.13.89])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 0EB25941684
	for <xenomai@xenomai.org>; Tue,  5 Jul 2022 09:41:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPKWosyINt+BpuSuVPmswzF3fok+1rwygtXzqnl0kzd6TEWARSATU94lNUcOU1GhK0pGEl9J8iy7FOXfx598vFaR/SfpqewCxtD2GJ4bT/rLYleYxc6wdhuvCvxhnSahnqbaTabkL/8iRdKy0iwIoZv8jIparFustG4N80NaiAvVHxwHssWfhoKBJU3fW8et4Y8Ka5WksJvQKEAGXGvDDXH+QASRolDJ92Uv+socVpN4jH4zwbJGC8XEiccEc/VGLyJ00ZppPAEbGcpPl8Y0JEjme1nwNck5ZJ4yHmalf75/HrHAQOnX9R7QuVPT4krFi2mXE3eoabngWlythlP0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNSrFlaZy5+nijCSwCOjy2rC2T2vR3eRPQ7y/dz+nrc=;
 b=TKB+49K/oBy1jVjtaRV4qC1mSXSn/8lo/YmgG+MHCRIkieyr4C0CZF3XP7U+lbsz6aDbHw87tqlBiFL07JNkAyt44I6fBmFV+JuexJahu2cNYMtSS3xzIPJBNMOrxut86GpuSqo8omuc/aQHCGEW3SG0SB/O1VbslNLhQHQaQS+fbzmztz9/X4UVW2hnOT+KmWJksOXumtYO1uJTNDevnvKfwldV1kVMgKDCGxk4XQ8+VyQJvdTqLgfrOrHarpoddrrWZGGaVYbJxYQWZBam+qwS0+a9S0Ql0VXBZ3MJT3wSYHXBUsM320LX9Hcrt29nURnB3lbVjr0laUhmxlEfcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNSrFlaZy5+nijCSwCOjy2rC2T2vR3eRPQ7y/dz+nrc=;
 b=Rb+J5yzZwMLIgxI+J6vsUqIInDzGCdWZ8d3A98PlFRd4ePeTUa925lNZsrvoKAL4nf2o7YI9oO8LUwdQ7GZu5Gby/imrMT1nRjOy/1oyZJ3ZP+023oDrzK/3oMHy/qp4lyipKLiyE8n/Qeaw/aKYzVWPw0rrPtMYTvBWwtDPTAXq4CK/BXKo3F7CQbGzVJV0FUIApcXnW4JNjMldEBaIVf3SDFgxPQBdrPUPQG4/hF2QIbwQIA5nqeaemoDHaI9FFAmaJfDMu0dYT/RSvNDeecRq7YwxDbWjbL01M0lL7k0Zg00GBwtxX3wSuG4uC4ueHHU9UT+q5ZINvBJ2y/41pw==
Received: from DU2P250CA0005.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::10)
 by DB9PR10MB4505.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:222::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 09:41:30 +0000
Received: from DB5EUR01FT106.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:231:cafe::38) by DU2P250CA0005.outlook.office365.com
 (2603:10a6:10:231::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21 via Frontend
 Transport; Tue, 5 Jul 2022 09:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT106.mail.protection.outlook.com (10.152.4.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 09:41:30 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 5 Jul 2022 11:41:30 +0200
Received: from [139.21.19.13] (139.21.19.13) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 5 Jul 2022
 11:41:30 +0200
Message-ID: <a271d367-615c-16f3-ad71-20ae107bc6aa@siemens.com>
Date: Tue, 5 Jul 2022 11:41:29 +0200
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
 <3bc48f68be16235291bae284fb438ec25b7679f4.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <3bc48f68be16235291bae284fb438ec25b7679f4.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.19.13]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.177100-8.000000
X-TMASE-MatchedRID: Alur8Cs15mw5QaOxwNGfvo9bHfxDWoibUlQrLabIzZNo9ddFVIEGiwEP
	JrYlsf/6sygHZqjWBas30EeCx5K2K7ekBxozLGXcWqEBIOyGYiks8CiT+sAz65V3j1zTOBYzP6T
	ki+9nU38HZBaLwEXlKCiv9uudOLyHhlDeaT5RhrgkrgMnNPRaLgw9tB9UvQcIGjzBgnFZvQ5MVC
	cj56k8hkFungmhsSsCM4mUtvpBXncES9kI92asxBb+/Q1vzLdAQLBrHsp/dPNKpXJ6KgA9xT6h7
	Zt9E7MjHApIKLQpe4QDE6k/i6Y0RQS5ROcJ/0CDIEk0VyKJvizEHXdj/44Lpm5eAiqrqZDK9FT7
	09M8dJiHPSXOyvGapqPFjJEFr+olA9Mriq0CDAgBi3kqJOK62QtuKBGekqUpI/NGWt0UYPBGuS9
	kUuEMpZo0vgo9BoR3BGMiv+j8blPinhtjx3MFGlEH9I1XOTtm
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.177100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 5C66CC808A0AFA85D837DAF1E3CAB064E13CDEDCC6F5D971FB3F8C56EC6BD8E42000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3de9fd51-e771-45ba-fdef-08da5e6a8a79
X-MS-TrafficTypeDiagnostic: DB9PR10MB4505:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v9cwL8ul+KXR2nEPq62FLf1rfFCthTBlAAOHI9Zpo+XEgMJnlMr5+ChvV5CI972woZKCKuq3EeRhPB/bS/kbCNwqRtFovpaRSJ8qIA3dwmlQLWlDmmRl7kTFOvmJuuYu9JXd3RMtVQbzoRHmGA8U4J84s/+5XVnALEztWxvRcF8ubM3XDqnzDVHNo9asv/xp4vTOSVR3P0VeAR0rqhx7B9w9ADcgIXnyh7ClIJGWoPqea6QFPAzU6V7jRe4CEj2ZMV77OduCnKfczMAGcdfKK6TaLst6YdKy6Z+YrYzaJyad3klslYq2oBjF/9yo6TQ1zRfdijch3f/n+odiEr2yCT5B6Zm5pVyiLx1WmFOuOHsLlA/qTmWzbA9JuADqPrh8J+63YG81KP8HY2LMz19Q1fEhmqo+7d2b8VI0btAMjQ0WVuf3WT+g4UFAxz5fI6dIcGuwu4VJN82dvqvhlI4B/pq+bc3ACWJY5yJI8/ewsNgpO3aoD3W/n0/7yyjJmGPeYDcEs/8i7UN4ANHukEWIdptwvNNt00UIRBKFnazE+KA9c4aeHYIMqHTcmj/AGcFJmN925LxAgf9xfxkz55KbD7AcYcOJYfI8rz2hZl/JbiFguDpc7Ya+9n2fc1RPoUBJktWRd0UXRJFq9B8iMz7rVo8GYl6NnWHi/gcB/MsYhmio/R0Vcad7Fjv27vdyvRLZx9QD5yaxRNYJqkQqpcqund+niLABhmEDU9OGAmazjyBpNqYEekT8D7lCdNsrkHD6ByJgMH6XSpgUDMuzlczqLn9uiw9u500Smboqeu+Vbzi0xW16JfTsQF6eVocEC551HPEoThk+rXNHFBJZkVOKA5W/FyRHXLCgSUk22oqFnKB4cgospK64nTNSPJZ7ptSPuLsvtDrxtcam9b1woYRz/Y3j4oWIp7+SdmsTpFdibR0=
X-Forefront-Antispam-Report:
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(40470700004)(46966006)(36840700001)(44832011)(478600001)(8936002)(5660300002)(53546011)(40460700003)(31696002)(41300700001)(2906002)(26005)(36860700001)(82960400001)(82740400003)(356005)(81166007)(86362001)(82310400005)(47076005)(336012)(16526019)(2616005)(186003)(956004)(40480700001)(83380400001)(8676002)(4326008)(70206006)(70586007)(36756003)(31686004)(316002)(16576012)(6706004)(110136005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 09:41:30.8360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de9fd51-e771-45ba-fdef-08da5e6a8a79
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT106.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4505
Received-SPF: pass (spool1: domain of siemens.com designates 40.107.13.89 as permitted sender) client-ip=40.107.13.89; envelope-from=jan.kiszka@siemens.com; helo=EUR01-HE1-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=Rb+J5yzZ;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.13.89 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

On 04.07.22 16:32, Bezdeka, Florian (T CED SES-DE) wrote:
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
>>
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
> One more thing here:
> 
> dev_addr_set when available inside the kernel uses ndev->addr_len for
> performing the memcpy. Do we ever set ndev->addr_len?

Hmm, I would have expected this to be initialized on device creation,
but it seems not.

Seems the better answer is to use eth_hw_addr_set - which hard-codes
ETH_ALEN as length.

Jan

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
>>       return 0;
>>  }
> 


-- 
Siemens AG, Technology
Competence Center Embedded Linux
