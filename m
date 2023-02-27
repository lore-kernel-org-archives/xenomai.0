Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26AD808
	for <xenomai@lists.linux.dev>; Mon, 27 Feb 2023 09:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kROwGtu53LqhcDsSJaUmjCldTcu/6h9U5Ajhs9oHHmbgW09HTQHyZZUghgnNakTZdlTQ3KVYQVPD5OvndeiVvGQWNSH4t0swqyX1A7OKvi+SeeDBh+NVQFqmyvhX0XVHP7GeDIu0f9wWbJKS09BSLsrDHTBGnKD2j64KkRruu+Ix2UFaEvr0rM4LqxSyl03w5Ooep+JhqplidXtFaHSqcA280CI30kkbpJqCbGiar5ScWOyeH+99xYMjQ3uUZ84aBSXA2eOyh5L+fhtpuoacIV3Nb5bPMgUYfany0hgaCDk+b4gkvyZ8M0u+E4aZfqKld/JWs41zHJpz+8d3L0UyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzgewW5ZixnlBERe2QVZsVCbp0WdKuslHZfN3PwEusI=;
 b=Ta1oIdKNFfsh2qPgqiRzb6a5YhDGVc5mfUIQVnrnfa9WPORrh00vRt60n2jy/lNCm81Ahk/nC0pe0A9X8WBdwTr+SQ523wIoBjp2SCgZMbR5qSKldcCO76O5o3u8+OCfnqMMss/xObIAJzAaYGkT7RdLqiSNpSaiHtlGlBL1zcFQE0TNeqNnIUj4OrNR+wlkTZQ2woRdTeEPj9cY0i6D61hKEpNKper032twA4TXNVcgjzP8PpvsO3C1oGXAFId6GYXg6gICHLsUrsqBEZad921HmeJxahmBeJBOz7tTOVFZlv5qrV1vOT/QuX4r3LG3gtJGYI0m0n/ws+uqHlUQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzgewW5ZixnlBERe2QVZsVCbp0WdKuslHZfN3PwEusI=;
 b=CZA6SYxUIe57nHkiaTSb7I2PXsOnqU2RTPnA6ocb8OcD8T+gUpQreKZjjDjj4G6JDc1xwBFIdr3Hyit2bu3/Jjui+UgKSBlbEpHOdi/FpJKZPvQN5nKX/xJDM4HqJy8gEXI5FRrSR5oJq5WHWTTiaOApnKJbLRTWYNbZZPqFnokMuPVxrVK/uCDtK/svqt3LRbammyxcFCGpc8xapJBC5U6LuAzyiaz5Qudz0IJ6xqDaW3FGmZrKlfnBMUlHYQWyhrGTw8K4dcifQB0TviDgytj7OoCxKkmI3BQUfZgWJqUcCR4BZaunMGuSuNvDtGbN4692NSAMagMtGFis0+V4mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6398.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:556::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 09:45:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 09:45:37 +0000
