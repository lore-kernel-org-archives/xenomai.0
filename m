Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2081.outbound.protection.outlook.com [40.107.15.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BED7EF
	for <xenomai@lists.linux.dev>; Tue, 28 Feb 2023 05:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5sFjCe9f5wBO/zqomNJ1i5flp/BGbvIVJe33FBiXXTP7sTz11RaHcuR2wI7fJVOcmoEU2DWFMg8cVW/ZclqSnhHCekgBSrcnaZ3+lZiHLXntXmzBL9Xh2vHTE7yW/oNfv8ShDfB6QZmwtZE2y3pUaxzmcngVQZpAoU4QIYyOCuZip/G6LFdTiPa+Ldy4Uh5xIHbQhYIDlC3glCF+yfcPoi/6hRb6MLDaTu2BiU46pDQZt8zaj6UzzjX3i6zVIaJqn94xJGu7vipSaBKdRIVHtlrCMd1XwHgKnH1ZmWyGq86DWdgMzykiGft0pZJWmpBj7tQlKFEwXFN1Ru85rtKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a86+x7gUJpQgQI+Ls/5dJlEzTrJj4RVYb5jKP4wtyW4=;
 b=HMj0+4BMf6gDI6UZ51S89n3V/2+h+jzEO4g4DNArIdjazMmcfK6vm+BF7y67yCUnMbv7JJmxc0uez3kRz7ht0wUGtm7Q9wCdaHpg/sRACX8tEgJXNCD1Bz7nLjHSZjo9yG1ht80eAZAzkMvpbfdUuLVp7iInnEGIKfLFToWd7xrO6NUoy6YC9sf58/dFM9BpzWZaC6LaNcZN6mZXc844BqqO1b1i42PACkbyoYSQfMDd4NmrsKdMN4M6w/VihANilQNux4ELlZfbBU0mwHKKuPxTlT0D0PVjIDMqVY6+x2Ogq+D1jRvgSBLSc0u8AQQ1dBsjkXb4KbAmly1OIkfniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a86+x7gUJpQgQI+Ls/5dJlEzTrJj4RVYb5jKP4wtyW4=;
 b=XpqOUEoqkQodpWp/65xz7W5eMR+cKU2moGmGhcYIjkcl413el0K804eyguNwZXj4tdkj0S+JaeUoYxe0eovgtEYXoXgtlD7K1JslVNFQSZMcdu32553uG1dJIoWCUauXBwPW5VMLhthVr6NmQ9yYH09OehJ8ht6W/0RwE7ls5yX+TctN9mSn7kBECYWxDvgqm7AZNl5hTQ5N+VbA4qjTBYdojZfA+0+PzsqfTDPt5Ge+cWYU4B8sdBWcXSYTakbk8UbPUwi+RP2Y6yyquJQD9spZiEe4utx86a+A/rD1elgkrDKgg8kSvwt2GLZnD103BS4k8wAeNE51TJaFohOlDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7363.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Tue, 28 Feb
 2023 05:48:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 05:48:26 +0000
Message-ID: <954672f9-5367-603c-1721-1047a4e18283@siemens.com>
Date: Tue, 28 Feb 2023 06:48:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: arm/arm-64 ipipe release
Content-Language: en-US
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <CALLqZ8T=c_ngHcuU5vkpLVfzbN4Kpfh-Aqzq2vKErCYqbzyQWQ@mail.gmail.com>
 <252602b1508b13bc480f6c971e13b02ae7702071.camel@siemens.com>
 <CALLqZ8SiSB8e1VJcCv06H7Gc=zwiLf=6kBisB73yCT6VhRRRug@mail.gmail.com>
 <CALLqZ8Sk2OejX_aZRSiMqdDunY-5nG_Gr5Guf032HhS41ewD=Q@mail.gmail.com>
 <9a49e98f-2de6-168d-51b2-22c68c2d8084@siemens.com>
 <CALLqZ8TA_yUvrSMvqbrLOD1_+pqE+SVxZ5-=FwgrPX+k5KgOpQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CALLqZ8TA_yUvrSMvqbrLOD1_+pqE+SVxZ5-=FwgrPX+k5KgOpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a11c43-8c6b-45b9-edb3-08db194f6994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FEBJfI8VL3UlB8cBrfmyvlTXTINkNqejrQPXq5vuXsMUelWZ1eKFQI6KynEt6gPjL3kQjf/gLM56Cl+aen4iabK3jKDX6MH1LVl+1+MKjNIskpEtJU+7n5A27WNt2L+o42p7X6jIOz29Vp/J8fEHDVj7TWJ4Xw38q9VOxNUlBPLA8IZSuUo84DaszOjxvyexiXPSBPaIV2Iu5XxZ2vLzqIcNUf8voFQPv9M9KHAOq+dE2avrmYh9D6be2A/v391svfJYthq89EDbTRQhbm0ZYUTxJEEKi5xag6fPrUEn65VFbwGoiFCTZMUeWQPM1XeNnRKugksRyXAu7/lZJ9q07hiVD4F3p4wq48gGKrzP/ufYIpGT7RSV0nlfTKmmHW6W13I8FQLoL3rob5iuVi8wxjQVcqUOQs3zF3cOMhgE1iqmcFSxrYIwbQOZKMKm9lMcpB1aaY5RC3JE3N7AG1ayAcIHvfMoGSqrvVUzFQT18wivqjxmSvuO3livMkdHiEgrghUM3eogmQOyGjs6+pxpeAE9EQm3yZve6S4WXp0NR7HcqazWZVuW+45O8o8sdNplXD7L8o6XyL6XDNMciUdaeBgBBNfDWZApYwS/xATiVnMJ7ZFRsSwcGXgDMgWFL+pg4K6iiBHLgs83U8mYvqWPw03DfKOxu9pOzhIJdv2iqxZWXA8vVze4XSVIZow9K5xIOmaGuYckv/tDCTQT9RUOKP7akYIRe/KGGsbzgAwYw2qMXbwEMA8hHr3ZsME88BaOiJgGkh/8mJrVjTvVjydGxjadUpe6QuQ7u0FvxNPxlcigf47F5Ov1xqSyxSHOa1ej
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199018)(31686004)(2616005)(6486002)(966005)(86362001)(31696002)(36756003)(186003)(2906002)(8936002)(66476007)(8676002)(6916009)(41300700001)(66556008)(66946007)(5660300002)(4326008)(53546011)(478600001)(6506007)(26005)(6512007)(44832011)(38100700002)(82960400001)(83380400001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHJHYXlXUFJBOXlXMzhrMEdXeVIvMGJURTFTWkt1cXpJMUNCWnFCdDNtb3pZ?=
 =?utf-8?B?RmhwaUVnbi9KelNxM0orSmxzVzh0NlhmVndLcXc1SUM3VFBxMTEzMDNUbThT?=
 =?utf-8?B?TXdMbE0vKzNBZlhaY080YXJqcEFvdndlaGpGZ0dSQjQ5cXozUTJtM0tYZDhs?=
 =?utf-8?B?WHFIaVpYSGE5WXl2S3NIWWlGcWpkaW90bmdSeFNFeXkxWU41eTQ3UWdBdXVB?=
 =?utf-8?B?dGF3d0luZXZwSDNPUC80cXFvZVNxVjRCSG14MDVtNDZuOGhtOGVROE02dUI5?=
 =?utf-8?B?R0U5RDhwZk1YSEM5eWZ1N1UxQngrcE4wZGlqVEFoR3NZSjBxa2RPcGVEeTlF?=
 =?utf-8?B?WWtTSkxaSmtQcmRMdWJNc2g2M2hhd1NpNW94R1lRSVpyeEVHQUtoUzhFaEFw?=
 =?utf-8?B?TXlaQ2RHOXNJeklld1haSVhsUWlqWFVvUGFFdmdWblU2b08wRStkMm5IaUt3?=
 =?utf-8?B?WkxPaldKSGxZOGREZWVOaG9iWUFGUXI4cTF2SDlEZG56VTRERU1tWG05VW5u?=
 =?utf-8?B?QnZjN2ViUUxIMCtMY0d4S1YzcEV2K0UvYXRxMG5YbEd1T3VZZDhma2xPdEQx?=
 =?utf-8?B?dEJnbEFPVEt2S2lCUzd6RVdseWdvMWJ1MVZrZE81NFpjSDFhWVdKUDdqSDRx?=
 =?utf-8?B?RXJjWHZ6VjlyeThFODV3Yk1JL1lMV29wcjdJdVhZTmpVU0FCeFgzT3YyQS9R?=
 =?utf-8?B?UmVLRHVrcW5YZVp3Q2JPYjBleFZYWXF0VldUL3dyZnRQYUFlZTBrNHVBcDZi?=
 =?utf-8?B?NFZFbFNNalV3U00yT2VGNTJ0TjFEc2RBcmFVM2wxRmJ3a0szMjhJMDZxZmkx?=
 =?utf-8?B?eTNuUkdzY3EvNlZ6V3dUYURXamx3VDVkZlFCakNNMllzQjF5emZSckkzZlNm?=
 =?utf-8?B?YTNScmt3eWt1WFR2OHRRL2RJTVJSY1k2UTNmL1VZdDBUa3RRQWpPK3QwbnVs?=
 =?utf-8?B?Tk41REZoUk9PYjhMajEyV0pDMTdha2c1MnZDMkRjZlZ6UFBVc2QwNWxWUFNx?=
 =?utf-8?B?SVorSTdHMEZ3QjR1N1B0dFAyTGtINGJkWDd5UkpPZmRFUlY0NGwwWWxKQnMv?=
 =?utf-8?B?NGlYdG5CbE5VUmFuTGxYRWxqKzBJbTlpT2xoKy9jQ1N5SXZoMi9hNnJSMG1C?=
 =?utf-8?B?c1RPNDBiaG9xcDFub1JNdjBuRWlWVUxlSU1XdjJxUm40UWVuODB5ZEt4VzA2?=
 =?utf-8?B?a3EvdXVQT0czNG9LdncrRnU5cW1ZalVjMGFxZ3c2cGF0ektGUDdieEl1T2FG?=
 =?utf-8?B?L044b2FZeHFHRDlON0ZFcjRsZ2dSMWxKMUdQRkVvYnNGa1M2Vk9tTlZSdWdK?=
 =?utf-8?B?dFljYzJUSFRwQ1NKUVpqWHFoanBUTHpWWm00b2lwMWUxbnk2K1lUVHF4ZWV5?=
 =?utf-8?B?Q2M3bkJiQXppMWlJSy9FZ0pNRnFKQ21JenhxZ3dPUGdzQkZ3VHYzNkszTFJK?=
 =?utf-8?B?UUtLQ3U1aTRZMzNLeUEvc0FZOW5VVUN2a3Q3U2tUVElVWHFwdEl2NCtDamZm?=
 =?utf-8?B?RURwTlJ1bGYyaFlQQ0JnK2YwUWpjaFA3Vk1SVGlhNnZtS0QxRFlndi96SjB1?=
 =?utf-8?B?T0dHT2Z2TDBzWjhrRzd5Rk9UOHQ5UjhScmNxVnMweTM5bHIvdk5HQTg3UlZ5?=
 =?utf-8?B?blRVWUdhN3puakVmWVhpU1FSeTRwRWIrUlRYU1pHeHVtUE5tclU4ZStPd3hU?=
 =?utf-8?B?WlRlM2hwVnByOFJtWFRNTWFQUXdnczRJSkV3eDdVSVY0aTdqbWQ1SjAwY25V?=
 =?utf-8?B?a0RqNUFKdWdlT0g4MlNRRlFEcGhURC9qMEEwWDZRTExQeDNZSTJFYnVyaDRN?=
 =?utf-8?B?eDNlazJ1MkFLTmZnWUM1d3oxa2VEOW45UlFpWEJOQlpBSXpjUDlBaGZtblB1?=
 =?utf-8?B?elFWeHp5YVAyMis1c2grY0lhbFo0Wlp0c3lEYklGbmFBK2NQQzl5L2JpNHR1?=
 =?utf-8?B?ZHl5Qzh0MGRQa29hRnVka2RsRnZWdjV1QVQraGFremFmSHhWb2dhQ3k2N1Ni?=
 =?utf-8?B?T0RvWmlRQ0wyUnpIZzM0TEM1S2F3YXM0YXh1V201b1Q0ZlZnTm9VdHFueTl3?=
 =?utf-8?B?K0tCUzdkUW1mWmY4MXNjZlRnMDBJbHFZeVZBZW9JNHpGVTk4YjhpMlVSbDkw?=
 =?utf-8?B?ZHErcUV4b3pMQmt4dXNPdXpCZFVzRnJaWjMyNDNtZitUSUUrSVJHdDhJalds?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a11c43-8c6b-45b9-edb3-08db194f6994
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 05:48:26.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6VTWaAJJcpkcs/pbZvfCn7xrGlUxmIkoskawVVbyzxOkfei22k0FZUM39T7XQRe6yAN0x1T7ZMnNJVv2UotBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7363

On 28.02.23 06:18, Greg Gallagher wrote:
> On Mon, Feb 20, 2023 at 1:42 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 20.02.23 06:27, Greg Gallagher wrote:
>>> On Sat, Feb 18, 2023 at 12:33 AM Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>
>>>> On Tue, Feb 14, 2023 at 11:56 AM Florian Bezdeka
>>>> <florian.bezdeka@siemens.com> wrote:
>>>>>
>>>>> Hi Greg!
>>>>>
>>>>> On Mon, 2023-02-13 at 23:01 -0500, Greg Gallagher wrote:
>>>>>> Hi,
>>>>>>    I'm almost ready to release the next arm and arm64 ipipe patch. I'm
>>>>>> working on stable release 231 since it contains the patch that
>>>>>> hopefully fixes the UART irq issue seen in CI.  If there's a problem
>>>>>> with using 231 let me know.  Finishing my local test this week.
>>>>>
>>>>> Thanks for letting us know. If there is a chance that you publish a
>>>>> public available -rc somewhere, it would be possible to tweak our CI a
>>>>> bit and trigger a full test run in our lab.
>>>>>
>>>>> That should help us to identify any leftovers upfront.
>>>>>
>>>>> Best regards,
>>>>> Florian
>>>>>
>>>>>
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Greg
>>>>>>
>>>>>
>>>>
>>>> I'll get -rc releases out this weekend.  I'll post back once they are
>>>> done and the -rc tags are pushed up.
>>>>
>>>> Thanks
>>>>
>>>> Greg
>>>
>>> Hi Florian,
>>>    I have the rc releases ready to go.  I'm going to push them up to
>>> the ipipe tree with the kernel update (5.4.231).  Does the CI system
>>> pull the current ipipe release based on the tag?  Would pushing up the
>>> new point release (5.4.231) break the current CI?
>>
>> We are pulling from the head of ipipe/4.19.y-cip and ipipe/5.4.y for
>> ipipe-arm[64], see [1]. It just takes manual triggers so far as there
>> are no ci files in our kernel trees (unlike the xenomai repo itself).
>>
>> Jan
>>
>> [1]
>> https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kernel/linux/linux-xenomai_latest.bb
>>
>> --
>> Siemens AG, Technology
>> Competence Center Embedded Linux
>>
> 
> I put the beta releases here:
> 
> https://github.com/ggallagher31/ipipe-arm
> https://github.com/ggallagher31/ipipe-arm64
> 
> Branch names are the same as gitlab, once CI tests out the branches
> where are the results located? I'll look to see what debugging is
> needed.

Anything speaking against pushing to the regular branches directly? No
need to tag/bump revision yet, you can do that after CI passed. That's
how I maintain the other repos/branches.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

