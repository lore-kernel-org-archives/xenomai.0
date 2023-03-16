Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBCBAD4E
	for <xenomai@lists.linux.dev>; Thu, 16 Mar 2023 23:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lH/X8zIWr4+ePF7wrRuc5RkW4Es+lfgV4dJtTSLCCqJcQlApo2hSH2+ej9HsUzmGWqMwtIOe2NGbd4fNhBx/FgeMFfQ/bx3TeC3AOfUOWxto6bTSPzEsx+JOnQt8up1cL192ExjAybmHbrelCw6uVLoFb4ex9IVyzvBoBtGsEKZDt+/gxZ8xhzS/cdFfaMAU/9NpYVJC2dmEHYtVWKucXJNG1G2q8ixMmdY+w6GHjlQbv6GbxpEgliRzJQ8PeCSm9NK7lIyo04Dkwcal81Rd/vF8PlKb8T5YbUhykva5tmZILiDUhicYngdycCIHAqBjtKG8sMrAAW7Vev5Kb6oNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7j/QrdjDFZpEhODYpRui+pXB2bKJN+DLnTzdHoJJA8=;
 b=IsqZfF87YRl9r+miXKAmseCB68nl71n33GCI8/xW56VNsXeYBDMdvxv2oNM9DDc7nCiyEY7u7zLqqT9/Sbzs+1I3CBEhMyWaXlTW/ZKmFUnIRWByAAwyTLh8ju/B++nmi3GOGdtmMcRymKyim3uyC7t8Nv8foAbTlWTuj3cFCCpm3Ike6cQ8FmJpDpntiCqxBXGwlOWCLmrPxB8RKjh9chb+JNAGzgWPSZxgssOts66edYVb7ryGatsTJ0oH3n+L8av4vyDC0NmCBGXoN2+CAJ1aw+x42uo89rm4hChu2cjDg1STWhW06AaDtLC6fGoENq1Voxplf/ndEtO90dlk/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7j/QrdjDFZpEhODYpRui+pXB2bKJN+DLnTzdHoJJA8=;
 b=uFJrbEAO977YpQ77orlKTYofnbLjng2qfcLknZTtRrWgZhYCx1Kbk0wtYhfuTJ93V7fHP11FNlTg7v52XD+qH+qYRoQfdO8Vy+bb/kWyyZT6Z2XgCt9UkOb16oUwHrO7x/dYGen0bUjRNZXbLzXJqW1ZidOoD4mO/1+YSsqg2mZSfau3uTnPVXZKO1PbV7NbGASqPr5/+CvIyTgG6Fh81X420KjwUooKR/bcGjvo87/CpNXxaYOG9OGOjbyxkz+MMJD4GC/S0cOpka9jaJApeYx+w7GwkCfmkA6+zwybw+0+4sLYn3JK6mYKhgxw8gY3q03WPwag+J6BDmR+pF5HzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by PR3PR10MB3833.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 23:43:00 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::70fa:c4d2:5d95:aa96]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::70fa:c4d2:5d95:aa96%9]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 23:43:00 +0000
Message-ID: <def247e9-8b37-08c3-0663-c504c5534009@siemens.com>
Date: Fri, 17 Mar 2023 00:42:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: arm/arm-64 ipipe release
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <CALLqZ8T=c_ngHcuU5vkpLVfzbN4Kpfh-Aqzq2vKErCYqbzyQWQ@mail.gmail.com>
 <CALLqZ8SiSB8e1VJcCv06H7Gc=zwiLf=6kBisB73yCT6VhRRRug@mail.gmail.com>
 <CALLqZ8Sk2OejX_aZRSiMqdDunY-5nG_Gr5Guf032HhS41ewD=Q@mail.gmail.com>
 <9a49e98f-2de6-168d-51b2-22c68c2d8084@siemens.com>
 <CALLqZ8TA_yUvrSMvqbrLOD1_+pqE+SVxZ5-=FwgrPX+k5KgOpQ@mail.gmail.com>
 <954672f9-5367-603c-1721-1047a4e18283@siemens.com>
 <88c4c9d231886bc3df0ede57a66353b19c4eabf2.camel@siemens.com>
 <327eb2af-b4b9-b78e-4456-32f61ce7b03d@siemens.com>
 <fb67c17c9b2c67b3a8b1b67dad9df4c77391ea14.camel@siemens.com>
 <8a97726e-46a4-422c-07b0-086dbf36c249@siemens.com>
 <48dcb04adfc2efc2936c554747660cb0c504fa7b.camel@siemens.com>
 <CALLqZ8Rq-TZZ3vHfU-JPgrGVrYZaC5Jgx5vBUWVeScpiMt2K7g@mail.gmail.com>
 <CALLqZ8SSVzhLH4augLVFR59is6atMhWHdbX9Fq+d82txN8u6NA@mail.gmail.com>
 <51a2aa74da3274aca7959b422349975fd75040b7.camel@siemens.com>
 <CALLqZ8SP2WFTneY-sjOewsDdcfKxcfpsNngBZfaSDCi0fEbf8g@mail.gmail.com>
