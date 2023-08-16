Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1999101F6
	for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 14:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aj+b55RWSZJ2IjwjsWViHXILXDxezItGRAQjEIflulE4j9847jd2rc3Ga5r3N7Kr3Xrt2oGXarjcfyayeduj51AyUpI053dD45pFou/UrUx/RD/ipyg+Lz58erG66nX4CHkBLqiRgmijowxnW777Tk9T3EGlg0QlCP1OZek6uR5GCLeID17zYWEQHaOYLYPnLiPjk4YLJkHv84kqgO4V9MtMeHV4TT3jigcMkppIZDJEtNyuyKf8rthItn29ECuLQweX/6x7n09MBlbujTZEdq1SdDZAFmT2xhZDr7o1P5rhw53wMOlIVlaOXkoisfOtZJQ+6HvbV7bwyrwJO3UfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okgN+YcH9kSRZudwUZ+mSHvCtXZ2GNVy+BcUGIMfYq4=;
 b=WU6hdsbnsw9MLpaCDWrgHNxRmgMa59fYyf3PrIav97qFSY4rLTJcSDc0J1d4Sv6IF3cq5ZVQ3PGniKUMqkOsuzCxPQNcWig73otgpynDCtW8WN5BLNdbkGUBgNuW4gvo/ArOA6r5eAaLaPdJHACjE6w9msZgyac2/WxEGb4+Xr1DX/5dd4FsrFH7NLogrmMVd1QEXpoOmmKHMObpcgpzhuAl17z+OaxXfewqBAk4QRdsihNJSdRiXlfz/LTzuUVJDLHcb3DQgpnTsDYbQpPsmhmZcm/S1heXKFY5NN4Rfia+vhj4guTRLZB+LcNwlSF/KZ8diJFVYqIMUiOlziUVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okgN+YcH9kSRZudwUZ+mSHvCtXZ2GNVy+BcUGIMfYq4=;
 b=lcGrT8zmfHPAIPQrMTy2yECcrFU6yvPnUVSYcZxxvxIul7CjtFcjAt1PhA83TxOIINUnTYgLzpsTrldpapoZTxQVmYTPIbA8FHc88qApRYKsjc48Y6l9LeMrr78TvNjHdMsxrIyxH/J0OVAj4+n8yUyYhwLDRMdrEVtevDVfB0yHnNmtoVit2gzXnZKCl9TJJXpTpA2v0BVwqGV3+EDyRjDEAb1C+O8QDW2KVk6xKfgrpJUlNn8mmuRQ+Y3z3mhPBGrbufnnM/Om4qkfINnCY0WTlMfo2f8ICji4cy2V++hncMAUDvfp8q42dtuEgFkgXJfhM+aabnrv7/BzM+uSpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5585.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:273::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 14:19:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:19:49 +0000
Message-ID: <40370ed9-e3ca-49d2-927c-5522e8039207@siemens.com>
Date: Wed, 16 Aug 2023 16:19:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] testsuite: Fully integrate alchemytests into smokey
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>,
 Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev,
 richard@nod.at
