Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82D9447
	for <xenomai@lists.linux.dev>; Tue, 22 Aug 2023 11:31:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRS2YnSNZZHOkVtk7IJAba5ckSF0fIGnk/i8bIr/PIAHtzwLpMbcYWSIELEU7Ak9Gl3i25r65NL6iGG1ggPNPtXsbRXKq4i1nTLsBKUgprDy/AiuaC7VMzfZQAEqKamVWG4SPW+enLj+Sa3qw+Kq6qBRxLKAJQuEVa03wCllqR3HmHEj4WR8hfubQubKmaIWGMInZOxGR/8Mgfv+MW7PMq0uP/Jt5VYz9i1CtrW4plpeGzzORUMg2hvBH2RgK1DpZjeR0QmGt7512moLTHpmfVMxt6jDNf7b44VmTWzKIhmdywrvWPZ7JaUwsC1XuLf0AtUNZlGjiHHJpbjKb7mDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8GvNmfXpGv8lT8pHhK3+jP2S35trL34Jans8FDnkQs=;
 b=TgUyyFk45RNgNbp8G7d0BRH9Yv6BFEEJdqk7P+3K4cOBGWG3wEIh92ZmuflBpSOH2RS84fo1zFZeMjVEg8d59mkgnrNF5AUxYzWpReVd5uy9VNt0FlQlzt0ra4Jh7kbksU7Uqgh7eybnieP0K0Ije1ixp+huOTcpx5MV85ejR634h4r0ztqDsPXj6pXeePCKFeCltsTEQOukhjYEIVFD7flvUYZ3yO7LfzgHmgdOrg6TJYtc29FX2D6P/jUTQBEzb9pkdY4ePkPKe2j+fsa/UkHZXbGv5+KO4UGu3NVwtAXLp3o9YKuiwCS80eIAmKmF0HX+EVCBacc5mvZuRIq82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8GvNmfXpGv8lT8pHhK3+jP2S35trL34Jans8FDnkQs=;
 b=eGrZArGMTLjw4kUHmrDVozwS3ixvLmfvyT8mG9yojgtnyGYPAIWo8h38GyCYbXWN0KCwTv3yI+66nsBzsX8xfjKRutls7wIj1hoG2V+2kirRPY2jgzyV5cCdB0kr3pAY1B9G5Yr5E9+6oMiQHUzkN+r+54gaST/NOV2H0tux0PqB0iDxX6HYZKd9VLcdqRIdyWFZ0z8KsUjH9fMXwu7cgGMQ5HNDOk943beY+MEFF0JFjpLsjYwLrVhbvytTIWRm6hKVHAOz7DuJpjos5NWeyfRSP/G56v25cCpXfDtfXc6lPidE4WABP7RcPy+K0Ox0yjlPKfktKHjQYtWJRNfakQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6185.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 11:31:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 11:31:02 +0000
