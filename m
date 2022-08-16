Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150058.outbound.protection.outlook.com [40.107.15.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F061FAC
	for <xenomai@lists.linux.dev>; Tue, 16 Aug 2022 06:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkrBQo/k1p55O+x+cW203cK8VY2Gu0WHz1F9BonPrmjjlxNZUoLP1HIUD4XvIor1JuCWTLzIFdX5i2ynk50Jc2fMLgMvtKkOOBl8aC9N3opcEr31SM40x/EC5Yuz85PE+VVbEolC+bkODme+17CrCNKCW7NJsVf2WqA0l9sAlKTzp95RKoICgQzeyPdAV3RKPcqvc2oEMV5TrIB7j/Er3XBJvIY56AfCZlaD8I9hqZDF4Spd5XP+utZ4OY3KIFyDD/PofqliPoPG87k2BxFOCmKOOhPIT9jVDXXeRQsF09067FS5LiTMIBDfLewNaODDO3I7Eop5Cus70OxS034Wpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr1H4V0qiZQqDYK7HFIsfT36UZLVYBNWxahE8laMeYA=;
 b=IMP6/zjJ4zqjGctIpLtbdzTJmsKBgkpZys77/keBwgudx4KkrDWbPZp8LKln88Y9SkgOUy1eKG5beaqZicW4/hit6G93LPOVR53VWerBGBcD1ZO2nme4ZJ4SJ81JymuZkwNsai13u7neacytdjWh7ptoLihJuZCt6bDb2W05tIjLTqqphPclJc73dWE1p7d+qZqUQJ/NQ1hPJwJ6EgP5EIYLNnwIMYnaR0LuHmlxKF5vJv3bye40xTeTuCZLoo/97kdozQdvjqTBYvCEwxRYgc9p0IhoruCpHGRlh08G8ZrB/WTPLiko498NaFQbzg3soLg3SvvnC+Y+NUTwMKg38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=philips.com smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr1H4V0qiZQqDYK7HFIsfT36UZLVYBNWxahE8laMeYA=;
 b=fnSuW33a8Wb6oOSAOpCWRryKwozs0noUotbZlcVwXlC1YjKA2glVtvkqLb/Yb6CmJLqTqk1XO35wr71X2KOw9QMPzvuAF50GoZxK7eZiuSpexbenFISgCUBTEs7V/GpBh+NBdllnOmTPy03lMbxLFkiHS7VVUK22nmknf6jOIB1Zs7YvWBiUelTFcSsHIXnNFBaNoUXpd4kR7U/dz8mxOSG0L3IRMXNulEvBQ5BZ+Hae5XEFe3wtSayAM49e5T096LgVictrknIxP3UmeKokIBka4jFo/q0nykHywXIojxfNSAdS3yQcS40x9Xfh9V34WTBZrULChvXvyDcC6B2OTw==
Received: from AM5PR1001CA0027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::40)
 by AM9PR10MB4546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:272::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 06:23:40 +0000
