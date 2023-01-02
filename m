Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE717D7
	for <xenomai@lists.linux.dev>; Mon,  2 Jan 2023 12:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmgTCcqzLr1hXUQVsfKayAA4mAb3dWuyZyuCJhCjADg+prSIi4t1bJ99GuTk23TmKOFNzAg6aeVSKbZQRRWBNifBpvrfxUcWT0g+nMBQVfOkIL/S5rd8FK09+lJ5GgtaLi9j75bS6qWKNvlYhOZ5XD+Gv8I0xqIMXYXx1+mXj8NzQoRHDVDlWwgdUJQDM7+PBkk3hDIdHqUQGaUHeL6YiTh0uF6QSo7AvfHUOStevapCCg0dGlrGnDN70/70g7E7UqiB1/PzxCJWIBF2kI7wZnuu8RV/D44UlDRIAGp8gWQKvPMFZJZP2ll8ku/gu0x77D9oRAPPCRXGjU3bs/6v1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1uF6sxyTstR2TSVm4fQI+Km92b4r1vURo6SjYz/gpk=;
 b=M4k0OseE3sBlSL8EeO6smArMUFtmsBASZBBCD3JoQ+oFAI3rrYNsnUR3831DOOgyiY4IonyqFThtND8YJPhY0SwfpA4OIRGxth0NTzuLMqYCz4hBIuoXYVOSV3fd28GzjFgedbWYiqLODMmesXSWbDGDR+MaQz8M1PJVoWG7ZnbwRPlGguMROMnUltIQbEk5CBM8v4G5snv4601LzEDAw+7j2P9+jfoK/7I1bVoFM0+yR9byiE0YPnM44exGTGlf5lUt/1nqQjcmAfNzGzzIgUUW+uxFCNMlpy9IJM7AG65oIRQbNNapAYTZajaRD9r2ehxDaevetJaxAeGB7G4FTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1uF6sxyTstR2TSVm4fQI+Km92b4r1vURo6SjYz/gpk=;
 b=lmJKAGwPiSD9ZcE1MLHbYhskIcjQPFT1Sms6vubsbxRWj0OB7XG4cIvs/ZpbyEAk+7TZMF44KVNqWumYa+a500GzQeXtaqcS8OhSejYPvfpL1huS7UeYjdeDGGr+W7569q5+N00zqlyg8vYPUsB72OuMc1clEXVRdIZLZirjab5rcwuAqGMOa5lvRSm17ev2Wk7UYzG/N0LV1nFPs3Xh2GK0Gvs+Wrz1LqyviL7rCtWd7CJRHxPjd/5wlsrX1WvHvLgJ5Id96i/k4AF/cfD6MLGTLLhp53/sRJA0ZI326RNVbnjkRn3YIDGGcKTpnagBP+PckT6U7h2Qjq/7Pv5DNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB7170.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:452::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 12:38:51 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13db:8a1:709a:4671]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13db:8a1:709a:4671%5]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 12:38:51 +0000
Message-ID: <945e3654-e6bb-18ab-9af6-0105cfd15964@siemens.com>
Date: Mon, 2 Jan 2023 13:38:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Synchronization request of supported ipipe kernel versions
Content-Language: en-US
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
References: <c7b9c30c4f0685adbd3f3829b9bba4b42835177a.camel@siemens.com>
 <CALLqZ8RgN_WNdf_k=My5m7kyOKFw=gmVB36e3ztQVUjsN9V_7g@mail.gmail.com>
 <CALLqZ8T8ZxV2bJD7h47t_cQDkAyb9dMUpA2HOUO0x=0_0Pht2A@mail.gmail.com>
 <15331e9004e2a34e03bada655de9895531befaa8.camel@siemens.com>
 <dda4a74d-84d2-7282-7517-74ec4cd58436@siemens.com>
 <d00c3c982f41ead3147dcfb2900f2a55606eb9aa.camel@siemens.com>
