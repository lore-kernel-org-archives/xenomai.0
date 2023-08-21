Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2067.outbound.protection.outlook.com [40.107.249.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FB94A3B
	for <xenomai@lists.linux.dev>; Mon, 21 Aug 2023 11:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk2XnlvWGL0+9VcFFkWReXGMmQ2b3wrfHa154LVhGRjE1XW6MOkLmbKtfaNBG7Mr58tZHYuhTDQQb391JBIyUjiDy3QIUdmMhKZ56LRHvqoUrssHGTx4mwpqXVte4XtK9wILFX2OQUbl0Yd0Sae/BcqnBPAzkTSSvCrY7y6IIpnHbk8fzK8kVlI6LlZV/9I90l4nUrNcG1VwF/LBGoj5wCFA2FD+t+DOa/18ai23vsoT+HOnFPOfSqFpmk8roi9Nlwy5TezJZZ4+H7W7I3e69iOLJz48p7ueWPzQG5hZAU7EsbWoXeE1PgwlAcQl6TAGchIabgmSpo3XLjNnePVASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkQBmXtjAHs4v38xeo5r4XbkosCP/PtjdL1qxxmDLCE=;
 b=Vv0d9DhCYYEofZmyvoMaDO8Lzue0WGNGieeHeCBYdtV4SW5T7rmlMBcmnureBIj9nBhSqdRTXkZNM+8Ewjxu/XvAIfeWASfV/1Ql9VGvrSbYaqmtCYWydoc+ut7YkFQgDYOg8kiQhyxGBCsnwnR91UaRMg1B9LD3ZCQLlG43n9FnRhfuDz8MexTUwvIt1uLLCGi+dgmCKlqCx4HRnhJjPxZ5KziCEvQnFnqQlrtsyc/1zvTjp/0Kzbhd2XbFwKNXLkCPEnRa7L2tR6Ie4ZlwcDHk4/p2mXDsqT+D2DWg1KUTeO8cUoe6xXWDno5VXlNkoTsoLgYH+86aEkc8E8fgGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkQBmXtjAHs4v38xeo5r4XbkosCP/PtjdL1qxxmDLCE=;
 b=psqbM6XXiujQ3KszL3/fUOTiYge8J7FvugAwhGy/eQkbrd9bgI2acDbbtbJp829ee6sJb4DsBqWcJab4OVFYSsx+ALgvdCGun9cGz26Yb3+kV3LOzncFRXMCZnu5FEka32Q/6+Eb/7y0iuYYzSIy4lIAJEpb55H1gVzZO7Sw6DAATbXVVmhe72+rm7YU7DNqMZDKhkzOoJINMzESroFAifcQDMV2l3iKjtCXH7aZenJuXADTtLKA/XAKvX5KrdYcon48s+HEOObds6yk4G1Uc523HA5KytUbuaK6IvslA4YTs7F4JjAoaSQCS1eeSTK0Do8g72jZqaTpDxoxAUSEgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7574.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:545::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:45:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 11:45:28 +0000
Message-ID: <a9f08036-50d6-4322-8ba1-0508aa77f5c4@siemens.com>
Date: Mon, 21 Aug 2023 13:45:25 +0200
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
 <22412bae-4472-48a6-a20f-83256e07c4b9@siemens.com>
 <875y58q4b3.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <875y58q4b3.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f2a081-e2fe-48a6-9734-08dba23c1db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CInQO9sRF53a5bfsxYugqETzo89O3KiYkYGu/hgvFEI6gmMPQE+4dzGHWFpLEorSTC7hRZrgtC5uyOQBs/oS0FUGMearBVzHHQC6mLnrb52WzEnPuMvjicf5H6NNR121631Je7RwB4Dm6jBGsok+1gB0mO75LHKtnR9+bHMsZa4A62ZBJrvqPgJuKeKnErQKGf5C99x6gNuzcxKLfLOse3S3k5JpEl4yavqfZsUJMTT4b/TcWLhdtN/EBEYWjwjQ0bpQ93wtv62jUTw+FszO5gIoH0cZVf+OudbcNrgfpqPl3AipBfOMLPP7ExQMQmAFha9fwmN2PATMqTDvZbAxabplja7/h6gW1RqUShVN5THuFkW8wy05bGEY4v3/3w3twqPwt5BJXbxWCJ9+s0qkzqlRcisizlg5cIC2owjZWPaGvi8sUohAcXsuSvoji+IIdplb0XBL3hf+rA3SFe6fRiFC8p4ni7wyr6TTgLtnt8f9t7YVRPHKmQKiNRUXW8ZXE3Rk8TWQKhxqAXGuUhVIb1cmsvOnBSLTL17pt1NFZUDtK4t2Ba9hu+tx8fnDy/RiBqPaxemELJbA82fRsLi/CZyXrh4xt43etIceQRoVDovFThJbS76H1mHBjs08c6+UK9Fm0qnemIg/e5Yl/BzHMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(53546011)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(44832011)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(54906003)(6916009)(66556008)(66476007)(82960400001)(966005)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkdZaCsrRzNGbXBlN281c3c1SGVIZ2JJYzkwMzFJbE1nU2orKzFPM2E4eEd0?=
 =?utf-8?B?eEVmYkM1OUw4U29qMFpadFUwYUlSNVp3YTVSS2lOblczMjU0djFURVplNXlK?=
 =?utf-8?B?Z0NqcXExdWk3VEIxL2RNQkRPdWh4ajdMTFJqWjI3ZjYyb2I4cUxtektWSUoy?=
 =?utf-8?B?bEp2OG5OUllhWVFEdUlBeFZYalNRWTFxb28yYmNtbEtCdmUwMFg2eHUvRmN0?=
 =?utf-8?B?b0Vxd1pmbGJTalN0ZlZZRmVpRTZaeHVpVjR6TnNuUkRWeUFWM0wzUFl4N01G?=
 =?utf-8?B?eEhIOGZZRU1qRHNKUFpzejRCVFZoWWlHenhXYk5Lc2FNOGV1RnBFU3BMYjFW?=
 =?utf-8?B?NDdYUloxa3BzTnVPeXhYeFJoVTZvM09sZU1ldzZmckZkTm84THhLeFZ1ei9k?=
 =?utf-8?B?MWF6NFpEOFR6S2dCbC80UzVxY3VISDVjRk00alRTOURiSHFwcUQvYnFEV0Iv?=
 =?utf-8?B?RWphMm1sbDhKdm50a0tKOG84NlFEb09aNDFiNVBnNXd4WTNXR3ZxbnJUVHdv?=
 =?utf-8?B?ckEvZ3F3dGJFMjUyOGd2NDQ0OGd4eXVyeUxvZjZYSXpWc05kdDByZmhsbEg5?=
 =?utf-8?B?TXRZNmtHa0pEWjB4Q0svQWp2WFkxMDkwc2tHeklxL1podXJhaHliWEwxRU9B?=
 =?utf-8?B?bzRxZE5ncDlvSkRlSkx0bC9FbTNLT3pOeGxwNjZoVTM4OVVNd1AwREF0RFRh?=
 =?utf-8?B?ZEZ4RHhjRjhIWDhZa1NoSG00RGZ1dm0wOG5oU1g1ekt5VHVQcWdKNE9KY3Zs?=
 =?utf-8?B?VU16NUpxK1pJd2VVa3A1TXFCeCt5RWw2N3p1VUNzcGp4WWdmRjRsNUF4M2s5?=
 =?utf-8?B?NlBhUi8yeWpSVU5GWVpzNmRUVWFjZXY4VldHc0xpK3BaQWVXSlhRUzl6WXZ6?=
 =?utf-8?B?eUYrd3VPQVlqMk4xOUY5eE9nL3k3UjVTcm9RaFgvOWtOWEZ1NnRGMHE4VGRK?=
 =?utf-8?B?RThjTWU0YlMrR1VGNUZ1OHd4VVMxN2pIZnJ2Vkp6RHdQa2pDekhha2poRlZh?=
 =?utf-8?B?L1pkK09XamE3ekdObTdNdjhTWGJpM1FwK2RTa0p3WXNKcmlOZVFvVHBBTEho?=
 =?utf-8?B?UjVvQXZpNFZWeHd0ZEhRcHFaYWFBZHFNOVltOElkSFZ5RnZRWUgvenY0aGUw?=
 =?utf-8?B?NkQveHF4Z21xSzk0U1Q1MlVycHE3VW5hM0JqTjdyZE4wSnQ1cHVDYzNJWWkv?=
 =?utf-8?B?NlI3R21MTVhYUTI0UUZtdDN5RmdHdGhLbUZiK0tjZ2hrVVVNQXAwSkl5VCti?=
 =?utf-8?B?ZE1sZFk5ZWY0TU5lWTFsN1oxZVlvR3Iwdm9Ec011V05ZYmVhdHhmbEhlWVNH?=
 =?utf-8?B?YWVJbm94RUU5aXBMYXRkTHFNamxZbU1CRjlwejBTbzRKTnE1bUEzeEhtWjRo?=
 =?utf-8?B?SkRKa0doWW1Zd3VZY2hnRXkxeE5DWFdxTTZUK1VHNW5LdHVQd2dhNFZocWFx?=
 =?utf-8?B?T3lRa3RHUS9vaUFvWktaZ2JtcGEwcVAvVE5kYnJHRWxLQWx3Q2dCY0ZIbG9G?=
 =?utf-8?B?VzRlUTdlT3VUbzhDRCs5N3ZyY2g1d3N4L2VWYmcxWGtxeWcxT2U1S0dGbnlO?=
 =?utf-8?B?SHI2WWQwd1YyRlUwalduUzVFcmVKVk1LcHIzWWx6L3ovbUpjRjZNNWI4Qm42?=
 =?utf-8?B?TlByYmFJRTUwT2xuNHJXS01sS0FNWWdZVTl1dkhPdFdFbkxKMXpiMFJrZzJV?=
 =?utf-8?B?RUJ0dFRzQlh6UDcxeHViajRCUmZTNU1QcHlwekRBcjU1dWVyZ2VWTmlMdXFv?=
 =?utf-8?B?TWQ2UUM5bXlKRDhwbTd1N0w0RW8vMStLZHU2alFDTHRHQm5keHA5V1Mzcm04?=
 =?utf-8?B?VU03TTZCQUVGcU1salNwcmJ2QWJ0YlJ2Mk5LdUxaaWxFcy9FYW1wV295d0JJ?=
 =?utf-8?B?MXdMRkhuWTVTRHZSVFVmV2hvaVlmSXB1V253dkNtL3I3TjlTSTJ6cml6bnBC?=
 =?utf-8?B?VktQVkgwYSt4d0dNQVg1UUhyRlRUSTAzd0lvcHRNWHd0ak16L2FsdmRIR0hw?=
 =?utf-8?B?R3lZY0JsM2dldzV3UmhkRE1kek03NWNkbkwxTG93Mzkrc2FRemVoeFdDVVFG?=
 =?utf-8?B?T2R3czhldDhvMWpHSm5SeFl5R3JIZjhDdGpZUlJyRGROOUg4TFJUNXZhem14?=
 =?utf-8?Q?gnSsRp9ljkQUAM9iov5cURlzq?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f2a081-e2fe-48a6-9734-08dba23c1db2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:45:28.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NhL4/bb5ccmh/UJoSrKMVfgN9s5Lotb8FdGYt/WWSxPRNFbZWOJo5itVuu+Cm1TLC7gnrEhmYepVRyx+jVlLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7574

On 21.08.23 08:41, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 15.08.23 12:18, Philippe Gerum wrote:
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 09.08.23 15:11, Philippe Gerum wrote:
>>>>>
>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>
>>>>>> On 09.08.23 07:52, Jan Kiszka wrote:
>>>>>>> On 01.08.23 15:26, Philippe Gerum wrote:
>>>>>>>>
>>>>>>>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>>>>>>>
>>>>>>>>> On Mon, 2023-07-10 at 08:59 +0200, Florian Bezdeka wrote:
>>>>>>>>>> On Thu, 2023-07-06 at 21:00 +0200, Philippe Gerum wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>>>
>>>>>>>>>>>> Hi Philippe,
>>>>>>>>>>>>
>>>>>>>>>>>> quick feedback on latest rebasing:
>>>>>>>>>>>>
>>>>>>>>>>>> https://source.denx.de/Xenomai/linux-dovetail/-/commit/8f155631c8b51731dfc2ae5145d4dcc68f2ed7ed
>>>>>>>>>>>>
>>>>>>>>>>>> This was likely accidentally folded, right?
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> It looks so. This conditional statement appeared upstream during the
>>>>>>>>>>> v6.0 cycle it seems, and was unfortunately left unfixed in the dovetail
>>>>>>>>>>> patch for this entire series.
>>>>>>>>>>>
>>>>>>>>>>>> Furthermore, I will factor this change out into a separate commit in 
>>>>>>>>>>>> merging v6.1.y-dovetail, for better traceability:
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>>>>>>>>>>> index ce8bdd804bc7..c843bf352999 100644
>>>>>>>>>>>> --- a/arch/x86/mm/fault.c
>>>>>>>>>>>> +++ b/arch/x86/mm/fault.c
>>>>>>>>>>>> @@ -1466,7 +1466,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>>>>>>>>>>>>  
>>>>>>>>>>>>  	/* The fault is fully completed (including releasing mmap lock) */
>>>>>>>>>>>>  	if (fault & VM_FAULT_COMPLETED)
>>>>>>>>>>>> -		return;
>>>>>>>>>>>> +		goto out;
>>>>>>>>>>>>  
>>>>>>>>>>>>  	/*
>>>>>>>>>>>>  	 * If we need to retry the mmap_lock has already been released,
>>>>>>>>>>>>
>>>>>>>>>>>> To my understanding, this was a dovetail fix that applied to previous 
>>>>>>>>>>>> versions as well.
>>>>>>>>>>>
>>>>>>>>>>> Only to v6.0, however this series is not maintained dovetail-wise
>>>>>>>>>>> anymore, so this stayed under the radar.
>>>>>>>>>>
>>>>>>>>>> FYI: This change fixes a real issue here. The 6.1-rebase branch made it
>>>>>>>>>> through a 24h stress test while the "merge" branch failed. Happily
>>>>>>>>>> waiting for the next release...
>>>>>>>>>
>>>>>>>>> Do we have a idea / plan when the next 6.1 dovetail release will
>>>>>>>>> happen? My internal customer is waiting for that and I want to avoid
>>>>>>>>> backporting to 6.1.34.
>>>>>>>>>
>>>>>>>>
>>>>>>>> There is a brewing rebase to v6.1.42 pending tests here, no challenging
>>>>>>>> source conflict. I pushed the tree untagged to the v6.1.y-rebase branch
>>>>>>>> if you want to give it a try before Jan updates the stable branch.
>>>>>>>>
>>>>>>>
>>>>>>> We are testing against -rebase anyway (but that needs a trigger which I
>>>>>>> just provided). The merging branch is only updated once there is a
>>>>>>> release tagged.
>>>>>>>
>>>>>>
>>>>>> Passed with the Xenomai 3 tests:
>>>>>>
>>>>>> https://source.denx.de/Xenomai/xenomai-images/-/pipelines/17252
>>>>>>
>>>>>> But can we update to 6.1.44 directly? Florian mentioned that there are
>>>>>> Downfall-related fixes in that release.
>>>>>>
>>>>>> Jan
>>>>>
>>>>> yes, .44 is actually brewing here already.
>>>>>
>>>>
>>>> Now we are .45 even. Will this one be tagged? CI looks good so far.
>>>>
>>>
>>> Nope, .44 was broken due to [1]. .45 looks better with this fix in
>>> place. This issue triggered on kvm/arm64 w/ PROVE_LOCKING enabled.
>>>
>>> [1] https://source.denx.de/Xenomai/linux-dovetail/-/commit/60ae6e4ea6a074698be4d999e96e9c3697b18ea1
>>>
>>
>> Thanks for tagging v6.1.45-dovetail1 and v5.15.126-dovetail1, I've
>> updated the merging branches accordingly. How about 5.10?
>>
> 
> Not done with testing yet.
> 

If you push to -rebase, we could join that effort.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

