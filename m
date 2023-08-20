Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F71568E
	for <xenomai@lists.linux.dev>; Sun, 20 Aug 2023 15:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlgvIvhkrLIfDvK2Wn6HfTITwkhNLjrmMQ+FAzyjBdLTyYzJkQM17QMgJrEIr10w0b9Q8n24xZO3DIEg+tbKh6SIbXZjVbOOXrhG7+AVl4uNDbZG+0x0iEpmlUfQkmKlRvS8iOGCsEySX/lgne4a6NRNotsxmmWGD+EhU05PTTbc8oQ9bw/EmD2GrxIPAZ/FuYTRnkRA9tdY9j/Jd0RXQAl/B9sVg0oUzDF9SjeCL9+78ZLfg3cHomV4RVcKLM+paukZIqR9YfGaw2tcaUvTTkprmFR8w51YVxofj+CxUl9ne4Wqmeen8QX0O8iGTlrJDmodNxI8W1QsZVVVGJNjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QD6Aix77cgYd50JSVkdg097KsoHbDDi2zqSUXCBqJ1E=;
 b=TeZI6lxn/N2ItwVCuftr2E/NlzLMAA0wRzAdJYjX1rIZSM7JP8C7mKkgmS67Glh+pgbFYa46XOsq9hnf0DLGxbZS0zhcJKHzYeUleG0LZgekRTD+9OyM5L4sJyTdTJlxS96DeT3eAr2VeK/mMCTs2KavIfSoc9CLfxU0WfkE5QW1zRdfbVSxJNDm8yV9VLAemLbZe/zmiT7LEzdrqgE/HEegO15s/RmWYk1G7p/dOV9q2//xgD4snHC85zW9bviwYnaLvrv+bkY208vs1bhydYnR0cwC9EjeKWAgWfBboQfJO/Qjv4RxZM2zjfSKpV79ASsRcRxEizjRF1QfmVpfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QD6Aix77cgYd50JSVkdg097KsoHbDDi2zqSUXCBqJ1E=;
 b=kq0eANEExxE9rKphgI8KEN7Xu7AQp8uF2M0Rd0Y0cc6+nmHP0Xgt21/LAjV0VZSzmmV/96jyNuxpFUSc+wOxCVJ1ZX9EcrQNfr64gJCZpjAQqQhnlFgGnZVEpllC2H18kyUUz8sEXaea3Op0t912gYw1iRqX776GTh/s6g7TN1Z+IhMw9xmrDjSLmswP/sTXik7suewhN67IQShB4mMSldndbxspJSRwuJch/VUVP2L7xhBD96ozRb7ClSe0e2Hnkx1crZHevQ4z8DciZS1pSrYaBj97AhRsjPbQ1WbL+xGYtS5pjXeI2k/rhVbCAn/jWRZUd+ymoa2NOT47WqBBqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6987.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:304::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 15:30:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.020; Sun, 20 Aug 2023
 15:30:34 +0000
