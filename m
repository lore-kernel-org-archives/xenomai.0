Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541942904
	for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 11:55:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6JMRbXQkCS5o8zwHEZdmVzzN+Q0yEbbCGEfAg/eSvVwWpUVXv1cX3bS/48CxSlvpxlYD10xDcrVd0HjzVNNq/rw0h13iRdJQkAJW8RMObq3luHWY0xcVYjf8Qh++gVzAjPYssmEVC8YMtyGhmbrI3LKlswmeyie86gjFWzg7KF9kfOCWI9U5aobCnY9qPMIPXEgc1msCiizCcfjKrV8Jq9MX1FGB3ULteh+c3rvZbJJ9qwFBd0de6PQ81dOvxse8AKa6XHcFZO969Y7Bi1sJ8I4dmgIIgY0DwlMxLACQnztmflAJzCs1Tf7dY3YlfNo4079qHi3Gcal2Q8/1gFHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdGFP9uZS2v7SJjzjkxGQKeA5gswIEIuoDVBqv6w+vc=;
 b=Kon2MqtoT9C+4dLN1OOqADYwF6NNaP4otYWxIUA7e++AMVl91YfS8dQ2r062ZZwFE6aYIq11R3GXaNID30XAOVZ2Ep/5JDXOrMB89v4mPhVFgCxos+ZF7zDfHwYBlS3ymEDLgcqcQqrbIurDai9y438kb2z2nv6YuOLWcfk+oVeXnrC/PW8Vqh0GdeS/aMDSAv5lfZBECLrXNg9KktsynsKrBBhOtdAaG7wo/m3kh9wOJuD4Wr7nZO8eu/ALJCalh8jBpkA8uFSriHynQyGv791BT1JeHL14Tok0xsTjviPtvMdN8z2LYf95ySnwW+OO4a2C+j6XoI6A3t3qc+EQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdGFP9uZS2v7SJjzjkxGQKeA5gswIEIuoDVBqv6w+vc=;
 b=T6Xsb2eNiQijzhfILojRDnKRWP28tS2bWSJmVodFJ7V4E+4IJPFiL58vHkKgYbq3W8CIbB3sVNVOdklei0Yit0P5+t58DlycC7xpbnChl4x2KqNDC9TZzI6VGkO2x35YYsflbbIRe+G+c7cbgmrH2BU1dS6Jga0XxZ/9sAsg7/oUm4chctgtula+JAlhTm6VF0BsJJqWh/RpP+Ta/9wN5LWKjLhfhJ/cuk/2MNXLTpFKA0O/mYSGvHwl4j8eaDnNfdTEFsnHzT4wgA0fZMpnpPdgDX1PxMraBzdEzU9waRQFFP8WVz7E8zVtUT4RFaC2GPUwvY1NWaJF1l9Kf65/pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7031.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 11:55:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 11:55:28 +0000
