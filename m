Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B3C2FF
	for <xenomai@lists.linux.dev>; Mon, 14 Aug 2023 17:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y12Lc6AIVaaw7F0sR5wN16r4JOEtBLXMJXI6OlpSWUT13Ew3zr1irfrq+ekhooQz+kaU5inxg5dUX/0C7MSli5Y65go+7Xd/7X1d4XnAzljhM6V3xvOENLfsO/MDXdlJnD1/iFI8VKnJ2dOAwS8y7j8ojbbifKAZChfSEt66Lhf/x2F/Qm69mByD587EDSXOhVoNNcVNJVNmWYLZW4DbD9eGYtKu01F7buOXui7vatR7Uu0Jf6Lkt39mSoPa+G+7fNVyp8Cz+3Ovp6ngFglY71vhyxUgrs/Sk3Jxj2QX9RKn9xVaL6C8bF6MSwTNXbsQ8YKZjjyyJquVrJoWYLDNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zvYufPR1aCsnt9+hMKsT9pbaR+B2+uan37Z2WA/9YY=;
 b=Rtxe4iP1SH+ZYrr+O0d8K4T5UxPjPhVQfDMv8CmtGzzZq0uFA6iEHDcmBIwpaDRDFbDWL/XMBK7lsSdlVYOiNb3SYAkmB8ylu/TXQlGHEMPuKCG4NtSRJtmZAeJC2S8Bhgv8XZ6wZn+1Ri3jcKYL6c5CMlh9vfSc+kmrYWm0+d7iEABqXwj7rzKfBYisATcntDAE90EKYCQVl829EirlTJ0m0zd/DX9g6eHlQ3TCwX6iibXGDPClwj7MQ61zqN7kLjeDmWMpRFqUQdxgT3QO/PxN52HqAD+MmvLadXARkJOCV/Dt+KIHngCjZqMmIDttMpQgK8VxYdMG8gt2+NWJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zvYufPR1aCsnt9+hMKsT9pbaR+B2+uan37Z2WA/9YY=;
 b=is6jHhJerT38k0wUUAYb/ONCOHR0s5SlteKjO8d2922waJ0nsVxcV+LXETFCzbx4Hjw0hGGohDez3F/H9vD6AO43hcfX4ne3KSxMpsXzRMvE2/HYiHiBMWgukNj2b7JhVC0WRFwPrJY8vHX7UxPwXipFnyydwFQrBZrvWR+YpB29tsLrUhveDw0m9Pq6Rx9SpArHsz87hlyE4EMMFcO/tAFdHPeUWMNNclyEUyCpqmUIlzUbNtbbMyUnuYoz1he2RcB4K/jiKa/LtHPt7/I+JkmsS8Ofd9PBoY6GNMWSlOgx3nwFD5oSHmSXTrbHYNlnuFNCpyegt5cnLVWaaKxosQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3900.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.22; Mon, 14 Aug
 2023 17:25:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 17:25:40 +0000
Message-ID: <20b3bceb-b63b-400e-8d8c-da5252a24f5d@siemens.com>
Date: Mon, 14 Aug 2023 19:25:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: v6.1.y-dovetail-rebase
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <a022bab1-7fbb-3b71-3eb3-e16791f3c2be@siemens.com>
 <87edlkeu1b.fsf@xenomai.org>
 <a35a96771c0f059370357b9a37c9ab1871e621b0.camel@siemens.com>
 <beff2aa61a6b00af08baa7374feff1a0ddf6dd93.camel@siemens.com>
 <87tttiswuf.fsf@xenomai.org>
 <163ed99e-bb3f-afe0-27d6-eda78c65e6c5@siemens.com>
 <a1d3d859-5230-4b13-b54f-93e41a1a3476@siemens.com>
 <87ttt8bbrw.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87ttt8bbrw.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3900:EE_
