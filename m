Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42772562
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 15:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvAnQbSeFqyy4O7EYJ367dDlLPo+6WXDtk77AF3gms8XZDGSlHzTTTRiGhGJu23nFjM4g1YdDXm7V5UXSMY0jqmRx9Mzf6HBj+RexejE9ScZ//nJLhin4JTrLoFKXjiQQAwBfzuN8QdLIwUJq6nFTKhbPAlarkQfrkVBeMifFxcapy3o6l/RCUUEJRCo9bMr7SjHzHfQilJ/WE7E/8YYPr8bbcKR4vvzkk/tKCn485QI7l0vEcRVcMSw7FB2df/tnCdvwRou1usmqZG0yyFoI5WhVQaXsulST8H2fwTiNDgTKzVHIRxEWjGjfwj/hMUFutyqibPrPWwH/I1P+zO2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PviNZ6OIY/ynORYb9A3tC1L7GBLXl73fNKxqyY5KVY=;
 b=hMxVN1f/z/f1MPBbFyCOMNG1flUIQk+hWu+9iCrJI3u+H8/gNQdkdqaVf+4l4c0rK7xsI4yCEyylPqUrKFeM7E8hES8Cyp6kcOaWEWC2eIcXtnMdsWYtzt2XL9kpscHJvmkDtHV4y7BGAoJAYd6HgFyzoLI1aX5yCrErqU3dHSCB+FF9fAsL1naFPdkQHUFBmru+DJooVjf0FUNi8L6kDQmBxiYwBf7KSiBRUiHsftKGy0e+fDVt6jliXI3PjBg/kwxXz3n/lqlBipKbsBJLUjL3OhbTVvxEP9FTGDdQp2w6ilk6bqdVgNO1PnfmN9OPeiq9PsQoHrOQui11hKXpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=philips.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PviNZ6OIY/ynORYb9A3tC1L7GBLXl73fNKxqyY5KVY=;
 b=m4Q1AjIDj2LyAd+wdRsp45BURSMLxU3HNN5tHtioTa4wNa8/DL/11GLQLWtVTyojnXSQiXAIM6ZRMM+T0qf5JFCL+ejoYygqiswX+o8SFGp+nwQJg/egTDcZh4rhKEywqCGvUB+sKXLYGgoUMU/0nzbGsTQcWmgC3CzElCbenQ3+lIc8rvFDxEvIAIVcOBQ1qxId5vkkDj3UoHFf9KNMshJioIPkGg/PRH0XinZ4q3UHdgFLTBdiLcNnR7rKATfSjyk0WQPsiMoiBphRMgpBOd6S1eorTDmWL0fsFmvzEWP6TQYQhtkneA7NwqSRK25AFWTJIJ4wzoV9ZLwayXER4Q==
Received: from AS8P251CA0012.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::33)
 by PAXPR10MB5231.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Mon, 20 Jun
 2022 15:35:34 +0000
