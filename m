Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E86D18
	for <xenomai@lists.linux.dev>; Wed,  2 Nov 2022 15:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq7ybpAu9MonWHqC8y9u77qC8XYBxD1oUxzdjCXUbocMpXCcZT55tmkcPhuBq241uFgtuVsblsr+9bPSL+7kgNZ60lT8Ht9cu6iSbr5qZaG214uDick8egu4zoe2UeRZd6vINv27RJmaYES21wp382pAXMSdr61tzieCkeyMXqkf/tILFNtdsh+LvqCtb3J4x7JWXV7d+qEN2hD10NzOjbizwr8ig3IdPgy5yEfBgbyE6f4h5CZiQMgs+7yFuW2znITQYo1KFR+GxTQMAAmDQCDLG/VT6EmhRl9lTpcxrqNqQLZtLYLaFZSMsphtYMMk0UrPdAKVzatxx63lzikGmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLi7F7LeI+3s3Nz7r9ouBCCiuOz8QWkxn5pVGJ7TnkY=;
 b=iE1t/kSyzhJr345kqlMJRGIv15dAJTFSsuLdu4EJUU2CFMor9gTVeKlc8QEacRnw6oStFaKFY4WWHBpdcB6/HDOm1/4c7Hnlu3wMDGoqWYEMb+eTz8guyeCcubYRkkadZX5RNT4e3ccLWHowc3tX0FYsCb1x3aWzqFk4KhkKzqxhk2h968wj7N3mCj+wVjmMnOQgRWF/P+DJI/nW5Hxd5YKVxmWbuDP4v5wGRsbjJc5D4CwFwiKhEp0Ra4NpMk4EVRbMkEjmroFZgRgAJVpfVU7ICWBVGcvqGevBDoswNug7QQJ7OfdaKq4/cmKxlw97lfFcsRpDWiEnj33jWDt12A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLi7F7LeI+3s3Nz7r9ouBCCiuOz8QWkxn5pVGJ7TnkY=;
 b=iE9owUiCDZ0JMiSNrFSE/ZtZy6FdMTBt4+bDNHoxG15tz/H8WbOorgQK7aRSyY7z70J7hSg9IMS7xe121FczFrp+54wA90FT+l6DqEWLfVUPB6HsTYYsAVFw7ym/e2A9vxXt+lnwnDS0YDLdfsvz+jWySsScfHfJei3rVIvhI7mYqwEUefoJfAmuEjmx+pFral6CskkxtE+JNhTKR8jObcJQZ6QuwoWCIa8IqUDYTRBIRLivsOISGiS7tOg+YHyjs3OUo/A3Tq5ygmOD93IoPvJTieVCxrUVFkLSrY1Sv1FjlZsQA0+yfMUa8UTCd4xOLy7lFrwfmaWZ0EYf6MsJqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Wed, 2 Nov
 2022 15:48:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4f98:4e25:cba5:cf58]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4f98:4e25:cba5:cf58%9]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 15:48:56 +0000
