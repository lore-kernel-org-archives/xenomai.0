Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70055.outbound.protection.outlook.com [40.107.7.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1173C13
	for <xenomai@lists.linux.dev>; Mon, 26 Sep 2022 15:01:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaT76pMTzwW7gP45CDcb1QB4NY0iY1Y1oalqNZCqhD1N/WAOjbRGggPfHMNh5YA1LwyNSQFwPeoqAW864xypLUeGzqhlWZh2GE5VY91/E3glIGyzOzSMnK1F7WwMDDc1WJSSk7Z4pmnNt5+WXn/hoPFrTL1iCCZ7PHCZlCnOOUyuOT+IF1OHV5Ov3YjfxF1wbKx5J+MZQqFf/579zlXEvVdaNV7VECHTI01//2iptm8yxH8ijkRMPOa3/BQKBctMTQxj2vLQ/uwilri8rogWJ564kprA5xkaiRDjSbJ9FOUhR/xBwYhnkc/hfhdsEIiYvsR5EEkZ6jqhsaRgtAvu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQHRVM7SUkOb0NFDqnuH7Lgm+BCPhf9Y1obSmncPDzY=;
 b=M112ilvKI6h++1Q1dOxIflsQiofmkiNTQpPcMMMb0B+7+pzmwHSPy+EaQ8O3YwmMk/a9Lfmz9k92j3GaCX53DuUyt9p8DQy0OpdtIyiea+ISpSyKyj+VacTJlN0oZXGkiBuzJYGoEIWDlrq3ZgliJruyA28dTo6o8wr7XShfI5IfqhcJ8c17J0oEI0QU7gxQXDMoBiZL/KX/0XtQkwDow1dzC9MC+BHh1Xvb1GeaGY6Pi+7FBieG/axKxUtYxunWXyu5adk9GVousaFhy5gvJWlR/dTr886A7UG0DMpgY3aJ5ujnpo10ukHGJITsjVqVyWq8ZrhDQU1/oEfq0JM4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQHRVM7SUkOb0NFDqnuH7Lgm+BCPhf9Y1obSmncPDzY=;
 b=fRB5VC8wk3q10jObjdWK8hfY3trBpTI70AoKBPE7jSa0fnrD+EfWV/B7JN5we9olLX1BB0w6GaNjgU1LV2R/34FW3wrPj1SDg9qFB77O5izvtjaKSP2+UrAcajdJbhs92HD+U/xXFKB8LIuTDQuBHh6wMoxBYgGGgzN7oh2SjhT/yXY1QVkVS7n4+3V9ZMtqAn+CF/bafF/IRbQ3eo6s2BWeySyqSqe71Zm1zX+mO59NjfGkHBk+pCCZZGGQkfemoR2qRkeMmLj/0eo2ndvEy0wmxv301m21dYAWd8DnQz+HyyxHdNv4UfrNyBLHfMiu84wPTPJovoYoqy1uvnQukQ==
Received: from OS6P279CA0108.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3c::6) by
 AM0PR10MB3505.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.25; Mon, 26 Sep 2022 15:01:04 +0000