Message-ID: <22412bae-4472-48a6-a20f-83256e07c4b9@siemens.com>
Date: Sun, 20 Aug 2023 17:30:31 +0200
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
 <20b3bceb-b63b-400e-8d8c-da5252a24f5d@siemens.com>
 <87bkf84nb7.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87bkf84nb7.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd431e8-9525-4cbb-c613-08dba1926546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LlTgLeb9j0+kDSjZHgeexydY0Dirw7bAklZRyZXOY9t3YU6gHiimrCT6+rppCluS5qEW75jtdbxS0+R1cUyckUDy6gHgIwMSR6Z8nf0RHsrNEPfJmMFl/O7UP6z7LgovdBMjzGs4qPwT6DE5H9/OXwm1wP7v6545J950LdjE4M3Dw/dsiyHTfL7g6OlXk/ZXmZCdd7NPpSNWbHj59wF2GNOh06/RFJXlMI6jN2MpIoozrTO4h9r+X8odo+Q1Y6KLl5A85loflNC1xloAaO5e4OmcS+OsZhflRg0+F/Zyjca+4WZG5CZlNf4FkV+jRDPxwpQtVryds1YFL9uuoZqsU3sIITDvAcSHns43GEeP3fmCDmKzS2xTHHYgTMlhW0NT1KJfC6Toq+v8wPg31twJzYJ2v15BeL2snZnu/HZ5TE7Jn6C6wxMu6tCSz4bdhakuYfaDzEzBBQbYrzndSJmq/467JDKRHl6aiMJ8ulG2Fs1z15UeybFXF4pa2IBKzLWwzERfjkiNH27qrDibfcQL76Xol4ZT6/6P+Vt4JtlGG3vBuVHBKt+qyOLERfBOQXTtYSP0j9mzJPN57Jw06pDWkmv5+QkoCtploWv8UL/VwSAm8nQcaJdqpYhCusNNB2H8gFI7re2hJxEghJIc7QgPPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(2616005)(26005)(6512007)(82960400001)(38100700002)(86362001)(31696002)(36756003)(83380400001)(41300700001)(316002)(8936002)(8676002)(66946007)(6916009)(66556008)(66476007)(54906003)(2906002)(5660300002)(44832011)(4326008)(6666004)(31686004)(6486002)(6506007)(53546011)(966005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekdRWEV3N090bkdZd1dtbkpKMGhDV2gwdGVQNHFWanZvMHp5eWQ3WWQrYy9h?=
 =?utf-8?B?eU5pd25JTENWUHUreE9LaEkyY0MrSmc0eTdreXY2VE9QVGdvU2RsZnNVaTdh?=
 =?utf-8?B?cENULy9BOGk0K3dCaFNuSmFWNjdsMm04U08yQUJZbEJHZmE1YktWVThWS09l?=
 =?utf-8?B?M0RtYTltWm5Bd2pYQXF5ekZzLzBkMUJKZk9IaENGb0QxZC9uMHdqM1o0Rmsv?=
 =?utf-8?B?N09WcnlCNWxpcEozblozNGl4MzVvYVNRaDRwa3B1bGp6dzV3bktyWTlaOE9m?=
 =?utf-8?B?UjdNN3FQQUVxZ3FtenRZVFk5bjJ3Q0NCL3I1NUMwdnU4ajUwVEhuZDBhZWZS?=
 =?utf-8?B?amZpMTMveGZ0N3lpZFpVVUJlZE5QWUNCdmxtcDQvekVCekMrekZ4VngwTFNS?=
 =?utf-8?B?bEo3dVFIby9vVVFrcTlNTlNNOFhOUjFDU2hYamxhNjJCYWdueXpyYTZ3SmZI?=
 =?utf-8?B?V2gvTVovUWZpdGtlYVBVbTBBaEZIUTEydXEwQWtGMHMyclNqRmdMSzFrNStF?=
 =?utf-8?B?UnZkWk1OZTYvazZFSlRSaVF1aUt0MmZGQm5yck5CazZteDhyTnF6UW01RjV1?=
 =?utf-8?B?eVRNSHY4aFpwZ0kyaWtHY0doWjVmTDFEbjRXV2krd3NUZVRVNU5TRmRick03?=
 =?utf-8?B?cnMySnBMdXJucWlJYjUrSzhNVVorVVhMQ0xDQThUMUlFa1V3ZTE3ZzM5Mmxi?=
 =?utf-8?B?RE42c0trTUhrRi9KQXRKQmR0cFdaRUlNdWp0UFpjUDd2aGZCbFJMMjVxdmhz?=
 =?utf-8?B?b1Ruc1FyMzh2Z21KK1BrV01CL0RldmJpeFpOcUZPU2FJRExmdUlWVWxnTXBX?=
 =?utf-8?B?dnhXT1pOWDBQQ05XUzl2bnRaQktZeXB0YmNUcGdPcjgvS0wvRlIySDJjcjBI?=
 =?utf-8?B?TWZMb3QrRG5veUhpcW85Q0wzVmg1YmRDdTdPWE4xdHY2RU9XaWl4M2JDcVc4?=
 =?utf-8?B?alNEbFZqcjZtTVhNcnBERkxQZ3g1QlNUdHAzNzZTQVAvdmVLaGFMaytYYVdv?=
 =?utf-8?B?L042UjY2SFRRRktLRVhRMVIrUHhyMEQwK0J5N2lZaUpWeS9rcTl0Q3o1T1FG?=
 =?utf-8?B?WVNZNHFzUUZzWjIyU1NwcE9paWorZzYvVFJYTjFUdWs0ZFdsYjZkc3V6dVJX?=
 =?utf-8?B?MWh1NlNuMXQ0QUUyZ0R2VjFGMkdLQWtia0tHenczOTUwTjZEVWQweE5MbVMz?=
 =?utf-8?B?eU1kOGt4YUlLZklhYmR5d0NSWHZISTlxY3VvMCtoUFFFQzd2ZzFhTVdHcHVV?=
 =?utf-8?B?aEJQTkt4ZDZvY1M1UWVmb2w2T1E2L1JValF2WmJNZ1N2Z0o2cDY0ak9FMWMz?=
 =?utf-8?B?R1Bob3NmRlYxM2x4cHp0aWx6RGMwdGhpaGttYVo4b1hjT1BHN3c1Nk5wSUxp?=
 =?utf-8?B?OWJXeUVYYW9PbkcyM3NFaWJGZkNKU29jRHZpdHZOVWFQTVg5akhBOFhxNER4?=
 =?utf-8?B?ZmJrMFZ0THN3RkZhOVRUTXQ3Kzd3UE1zTzY3ZTkzWXJmMTBOeDdyd0V0MGdT?=
 =?utf-8?B?d2E0WjJRL0MvN0FUUml5ck1mSTVsVzlIWkVWWWt3aDlvcmMyQWM0dkpWeEl6?=
 =?utf-8?B?ejhIZU1RK3EvZlY5R0x0NG9DSzZKaE1YdGFuUkFkbll0bko2K3NyMFlMbzZS?=
 =?utf-8?B?OGpFNlFXZUFSOGJOZW4ybVBhbmNXeFNGLzhvWUQwOGpMVGh2b2NiQmZkcWtY?=
 =?utf-8?B?ZU82UWZPR3N5YlpaUVZDM0RtMVpTSkJUaU9jU2FUbUdoZW80Y2Fjck9MNkRo?=
 =?utf-8?B?ZVFoZktEZlpLZVFJMmh2Ni91S1lQaU4zVVRNU0s1aXpHQng2L25xU09PdnIw?=
 =?utf-8?B?ZEZUR1htNHlqa2sxYUU1RHRBa2VJbEtvQTNoOEo3R0FWOFdrLzh6STZSYXFr?=
 =?utf-8?B?ZS9USThSMWtFQ3hmcU5rWmpHdmNySDBRZVAxZkt0S2E5a0pOQXBsQUp6NmQx?=
 =?utf-8?B?VW1PZXhxNGprZ05lVUVDMnF6dVdWM2JBNjVNL0tEYjB1OTQ5NjZRWjlxRFVH?=
 =?utf-8?B?WHV3RVl1VFVVUkhOUFlqMnBtMjgyRnorQ04xcUFadVV4OW15MUtINFJZTlcr?=
 =?utf-8?B?NklLcDhQQ0FEZ0pDZC94cHV1ajN3ZHY4UFZ4MXMwTDBjNjB2THZYZmtOYmVD?=
 =?utf-8?Q?YS8KG+zre4t4woJPtQmcQF3aP?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd431e8-9525-4cbb-c613-08dba1926546
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 15:30:34.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zP9sCb4h9PB6nSu5goX8suq4MBvapM1KxH/nAtHOmfbTb0jYolLZ2qCgoe0Hzr3xIAISrQjNSUdvUIdAfVvqjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6987

On 15.08.23 12:18, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 09.08.23 15:11, Philippe Gerum wrote:
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 09.08.23 07:52, Jan Kiszka wrote:
>>>>> On 01.08.23 15:26, Philippe Gerum wrote:
>>>>>>
>>>>>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>>>>>
>>>>>>> On Mon, 2023-07-10 at 08:59 +0200, Florian Bezdeka wrote:
>>>>>>>> On Thu, 2023-07-06 at 21:00 +0200, Philippe Gerum wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>
>>>>>>>>>> Hi Philippe,
>>>>>>>>>>
>>>>>>>>>> quick feedback on latest rebasing:
>>>>>>>>>>
>>>>>>>>>> https://source.denx.de/Xenomai/linux-dovetail/-/commit/8f155631c8b51731dfc2ae5145d4dcc68f2ed7ed
>>>>>>>>>>
>>>>>>>>>> This was likely accidentally folded, right?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> It looks so. This conditional statement appeared upstream during the
>>>>>>>>> v6.0 cycle it seems, and was unfortunately left unfixed in the dovetail
>>>>>>>>> patch for this entire series.
>>>>>>>>>
>>>>>>>>>> Furthermore, I will factor this change out into a separate commit in 
>>>>>>>>>> merging v6.1.y-dovetail, for better traceability:
>>>>>>>>>>
>>>>>>>>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>>>>>>>>> index ce8bdd804bc7..c843bf352999 100644
>>>>>>>>>> --- a/arch/x86/mm/fault.c
>>>>>>>>>> +++ b/arch/x86/mm/fault.c
>>>>>>>>>> @@ -1466,7 +1466,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>>>>>>>>>>  
>>>>>>>>>>  	/* The fault is fully completed (including releasing mmap lock) */
>>>>>>>>>>  	if (fault & VM_FAULT_COMPLETED)
>>>>>>>>>> -		return;
>>>>>>>>>> +		goto out;
>>>>>>>>>>  
>>>>>>>>>>  	/*
>>>>>>>>>>  	 * If we need to retry the mmap_lock has already been released,
>>>>>>>>>>
>>>>>>>>>> To my understanding, this was a dovetail fix that applied to previous 
>>>>>>>>>> versions as well.
>>>>>>>>>
>>>>>>>>> Only to v6.0, however this series is not maintained dovetail-wise
>>>>>>>>> anymore, so this stayed under the radar.
>>>>>>>>
>>>>>>>> FYI: This change fixes a real issue here. The 6.1-rebase branch made it
>>>>>>>> through a 24h stress test while the "merge" branch failed. Happily
>>>>>>>> waiting for the next release...
>>>>>>>
>>>>>>> Do we have a idea / plan when the next 6.1 dovetail release will
>>>>>>> happen? My internal customer is waiting for that and I want to avoid
>>>>>>> backporting to 6.1.34.
>>>>>>>
>>>>>>
>>>>>> There is a brewing rebase to v6.1.42 pending tests here, no challenging
>>>>>> source conflict. I pushed the tree untagged to the v6.1.y-rebase branch
>>>>>> if you want to give it a try before Jan updates the stable branch.
>>>>>>
>>>>>
>>>>> We are testing against -rebase anyway (but that needs a trigger which I
>>>>> just provided). The merging branch is only updated once there is a
>>>>> release tagged.
>>>>>
>>>>
>>>> Passed with the Xenomai 3 tests:
>>>>
>>>> https://source.denx.de/Xenomai/xenomai-images/-/pipelines/17252
>>>>
>>>> But can we update to 6.1.44 directly? Florian mentioned that there are
>>>> Downfall-related fixes in that release.
>>>>
>>>> Jan
>>>
>>> yes, .44 is actually brewing here already.
>>>
>>
>> Now we are .45 even. Will this one be tagged? CI looks good so far.
>>
> 
> Nope, .44 was broken due to [1]. .45 looks better with this fix in
> place. This issue triggered on kvm/arm64 w/ PROVE_LOCKING enabled.
> 
> [1] https://source.denx.de/Xenomai/linux-dovetail/-/commit/60ae6e4ea6a074698be4d999e96e9c3697b18ea1
> 

Thanks for tagging v6.1.45-dovetail1 and v5.15.126-dovetail1, I've
updated the merging branches accordingly. How about 5.10?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