Message-ID: <b49df726-0eb8-1f65-f584-37eba99aae77@siemens.com>
Date: Wed, 2 Nov 2022 16:48:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Content-Language: en-US
To: "Heber, Stefan" <Stefan.Heber@zwickroell.com>,
 "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "Wang, Rick Y" <rick.y.wang@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <FR2P281MB265487EA098F01EFC0F77CB8FC569@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <ca3f971c-87e1-b7b4-262c-bf80483ef9fd@siemens.com>
 <PH0PR11MB5880908DA18819B93D4DAEB9DA319@PH0PR11MB5880.namprd11.prod.outlook.com>
 <4a08b7af-039d-99ef-ec9e-4749cb47379d@siemens.com>
 <FR2P281MB265412CDC9321A60BA8B87BCFC309@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <PH0PR11MB58807DD17256817B3BFC54A3DA399@PH0PR11MB5880.namprd11.prod.outlook.com>
 <FR2P281MB265432E604FFEB38A3FB7AB9FC399@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <FR2P281MB265432E604FFEB38A3FB7AB9FC399@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0447.namprd03.prod.outlook.com
 (2603:10b6:610:10e::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 82254073-cac8-41d3-5915-08dabce9c032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0qa0CV4vPo9t3JTZDIPJs1oZTIbjzh/S0fgOxDm/5/nCXnUc9ULIh+YWPSMQU7tfESZieEXeH7uqVEk0tbSzLVFfO4gvXZnwdPWeley13/gfWQatnhUsPXIw6sxe6B2VEmBr1rFDdv9d0PtxLY95njMWNrQJGsva5F3gVcN1srCpF+KmfU+0D1kAeDoQqNVIHOlaQkNeU1Y/JsnrrEfcz5G7iZyEa+lC1kgD/rV24hfUTlJeUvJ5l1mgD+fd60vwOaPji1kblKh0OiDfTaJw1JL75UFy2gkjB/fCy10ID3kVEb7mGcLmHt7zbrFkQWSp3vEgS4GKJ1qHBLQ+Qn0Q4IKDHjunLgbVAgVollOhSewQxDOg6TcHC/wwW+hAjyVtiOq/RK+G4IR9StGmZPDVRVXYGQgsU0IrKehFgoJMQLyeuptlDwvaE+ZIcudaz6irV5kx/N0X0Pl1dJhm+CyWZpAD6S38MI7i+DRaqte8VqfqJVC5JgmMppUMOKcUZq0qGUjHQjFi/Ewz/YtWN19SDnDsEWMpaba5lmQjVewL8BGLDMgSlOFuNw6za8iAmZZWxfulasI2zl5HjNMrDlcKkAbKn3HOzkzHOgb8P47G0AvF4kV5qb/wlrNan3WHClqLkRdGhkfh99XsZu1Az6agNERp0q1f2w5mcIqpsK9cWCVjUoub9liwIy4YYkCHmPfLe30cgfxrjmv5q9hbkT6lki8XusCaz3yPQO22LmvioZC9KP0A083P7OxtW6iRkAnFcfrVHV5hWCL1cIXDldLruvLew+SPwQdQlF3g7QXKwzs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(6512007)(478600001)(2616005)(83380400001)(6666004)(53546011)(186003)(44832011)(2906002)(26005)(6506007)(54906003)(66476007)(66946007)(8936002)(6486002)(5660300002)(41300700001)(4326008)(8676002)(110136005)(316002)(66556008)(86362001)(31696002)(36756003)(38100700002)(31686004)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHJoSHVRbEJ4S1E5RklQbko0UWI1MUJBemRNTWpCR3p3M0FiLzE2K1lVdjhT?=
 =?utf-8?B?L1FScTlqanZQY1FvUDcyeUxoeEM5dGpCbEFZS2E3OUN6bk1aT0RYSTAwcGN5?=
 =?utf-8?B?M2UweDZncGRMZXZ4UFNvQ01BYW1oaUJKN215NlFVeVgwVGQrTGtDcVFsRE91?=
 =?utf-8?B?NktRL0RXY3FIWFRMd2NjSWRWVXBJOStQMjNtcE15bC9mV29sNFpyaWFZcjYx?=
 =?utf-8?B?WlIzWmFiWEY1SVc2eVF2VWtLd3RxVVpqQ0U0ZFV5WWxWNU9CZmRMM0g5OVJv?=
 =?utf-8?B?Z1JjZEFjdU5jTGwvUjVQb25yRktuWkxRRzF0WldjRVVyWjRaVk9xYTFDcFBP?=
 =?utf-8?B?aHM0YVp2NmUrVUtKajlqTEFaV241SVZBNTU1czBib3Z5cnFvQlVSVGdiQjFF?=
 =?utf-8?B?Y2ZaU0JhalBkWGdPL3lRcFdSRUxNWkR1YzQ4eVpWVTdlSS9McFdLQ3ZFbG5D?=
 =?utf-8?B?a2tZc2JhV2c5THAwaUJhSmY5alFvQUl2NXlLSVF3N0p2RmNqNHNIUHRPMkx2?=
 =?utf-8?B?bk4wZHEyZUVaL3Y4VXBDL2lUOTdXUGVYVVNtbmNnZmUzR1dlZzU1U0NNWTVj?=
 =?utf-8?B?TzFxVHY5b3lBT3FVRncxTFV3ZFVTbEJoSnZiRTFFUmFGekd6dlNaMGhHc1dq?=
 =?utf-8?B?OE16czd4MmxQUWNqUjNqRU5KYk1JazFIeFZldHh3NUFjUC9aTFIybnlTMmp3?=
 =?utf-8?B?c2tRQnhaMVZyNzNZKzkzcS8wMUJyczFtVGRLRlhyc3lvUDhWbmlScjJ4Z0JX?=
 =?utf-8?B?UVhCdE05cW91cnNuWG4rK2hEMXZHb1RyUC8vTktFWnRuQ2Y0dkplbk94cFFI?=
 =?utf-8?B?ckdIcTdjdFZYb1QwbVk2UGpBZ2xsckJJdkZmN0NnTWF5S0NwYVl2VWNuR3Vz?=
 =?utf-8?B?R1daOUMrZnJiODFpbFBFelRqOUZSTDJzdGUxMHJldEc2Zjd4cnlKb25mcHdk?=
 =?utf-8?B?SndIOEh5RnBQdDRxQzFSMTlQMGxxc2R1SG8ra2h4RDQzcTRPSUhkenNtdkE0?=
 =?utf-8?B?T0JNMUxqdmpjMEFpbkpTZGFMUDRxbjVhdTlLeVVtMGU5TGhNQmRrWW9PRWpY?=
 =?utf-8?B?c0F3NHFLSkJxOVhHbjNaZ0FUSjcrZG00M1BMY1RtNEVSMXVsRFd5N1FlaGJi?=
 =?utf-8?B?UTJocTFxRkRLY1E0eUhJKzF5QkQ5cm1aWFM0ZktjVG8vZG5tWis2c1RjRkx6?=
 =?utf-8?B?RmhVbEtKbUVCaG5BTkptbjZlU2M4cHQvWGExSHVrcE9pbEljZ2s3elkxR015?=
 =?utf-8?B?MnBuL3hpVXUvOHFPSUhzKzZuVWEvWkR3WnRNQTZUSmh4SnozVmcyRTBqSGJL?=
 =?utf-8?B?VEIrRTVtd3dla2t5alUwbm1IS3hCck5LajNraE80UUZLMFdsRUNFVi90UVNw?=
 =?utf-8?B?VDRlQzFXdXlxWDlmVmt5aUE4SFBxUzBmd2p6Z2pWRmVRM2lXbU5xQ013OGVB?=
 =?utf-8?B?T0d4VFllOWpzRm5IRElrblJwMUhaelBpbkgyWFU0akJ4Tk81aTVwdmpuczZa?=
 =?utf-8?B?TXVDYk0rSjJKNkJqcVZOdkdzZG1vcEU0L2h0VmduMzFHa2NUbk0veVVpdHBO?=
 =?utf-8?B?V1hXQ0tqcmFoR0lkRm5jM3dSUHM0UHRlZEFWL1FheGI5ZldIeEtYRTE2eWR1?=
 =?utf-8?B?M21JajAxZlcwWnFRTXdJaC9aQ0d5WkgwNjYwdUdzTXhXdzc0QUs1YWxxcUcr?=
 =?utf-8?B?WWJSZ1R0RHd0STcwTitlaXBkNnl5bWNLb2tEdzdWTFdSeFpOdk8remtIckFP?=
 =?utf-8?B?QzBBSlQ3QkUzMXFmMGMvZk5Rc1ZuUXFseit1Z1BXOFZmaVdDRktxdDl3eDJ3?=
 =?utf-8?B?ejdGcFNIOWtJdWxuUmlFOEhGRkNoNXBmUXVPZGFLS3U3eitwcFB6SVRqOWta?=
 =?utf-8?B?UThDNS9hNCtyT1dsMkdKYXlMVGd0NFhIYzZiM3NEcGdsbDlxZ2FvVFdKemNn?=
 =?utf-8?B?ajNZZE9kc0pvWThlZTZsclBQOXg3N1d4dEdBWVRSZy9vczNnaEtFalBGQjJQ?=
 =?utf-8?B?dExuR1oyL3Vsamcwc1d5OWlkaUdNVHpFQld5ZEtzNi9VTHhxUVExU05PU0hh?=
 =?utf-8?B?QVZseVZaSUNkcmtBcGFNbkhNY2RvazlJS2pzdnpITDdmenByUDc4SUtQTDVm?=
 =?utf-8?B?R3dEdllFZnVZMGxmZnRFV01JTnMxaU14RWxHWFUyRnh2MmVDb1FmSzlxak1q?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82254073-cac8-41d3-5915-08dabce9c032
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 15:48:56.6616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVILGR6YTk+DHyDth+0FJcouv9vXwikULHKDm6Ql+rgBWZn2VGUmJjCi0nA0g22BKjjlpwhYIp0wVM7ppFsDMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7898

On 02.11.22 16:34, Heber, Stefan wrote:
> Hello Zqiang,
> 
> We tested your 0001-IPIPE-ignore-xenomai-FPU-operation.patch on our system (Linux-kernel 5.4, Xenomai v3.2).
> 
> This patch makes the problem disappear with our tiny testapp on our system, too.
> But with a systemtest from our huge application (>250k LoC, >20 threads) the problem still exists.

The patch is surely no solution, but it points to the direction where we
need to dig. Unfortunately, I still didn't find enough contiguous time
to start that.

Jan

> 
> Stefan
> 
> -----Original Message-----
> From: Zhang, Qiang1 <qiang1.zhang@intel.com> 
> Sent: Wednesday, November 2, 2022 12:30 PM
> To: Heber, Stefan <Stefan.Heber@zwickroell.com>; Kiszka, Jan <jan.kiszka@siemens.com>
> Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Wang, Rick Y <rick.y.wang@intel.com>; xenomai@lists.linux.dev
> Subject: RE: Memory corruptions upon strcpy and similar when being interrupted by scheduler
> 
>> Dear list,
>>
>> We tested some of the suggested ways to make the problem disappear.
>> Here our results:
>>
>> 1. The patch of kernel/cobalt/arch/x86/ipipe/thread.c as suggested by Zqiang makes the problem disappear with our tiny testapp on our system, too.
>> But with a systemtest from our huge application (>250k LoC, >20 threads) the problem still exists.
> 
> Hello Stefan
> 
> I guess this problem is related to FPU, so I ignore FPU operation on Xenoami, the FPU operation
> is fully controlled by linux kernel. The patch base on Xenoami v3.2.
> As usual, I apply this patch and use kernel-5.4 run your testapp, this problem disappear.
> do you have time to test it out with  your huge application?
> 
> Thanks
> Zqiang
> 
>>
>> 2. The problem disappears with linux 5.10.127, xenomai 3.2.2 and dovetail with our tiny testapp on our system, too.
>> And it also disappears with the above mentioned huge systemtest AND with the complete application.
>>
>> Tests with 4.19.x are still in progress.
>>
>> Stefan
> 
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Tuesday, October 25, 2022 8:40 AM
> To: Zhang, Qiang1 <qiang1.zhang@intel.com>; Heber, Stefan <Stefan.Heber@zwickroell.com>
> Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; Wang, Rick Y <rick.y.wang@intel.com>; xenomai@lists.linux.dev
> Subject: Re: Memory corruptions upon strcpy and similar when being interrupted by scheduler
> 
> On 25.10.22 04:39, Zhang, Qiang1 wrote:
>> On 30.09.22 13:47, Heber, Stefan wrote:
>>> Dear list,
>>>
>>> we, as long time Xenomai users now have a severe problem. We are currently
>>> in the process of migrating our huge application from xenomai 2.6.4 32bit
>>> to 3.2.2 64bit (linux 5.4.105). In general we are almost done, but one
>>> problem remains: Obviously we have memory corruptions resulting from
>>> strcpy functions (transferring large configurations) being interrupted by
>>> high prio tasks.
>>>
>>> We now nailed this problem down in two minimal test applications in order
>>> to rule out any programming errors in our own sources. These two
>>> applications are:
>>> a) a simple test that swaps two very large strings forth and back via
>>> strcpy (and alternatively other copy implementations) and then check the
>>> string contents. This simply happens on the main thread.
>>> b) a "sleepproc" app that simply contains a while/nanosleep loop that
>>> wakes up every 500ms just in order to interrupt app a).
>>>
>>> When running the test app while sleepproc is running we see sporadically
>>> errors (typically less than 20 runs of test until we see that error).
>>> Without the sleepproc app, test runs without errors. And don't worry
>>> about this magic txr19391 prefix, it is just an issue number ;-)
>>>
>>> So, could you please help us and have a look into this problem?
>>>
>>> Some remarks:
>>> - The test seems to be highly sensitive concerning timing. So we had to
>>> fine-tune a lot to see the error in this minimal test. Also it seems that
>>> even the CPU may influence performance enough to make the error
>>> disappear. Another weird thing is, that if we let the sleepproc sleep
>>> 100ms rather than 500ms the error disappears.
>>> - In the test we can either work with individual mallocs for the needed
>>> 3 string buffers or with one large malloc and specific "pool allocations"
>>> from that large pool buffer. We can see the error only, if we use the
>>> pool approach (see the two options in the code switchable by commenting/
>>> discommenting).
>>> - We tested 5 different copy methods: strcpy, memcpy, two types of while
>>> loops, one for-loop. We can only see the error with strcpy, memcpy and
>>> for-loop. (also here: see the options in the code). Maybe that depends on
>>> timing, maybe it depends on the implementation ... we don't know.
>>>
>>> CPUs we tested on (all with more or less the same kernel config):
>>> - Intel(R) Core(TM) i5-8400H CPU @ 2.50GHz, 4 cores
>>> - Intel(R) Core(TM) i7-7820EQ CPU @ 3.00GHz, 4 cores
>>> - Intel(R) Core(TM) i7-4700EQ CPU @ 2.40GHz, 4 cores
>>> - Intel(R) Atom(TM) CPU D525 @ 1.80GHz, 2 cores ... here we couldn't tune
>>>   it such that the error appears
>>>
>>> So, thanks in advance and, btw, thanks a lot for your excellent work
>>> during the last >15 years!
>>>
>>> Best regards
>>> Stefan
>>>
>>> Ok, confirmed under xenomai-images, qemu-amd64, 3.2-head, 5.4-head. But
>>> it does not seem to trigger with 4.19-head (all the rest was the same).
>>> So we may "only" have to look into what makes 5.4 special. Didn't debug
>>> anything yet, though.
>>
>>
>> My test environment (xenomai-v3.2.1  linux-kernelv5.4.105  qemu), can reproduce.
>> but after I made the modification as below, the problem disappeared,
>> It seems that the large memory copy uses the FPU.
>>
>> --- a/kernel/cobalt/arch/x86/ipipe/thread.c
>> +++ b/kernel/cobalt/arch/x86/ipipe/thread.c
>> @@ -153,7 +153,7 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
>>                  */
>>                 clts();
>>  #endif /* ! IPIPE_X86_FPU_EAGER */
>> -#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
>> +#if 0
>>         if (!xnthread_test_state(out, XNROOT | XNUSER) &&
>>             !test_thread_flag(TIF_NEED_FPU_LOAD)) {
>>                 /*
>> @@ -209,7 +209,7 @@ void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
>>  #ifndef IPIPE_X86_FPU_EAGER
>>         stts();
>>  #endif /* ! IPIPE_X86_FPU_EAGER */
>> -#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
>> +#if 0
>>         /*
>>          * Refresh 'in', we switch the stacks. However, there might be no
>>          * current thread at this point.
>> @@ -445,7 +445,7 @@ void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
>>                 return;
>>
>>         copy_kernel_to_fpregs(&to_tcb->kfpu->state);
>> -#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0)
>> +#if 0
>>         /* redo the invalidation done by kernel_fpu_begin */
>>         __cpu_invalidate_fpregs_state();
>>  #endif
>>
>> Thanks
>> Zqiang
>>
> 
> Interesting. Yes, SSE instructions are preferred for memcpy on today's
> CPUs. And that version-dependent code is obviously not taken by 4.19.
> Forms a picture, but we still need to understand why our switchtest is
> not catching the issue. And we need to understand the issue itself.
> 
> Jan
> 
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