Message-ID: <c4aececb-ba47-4e5b-aa2b-69860a2b421d@siemens.com>
Date: Tue, 22 Aug 2023 13:30:59 +0200
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
 <a9f08036-50d6-4322-8ba1-0508aa77f5c4@siemens.com>
 <87wmxoo82k.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87wmxoo82k.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 058bbe80-17d9-4ed5-5c3d-08dba30343a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2uL15ZMto+ZtpoPGP+wh/WLQWE0266nJ5G09cwStNDi/+g578eFaxJIATlO5TahtVmmE919KG2V4gIErwIz3wxsCltMj4NZlBA4gmu+nRj4vVTdLWB6k9WI2quBqVL55EgA04EXwIHow9MVnGta8K5oUJBBcpby7+k3ap9X2QD6okIjq40sRtqMxG/q8wtIjqLt6LTS8HxtaKfMFwAoDl0pGV3aSZvGROWrSLJ6FFaqLdQDyICVNIl1FhjBi38yB77nXHN01PI/3cGICk7FDoTaya3AdCMCtP1lRvMDE+bSuCvT6Di0jjqZPZUZw3k9q2hV6yUDI8itSiq9v+mYCtGeQD6rLoQbDuPOV+8DVNZdVYazyGX3rNAswTfwlVHY6o9llJCVB9RMwOJjI/6V9Wd339f62gNJXWBtN1z04PCVDEvPIEscx91HF1Ozo+p/FTpQi7QznXB9Vy8nOBgCp8VqVTuwf/EnX7Bb09Xw1Lyfk9mUqQsi1JnEiTDeoc3xsHcUuTq8xnnhwBX8Z8r1bcvoaxRP5Gx8FIpL8VXy3imZOWU3pUmdntAXznmwSsX0ONmYA0bOHtGqbiqgdOuSQTJD8W+aE8AqSJ1Q0jjhiJGRMS3Knxlgb3jBcvo96GyOu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199024)(186009)(1800799009)(86362001)(5660300002)(44832011)(66556008)(2616005)(66476007)(66946007)(316002)(6916009)(2906002)(54906003)(966005)(31686004)(8676002)(478600001)(4326008)(8936002)(41300700001)(31696002)(82960400001)(6666004)(6486002)(53546011)(38100700002)(6506007)(6512007)(26005)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm5ZMnRiRzhGUUZJVkdWbEN2ZWlFUW8rYlR0eGcxNVpqN1BSNGVPSVVRWU8r?=
 =?utf-8?B?QmtwRElNbFRROUJEamllS1VZT0lNZmxtNUpDamF2YUlwV3VTVCtFM2dmSjVW?=
 =?utf-8?B?eFFKVnVwYmhQOU1VV1BJdmw1Mmc3cUR0U1hheUlRNWdzdFEvTFhUTnV4N0ln?=
 =?utf-8?B?WUVrOTFXV3VKMFhHY2FtT0swdEdSWDlvSU4xU3llaThDZVNSanZxMEQ3NDBF?=
 =?utf-8?B?VHFlV0VQallFVWIySUFabGprVzY5QmcrZDdIdDJWRG9RdjUrWWtaVFJhWnpp?=
 =?utf-8?B?bVJlMDFKdHJjdXo3ektuZkxyN0U5cGF2Q0NVZW9UREY3REZZS3VOR2V1ekJ4?=
 =?utf-8?B?YzAwN2F1QjVQYkZmRURSOWJYSlM3MmR3TlhOVHlsVk94NmwwUll5SFZYbk5M?=
 =?utf-8?B?WDk4ZmlvVjZleVJ4Qkg2R3dIZW9ZN3ZrQ25MdTZ6MHJTbUt2WUw4NGlPUHlP?=
 =?utf-8?B?QWF4QlB5ZGNlcnhhb1pLcmhJZkdsZFVhOW9YODRZUEVWcTZScDNBeTdQQjU0?=
 =?utf-8?B?N0gzVnl6T0FJK2ttR0dHaGFUZDBGcUlKWHdKM3Q0ald1dEJsZWo1V3RVcG9u?=
 =?utf-8?B?RlNnZ3MwV3lqdnA3UTByODZQZHZsZWRLdnVuaEhWR013VENvSG1DTmZKL09m?=
 =?utf-8?B?M0p3Rjk2SGcyaHBESXFKdzNPUnV1cnJWYmZJT0xEQ1BpNG1QUklGR0xyOFh0?=
 =?utf-8?B?alJIUjlHMTdBUUVUK0hqaUVSckpYTmZNSlk3ZGxqc1pZZ1FlbGRmSk1wV0FV?=
 =?utf-8?B?VEEwNVloQlJTSU5vckgzWVpScE0rQlFicXhkb09PZDAyQ0JjbllZQ0FMV29q?=
 =?utf-8?B?S2ZxQmpWSDNXckpiWXo3bGZhem5TZU9YSUEySGVVTTh3dXh5dFpCVG9NVk5u?=
 =?utf-8?B?bllHcFAyTVcxeFNtYmc2c21FbE9EY1hxdGEvNEgzbEdNR3Jrd1lYeGJwSXNm?=
 =?utf-8?B?QnJUbHYzWGtKVEw0SlFoNVFRM2Q0U1hJTGZiODFZaDlYVGdzN2xGc1p3VGxx?=
 =?utf-8?B?cDFjd1V5eVkxckJsaTZmMEx1Mm5VV21GOWV2R3U1M1ptRjhCSFovRlovaGYv?=
 =?utf-8?B?REw0WVdYZmo0MnovS0V1SDZKWWdVanNkZVJ5cnQwWnpZL3NTc2lYWWcvM29G?=
 =?utf-8?B?SzhYNWsxZGRIUEVlZW9Bb0s0c0F6ZVJOMUV3cEk0U29jWXdETXVISlJqMURJ?=
 =?utf-8?B?amw0bmV2VC9iTEV5d3FkRmVhcVVCZzNKaitoTHdFU3RIcXVsQzRDaE9iMXA3?=
 =?utf-8?B?UVZrM2RRZ0MvTUdzdWlZVEE3aTZlRFd3QUhMWkRXZ2xacXpHMUpVb1JUdllY?=
 =?utf-8?B?Wlo0UmV2d3A4OXZpOWJkVHJvcmdJemNBTEc3NmRCTFltN0lCVnMvWWk1NXpj?=
 =?utf-8?B?VEFmKzM4RkZOS2FaaHJRM2Y4cmx0NW53Wm4vbEpOTDFPQTZHYm1kK2ZrSU9K?=
 =?utf-8?B?cHMzVE9DWTBVZDZhYUh6UXdQYjYrWEN3L0VUbGJzWnkyOW1zRHQ3alVpd21C?=
 =?utf-8?B?cjJGZE14cHJ6alZxRGpncEx5RmpkMzZVckpVOVBITElMb0JhMTRXRE1NdlhU?=
 =?utf-8?B?bDR6UVVBTkFFQlJKVU9IazNLRnNNbGkyRFJ1bEwzcDNSTnU4a2dwMEJ2cG1B?=
 =?utf-8?B?cFN2OXJRK2phdHpTOTByamE1ak5UU0FVT3d5U0ZjeDhmTFpYa0xVeFltRnhM?=
 =?utf-8?B?dDdzdXNSY3huQXZ4KytlQlRacDh5RjUyU2hVL3Z1MGdtcDI4S21mSmdFblNv?=
 =?utf-8?B?YmxieEZFSXpVN2gxVUhJMEZWZ2ZtVDMyczUwWDNyRjlPdjk3RTJ2SnFOQWY0?=
 =?utf-8?B?bG52U1IzejF1RjdPZkNjTktTYnpaL2ZGWW1tdHcwVzduWFRGeHhVYVY0Y1Bw?=
 =?utf-8?B?Y2hLR1AzWUJKNUJESSsxdVBZSnBpUnBaZFNqUnhxQ3V3VE5lMXJyMHFpU0lK?=
 =?utf-8?B?MTZ2TmN2WVdlejlrQm5WajBPTlZtUUJLcXhhNElNOGZpbTdSNmhYdEc0dDZD?=
 =?utf-8?B?ODY0eGFoN2N4UUR3SXZFSlFzUDJYakw4ZS9peDl1NWVyaDZiK0NzNCtZdXQy?=
 =?utf-8?B?U2gwTEgvbWhScGpGM25tYmdPQitVbUhQNjdhbTgyZEtXWHgvN0h1RDB5RDFm?=
 =?utf-8?Q?hdjrO5G6x20SC0L5bpnY1eifI?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058bbe80-17d9-4ed5-5c3d-08dba30343a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 11:31:02.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHp4T9Ju9Bff5g5QH8U9eH/DaV4j2i9MDE/dKwJ/PnBiw6WvNcQeALaU++f58m0xMej4rnKDc5gy+b9LiShnuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6185

