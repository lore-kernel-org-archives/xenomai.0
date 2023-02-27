Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5629936F
	for <xenomai@lists.linux.dev>; Mon, 27 Feb 2023 10:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apg3Adb/4D/xFkfuZwPxkg75fxD4U0uRpIDu+/mdZbKkDl6osXeTA6SGb681gj7quu9cMSvUiVCexAQWhunzudrccQx8hR37TSgsU29PWnCRdS4uSJbYuXeIFMtAb7e/MYK+sdycpXBaS387q90hSDT68rEgjV6h8MadboR/Wfe3d9OOm2qe+6sV2/MKeI38kyi6oT0Cu2B8DGrvpsEZnpyXPiUD/loG+I2pkvja21awpsgr09bgMchTWop3w6M4qHtIp7OuXHpQa00TWdSRnplTNHXdWsFVqHeOYRBtUa6RkLoizSb6fn+HcM0cSKqJ9hwKGut7JXn8F2jbUo+mPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJOMtZhdqFISnZe9HE9vegK8zW/EhhTrJ1rY/zBQjdI=;
 b=GA/D9Fba736qHeiPRCc730a8keSbgrOq3iVULKZFIGWU6pJYQtxNL1lkAjEhyXsBJBXQPeUo/cN1eDbjmPz7nCK2+0/N9BvKvv1FPiErDow7BiMV5atZ1Ynrz8l3+/DqMMrP28canGeqMdl2buSSGV/xbuXIF7SUYmLy6ILQaB2FjalJwPOrFgiz7UeYZjyvzAaVvAOnv2RhPtzi4Ic2XnjqEn6bVzAle+rnyZFrxGCsPSxuBpFHZv/QmFGTsZub7e2Eod7zD6vLogwRuD0Icn9yG/wiLdX7sCcvfGWgWDgHpwSCnlt2r52YuWwM7q2JTD9VTjblg3JweuQIddeeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJOMtZhdqFISnZe9HE9vegK8zW/EhhTrJ1rY/zBQjdI=;
 b=dJ//IIQzqv3aXnJnLWb166xDQBjVBUMNK/VKG6j9KhThXO5V8ua/VkZFG50z5+c7qv6QpOrQNUor2RRvXGosWJpWbQwUOHjHfp2HL7q4wJZvJMM/NIMhNfWIEVut3KUMsYnC/76GGYWmmOdXpfBIKphp0xuQtTSl/xiQKBjf3Y0XrqoSpSwpnVrVUg+DUJb15AGRaLCeMOn7ToMjlS8aCgufth+t2AEVfcZ5iHD77jfc1upBolLNKdourWEHQ7bkPHCN3zCg8iN4C6cX8DZTsIqmJB111aoZZqNeJJrvNRNdv5BewEaVeoUmA8GXR5kl3rh4HMmXGs8DsXGgal9MTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7242.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:454::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 10:30:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 10:30:46 +0000
Message-ID: <d58eb804-dcbf-5fe2-182b-878b4fd987c3@siemens.com>
Date: Mon, 27 Feb 2023 11:30:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: xenomai 3.2 compile failure : cobalt_lookup_vdso
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: C Smith <csmithquestions@gmail.com>
Cc: xenomai@lists.linux.dev
References: <CA+K1mPGxOi=GFfDbE+nq99HsMWEe0+Q37bw=X=UHjqb-yNfj9A@mail.gmail.com>
 <39ce5d58-ddcf-de33-32fb-eda57a5d128b@siemens.com>
 <CA+K1mPF8G3c0V4Y7co=y9SGdjTy_R_d9Up=9bj7c6Nz2XEXp-g@mail.gmail.com>
 <0dea24a1-0943-d9ed-1f9f-c535e5a526ba@siemens.com>
