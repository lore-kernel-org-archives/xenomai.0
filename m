Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3562F56
	for <xenomai@lists.linux.dev>; Tue,  5 Jul 2022 13:11:28 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id D7EBA60009
	for <xenomai@lists.linux.dev>; Tue,  5 Jul 2022 13:11:20 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80059.outbound.protection.outlook.com [40.107.8.59])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B6A91941833
	for <xenomai@xenomai.org>; Tue,  5 Jul 2022 13:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpWHIAqe2H0dlyCrkS+b7eBNMWOxvJdD/6m3quDnaLA8Rh/tUmfAXNHCqICvb7sXyNK63ax8WmmhqiytlD7CY0uJBfLTD5EG7CQpoe3BAWGSAbEngEVbEg2ErEAGf3M0POOp2tmC1dYV3vctqBiyMX9UYdpqd/pBel1aEebVf88d9xxYf+N5fietT/aFy8QbLAbkIdqCdTHtEXcVNfXnOcyPec52/7h0KnuCFfGyzZhbtmG7Ua9ypGYnDn9Qm5CJYJpuyidrXyQLUwhYs6CtjQACaozIogneWcvyxZI8TG2UuY12x+Efcr8Axt7ib+rmwU3AKmBREGfl7F/CW9n6HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNh1teFMy6KFjXsUpumRycIk0UPEJxu1qx1VSsqSVe8=;
 b=ETOEjUQAQlns3/ZKu6Ifnz9PC9T1MHGcrSi0Pt+5V4VlIxBJ4396FDEiqPhjzdAEVVdK4yum9cOjNYUYpMTVCBbvzDqH02nz5kbz56WF0dWgget7jFGGBIloNYlZzHo1cwG7nGrRsUTaPHVHRH0g8nSbfvbDvxGkxMlgAKbdOqoDMOVatPwTHc4GSKH+8NX2yLDa3F44/Xqm82ibpiYpvroB+mW2OtahB1o8xjokXi3uV54W6Sdt4/jHCwilCk0bWiegfUOKIWmMl/pee0aIAWs8cKH+SyoP4onB0EmUHWVXNKIEJ08yWeryUpgRLQlq6uOvOVP6AwjXJca3srQLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=xenomai.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNh1teFMy6KFjXsUpumRycIk0UPEJxu1qx1VSsqSVe8=;
 b=N74NPt9RPv5PJw/lZjRYZ764A9gVx5cOvrFznUDHlDHR7mh5J6oGcK/1q2J9Nqu3ZK6GKSBJ9BuTq5R3BMR73rABpG8s5n11iuycT/D6gbrB4+UcWlqg3MvSjcLACM2yF8x6dpB2Sl0r//c9/n0c7AUYa68wm0l0hLxNJv9iRmCL/6wj38C3KImiRjR/BF+eOfodAnrmonDO4bbqam9QS/PdkQMjnnMp/tQm966X9C9c2OlcgKtTUv4hXms5QOClkVzE0CLw9XIm5L1WeIMTQ2hfpam7bqoRytPDGl1nb/3CBaGCD2bpGuWmu9VmyHv4Y3IVQnnHP5GXWuhXjrRSnA==
Received: from DB6PR0501CA0027.eurprd05.prod.outlook.com (2603:10a6:4:67::13)
 by PA4PR10MB4605.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 13:11:18 +0000