Received: from VE1EUR01FT106.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:2f2:cafe::cc) by AS8P251CA0012.outlook.office365.com
 (2603:10a6:20b:2f2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22 via Frontend
 Transport; Mon, 20 Jun 2022 15:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT106.mail.protection.outlook.com (10.152.2.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 15:35:34 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 20 Jun 2022 17:35:34 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Mon, 20 Jun
 2022 17:35:33 +0200
Message-ID: <e5412511-e7c7-0951-2f72-357e9a47047f@siemens.com>
Date: Mon, 20 Jun 2022 17:35:33 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] rtdm/drvlib: Prevent pagefaults on arm on io mapping
Content-Language: en-US
To: "Grau, Gunter" <gunter.grau@philips.com>, Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <20220523140444.2632658-1-guntgrau@bbl.ma.philips.com>
 <59e12ca2-6c6f-09ff-5365-985586dc4e4e@siemens.com>
 <87fsk6pddt.fsf@xenomai.org>
 <06fc6d18-891c-e0b0-51a7-4b21f49e2add@siemens.com>
 <87bkuupad5.fsf@xenomai.org>
 <b6d70f96-0e67-241b-fb4f-4d822933d05e@siemens.com>
 <e876977a-4f17-d075-b9e7-1a096ea29949@siemens.com>
 <cd3fcfaa-0432-feaa-b69e-f3983f200529@siemens.com>
 <AM7P122MB02294E1A0DF3037F0F3C929DF2B09@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
 <AM7P122MB0229933887662FDFFF9A43C0F2B09@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
 <3dc03baf-12fb-60f3-0284-6631db21acad@siemens.com>
 <87tu8fifxf.fsf@xenomai.org>
 <AM7P122MB02292C83BFE45FFDBBC341DAF2B09@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <AM7P122MB02292C83BFE45FFDBBC341DAF2B09@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--20.394300-8.000000
X-TMASE-MatchedRID: aGuL5piyGFo5QaOxwNGfvo9bHfxDWoib1xQ2OgXti5XdOaMxXy5omemS
	EcB/12NX8L1Hx/VFNwTZTAEszxrPVPGwUUhZtzr+xI6hO19AR22ijxnT+v7fnDjNGpWCIvfT/qW
	l+m17jWEhnmSpmb/95RMnvir+JcmKx6NPugrya27r9E4aIltZg/jb5G1WTK9EdXu122+iJtoesY
	pisPR2EPbcLOjMQj3p5TL6apB3DsrrxgoHOxdS0cYnGguSQEOkXOFTT+immjb4AIbmhYnu0ied1
	xvDzsH6n3aUwjMXzz+J5MEYOpUUO+ii1UmnRbispboK15uSCnA/QMF1B4qVfTCj6xe3SuezxEks
	T8U2vYN+pi1NCIyfG2tIXv9h8AUm2vKD6VRf2idWHBMGehDHi07HN6DyoeIKbMGKOuLn5FUxXH/
	dlhvLvwdkFovAReUoZvo+mFW19mBvwRMivGm2q/5nI8KIHQ65ceYYVCI3G5oZSUX8zcPGnzPkGD
	lkvVyH3unRG7yMq8WDUsxiH5L93DQT3MFs3iRuSofSpsyetKmV76rqTtD9zC/MuWzsdN8ZfS0Ip
	2eEHnzUHQeTVDUrIuB8J9aWc1v/VymkLM+r7VSQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.394300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 4A12579A277D27D7D0A81C4C0BCB3F64EBAD956F4F7042B276E1FBCBEB25A8822000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48955031-eed0-41eb-fa58-08da52d28484
X-MS-TrafficTypeDiagnostic: PAXPR10MB5231:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR10MB523191074FFA8C9DCBB9428895B09@PAXPR10MB5231.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/bRkykKfGAxrUnvi8x0RUe5N3micgXSI26sY/n8a1togC374KDgjiyg8wlY90t4aqctGCXtQO6CsjsEW3FRZrecNLwNYyddRjJOjYLX7o5K2AmQTyfMasPkf/i6n8Ax0znuMTufhr0yeX57RQCSUou0GwjopTnPQJEULB4jQkHxHwIQjmfyON4vd4z9rtzZVgANXQ6pL3S4rjOUm0l/2/r2pavb4EFxqhsZuvAxyGvzffcfPT028oWqGgH3BXcm/bQwc6Pn59ox3jS5MK9Naex/myRVhoCT0NN4uX6nDO1xNtoz3Q05OdB9oHDNINtjbvPHoOMmxrZfHfK9eK9QXIZGNc21rchsI1LxOl6zEOw3XylSegFLHmzqy/MGnhF+kxrsA/NEwCl93EF7YCnLWckO8DAOBHSBaeHXO0KaQdl7SKwtPWbrZffkS68qfXHvhwxZ8FJ3EaHy4xewyQ1+jY+kviDoGsp7NRdIx3a/P8Q3qDWrUmSsQBy/+3ydrFVgUilKonSalHtXzyAGMMcMEJcHlocw5q6E5IOFbvPLLkNpSFBmX74uqmiDTszHT5u4WyhLQYUtWQgENK0DsEqD98ethly7Of3AUc07AkzhxOAVtNeSQvbhiRrICV+tL+eppMYsNwpF/SMA5i3FVMHEQ1CTkZH3NsM4bdYhwxVaBr0LRCsSrcgDNENr9mhy1uB7TQRsW0ssCWyQ0w4yKib8tG/RWZYqMlfD3sxgcDTQPyifMQDudCgWFTEae5b2Pk3Jtk+ch7aOXALJ55zV8XM+apq4G/BsOf3uKzMFR4qqCptxpulDAC6k2wxmwtlRNSxh9sloVshYYhyEYxkIDBFGwRYN0sBJaS0sWxtXiZyFwWdyVwFB6YVe1VNjjSiuVNnLS
X-Forefront-Antispam-Report:
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966006)(36840700001)(40470700004)(47076005)(336012)(36860700001)(356005)(41300700001)(6706004)(2906002)(16526019)(70206006)(31686004)(26005)(16576012)(186003)(296002)(316002)(86362001)(2616005)(36756003)(31696002)(956004)(40480700001)(8676002)(81166007)(70586007)(5660300002)(83380400001)(40460700003)(8936002)(82310400005)(966005)(82960400001)(82740400003)(478600001)(44832011)(4326008)(110136005)(53546011)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 15:35:34.5734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48955031-eed0-41eb-fa58-08da52d28484
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT106.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5231