Received: from HE1EUR01FT025.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:3c:cafe::6c) by OS6P279CA0108.outlook.office365.com
 (2603:10a6:e10:3c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Mon, 26 Sep 2022 15:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT025.mail.protection.outlook.com (10.152.0.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 15:01:03 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Mon, 26 Sep 2022 17:01:02 +0200
Received: from [167.87.17.23] (167.87.17.23) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 26 Sep
 2022 17:01:01 +0200
Message-ID: <d8d6fdd9-0035-b087-a348-5190a1769e6e@siemens.com>
Date: Mon, 26 Sep 2022 17:01:01 +0200
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
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Zqiang <qiang1.zhang@intel.com>, <rpm@xenomai.org>
CC: <xenomai@lists.linux.dev>
References: <20220921031416.445763-1-qiang1.zhang@intel.com>
 <a3e806e6-8f9e-6935-561f-b05ee7be88e5@siemens.com>
In-Reply-To: <a3e806e6-8f9e-6935-561f-b05ee7be88e5@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.17.23]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.296900-8.000000
X-TMASE-MatchedRID: AQ9SOYvqpDY5QaOxwNGfvo9bHfxDWoibO5k/PxBAvv6JUlmL3Uj0mA/o
	5bNHEsCTvn1ivDdpAIflfQ4dEl5mF4HPWllJx5O/dPhh3aRUoXu1j71uqD+zcoS/TV9k6ppA4Sk
	IdSwphgbfUY2boz4kpPcwyVYGZr7IHz45mzJ+08UsH4a1ASijvcmq8U2/MJXWPaBTJyy84wV6i6
	96PjRPiNzONa1Rspx3QBzoPKhLasjWsfhGDQA5PRmGGSZ2LT4ZETQD7c8+Qlq628cXbnOhTzZJJ
	00SAjewj1UOAOjhpZHIcj2m+H71byvn27+DO/kwtTOrxEGQm4ZJI5ZUl647UDl/1fD/GopdnCGS
	1WQEGtD8V77yhJRgozDmMp5UGBhvC24oEZ6SpSkj80Za3RRg8B8P1H96NdvUhdzffpCVbrBR/te
	Ko7OEn7dHhy2JHaY47phmB2X9ZH4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.296900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 95FDD996A90B4103C2CB74A2DAA012343090BF020EC8D3B74A7C65308166017D2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT025:EE_|AM0PR10MB3505:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc4a4f5-6ec0-4c04-7e67-08da9fcfee8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YBEYZlfuR3vq9DJVaiR1Y8m57+PmfICD+2/679/Q+IvJxkEH/al26u5LYojGtMjmOAKqqZCtWF8MW3gQHBUvb0s3MYoO1KMebx+5qpZEDoz+JloJhgaKrYCkrl9ZYznDZy0P/Naj6hMLUai84VYNQtvd+mo2FFJURl+URU50c2CGnj6cZxFYWH8lqRFt0Fo85ejxIC6IjtwzlUubT2z5THGAAX2MZje4EBZP7CmxIU+bXnbnOgQltF1BmNrc+Hh1hXpFoNQeUF7cYvUCs7SoVNbcqoF4qKCkWD+7nn0XxBRgNhDZZuCQ+AH5epSalaTwBcunv5XZevndqaAJsJpFo+L3kDOdqhRHrawcHtKSPSQo8ppLOn04rKzP6sWokGzn6SEJgZWub7qC1030QwScudkFnldKe3mcQKJgSmLHddAEdjuCuwssLqpqSok3N1t7BeN/P7uTOr2TkyjMd/5tXGgyto83I9d8Jw4kVU+xnpCIyl2cEGUk9iP2nJmkdEpPX5/6AfV+uI/nkq0KpAxn0tJds5rYasSYpDquEUkUA/wxZxAjn/xRsPaw+TXpNehUp2bQ9PMvJjuJMHb4fU3YN9fuGhyyfyTGjrR7hCL3U+AK9wTGNoL1FkCc526I7S1V8QxDxBki6ObObt5HoCNuaT264nvfZVbQMg9+51v4R7rZkITGrpeQfUdF/9xsE7lzux9VYmVBA1VKXdS0arys+wAwdX3cIuAIcGNHi5lPTnzYoCJaQIIcC8v/RWdfZeXlf2Of1gAx0J5+5AMEQNu+yjgdQlTqqAObxCuRx7HwooQQ7TfEm3kYGi3ArWAf1Kyy0z6WIGKFCPcV/CygFF6pvWDrNU6PhBY1hOfJFm6+xqI=
X-Forefront-Antispam-Report:
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(44832011)(53546011)(26005)(5660300002)(36756003)(2616005)(956004)(8936002)(2906002)(70206006)(70586007)(4326008)(8676002)(41300700001)(31696002)(86362001)(40480700001)(82740400003)(47076005)(36860700001)(336012)(16526019)(186003)(82960400001)(81166007)(82310400005)(40460700003)(356005)(316002)(16576012)(110136005)(6706004)(31686004)(83380400001)(478600001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:01:03.4615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc4a4f5-6ec0-4c04-7e67-08da9fcfee8e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HE1EUR01FT025.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3505

On 26.09.22 17:00, Jan Kiszka wrote:
> On 21.09.22 05:14, Zqiang wrote:
>> When kernel enable CONFIG_HARDENED_USERCOPY option, since not marking
>> rtskb_slab_pool cache is usercopy type, will trigger the following
>> calltrace.
>>
>> [  594.413602] invalid opcode: 0000 1 PREEMPT SMP PTI IRQ_PIPELINE
>> [  594.413603] CPU: 2 PID: 492 Comm: rtcfg Tainted:
>> [  594.413603] IRQ stage: Linux
>> [  594.413604] RIP: 0010:usercopy_abort+0x77/0x79
>> [  594.413610] Call Trace:
>> [  594.413610]  __check_heap_object+0xa6/0xc0
>> [  594.413611]  __check_object_size+0x136/0x150
>> [  594.413611]  copy_stage_1_data+0x48/0x70 [rtcfg]
>> [  594.413612]  rtnet_rtpc_dispatch_call+0x151/0x320 [rtnet]
>> [  594.413612]  ? cleanup_cmd_del+0x70/0x70 [rtcfg]
>> [  594.413612]  ? wait_woken+0x70/0x70
>> [  594.413613]  rtcfg_ioctl+0xa0/0x250 [rtcfg]
>> [  594.413613]  rtnet_ioctl+0xdf/0x170 [rtnet]
>> [  594.413613]  __x64_sys_ioctl+0x83/0xb0
>> [  594.413613]  do_syscall_64+0x39/0x50
>> [  594.413614]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> This commit make rtskb_slab_pool cache being an usercopy source.
>>
>> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>> ---
>>  kernel/drivers/net/stack/rtskb.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/drivers/net/stack/rtskb.c b/kernel/drivers/net/stack/rtskb.c
>> index c9042db93..fa75ca6ec 100644
>> --- a/kernel/drivers/net/stack/rtskb.c
>> +++ b/kernel/drivers/net/stack/rtskb.c
>> @@ -497,10 +497,11 @@ EXPORT_SYMBOL_GPL(rtskb_clone);
>>  
>>  int rtskb_pools_init(void)
>>  {
>> -	rtskb_slab_pool = kmem_cache_create("rtskb_slab_pool",
>> +	rtskb_slab_pool = kmem_cache_create_usercopy("rtskb_slab_pool",
>>  					    ALIGN_RTSKB_STRUCT_LEN +
>>  						    SKB_DATA_ALIGN(RTSKB_SIZE),
>> -					    0, SLAB_HWCACHE_ALIGN, NULL);
>> +					    0, SLAB_HWCACHE_ALIGN,
>> +						0, SKB_DATA_ALIGN(RTSKB_SIZE), NULL);
>>  	if (rtskb_slab_pool == NULL)
>>  		return -ENOMEM;
>>  
> 
> Thanks, applied.
> 
> Jan
> 

v2, I meant...

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

