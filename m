Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C99211C
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 05:52:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYrpyl04nekUxOrxaNXqb4RHM3CHl5Kr0QOV5A6IV2ruY8hzy/KJhQ6/36JwX0S0yHGeL3iwTfxMH0c+1dStt5RDpd4of1vdBunjwZFZXNnm3IVZ9BkJghlwpgauj0V3chBkkLYgByTqmOEcWpK8a/V2we2pH8x0JmGHx+pwF8i85PZ7Mx0kYFaWFRtIBUuqYaP49JDiThctyFC+3f2vWnHswjcTeLzGcOoWmT1oS3rdVbZ/DYKbn4g6HmwX+OK1vhV5KbK9L099C1fQdk5/j5278PJmY/BEBbx7AUCtNS0ho7OldC9ZI56ctBokzfJGr2pg/HDG/G0MWlv0E+FLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKSTljaNjzMOOZZAirVIgkxLBdO2P8wa2sR3dI8eO0I=;
 b=a1mTck4YBEdXnm67KvR+FMK5admO65If4JEqLdfpHykbigvJ8B/ETBr9BKp8xZ5Z5qnxv/EFraALy4zyWXeNZsotlhwFoTWxiOfZxK1c9+4QYA/9Rnpy7bqF2G0kq/O3cQuRATdq3lAnQdI9STgykvzz8URSMKkum1pG6HDXDw/wd18msqahrLY0SPUkRrq64UadDx2GTgK6MS9y6Tjp21KG/fSbYszxUWyVGaT/h5kTb7VHvrXS6O2PmYHGCHnin2Ujt6G78yYb1YMIUB6BRrmctgyas/l/JAAEz9osPuzKqP29LEe3zdDRJvH8H0+3ckAC3eNFcQAKZpBW+63gjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKSTljaNjzMOOZZAirVIgkxLBdO2P8wa2sR3dI8eO0I=;
 b=YGwK4cLcuYArvDNGOYQqsUdr0PqPoWnCHrs8ke6wGyvIgz+DMADtPrF81ngfQyWNsFurVnutYdvlh/KpeBkzneTO/rRvgFfgIUUeH8ESdElqTZ5u5OBVhX3QMkcJyDFVNpoDAfmOJ3MgVVGV9CSJg9/AXo09l8lqxr0topT15jet+fRfFg5Wv655Xs1gAlCXZNIg823BW9IlYBbKnSiSQEKi0fsRshniklL1wpauE+rTWZR1Olh6h79VqsaxxY68EcEM/lAJygffB7drR7USYOP98haDRUORbkB/fjXNTMD1IqqTfwncL7xibxDrFZt8ieCRkyN5zM3JukLECq216w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5530.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:475::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 05:52:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 05:52:32 +0000
Message-ID: <163ed99e-bb3f-afe0-27d6-eda78c65e6c5@siemens.com>
Date: Wed, 9 Aug 2023 07:52:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: v6.1.y-dovetail-rebase
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <a022bab1-7fbb-3b71-3eb3-e16791f3c2be@siemens.com>
 <87edlkeu1b.fsf@xenomai.org>
 <a35a96771c0f059370357b9a37c9ab1871e621b0.camel@siemens.com>
 <beff2aa61a6b00af08baa7374feff1a0ddf6dd93.camel@siemens.com>
 <87tttiswuf.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87tttiswuf.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5530:EE_