Received: from VE1EUR01FT008.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:206:2:cafe::89) by AM5PR1001CA0027.outlook.office365.com
 (2603:10a6:206:2::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Tue, 16 Aug 2022 06:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT008.mail.protection.outlook.com (10.152.2.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Tue, 16 Aug 2022 06:23:40 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 16 Aug 2022 08:23:39 +0200
Received: from [139.22.139.114] (139.22.139.114) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 16 Aug 2022 08:23:38 +0200
Message-ID: <2054e69e-237e-2c96-be14-3ce28510382d@siemens.com>
Date: Tue, 16 Aug 2022 09:23:37 +0300
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [[I-PIPE PATCH]] ipipe: noarch: Fix ipipe level end interrupt
Content-Language: en-US
To: "Grau, Gunter" <gunter.grau@philips.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
References: <AM7P122MB022949A2E0ADC59FCC8809BBF2689@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
 <20220815102704.1825151-1-guntgrau@bbl.ms.philips.com>
 <72810e59-33db-821a-64c1-8e2c41bdacd4@siemens.com>
 <AM7P122MB022912FC857E9E50CE2B1063F2689@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
 <25363307-a86c-8c42-363d-2538a0f97c6d@siemens.com>
 <AM7P122MB022995525A5F20BCB36237B8F2689@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <AM7P122MB022995525A5F20BCB36237B8F2689@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.139.114]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--23.771100-8.000000
X-TMASE-MatchedRID: SPXcha2wtZzPhQMrvkSA3r6YI58LYP7EXKlUkWaHqwvx5KZMlKYS/ZLc
	b1TGljGwLdSo4PD5A3qbF/hSFVTmxfPb88/HqcTUd69Q6+2T30x8+ZRBAbr2nHl14Xo5Ir2XAPi
	R4btCEebM/0sSqPZieKECocuoPkaB05ptvg4xWi43hu8snJh6Pghqxc+Vy0t0X1J8nCIowYDYUD
	vAr2Y/1wQsw9A3PIlLKtZ1n5KOURnBioCU75hrEZPrkLG7Agm3xz6opuAAUJIacx73gxEmrDQjc
	FUdgOJXSStniYWNNsPJ38psbhUSW1or28p4LrnNmxwLkNXVJ7liWV0DQ85LUrMVsrxMTyheyeUl
	7aCTy8gjIzpupoCXK43Ea5VcsfoB7X9NSuUk7CCFClSci0DxSyNSgIz9w6XA81y25CVs6CSlY4F
	8r0vXPyvFSzw3D/Z++8EgqsLKfjbuo3YBjUsFh2QrDbvYZGaI4hjUBITbCT51e7Xbb6Im2oQu+X
	fLPysKuSti1BoHqPYOWsosQNwjnBtAdLvrTLYyi7y/x0H2N2K8+Qw9PrZG9W5eAiqrqZDK9FT70
	9M8dJiHPSXOyvGapqPFjJEFr+olA9Mriq0CDAgBi3kqJOK62REK+kazaxoyfwO+RRpsStUqtq5d
	3cxkNfAxRSAc0OENIuJieNVvzvp+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.771100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: B892C8BC4B9016E0D1DCCED46BDD46F4E9D03A32C6E92CCC47D0EE99B6514BFE2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dde8a3f6-b228-4af6-9986-08da7f4fdc80
X-MS-TrafficTypeDiagnostic: AM9PR10MB4546:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEtOTVB0UTBmYlJld3dOWTZ3cGVTWWE4cjlQUjUyNTZHWnd6U1FRazJ0bnAv?=
 =?utf-8?B?dXpubEJYMTNBekpqYnNXWXBoeVV2OXBydWRjZXJscGVLaVhCVmVGUUw2ZWVY?=
 =?utf-8?B?bmhRSHRNbWIxYkh2MkRsNkRxU3NqcDhCYStVWXM2bTBUelhndWEzVVNTUE5G?=
 =?utf-8?B?OXhlZFpBVEhSb3NnRXNHdlpuazNyL2ZLNno5cmVxT1NDZXlpVmpPVW9MQ1Nq?=
 =?utf-8?B?WjdreFd2aG1CWXlHTHdaVW1uczhOZFN6UkEyZXlSQTRqMStuSUNNVDRmWmNn?=
 =?utf-8?B?QTFCRVFObVdaMjRKQXBrK3pOZXdkbEFrNWVnMDZDNHpJbzZpWmJVM29GOWw5?=
 =?utf-8?B?LytQZE9qY2pyUEJhWVNGVDFBamg2WFFMa3c0MUVGcXAyem9NandnL3Rtdks3?=
 =?utf-8?B?Q2wxQ2gxR3N5MEErQ3dCL3hjZ3hwelJhRXNTajBlWlNzR3J6UGdlQWM4NUQy?=
 =?utf-8?B?ZnltdDBVcnlVVWtYbFFuWWxrTTdWT3NzdHZSYlRFRkxQY3JsT2RjZjUrZDBT?=
 =?utf-8?B?cS9xdUUwdnNTOU9Bbk5ZTXhjQmtlZUljc3lleFhtOGp4dS96REV2SzBFR1I3?=
 =?utf-8?B?RHEwL1VPeGQrQVFUUDRNWUI3VDVDWFpXWVBxWCtmaStQWDM5NnBVYk4xdnlu?=
 =?utf-8?B?YnZZMFdKclB4RXA5aHlLQVFIT0Z0NHpjaUlRTTJOYVJaREFXZnNZdmhFRmhB?=
 =?utf-8?B?WUNXQi9vTzhnc29qWFNEUjZWdDk5VnFyeExDRlFXQ3QzVkZvdXgwNUVPWVZs?=
 =?utf-8?B?S09UVGp1Q1RrNDRFNW95Lzl3aktmMDhDaU0zWjB0QWJ4Zmc5T1FJc0dhaTBJ?=
 =?utf-8?B?RTV4QUdsdzRiRndFVXpkeGdBS3hEVDAxNXNQVS9ocnVuN0gzTEFYM0pYNkVH?=
 =?utf-8?B?TFNOMjZRU3prU3RPRXQ5QnM3N1U0WmtzUWRIVlJqRlJVUmttMEdrU3VXTEsz?=
 =?utf-8?B?bFpyOWxQRWUxQTBtSWF4T0JwditpeDg5ZlREUFFiZ05Hb0JlekVvRkJNZk81?=
 =?utf-8?B?NXAwVWtaMlNueWtBTC9EV2luZ1FqUU55aW5IcXg1VjJRK1B2cWVaQitna0py?=
 =?utf-8?B?SURkbFhFa21QbExHcGFwbnluZml6WStlN3FnM3RDMnZRWThQRHJuNE04L09p?=
 =?utf-8?B?NEZ6OHgvTFdTRHNFOFVtSm1rbVk5U0JCZzRabjlaKzRERWEvWVNwaVBPKzVC?=
 =?utf-8?B?akh4R2Q2azRrRlVsNWgyRURRUWxGUHZEWTNEZ1BjWTR4UDFXKzVLYWY4WWsv?=
 =?utf-8?B?SGNqZ3k3QWdwN0ppNG9zQndHYituY2Z1NTVKVXkvaGRGY2UzUT09?=
X-Forefront-Antispam-Report:
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(40470700004)(36840700001)(83380400001)(8936002)(81166007)(82740400003)(356005)(82960400001)(86362001)(36860700001)(31696002)(34070700002)(70206006)(40460700003)(16576012)(70586007)(316002)(8676002)(6706004)(2906002)(110136005)(82310400005)(956004)(26005)(5660300002)(53546011)(41300700001)(44832011)(336012)(186003)(16526019)(47076005)(2616005)(478600001)(36756003)(40480700001)(31686004)(87944003)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 06:23:40.4280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dde8a3f6-b228-4af6-9986-08da7f4fdc80
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT008.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4546

On 15.08.22 18:24, Grau, Gunter wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Subject: Re: [[I-PIPE PATCH]] ipipe: noarch: Fix ipipe level end interrupt
>> On 15.08.22 15:31, Grau, Gunter wrote:
>>> Hi,
>>>
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Sent: Montag, 15. August 2022 13:56
>>>> To: Grau, Gunter <gunter.grau@philips.com>; xenomai@lists.linux.dev
>>>> Subject: Re: [[I-PIPE PATCH]] ipipe: noarch: Fix ipipe level end
>>>> interrupt
>>>>
>>>> Caution: This e-mail originated from outside of Philips, be careful
>>>> for phishing.
>>>>
>>>>
>>>> On 15.08.22 13:27, Gunter Grau wrote:
>>>>> From: Gunter Grau <gunter.grau@philips.com>
>>>>>
>>>>> There is the possibility that a new level triggered interrupt is
>>>>> already waiting when __ipipe_end_level_irq() is called.
>>>>> In this case at the moment when the irq is unmasked it may already
>>>>> fire and call __ipipe_ack_level_irq() before the masked state is
>>>>> cleared in the irq description. If this happens mask_irq() called by
>>>>> __ipipe_ack_level_irq() will not mask the interrupt and the system
>>>>> my stall.
>>>>> To prevent this, the masked state will now be cleared before
>>>>> unmasking the interrupt. A following direct interrupt handler call
>>>>> will then correctly mask the hardware interrupt as needed.
>>>>>
>>>>> Signed-off-by: Gunter Grau <gunter.grau@philips.com>
>>>>> ---
>>>>>  kernel/irq/chip.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c index
>>>>> 6a883a4cee87..25d0942b592a 100644
>>>>> --- a/kernel/irq/chip.c
>>>>> +++ b/kernel/irq/chip.c
>>>>> @@ -1048,8 +1048,8 @@ void __ipipe_ack_level_irq(struct irq_desc
>>>>> *desc)
>>>>>
>>>>>  void __ipipe_end_level_irq(struct irq_desc *desc)  {
>>>>> -     desc->irq_data.chip->irq_unmask(&desc->irq_data);
>>>>>       irq_state_clr_masked(desc);
>>>>> +     desc->irq_data.chip->irq_unmask(&desc->irq_data);
>>>>>  }
>>>>>
>>>>>  void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
>>>>
>>>> OK, but if we need this ordering here, why didn't we need it before
>>>> for unmask_irq()? There, it was sufficient so far to disable local
>>>> irqs around unmask + clr.
>>>>
>>>> Jan
>>>
>>> Interesting, I thought the disabling of the local irqs is exact the reason why
>> it works in contrast to __ipipe_end_level_irq() without disabling.
>>> So did I miss something? Should I add a local disable here, too?
>>
>> That's not yet what I suggest. I just first of all try to understand the boundary
>> conditions for the issue here and if those may apply elsewhere.
>>
>> If I look at the caller of ipipe_end_irq in Xenomai, none should have hard irqs
>> on when invoking this. And that means, when local irq disabling is not
>> sufficient, unmasq_irq may have the same issue you are trying to fix here by
>> reordering.
>>
>> Jan
>>
> 
> I tried to follow my issue by dumping the stacktrace in __ipipe_end_level_irq(). Kernel is still 5.4:
> 
> [   34.590806] [<8010f314>] (unwind_backtrace) from [<8010b824>] (show_stack+0x10/0x14)
> [   34.598601] [<8010b824>] (show_stack) from [<8084724c>] (dump_stack+0xd8/0xf4)
> [   34.605877] [<8084724c>] (dump_stack) from [<8017c160>] (__ipipe_end_level_irq+0x20/0x30)
> [   34.618312] [<8017c160>] (__ipipe_end_level_irq) from [<80177f90>] (irq_finalize_oneshot.part.1+0x78/0xf8)
> [   34.628031] [<80177f90>] (irq_finalize_oneshot.part.1) from [<80178080>] (irq_thread_fn+0x70/0x78)
> [   34.637044] [<80178080>] (irq_thread_fn) from [<80177e44>] (irq_thread+0x170/0x244)
> [   34.646751] [<80177e44>] (irq_thread) from [<80148fa8>] (kthread+0x14c/0x150)
> [   34.654879] [<80148fa8>] (kthread) from [<80101118>] (ret_from_fork+0x18/0x24)
> 
> I also thought the irqs are always off here. But I cannot explain the current issue otherwise.

In that path, hard-IRQs are NOT off in fact. I only checked the Xenomai
code paths but forgot about the kernel ones.

But even if we disable hard-IRQs here as well, that would only protect
us if that physical interrupt can only be raised on the local CPU. I
don't think we can blindly rely on such an assumption (except for percpu
irqs).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
