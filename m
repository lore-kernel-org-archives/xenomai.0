Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8511E7EF
	for <xenomai@lists.linux.dev>; Tue, 28 Feb 2023 05:11:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBXCyC1BRwhzizKpvOzWBgVMucGF9qA2fQm9CH+WbYfci43eriV9tn/dfFWuAgQEpDFPwn/YfMUEGz3VhbYUuA/mjXRMumdegcKLsXZPKZ+pz74VhBZI2AExQH4X2007scytdUXj4DD/Rj3wAwp+59V8iAiZKGwIQtDyCufLmDOvjAyfpHTFex6MEnhYqfVqrE6ShosZb+NyQf95Q+kQYaNnDRX4DqxVB4CrdrS4VaC5gEW3Pv1eSEYtnLdBrxaJmYhSQzco1GHjCoERGhIDi84VrefqFx4Y+QAYM6u9zyrtRs33Gdsjqiwu89QLHS6QEGjuJuQQapZnTfFjXhhwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHRB/H5N2kr1JGAf/14WNuC053Z6IA+znSGCUrvSwKM=;
 b=ntUSIUkI6YtJTqa5wciEVgCP/j3STQwizeaDtoN1vOhLiQB6ApAon8+2FXIVvBT0Tbmpwl1dNmUIBVWmuUmKoTv5u9n9ApB+vdruxcjSYL0e2M/bg8O8l/kpdDVw+02PDYHQHBinrjMqevlC+s66gemwyYY7UJchBMcUNJpY8/AYP72c1AH65zbB3ADDz8JyuBkY2HJ5ZUpF0O8S2qQdUc/SG9QyjFN+JRuZKg/SvGWBBsmfbp+WKNVvMjz67yObjunmRS9vf8epvZifKchPkzhf8MWp5H0k2bXm2GWFheJGCg0kRoQHc9lK78rIXPYztPAKn16nIctDReYBflkDMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHRB/H5N2kr1JGAf/14WNuC053Z6IA+znSGCUrvSwKM=;
 b=wKjXcln813q9kJvUReediX1QAVSNpdkqjN1LMq1RmhUYap7flqtx/9LINZOhrjN4yRqOcP3A6z02Nkv2qLlgG+ZPUhJ16gBjWcByYj5FpiTZ0NugkI1eIrO6QqFBqmY9wWGd86KtI6p6mWk/Pt14EQJEx0nHLyQrW9bUKfiLNfm4+zw511MlHg07zl0SR/L5HpgnpR2PfaLTLbHxEXvhK4/ra97XEoZi5HmnTpH1C4eEPGsAWTDQcJlOuBgk2r8QMkorYckVXyPqJRkMWlg2EK7O8tWiDYHW6ne0Kc9oamSyNvbyKjes3ztluDA14BaliT2yTWg0KEVv0WeHMTbF0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 05:11:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 05:11:11 +0000