Message-ID: <08355553-db9b-cf6f-1470-20384a91d401@siemens.com>
Date: Wed, 22 Feb 2023 12:55:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: undefined reference to `fuse_main_real_compat25' when build with
 --enable-registry
Content-Language: en-US
To: "Mauro S." <mau.salvi@yahoo.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>
References: <fc2f8e65-dce5-452d-3789-70ebc838abf2.ref@yahoo.com>
 <fc2f8e65-dce5-452d-3789-70ebc838abf2@yahoo.com>
 <MN2PR11MB4285DF9642B16AE3F170431FF2D89@MN2PR11MB4285.namprd11.prod.outlook.com>
 <b953b20d-f866-5bec-faf3-f8560354bf59@siemens.com>
 <04a817d8-5792-c00b-8533-488cbc24cb4d@yahoo.com>
 <02c53276-6a36-8377-4792-575274793c66@yahoo.com>
 <023a8783-e78e-94e2-fd2a-0bf959b886de@siemens.com>
 <bfea17eb-684d-40ba-8325-ef3b45bfc226@yahoo.com>
 <a9c9fbbf-9278-141f-8b73-04c9e5217a48@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <a9c9fbbf-9278-141f-8b73-04c9e5217a48@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 702b819d-d171-4741-db67-08db14cbb0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	09tJmEhFp5kKVo8IT8gTsR5s0gfGY+ZK5kTN1AftsTgp++JwaLeI48ABNrF/6r3sOHaRAaEYOfjOUyDzCZmGQecJEZ7jaJ6Sb5/Wkvgac8M5yW17Z7ms5bbNjT8wQbSoZLi7ls1z7yt2/uRDc2UvY4nUCi4C79xGqJCYTjDVf8WahLRYzugDjJYwajUB/Wk7Z0xzBxUh5SIJba0mHF1UeEBcN45iM3Bkmekh9JlqqZ0T/WC65arINqneRccaMBXTBcJFB6wI6/4zCFpqGCWXDosuotHx0VsavM/bGZxRSU3Z8PYz6aYa3SGkZyDQb+Npqw/JCQ21Z9eBRsXzPGidLjSTscXfdZoJOqG+s71rOZQlVLiZtDB9+I8RFbQF3j5JotRpL7HyNYM21Qlqfz9JgjHepoTmw+S/nThyqFz1H4xc4QE8o+xSg+EfZSxLH1mClofSX3DA/eUqWYMOC3IHCfWpK6uNquyzRA2gWw4CfS5wt6gB1tTdryEHZrwyds6AK8ZvZzm15iEP7+yJwWFqTN5wAIfQHVwNMS2su+jrLo9fgbWQL5foIc6fogZtz74sS6/96wuOWfO33A+80ruILNO4H5bPwtZkRAH/BXnVzwHL95d1ko0Q1t/1QtZWpxWBAozsDwoYURYN4LNgVqtty0yOhsi6hJUFUdPvhit6gm25Rqj/D1DWJjm8xFnP0HkS+wYyHrCkPG/YDeGYWE101dcwXKYdLmLVix1XGBNWTrnlxSAnQaaZt/pWUglYFJcW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199018)(26005)(31686004)(966005)(6486002)(186003)(53546011)(66946007)(4326008)(66556008)(66476007)(8676002)(5660300002)(36756003)(83380400001)(8936002)(2616005)(6666004)(6512007)(6506007)(478600001)(41300700001)(316002)(110136005)(38100700002)(86362001)(82960400001)(31696002)(44832011)(2906002)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGhueGxGOWhuNVlHMUtzeUgzR3VwNzJuejFDektjTzI4dzVVcnpUcUFZcjVi?=
 =?utf-8?B?RWRaSEdXdTVkbUYxYzRkdnlNTEVydGRpc0JvcUEzWkFzZ0IyeDR0ZW9udldx?=
 =?utf-8?B?dXM0eHpvNzN5Um5md2d6RHNzVjdLY2VhQ3N6aHIydHFLc2U1QUs4ZDhMYUtC?=
 =?utf-8?B?Nlc4dFM1aExIR2ZuTkNUbWh4SUVESWFIQjMyVTFORm5GdnNzT0xqR0JMTjdk?=
 =?utf-8?B?elJNeEdXL3VqZEZYcHE5dUlpQjNBZGxiZzY0Q1V4bnVqRG1iRXJwTWFCTm1Q?=
 =?utf-8?B?WHYzUjltK09qenAxa2FTMjNjUGFSSVF2SXpWVEFZU01SKzVkNVo4OTlwTXNN?=
 =?utf-8?B?SzM1R1VGcnZ4VHNsRkhSNHdDSGE0VE5JWWpLeFg4V0tCa0tzSXdjdUkyemQz?=
 =?utf-8?B?dFdneHVtMG40TGxKYkJBVWw1WEdQSS9BZU1wMFJuTW5aQzMybnVyekM2Qjl6?=
 =?utf-8?B?K3J5akpsR00vRGl0QVZ0N1NBcVM4MjlhUFZFbHdQeGpxMlhLNmFNZWhHYzJF?=
 =?utf-8?B?QjdtRGphM1B4OFV1QndjTm1hcllFY25rUGNOS0ZNUHczYmduV3ZEZnVzSUlB?=
 =?utf-8?B?aVFRWGRPVHV0bFQ1Mk1ROGpqWUdxcFdhV1dCRXRzVlBTa2RlMUxvenhJNE1I?=
 =?utf-8?B?bmhMdUNmMHlhcXA3eHI3cHVpbDZSbWlkaDNCNTE2Um5GTVVnckx0aDFuTHQ5?=
 =?utf-8?B?c2g4OGZLZlB5WjIxdjBXQWo1c0s2WWgxSUV4RE1pRmtLcENMOUJOT2pvbisw?=
 =?utf-8?B?dTJ3d1d1SUl0eVdWc3QzSlRoZFVGR2Q2K0tKWGpuMXhTckRER09jSU1oTEs3?=
 =?utf-8?B?aXhURGtpRzlEZXY3UnNTTUk1OEtCRk5KR1o3K050UVpMeHkyVXZsSzgvVzdH?=
 =?utf-8?B?ajhTTklYalBWZEh0NEs4UUJLVmd4SFZUR2lBTmRIcGY0VHlJL2V2a01SU0pT?=
 =?utf-8?B?RC9oWEtYZlFLbWpkRjRhbis4UGxDRnlJNzFhbzNHemtwcU5PUWQ1dUc5SWpr?=
 =?utf-8?B?QTZZam12eHg5TXcvSithU2JpY3QzWXlVSkl2V2hQWm9wKzV0OEJXenhiL3V5?=
 =?utf-8?B?R3NLWVJsd1p6YXpZeUdXc0NZOUQxWk9GYnkvcDQrZkpIcFl5VGlvZmFWeHd2?=
 =?utf-8?B?VWw4SDY1azNRNDNOc0p1QVFDaWtmc0psOTgwKzhWbmZZc01pa29DOFJSRU4y?=
 =?utf-8?B?aUYrU2dNSVZMbmdHd3pNbkt2OXJhMlB5dUgzUGQ4YjBZMGtGUWNqdWZsM0ha?=
 =?utf-8?B?S0QrekVXTC9mTzBTMHBrc3dpYWRZQjJIUTB1WStyWk96czJaUG15U3h1R0Ex?=
 =?utf-8?B?ZWx0SnRjMDkxT1FubW1YTUVyOEFSYjBsOUdnaUhoYUVUTXBBaUZPdG9lcVR6?=
 =?utf-8?B?bzR5VGZEdVBySmF0eFB0Y2w3UzZ4S1RjUyt5VnhjVVpRYVhWeWVNd3ZaLzNu?=
 =?utf-8?B?eTdxVlJINUNlUmtBVHpGbGY1SHNFRkNWRC9LT1RzbUltVlRwNU1XTVVrSlBl?=
 =?utf-8?B?L0xnS2h4RlJxaVJ0QzdqdnFIeitpa0tCem9Bdzdaa24wOUliWmcwRG5MUEMr?=
 =?utf-8?B?SlRMckhaM2FsUEV3UjlZUC95QmdGV0lRRjd3bVN1WVFjK09paktOYkdkTnl6?=
 =?utf-8?B?My9pOE0rVHBKV1BLbTJlOXZUTFNSTVhGcm9LbFB1YjEzMFpOTlNyYWxMVVZx?=
 =?utf-8?B?NU5pRml1VnFQZFI2UmIxZHlqS1R0WHZ2aVMxMFE4ekZQdnBXWlNSSHBJZkcy?=
 =?utf-8?B?VFltb2hNZFB5cUZBSTd1dU8rK1hkamFFSzRBdWU4VDNzTE4yVFpMOGlHZ3dI?=
 =?utf-8?B?dFgwcXdwVjN1NkYrNHhhdHdUeGxFRFd0WTYvTzh2VzA0RXR4QVlJSG1XYzdr?=
 =?utf-8?B?aFNnSzNJanJraTZJaTlzZlgwcEVGV0dCTmpxODRMT0JTZW02SnlFR2R0UFIv?=
 =?utf-8?B?SDlEK3E3MXF5QzNMTGVTUE1QQjdKaVZDQ1YwWU4vMzBGVWZUbmRTbjJ4TWFZ?=
 =?utf-8?B?anBmcUZXVmFkV2sxc0VnZXBqZ3FXakFJRHN3MU9BSFdnbEg1Z2NLSEZhVmYy?=
 =?utf-8?B?aTBYTW9hM0xFc09jTU0zOVNjbFJDSDBENDZXRHlBTWlocXowek9LVUNZdXQ4?=
 =?utf-8?B?QW85cmxzR1RtRVFpWXJzL3ZvY2FQWC9wWnhOVU9ubkg3c1RTWWpYKzJabUF2?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702b819d-d171-4741-db67-08db14cbb0e5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 11:55:28.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INSx0YPyN/9hLj8qgbmVV/cOJFsYobD0AdWhUUOh2nCObnsTHO7l8GUEJkwVvAVwPJ7TZbix2Ms/7fYqDbboxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7031

On 22.02.23 10:52, Mauro S. wrote:
> Il 22/02/23 08:19, Mauro S. ha scritto:
>> Il 21/02/23 17:57, Jan Kiszka ha scritto:
>>> On 21.02.23 11:40, Mauro S. wrote:
>>>> Il 21/02/23 11:24, Mauro S. ha scritto:
>>>>> Il 08/02/23 09:21, Jan Kiszka ha scritto:
>>>>>> On 08.02.23 03:27, Chen, Hongzhan wrote:
>>>>>>>
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Mauro S. <mau.salvi@yahoo.com>
>>>>>>>> Sent: Tuesday, February 7, 2023 9:46 PM
>>>>>>>> To: xenomai@lists.linux.dev
>>>>>>>> Subject: undefined reference to `fuse_main_real_compat25' when
>>>>>>>> build with -
>>>>>>>> -enable-registry
>>>>>>>>
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> I'm bulding Xenomai 3.2.2 for x86_64.
>>>>>>>>
>>>>>>>> When I configure the library with --enable-registry, I get the
>>>>>>>> error
>>>>>>>>
>>>>>>>>     ..
>>>>>>>>       CCLD     rtcanrecv
>>>>>>>>     libcopperplate.so: undefined reference to
>>>>>>>> `fuse_main_real_compat25'
>>>>>>>>     collect2: error: ld returned 1 exit status
>>>>>>>>     ..
>>>>>>>>
>>>>>>>> libfuse-dev package is installed (the configure script finds fuse),
>>>>>>>> and
>>>>>>>> it has the function fuse_main_real_compat25 exported
>>>>>>>>
>>>>>>>>     readelf -Ws /usr/lib/x86_64-linux-gnu/libfuse.so | grep
>>>>>>>> fuse_main_real_compat25
>>>>>>>>      318: 000000000001a500    14 FUNC    GLOBAL DEFAULT   12
>>>>>>>> fuse_main_real_compat25@@FUSE_2.6
>>>>>>>
>>>>>>> I do not know if it might be related to fuse version. In
>>>>>>> configure.ac , it selects fuse version 25 but you are using 26?
>>>>>>>
>>>>>>> if test x$use_registry = xy; then
>>>>>>>           PKG_CHECK_MODULES(FUSE, fuse)
>>>>>>>           FUSE_CFLAGS="$FUSE_CFLAGS -DFUSE_USE_VERSION=25"
>>>>>>>           AC_DEFINE(CONFIG_XENO_REGISTRY,1,[config])
>>>>>>> AC_DEFINE_UNQUOTED(CONFIG_XENO_REGISTRY_ROOT,"$registry_root",[config])
>>>>>>> Fi
>>>>>>
>>>>>> That's a good hint. I vaguely recall similar issues when building
>>>>>> against a newer version and trying to run that against an older
>>>>>> one on
>>>>>> the target.
>>>>>>
>>>>>> Jan
>>>>>>
>>>>>
>>>>> Hi all,
>>>>>
>>>>> Yes, I'm using libfuse compiled with FUSE_USE_VERSION=26.
>>>>> I'm building in Yocto.
>>>>>
>>>>> I tried to
>>>>> - change FUSE_USE_VERSION=26 in Xenomai: does not work
>>>>> - change FUSE_USE_VERSION=25 in fuse and rebuild it: does not work
>>>>>
>>>>> I finally removed the can utils from the Xenomai build (I don't need
>>>>> it) and the build completes correctly.
>>>>>
>>>>> Seems that the fuse symbols are not found only for can utils (don't
>>>>> know why).
>>>>>
>>>>> Thanks, regards
>>>>>
>>>>
>>>> Replying to myself: Xenomai does build but does not work:
>>>>
>>>> /usr/lib/libcopperplate.so.0: undefined symbol: fuse_main_real_compat25
>>>>
>>>> Strange thing is that /usr/lib/libcopperplate.so.0 does not depend by
>>>> libfuse2 (that have the fuse_main_real_compat25 symbol exported)
>>>>
>>>> LD_TRACE_LOADED_OBJECTS=1 /lib/ld-linux-x86-64.so.2
>>>> /usr/lib/libcopperplate.so.0
>>>>      linux-vdso.so.1 (0x00007ffe6ed14000)
>>>>      libcobalt.so.2 => /usr/lib/libcobalt.so.2 (0x00007f21fc308000)
>>>>      libmodechk.so.0 => /usr/lib/libmodechk.so.0 (0x00007f21fc303000)
>>>>      librt.so.1 => /lib/librt.so.1 (0x00007f21fc2f8000)
>>>>      libpthread.so.0 => /lib/libpthread.so.0 (0x00007f21fc2d7000)
>>>>      libc.so.6 => /lib/libc.so.6 (0x00007f21fc10a000)
>>>>      /lib/ld-linux-x86-64.so.2 (0x00007f21fc355000)
>>>>
>>>> Other hints? Thanks in advance, regards
>>>
>>> If only can-utils are affected, it should be possible to spot some delta
>>> in the Makefiles, the build logs or also the generated binaries of other
>>> tools. There are many more tools, and the can-utils do not reference
>>> fuse or the registry service explicitly.
>>>
>>
>> Yes, I will go in this direction doing diffs between build logs,
>> ldflags order etc.
>>
>>> And: Where does version 25 come from? Do you have it on the host, and
>>> something actually leaks into the yocto build so that the host libs are
>>> referenced?
>>
>> Version 25 is the libfuse API/ABI version that Xenomai wants to use,
>> and it is indicated in Xenomai's configure.ac, as pointed out by Chen.
>>
>> libfuse is built with version 26, but contains backward compatibility
>> API/ABI for version 25, allowing the binaries to use it like Xenomai
>> is doing. In fact, the libfuse2.so library contains the
>> fuse_main_real_compat25, but canutils does not see it during the
>> build, and libcopperplate does not find it at runtime because seems
>> not linked to libfuse2.
>>
>> I will do more investigations about it.
>>
>> Thanks, regards
>>
> 
> Ok, found the problem. First of all, canutils buld fails because
> libcopperplate does not find fuse_main_real_compat25 (as you stated,
> canutils does not need libfuse directly).
> 
> libcopperplate does not find fuse_main_real_compat25 because
> libregistry_la lacks the fuse ldflags. This patch solves the issue:
> 
> diff --git a/lib/copperplate/Makefile.am b/lib/copperplate/Makefile.am
> index 671e87d79..a68f2c80c 100644
> --- a/lib/copperplate/Makefile.am
> +++ b/lib/copperplate/Makefile.am
> @@ -34,6 +34,9 @@ libregistry_la_SOURCES = registry.c
>  libregistry_la_CPPFLAGS =              \
>         $(libcopperplate@CORE@_la_CPPFLAGS)     \
>         @XENO_FUSE_CFLAGS@
> +
> +libregistry_la_LIBADD =                \
> +       @FUSE_LIBS@
>  endif
> 
>  if XENO_PSHARED
> 
> But for me it's strange that this error does happen only to me.
> If you are ok with this patch, I can send it in mailong list, or just
> take it from this messsage if you prefer.
> 

I don't recall all details, but I did recall something similar from the
past:
https://source.denx.de/Xenomai/xenomai/-/commit/9287a691412ac1da0d611606499eb0201c2e0247

Reading "optimization", I could imagine that different compiler/linker
versions have an impact here. Are you on gcc-12 or something similarly
recent?

> I also have another fix for sysregd utility, that I will send in a
> separate thread.
> 

Yes, please.

Thanks for resolving this!

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