References: <20230720145150.24607-1-aaron@sigma-star.at>
 <20230724135239.10579-1-aaron@sigma-star.at>
 <20230724135239.10579-2-aaron@sigma-star.at>
 <c8b63b8bf2c3d4f803d6049d874e9a37f5dac284.camel@siemens.com>
 <20230816124146.pz5xymkd7di6kxbd@mail>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230816124146.pz5xymkd7di6kxbd@mail>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5585:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d11f52-c980-4096-a242-08db9e63d9d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8NgNlqjDVNHOwP47TbqkFRhx+dU3ng4kBSuSJ56CExaA33wzAkO5EMSsqWcQePXiO8H+WXS0CQfpHtEGK7fXvXf+p2AgaqIMpjHhPp5JV2uvq0GBbiWnwXXFA7uhRn6YEHhTgkie+JfTaGcgYCCZpDubRIhuBWnagRzFID8kh9a98e+CrlrdorswuMpA1sFvhhf8ea17FHT/nXqrytMYZuXKgu0LMahIgTV2kJ05ZoEvv7xZMu6e3uL9BN8wAdDem9h0fXRYDhxe/1CZ/Fv547lVtIhwztmqOz1lY7Erg1JR96xXTsdKMpSyDg+xOSqQjs5RtjRkm57claaH3XG6wIfO7vkbiyOrPQ8U0cYDaefa+Lmf2VufeF5P06lUMWZq6TLzqn79laO8mNJMlC6SHLWhbYklrE50ERk0+Cndz1tXnlhvgYv6/d13vWpDt4GB+uk249HEt+FnqnrPTKtVk1Av8spjFRXs2tSUj1LH1GHq55GFY08xdxMEr8yAWMhjzvg2BCrof0lTqo75ZLYPyPSWk4J6Li2TgAZ0HJRUJTKKo3u4uFn/g47GTJbVFPCgkc6RqvfguEELiHKMfozXcbOND48//lyqBFf/IpWNRIh7uQ3BEcsofNRXeJWgsX4wjCcWpbB8EB1mvdIhu93MOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(66946007)(110136005)(66476007)(66556008)(966005)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(8936002)(82960400001)(2906002)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUM0WG5jYjkwcUQwY0VGbnRuRkUxV1BQNGVPbWFzWGtLL2xsbEJZc3FxL21u?=
 =?utf-8?B?U2lFZlhWZ0Z1NEVVaTgrNG0wVHJXWmEwR3AvaDFOMTkwYkF4aWcwK3FPZndR?=
 =?utf-8?B?Tk9Gb1cxRFhqYytvZ3ZBeVFsVG92QjZRY1lnYVEvYS8xKzdKZXkwK0tjVDJT?=
 =?utf-8?B?NkI5bVB1UXNGVzNoZkZzUEMvNWliNXB3NFhneDVwU3VFTzhDWjhZMEQwK1JG?=
 =?utf-8?B?ckN4b3p4dm5KMWRSRGtJNkVnTk0xMzRjMVlTTGFHZG90SUJnQ25lUmFxc2pH?=
 =?utf-8?B?YnJQWUI5NnBIQS9ON25iOFFsa0ZNcE5tZDUvR0F4WFF3aGhvUHc5U2RzYjV0?=
 =?utf-8?B?QWxrWUh3ODY5MElHbDBxMEMzNS92QVVUMW5xcU5vRTQ0SlVCc1hRRThDb293?=
 =?utf-8?B?aEI5T2NkQlduQ2JkZVBqQitZOG9OZUtXQWJUQlZPL1JIWGJzSTFHSDZldzk1?=
 =?utf-8?B?NTRQVm1FQ3JDMEEvVTFaZXVMVEVvUDFTaitObWkwYUhteDJBZFJpN2xVdnk4?=
 =?utf-8?B?Z09VLzI0ajloRldQS1NXNWc0T3M1MFNwanJlbWpaVzZHZ3Q5bTZPalBqcXE1?=
 =?utf-8?B?a0FVZ2hVbVJJSFVIS1lNdHpTSmtBS2RyVFFqcDNocW1DNzlRa25pYWcrQjE0?=
 =?utf-8?B?ajZBdTBNT0lRZkNVTll2Q2dTTG1ub3hGdFVPWXM4Z0dGcXVMQkF3R3JiR0I3?=
 =?utf-8?B?TytPWGVYT2wzOC9iTDNqRXhaTFhheTUvNXJ1dlJ6K2dYUjgvSWFhVWI1ZjdX?=
 =?utf-8?B?RklwRjdXTTFnVEpBb2hJVkF2TXdxT0ROYXB1ZVpqSlpYNlF0RHhOaDFXZnZj?=
 =?utf-8?B?L3FmaFhmQW9TZUNhTjhENkkvRHlVNUsvYzJ4SmdnSXpMWXE4TjhGQmNmQkFJ?=
 =?utf-8?B?bWJSVlpoaDRQaWNnS2JlaitSL2pTbE5SRVZwMk8reTN3bzRwby8xQjdYRFpP?=
 =?utf-8?B?VDVUMUJUUDBOZmdxci9nNFY5QlZUUG9YWlRUK1h4aHpoV3o5VDJmSVN2eVEr?=
 =?utf-8?B?cjhnSTBGcnFiM3drMTZidkRTaVNqSEY4MGJGVThBUGtsYitJRFhmZjJVdzBO?=
 =?utf-8?B?bFo4Q0lVWW95K2xrVkRsbUFZRFNYM1ROWkg0dEtxajhzN1BOWjhtcmt3ZTky?=
 =?utf-8?B?VG1XMndlbTVkeUUxU3pjQitUM1FSTmhjVkNqdVQ3UG8yVGQwMGV1S0lyT1lB?=
 =?utf-8?B?UnVLcmNFZngwbnNFZit4aytsSXo2QlRlZTBQbGRUeUxRMWRENUhTbEVPYXVK?=
 =?utf-8?B?ZlNQVEFBdldCaFFDcTQwSEZhZUxueHU4ZmQ2MEhuaFZKbThMTUZ5VXN4NGhJ?=
 =?utf-8?B?cm9MaDN1RU02ZTJjdTdoN2xjUHlnc1BCa3UwS1puc2N1S2xoazc2TWNrL1dq?=
 =?utf-8?B?MEsxeHRyaW93KytsTFFMWEZ1TnFYcWh5SnNOelU5bXJnS2lKNTRxUUkzN1c4?=
 =?utf-8?B?WjZwUE1JNGF3OHZwNTU0dUlUSG05Wk1MZmJlUXJsTFBteGgvek9XV014T05o?=
 =?utf-8?B?ZUZGa2l3R3ZqY1hmbEVKS0hrNDN5eEE3dTRtamRRSU0vUnMvd2c3Q1VUTXJ2?=
 =?utf-8?B?dTl2RmhROGdzbzhOckE1czRXaWtQYUVyaHQxU3I2bWxSNFBYVEFycy82VjZY?=
 =?utf-8?B?OGZ3SDhBREtObDJVblA3emxVcklLcWx1YkVVOENZTTJxOEh0WHVZbjdOTGIz?=
 =?utf-8?B?UWg1WHVJdTNtNHU3RVZacG9qaWljblRTL3BSdFpFenVqbHRDdC8wT1VMbWVx?=
 =?utf-8?B?M2svaDc2RjIxOXRneVV2SkNzc1FiRE1DYlFCM0ppYVlTOHZ5ekVpbm51RE9x?=
 =?utf-8?B?Tm1VcG9vTDNzdzBYZFhoNCtyV1dXMEpMME9POFJEOUk0dENIdEJJWDNOS05F?=
 =?utf-8?B?K29mWkZhdDJmbHpOZkRWQkpGQ3MwV0w3MTlhU1Fsd0I0QXFhSWhJaVFiR21h?=
 =?utf-8?B?clFJS09hSzVEYXI1YmU0STBIOEVBYnJKeEwvZmVMNndlQjNPVngrZUl2ZVoz?=
 =?utf-8?B?Nmh3VmJGSGNpcnljOWY3aDR1ek1vU3FWZS9pQ3lwRzNDRmV5Ym53SVplaVBG?=
 =?utf-8?B?RGlENjV5UkdRTHNMV01rM1FxcGpYcUhZZ253MGFRVVlra1pPREpsbzd0eVBP?=
 =?utf-8?B?WnRaV1ArTEJXLytYemhYbkwrZUdqcjRVSjJ0czU3MWJ3Q1JZV2grTGhuNzRz?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d11f52-c980-4096-a242-08db9e63d9d2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:19:49.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rl6K80G7skeJygI/5S7ffhqJIzgmHArVsohYN6YXLey9fogdOFSGzNAXvQsnmS+Nit2EsUoN+vBPqJdCPBok1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5585

On 16.08.23 14:41, Aaron Marcher wrote:
> Hi,
> 
>> IMHO includes can be cleaned up. Can't spot a usage of error.h,
>> libgen.h, stdbool.h and unistd.h (at least).
>>
>> Applies to more locations within this series.
> 
> Oh, missed that one. Thanks for the note, will fix.
> 
>> The following applies here and on several other places of this series:
>>
>> Do we really want to have a test plugin for each sub-test? I would have
>> expected one plugin for each "test class", so basically one for each
>> sub folder in testsuite/smokey.
>>
>> Each module could then call all the sub-tests and report back which one
>> actually failed - if any.
> 
> Hm, I will have a look if that is easily changeable, as I had some
> troubles with linking the Smokey plugins together initially when trying to
> create a plugin for each "class" (which was planned originally).
> 
>> Btw: I think Jan already reported that: I have to disable the
>> vxworkstests_task2 test as it fails CI runs here.
> 
> I think Jan posted a fix already afterwards?

Yes, task2 should be fine now. I had some other tests failing in some
qemu build these days, see
https://source.denx.de/Xenomai/xenomai-images/-/jobs/675985.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

