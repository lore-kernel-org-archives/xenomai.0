Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2059.outbound.protection.outlook.com [40.107.6.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067623A1
	for <xenomai@lists.linux.dev>; Wed,  1 Mar 2023 12:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNnQ20GpPSIKgz+tDFOBNyIhjrvtUlxJnmmQ/t9U7qnDpdGRVhUq6ajCaWsceic4zwWDVt2ymQrKiGpf0A23hU27r1C13y/p7Eb1dBfnAUOwYYikC7h2ghtbaY/f/8/Z4FMNzemzf2nMcBanGuQxvy2ai9lcr8bc8OFiv+dwYgAcWZTkah6Vs0tOoxFmZ1GmSaiK2tn39PunSh9XyV+Ybo4sA7y/gWY0O0lAlSOJCwWx5jk4A3Vdoc6ub+SHH4JIEJdLV6RuO/iq/hHThE9nFB0s0ZWxXq2u0LTKAQiksH9HBFwnQ/kxvdLkm0QBtKsQa4Jmw4wHDqfVDg7/dq8zIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFzFMZibCk1UyUZefbEEvwa42Z7j2GJuycagyB2jzyQ=;
 b=XbHr4wfCp7+lfZw/81onmDXLcoVKKguH5HaJMdwnIxXOraJrz/GCBok0/NpJJJ+7iaRj/1VtV9CW+mRDKNd5PYhnKzrYy2wzvJdYmamLfKQhaBQs39ajDLBqnOLrlwnnhDsitn2S9agtFqo3T4jbiy0eeEmH6Dum4gPJbfb4ChHt5wM3/j7DPXzPFrtWEX3Ttx2cvaRIbLEM6q9GSVdMvOWKa0MPFajuSzFzL+B+k7EoSG3MeBNLidCNmaQiHolhfaqY42duaSBEfE/lX24Drt7cKnQEM5si8K8wAh0knTDaV7yYf7lAWMbMjEjQfLRQIFSfEUvTI5N6hrBqaIusmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFzFMZibCk1UyUZefbEEvwa42Z7j2GJuycagyB2jzyQ=;
 b=iMza32N5kvL6aJvCl1d70+mRfhNT8+BvkpjHfh+inMQyc6UXvmX0Hi+6n0gW5jwoZExZX08bL7xRWIamu55IdgzhYq8zTQvMW0kTDKmYNX6eBq9OBitzEiA8Rt02Qdyvbd5cFMjbV3ru1PGimYQHxBXYcM3F9UNDJ1GMCYgR3VuzZG12f5x7/2GBRsSCkR/H/D7fcHNeZ3lgYijI2QUPCvoOLxwPP2SppTNnEWIqP7yjswhuDZy1uu65t5ERzeBUiw2NEjkNuaUrvvpKzqD7lEX8LdV5evNXocCT4wRfWS07cF6MjzLzA3ZIWLvmDEvy2AtboN4/hbA3Hd/NkOhncg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7698.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Wed, 1 Mar
 2023 12:08:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 12:08:04 +0000
Message-ID: <8a97726e-46a4-422c-07b0-086dbf36c249@siemens.com>
Date: Wed, 1 Mar 2023 13:08:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: arm/arm-64 ipipe release
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai@lists.linux.dev
References: <CALLqZ8T=c_ngHcuU5vkpLVfzbN4Kpfh-Aqzq2vKErCYqbzyQWQ@mail.gmail.com>
 <252602b1508b13bc480f6c971e13b02ae7702071.camel@siemens.com>
 <CALLqZ8SiSB8e1VJcCv06H7Gc=zwiLf=6kBisB73yCT6VhRRRug@mail.gmail.com>
 <CALLqZ8Sk2OejX_aZRSiMqdDunY-5nG_Gr5Guf032HhS41ewD=Q@mail.gmail.com>
 <9a49e98f-2de6-168d-51b2-22c68c2d8084@siemens.com>
 <CALLqZ8TA_yUvrSMvqbrLOD1_+pqE+SVxZ5-=FwgrPX+k5KgOpQ@mail.gmail.com>
 <954672f9-5367-603c-1721-1047a4e18283@siemens.com>
 <88c4c9d231886bc3df0ede57a66353b19c4eabf2.camel@siemens.com>
 <327eb2af-b4b9-b78e-4456-32f61ce7b03d@siemens.com>
 <fb67c17c9b2c67b3a8b1b67dad9df4c77391ea14.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <fb67c17c9b2c67b3a8b1b67dad9df4c77391ea14.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 209b59ea-6e36-4831-b605-08db1a4d9c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/oYJ2MluA3wrKlTvlXLM6kznW3IqQKz/0N9d2vmG0GqCmemoZ1P7hLA+5njzzQMcvvBRVolERZY+u/nGwqjI9HR61hlJLn/pv87cv4sYeWvPIw3llB18Q7R8J33+v1OxxwWNsk85HHQcybeftkOEIeND7Z9sxw1XuBPLCmZo9Jj1oeYso1fDFMjceGcNXejrMdoACbpI8iP8p2NH7+UNFkCeyfS9xhcccq2mYnrISxRjYf5jwbO5mz6ScUzyYpG1tBCAxbUqV1CZG+ZhlKgtczfLU8wBYjGMfLd64CIcDuhHhv3ZWpvUvjQUJ31PVJ0T0yNCT1w9CSAwICp9PNByGv1lDajKxTGiqAYeL1or3GGzttawMjAvJS1O0KzaxXnMqQNgfBzXFhoRUjfQOL4d0zBb0SywITIBiIq3INaFHtlhZJoOvcTLuU8nf+T1VKTmrRDnhgb5FsD8qQvbGkVtSQ4T4936pcsrQ4YEWXteVRcI6fu38/AcNObuejUHDL4d9QgAa+J0FaWPjjJHVVD/JvO9B8PzXRRpcdit9XHRs9Y/z1/SwqwFXGoON6unmjj1Rij15iklVHPyOSrrlI5oibG07JhzfVy5fs8eVPbBLmbpCuKHyISNRxAqkwiGzrUfGhI4ATDoqiWICPNTGFYeVqXcb8oFw1S1SyUZ0QLIw3a8zSxqE46ImISnlqd9U7avVcKTuFCrxGcX/KWAaDiKXLfe9e7/oh3JSalSBOlMswbbCIdEe0amo14GuaVbRTjIXPVIysiDk/PmVOcDBzo11w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199018)(31686004)(86362001)(966005)(31696002)(316002)(110136005)(36756003)(83380400001)(6486002)(478600001)(4326008)(66946007)(8936002)(8676002)(66556008)(6506007)(66476007)(41300700001)(2616005)(186003)(6666004)(53546011)(6512007)(26005)(44832011)(5660300002)(82960400001)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YS9GcHBGYmNYQTdYYSthVWZrSU1KQVJyOHpCWExVVjVOVEVaanNqa2Q1THVE?=
 =?utf-8?B?eCt5WVZFU2xpc2N5K1ZvME5GeUladndzY1lsTk53VTA0Ui9PbUJTeDN6elg0?=
 =?utf-8?B?eE9ESHNLME1jNGllLzYwWFdMN0ZpanNhZ1BmN3BIRDYvbThMUit0endNZjVM?=
 =?utf-8?B?RExucStUenZSK1J1STRNUTIyN014ald5WVRKT2I1cUxqMjk5YUtGWGdZU2xI?=
 =?utf-8?B?RjRaYThJT0FLbUxjUXFQRFdPZjJRS0U2SzdQeGJGM0FBeTlvOFFEd1IvcWxX?=
 =?utf-8?B?c2VHaytndFI0N0JsaFpXbmo0YVhFSno4blpsM3BTZHlYRmFPYjU1L0ovSjZ2?=
 =?utf-8?B?N3hIUDBVL0hEKzNpdEJUQnpXYVNOS2RJZ3UrUnVQSXVTY2pTT09FRHhZaGxK?=
 =?utf-8?B?aldkaU1xTHlrMzVKVWN6dFd5ellid0NsUTNtd3lpMStCaXR2Z0ZmV2lVMTRh?=
 =?utf-8?B?N0lVRTQza1B4YzJUbmlkWUN6MGVBSEdFME5RVS9RNEw1YmV6RXVrSEoxK3Ni?=
 =?utf-8?B?cDJKc21tMnVGaHREcWY2YURrTzFZcm92dWxNVXc2QUduam9hcU5sMWRhZ3VT?=
 =?utf-8?B?QTl1TDN6S0NDSEFPY05pMXRrTzdBbCtSWTd3YnQzTld4TWNydmt0SW8wNVVh?=
 =?utf-8?B?WGFrS25PcW9iWFQ3OFVXN21PU1pOU2VsVjVmZ3dBSS9VZ1pDUFI3UE1obWp6?=
 =?utf-8?B?eDdXNnkyOHBaZlV0bDNPNXNpYzU5T1ZmVGR2Ny9xait3ODFOaDhqTEZRMC9m?=
 =?utf-8?B?WXZWa3pxU21XVEprM0pZME8vcUxTY2c3Z3ZqejNmaEl2YXpnNGdQOC9samhY?=
 =?utf-8?B?TzJGdWVRbXFFQjE4cTh0WXEzNmU5SkM5MnlOUUZURzdzUVljNGJWR0dUM0tu?=
 =?utf-8?B?UFBSZ3BVeGpmUW54RDVxMDltRGZ0K2hScVQyajNleW96eSsxb3BLSmZodHRM?=
 =?utf-8?B?ZHhEdjRzdzVKcGFWSHhKR2pmQnljZzZBMmZPRmtIbEEzVmFhNXVmUXhJRno4?=
 =?utf-8?B?K0Voa0xRMU00UnlLVVhxWkZRL2lraHVpdnFjMGpaMEtHUjkvMHM4UW9vaUlr?=
 =?utf-8?B?bUVqQWFSNFJvOHZHV1d6RlFxdVVRdEFWSFdWMzdncUpFWlhtRHlWanFIY2t1?=
 =?utf-8?B?azFDN0VCWWRIanlkUTMxeUo3T05Nd3lIZ3ZXdlBhYXZZYTByNkttTlh2a0Fa?=
 =?utf-8?B?S2NVaUhhRCs2VGxYUmxNdjAvZHNzWWtyREF2MDIvUHVLVjMzclIzVEV3ckkr?=
 =?utf-8?B?VWJvNnlnY1hWVFFIWk5hcTlMMHg4d1Jrd0ZPR3VHeGNOb283YzNJVUNHYXpI?=
 =?utf-8?B?WXRZdk11UVByMldrL0VXWndTTE5RZGxvcWxsemNBMkp6aWJ0Znh0alF3dWMr?=
 =?utf-8?B?UnJoU1dLVEJvSUd6NFprRGpUTGtsbUJ3V2lkL1FkMDVRMm9IalhaSmJBYkJX?=
 =?utf-8?B?WEFvckQ3TlZ1Nmc4a3pVeE4vWVdKYk92WG5pVWtzcW92M0VONm5kdU40Z0ZJ?=
 =?utf-8?B?UStrblRkUncxZ3ZlRXhTeFkzSFEvNFZuSWYzS2p0YWQrRmlEbXpVRzhYM3U2?=
 =?utf-8?B?aDcrRmZiSU9ISXlhYmxkbFZMZjRBeGd1NjNnR1FDSGZyQUtPSHZHSi9hQnp6?=
 =?utf-8?B?bDFtZ3ViV25zYk9hWG5RYXVMRzRlZWZrQ0V5T3lxMnM0RFFEQW9JSGxyWC9I?=
 =?utf-8?B?bEdVL1hxN3hqM1pnZy9yYWhBWStNWkFTNklLNExFQnY1THpqbHozdS96c0d1?=
 =?utf-8?B?M3pjUFJHdDlXUjBQRDBPL1d2cHVlSmFHVzI2N0ticzNLVFZaQXJ5YjJQd3Jz?=
 =?utf-8?B?R2hVbXc2eDhZeWtKdmlLYURVUkJ5K0hCc21kdUNVYjAvc09yM2t2S3hMWmlh?=
 =?utf-8?B?MHd1emFuMWdPeEM0N21WdHZsSnFQQ2FnWWFRLzRNd2NBYWtHK24yc2s3UDZv?=
 =?utf-8?B?K3ZWemEvT3k5Nm16MFFWaS9hM2VaeENYWDJmcC9BeW1WV1VOTXVwcVROOTJm?=
 =?utf-8?B?bStMR3lvSUl3SDM0TnFVZzQrcUQybWNGTHFrMkhtL1RoQms0Z2hVNmJFa1h4?=
 =?utf-8?B?bytxWllPVHFodHl0cTJjTXVkRWFCM1k5cmRTVFlONW1FZHUzWk1Jb1hwL3N2?=
 =?utf-8?B?cUU4N0pDcFhwaEk4aFpseXJscXhOdnRCVjRTUS9RUnRUOTFZTFM3d2txVmRZ?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209b59ea-6e36-4831-b605-08db1a4d9c2e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:08:03.9417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwasbGYSsMzOoH5ovgg8MG0ABN2uMdXrzp5xtwO/k1sXkxz8+V1W6vOQUzlEHSn/o/y4Oct/gBZ4RHwRUnTDXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7698