Message-ID: <0dea24a1-0943-d9ed-1f9f-c535e5a526ba@siemens.com>
Date: Mon, 27 Feb 2023 10:45:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: xenomai 3.2 compile failure : cobalt_lookup_vdso
Content-Language: en-US
To: C Smith <csmithquestions@gmail.com>
Cc: xenomai@lists.linux.dev
References: <CA+K1mPGxOi=GFfDbE+nq99HsMWEe0+Q37bw=X=UHjqb-yNfj9A@mail.gmail.com>
 <39ce5d58-ddcf-de33-32fb-eda57a5d128b@siemens.com>
 <CA+K1mPF8G3c0V4Y7co=y9SGdjTy_R_d9Up=9bj7c6Nz2XEXp-g@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CA+K1mPF8G3c0V4Y7co=y9SGdjTy_R_d9Up=9bj7c6Nz2XEXp-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: c119b3bf-3bba-49a4-bdc5-08db18a760f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tOy4gWhouKh3RtWT1KXjFwHXclIHdEWKPsOleFgAdyME2agsqDVlPwiRuxf+CZ3fbTuz30seyoqhTJLPS2vPJNwTEZJrlTMsYBpYuKdlfyDoIEfTcmvJwk3KjT2eR8hwKWCyPNyKbU8w8zsIbxd87BGK2BDKpZL8B10EiLoAG+7A5LjUCAp44mi9z5z7W49kE+V/Ruko5kdrRFy7Rt7ZrW2Sia3uBeJpuK8JzS0kxMFtwZdJfrNwYLQTNXvAG/EHJSbXm8PIILNKEmgizgoGUojTWWQCnMfWNPfX0mOqmyftGj80G4g+8Ge1IW5e6n0psBF/rDNGodBjems8/qxlbc3CTAac9YMry+l2jo2FVgMoiaIF2JC1JCaLsVHGmopDLa1ynM8gJnGoPucSFIHfk5kxXMEF94+pKgGz9nqtdTywpkniQIQSu+uIF8pj4Rz4PDJc5e6sYV6qyBjagSE9cjjnMQfUzeDVGYiYfHmmWNT1x/K5rdptWJnVM/oYUMf4G4wACY6zNjpqMI/5WwC2xA2AJhZef6TZZLGD9fXU8GqfhLOLceC6DatHB5MMfw6TA5QGdcCA8ZVYphfXd42QBZ7AUrIFi9daka0CAm0hmufo9R0GjRogY40+2rQpYmWvmqIW0+ru9J+ImsqwY4K6u7G1wwJ/SX4rhbm9sTlZihY11JyLP52KDudz9bTyK3f1k3F1gKLZTMKuAheJK486Zfv1uI+P/hYNJqb0RETeUX0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199018)(38100700002)(2906002)(82960400001)(31686004)(44832011)(5660300002)(83380400001)(8936002)(2616005)(66946007)(316002)(966005)(6486002)(86362001)(66476007)(66556008)(6512007)(6506007)(6916009)(53546011)(26005)(4326008)(186003)(478600001)(36756003)(6666004)(31696002)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnBwd2hiZ1BCVFBUTThrbENsdVRUNUlQTHpueEE5TmNNNm9YOXBkSE0xbkEx?=
 =?utf-8?B?UWdEY0s1VTA0eXorSDQzMVV0NU5OWEZkc25iSldFSFVZZEtZSGtMcERISHRz?=
 =?utf-8?B?cC9mVndaQkx3cG54WTZyVHlvcWU5Q3JnMEtQRC9xNStBakFyaEI0eDBuNzZ6?=
 =?utf-8?B?a3BzbkRBVDVtaTVkREpnRkdyRHhKUmRvR0NmTHZkOGtCTngzOE9nQVdnQWtB?=
 =?utf-8?B?c1grU05DVkovck5pK1U1VVJwTC9EY1J0eHZkaWZTZlZzbWpxeWlJNVJsdmhO?=
 =?utf-8?B?Y2ZGSUQrdWdQeXMvR05hUER4RGoxb3R1bTN5SzY3SkVwYXNGK3hKQVJPK252?=
 =?utf-8?B?eHYrT3R3R05yRzQvWmNkNVdsUXpFOGs1V3BRZEdLNXM2aTd5dEJtSzFob0M3?=
 =?utf-8?B?ZzM4N0U4YWtzQ3hUNWRzYXM5emhzS3RiY2xnNzFzY3lyTWQ2ekozZmtzRGcy?=
 =?utf-8?B?V1IxeXFIZkRza1Q4WTNBdUVJR0lzanh0a2dJd21MUGp1Vm4wc3doZFZNSXZJ?=
 =?utf-8?B?b0E1UDQyV3JMSHNmb2pUNElJSzNPMVVpK3N4aWdYS1hXdWEzSWQva1dzdVdH?=
 =?utf-8?B?eGtNL3RZbExOd3BvN0JEV0VQYk5ScloyYWNoUHdyTGdOd0xGTFJDOUtxK3J5?=
 =?utf-8?B?TFlqR3BuRjV5Z040SFFwQkdtQTBCQUh4ODc1T25MNjBETjVBZVVWOTRrUnRB?=
 =?utf-8?B?VzVSWWNpeFE1VHY3QW9EeS9rNEVJRnlmdUVjTXJneURRRW5kanJiYnM3VnFN?=
 =?utf-8?B?VURHRlJFNStRcWZZVng2YmZxQkdUa0VOWVJOK01OUUV3TDdLOW56TkFHMEFi?=
 =?utf-8?B?TUN3aGh0ZTBMektUMlFDcmNWTUlkU1V6aE5ET0Y1MnY0UTZseWhSMUZVbGdH?=
 =?utf-8?B?THM0SWhDbEhScDZSOEVVbmd5bTVRZEZsN2FmbzhsSGxBM1lvOUx6Z1l2aWx1?=
 =?utf-8?B?cDVod1plSHlSdjBYU1QvUUdtbXExVTFIc3EyMDhQcnRKbFM4K0JWZVp5eFZn?=
 =?utf-8?B?V3hUdzJDSkJ3SzlsSEYxKzVqZExQTHoxNm9pTWF3cFZ0VTlKaGI1RWVPT1Er?=
 =?utf-8?B?cHVhTzRoUkp4UWFuWmQ1VysyV20yV2NTSktPTGs2SWxmMERlTkhJb1o2M0ZP?=
 =?utf-8?B?MFltN0RMNHBRVENxZHFPUU9EbXlmS1RVakVicTVPWTJReTJaSnVaYUZLSzN1?=
 =?utf-8?B?UFhIbWp5NFBPQnkrYThNb21ZUGR2U1I5V2dVa2tOaFAvV21PNG85WlBCemJS?=
 =?utf-8?B?TXVScUYrc3F4eXU1QWVkZTdSWCt0cnh5a1RIQ2R4WkVRUkJ0UnJHZHRHRkZl?=
 =?utf-8?B?aFlmUTRHM2M2L2VWU2lNWTg4Q2gvQmMxTzRoVEFmdXU5ak9SMCt6YjF4bVF1?=
 =?utf-8?B?Qit5SzNSSkZlakFtRVhnWlZyTnlyVlpRSmI3RlhvdHVocnBVbTg4cmhxNHpD?=
 =?utf-8?B?dmlCM2ZZdmRTRXRRZy9tTFFhY1Jtei9NMnpJeGwzSUtORnFKZ3NmS1krLzd6?=
 =?utf-8?B?bGpsK1JBTkZodWFjR2RROG5OVmUrUDRIQm9RYUd2U2UwRVE1eFVscHY3T3hi?=
 =?utf-8?B?d0RCZVlYVSsvTVRDMGhLWllKUnVhVlZWakw4Z3V3NFBYbkVuV1libGNhZFpX?=
 =?utf-8?B?YUxGMHErZGhGblVqTk1tdzR3dHBDMVlwK1JnamZodzFDY2ZTbldtVWV2dGla?=
 =?utf-8?B?aEd0b2Ixc2lnSVArOVpCMnNiZzFZSC9wd0RBMXc0WnVHWmd4N3Q3RDE1THR1?=
 =?utf-8?B?VGk4ZHZqRitnYVA2d3VldXhzUmJwYkRSV080WEtwckVPOXg1TlpuaE9HOHZa?=
 =?utf-8?B?UXkwMXQ3dVJFWlkwS1NxbmkreXdBUERzTUwwYjAxN3hWQkUwSGtQUHQ1YzV4?=
 =?utf-8?B?NjU3b3lTaXFaREdZL2pRV0w2bVlLb3k3dERyNjVyTUJnUktZcU9ZYlFjcGxv?=
 =?utf-8?B?LzdTcFhUY054eW1TYjIyN0FGcjdNQ2c3RmZIYlhLZjRqMGViaUpEM3B2S3li?=
 =?utf-8?B?amtaWHBicWI5Y2I4bGdkY3E1UTJXU2ZWU1ZEWkYyNkF6eDhyUTlhd3p4WnF1?=
 =?utf-8?B?Ym9CQ3BPVFkyd2FRSlgvMWdGYW9iZm45UXFSdHl0NjEzR2ZzaFdyWTFUbExT?=
 =?utf-8?B?eWp2MWRvK0VmNDhDVThDb1BxNE8raHNGUVdnWFFTWTd3YkpGam1Vb3VueHR6?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c119b3bf-3bba-49a4-bdc5-08db18a760f3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 09:45:36.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKYFpGVNfgpWlvZpGvaDRkiOoj4BuppmdElqMFe1BIOFjbxrbwOPtdLIW7sLZ3sP4dsqMtu0ljusZhs73K2RTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6398