X-MS-Office365-Filtering-Correlation-Id: 921612cc-82c5-46d6-82c1-08db989cd319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f0zLZrKxfv12/c6/cLVhbFYvfMVqjk1kQeNPgeFPyxJBYe+H0PhAaRNL/8Ldf2mC4E0HFCE+SiIdw6K9Cu/vzotcwwQNPvGm5NQ7lVwhwp7m30UW5gr5rb7ZvxpG43zE13O+UTDG/x3gtaTXrDgX2fgH9aNJ4xl8ycj9TQg78I0rEOSHrN86YwxkfSiOv9cdSkZCNiWyFZy26bzeyN37WbmtbNQ7toJwS8POidTv+wujwlaPxFJYk2+Nj1YPl8aXoR7+CnUrrX4CzF4x/29LmdIkvd243kb8ifW6fusEkXwvPDsdZmdvyCLX8T4W7zcPMGXVC5WXuwtoOZXLHCSSSn0K/xrCUo+3y7rL8MAUWjs5Zd2Oec8Z4YiZYzDo7OJ4XPXDDvCHb10a4Q0vytSxkT6bhFtK9b43JRMI4pekaY5vEi7gDnUrc2IGkv7lJk/uBFdGBJNPmuLMtRHbb8K95NTNMHwHBJCa8axFFiaZBUdorEfyBffsi4PiBHLUgwu93k0K0hL8JGw1YTKTKNcqO1vS0/8q0lDNmx48zA6vZbsXUI6M2BhQ72bZjLP4OFnOfia4B5x/ZXB34mloGwCYCR+sA8vUtozwca35ZTBY5+fUtD+BcYDGKUpVT3XeVxxfAeCZkqmAt2Kzf5nhitdRRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(186006)(1800799006)(31686004)(316002)(83380400001)(44832011)(2906002)(36756003)(82960400001)(2616005)(26005)(8676002)(8936002)(38100700002)(5660300002)(6666004)(6486002)(66476007)(66556008)(4326008)(41300700001)(66946007)(6636002)(53546011)(6506007)(478600001)(110136005)(86362001)(31696002)(966005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3BnYlEwdXM2ZDBTUUl6RW1tdUw0SlZab2cxdGlDeStRYlpsc2pzaVFjMFZZ?=
 =?utf-8?B?OWN5VlY4cjVXRWxsUWNLL3I3eVk2UHllQW1xbk5Da2sxeXl1bDBUT2hCNW0z?=
 =?utf-8?B?M1IvRFdWeGZzRjB6dEl4TWdTS1BrTm1QbzR4M3BzbUYrSWlDSG9QbWU2K0V6?=
 =?utf-8?B?UG9MZFRYbnZqOXdZT3I5dk1yU2xGQUVua0FSYkFwU3p4azRoOHRnSEhQTEJP?=
 =?utf-8?B?RVAvaTZRRmptaWNOa0ZqV0hySGY5Z2s1cFh2WmlhT3huQWxnT1phb3VLVUw4?=
 =?utf-8?B?K0p5dSt4VEJsek0rM05aRHYrdE9VeVlYeWZvdVpGU2pmUUtsM1M4OVptSXd5?=
 =?utf-8?B?K2NsbDlxVUtzdjFqZy9TV1h4UmtRZGJpRyswalZwOU1jRzJiTEpsMFpIaXBj?=
 =?utf-8?B?QmpKRmJicWdIcXpUWmQwWXBJQnlTWmxDT1JGeVo4bHdWUUtOS1pXd2tlTDV5?=
 =?utf-8?B?eDZQa2FzbkVxQkFrU1VvVXhhZzNsRksvMDdHZnBzKzRXMXhpQzJ1emJyTEtr?=
 =?utf-8?B?WlRPN1ZteTEvR0tQR2lEMHVoRTJNMW9jaVFRdVJ3YnRZS1JIdHF1RU8zWHVS?=
 =?utf-8?B?eGVMSzUzY3podzBvYmJpcDhVMXllTnlMREZ6aGNUbGhMQjcwdHdTUWNBZEhv?=
 =?utf-8?B?TlBFcG1PUzJjblFlRzRGNjRucUV6K2NtaDg1U0g4cW1zayswZnVoNWd1MGxM?=
 =?utf-8?B?NElEUGthblRWY0cxRWwrRWFMMnQvL3AwTStDOHFuRU9lQWFOVDdYZ3RhbXZt?=
 =?utf-8?B?cS9uZWNLOWdTV1BtaTVxMGVobHBiZUF1QjVCM1o0TWVjYW1oMmJOYjlZdVlm?=
 =?utf-8?B?MGJmVXJzd3ZEQjNCOGF3ZmZHNytiWDROd0lxVjcxQURKbUVpdXp2NFFhTUVR?=
 =?utf-8?B?aWNlc1I3dUh4d1Awa2Z2S1BkVlNBbGRaQVhCbi9MSVl5WlZVZkVLUStkUWo1?=
 =?utf-8?B?aHRhUUhxaHJDS0IrUjVtbiszNzZSLzVqNW5tT0hNOGZLVDk0OC9RTGlobjRT?=
 =?utf-8?B?RU5DVzhoTWs1K1RpVE1xTkV4TkNFdzc1VWp3QTJMQllrQzBud1hSWVVSSFMw?=
 =?utf-8?B?WjdOd044UmVyVDlOVHdvUWpQMXExU1YyNFZOU3pRWlVzenV6VTFRTWtTWmlh?=
 =?utf-8?B?SFA2U09qR3RrYXBnU3NVZm81MGZGdU9zRE9CZnlZV2tvNWIvbUw2V3hwT0Jy?=
 =?utf-8?B?RGJLUkkyK2VqVXcyY0RHbFNtZGpEZXVVbjZBZVZ6dzM1b3ZmMVdKOXlCN1J6?=
 =?utf-8?B?M0xFaERub2ttazVUMFE2WFBPVG45bjlkVVNvUkRyM0dEam1EOC91eWdXUGhC?=
 =?utf-8?B?dC9yYW5RejBjZEtaRjgwLy94enFDdTRyYzVDak52blFQWktpdXZrMlRuMHNW?=
 =?utf-8?B?OEdUeFdQRzB6ZE9scWc1MGx0S21GaEdjVVN2L1BtaEVaTDdqdXBvSXVxSEx2?=
 =?utf-8?B?clNLbWFiY2FvQ3FuYm1rSDVsUHZsMEgycVRLQjloL21Ecnl5UE9qcFJkYUFI?=
 =?utf-8?B?TDNLc1hMQTRpZXZiaEVCRWJpb0Yra0dIcVk2Y0ZueUVvTFZyYlphbHFSNVly?=
 =?utf-8?B?V2laQitwM3c0UngwWFg2S3hSMUU3Wml5VzRoanBBZm5iTCsxM1FBelUvWkMy?=
 =?utf-8?B?Z1E0SFBuTitueHVXOFo4MCtFbjlXV1ZtbDdINDhrTWY2b3FCcm5VRUpXZXZt?=
 =?utf-8?B?OG53b0VtMUJCOXZYMUpKeWswcCtaNEExVkVCVE5oMldhN3VtQTZVd3NyRmx1?=
 =?utf-8?B?TFFFeEw0UkJGdE1rQ0xMcm10dzcrWEo0U1cvdExFNDhiVVh3WTVIeHJKTnVu?=
 =?utf-8?B?S0RmaUZUMU9NY2FoUlJmckdqeDR5dDlXMzNoTEVhQUwyNDk1TzBpMDdEYy9T?=
 =?utf-8?B?a3VCbk1OWCs3Z3MvaFJpYUszK2k0OUsyT0oza2swbmJTTHBWNi9rdlViRXVQ?=
 =?utf-8?B?U0piY3dQdVZOT3BVWTdoaktlaGxnVjk3L0VrMUNVclVXY3NlSVI1UWNQNFox?=
 =?utf-8?B?T3NsQTAzVUUyS0QvMG1STm91aW9Na0VzdVBYODlwUFJZUGdHZ2Z4OGdPbEJG?=
 =?utf-8?B?dkl1N0p1RXd0T0ZOTnV3SVZGLzVVbitJSC9Na2tJWGovdFRVL2hIelRVNFhX?=
 =?utf-8?B?MGd0dVpXaE1KbG1kT3prUk16a1hnUjZLdWJJU1lVbERQTjJjUjBZTjhSODVa?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921612cc-82c5-46d6-82c1-08db989cd319
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 05:52:32.8718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dg3uSIuWykZEWeR29Yju14hPTKroAY4WZJjTKcoT50ekVBJNLxIwWE4f68Gus3zZpLip6vkBUUVlsCCXGg0Jbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5530

On 01.08.23 15:26, Philippe Gerum wrote:
> 
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> 
>> On Mon, 2023-07-10 at 08:59 +0200, Florian Bezdeka wrote:
>>> On Thu, 2023-07-06 at 21:00 +0200, Philippe Gerum wrote:
>>>> Hi,
>>>>
>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>
>>>>> Hi Philippe,
>>>>>
>>>>> quick feedback on latest rebasing:
>>>>>
>>>>> https://source.denx.de/Xenomai/linux-dovetail/-/commit/8f155631c8b51731dfc2ae5145d4dcc68f2ed7ed
>>>>>
>>>>> This was likely accidentally folded, right?
>>>>>
>>>>
>>>> It looks so. This conditional statement appeared upstream during the
>>>> v6.0 cycle it seems, and was unfortunately left unfixed in the dovetail
>>>> patch for this entire series.
>>>>
>>>>> Furthermore, I will factor this change out into a separate commit in 
>>>>> merging v6.1.y-dovetail, for better traceability:
>>>>>
>>>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>>>> index ce8bdd804bc7..c843bf352999 100644
>>>>> --- a/arch/x86/mm/fault.c
>>>>> +++ b/arch/x86/mm/fault.c
>>>>> @@ -1466,7 +1466,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>>>>>  
>>>>>  	/* The fault is fully completed (including releasing mmap lock) */
>>>>>  	if (fault & VM_FAULT_COMPLETED)
>>>>> -		return;
>>>>> +		goto out;
>>>>>  
>>>>>  	/*
>>>>>  	 * If we need to retry the mmap_lock has already been released,
>>>>>
>>>>> To my understanding, this was a dovetail fix that applied to previous 
>>>>> versions as well.
>>>>
>>>> Only to v6.0, however this series is not maintained dovetail-wise
>>>> anymore, so this stayed under the radar.
>>>
>>> FYI: This change fixes a real issue here. The 6.1-rebase branch made it
>>> through a 24h stress test while the "merge" branch failed. Happily
>>> waiting for the next release...
>>
>> Do we have a idea / plan when the next 6.1 dovetail release will
>> happen? My internal customer is waiting for that and I want to avoid
>> backporting to 6.1.34.
>>
> 
> There is a brewing rebase to v6.1.42 pending tests here, no challenging
> source conflict. I pushed the tree untagged to the v6.1.y-rebase branch
> if you want to give it a try before Jan updates the stable branch.
> 

We are testing against -rebase anyway (but that needs a trigger which I
just provided). The merging branch is only updated once there is a
release tagged.

Jan

>> @Philippe, any news regarding the IRQ issue? Did the VM image help to
>> reproduce the issue?
>>
> 
> I did not have a chance to look at this yet although I intend to, no
> spare cycles ATM. I'll follow up when I have news. Since it takes ~18h
> on average to observe the issue on your end, I would not expect a quick
> resolution though.
> 

-- 
Siemens AG, Technology
Linux Expert Center