On 20.06.22 16:54, Grau, Gunter wrote:
> 
> 
>> -----Original Message-----
>> From: Philippe Gerum <rpm@xenomai.org>
>> Sent: Montag, 20. Juni 2022 15:58
>> To: Jan Kiszka <jan.kiszka@siemens.com>
>> Cc: Grau, Gunter <gunter.grau@philips.com>; xenomai@lists.linux.dev
>> Subject: Re: [PATCH] rtdm/drvlib: Prevent pagefaults on arm on io mapping
>>
>> Caution: This e-mail originated from outside of Philips, be careful for
>> phishing.
>>
>>
>> Jan Kiszka <mailto:jan.kiszka@siemens.com> writes:
>>
>>> On 20.06.22 12:44, Grau, Gunter wrote:
>>>> Hi,
>>>>
>>>> I added a dump_stack() in cobalt_assert_nrt() where the XCPU signal is
>> generated.
>>>> Maybe you can give me advice if you need better information.
>>>>
>>>> [   13.690407] CPU: 1 PID: 581 Comm: UT1  Tainted: G           O      5.4.191-
>> 00703-gbfba1d43d087-dirty #23
>>>> [   13.699901] Hardware name: Freescale i.MX6 Quad/DualLite (Device
>> Tree)
>>>> [   13.714083] I-pipe domain: Linux
>>>> [   13.717347] [<8010f314>] (unwind_backtrace) from [<8010b824>]
>> (show_stack+0x10/0x14)
>>>> [   13.725118] [<8010b824>] (show_stack) from [<8084604c>]
>> (dump_stack+0xd8/0xf4)
>>>> [   13.732365] [<8084604c>] (dump_stack) from [<801d8318>]
>> (ipipe_trap_hook+0x1b0/0x33c)
>>>> [   13.748287] [<801d8318>] (ipipe_trap_hook) from [<801be9d0>]
>> (__ipipe_notify_trap+0x98/0xdc)
>>>> [   13.748304] [<801be9d0>] (__ipipe_notify_trap) from [<80114114>]
>> (do_page_fault+0x20/0x444)
>>>> [   13.748317] [<80114114>] (do_page_fault) from [<80114800>]
>> (do_DataAbort+0x3c/0xe0)
>>>> [   13.782231] [<80114800>] (do_DataAbort) from [<80101f7c>]
>> (__dabt_usr+0x3c/0x40)
>>>> [   13.789655] Exception stack(0xc2129fb0 to 0xc2129ff8)
>>>> [   13.794735] 9fa0:                                     6c1d7000 00000600 72c61910
>> 0000013c
>>>> [   13.802954] 9fc0: 72bff024 72c618e8 004247c8 76ba5000 ffffffff 00000000
>> 004247c8 6a87da3c
>>>> [   13.811155] 9fe0: 6c1d9000 6a87da20 00020000 72bb5c68 20010010
>> ffffffff
>>>
>>> OK, a regular page fault that the out-of-band code in I-pipe was not
>>> able to fix up. The question is whether we lack some logic there to do
>>> that or if that fixup really requires Linux.
>>>
>>> Can you trace which resolution Linux applies to this after switching
>>> to non-RT? Or do you already have a suspicion, Philippe?
>>>
>>> Can this be reproduced in qemu-arm as well? With some dummy device
>> and
>>> driver? Would allow to examine it also with Dovetail.
>>>
>>> Jan
>>
>> The I-pipe is wrong at:
>> https://source.denx.de/Xenomai/ipipe-arm/-/blob/ipipe/master/arch/arm/mm/fault.c#L564
>>
>> Reporting a trap entry to the real-time core should be postponed until
>> __do_kernel_fault() can attempt to fixup the exception, in which case we
>> would remain on the oob stage as expected:
>> https://source.denx.de/Xenomai/ipipe-arm/-/blob/ipipe/master/arch/arm/mm/fault.c#L265
>> https://source.denx.de/Xenomai/ipipe-arm/-/blob/ipipe/master/arch/arm/mm/fault.c#L200
>>
>> Dovetail has it right:
>> https://source.denx.de/Xenomai/linux-dovetail/-/blob/v5.19-dovetail-rebase/arch/arm/mm/fault.c#L557
>> https://source.denx.de/Xenomai/linux-dovetail/-/blob/v5.19-dovetail-rebase/arch/arm/mm/fault.c#L279
>> https://source.denx.de/Xenomai/linux-dovetail/-/blob/v5.19-dovetail-rebase/arch/arm/mm/fault.c#L205
>>
>> --
>> Philippe.
> 
> Hi,
> 
> In complete absence of knowledge what I am doing I removed the extra code in fault_mm.c  😉 :
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index f712fa20aea2..2b46c67985cf 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -558,9 +558,6 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
>         return 0;
> 
>  bad_area:
> -       if (__ipipe_report_trap(IPIPE_TRAP_ACCESS, regs))
> -               return 0;
> -
>         irqflags = fault_entry(regs);
> 
>         do_bad_area(addr, fsr, regs);
> 
> I can confirm, that this works for me then without my patch.
> 

Yeah, but this is not getting us to the solution. I-pipe in general, not
just on arm, worked differently /wrt when a page fault was reported to
the RT core. That could be changed, but I don't think it's worth the
hassle anymore.

In that light, we should take your patch with an updated commit log to
stable/v3.2.x and older. However, I will drop it now from next which is
dovetail-only, thus not affected by this.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