Message-ID: <58bb082d-fb06-c69f-8b67-3e9a045f0a3f@siemens.com>
Date: Tue, 28 Feb 2023 06:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: xenomai 3.2 compile failure : cobalt_lookup_vdso
Content-Language: en-US
To: C Smith <csmithquestions@gmail.com>
Cc: xenomai@lists.linux.dev
References: <CA+K1mPGxOi=GFfDbE+nq99HsMWEe0+Q37bw=X=UHjqb-yNfj9A@mail.gmail.com>
 <39ce5d58-ddcf-de33-32fb-eda57a5d128b@siemens.com>
 <CA+K1mPF8G3c0V4Y7co=y9SGdjTy_R_d9Up=9bj7c6Nz2XEXp-g@mail.gmail.com>
 <0dea24a1-0943-d9ed-1f9f-c535e5a526ba@siemens.com>
 <d58eb804-dcbf-5fe2-182b-878b4fd987c3@siemens.com>
 <CA+K1mPGGw1iJaCh_L0hRVNFcw-J4O8L-V2wMybnTZQh5EjqNMQ@mail.gmail.com>
 <8fb9cff1-7ef4-715d-0db6-3b15ffa728b1@siemens.com>
 <CA+K1mPFkq-JD_+M8JzCEp+n5aPjgWGu2D6h9uZc=UNd8q6uqHQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CA+K1mPFkq-JD_+M8JzCEp+n5aPjgWGu2D6h9uZc=UNd8q6uqHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 0286260d-42ab-4ce8-72a3-08db194a355a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uAfWOfIw8dgBqHqY9k/WvG5hf+4Mi0yqdA1/V50SX/exYmI5HPRd2MOZe9TSlNShGeyo2pPYXZv95k+XcQ3gZjy/Og7XiN7ZWYPoyoX6vPHpwmrVKzDxaptxz8VQmioZ3qIfRHvJEezedHBHvLyHWzn/4wJyWHkpx1FacE5h7+aiXQYw5qWFlSM/4dsQrD/Bi3MI9IVImvxBouHwb0U/VuO28k3hjUNU/pwUi2X3k+karh8Jbk/mJGy4iQR7ZsaYM87KdlUFGhTBz7AhZosLflzr88fziVfcjpKTtp1kM+kQUTrCAJhVvmqP6oBrHPaigErMbB+Q+GlPzfaL3YzQrz1XCK+9gEsCLPKi1791LdqLhUlTpA8i5en/7g0Gwnqhm4g0o+/pKnEV8C1B7zmqo9vf/WSC0/1fpLRaWCQnhXW8GiJMGSYiEemNZecrLY7zHfEgjePiWFnsIboVUsKP7sFtqCRqHOz3jJ2lZceVMBnDvvZa5DsDdXVJb9Ue6WW4dh4TWCQa8RF5V+aG+/IlNFL603uSyHRzl/kuO6mgKh955w/1mGGw6rmv/tI1705GUfZ/gtmzBlex95HJXS0HeBDIgWwkNy3vRq3QvICVXyKUn+EONKmfB7WZEM/jTUFN8EYsGs2NM10w2fcGs+wSS089wIRHengqrVexKcQ+9oCbbxv7pOwq1/p1fBLjOfsuZzDoPSYcJDYy+XUMWjy2j8vLMPaQVxKTznw4uOeBs2E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(316002)(82960400001)(66476007)(2906002)(31686004)(31696002)(44832011)(5660300002)(36756003)(86362001)(8936002)(53546011)(6512007)(66946007)(186003)(26005)(8676002)(4326008)(66556008)(38100700002)(6916009)(41300700001)(6506007)(2616005)(478600001)(83380400001)(966005)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVpSSDRrdVJlMVBocElSUHJSZEMrakZaTVpzT2lpMStZK0czTlZQZTJPcDd6?=
 =?utf-8?B?TUtqTmlZWWMxUmt0ZDVSUi9oWWUyWkRYY1FsS1hlRkNDb1lzeXp6bDh1c01C?=
 =?utf-8?B?Nk12eGhOWWhMazBQMERSeUZSKzhuMm1GeVhKWS9pQnpWa1ZsQVFPZGlhbUIx?=
 =?utf-8?B?V1p1N3pHRDJmSk5JS253Mm5iVWJUK2NaOTJIc1pIbm5lcStMNGFQaW80cngw?=
 =?utf-8?B?REhtQjFlYXp5NTc3c1F2b0FzNGVMeVZLUFdZSkxmVC80ZGx2dGhPTkN5ci9a?=
 =?utf-8?B?TkFoZjd1OGVSOWVabFdHdDcydFkvWHU5a3RVT284ZFlUVGR1UFJ6bmZjaEdW?=
 =?utf-8?B?ZE9aeXNLaGt3dlVCMVBFRW1CZGh2N1lUTXZROFdjSEVCVWNxRllGdHM1WTk0?=
 =?utf-8?B?akNuUTcxTEJocFNKd1AyNE01SVh5YTh6THJKY09EaUwyOTVLOWJoZTR0cEZr?=
 =?utf-8?B?Z1ZwaUY2TktFTFVkck1OY0ZWMERPdjJ6QzVpdmtVL0g4dm8vbHhMSGlURzZH?=
 =?utf-8?B?NUxLVW5CYkRIWjZnWUIvSTNibDA4NmtRU1FsN1pLNXVWT0c2bVVjeE01MmJw?=
 =?utf-8?B?U1FwTlpRc3FwWGlJN3dOWEJCVWoycHdqcjZZR2szWlJJSHExWXhpU0tNUExn?=
 =?utf-8?B?cUdxU3RPQ2N1RE82TWxNUHdibWx3MkxqVGNMZFRzblppb2ZlZ0ROQ0ZZUGxD?=
 =?utf-8?B?a0xzNjc5SXoyNWIrbHZnSkgzZ3VWZjAweEIxbFovNERjczdVczY4MkYwc2Nt?=
 =?utf-8?B?cTAzK0UvbkJ6VmttZEdLK3RsckdkV3RFaXk5QVc0bG9ZcXBEUUM1TWphbVh0?=
 =?utf-8?B?Mm1kaGFwQm9BUUlPMFVRZGIyK3VtbWxsRDhvbTlRSy9ta2dXeDB4UndtdFZZ?=
 =?utf-8?B?RCs4NXlkK2VFWlpLRWlnWmN5ampndmYxWGdYeWMyT0FobDVVVDdKM0Fxd0RG?=
 =?utf-8?B?VVVEUE5PVVhsQUdnRDI4T21KUytML2F3dGhzZnhJK1laMnpyRVk1NStlaHRC?=
 =?utf-8?B?U3VwS0o0MSsyWXlEQTY5T1FRQitzT2c0azJNdEhwQ0F5WEdCa09mUDhObzFj?=
 =?utf-8?B?dG8yNExxMzAza0JBNWkvYU5JOGRQZHZTTmQySFhod3JWK2IzTEd2d1YwOXBP?=
 =?utf-8?B?V0JaV1Z4YkUrdVhibEZjQ3NDZmRUVDZvZjNYUUVNQWVYaEwvL3RhclowVVZC?=
 =?utf-8?B?TUJTY0RzMkJSNEFtcDNYeFhRN3NzeXlxb2FRRmlmUUVBZEVISTc4WnFSZ2Nq?=
 =?utf-8?B?alI0WEpPT213ZzdtSWU0VXhWT0dBNXFaUGlqVUZZS1YwTFBGbGpGOHRvMVhE?=
 =?utf-8?B?VXhBQ2VEMDBrc0NaTGxnVTVrWkpVNU4xMUFQQ0pvK3djQUdJVDQrVWFlM1Fj?=
 =?utf-8?B?OFR2TDd5N3ltS0NHbCtNMFVZVWZYTFJXc0NvcWtKajdNUE5Ib0hoTlJOOFBl?=
 =?utf-8?B?M1J1THFObnJtS1JrQklRYlEvclh2dEZKQVA1TFpKa2NSTGExaDA4QVh6Q2th?=
 =?utf-8?B?dDdkdFpBM3U4VThrb0JJM0xjV1JGMHhyYTJMVG85Y1FFM0dZRytpRnJOMjdI?=
 =?utf-8?B?WmZKUWduMFFWcXo1M3VSekh6dFRrbHpSOU5EZklpNXd3bUw0bDhLWDBuUkJO?=
 =?utf-8?B?RHo0c0JjSy93MmRpeEdudkQ2aUh0bEFXOU9rUnpVQlRiQk5YVFFySnRYUFdH?=
 =?utf-8?B?S0lpanpvODZDWXRGR25ZS0xCU0xXRFYrajBJZVRsdU9wcDduUzM3QytsWGxl?=
 =?utf-8?B?WTRsV3Q0R0YvaCtwYUZJemxxZnU0V3RTWFMzZElMYlNjRjRYVW5qemx3bnNn?=
 =?utf-8?B?dmIxQ2tvYVZzbllNa1ZYOUFYd3N5TmNQSDJ4S2U2RC9PV2kySTZodmZObUd0?=
 =?utf-8?B?QlhpNTJTaTJ6ZkJyWkNlV0JvaGs4ZUlBZnpxRGFaQjVaVER4azBnR0E1WEhT?=
 =?utf-8?B?YW1OVTkxWC9VaDFnY2VoQ0QxV1RkNXlTT2kzSC96TzJ4dS9BbkhRbStuSTVQ?=
 =?utf-8?B?ZllnTzhIR3gvaVZsU0ZWeUdLd3NxQkxLMzg1czRGcEFSQTlXMGtjTG9HZnVq?=
 =?utf-8?B?cG5nQkZMd0tKMVpnZitEVGtUQ0ViSWxSd0s2VFBRdDBWbThMRkQ1ZnVVVjVK?=
 =?utf-8?B?N3R5LzVRcjB5K0VibmREUUlpTFA4c0NObE5oOStEUXlnVFRzRGxVWjgycU4r?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0286260d-42ab-4ce8-72a3-08db194a355a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 05:11:11.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uO4IPtln2Ft8CWIS22N/SMT1XXbMSkPPuHYmm4uTV5N+Oj5T6Wzc4vlCikmJISvPaFktJnHREraAT7oCquDvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6084