X-MS-Office365-Filtering-Correlation-Id: fb85179c-7a02-4c03-8373-08db9ceb7b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sQKsHtXg9NLIS5CHUCErJiajKOWaV1D42ciOnFRQtoujDgxTafRVAOYtB2BcBfMEP3U0zjYQqUDtOwns0dn5WIiho5VynOI3NP1V6xBqjTLUJ2fzAW4b57TL4iBI0raGRFB25gngb/g/uQVTenUsYVya5KrNM02HflX6I9CHBnvE4JFyxhp415AkWhjXiSAGaTUkfnQDyXAOZESZ+tykvcRcYfVvhyPE64Pw3ITuJ0lX+l4TUo1LYuPUkt6IqSVPmRuZwULS4a2BuLI8uJVe9zUw87A3MN0rLLpcRRVS/SHgzxO2wSmM5qNYvW4N2Jmy43VMJCvx3FQ4XMvddRt1B8oNfX11TbsOUNLg1l+28EMAcCQeSESrKNvjoh/KDsTml9zVrMiKdyqFPLQmdf610y4dbMIdSWem0bScJdC6GqO5Qr7D+9ED1wRrrmnH1WkYLHlDUegsz9v20wb3+QY3M2A7Ko3+hAAZGV/Sy8khi/MLCygnoaHhmaUNQCf/BNJVzz1VyfxyXc7NpcPffW06BlCRe/CKV7bnCwA4k4eupJQrGMBICRsrDTYYwlNc8/zsKfYJmj+gyLb52AUNkbJwtla4qXYRSr50S5EdLujn7Ei08rHcK0qCoVFNPsbNnWK4FMN5tiTOvKftbqJxc+jZVg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(346002)(39860400002)(186006)(1800799006)(451199021)(31686004)(6486002)(6512007)(6666004)(966005)(66556008)(86362001)(31696002)(36756003)(38100700002)(83380400001)(82960400001)(6506007)(53546011)(2906002)(44832011)(54906003)(478600001)(26005)(2616005)(8936002)(8676002)(41300700001)(66946007)(5660300002)(4326008)(66476007)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjZFMmFpTWhvYUQ2bXh6RG5ybENtZ1FXSnpUUHNzY21zaU8vU1ZKdHRrR0RK?=
 =?utf-8?B?aVI3OFlvWFRPbmlqTzEweHdDcWp1ZG1EYjBEMzVtb01xcVB2Z0FTWDVWM2g4?=
 =?utf-8?B?eHZ5TzM4dmRmNFhnNUdKWEwrWjZQRDNjWVVuUjVYR3R1REMvWXlVQjNFUkZp?=
 =?utf-8?B?ckFMZUEvVGoxbEpoaWR4Zk5LSDgvNjVMNkpwRnRqNHFhSjlIbC9yY3Q2TWpy?=
 =?utf-8?B?Tm5FR1pqbndnQXdVTkJER1BMVUpQcytGTmZaZHZIS2lFcEVnWVozakc3TzJP?=
 =?utf-8?B?L0FLUTJnVUJlRmhua1Flc1RtTmpPa0Nmb25tcEc4djZLWjgrQ01SWXVhS2JM?=
 =?utf-8?B?MGtCL3E4OXhBK1pUUHk0REFlMHpRbTh2MlI3LzBRNWV3YnRQM3YwQ3ZlOHlX?=
 =?utf-8?B?NGcyK0pNNW9namxxeU1oNDlXUGJ5WGNpd3ZPOUdSYldqNnpTQ0RrTXBMMXIz?=
 =?utf-8?B?am82WjBCSW5QMHBRUlJieVFhOW1VRU5FU2hYMCs5N1ZnWG5LZUNYMnBVUUVo?=
 =?utf-8?B?bFB6ZWxYaUhFQ3V6RitER081NjhvQ3A3TkVoMit3WE4veFIxYlVoOFJzcHpZ?=
 =?utf-8?B?Z0JuL3VzMmJ4eHNXV0hUWE9ZMm5XWkh1Q0F2aXB3M0w3VUZjMGpwQzM3dEFo?=
 =?utf-8?B?b0VKeW9yUkJxemNmZXZhNlRlNDExRjNBWFhTbXlqKzZCY1NLbU9MbzlsRyty?=
 =?utf-8?B?YncwdmE4VzIyR2N0WUE0Wm1iVlluQUYwTmIwUXRUQWhtM3IwckNnOWQ0ckhI?=
 =?utf-8?B?NWwvWVZiSkNpaDRaVFBxNVpxWUdSSW5IZEthL1VTeGhlU1dvcGVyOER4WG5J?=
 =?utf-8?B?RDRHSHUwd0hJUXFiR1BEcXVhNmdGUVNLTWRvZXVtM1YxOGcwRm5nVDhoZ3lD?=
 =?utf-8?B?WUpUMDRMdFEydUsxTUk0YXM2OHNMb1JVc0c2MDdRZnJxZzVLbmQxNGF1VmZt?=
 =?utf-8?B?aXF1bE9Ybi9ybWE3ZXhEZUtVVk9mOHJxelhMaDFvZ3hXUFRYUjNGV0V4YnhP?=
 =?utf-8?B?ZC9pU0dZR0lUUDZiUlkzWS9EWGhrMEdTVUJSejlLaTVxQ1RTRmNwaFFMbEF0?=
 =?utf-8?B?VlZGVnBpS3BTVHZTUzR4MU1xbUtqL2tNUmxIK3lTamVaU3hqVjREeE90MVhN?=
 =?utf-8?B?bDRWcFIydnJFS0JQcjYvZFExdTBqbVZQRG4yMS9yWjNvb29tT1Q5dXdzNjJ3?=
 =?utf-8?B?end6dzduMjQzdTFTbUE5Y3Y0ZGFObUZUUU9vMGFKNEJIRzBTNmR0ZWNnNVhQ?=
 =?utf-8?B?cWl0Z1ZZMEMyM3Bja0JHZEFINGRqaStCUi9CaFdjL2tRbUwyMmNBc1BVTTdG?=
 =?utf-8?B?bWtkZXp5ZjZqbE9PMkxVa1hPS1ZXRHl3by9YZ0ZyT2Nab3oxdGh2UUpzeU1t?=
 =?utf-8?B?RGltMFlyUjNTbDhrSVlNamdVa0IxZVpJZ1pTMFhtbnQ3MXZvajBoMW4rQ1Q1?=
 =?utf-8?B?VFd1ZVdxL3RZS0doRm1DMTIrNmhMUEJBVG43c0xFMm5adkJoZ3EvUXVyZzZj?=
 =?utf-8?B?dXJIdk12S01WdS9HdmZ1Mi9taGxjbXBKZjZLcENEaDRncFl1bi93MHpPaGIy?=
 =?utf-8?B?ZlR3dW5yZ3lObnN0cml2U1VyRThUWkE1MU1meDBRcnpublFkYVBqOTVOaEhI?=
 =?utf-8?B?cTg1ZGtjd2szdVMxYitDYWp3dDliV250ZitMRmdQYnlwOHMrZWFQSDU2Snh5?=
 =?utf-8?B?ODJSSTFiT0FSbzc3UEdtN1ZucWdjT0dsYzhnNkt5UStOTThLd3lBZlZSMXVp?=
 =?utf-8?B?eC94dTZQeC93OUx6V25mTk1jWGhwOTl1VzgwWjgyOEQ2UGlkamZDaVZ2bXJl?=
 =?utf-8?B?cDVzNnAzNFc5VEIrdVpyQjJ3Nmo5c3psOVQxOVAvRVZ1eXdXOUhuQUlET295?=
 =?utf-8?B?R2xlS1hmd1BkbUdQYjRYbVgxTzU2bmorMVl2SUt3UTV2NHE4dStSZDBjMjdx?=
 =?utf-8?B?ckRDcFZxT09yalRGTGR4L0EvZmVTaCt0RTJGWTFvODQxVm93UGRibU1RbDJq?=
 =?utf-8?B?dnZnVWF4RnQxaE84S0MrbWdtSkFNZVIzbzJFTi9JNjlScStYTE01U3Qzb05j?=
 =?utf-8?B?Ykg1Q1RKcEc2Skl1MW54TG5Bd3NIRkd4SzJ5TjlwU2VVTXdxbFc2RnkwVlVn?=
 =?utf-8?B?bU54d2FLazBseHdCNFNhNVF4cXFhM3NmUXRJMEl3UnRPZkFTZ1BrSUNsNjVE?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb85179c-7a02-4c03-8373-08db9ceb7b20
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:25:40.1175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +V+korNSWzWS7O4YVNsy3c675rczJ7vI0+JuiGKVkfJVme2NzVaGOWls2Ux/w034yXeK4m5MLUpeHVagtFJ7Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3900