Content-Language: en-US
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <CALLqZ8SP2WFTneY-sjOewsDdcfKxcfpsNngBZfaSDCi0fEbf8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::19) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|PR3PR10MB3833:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac28678-eadc-491a-a4f8-08db26782d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ck9oLzSwiA3sNlZdZHitPVfNFJWAyLoZ5EoHhOtn00tm81KP6J1NME1BpK25HW6nhucYz/3N8l8Y/r0TbsK8MEYhXEohAa3DNILM5BUVzoBt6KSwxFXuQ/0r+RXPznGdmgP/YrAJoCDhC0Uexp4Ors0Sx8IXMDWt5JAkrQejbyAEL4gG6zW5zCQkngMxOuz9a2I7S1ylP8oWMaOnT4h5Uq8kwowFrNDNbIkzIi3GpxlICp/asLGvPbbJRNTpU6Aj3P5t81+iWumOSAON5nGxJIW0LrcjHe1e6YO08x0smxSpkzSs4PdWh8d7g5STeUNhU0kNvIMhUbErYQzGXmHNpTySTJQU8W4jaYVtuJrzGfSHIgzbBMfKEpq1nzheoauFsY9+49Z8TZfB3n+OSbn7cNztvIqLC9FEbkkAdcuD6u0AVenS8PQwUTBc4dG6MJSPwpFbTJSqzhOxjkGW1kObENGDD6nPS/W1BEKp/Er3E7EgOzvPlcs9bHkVUE1cky5bnA4qRViAvlHVRbleBV4GOJ5ow5ThFnas/ovK1xWuzqkvbLwALAEBLme6/aFetZASnBI7wnwAo7W0L1MnS9gQr/6ZICqE5hRl2F/OATBLX3QRMeVZyB4vLnHWZF45QcY6JxkdauU23sgSTUWO1cfnAEDi5+zk1wvdVQ4jq6kfSjFKakW01WREiOeJ+K+H5RZJo+X3qt1eG6DhyxE3HHg7SOqDW4cfgNPLl7+w/9jndNWc/CbdQAekIE1i9oFdSJdH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199018)(44832011)(5660300002)(41300700001)(8936002)(31696002)(36756003)(86362001)(6916009)(4326008)(82960400001)(2906002)(8676002)(966005)(6486002)(38100700002)(83380400001)(478600001)(186003)(6506007)(2616005)(66476007)(66946007)(6512007)(53546011)(66556008)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE9YczY5SVBoVUQ1V2JoM09INWRGdG9KaUpRdHU2Ulo1NVY2N1Q5aW1PdHlG?=
 =?utf-8?B?a0x4RTducEZrTTNSd0hxQnlMbXNoencrcFRXYm1zOHBHUmt5UDh0TmFBTVQv?=
 =?utf-8?B?dlc5cldBUC83SlgxUFVublhpSU9lYUZiYXh3WlNmRm9kNmxEenJvWUpJb1Fj?=
 =?utf-8?B?WGtyVVoyM0o2Q3I1NnBPNmdJTnkxWU5lS0FiVG9Qd0hLMlRKMG1JbTRpTnBI?=
 =?utf-8?B?MkE0cWI5MUFnN1BQME0zU2xaTFBVVkZWQVFzdGhIRFFCU3VNWkdYaUpBN3k3?=
 =?utf-8?B?c2xtbEZJbTRiZy9LWHUvZVF6djV0TW92TFRoUGtLbXIxYzBJVjBBOWlmS3NF?=
 =?utf-8?B?MzdUNXBkdk5Obno2OVZxSTJXMUplaW50dVN0ZlVEek1nYXRBMUw4aGVROTZa?=
 =?utf-8?B?c0E1YWlmZUZmbEUrT1lUSEc1Smk5MU5NNm9jTmwrclY3dWJIcVFkWmdrdWZX?=
 =?utf-8?B?dk5JdkJ4T2dTeEZweFdUd05HYncrVytkWk9rQlVwbWpLUFYvOExxelRrWEtn?=
 =?utf-8?B?Ykc2VTVvb0FZZTNXTlpYaXN2RVNHd3JjOERIb2xpVmpQZU4ya00vWkdJdnFq?=
 =?utf-8?B?RWRQcktYTGxpSm9oUFFRMEh5S2dTbFRRYTNFR0VraUtlamZHYW16WnBvVjNY?=
 =?utf-8?B?bFdlSHVCWHljUTFXWG5TR3NoVGpxQmdwbnNlb1FLcVBJSVp0aSthbmZ1VHVR?=
 =?utf-8?B?NmsrTlU0dUdReEo4RkhYemJZbjJKbkNIQ0RLbDRIOEpSL3NUR2V0YmNMWi96?=
 =?utf-8?B?cmV3M3ZxakoxUVlyZHMwalg2ODhPUGw0MnJKeC9VZlREOTBMY0ptWHlEdVp4?=
 =?utf-8?B?WlBpU1hiaW1henU1bWdETE1Gclk5enAyMm9ranY0WFhySG5McTNBN0tnenAy?=
 =?utf-8?B?Qmh0YXYrY1dDQU1QL3VLb0oyNnUwTXZidHNqMVFnM3JheWkvN0R3MjBoNjA0?=
 =?utf-8?B?RTkwcHdpeVF3bjRhTW5kdHRNOXh0MGg5UTFoVHM2MW5ybnVEbzN3RjBIdTd0?=
 =?utf-8?B?TXVaV0lPbWEzNHp2ZHJtSTBJMmNuZitQaGx6bllpWTNpL05ROThsTnVSYnpZ?=
 =?utf-8?B?OEIvS0dER0tDNUpyY0JNQ2FVWjJ6RU9TMWdJWEhrZEQxenFCQ29JaENOZ1pI?=
 =?utf-8?B?Y1cvWGNLbjcycmtHVTIwckVja2lPQ29vV042dHBjZFBMMFZjZGY1REF2aTVQ?=
 =?utf-8?B?NllVMUlzYmJETi9LbTdwZHphazhHQW5OQjRkWFNxcXgxaVQybGI4aU41YXFR?=
 =?utf-8?B?dVpna1VXcFdXci9MU0s5ZWZ2Q05oajlFZ2NRWXJhK2dKanZJQ1VkbVcxbnBD?=
 =?utf-8?B?dlpOeWpJc1hqWXN2NjIrODM0eDMzSlJ3SFJTYUVtVCtCVUlkcW02RDF5aUR6?=
 =?utf-8?B?U1lab2E3V3JTdmsrK1RBYWxPaWFwdjRoVldnQldGT0l2WUxrdWVjLzVYSUdL?=
 =?utf-8?B?dlZSMDRLMjhwSlQvYkNYKzl3QzRWUUREcllDZWtWclpwUmlYSE5FWXVPYUJ0?=
 =?utf-8?B?em5DNUZYbEFGbEUzZFlwOU5lQXp1c0g5Wm5GYUlvRWdlTnFicFpwMmN2eWhj?=
 =?utf-8?B?dUQvUnJEMmFNYWYyaU9WTzdYK21INnMzVStiTDNiNGdJbkFac1EzcS9CcjM0?=
 =?utf-8?B?eVQybzVUZ0EvYjhNSGpwVGdZYW92U3ltL01VOVY1RWlXRWJrQStkczQyTTdJ?=
 =?utf-8?B?eG1YaXFLSDhpN3NiM3pmUmM1RVZmZHFDbEhRZFpwNk5jaDcvZUxzR1VFbVMx?=
 =?utf-8?B?WUs2YzFlL0prRWh5MjJZb3M3UWExK1RYekg1Qy82bE41SEZpRi93WHhDT2dW?=
 =?utf-8?B?cG9idGp3a01rYUU1cnJ5RFI5enBNYlJheFJSaHN0RkxaSWUyd2IwcklUUHZ6?=
 =?utf-8?B?SHNGcUNTWkl6WW1ENVVCaVBsaUNaYkZGQmpTYU1qczB6QmoxK1MvOFpSTVNF?=
 =?utf-8?B?TFhhTVFkTTFKck1vckZ5WmplaHVJWWNRUHpuZWxwTW9pemtXcXN1VDZoRnpW?=
 =?utf-8?B?aFlNRUtLSVljU3BTSjRmOUtUY0JNUzczL3c2UGlxdHVuRmwyQmxxK0l1VjFO?=
 =?utf-8?B?aFRGVXFDOXR5ZFZpdUlYcWQ4akpROVJPRlEwR0JHUjdDRkpkOVdROGJWY2xY?=
 =?utf-8?B?WmwvZnhiUjFnV1dUUUV5a0FMS2RiMmFma3JLNnNGYTFkN1RiSFduTkIzTTBo?=
 =?utf-8?B?MzBlOGxpcDNqb2ZXWXpOb3hROFpIR2pQQm9JZW1ZUGNwa2xMZTB1Q2gxcDkv?=
 =?utf-8?B?b0hkOFhHUEdyRlppWm1laE1YcnNnPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac28678-eadc-491a-a4f8-08db26782d78
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 23:43:00.5431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2huftckhCVO8DN7mumhyzRzJ+F0T0WhquIy6fHPLUMaPmp6/DW8p5ax1Q6p6dx7bx6JSQuVYCMBkfOPOYuZ7uDd8gpQhVK4LVlN+lV07Z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3833