In-Reply-To: <d00c3c982f41ead3147dcfb2900f2a55606eb9aa.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::7) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|DB9PR10MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d19644-d9d1-4d00-166a-08daecbe4d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6ngOU02JRteEwLSNCUwkR4ZCBM0/GHO7v5x5qxMR5pHKfFPebJyuTdQKkQ/hqTHE91hA1XMahavvNbw7JMTE2EnaBeq1BbVPGON/6klAp2oFNN8WDjk61PJl14plZ2F1UnALn0YRBejqzExtN01/UIFmi/zS7MFmt+q7EHGpV5q/vJrVw+Bfgh5EeScawG1/hEZgJ3I3kUusti23uWT6LliD+ul/+vF7bFHy2tkAIONeb3lAZ5G8O4MJHbW4eGJQseaOodg9MSgx0rugw2glrGN+QN1FwJegddxTboUcj/ueSdUmIfYaS75SEGu1Nkedm7XvXBy/2hofrJFEZeZHVzBhfdQphWdw1DUQqvTjKaTQM2YiJLaa+Dk6xBtSVB63/dbVqRl6EDk195QHIbNvZZ0TEiimxF+erngBfQrjzxJ59I7UqVycyi+uycSl8V/h/OxaUxGSxUhqXPrTSF3nlEeUDgdRrBjKPgjKMuht6I11Pb0jlV/EFzRPX0EkGeOZwTdnFC88NmvbO7G3oG6xS1u+NvxYWRJ7llqhieNWmNtk+EzQiJ3ooJrBAM++iVRgyAd3AZJgLa0idS/jq6hnVjP9pdZLlXgiwGwHZvcna6qf2viOnc08BUhag/l+Xy1T7CMHrC6hLNBm/Yois39XMJundqs6o1Xi3rMZR1EkiAqAtN/EWDLviRcAuGlE66pym8kkrxepavg6Q7aWYqGnpZ/NknagUcXMUoKwvpt+MGdJVx2+v+bYxjQLSl8q68qt4qgXk/Ht0RZKU1k66bJTgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(5660300002)(4001150100001)(2906002)(8936002)(44832011)(31686004)(8676002)(4326008)(41300700001)(66899015)(66476007)(66556008)(966005)(316002)(66946007)(6916009)(6486002)(478600001)(6666004)(53546011)(2616005)(26005)(186003)(6512007)(107886003)(6506007)(83380400001)(38100700002)(82960400001)(31696002)(86362001)(36756003)(22166006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L09oZmJpSGE5eXN0eWI0YThKNnVpak5sQXdOaUthdEpzL3IxRTVTL2ZuV1lk?=
 =?utf-8?B?MnZKeS8rVnp1dWpPc2g1ZkNSQUo2aGVxMHlBOUlabGNjdTdFZ0tTSldGcit1?=
 =?utf-8?B?QlppWmVsN0JhTi9McTVpTU5pRDRVcCs2alRCak5DUGlOUTlQc1pmR2g4aGU1?=
 =?utf-8?B?MFVTb2RqZUFhdGw0WG1OSnVtYUNEMktDUWlPM0g0SzlBSmRFMVNEcW14MGZr?=
 =?utf-8?B?TzErRkJZVXZFTG1kcExGNDA1a1Y5ZlpYbFY5SVJyQ2hWUzV1MitmdTZiNXpW?=
 =?utf-8?B?SHA2SCtPQjU5bGEwZ2tuWld1QW9GVVFualo4MlZNOWRWK3J6a0dIYTRUVVlE?=
 =?utf-8?B?UkMyamRyWkg0Q2FkWVZ4em9aaGdpbXdxYUdudXVCNjFqcEs3WHVNdmprTGF3?=
 =?utf-8?B?b1BhdHFURlBnM0dVcGJ1ZnhVM0kzSm5sTTMvMk4zc3d4RHBYbjlTOHhrN0hO?=
 =?utf-8?B?dmdXa28zcW1GRkZaYlhXZW0vdVVQeDBEYU9BNlhBcVpxVExmU2FEampnMHFB?=
 =?utf-8?B?aGh5TUt2Y0FoNjdvamdzNWdPSS91TEhRSnJIVlJtYlhydXhmMkZSaFJwTlR2?=
 =?utf-8?B?REhXL0l2aTdRTjlwRHpFZ1ZINFNCOWlCbGdFcWpoUlYxbVBIc2xVT0RKQ3RM?=
 =?utf-8?B?dmtZdi9TZ3BBa1Mxa1lGa0Evc1pyUFlkc2NZZXJITENZeTZjcFVKMjVuaURt?=
 =?utf-8?B?bzB0cDRnQWhUbG5Wa2tGM3ZydzBqd0Z3ekFPeTN1YzVsVTFDdDA0VW9PWmVI?=
 =?utf-8?B?SWs5S1ZLcEZiUDF1R3NCbGpsOWNmc2M2SlFpbVNiektiazlhTTRHbzJsMlBU?=
 =?utf-8?B?VDlQTUN6T2VUVEwwRmR1S0hiRTgrMk5aekZQbmJRbjJsTTB0OStGWGQyQW1E?=
 =?utf-8?B?N0VRUUo4UHZwMnIrR2d4ejZraGdYUWMyZ2NjZEx2VnlRVHREVFdXR21pZ1Bx?=
 =?utf-8?B?WFVRekJHWkJCYmlPYUJXSDBHaGRBalFtd2NsOFM2RWhobFMwbkRhTHA2VFNq?=
 =?utf-8?B?cmord3lUM2lHS3BxaTRwc1gxRW0rVk8xZG5IUkVpVVpGbHg2QWVZMEhnUkFo?=
 =?utf-8?B?TGFhbFB2V0YvdUkvL0s4b2FjdmxHOW8xWXQwNWc5dWtuMDZCWmlVR0ROZlhK?=
 =?utf-8?B?dWxmVEFTZTVTMUEyTnVrejVsWTd1bmpYc0hHSjhUaE4vM0NtMHA0LzFUSFZV?=
 =?utf-8?B?SXdwSlBvbzNqQk9rS2hxbEVpTFJPOTY5MitDcHJlb3FOOVdpK3NlSVFDVkx1?=
 =?utf-8?B?UElFcndXU0pzR0h5bVNDc0pxMXRKUlRndHZoTGlXbGpLWVJReEF0M2tFUlY3?=
 =?utf-8?B?VSt5OEtqTGFBSVk0Ym9KRWhWVE9OMUFlVCsyYmJaS1ZXNGdlWVltVGdpNURH?=
 =?utf-8?B?ZHVyQ0JFY2d1Ui83cXk0N3VuOG9CZy9OQXk4TllDSWYvemRqcTh4VmozenBD?=
 =?utf-8?B?a0xxbmc0Z1pHTWp1N0xRTDZERTVrZWZYZ0dJMDNWWVNQWTNXOVVHWGlzM3lF?=
 =?utf-8?B?bHhJSFh6UWs3SnptS2QxcVU1anZlT2pPWGYyTWRBS1hUU05mTHlTL1VDMEVj?=
 =?utf-8?B?d0VseitaSC9QbmVFczBaei9HOW9YN3JHMkZ2L3VlMkZ2R0Y4cTJYRG00TFpp?=
 =?utf-8?B?OVNRT3FRTFdnRjd0NHJIRXVnS2U1emZGNGxwQkpSZzFVVzlBR1JzeFRpL2Fp?=
 =?utf-8?B?cGpGNnNPd3MyMFlFa1l4L1VaWFY1d2Y4U1NxckE1Mng4K00zRVd2SjZMYWpJ?=
 =?utf-8?B?a0VscWhRRHlHZXF6ZHJXWkdxVUE2YlV3M3c2SWgwR2RGNUV6MEttbm5TUmFQ?=
 =?utf-8?B?L0NBR1NJTlJBOTNNa3hzZWpnUkN1QzNNc21tN1Q0WTNvNDJWazN6TmltL1lR?=
 =?utf-8?B?VVBOR3RtT3NWTTRVSG9pQllPeC83L3FGTTlRbDNiL0x2UW9GeXlVd1lJZW9Z?=
 =?utf-8?B?dDFWYVl3T3g3TGtCU2FPeVlDUEdsQjNRWXAzRFZObVl5clpKblhNeHUySGtI?=
 =?utf-8?B?Z0NUSzBEc2JpbU1rSC9NQkszMEdpdS9WUG92RHdCaGlhbHhGT2dwY2lCLy9p?=
 =?utf-8?B?dG1QSnJMbmpXT0dsRWh4aTJrWHhtTDlmd2svb214ZzcrTlFLeXZoOVF5eTZi?=
 =?utf-8?B?bWRlRzdXemtmZVZKMmY5ODVFWXZ6L0F6UXhlWlNjZ2MzSzZ3S1hmc0l6NDR2?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d19644-d9d1-4d00-166a-08daecbe4d77
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 12:38:51.5824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wdt8+M3F2hNmZ8aJHANHUtE6w3Y4F71/n3JJOuybvfh1zaRY+LP7DpFzGcmTLTVDSl9nQpKQixKMYOTRGkzNlfxAaZI4Ez15qI1GZ81B2GQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7170

On 15.12.22 16:25, Florian Bezdeka wrote:
> On Tue, 2022-11-29 at 08:01 +0100, Jan Kiszka wrote:
>> On 28.11.22 17:36, Florian Bezdeka wrote:
>>> On Sun, 2022-11-27 at 22:09 -0500, Greg Gallagher wrote:
>>>> On Fri, Nov 25, 2022 at 4:13 PM Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>>
>>>>> On Fri, Nov 25, 2022 at 9:11 AM Florian Bezdeka
>>>>> <florian.bezdeka@siemens.com> wrote:
>>>>>>
>>>>>> Hi Jan, Hi Greg,
>>>>>>
>>>>>> while tracking down some ipipe issues that appeared while trying to
>>>>>> modernize the CI toolchain (Debian 11 => 12 update) I had massive
>>>>>> problems with all the different kernel versions that we have for
>>>>>> different architectures.
>>>>>>
>>>>>> Currently we have:
>>>>>>
>>>>>>             4.19             5.4
>>>>>> armhf   4.19.229-cip67+    5.4.180+
>>>>>> arm64   4.19.144+          5.4.180+
>>>>>> amd64   4.19.264-cip84+    5.4.223+
>>>>>>
>>>>>>
>>>>>> Might I request to synchronize them?
>>>>>>
>>>>>> It would simplify things a lot if
>>>>>>   - all 4.19 versions would be based on the same patch level
>>>>>>   - all 5.4  versions would be based on the same patch level
>>>>>>   - The 4.19 and 5.4 versions would be based on the same stable
>>>>>>     patch set. Currently 4.19.266 and 5.4.224 are recent versions
>>>>>>     with the "same" set of patches applied.
>>>>>>
>>>>>> Concrete example:
>>>>>>
>>>>>> I had to update my 4.19 baseline to recent 4.19.264 to make sure that
>>>>>> I'm not hunting for something that is already fixed. With that I pulled
>>>>>> in the following upstream commit:
>>>>>>
>>>>>> 211565b10099 ("serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle")
>>>>>>
>>>>>> This commit breaks (or will break) the pl011 driver in case ipipe is
>>>>>> enabled. It is part of 4.19.253 and 5.4.207. The only tree that already
>>>>>> has this commit is for amd64, but it's not a real problem as x86
>>>>>> normally doesn't require this driver.
>>>>>>
>>>>>> a) I'm currently not able to fix that for arm/arm64
>>>>>>    (too old but not yet affected)
>>>>>> b) If 4.19 and 5.4 for arm/arm64 are not based on the same stable
>>>>>>    patch level I have to backport for each arch/ipipe.
>>>>>>
>>>>>> Let me know what you think!
>>>>>>
>>>>>> Regards,
>>>>>> Florian
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>> Sorry if this is a double reply I think my original didn't go through.
>>>>> I’m good with this, I can update the arm/arm64 branches this weekend.
>>>>>
>>>>> -Greg
>>>>
>>>> I've got my local branches based on 4.19.266 and 5.4.224, running
>>>> smoke tests.  I haven't looked into the pl011 driver breaking yet, do
>>>> we need that fixed before I update 4.19 and 5.4 ipipe? Once I run my
>>>> local smoke tests I should be ready to update the branches tomorrow or
>>>> Tuesday.
> 
> Hi Greg,
> 
> I revisited the pl011 driver problem today and was unable to reproduce
> so far. I will continue for some time but it might be that the real
> issue (system hang) is triggered by the wlan driver.

There has been some upstream activity recently. Upstream commit
032d5a71ed378ffc6a2d41a187d8488a4f9fe415 [1] touches pl011_unthrottle_rx
again, which according to the changelog should fix some data loss.

The mentioned commit has been backported to 6.1, 6.0 and 5.15. I guess
older stable branches will follow soon.

I'm quite optimistic that this fixes my problem.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/tty/serial/amba-pl011.c?id=032d5a71ed378ffc6a2d41a187d8488a4f9fe415

> 
> Any findings from your tests? Can you update the trees?

Greg, could you update the ARM trees after next stable release?

Florian

> 
> Best regards,
> Florian
> 
>>>
>>> If we do not fix that upfront I would expect Xenomai CI to report
>>> "hangs" on next pipline run. 
>>>
>>> Jan, can you also offer 4.19.226 and 5.4.224 for x86?
>>>
>>
>> ipipe-noarch ipipe/master and the heads of ipipe-x86-4.19.y-cip as well
>> as ipipe-x86-5.4.y have been updates, CI is running.
>>
>> Jan
>>
> 
> 