On 09.08.23 15:11, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 09.08.23 07:52, Jan Kiszka wrote:
>>> On 01.08.23 15:26, Philippe Gerum wrote:
>>>>
>>>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>>>
>>>>> On Mon, 2023-07-10 at 08:59 +0200, Florian Bezdeka wrote:
>>>>>> On Thu, 2023-07-06 at 21:00 +0200, Philippe Gerum wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>
>>>>>>>> Hi Philippe,
>>>>>>>>
>>>>>>>> quick feedback on latest rebasing:
>>>>>>>>
>>>>>>>> https://source.denx.de/Xenomai/linux-dovetail/-/commit/8f155631c8b51731dfc2ae5145d4dcc68f2ed7ed
>>>>>>>>
>>>>>>>> This was likely accidentally folded, right?
>>>>>>>>
>>>>>>>
>>>>>>> It looks so. This conditional statement appeared upstream during the
>>>>>>> v6.0 cycle it seems, and was unfortunately left unfixed in the dovetail
>>>>>>> patch for this entire series.
>>>>>>>
>>>>>>>> Furthermore, I will factor this change out into a separate commit in 
>>>>>>>> merging v6.1.y-dovetail, for better traceability:
>>>>>>>>
>>>>>>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>>>>>>> index ce8bdd804bc7..c843bf352999 100644
>>>>>>>> --- a/arch/x86/mm/fault.c
>>>>>>>> +++ b/arch/x86/mm/fault.c
>>>>>>>> @@ -1466,7 +1466,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>>>>>>>>  
>>>>>>>>  	/* The fault is fully completed (including releasing mmap lock) */
>>>>>>>>  	if (fault & VM_FAULT_COMPLETED)
>>>>>>>> -		return;
>>>>>>>> +		goto out;
>>>>>>>>  
>>>>>>>>  	/*
>>>>>>>>  	 * If we need to retry the mmap_lock has already been released,
>>>>>>>>
>>>>>>>> To my understanding, this was a dovetail fix that applied to previous 
>>>>>>>> versions as well.
>>>>>>>
>>>>>>> Only to v6.0, however this series is not maintained dovetail-wise
>>>>>>> anymore, so this stayed under the radar.
>>>>>>
>>>>>> FYI: This change fixes a real issue here. The 6.1-rebase branch made it
>>>>>> through a 24h stress test while the "merge" branch failed. Happily
>>>>>> waiting for the next release...
>>>>>
>>>>> Do we have a idea / plan when the next 6.1 dovetail release will
>>>>> happen? My internal customer is waiting for that and I want to avoid
>>>>> backporting to 6.1.34.
>>>>>
>>>>
>>>> There is a brewing rebase to v6.1.42 pending tests here, no challenging
>>>> source conflict. I pushed the tree untagged to the v6.1.y-rebase branch
>>>> if you want to give it a try before Jan updates the stable branch.
>>>>
>>>
>>> We are testing against -rebase anyway (but that needs a trigger which I
>>> just provided). The merging branch is only updated once there is a
>>> release tagged.
>>>
>>
>> Passed with the Xenomai 3 tests:
>>
>> https://source.denx.de/Xenomai/xenomai-images/-/pipelines/17252
>>
>> But can we update to 6.1.44 directly? Florian mentioned that there are
>> Downfall-related fixes in that release.
>>
>> Jan
> 
> yes, .44 is actually brewing here already.
> 

Now we are .45 even. Will this one be tagged? CI looks good so far.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

