Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2042.outbound.protection.outlook.com [40.107.15.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2B9443
	for <xenomai@lists.linux.dev>; Tue, 28 Feb 2023 17:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHUGt1hjrUp/nYDXhxbdnTzh1T/4HmrwqpKK3xdyjiXVZtg4WXvl0AWUnRy+d9ITNrB/43GHJd9bAh2a9gSZZUdmOHVU9noVowsbRfX8FW8aaWmvdEvwu7Eqmo2WAeNOohOT/b6ek0QARGazmXB6mZ4qxiyJlpHI0gGccQllm7C4coaMvWj+6LEk52ArbHot4aieLunmWhMnnlQ1Zk4hWHKrY+3Lx8EOYqC4VUvq/Ct6R2EBi0s7jBNtKYQ660txpW05O0osH4xWX+mNuxocGuO29bEtiMnydGl1AVko2tt6ewpa11tGYLUzu4oXSaLsW6qyiZXExSPzT26ZxPKyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SpZZBGgPu40xLsyHfqpKwaInp2WJTlDRsGGDZH5TG0=;
 b=Jhd5Oi1vzwATrOmFJpRPpzsGZqqx/hto49TSalTR5qgGyXKHUPL6vQJrfvYhCYsjFEN9yVU84WPhaXE7AYHDgUwjFhS6MA+SChS0MP49kGEfurgTosoUsv9NJNBhVFIRx9lRuj2joNXtperErhXrglQcBg9ZJhb1cIzZUvRlHVcquZPicJEKg/2PU7+tvijYHlNRCnUYFgKZEG4OSlZh4faMMTUq81lvGOMhN3NTOneAOiJWyTxfCsYctP1Vi60M7FOr09tlp2/EcjGyfqgaY7dUjLZKN+6GMfbO0u2s7UgCUIZo0/rShhXX+V4miFcZEkESLkRX7mWnG1ZjulTAjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SpZZBGgPu40xLsyHfqpKwaInp2WJTlDRsGGDZH5TG0=;
 b=DM2Por+CQTKnu6vvWJfz2yOd3l0XybScQW1kXV1H4fijc4DpLkVCJcjEUH5CpYyW1CbsK0WTOWWIOtF/2gwePCssC8PmX8CaaK58y/5I4ksh1Y74eZKc6KF5noqVLArzbnX+h3k/LPIgJw9vn6wvWtIYU57uc/Sa5xqk60/JZ3X8OCVGxQodRKvB5hwhoKGylOb6NAA2sEt10uKKHOuEFgW5IEp17007QBw6KWiFizief4rFuW2Nwxh9kb38gzdxnyU9qxxj9Ov86xFmogXExEbj+02H5vVXixzIP7xILlxJpxtFCTAVJM/CqWrWqooc5okVQZtbGI4V9tyuyOQs/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6232.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 17:58:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 17:58:08 +0000
Message-ID: <2e6f787f-5854-6eea-b332-38a6bebe9478@siemens.com>
Date: Tue, 28 Feb 2023 18:58:00 +0100
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
 <58bb082d-fb06-c69f-8b67-3e9a045f0a3f@siemens.com>
 <CA+K1mPE+8V=k9+JE8yM9tD5T1B_2ZbWHUgVD9TO-D2Gie+SfOQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CA+K1mPE+8V=k9+JE8yM9tD5T1B_2ZbWHUgVD9TO-D2Gie+SfOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:610:e6::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfab236-f468-457c-0e32-08db19b55990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hs589ta/ajWRkmvl4nROPgHaPNnZPl7JsDU1KcttkEqvhq/Cp7OxrLqBu1vf15A9uDwcc0zSkxt6RgKCkoojtDhUgv39tO6yA969x+SeDyaVhzhcD38dmvzOaZGDuhlMOVHdCXnVvfaCez2abTvU0dtkOvpZdAJzpKaoTg+ferudnxImHx8buFhS/NNw+Nfg7rp77Y0HKzMpntvgdzGBEwWjorwBRUn0aLk0JfpXQGZktsfCTcJqXV5mrSshU0+UdBoq0AcPL7Mp2YoxPrG+MgN6UxrmqGTFMJI1pdCu1Fjd34emgEIQDpSmiKUyIeuF+sabHXblbPL+WgpbAcVabWYyjVK1ZS3lL1kkcrFwp0zEWZCcZdelDHQbrU9/r6EgB+zexI/PfpgOPQ/Bk84vMOV1yJ9JB707P6QkG4T9af/D/O4AUG7dd1jJ/QAz3zjx9o4pcHmfHv/yn5exJfNHzBRcRyCGtSzALx3N4MlEI6htK8EOVVX09816mMj2jFOZCYgMK6MGOKvZSLyZo90dOFffl5fVkwVtJnbrMEE2N7UlLhVKmfYtYZ9Q9iFZZLheYHaEw/GRdxZxudA9GvpNgi8QrvhRkBGDsHhRDKWUAsSRvtqoEMG4fROkK+o5ReGJGPT34FqX0VeNiFWzjitIvr9WWGN+mEUxAcB9tIu/CGKn9vhjPU/p9oHmPlz7DT7Y3cknNP0ac0OIUQ2BZpZqNnpLnCtBKaaRDxJVi9mD26U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199018)(186003)(2906002)(82960400001)(83380400001)(316002)(38100700002)(8676002)(6916009)(4326008)(8936002)(41300700001)(66556008)(5660300002)(44832011)(30864003)(66946007)(478600001)(66476007)(2616005)(26005)(6666004)(53546011)(6512007)(6506007)(966005)(31696002)(86362001)(36756003)(84970400001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDBsa2dlbnZ0QWhmNHRjbytGbXpHMHNCM1Jha21VS3g3R3BkQmhMK2xML00v?=
 =?utf-8?B?d25pSW5KaUd4NnZVVDNMUHVSWGplRXNHbTZPNE50eXRTTGdsNGZzMnF5ZU5n?=
 =?utf-8?B?N2hiNnp1VjBSbWljUUxGSWlrTzJtUXlQcG5VV0VWdUNzbjViNmIxRHhJMVlW?=
 =?utf-8?B?NFlvMUxRQ3hUckUxcmVsR0crbWp2ZmcxTjVsV0orUzQzRExpS293MWpJdzNz?=
 =?utf-8?B?azVoLzJLa1luc1lqZTZsTUFXY2lBMHErZWNqRzFVU29hQkNva045Y3BtL2o0?=
 =?utf-8?B?anl4czhSb0hmOVdud0pRS2xSQXF6Z2xoSnNmL1YyaFZUMlkxNUZseXhqYjB1?=
 =?utf-8?B?bGcrTFE5S3VoQUVKWHR6d1RYbGFFZXVDUm44UVJiaXg0VmdMZ0ZlMWt3S0xR?=
 =?utf-8?B?TTF0eTBodUdaaEswOVJHeWIzNG1jdDZReDl3OTdCK0VEUHhhYVhLbDd3SHc1?=
 =?utf-8?B?VlZIMlc2SGJ4QzFieG80MTNzMlVQbGhMUExoQmYzckZ0SGhNdXMzT2t5K3c2?=
 =?utf-8?B?MDFvalpkSmgrUk1ISm9iQnhGcVVISVdIRzZnWW93Vnh5OHB4d25NRG9KTE5L?=
 =?utf-8?B?UTdmbzFKcnh3MXJxWlBCUjZWVXdvRkY4M3VBbExBRmJmMDZhUnpxdUdMM3lu?=
 =?utf-8?B?MmFUejh2NGV5eFUzRG9ZQW55cFNpRHBVenRyVS8vOTNadkxXVTliOEhLQ2hD?=
 =?utf-8?B?WHUrZ2pFYWV0MmgyUGl6NFJHZlhZSkJ2SG9Nb3I0cmdTS1hSNVMyKzd1YkNK?=
 =?utf-8?B?dmVJWmp5UjBVQlZ5WnhZaUxOTVJJTjg4SzVMRWtrclZnbU1EVzVJWXdNWEx5?=
 =?utf-8?B?dDk4M2NjRGZ5RVlIU2NDd2lrbGRyTEJhWFQ3NDFVRGhzeUF3TUhFc0ZKZ040?=
 =?utf-8?B?WVd1Q1VFdEd4Y0JrTkZTdFZpTGZuQVc4R0REVkU2MXlFTFRWU1Vwb09LWCtH?=
 =?utf-8?B?Nnpka3R1TkpyWkR2TTJaanV6TjQvaGF3MHU1ajUvQ09nVUVqeG9nemFXZ1BQ?=
 =?utf-8?B?U1ZZbzhkRTVpczV6TXY1a3IyRXROSHgxcWpiMnRiTFdYUm5YN3dTN0xrMVNt?=
 =?utf-8?B?UVlpbVJYYjJHY3k3Y3o0YUt2SGlQQjZQakxhOUFKQ1YrNEQvK3BBVWJUcXRB?=
 =?utf-8?B?a2k4b3NmY3gzd3BnVWFPSFR2NzdYUUlxVW5NTElSUjhsL0duc2Nhb3ovcm9n?=
 =?utf-8?B?Z2FQaGVsRjViNXpURDhtY2lDb2lKdTA5YUlIbGpaTjlsQlFSSEJJbEJGd09G?=
 =?utf-8?B?endhSXZ3N2hVb0Rwb3JjQUE1WTFLV21ROURZejBBWkdtTDl5alhZTW9JS0Iy?=
 =?utf-8?B?cmoxcisrQjF3T3BvemtrSFdDM2hzbkdiR2h3eGtiUFhxRzJEeEVTV2RWT0R4?=
 =?utf-8?B?d1lIK0NLZTN0RGUzeVNnOGZKdzZITHg0WUxyd1h1VElaOXZJcCtyU0MydUph?=
 =?utf-8?B?dWFEeFZ5dmhKRVp1aVBNYkJRYW5JWFdXZ080eFVkWEE2cEs1b1NYRE9CQmht?=
 =?utf-8?B?YTRzaitMcEsyakJWczFoKzRMZU13WDBHYXJnSGFma0ZLblZJZXd4MG8zS1c2?=
 =?utf-8?B?RFl2alZUY09NOGhEbmZhUjB5N1BydE54eE9oWUpoWnBlWnpZNk5DSGVrUDZ6?=
 =?utf-8?B?cG92WkJyL1AxYW16QlRXekZYVEFheVhRZXVCTmx1UHFUSjFUWmdseHZ1S0RZ?=
 =?utf-8?B?UktJbm9HWHY1SDhBUWhnZ1NGa1J0WjRlNkliQnJ2R0ZJaHpnTFBkTFRtWlAw?=
 =?utf-8?B?WGUrVTl6NUpuQkxOMmRFVkdRYU9nbzFLa3pPazBPM0hCeGlZUElXcjVFRWpB?=
 =?utf-8?B?MGxCdnVrOWdXbys2aStIclNTVnZMWW1LNVcwRDhSaUxKdkdjV2Z1L29NZWc5?=
 =?utf-8?B?MEhKOFB2VHc4Y0trVWtvZG5xcHBlcmgxbUZYVVNCRVZJZnUwRnd1dGlUTldy?=
 =?utf-8?B?Z00ybm5hWmZUSE5DS3BGa2U0U0t2VjFVd1c0Z085U0JKY3doK3JZY2VpNkxp?=
 =?utf-8?B?d0xxcmhnWXdtR3JGVTc3eU9WaHVCTDVzRzJhZWU3ckQ0OHhMZm9Gc3NiWjIv?=
 =?utf-8?B?T3hqby8rQWZKeFkxbzlxUmtrMkhtaVI1dTJWWnJHbStvSkVvQVFWK2htMGpF?=
 =?utf-8?B?dWpMLzJKNU9jQ1VlUjhDbDhEbElSOVlxbC95ZTg1enl0ZVV4OE5Pb1M1ZHc5?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfab236-f468-457c-0e32-08db19b55990
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 17:58:08.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHXMop8b11DIWh7aUnbFR8IT14HOmFeU1rr8snPSmS0MThG9bOpgs3AbVOD98Qw1qd3a55Iw6A2kA67m33N+UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6232

On 28.02.23 18:41, C Smith wrote:
> On Mon, Feb 27, 2023 at 9:11 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 27.02.23 20:54, C Smith wrote:
>>> On Mon, Feb 27, 2023 at 10:21 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 27.02.23 19:02, C Smith wrote:
>>>>> On Mon, Feb 27, 2023 at 2:30 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>
>>>>>> On 27.02.23 10:45, Jan Kiszka wrote:
>>>>>>> On 27.02.23 08:27, C Smith wrote:
>>>>>>>> On Sun, Feb 26, 2023 at 10:54 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>>>>
>>>>>>>>> On 27.02.23 02:26, C Smith wrote:
>>>>>>>>>> I am unable to compile xeno 3.2 after patching and booting kernel
>>>>>>>>>> 5.4.228 successfully.
>>>>>>>>>>
>>>>>>>>>> I had done: git checkout origin/stable/v3.2.x
>>>>>>>>>> Kernel is patched like this:
>>>>>>>>>> [root@host linux]# ../xenomai/scripts/prepare-kernel.sh --arch=x86_32
>>>>>>>>>> --ipipe=../ipipe-core-5.4.228-x86-12.patch
>>>>>>>>>> I am compiling xenomai for 32 bit apps, so maybe that is unique. Here
>>>>>>>>>> are the configure options:
>>>>>>>>>> ./configure --enable-smp --enable-registry --enable-debug=symbols
>>>>>>>>>> --enable-shared --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64"
>>>>>>>>>> LDFLAGS=-m32 host_alias=i686-linux
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Not really:
>>>>>>>>> https://source.denx.de/Xenomai/xenomai-images/-/commit/ed48e736f4b3f96c73cb676f793f768a921d0624
>>>>>>>>>
>>>>>>>>> But we don't think have the registry enabled. Maybe worth to change that
>>>>>>>>> (debian/rules).
>>>>>>>>>
>>>>>>>>>> The failure I got is as follows:
>>>>>>>>>> ...Making all in regd
>>>>>>>>>> make[3]: Entering directory '/usr/src/xenomai-git-master/lib/copperplate/regd'
>>>>>>>>>>  CC       regd.o
>>>>>>>>>>  CC       fs-common.o
>>>>>>>>>>  CC       fs-cobalt.o
>>>>>>>>>>  CCLD     sysregd
>>>>>>>>>> ../../../lib/cobalt/.libs/libcobalt.so: undefined reference to
>>>>>>>>>> `cobalt_lookup_vdso'
>>>>>>>>>> collect2: error: ld returned 1 exit status
>>>>>>>>>>
>>>>>>>>>> I got the same problem when trying to compile 64 bit, with:
>>>>>>>>>> ./configure --enable-smp --enable-registry --enable-debug=symbols
>>>>>>>>>> --enable-shared
>>>>>>>>>> But I actually need to compile for a large suite of legacy 32 bit apps.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Can't reproduces. What is your build environment (compiler versions,
>>>>>>>>> host and target distro)? which revision of stable/v3.2.x are you
>>>>>>>>> building (though I'm not aware of any related changes)?
>>>>>>>>
>>>>>>>> I'm on RHEL8.5
>>>>>>>> gcc version 8.5.0 20210514 (Red Hat 8.5.0-4) (GCC)
>>>>>>>> I got the linux 5.4.228 from kernel.org
>>>>>>>>
>>>>>>>> I'm using the latest from the 3.2 stable branch this way:
>>>>>>>> I did a 'git pull' inside a git clone and got a bunch of deltas
>>>>>>>> I did:
>>>>>>>>   git checkout origin/stable/v3.2.x
>>>>>>>> This is what branch I'm on now:
>>>>>>>> [root@host xenomai-git-master]# git branch
>>>>>>>> * (HEAD detached at origin/stable/v3.2.x)
>>>>>>>>   master
>>>>>>>>
>>>>>>>> git log shows:
>>>>>>>> commit 62edc8a277d811bf35acea1784d561c45bf592c8 (HEAD, origin/stable/v3.2.x)
>>>>>>>> Author: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>>>> Date:   Thu Feb 16 00:02:54 2023 +0100
>>>>>>>>     testsuite/smokey/sched-quota: Allow building with gcc 12
>>>>>>>> So thats the latest commit on this branch, right ?
>>>>>>>>
>>>>>>>>> Also check what happens to cobalt_lookup_vdso in libcobalt.so. In my
>>>>>>>>> side, readelf -a lists it. Check if lib/cobalt/parse_vdso.c is built and
>>>>>>>>> included in your case.
>>>>>>>>
>>>>>>>> parse_vdso.c didnt build into a .o file but I think it is linked into libcobalt
>>>>>>>> [root@host cobalt]# ls -l |grep vdso
>>>>>>>> -rw-r--r-- 1 root   sstorage  7240 Feb 25 23:56 parse_vdso.c
>>>>>>>> looking at Makefile.am:
>>>>>>>> libcobalt_la_SOURCES =          \
>>>>>>>>         attr.c                  \
>>>>>>>>         clock.c                 \
>>>>>>>>         cond.c                  \
>>>>>>>>         current.c               \
>>>>>>>>         init.c                  \
>>>>>>>>         internal.c              \
>>>>>>>>         mq.c                    \
>>>>>>>>         mutex.c                 \
>>>>>>>>         parse_vdso.c            \
>>>>>>>>         printf.c                \
>>>>>>>> ...
>>>>>>>>
>>>>>>>> [root@host xenomai-git-master]# readelf -a
>>>>>>>> ./lib/cobalt/.libs/libcobalt.so |grep vdso
>>>>>>>> 00024f88  00026306 R_386_GLOB_DAT    00025ac8   cobalt_vdso
>>>>>>>> 00024fa0  0001f306 R_386_GLOB_DAT    000255fc   __cobalt_vdso_gettime
>>>>>>>> 000254bc  00009707 R_386_JUMP_SLOT   00000000   cobalt_lookup_vdso
>>>>>>>>    151: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
>>>>>>>>    499: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_gettime
>>>>>>>>    611: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
>>>>>>>>    453: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
>>>>>>>>    507: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_gettime
>>>>>>>>    903: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
>>>>>>>>
>>>>>>>>>> I can send my kernel .config if you want it.
>>>>>>>>>
>>>>>>>>> The kernel config plays no role here.
>>>>>>>>> Jan
>>>>>>>>
>>>>>>>> Well, I untarred the xeno 3.2.1 package from xenomai.org and that
>>>>>>>> compiles fine, no errors - so that's good.
>>>>>>>>
>>>>>>>> But the git stable branch above won't compile - and I thought I needed
>>>>>>>> to be on that branch because I want Florian's latest compat patches.
>>>>>>>>
>>>>>>>
>>>>>>> That's weird, given:
>>>>>>>
>>>>>>> # git diff --stat v3.2.1..stable/v3.2.x lib/ configure.ac include/
>>>>>>>  include/boilerplate/atomic.h                      |  2 +-
>>>>>>>  include/boilerplate/debug.h                       |  3 ++-
>>>>>>>  include/boilerplate/libc.h                        |  4 ++--
>>>>>>>  include/cobalt/kernel/assert.h                    |  2 --
>>>>>>>  include/cobalt/kernel/dovetail/pipeline/clock.h   |  5 +----
>>>>>>>  include/cobalt/kernel/dovetail/pipeline/trace.h   | 26 ++++++-----------------
>>>>>>>  include/cobalt/kernel/rtdm/fd.h                   | 16 ++++++++++++++
>>>>>>>  include/cobalt/uapi/kernel/synch.h                |  4 ++--
>>>>>>>  include/copperplate/clockobj.h                    |  2 +-
>>>>>>>  include/rtdm/uapi/testing.h                       | 14 ++++++++++++
>>>>>>>  lib/cobalt/arch/x86/include/asm/xenomai/syscall.h |  6 +++---
>>>>>>>  lib/copperplate/threadobj.c                       | 11 ++++++++++
>>>>>>>  12 files changed, 59 insertions(+), 36 deletions(-)
>>>>>>>
>>>>>>> Please test if a checkout of v3.2.1 is also unaffected, and then do some
>>>>>>> bisecting. I'll see if I can find a RHEL 8.5-like container image
>>>>>>> somewhere.
>>>>>>
>>>>>> Tested in redhat/ubi8:8.6-990 (with fuse-libs/devel from centos, didn't
>>>>>> find it in the RHEL repos) and only with 64 bit (didn't find the i686
>>>>>> wrappers for gcc), but hat worked fine.
>>>>>>
>>>>>> There must be something else different on your side to trigger this.
>>>>>>
>>>>>> Jan
>>>>>
>>>>> Some progress, I got further.  But still another build problem below...
>>>>> First I did:
>>>>> git reset --hard
>>>>> git clean -d -f
>>>>> I'm still on the stable branch:
>>>>> [root@rhelG xenomai-git-master]# git status
>>>>> HEAD detached at origin/stable/v3.2.x
>>>>> And 'git diff' returns nothing , indicating I made no changes.
>>>>>
>>>>> then I did this again:
>>>>
>>>> Please run scripts/bootstrap first, just to be sure configure and
>>>> makefiles are up-to-date.
>>>>
>>>> Jan
>>>>
>>>>> ./configure --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64"
>>>>> LDFLAGS=-m32 host_alias=i686-linux
>>>>> To Florians question: I got that configure line from Jan a year ago
>>>>> and I've been using it successfully since then. I think 'i686-linux'
>>>>> is appropriate as I want to generate 32 bit libraries to link my 32
>>>>> bit apps against.
>>>>>
>>>>> Then I did: make
>>>>> libcobalt linked ok! No more  missing cobalt_lookup_vdso, but then the
>>>>> build stalls here:
>>>>> ...
>>>>>   CC       libtrank_la-posix.lo
>>>>>   CC       libtrank_la-native.lo
>>>>>   CCLD     libtrank.la
>>>>> make[2]: Leaving directory '/usr/src/xenomai-git-master/lib/trank'
>>>>> make[2]: Entering directory '/usr/src/xenomai-git-master/lib'
>>>>> make[2]: Nothing to be done for 'all-am'.
>>>>> make[2]: Leaving directory '/usr/src/xenomai-git-master/lib'
>>>>> make[1]: Leaving directory '/usr/src/xenomai-git-master/lib'
>>>>> Making all in config
>>>>> make[1]: Entering directory '/usr/src/xenomai-git-master/config'
>>>>> make[1]: Nothing to be done for 'all'.
>>>>> make[1]: Leaving directory '/usr/src/xenomai-git-master/config'
>>>>> Making all in include
>>>>> make[1]: Entering directory '/usr/src/xenomai-git-master/include'
>>>>> make  all-recursive
>>>>> make[2]: Entering directory '/usr/src/xenomai-git-master/include'
>>>>> Making all in boilerplate
>>>>> make[3]: Entering directory '/usr/src/xenomai-git-master/include/boilerplate'
>>>>> make[3]: Nothing to be done for 'all'.
>>>>> make[3]: Leaving directory '/usr/src/xenomai-git-master/include/boilerplate'
>>>>> Making all in copperplate
>>>>> make[3]: Entering directory '/usr/src/xenomai-git-master/include/copperplate'
>>>>> make[3]: *** No rule to make target 'wrappers.h', needed by 'all-am'.  Stop.
>>>>> make[3]: Leaving directory '/usr/src/xenomai-git-master/include/copperplate'
>>>>>
>>>>> Incidentally I already did a 'make install' after building xeno 3.2.1
>>>>> from the official tarball, so /usr/xenomai is in good order.
>>>>> How do I get past this wrappers.h problem ?
>>>>>
>>>>> thanks   -C Smith
>>>
>>> OK, I did:
>>> make clean
>>> git clean -d -f
>>> ./configure...
>>> make
>>> and the compile finally succeeded in its entirety.
>>> Perhaps this git sandbox was used previously and the sources were
>>> bootstrapped against an older version of code.
>>>
>>> Is it possible that the Makefiles could clean things up better during
>>> a 'make distclean', and then in the absence of any bootstrapping the
>>> user could be warned that bootstrapping is required?
>>
>> I the absence of bootstrapping, there are no configure and makefiles at all.
>> Jan
> 
> Right. But analyzing what happened: make bootstrap was run long before
> git pull, then after pulling recent sources the sandbox wouldn't
> compile anymore. So some mechanism to get the sources out of that
> state would be valuable.  scripts/bootstrap is bespoke and unknown to
> developers, 'make distclean' is universally known.
> 
> Right now make distclean already deletes the top level Makefile but
> that is not sufficient because configure regenerates it, allowing the
> build to fail again.
> 
> So how about if Make distclean deletes the configure script? It would
> also print a warning telling the developer to 'make bootstrap'. Of
> course, once they do that, the sources will build successfully.

The purpose of distclean is to clean for redistribution. And
redistribution (as tarball) in fact includes configure & Co.

I'm not sure if there is a way to detect a potential inconsistency
between configure.ac/Makefile.am and the generated files.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