On 27.02.23 08:27, C Smith wrote:
> On Sun, Feb 26, 2023 at 10:54 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 27.02.23 02:26, C Smith wrote:
>>> I am unable to compile xeno 3.2 after patching and booting kernel
>>> 5.4.228 successfully.
>>>
>>> I had done: git checkout origin/stable/v3.2.x
>>> Kernel is patched like this:
>>> [root@host linux]# ../xenomai/scripts/prepare-kernel.sh --arch=x86_32
>>> --ipipe=../ipipe-core-5.4.228-x86-12.patch
>>> I am compiling xenomai for 32 bit apps, so maybe that is unique. Here
>>> are the configure options:
>>> ./configure --enable-smp --enable-registry --enable-debug=symbols
>>> --enable-shared --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64"
>>> LDFLAGS=-m32 host_alias=i686-linux
>>>
>>
>> Not really:
>> https://source.denx.de/Xenomai/xenomai-images/-/commit/ed48e736f4b3f96c73cb676f793f768a921d0624
>>
>> But we don't think have the registry enabled. Maybe worth to change that
>> (debian/rules).
>>
>>> The failure I got is as follows:
>>> ...Making all in regd
>>> make[3]: Entering directory '/usr/src/xenomai-git-master/lib/copperplate/regd'
>>>  CC       regd.o
>>>  CC       fs-common.o
>>>  CC       fs-cobalt.o
>>>  CCLD     sysregd
>>> ../../../lib/cobalt/.libs/libcobalt.so: undefined reference to
>>> `cobalt_lookup_vdso'
>>> collect2: error: ld returned 1 exit status
>>>
>>> I got the same problem when trying to compile 64 bit, with:
>>> ./configure --enable-smp --enable-registry --enable-debug=symbols
>>> --enable-shared
>>> But I actually need to compile for a large suite of legacy 32 bit apps.
>>>
>>
>> Can't reproduces. What is your build environment (compiler versions,
>> host and target distro)? which revision of stable/v3.2.x are you
>> building (though I'm not aware of any related changes)?
> 
> I'm on RHEL8.5
> gcc version 8.5.0 20210514 (Red Hat 8.5.0-4) (GCC)
> I got the linux 5.4.228 from kernel.org
> 
> I'm using the latest from the 3.2 stable branch this way:
> I did a 'git pull' inside a git clone and got a bunch of deltas
> I did:
>   git checkout origin/stable/v3.2.x
> This is what branch I'm on now:
> [root@host xenomai-git-master]# git branch
> * (HEAD detached at origin/stable/v3.2.x)
>   master
> 
> git log shows:
> commit 62edc8a277d811bf35acea1784d561c45bf592c8 (HEAD, origin/stable/v3.2.x)
> Author: Florian Bezdeka <florian.bezdeka@siemens.com>
> Date:   Thu Feb 16 00:02:54 2023 +0100
>     testsuite/smokey/sched-quota: Allow building with gcc 12
> So thats the latest commit on this branch, right ?
> 
>> Also check what happens to cobalt_lookup_vdso in libcobalt.so. In my
>> side, readelf -a lists it. Check if lib/cobalt/parse_vdso.c is built and
>> included in your case.
> 
> parse_vdso.c didnt build into a .o file but I think it is linked into libcobalt
> [root@host cobalt]# ls -l |grep vdso
> -rw-r--r-- 1 root   sstorage  7240 Feb 25 23:56 parse_vdso.c
> looking at Makefile.am:
> libcobalt_la_SOURCES =          \
>         attr.c                  \
>         clock.c                 \
>         cond.c                  \
>         current.c               \
>         init.c                  \
>         internal.c              \
>         mq.c                    \
>         mutex.c                 \
>         parse_vdso.c            \
>         printf.c                \
> ...
> 
> [root@host xenomai-git-master]# readelf -a
> ./lib/cobalt/.libs/libcobalt.so |grep vdso
> 00024f88  00026306 R_386_GLOB_DAT    00025ac8   cobalt_vdso
> 00024fa0  0001f306 R_386_GLOB_DAT    000255fc   __cobalt_vdso_gettime
> 000254bc  00009707 R_386_JUMP_SLOT   00000000   cobalt_lookup_vdso
>    151: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
>    499: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_gettime
>    611: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
>    453: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
>    507: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_gettime
>    903: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
> 
>>> I can send my kernel .config if you want it.
>>
>> The kernel config plays no role here.
>> Jan
> 
> Well, I untarred the xeno 3.2.1 package from xenomai.org and that
> compiles fine, no errors - so that's good.
> 
> But the git stable branch above won't compile - and I thought I needed
> to be on that branch because I want Florian's latest compat patches.
> 

That's weird, given:

# git diff --stat v3.2.1..stable/v3.2.x lib/ configure.ac include/
 include/boilerplate/atomic.h                      |  2 +-
 include/boilerplate/debug.h                       |  3 ++-
 include/boilerplate/libc.h                        |  4 ++--
 include/cobalt/kernel/assert.h                    |  2 --
 include/cobalt/kernel/dovetail/pipeline/clock.h   |  5 +----
 include/cobalt/kernel/dovetail/pipeline/trace.h   | 26 ++++++-----------------
 include/cobalt/kernel/rtdm/fd.h                   | 16 ++++++++++++++
 include/cobalt/uapi/kernel/synch.h                |  4 ++--
 include/copperplate/clockobj.h                    |  2 +-
 include/rtdm/uapi/testing.h                       | 14 ++++++++++++
 lib/cobalt/arch/x86/include/asm/xenomai/syscall.h |  6 +++---
 lib/copperplate/threadobj.c                       | 11 ++++++++++
 12 files changed, 59 insertions(+), 36 deletions(-)

Please test if a checkout of v3.2.1 is also unaffected, and then do some 
bisecting. I'll see if I can find a RHEL 8.5-like container image 
somewhere.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

