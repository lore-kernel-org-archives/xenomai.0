Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78ED7E0
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 06:40:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXpF9c6ubtl4XNTLBudafi/V93Fh8I/hcL7UIert6+Kq7mDJ1kEb6PzHNIMeyp5ExhDQV9Cd2g5j3Fts1/VtVVKQb774IsQCc/3k7hw4YrVjrV8aA7BSEcPVgXeWCW7SOQxqlqa1bt9C/vScIUboODwi/yg/xhepNW9YN9PzmPxh4uOalbmGicPhC6FarJOlRwOSR/OGSAK6KCCSv18PkPBgPKJkZ3WijavGylTenQasFUdZEWNvYVXPm8iy6e0FxfJjDuchOskX/UAXf4n5BVjwJ0njl9MAyqLrstc6sY60HJZetQzsZNQHaVzm/NKGO1gj11iVEt1z3ynY6JKbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whDUcjRQnHdFJ/Evyewpj7i9qopXMCTU01+eHiSAt5c=;
 b=fH7GNPnEdDlK7e2iihyPXKtpxH7hlMTOg47X1JyH6y62U4g1k7tiYBId9QQsK13ZToss31NZb4Uow/gH991/VEWokbYnEZ1QV+Qkv4r4bjvfJElu5XSNPi67uVF9Fo1KSboF79I/9RcuNKhvF2NQ5B3puoHbQ+t6arZA78KD62uJEYH/Q6piytncYrySeaWUjzaxWbq5ABtfHGj2zCd0G32q7RiK4DRAOxB7cMa1HxgPdp7Gax7EbrBN3gPB7silVCpeU2cSO/cWvQ/fisSHUIjSfM5NCoRMxQMdohnRxkE8eHff9ciPHC0tyUCF3dPog4QWQx7gQu2YdxQBRH8+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=philips.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whDUcjRQnHdFJ/Evyewpj7i9qopXMCTU01+eHiSAt5c=;
 b=vD9IMjsFarvryglhTaSTiRpJlja+rYE0+ShdX+HZygO3YlkjTbr6eHrFX5XkFLAsfFpIvR2LYGDhAZHdzFvHubZKr8BRH2flxk7JUvjLOyIcLuj7ghoAvi8QzrysdkGVWcmS1IaVceE0MJtskDoetD/LW3TkTTZn7g/1CkHHOBLGwTrONDjHCMYSHKXoZuXLczY1h8Kd3vJvlWoB32glqhiLAss7jU9mKNE6a754iHIaGid58v+Q87v72TWTxuG6pSeV7uiEVXWF336IaDfIDSL4egASJWYyMyGD4OkbY01vm5Z3hkDqNOfyCH/i+e29lM40ZK0GJtqkLaV7IysxWQ==
Received: from OL1P279CA0012.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::17)
 by AM7PR10MB3589.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Mon, 20 Jun
 2022 06:40:06 +0000