Received: from DB5EUR01FT041.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:67:cafe::c8) by DB6PR0501CA0027.outlook.office365.com
 (2603:10a6:4:67::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21 via Frontend
 Transport; Tue, 5 Jul 2022 13:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT041.mail.protection.outlook.com (10.152.5.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.17 via Frontend Transport; Tue, 5 Jul 2022 13:11:18 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 5 Jul 2022 15:11:17 +0200
Received: from [139.21.19.13] (139.21.19.13) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 5 Jul 2022
 15:11:17 +0200
Message-ID: <b3c89d7c-e606-1fd8-f604-95a2f13fb3e6@siemens.com>
Date: Tue, 5 Jul 2022 15:11:16 +0200
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
 <a271d367-615c-16f3-ad71-20ae107bc6aa@siemens.com>
 <83bb43a9f69b7a4e211543050ef3cb60d22df94b.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <83bb43a9f69b7a4e211543050ef3cb60d22df94b.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.19.13]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.619200-8.000000
X-TMASE-MatchedRID: ObgwaKFsELA5QaOxwNGfvo9bHfxDWoibUlQrLabIzZNo9ddFVIEGiwEP
	JrYlsf/6sygHZqjWBas30EeCx5K2K7ekBxozLGXcWqEBIOyGYiks8CiT+sAz65V3j1zTOBYzP6T
	ki+9nU38HZBaLwEXlKCiv9uudOLyHhlDeaT5RhrgkrgMnNPRaLgw9tB9UvQcIGjzBgnFZvQ5MVC
	cj56k8hkFungmhsSsCM4mUtvpBXncES9kI92asxBb+/Q1vzLdAQLBrHsp/dPNKpXJ6KgA9xT6h7
	Zt9E7MjHApIKLQpe4QDE6k/i6Y0RQS5ROcJ/0CDPdz3eAVcpFR0U57VQ7qTiVmU3gdLaqKb+Ifr
	iO3cV8QnzvR+mP3cvlToQXMMvKm718xKT+GS21cvHEcEx0NzujLvC8LxRzodngIgpj8eDcC063W
	h9WVqgtQdB5NUNSsi1GcRAJRT6POOhzOa6g8KrS0S5vtw7NlwaoreDFy6derOfLBBL5N/JrIFa2
	bSpiysrO5HAqc+D+o=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.619200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 1AAC99522C184A517A5B601157281F68454764D5D5D8402637567855DA757AF72000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39445bfe-f548-474c-1e3e-08da5e87d92d
X-MS-TrafficTypeDiagnostic: PA4PR10MB4605:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	viNpMdhTlGrtXFcf6MzbRkgkuYlP4In04Xm/NyWMv9fnvwnRsMEyzYWpOLEnNZJJltkKK7sZRsVLEdiFu8wwMR9wpcjv4w/+os5Ltsl7t7wxdavIZZlXZNt3pRvAOaaNmokJJEPmQ3td+dnBABDJQMwRk0HOSeDFHO08ZllhvvRymzVjkQqb2N8Z7AF1z098sZxJk6bqAgg/vbYxj4R2fggSt31nThkHytEj0v8fSCQAK4/nmUW6gVwQpQ0gBAuGWz2j5/JnEudV7fuSAMj8P39L0iLtN9CoIJmsPxRuufD0Dp7aLbRabr4v1AlYsyjs1xj/q85D5vDj1CTAhJ5ktWEsJroc5wFYv/Os/H+8pO0mEz551TrApgX/agAPofcd1iEAy1IAmarAwNQjFpwwdfhnYxNLdoYDvNAidC3liCCELdBS4xNFK91anpoCikR1iNNoNhG1rq6GuBI1B5ahv0iylaYsSbDYhPEAM+jMNhnt0hNTB39a/jiCYWEDU8khfLdKnn/JwpZlAgg428pcHjUKWdKkPq1ZtL7z0xa8RkPFAsso/+TJryr1sZHk+Ka4d30O84NnPlOuxM9S8bGxWDysioQgvy5uUb7fj7T8CXPn/9hqRT7ym8nzLmi4iIvU08aeNiLpbyz6FOuP6uRhnC4MCYULrWcGvf39FaSrG0rDb6J0jDT7wkpqlW2msCYGlDPWbW/qGPYQUklscD/4CUOjVCNg0+dTlIkY0VsVFneakseTihc/VzHAu3J/gJnSEZxjSLR1SKp0pRTI/yZYYBYc9H1IjlLMlcjV8Y0xnSxlJ+wXvqKJH9+dv1ZEIP4hDGS31Sc7bF8OI5hFMS694kVXK0sxJmU4qPcxlIOVt/k2pUGnip395KNGI8vrvnvSfojFokLXa6/slKdSLvg+POWf+D9wSqcq241J9paM62E=
X-Forefront-Antispam-Report:
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(346002)(40470700004)(36840700001)(46966006)(186003)(16526019)(47076005)(336012)(40460700003)(82740400003)(36860700001)(31696002)(8676002)(83380400001)(70206006)(70586007)(4326008)(316002)(81166007)(36756003)(31686004)(40480700001)(16576012)(6706004)(110136005)(44832011)(53546011)(26005)(5660300002)(956004)(478600001)(86362001)(2616005)(8936002)(356005)(82960400001)(41300700001)(2906002)(82310400005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 13:11:18.2773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39445bfe-f548-474c-1e3e-08da5e87d92d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5EUR01FT041.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4605
Received-SPF: pass (spool1: domain of siemens.com designates 40.107.8.59 as permitted sender) client-ip=40.107.8.59; envelope-from=jan.kiszka@siemens.com; helo=EUR04-VI1-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=N74NPt9R;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.8.59 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=none) header.from=siemens.com

On 05.07.22 13:16, Bezdeka, Florian (T CED SES-DE) wrote:
> On Tue, 2022-07-05 at 11:41 +0200, Jan Kiszka wrote:
>> On 04.07.22 16:32, Bezdeka, Florian (T CED SES-DE) wrote:
>>> On Mon, 2022-07-04 at 15:08 +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> Latest kernel complain about accessing dev_addr directly and push us
>>>> toward the accessor functions. Use that and provide a wrapper for
>>>> kernels prior to 5.15.
>>>>
>>>> CC: Gunter Grau <gunter.grau@philips.com>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  kernel/cobalt/include/asm-generic/xenomai/wrappers.h |  4 ++++
>>>>  kernel/drivers/net/addons/cap.c                      |  5 ++---
>>>>  kernel/drivers/net/addons/proxy.c                    |  2 +-
>>>>  kernel/drivers/net/drivers/freescale/fec_main.c      | 11 +++++++----
>>>>  kernel/drivers/net/stack/rtmac/rtmac_vnic.c          |  5 ++---
>>>>  5 files changed, 16 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>>>> index 88152a25e1..6489c82c8c 100644
>>>> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>>>> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>>>> @@ -54,6 +54,10 @@
>>>>  #define close_fd(__ufd)      __close_fd(current->files, __ufd)
>>>>  #endif
>>>>
>>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0)
>>>> +#define dev_addr_set(dev, addr)      memcpy((dev)->dev_addr, addr, MAX_ADDR_LEN)
>>>> +#endif
>>>> +
>>>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(5,17,0)
>>>>  #define pde_data(i)  PDE_DATA(i)
>>>>  #endif
>>>> diff --git a/kernel/drivers/net/addons/cap.c b/kernel/drivers/net/addons/cap.c
>>>> index 1e86440699..3784b65226 100644
>>>> --- a/kernel/drivers/net/addons/cap.c
>>>> +++ b/kernel/drivers/net/addons/cap.c
>>>> @@ -263,9 +263,8 @@ static int tap_dev_open(struct net_device *dev)
>>>>       if (err == 0)
>>>>               return -EIDRM;
>>>>
>>>> -     memcpy(dev->dev_addr,
>>>> -            (*(struct rtnet_device **)netdev_priv(dev))->dev_addr,
>>>> -            MAX_ADDR_LEN);
>>>> +     dev_addr_set(dev,
>>>> +                  (*(struct rtnet_device **)netdev_priv(dev))->dev_addr);
>>>>
>>>>       return 0;
>>>>  }
>>>> diff --git a/kernel/drivers/net/addons/proxy.c b/kernel/drivers/net/addons/proxy.c
>>>> index f70587678a..b37b42c9de 100644
>>>> --- a/kernel/drivers/net/addons/proxy.c
>>>> +++ b/kernel/drivers/net/addons/proxy.c
>>>> @@ -321,7 +321,7 @@ static void __init rtnetproxy_init(struct net_device *dev)
>>>>
>>>>       dev->tx_queue_len = 0;
>>>>  #ifdef CONFIG_XENO_DRIVERS_NET_ADDON_PROXY_ARP
>>>> -     memcpy(dev->dev_addr, rtnetproxy_rtdev->dev_addr, MAX_ADDR_LEN);
>>>> +     dev_addr_set(dev, rtnetproxy_rtdev->dev_addr);
>>>>  #else
>>>>       dev->flags |= IFF_NOARP;
>>>>  #endif
>>>> diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
>>>> index be0ed0c51e..72ee4de738 100644
>>>> --- a/kernel/drivers/net/drivers/freescale/fec_main.c
>>>> +++ b/kernel/drivers/net/drivers/freescale/fec_main.c
>>>> @@ -1315,11 +1315,14 @@ static void fec_get_mac(struct net_device *ndev)
>>>>               return;
>>>>       }
>>>>
>>>> -     memcpy(ndev->dev_addr, iap, ETH_ALEN);
>>>> -
>>>>       /* Adjust MAC if using macaddr */
>>>> -     if (iap == macaddr)
>>>> -              ndev->dev_addr[ETH_ALEN-1] = macaddr[ETH_ALEN-1] + fep->dev_id;
>>>> +     if (iap == macaddr) {
>>>> +             memcpy(tmpaddr, macaddr, ETH_ALEN);
>>>> +             tmpaddr[ETH_ALEN-1] += fep->dev_id;
>>>> +             dev_addr_set(ndev, tmpaddr);
>>>
>>> One more thing here:
>>>
>>> dev_addr_set when available inside the kernel uses ndev->addr_len for
>>> performing the memcpy. Do we ever set ndev->addr_len?
>>
>> Hmm, I would have expected this to be initialized on device creation,
>> but it seems not.
>>
>> Seems the better answer is to use eth_hw_addr_set - which hard-codes
>> ETH_ALEN as length.
> 
> Sounds reasonable. I assume the expectation is to set ndev->addr and
> ndev->addr_len at the same time. No idea which API to choose.
> 
> Possibilities I know of:
> - dev_addr_set
> - dev_addr_mod
> - eth_hw_addr_set

I'm seeing tons of usage for eth_hw_addr_set but only very few addr_len
updates.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