On 01.03.23 12:19, Florian Bezdeka wrote:
> On Tue, 2023-02-28 at 09:12 +0100, Jan Kiszka wrote:
>> On 28.02.23 08:49, Florian Bezdeka wrote:
>>> On Tue, 2023-02-28 at 06:48 +0100, Jan Kiszka wrote:
>>>> On 28.02.23 06:18, Greg Gallagher wrote:
>>>>> On Mon, Feb 20, 2023 at 1:42 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>
>>>>>> On 20.02.23 06:27, Greg Gallagher wrote:
>>>>>>> On Sat, Feb 18, 2023 at 12:33 AM Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>>>>>>
>>>>>>>> On Tue, Feb 14, 2023 at 11:56 AM Florian Bezdeka
>>>>>>>> <florian.bezdeka@siemens.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi Greg!
>>>>>>>>>
>>>>>>>>> On Mon, 2023-02-13 at 23:01 -0500, Greg Gallagher wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>    I'm almost ready to release the next arm and arm64 ipipe patch. I'm
>>>>>>>>>> working on stable release 231 since it contains the patch that
>>>>>>>>>> hopefully fixes the UART irq issue seen in CI.  If there's a problem
>>>>>>>>>> with using 231 let me know.  Finishing my local test this week.
>>>>>>>>>
>>>>>>>>> Thanks for letting us know. If there is a chance that you publish a
>>>>>>>>> public available -rc somewhere, it would be possible to tweak our CI a
>>>>>>>>> bit and trigger a full test run in our lab.
>>>>>>>>>
>>>>>>>>> That should help us to identify any leftovers upfront.
>>>>>>>>>
>>>>>>>>> Best regards,
>>>>>>>>> Florian
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thanks
>>>>>>>>>>
>>>>>>>>>> Greg
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> I'll get -rc releases out this weekend.  I'll post back once they are
>>>>>>>> done and the -rc tags are pushed up.
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>>
>>>>>>>> Greg
>>>>>>>
>>>>>>> Hi Florian,
>>>>>>>    I have the rc releases ready to go.  I'm going to push them up to
>>>>>>> the ipipe tree with the kernel update (5.4.231).  Does the CI system
>>>>>>> pull the current ipipe release based on the tag?  Would pushing up the
>>>>>>> new point release (5.4.231) break the current CI?
>>>>>>
>>>>>> We are pulling from the head of ipipe/4.19.y-cip and ipipe/5.4.y for
>>>>>> ipipe-arm[64], see [1]. It just takes manual triggers so far as there
>>>>>> are no ci files in our kernel trees (unlike the xenomai repo itself).
>>>>>>
>>>>>> Jan
>>>>>>
>>>>>> [1]
>>>>>> https://source.denx.de/Xenomai/xenomai-images/-/blob/master/recipes-kernel/linux/linux-xenomai_latest.bb
>>>>>>
>>>>>> --
>>>>>> Siemens AG, Technology
>>>>>> Competence Center Embedded Linux
>>>>>>
>>>>>
>>>>> I put the beta releases here:
>>>>>
>>>>> https://github.com/ggallagher31/ipipe-arm
>>>>> https://github.com/ggallagher31/ipipe-arm64
>>>>>
>>>>> Branch names are the same as gitlab, once CI tests out the branches
>>>>> where are the results located? I'll look to see what debugging is
>>>>> needed.
>>>>
>>>> Anything speaking against pushing to the regular branches directly? No
>>>> need to tag/bump revision yet, you can do that after CI passed. That's
>>>> how I maintain the other repos/branches.
>>>
>>> I can tweek the CI a bit and trigger an internal run. The test runs
>>> will be visible at [1] once build stage is complete and we enter the
>>> test stage.
>>>
>>> Pushing to the regular branches - and a failing CI afterwards - means
>>> that we already "released" or at least deployed something that is not
>>> working. No?
>>
>> Released is what was tagged. I do local build tests for my branches
>> before I push, but CI is doing the rest of the qualification. Then I
>> bump the revision, add a tag, and push all that as release.
>>
>> Jan
> 
> Update:
> 
> I triggered our CI infrastructure to perform two different builds. One
> with Debian 11 (gcc 10) and one with Debian 12 (gcc 12).
> 
> The result of both runs is the same: We have one failing test job on
> the Hikey board. 5.4 [2] does not show any UART output, 4.19 [3] is
> fine. 

Do we have any early printk on? And does it only show that issue with
I-pipe enabled? QEMU arm64 is fine, right?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