On 27.02.23 20:54, C Smith wrote:
> On Mon, Feb 27, 2023 at 10:21 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 27.02.23 19:02, C Smith wrote:
>>> On Mon, Feb 27, 2023 at 2:30 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 27.02.23 10:45, Jan Kiszka wrote:
>>>>> On 27.02.23 08:27, C Smith wrote:
>>>>>> On Sun, Feb 26, 2023 at 10:54 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>>
>>>>>>> On 27.02.23 02:26, C Smith wrote:
>>>>>>>> I am unable to compile xeno 3.2 after patching and booting kernel
>>>>>>>> 5.4.228 successfully.
>>>>>>>>
>>>>>>>> I had done: git checkout origin/stable/v3.2.x
>>>>>>>> Kernel is patched like this:
>>>>>>>> [root@host linux]# ../xenomai/scripts/prepare-kernel.sh --arch=x86_32
>>>>>>>> --ipipe=../ipipe-core-5.4.228-x86-12.patch
>>>>>>>> I am compiling xenomai for 32 bit apps, so maybe that is unique. Here
>>>>>>>> are the configure options:
>>>>>>>> ./configure --enable-smp --enable-registry --enable-debug=symbols
>>>>>>>> --enable-shared --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64"
>>>>>>>> LDFLAGS=-m32 host_alias=i686-linux
>>>>>>>>
>>>>>>>
>>>>>>> Not really:
>>>>>>> https://source.denx.de/Xenomai/xenomai-images/-/commit/ed48e736f4b3f96c73cb676f793f768a921d0624
>>>>>>>
>>>>>>> But we don't think have the registry enabled. Maybe worth to change that
>>>>>>> (debian/rules).
>>>>>>>
>>>>>>>> The failure I got is as follows:
>>>>>>>> ...Making all in regd
>>>>>>>> make[3]: Entering directory '/usr/src/xenomai-git-master/lib/copperplate/regd'
>>>>>>>>  CC       regd.o
>>>>>>>>  CC       fs-common.o
>>>>>>>>  CC       fs-cobalt.o
>>>>>>>>  CCLD     sysregd
>>>>>>>> ../../../lib/cobalt/.libs/libcobalt.so: undefined reference to
>>>>>>>> `cobalt_lookup_vdso'
>>>>>>>> collect2: error: ld returned 1 exit status
>>>>>>>>
>>>>>>>> I got the same problem when trying to compile 64 bit, with:
>>>>>>>> ./configure --enable-smp --enable-registry --enable-debug=symbols
>>>>>>>> --enable-shared
>>>>>>>> But I actually need to compile for a large suite of legacy 32 bit apps.
>>>>>>>>
>>>>>>>
>>>>>>> Can't reproduces. What is your build environment (compiler versions,
>>>>>>> host and target distro)? which revision of stable/v3.2.x are you
>>>>>>> building (though I'm not aware of any related changes)?
>>>>>>
>>>>>> I'm on RHEL8.5
>>>>>> gcc version 8.5.0 20210514 (Red Hat 8.5.0-4) (GCC)
>>>>>> I got the linux 5.4.228 from kernel.org
>>>>>>
>>>>>> I'm using the latest from the 3.2 stable branch this way:
>>>>>> I did a 'git pull' inside a git clone and got a bunch of deltas
>>>>>> I did:
>>>>>>   git checkout origin/stable/v3.2.x
>>>>>> This is what branch I'm on now:
>>>>>> [root@host xenomai-git-master]# git branch
>>>>>> * (HEAD detached at origin/stable/v3.2.x)
>>>>>>   master
>>>>>>
>>>>>> git log shows:
>>>>>> commit 62edc8a277d811bf35acea1784d561c45bf592c8 (HEAD, origin/stable/v3.2.x)
>>>>>> Author: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>> Date:   Thu Feb 16 00:02:54 2023 +0100
>>>>>>     testsuite/smokey/sched-quota: Allow building with gcc 12
>>>>>> So thats the latest commit on this branch, right ?
>>>>>>
>>>>>>> Also check what happens to cobalt_lookup_vdso in libcobalt.so. In my
>>>>>>> side, readelf -a lists it. Check if lib/cobalt/parse_vdso.c is built and
>>>>>>> included in your case.
>>>>>>
>>>>>> parse_vdso.c didnt build into a .o file but I think it is linked into libcobalt
>>>>>> [root@host cobalt]# ls -l |grep vdso
>>>>>> -rw-r--r-- 1 root   sstorage  7240 Feb 25 23:56 parse_vdso.c
>>>>>> looking at Makefile.am:
>>>>>> libcobalt_la_SOURCES =          \
>>>>>>         attr.c                  \
>>>>>>         clock.c                 \
>>>>>>         cond.c                  \
>>>>>>         current.c               \
>>>>>>         init.c                  \
>>>>>>         internal.c              \
>>>>>>         mq.c                    \
>>>>>>         mutex.c                 \
>>>>>>         parse_vdso.c            \
>>>>>>         printf.c                \
>>>>>> ...
>>>>>>
>>>>>> [root@host xenomai-git-master]# readelf -a
>>>>>> ./lib/cobalt/.libs/libcobalt.so |grep vdso
>>>>>> 00024f88  00026306 R_386_GLOB_DAT    00025ac8   cobalt_vdso
>>>>>> 00024fa0  0001f306 R_386_GLOB_DAT    000255fc   __cobalt_vdso_gettime
>>>>>> 000254bc  00009707 R_386_JUMP_SLOT   00000000   cobalt_lookup_vdso
>>>>>>    151: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
>>>>>>    499: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_gettime
>>>>>>    611: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
>>>>>>    453: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
>>>>>>    507: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_gettime
>>>>>>    903: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
>>>>>>
>>>>>>>> I can send my kernel .config if you want it.
>>>>>>>
>>>>>>> The kernel config plays no role here.
>>>>>>> Jan
>>>>>>
>>>>>> Well, I untarred the xeno 3.2.1 package from xenomai.org and that
>>>>>> compiles fine, no errors - so that's good.
>>>>>>
>>>>>> But the git stable branch above won't compile - and I thought I needed
>>>>>> to be on that branch because I want Florian's latest compat patches.
>>>>>>
>>>>>
>>>>> That's weird, given:
>>>>>
>>>>> # git diff --stat v3.2.1..stable/v3.2.x lib/ configure.ac include/
>>>>>  include/boilerplate/atomic.h                      |  2 +-
>>>>>  include/boilerplate/debug.h                       |  3 ++-
>>>>>  include/boilerplate/libc.h                        |  4 ++--
>>>>>  include/cobalt/kernel/assert.h                    |  2 --
>>>>>  include/cobalt/kernel/dovetail/pipeline/clock.h   |  5 +----
>>>>>  include/cobalt/kernel/dovetail/pipeline/trace.h   | 26 ++++++-----------------
>>>>>  include/cobalt/kernel/rtdm/fd.h                   | 16 ++++++++++++++
>>>>>  include/cobalt/uapi/kernel/synch.h                |  4 ++--
>>>>>  include/copperplate/clockobj.h                    |  2 +-
>>>>>  include/rtdm/uapi/testing.h                       | 14 ++++++++++++
>>>>>  lib/cobalt/arch/x86/include/asm/xenomai/syscall.h |  6 +++---
>>>>>  lib/copperplate/threadobj.c                       | 11 ++++++++++
>>>>>  12 files changed, 59 insertions(+), 36 deletions(-)
>>>>>
>>>>> Please test if a checkout of v3.2.1 is also unaffected, and then do some
>>>>> bisecting. I'll see if I can find a RHEL 8.5-like container image
>>>>> somewhere.
>>>>
>>>> Tested in redhat/ubi8:8.6-990 (with fuse-libs/devel from centos, didn't
>>>> find it in the RHEL repos) and only with 64 bit (didn't find the i686
>>>> wrappers for gcc), but hat worked fine.
>>>>
>>>> There must be something else different on your side to trigger this.
>>>>
>>>> Jan
>>>
>>> Some progress, I got further.  But still another build problem below...
>>> First I did:
>>> git reset --hard
>>> git clean -d -f
>>> I'm still on the stable branch:
>>> [root@rhelG xenomai-git-master]# git status
>>> HEAD detached at origin/stable/v3.2.x
>>> And 'git diff' returns nothing , indicating I made no changes.
>>>
>>> then I did this again:
>>
>> Please run scripts/bootstrap first, just to be sure configure and
>> makefiles are up-to-date.
>>
>> Jan
>>
>>> ./configure --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64"
>>> LDFLAGS=-m32 host_alias=i686-linux
>>> To Florians question: I got that configure line from Jan a year ago
>>> and I've been using it successfully since then. I think 'i686-linux'
>>> is appropriate as I want to generate 32 bit libraries to link my 32
>>> bit apps against.
>>>
>>> Then I did: make
>>> libcobalt linked ok! No more  missing cobalt_lookup_vdso, but then the
>>> build stalls here:
>>> ...
>>>   CC       libtrank_la-posix.lo
>>>   CC       libtrank_la-native.lo
>>>   CCLD     libtrank.la
>>> make[2]: Leaving directory '/usr/src/xenomai-git-master/lib/trank'
>>> make[2]: Entering directory '/usr/src/xenomai-git-master/lib'
>>> make[2]: Nothing to be done for 'all-am'.
>>> make[2]: Leaving directory '/usr/src/xenomai-git-master/lib'
>>> make[1]: Leaving directory '/usr/src/xenomai-git-master/lib'
>>> Making all in config
>>> make[1]: Entering directory '/usr/src/xenomai-git-master/config'
>>> make[1]: Nothing to be done for 'all'.
>>> make[1]: Leaving directory '/usr/src/xenomai-git-master/config'
>>> Making all in include
>>> make[1]: Entering directory '/usr/src/xenomai-git-master/include'
>>> make  all-recursive
>>> make[2]: Entering directory '/usr/src/xenomai-git-master/include'
>>> Making all in boilerplate
>>> make[3]: Entering directory '/usr/src/xenomai-git-master/include/boilerplate'
>>> make[3]: Nothing to be done for 'all'.
>>> make[3]: Leaving directory '/usr/src/xenomai-git-master/include/boilerplate'
>>> Making all in copperplate
>>> make[3]: Entering directory '/usr/src/xenomai-git-master/include/copperplate'
>>> make[3]: *** No rule to make target 'wrappers.h', needed by 'all-am'.  Stop.
>>> make[3]: Leaving directory '/usr/src/xenomai-git-master/include/copperplate'
>>>
>>> Incidentally I already did a 'make install' after building xeno 3.2.1
>>> from the official tarball, so /usr/xenomai is in good order.
>>> How do I get past this wrappers.h problem ?
>>>
>>> thanks   -C Smith
> 
> OK, I did:
> make clean
> git clean -d -f
> ./configure...
> make
> and the compile finally succeeded in its entirety.
> Perhaps this git sandbox was used previously and the sources were
> bootstrapped against an older version of code.
> 
> Is it possible that the Makefiles could clean things up better during
> a 'make distclean', and then in the absence of any bootstrapping the
> user could be warned that bootstrapping is required?

I the absence of bootstrapping, there are no configure and makefiles at all.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