Received: from HE1EUR01FT087.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::b9) by OL1P279CA0012.outlook.office365.com
 (2603:10a6:e10:12::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Mon, 20 Jun 2022 06:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT087.mail.protection.outlook.com (10.152.1.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 06:40:05 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 20 Jun 2022 08:40:03 +0200
Received: from [139.21.16.131] (139.21.16.131) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 20 Jun 2022 08:40:03 +0200
Message-ID: <cd3fcfaa-0432-feaa-b69e-f3983f200529@siemens.com>
Date: Mon, 20 Jun 2022 08:40:02 +0200
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
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Gunter Grau <gunter.grau@philips.com>
CC: Philippe Gerum <rpm@xenomai.org>, <xenomai@lists.linux.dev>
References: <20220523140444.2632658-1-guntgrau@bbl.ma.philips.com>
 <59e12ca2-6c6f-09ff-5365-985586dc4e4e@siemens.com>
 <87fsk6pddt.fsf@xenomai.org>
 <06fc6d18-891c-e0b0-51a7-4b21f49e2add@siemens.com>
 <87bkuupad5.fsf@xenomai.org>
 <b6d70f96-0e67-241b-fb4f-4d822933d05e@siemens.com>
 <e876977a-4f17-d075-b9e7-1a096ea29949@siemens.com>
In-Reply-To: <e876977a-4f17-d075-b9e7-1a096ea29949@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.16.131]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.558300-8.000000
X-TMASE-MatchedRID: 135NFiUt/83nZ4rrQzk8iiGRjDhB4tc5PXdZx1sZHpD2b09s2KGDsAvx
	MaV6x4s8FWKVb1PZ1Sm1jg3WdTw5hJqvf1vJTZ68EzvXiPvr1j6FILFr/FCwnwm147FwLa2K1B5
	mjfppvWAEYgC0OdgnwlZBB8y9CahzQfzj568mLeqOgM+McgCEws+9kIneOZlhfJy8LojR0kjr3E
	41VlKsfVVkJxysad/Ic375ob0IzN0Z6pYBwZFfCqvpdbv01AN5Mda8WztFgDLece0aRiX9WrzET
	YfYS4xZjlXUAIjJm2ei5pcT+t5JmSO8EvmKde78KSvWfUcRwV9oRvAKYVTCojocbof0WiRxAgvM
	6h73BtoINpIFnbd6muhoFHLBuVWKnhYxnndpkBaqc+Y7z/TlXXvkTOgyYAhEeXXhejkivZfzZKD
	A1/pIrileBpqCo+tItf2GcyrOX7t1wJmEbc3cN8o12pSoBBbf9nZNOQQHg+pn3ejPjd19cVmirz
	mgRbYUwU139rkATMS0y3Da3B9hq+LzNWBegCW2RYvisGWbbS+3sNbcHjySQd0H8LFZNFG7bkV4e
	2xSge4OsI2ZwiJmIwHoiOIbToGTBJxIQLBnAq9mCn8x4vmvZuulxyHOcPoH
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.558300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 B5EE56534A1F69E6B1B62021451674150ACA1522E4A2C7700CC58D0AD121E7162000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 840e4efb-e2d1-400e-70d3-08da5287b666
X-MS-TrafficTypeDiagnostic: AM7PR10MB3589:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR10MB358935982636097C829AA14295B09@AM7PR10MB3589.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kxautqglGKQnN7/JfGQBrNS3sA5rsuXeIJrmTAVL0bQ2nk20VikPymA5NwoUgC/qeQgCBgy8/y+xzPu5n74XdrLqSDAP1FZNN9DNXAEOS2HCAcRVKBpsybHf4DL/3Ia17xZs8uToJJBdfvfGadeK8c7mWx5JIckJO85IAZUXUbhi1xyrAEwNZVakySxdJAncnD+AIBdCd5TSuXN6pWiL85j/pBnUJEBkbKGR0vLV4yCRrxzcE/hKFtkUivZLCQWHRa0+TljAUm4jb9FzQR0sqbT6uuPwvUIoF/Lk/R8fLZPkzk/w8aT90NKIu8NfN8/F1fuhSjrI5ducubeJEsYi+P/Bg4y89dMtSaZA0FNk5Ol7HKJlJNe5d7SfQn6hwRTAFgCgzevm6xB8chhBAfR3hMzLz3KCntz1f7mOVzHFwzN8U3VGmUabLoo1MgRWnLNoli/cqwFN6V+LACOTbiZVr4anTw3l7vT49czXqaSv5XoxJ8Du2TasBeflB7gHojhK761qS1euBdX59nmvylrJJxp4/5rtRfggst39iXcvGBsedkBzp28kiNiTKSnGkhMYSgxUkH7bGVssKZcxKk4ZLtudISIszVvWxo6AQB8aNP6YNwiTKx5imjeKfwLj1OssQVJpE4SJ0zhsgih+ZOjbn67ibKp2eHLrQ9MpZ+uk6iOtjBVQOuxCtlXXmROdWIjdB/A7d64evz/2d3ySXIgK37H7c5uOjHXBFtU89NwXIQ5sNt2IG+n0PHUduzlKJwI4gIEY5GAbf9zt2Sdp9MAPWA==
X-Forefront-Antispam-Report:
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(31696002)(86362001)(356005)(82960400001)(2616005)(26005)(316002)(40460700003)(956004)(47076005)(83380400001)(81166007)(336012)(16526019)(186003)(53546011)(5660300002)(8936002)(31686004)(8676002)(4326008)(70586007)(82310400005)(44832011)(296002)(36756003)(6706004)(498600001)(16576012)(2906002)(54906003)(36860700001)(6916009)(70206006)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 06:40:05.9727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 840e4efb-e2d1-400e-70d3-08da5287b666
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT087.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3589

[forgot to update list address...]

On 20.06.22 08:38, Jan Kiszka wrote:
> On 15.06.22 11:55, Jan Kiszka via Xenomai wrote:
>> On 15.06.22 10:30, Philippe Gerum wrote:
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 15.06.22 09:54, Philippe Gerum wrote:
>>>>>
>>>>> Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:
>>>>>
>>>>>> On 23.05.22 16:04, Gunter Grau via Xenomai wrote:
>>>>>>> From: Gunter Grau <gunter.grau@philips.com>
>>>>>>>
>>>>>>> When mapping io memory into userspace an extra simulated pagefault for all
>>>>>>> pages is added to prevent later pagefaults because of copy on write
>>>>>>> mechanisms. This happens only on architectures that have defined the
>>>>>>> needed cobalt_machine.prefault function.
>>>>>>>
>>>>>>> Signed-off-by: Gunter Grau <gunter.grau@philips.com>
>>>>>>> ---
>>>>>>>  kernel/cobalt/rtdm/drvlib.c | 10 +++++++++-
>>>>>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
>>>>>>> index 4eaf3a57c..db8431ee1 100644
>>>>>>> --- a/kernel/cobalt/rtdm/drvlib.c
>>>>>>> +++ b/kernel/cobalt/rtdm/drvlib.c
>>>>>>> @@ -1761,6 +1761,7 @@ static int mmap_iomem_helper(struct vm_area_struct *vma, phys_addr_t pa)
>>>>>>>  {
>>>>>>>  	pgprot_t prot = PAGE_SHARED;
>>>>>>>  	unsigned long len;
>>>>>>> +	int ret;
>>>>>>>  
>>>>>>>  	len = vma->vm_end - vma->vm_start;
>>>>>>>  #ifndef CONFIG_MMU
>>>>>>> @@ -1774,8 +1775,15 @@ static int mmap_iomem_helper(struct vm_area_struct *vma, phys_addr_t pa)
>>>>>>>  #endif
>>>>>>>  	vma->vm_page_prot = pgprot_noncached(prot);
>>>>>>>  
>>>>>>> -	return remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
>>>>>>> +	ret = remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
>>>>>>>  			       len, vma->vm_page_prot);
>>>>>>> +	if (ret)
>>>>>>> +		return ret;
>>>>>>> +
>>>>>>> +	if (cobalt_machine.prefault)
>>>>>>> +		cobalt_machine.prefault(vma);
>>>>>>> +
>>>>>>> +	return ret;
>>>>>>>  }
>>>>>>>  
>>>>>>>  static int mmap_buffer_helper(struct rtdm_fd *fd, struct vm_area_struct *vma)
>>>>>>
>>>>>> Wow, that was likely broken by the refactoring in c8e9e166, long ago.
>>>>>>
>>>>>> Applied to next
>>>>>>
>>>>>
>>>>> The prefault hook has always been specifically about COW-breaking, I/O
>>>>> memory has no business with this, so there is no point in having the
>>>>> iomem helper calling the prefaulting hook.
>>>>>
>>>>> I suspect that rtdm_mmap_to_user() should be called instead of
>>>>> rtdm_iomap_to_user() in the case at hand.
>>>>>
>>>>
>>>> If Gunter is mapping IO memory, rtdm_mmap_to_user is surely not the
>>>> right thing.
>>>
>>> The xenomai2 implementation had a single helper dealing with I/O and
>>> kernel memory mappings (from virtual and linear memory) altogether. So I
>>> would not find impossible that wrong assumptions could be made from
>>> this implementation.
>>>
>>>>
>>>> Could it be that the prefault callback also has the side effect of
>>>> setting all page table entries that would otherwise only be filled lazily?
>>>
>>> Yes, this could prevent PTE misses, however I would expect minor faults
>>> to take place, those should be handled directly from the out-of-band
>>> stage.  Otherwise, this _might_ be an issue with the interrupt pipeline
>>> used. The prefault for ARM was kind of a hack to work around
>>> shortcomings from the generic COW-breaking mechanism implemented by the
>>> I-pipe on ARM (IIRC, this had to do with LPAE support).
>>>
>>
>> Gunter, could you take a function-trace of that very first fault without
>> your patch applied? Then we may see better what actually happens here,
>> specifically if your patch just happens to paper over a real issue.
>>
>> BTW, you only tested it with I-pipe kernels so far, or did you also see
>> the issue with dovetail (5.10+)?
>>
> 
> Gentle ping on this because I'd like to decide whether to move the patch
> forward to master - and possibly stable trees - or drop it from next again.
> 
> Thanks,
> Jan
> 