On 21.08.23 15:09, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 21.08.23 08:41, Philippe Gerum wrote:
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 15.08.23 12:18, Philippe Gerum wrote:
>>>>>
>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>
>>>>>> On 09.08.23 15:11, Philippe Gerum wrote:
>>>>>>>
>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>
>>>>>>>> On 09.08.23 07:52, Jan Kiszka wrote:
>>>>>>>>> On 01.08.23 15:26, Philippe Gerum wrote:
>>>>>>>>>>
>>>>>>>>>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>>>>>>>>>
>>>>>>>>>>> On Mon, 2023-07-10 at 08:59 +0200, Florian Bezdeka wrote:
>>>>>>>>>>>> On Thu, 2023-07-06 at 21:00 +0200, Philippe Gerum wrote:
>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>
>>>>>>>>>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hi Philippe,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> quick feedback on latest rebasing:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> https://source.denx.de/Xenomai/linux-dovetail/-/commit/8f155631c8b51731dfc2ae5145d4dcc68f2ed7ed
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This was likely accidentally folded, right?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> It looks so. This conditional statement appeared upstream during the
>>>>>>>>>>>>> v6.0 cycle it seems, and was unfortunately left unfixed in the dovetail
>>>>>>>>>>>>> patch for this entire series.
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Furthermore, I will factor this change out into a separate commit in 
>>>>>>>>>>>>>> merging v6.1.y-dovetail, for better traceability:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>>>>>>>>>>>>>> index ce8bdd804bc7..c843bf352999 100644
>>>>>>>>>>>>>> --- a/arch/x86/mm/fault.c
>>>>>>>>>>>>>> +++ b/arch/x86/mm/fault.c
>>>>>>>>>>>>>> @@ -1466,7 +1466,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>>  	/* The fault is fully completed (including releasing mmap lock) */
>>>>>>>>>>>>>>  	if (fault & VM_FAULT_COMPLETED)
>>>>>>>>>>>>>> -		return;
>>>>>>>>>>>>>> +		goto out;
>>>>>>>>>>>>>>  
>>>>>>>>>>>>>>  	/*
>>>>>>>>>>>>>>  	 * If we need to retry the mmap_lock has already been released,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> To my understanding, this was a dovetail fix that applied to previous 
>>>>>>>>>>>>>> versions as well.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Only to v6.0, however this series is not maintained dovetail-wise
>>>>>>>>>>>>> anymore, so this stayed under the radar.
>>>>>>>>>>>>
>>>>>>>>>>>> FYI: This change fixes a real issue here. The 6.1-rebase branch made it
>>>>>>>>>>>> through a 24h stress test while the "merge" branch failed. Happily
>>>>>>>>>>>> waiting for the next release...
>>>>>>>>>>>
>>>>>>>>>>> Do we have a idea / plan when the next 6.1 dovetail release will
>>>>>>>>>>> happen? My internal customer is waiting for that and I want to avoid
>>>>>>>>>>> backporting to 6.1.34.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> There is a brewing rebase to v6.1.42 pending tests here, no challenging
>>>>>>>>>> source conflict. I pushed the tree untagged to the v6.1.y-rebase branch
>>>>>>>>>> if you want to give it a try before Jan updates the stable branch.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> We are testing against -rebase anyway (but that needs a trigger which I
>>>>>>>>> just provided). The merging branch is only updated once there is a
>>>>>>>>> release tagged.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Passed with the Xenomai 3 tests:
>>>>>>>>
>>>>>>>> https://source.denx.de/Xenomai/xenomai-images/-/pipelines/17252
>>>>>>>>
>>>>>>>> But can we update to 6.1.44 directly? Florian mentioned that there are
>>>>>>>> Downfall-related fixes in that release.
>>>>>>>>
>>>>>>>> Jan
>>>>>>>
>>>>>>> yes, .44 is actually brewing here already.
>>>>>>>
>>>>>>
>>>>>> Now we are .45 even. Will this one be tagged? CI looks good so far.
>>>>>>
>>>>>
>>>>> Nope, .44 was broken due to [1]. .45 looks better with this fix in
>>>>> place. This issue triggered on kvm/arm64 w/ PROVE_LOCKING enabled.
>>>>>
>>>>> [1] https://source.denx.de/Xenomai/linux-dovetail/-/commit/60ae6e4ea6a074698be4d999e96e9c3697b18ea1
>>>>>
>>>>
>>>> Thanks for tagging v6.1.45-dovetail1 and v5.15.126-dovetail1, I've
>>>> updated the merging branches accordingly. How about 5.10?
>>>>
>>>
>>> Not done with testing yet.
>>>
>>
>> If you push to -rebase, we could join that effort.
>>
> 
> This would help, thanks. Pushed now.
> 

Tests went well:
https://source.denx.de/Xenomai/xenomai-images/-/jobs/681220
https://source.denx.de/Xenomai/xenomai-images/-/jobs/681219
https://source.denx.de/Xenomai/xenomai-images/-/jobs/681218

Jan

-- 
Siemens AG, Technology
Linux Expert Center