In-Reply-To: <0dea24a1-0943-d9ed-1f9f-c535e5a526ba@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0056.eurprd07.prod.outlook.com
 (2603:10a6:207:4::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: edef0233-dbb5-4805-e369-08db18adafe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fPsxGOt0VNnhr4d3gQ6KqSo0ItjpGjC5m9Vw4XieuiNFerpPVVrdkI0wUrHtUqxCi08MzjULbgZxv9PoUTOk01m9L3JsvHVchxWVonQ69msQbUiajKuymMAsCQXD15zCcP3C6TNf+oiWak1CVRrQ0sGZ+f2AvCKUIal7gZl12Zh4uE9ioS3gCu0MaZE9J8//F9o7fnTWW0rJHd3G81M03f6Z604TB/Ui/1HsEyUfzmY9nORv+QsTr0aKkPHKc9N8lz/Uv2mECOHabNg6TwcAJ3mSaGzXN3h5uUF44ad7mrVRBiiRe1+DBzcoPuOXM7ExLJqUMXGj+pmhbZ2oNGAQPA60BP7nUBZbyT9rmWXBU+zPU54PdY15tSJPeT1sOV2DfULTpzuZbPxGaG2qGXN0YCorCzcORiEuMfeV4O+2jo9K8D/gZVh8qvHSZs0K5pMnjvRcgjUgUiGS6YuAgx5Yi7NOOSYd+FY1CZst5I5iP4khbaZy2MSoDzfUQpBxx61EoXsSSU5OXEYUaCDDo1kvKhnQD1ROpcyFS370QuIj/yJ9A2sfuUtztSqHmDVFBsU0yoUnTdoqGxigqilcoDvLgg67K1pJhmxo6//LmCcF043AK67W3FGXtf2OYb53vy3NKlMpi2FLtO5qkmxND5cIEwu9Fyh0HrCICj/sKOOO4kBymmFLK0Cce3HuZoyaKcuekHu8Y3GBLa5pjuXHTpzP9tSaq39FTCfFu19WIgwSc/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199018)(2906002)(83380400001)(31686004)(44832011)(5660300002)(8676002)(6916009)(36756003)(8936002)(2616005)(4326008)(66556008)(66476007)(26005)(186003)(66946007)(31696002)(6512007)(86362001)(53546011)(6506007)(316002)(6486002)(478600001)(6666004)(966005)(41300700001)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzFJdU1EcHBtZjlwWlVJWTZNSWgrdEVPclNrcnB5WGxVaWFzSTN3aWFmQXA5?=
 =?utf-8?B?Yi9mOEJHc2N5L1FWSC81RGdUU1hBUzF1YXIyK3Z6YkxGR0FPdGFLWUlRVTdh?=
 =?utf-8?B?MXF1WDBiMUV5SXRMOXE1KzVTeTBWWmUvWlZieldsbm9mblU1NkF2RUkzd0V0?=
 =?utf-8?B?L2ZOZkxMbk1wMmtoWlcrV1hhWEMyUTAvbFVrZ2p2NGRwSEQ5amIyd3BmSDhR?=
 =?utf-8?B?YXJXS3lFUVBNN3VMZ0dEM2ZKZWV1dHUrMzBsSVkyOFFsVURaOHMxS1JzbVZu?=
 =?utf-8?B?RlF5NGh3L1crbE1MeTN0NTdCRk5LU0VZMTdqMWtVcnYyRFg2L2ZIdEFIOGxz?=
 =?utf-8?B?ZG9DQVN1cFBKdUM3RjJZQVhUZVdTL2NDdldVTUtuZy9tWURhdStoUlByQWUx?=
 =?utf-8?B?aHdNbXpTUHZwUERlUG9NSkhwWkpONzZYTElPcHRRWHdTdi9iQS9GbStPenIr?=
 =?utf-8?B?blNMamJjM3gybE15TVV4Yjl6V3RHdEh3Z3hXWEFYZk5kb0FOZUVBSkpBaWx5?=
 =?utf-8?B?eEYyaWMvMEpJT2dUaCtvWlNXUGJINkVPcmJ6YVVmK2FiLzhIUnNtbStGZnlU?=
 =?utf-8?B?QXJUUUptcGVUWU90K2k5K3dObGFoUnVzN2Y0QXNPR0didHA4aUQvcGhwcnJJ?=
 =?utf-8?B?b2krY2VVWUhzeklzeVFjeC9veVRxeHJ4K3RNMHd0MHlXN1A2c3dDc0h2MXlQ?=
 =?utf-8?B?WWdzWVhiZ1dvV3hML0NmNFRaZnVSZ05NSm0wQU5QcDhwNUErRm1Ha2M1VVBO?=
 =?utf-8?B?Q1V1N3kyaXNXL2p6anFpZ2dDU04va2QvM3lJMmVORFVDbk5MSzQzdWY0U0RL?=
 =?utf-8?B?Q3dvc2xDZkV2MDFzQ3ViT25YUC9ib0thMDVLby9aN1NlNlhlS1doM241bUZn?=
 =?utf-8?B?ZU55dWhnclNPYUJZRXNGV1ZYOWJjOU0xN1pybnBCcVVCMnp1aytTdEFXQXEy?=
 =?utf-8?B?L1NhZmc2N2R3Y1ZsUitjdnpsTUROR1RWaVZLYWVCT2w4eU9CZFUybzNrZUJ3?=
 =?utf-8?B?cTFLbnRtMFJRVHJVaFIwOE9hUmpkVHZqRWtncjRqdUtEVDkvTWVqVkZwLy8y?=
 =?utf-8?B?cjZpSXBvR21TZXdYN2djV05QY0M1ajlsUXhQQTV6eTR3eXNORXE1OEg0OEdE?=
 =?utf-8?B?OFZMeXdFZkZ2TVV3TG5mMlNzbnpiQVJCaXBGeElmbDN1YTdHSUE5b1lMdUdw?=
 =?utf-8?B?UVdPNXI5ZXkzQkRlQWUxMHgrUlNNQzh2ZnJQMUJ6ZStzenZSK1VsRGFzOWth?=
 =?utf-8?B?bkp2WTFhM1AxMTQ0Zk0rMjk5UngzaTlEVCszcTh5MWxEOCt0VWpvNXBHNTVv?=
 =?utf-8?B?Y3pZZWlZeEVld01lZ09yN0VMNkd6Wm1SckJVL2VHWEF1QjF1NlRWNHFtYy9H?=
 =?utf-8?B?R05SNEZuczJoa3Q4Umh1Q1Q3NC9PT0V1WFMyRFpYd3JqRTNNZlBHak4wNHlT?=
 =?utf-8?B?cHUrbEZmamRheThFUlZUUFNpL1VxYkFReGxMLzd1VnJEb2VSTlJ4U0VNTURx?=
 =?utf-8?B?elQ0TjlCeHQwQUMxcTkyUXZ4UUpvUHM5ZHI2blQzbVo5MThrTGI3UXZhK3dE?=
 =?utf-8?B?KzZSbHFTZ0c1N0xUMUhXc2s4dVBPdWErRG9QMkcreWVnWEVrU3BCK3U2RTQz?=
 =?utf-8?B?NEpxbnVpSlc2aXJUYkNIWFpWWEVvQm5EQndiY1YraGFZYUg5NUVpTzRZRTFq?=
 =?utf-8?B?SldCWTRBWG9RVkdmZnBKUGJqL0J6d3dUUWdpMjRvVWh4a3NVK0RTVkhYbUl2?=
 =?utf-8?B?Vi9PcUNQMFFhbDZEM2JYZjNBOHE2R2tibHRwSlMwSXdSVHRCOUhWYnVDNjIr?=
 =?utf-8?B?dTY2eVZ1R1VrQVFBcU8yNk5RK2JocEo3SUsrMEE3R0g3dHgzM1VWckwrWVhz?=
 =?utf-8?B?cmxkbGw0NVJMbWE0NWZ6dUt1aTV2VVBZRDUyQWh2d3h4K29nL29VVnhsaElJ?=
 =?utf-8?B?YXBWZlVjcHFNbzBhN0xzNWNhdy9DUXNzcHE1OVVQWjY0Y3JvVkdsR0RybUxw?=
 =?utf-8?B?Wk82RjM0cHRaNkdjbitjRkg0UUZWVTFCUzFUd21tZDJPSTBzWUR2cTFHdlNj?=
 =?utf-8?B?QnZwSXY1cS9LUHZ3eDFBR1JWMzNlbmdjQ2MvVkVHRXdTb1FpOGF0Lzh0dHpW?=
 =?utf-8?B?Mnk1Y1E3bU85aDkxeE5uSi9vM0hQUFRGMkNUMko5Z0hVR3BWOTRxbmZvYURL?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edef0233-dbb5-4805-e369-08db18adafe1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 10:30:46.3376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hvsrb7GZF0lKp40U69KbrZnjGWUj77UGZ2HBR4gQIMULQsjXb90ubV/d261GhkpM0cD19ddpdracNDpZGq6DeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7242

On 27.02.23 10:45, Jan Kiszka wrote:
> On 27.02.23 08:27, C Smith wrote:
>> On Sun, Feb 26, 2023 at 10:54 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>
>>> On 27.02.23 02:26, C Smith wrote:
>>>> I am unable to compile xeno 3.2 after patching and booting kernel
>>>> 5.4.228 successfully.
>>>>
>>>> I had done: git checkout origin/stable/v3.2.x
>>>> Kernel is patched like this:
>>>> [root@host linux]# ../xenomai/scripts/prepare-kernel.sh --arch=x86_32
>>>> --ipipe=../ipipe-core-5.4.228-x86-12.patch
>>>> I am compiling xenomai for 32 bit apps, so maybe that is unique. Here
>>>> are the configure options:
>>>> ./configure --enable-smp --enable-registry --enable-debug=symbols
>>>> --enable-shared --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64"
>>>> LDFLAGS=-m32 host_alias=i686-linux
>>>>
>>>
>>> Not really:
>>> https://source.denx.de/Xenomai/xenomai-images/-/commit/ed48e736f4b3f96c73cb676f793f768a921d0624
>>>
>>> But we don't think have the registry enabled. Maybe worth to change that
>>> (debian/rules).
>>>
>>>> The failure I got is as follows:
>>>> ...Making all in regd
>>>> make[3]: Entering directory '/usr/src/xenomai-git-master/lib/copperplate/regd'
>>>>  CC       regd.o
>>>>  CC       fs-common.o
>>>>  CC       fs-cobalt.o
>>>>  CCLD     sysregd
>>>> ../../../lib/cobalt/.libs/libcobalt.so: undefined reference to
>>>> `cobalt_lookup_vdso'
>>>> collect2: error: ld returned 1 exit status
>>>>
>>>> I got the same problem when trying to compile 64 bit, with:
>>>> ./configure --enable-smp --enable-registry --enable-debug=symbols
>>>> --enable-shared
>>>> But I actually need to compile for a large suite of legacy 32 bit apps.
>>>>
>>>
>>> Can't reproduces. What is your build environment (compiler versions,
>>> host and target distro)? which revision of stable/v3.2.x are you
>>> building (though I'm not aware of any related changes)?
>>
>> I'm on RHEL8.5
>> gcc version 8.5.0 20210514 (Red Hat 8.5.0-4) (GCC)
>> I got the linux 5.4.228 from kernel.org
>>
>> I'm using the latest from the 3.2 stable branch this way:
>> I did a 'git pull' inside a git clone and got a bunch of deltas
>> I did:
>>   git checkout origin/stable/v3.2.x
>> This is what branch I'm on now:
>> [root@host xenomai-git-master]# git branch
>> * (HEAD detached at origin/stable/v3.2.x)
>>   master
>>
>> git log shows:
>> commit 62edc8a277d811bf35acea1784d561c45bf592c8 (HEAD, origin/stable/v3.2.x)
>> Author: Florian Bezdeka <florian.bezdeka@siemens.com>
>> Date:   Thu Feb 16 00:02:54 2023 +0100
>>     testsuite/smokey/sched-quota: Allow building with gcc 12
>> So thats the latest commit on this branch, right ?
>>
>>> Also check what happens to cobalt_lookup_vdso in libcobalt.so. In my
>>> side, readelf -a lists it. Check if lib/cobalt/parse_vdso.c is built and
>>> included in your case.
>>
>> parse_vdso.c didnt build into a .o file but I think it is linked into libcobalt
>> [root@host cobalt]# ls -l |grep vdso
>> -rw-r--r-- 1 root   sstorage  7240 Feb 25 23:56 parse_vdso.c
>> looking at Makefile.am:
>> libcobalt_la_SOURCES =          \
>>         attr.c                  \
>>         clock.c                 \
>>         cond.c                  \
>>         current.c               \
>>         init.c                  \
>>         internal.c              \
>>         mq.c                    \
>>         mutex.c                 \
>>         parse_vdso.c            \
>>         printf.c                \
>> ...
>>
>> [root@host xenomai-git-master]# readelf -a
>> ./lib/cobalt/.libs/libcobalt.so |grep vdso
>> 00024f88  00026306 R_386_GLOB_DAT    00025ac8   cobalt_vdso
>> 00024fa0  0001f306 R_386_GLOB_DAT    000255fc   __cobalt_vdso_gettime
>> 000254bc  00009707 R_386_JUMP_SLOT   00000000   cobalt_lookup_vdso
>>    151: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
>>    499: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_gettime
>>    611: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
>>    453: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
>>    507: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_gettime
>>    903: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
>>
>>>> I can send my kernel .config if you want it.
>>>
>>> The kernel config plays no role here.
>>> Jan
>>
>> Well, I untarred the xeno 3.2.1 package from xenomai.org and that
>> compiles fine, no errors - so that's good.
>>
>> But the git stable branch above won't compile - and I thought I needed
>> to be on that branch because I want Florian's latest compat patches.
>>
> 
> That's weird, given:
> 
> # git diff --stat v3.2.1..stable/v3.2.x lib/ configure.ac include/
>  include/boilerplate/atomic.h                      |  2 +-
>  include/boilerplate/debug.h                       |  3 ++-
>  include/boilerplate/libc.h                        |  4 ++--
>  include/cobalt/kernel/assert.h                    |  2 --
>  include/cobalt/kernel/dovetail/pipeline/clock.h   |  5 +----
>  include/cobalt/kernel/dovetail/pipeline/trace.h   | 26 ++++++-----------------
>  include/cobalt/kernel/rtdm/fd.h                   | 16 ++++++++++++++
>  include/cobalt/uapi/kernel/synch.h                |  4 ++--
>  include/copperplate/clockobj.h                    |  2 +-
>  include/rtdm/uapi/testing.h                       | 14 ++++++++++++
>  lib/cobalt/arch/x86/include/asm/xenomai/syscall.h |  6 +++---
>  lib/copperplate/threadobj.c                       | 11 ++++++++++
>  12 files changed, 59 insertions(+), 36 deletions(-)
> 
> Please test if a checkout of v3.2.1 is also unaffected, and then do some 
> bisecting. I'll see if I can find a RHEL 8.5-like container image 
> somewhere.

Tested in redhat/ubi8:8.6-990 (with fuse-libs/devel from centos, didn't
find it in the RHEL repos) and only with 64 bit (didn't find the i686
wrappers for gcc), but hat worked fine.

There must be something else different on your side to trigger this.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