On 16.03.23 21:56, Greg Gallagher wrote:
> On Thu, Mar 16, 2023 at 4:52 PM Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
>>
>> On Thu, 2023-03-16 at 16:11 -0400, Greg Gallagher wrote:
>>> On Mon, Mar 6, 2023 at 12:18 AM Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>
>>>> On Fri, Mar 3, 2023 at 12:50 PM Florian Bezdeka
>>>> <florian.bezdeka@siemens.com> wrote:
>>>>>
>>>>> On Wed, 2023-03-01 at 13:08 +0100, Jan Kiszka wrote:
>>>>>> On 01.03.23 12:19, Florian Bezdeka wrote:
>>>>>>> On Tue, 2023-02-28 at 09:12 +0100, Jan Kiszka wrote:
>>>>>>>> On 28.02.23 08:49, Florian Bezdeka wrote:
>>>>>>>>> On Tue, 2023-02-28 at 06:48 +0100, Jan Kiszka wrote:
>>>>>>>>>> On 28.02.23 06:18, Greg Gallagher wrote:
>>>>>>>>>>> On Mon, Feb 20, 2023 at 1:42 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On 20.02.23 06:27, Greg Gallagher wrote:
>>>>>>>>>>>>> On Sat, Feb 18, 2023 at 12:33 AM Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Tue, Feb 14, 2023 at 11:56 AM Florian Bezdeka
>>>>>>>>>>>>>> <florian.bezdeka@siemens.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Hi Greg!
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Mon, 2023-02-13 at 23:01 -0500, Greg Gallagher wrote:
>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>    I'm almost ready to release the next arm and arm64 ipipe patch. I'm
>>>>>>>>>>>>>>>> working on stable release 231 since it contains the patch that
>>>>>>>>>>>>>>>> hopefully fixes the UART irq issue seen in CI.  If there's a problem
>>>>>>>>>>>>>>>> with using 231 let me know.  Finishing my local test this week.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks for letting us know. If there is a chance that you publish a
>>>>>>>>>>>>>>> public available -rc somewhere, it would be possible to tweak our CI a
>>>>>>>>>>>>>>> bit and trigger a full test run in our lab.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> That should help us to identify any leftovers upfront.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Best regards,
>>>>>>>>>>>>>>> Florian
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Thanks
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Greg
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I'll get -rc releases out this weekend.  I'll post back once they are
>>>>>>>>>>>>>> done and the -rc tags are pushed up.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Greg
>>>>>>>>>>>>>
>>>>>>>>>>>>> Hi Florian,
>>>>>>>>>>>>>    I have the rc releases ready to go.  I'm going to push them up to
>>>>>>>>>>>>> the ipipe tree with the kernel update (5.4.231).  Does the CI system
>>>>>>>>>>>>> pull the current ipipe release based on the tag?  Would pushing up the
>>>>>>>>>>>>> new point release (5.4.231) break the current CI?
>>>>>>>>>>>>
>>>>>>>>>>>> We are pulling from the head of ipipe/4.19.y-cip and ipipe/5.4.y for
>>>>>>>>>>>> ipipe-arm[64], see [1]. It just takes manual triggers so far as there
>>>>>>>>>>>> are no ci files in our kernel trees (unlike the xenomai repo itself).
>>>>>>>>>>>>
>>>>>>>>>>>> Jan
>>>>>>>>>>>>
>>>>>>>>>>>> [1]
>>>>>>>>>>>> https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kernel/linux/linux-xenomai_latest.bb
>>>>>>>>>>>>
>>>>>>>>>>>> --
>>>>>>>>>>>> Siemens AG, Technology
>>>>>>>>>>>> Competence Center Embedded Linux
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I put the beta releases here:
>>>>>>>>>>>
>>>>>>>>>>> https://github.com/ggallagher31/ipipe-arm
>>>>>>>>>>> https://github.com/ggallagher31/ipipe-arm64
>>>>>>>>>>>
>>>>>>>>>>> Branch names are the same as gitlab, once CI tests out the branches
>>>>>>>>>>> where are the results located? I'll look to see what debugging is
>>>>>>>>>>> needed.
>>>>>>>>>>
>>>>>>>>>> Anything speaking against pushing to the regular branches directly? No
>>>>>>>>>> need to tag/bump revision yet, you can do that after CI passed. That's
>>>>>>>>>> how I maintain the other repos/branches.
>>>>>>>>>
>>>>>>>>> I can tweek the CI a bit and trigger an internal run. The test runs
>>>>>>>>> will be visible at [1] once build stage is complete and we enter the
>>>>>>>>> test stage.
>>>>>>>>>
>>>>>>>>> Pushing to the regular branches - and a failing CI afterwards - means
>>>>>>>>> that we already "released" or at least deployed something that is not
>>>>>>>>> working. No?
>>>>>>>>
>>>>>>>> Released is what was tagged. I do local build tests for my branches
>>>>>>>> before I push, but CI is doing the rest of the qualification. Then I
>>>>>>>> bump the revision, add a tag, and push all that as release.
>>>>>>>>
>>>>>>>> Jan
>>>>>>>
>>>>>>> Update:
>>>>>>>
>>>>>>> I triggered our CI infrastructure to perform two different builds. One
>>>>>>> with Debian 11 (gcc 10) and one with Debian 12 (gcc 12).
>>>>>>>
>>>>>>> The result of both runs is the same: We have one failing test job on
>>>>>>> the Hikey board. 5.4 [2] does not show any UART output, 4.19 [3] is
>>>>>>> fine.
>>>>>>
>>>>>> Do we have any early printk on? And does it only show that issue with
>>>>>> I-pipe enabled? QEMU arm64 is fine, right?
>>>>>
>>>>> Nope, no early printk enabled. The qemu job is OK, so it seems board/hw
>>>>> specific.
>>>>>
>>>>>>
>>>>>> Jan
>>>>>>
>>>>>
>>>> Let me see if I have a board here that has the same uart as the Hikey
>>>> board, I'll see if I can reproduce locally.
>>>>
>>>> -Greg
>>>
>>> Quick update, still debugging the ARM64 build, the arm side looks
>>> okay.  I'll release the ARM stuff by the weekend and continue to look
>>> into ARM64.
>>
>> Thanks for the update! Our CI confirmed the same thing, arm OK, arm64
>> boot failure.
>>
>> Still debugging means that you can reproduce? That would actually be
>> perfect because I don't have the board at hand and would need to
>> remote-debug it...
>>
>> Florian
>>>
>>> -Greg
>>
> 
> Hi Florian,
>    Can you confirm what hikey board it is.  I think the uart driver is
> the arm,pl011.  I do have a board here with it, I'm trying to
> reproduce tonight and over the weekend.

According to our machine config / used device tree[1] we have a 
Hikey 6220 in our lab.

[1] https://source.denx.de/Xenomai/xenomai-images/-/blob/master/conf/machine/hikey.conf#L20

> 
> -Greg

