Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD79879E0
	for <xenomai@lists.linux.dev>; Mon, 27 Feb 2023 18:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQepw2XMBgKVAad59bkJ50x5sjod1hM4MRHvqpiLKh0rm5JhB3Ip4x/4zS4ECj5EGsqbLXX+5Di752sWWmyatEgxoE0kY5s6DRXk3i+dLrDQraDfXo0lab/a80KTLDSocQ7XVQ0l0tBHx0XJxN9BmCAorOyRDMXvwNBYQ94AySKQqoW+Hj0ogmE1s5/oY3FB0XmALMBuWl8YBDGcdkWxDpB0d0dAy4GPPKQJArNbk2kK2GpHm5wYC0S9GpkQ7kem9Vvys6BJVyKGAsfWgIhiEPURhv5wFfXaXKkDU5BkxB60v7qCBg2iY731qse8GM+lKyaFgfdUGW/aM2OYRTWGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73FfHvnACFFB/TUUulVSjEdBjEIAKCw0Kn0i9Wu6KGU=;
 b=T7o/0Ra1GWcquM4gwocSW/RkTFp97p2Tk0fzZLsFLfBMlvfkXu5Fp+D1MsUkD/asL5+wY4i7MKjzX96u1Zs9FyLSPPjhgRxyjHCdUn9rMu7yAgOCy4ExCBDtuc6q22TMn1ZXJCdBT0H6FBlALEo19/wtlIz9/EbZ5QlNPr7JUuk8HpJdO/vLLEMPWSlKBOBRs0xPLQw7ik31Jkn5mX+2Yh9bMPZy9PAyk1882w0BvNYrCJlYiHP2sZwv4O9tz6iIhlB1DMhdGGnv+swT+WF8C4Bi1WKXlWcvgy5tEPwwPBfWekoD9Y+9s24sneKp6UMbckrKc7DGF9Y3BtL0gwBlPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73FfHvnACFFB/TUUulVSjEdBjEIAKCw0Kn0i9Wu6KGU=;
 b=XUXh6bJhmLVE7XVjW/Q8O1IRaRm/nVRWgOeN/86Qs4IjL4YLJAmDicY75tYdUpGj0z8wKgA6M2Y0w8eguJy6L9k94hTNGuQ6pQgiyynUihZkfV0wdjzELvVCJPQLjptmkidLezi3piWNST4ZToeG5L+tTckiS6EHJEBCJt96V/5MJzSmAXL3Advc1Tko8uTYsPBVhStGMLHxPxwH1twcgoz5epWBa0xnAQoAkuwSEC1XbtEJdQOC2/cSoRgpfWeEK52aZVpVGmP4sNaco2dX67LQ6w3Xtlk4cib+Afjk1+zH4brg9AED6GNQiuoeRy+pLFfdXecJgUVw3EH1FpNGzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7691.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 18:21:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 18:21:50 +0000
Message-ID: <8fb9cff1-7ef4-715d-0db6-3b15ffa728b1@siemens.com>
Date: Mon, 27 Feb 2023 19:21:48 +0100
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CA+K1mPGGw1iJaCh_L0hRVNFcw-J4O8L-V2wMybnTZQh5EjqNMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea49904-cf0a-4d15-fba3-08db18ef7e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1zJVsCjM2uDUKW0fV9NdsmSLuvbL8VcV5z5Jho0ZfwyPIyqyRZuMNq9YIFpL/hEVVGRlBQetA6SuEwZ81qpItDSxoTIpb2sgp6XapLmSw51rZiH5BO5Goqyjieh5AlqAQovVz0dWEohW4n7BHYrixgy9ZoRzrKcbQ8BsxmV3K85wjF5NV8nzdPCWIn4BjjbdDafBUHQQ0iTQBbP1O6+vb13rQDK6KcrSWbkBo/meFi+fYDYxRHREbA7mc0Hqlqm3r63XKs5/9k9ctWTYEmsQk4T+Sz+N9Qmjo2H8P3x46F5lj3RkBOYMhkQ0s6pYtzS86Jz2ea7kJSKstgd1cJ7SWKzVfNT1aD8SkavsKQZtyMlwAr3Pk0rqFL0WTETT2HPm8aJ1SKu5/Jklzy8z1/qMIWrgN63I0tWHYykQvhg2tBDYOFBYrisrR5pd1CNk61MAwN2VRydtXkx62GnjoW5RUP+Tr4S+W7tATTmyVat5J6QXpUoPtgMA3LU3K9G9uAHVqc1k94LeFFnz5UdTCSs4obxSJ8/jEefthZuMI4shdxVBktcKhD2nKY9rxIMSR/vUMsn/Ff2xJfnJSgwlrxaIzM3YdNJtevSCIILIiZJYQo5SmM/Khosy2qxWOf9iZIpzuPieAJEcS86KKfUL736tDp90SiarsQi9LmwNlL0nDGpuY6LqHAMTCEm3hdmW4YZmWMOWe1/53z/NHoPGbss7uCLtZXQNspBLh/Z5mNHw8TE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199018)(36756003)(5660300002)(8936002)(41300700001)(53546011)(6506007)(6512007)(82960400001)(38100700002)(83380400001)(2616005)(186003)(26005)(31696002)(316002)(66476007)(66946007)(66556008)(8676002)(6916009)(4326008)(478600001)(6486002)(86362001)(966005)(31686004)(2906002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2RERER6OFQ5TFlCcHROcHlScWlYK1VTbUMrNkVXM0Q1WFFrVDdYTjVwTDZP?=
 =?utf-8?B?WDBUY1dHVklyRVZMY3g1UzRXVnNZU2xBczQyd2JITUNaWnU1Y0xRb1JqbWli?=
 =?utf-8?B?eXgwaHdtWlZFWmFSbjNTdTkyblcybHB5ZXZCeG8yK0Z5M0VQaFJxODN5LzY2?=
 =?utf-8?B?MW45Qm0xaUhReWFZdG5MU1Y3enZJRkZuUDk3UDF6dWFBeW9TTnR4cW9jMVBL?=
 =?utf-8?B?SGRGZUlmclFVWml4YXJoY1h4U3RwNzIvN1kxZUVJSC9FaGZGcXRxUS8vRXVY?=
 =?utf-8?B?c0xxc0Z2S3VFVkZ5YlV5eEtzZ2R4WG1sY0VZN0h6VHc1dTlJVCtIY3c3L3FR?=
 =?utf-8?B?bitLeVQwK3JzTGIveFo4Q1BQS25XRGMvamk5Sm5hd09ZcnEvWTM5V0lhSnll?=
 =?utf-8?B?MVArR0oybEFBaTl0NWNDTU95S29VYnZEd244N0tTbmo1NnJtMDJtcjAxV21E?=
 =?utf-8?B?dzZTTFBPc05OSFFDWllsNVduYysvYkdJVStmcHFJMER1bFVvRWQ4NDR5VjV4?=
 =?utf-8?B?N2tWY2JoQnFEdDRpV1ptdmg5RnlPdDFUWjVGTk9HeTdpQ1NoblVBK1lieUQ1?=
 =?utf-8?B?czJWVTU3QWl1Y0RQZVdZTXhmUzJ1L3lvKzdMeEZDVDVtcHB0dFlCVWJyTldH?=
 =?utf-8?B?NzRNUlpCNlV0NGY3YWExbDFGMjVyZ294UW5QV20wVmxZZnNteGpiMmx3Sk9V?=
 =?utf-8?B?SFpqNERFeHpOS0VxY0pFVE9IVWlvRFN3R2p2eGNsNWZqbk15ZkFmMFJVZHZO?=
 =?utf-8?B?TU9NZ0p6SDhlTll4VXl4dTZtclk2TE02cldna1dPbjYrRGJoYzJMbEdleWVW?=
 =?utf-8?B?REpEbUFSOS8yT2d0REhyS2hGb0JwSGsyc2RRckgrSEF3Ly9URCtZbjFOMWhN?=
 =?utf-8?B?NHh1bC8wQWZRcE9PMDQ5TWhkTmlNUll2Q0lxTGtFM0pPdnA4OTk0WFRFQUVi?=
 =?utf-8?B?YzZOTUVPYkVtU3RKY0ZPbVBEaHprNmlvbE1lSk9XSG53WWk5T0ZJVkVLL0RS?=
 =?utf-8?B?bUdCeU5NVlBXUHJwUnJ1VUNYRnZ3azNYQTROMFdJaHRaUEZicnFoR2htS1Ny?=
 =?utf-8?B?ZDArVnNlTG5vbzdlQ29nT0ZUdjZxVWtNaTJDaHVXbGlId2VaZVpmeS84aVlU?=
 =?utf-8?B?NVRjcjNHcjArY2FPMkRiRW5XN2wrMjRnbWpyV1FRUC96OVZLNXNjWlRybHY5?=
 =?utf-8?B?VU1iUzdzUWo1NzQvU2VGNnpwV1M4Uld2Y2hMelRXUW9VZVNUVDNjQWlERHg3?=
 =?utf-8?B?VGw3cVhUV2dmWW1SbDRNbGcybDQ2TFVuSFF4Zk5wQzcvZEV3eUdkRkppYVFB?=
 =?utf-8?B?SCtKU3NPWjMvRzFPODQrSExXajhnUnJidFgvcnN0SFJpLzd3VzFjeUkyenQv?=
 =?utf-8?B?L01YVXZYRzdzS3dHMVFhZmdrKy92ZlhGbTk0TU9uM1hhcW52bS9pNWljR2Vy?=
 =?utf-8?B?eWx4Um9yT3lVd3dPdWdGSDVtcFliWnZLamM4a0drRmNLU0tQaEdNRDd4ejho?=
 =?utf-8?B?cTVzcGoxcmVtQ0Roam5ncnQ2WTZRYUVYOTI2ZG1RelZTd0JZbTFPNXBjV2lo?=
 =?utf-8?B?ZkliS25tRThXdjJOUzZWRHNlNkFWOXpIcjRoc01YWW5aa2pKU2dnZnl1blZr?=
 =?utf-8?B?ZXJmQXBHeHFMcGduUkxIUklWdU5qT2Fyb3AyOWVMM0lRQzhDajY0d0psR2t2?=
 =?utf-8?B?QXArUW5McCs1RjNYNUd6VEQ5ZllPMWxoREoyM2lzQmpFL1BzQzNCYmQrTGRY?=
 =?utf-8?B?NUxOSUNkM3d2THRaSWxickdicWdXWHAvMHdGVWFFamQrRGI0VmlKSk1taXBD?=
 =?utf-8?B?VFlaUlRpTDdLQmczZmdjUHhFM0JVMnNJY3YvaVkyL3JVMGo2eXlnSGU0N2Vj?=
 =?utf-8?B?aHdrY2hma2NDQzE3THFXcGZlQ2dlQTdtM0dXb0t5OWVnd2NPRDZhVWhTVXZZ?=
 =?utf-8?B?RGxGWXNjUzZWZG9TNjlhOXpGTDZkMDZHT0lHMGNBbElCSkU1UnB3d3dtNWho?=
 =?utf-8?B?TFVTaGZhRUZpdkxIRklOdFdnZ1JFRld1UW03RnVZV2R5MVV4NndrdEEyVDUw?=
 =?utf-8?B?eGp0b2w0eWZyeXhRTENTVVRwa3hvSTJTVnVjMk96Syt5V2JNTW9jVko5WFpH?=
 =?utf-8?B?STNDMlJMYWRvL3lpRU1uRWdFMEoyKzc4alVubXM0dVJGS1NCOVNmWmhtY2dS?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea49904-cf0a-4d15-fba3-08db18ef7e8b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 18:21:50.3973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxkFg9M6pIDK4VFOOaEuWCK+cVIe4wmTii+HKX/M5r7/rm+vWn+X0+n6W0EDhMymvPyCBiiEEL7RYycsWppSKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7691

On 27.02.23 19:02, C Smith wrote:
> On Mon, Feb 27, 2023 at 2:30 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 27.02.23 10:45, Jan Kiszka wrote:
>>> On 27.02.23 08:27, C Smith wrote:
>>>> On Sun, Feb 26, 2023 at 10:54 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>
>>>>> On 27.02.23 02:26, C Smith wrote:
>>>>>> I am unable to compile xeno 3.2 after patching and booting kernel
>>>>>> 5.4.228 successfully.
>>>>>>
>>>>>> I had done: git checkout origin/stable/v3.2.x
>>>>>> Kernel is patched like this:
>>>>>> [root@host linux]# ../xenomai/scripts/prepare-kernel.sh --arch=x86_32
>>>>>> --ipipe=../ipipe-core-5.4.228-x86-12.patch
>>>>>> I am compiling xenomai for 32 bit apps, so maybe that is unique. Here
>>>>>> are the configure options:
>>>>>> ./configure --enable-smp --enable-registry --enable-debug=symbols
>>>>>> --enable-shared --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64"
>>>>>> LDFLAGS=-m32 host_alias=i686-linux
>>>>>>
>>>>>
>>>>> Not really:
>>>>> https://source.denx.de/Xenomai/xenomai-images/-/commit/ed48e736f4b3f96c73cb676f793f768a921d0624
>>>>>
>>>>> But we don't think have the registry enabled. Maybe worth to change that
>>>>> (debian/rules).
>>>>>
>>>>>> The failure I got is as follows:
>>>>>> ...Making all in regd
>>>>>> make[3]: Entering directory '/usr/src/xenomai-git-master/lib/copperplate/regd'
>>>>>>  CC       regd.o
>>>>>>  CC       fs-common.o
>>>>>>  CC       fs-cobalt.o
>>>>>>  CCLD     sysregd
>>>>>> ../../../lib/cobalt/.libs/libcobalt.so: undefined reference to
>>>>>> `cobalt_lookup_vdso'
>>>>>> collect2: error: ld returned 1 exit status
>>>>>>
>>>>>> I got the same problem when trying to compile 64 bit, with:
>>>>>> ./configure --enable-smp --enable-registry --enable-debug=symbols
>>>>>> --enable-shared
>>>>>> But I actually need to compile for a large suite of legacy 32 bit apps.
>>>>>>
>>>>>
>>>>> Can't reproduces. What is your build environment (compiler versions,
>>>>> host and target distro)? which revision of stable/v3.2.x are you
>>>>> building (though I'm not aware of any related changes)?
>>>>
>>>> I'm on RHEL8.5
>>>> gcc version 8.5.0 20210514 (Red Hat 8.5.0-4) (GCC)
>>>> I got the linux 5.4.228 from kernel.org
>>>>
>>>> I'm using the latest from the 3.2 stable branch this way:
>>>> I did a 'git pull' inside a git clone and got a bunch of deltas
>>>> I did:
>>>>   git checkout origin/stable/v3.2.x
>>>> This is what branch I'm on now:
>>>> [root@host xenomai-git-master]# git branch
>>>> * (HEAD detached at origin/stable/v3.2.x)
>>>>   master
>>>>
>>>> git log shows:
>>>> commit 62edc8a277d811bf35acea1784d561c45bf592c8 (HEAD, origin/stable/v3.2.x)
>>>> Author: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>> Date:   Thu Feb 16 00:02:54 2023 +0100
>>>>     testsuite/smokey/sched-quota: Allow building with gcc 12
>>>> So thats the latest commit on this branch, right ?
>>>>
>>>>> Also check what happens to cobalt_lookup_vdso in libcobalt.so. In my
>>>>> side, readelf -a lists it. Check if lib/cobalt/parse_vdso.c is built and
>>>>> included in your case.
>>>>
>>>> parse_vdso.c didnt build into a .o file but I think it is linked into libcobalt
>>>> [root@host cobalt]# ls -l |grep vdso
>>>> -rw-r--r-- 1 root   sstorage  7240 Feb 25 23:56 parse_vdso.c
>>>> looking at Makefile.am:
>>>> libcobalt_la_SOURCES =          \
>>>>         attr.c                  \
>>>>         clock.c                 \
>>>>         cond.c                  \
>>>>         current.c               \
>>>>         init.c                  \
>>>>         internal.c              \
>>>>         mq.c                    \
>>>>         mutex.c                 \
>>>>         parse_vdso.c            \
>>>>         printf.c                \
>>>> ...
>>>>
>>>> [root@host xenomai-git-master]# readelf -a
>>>> ./lib/cobalt/.libs/libcobalt.so |grep vdso
>>>> 00024f88  00026306 R_386_GLOB_DAT    00025ac8   cobalt_vdso
>>>> 00024fa0  0001f306 R_386_GLOB_DAT    000255fc   __cobalt_vdso_gettime
>>>> 000254bc  00009707 R_386_JUMP_SLOT   00000000   cobalt_lookup_vdso
>>>>    151: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
>>>>    499: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_gettime
>>>>    611: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
>>>>    453: 00025ac8     4 OBJECT  GLOBAL DEFAULT   24 cobalt_vdso
>>>>    507: 000255fc     4 OBJECT  GLOBAL DEFAULT   23 __cobalt_vdso_gettime
>>>>    903: 00000000     0 NOTYPE  GLOBAL DEFAULT  UND cobalt_lookup_vdso
>>>>
>>>>>> I can send my kernel .config if you want it.
>>>>>
>>>>> The kernel config plays no role here.
>>>>> Jan
>>>>
>>>> Well, I untarred the xeno 3.2.1 package from xenomai.org and that
>>>> compiles fine, no errors - so that's good.
>>>>
>>>> But the git stable branch above won't compile - and I thought I needed
>>>> to be on that branch because I want Florian's latest compat patches.
>>>>
>>>
>>> That's weird, given:
>>>
>>> # git diff --stat v3.2.1..stable/v3.2.x lib/ configure.ac include/
>>>  include/boilerplate/atomic.h                      |  2 +-
>>>  include/boilerplate/debug.h                       |  3 ++-
>>>  include/boilerplate/libc.h                        |  4 ++--
>>>  include/cobalt/kernel/assert.h                    |  2 --
>>>  include/cobalt/kernel/dovetail/pipeline/clock.h   |  5 +----
>>>  include/cobalt/kernel/dovetail/pipeline/trace.h   | 26 ++++++-----------------
>>>  include/cobalt/kernel/rtdm/fd.h                   | 16 ++++++++++++++
>>>  include/cobalt/uapi/kernel/synch.h                |  4 ++--
>>>  include/copperplate/clockobj.h                    |  2 +-
>>>  include/rtdm/uapi/testing.h                       | 14 ++++++++++++
>>>  lib/cobalt/arch/x86/include/asm/xenomai/syscall.h |  6 +++---
>>>  lib/copperplate/threadobj.c                       | 11 ++++++++++
>>>  12 files changed, 59 insertions(+), 36 deletions(-)
>>>
>>> Please test if a checkout of v3.2.1 is also unaffected, and then do some
>>> bisecting. I'll see if I can find a RHEL 8.5-like container image
>>> somewhere.
>>
>> Tested in redhat/ubi8:8.6-990 (with fuse-libs/devel from centos, didn't
>> find it in the RHEL repos) and only with 64 bit (didn't find the i686
>> wrappers for gcc), but hat worked fine.
>>
>> There must be something else different on your side to trigger this.
>>
>> Jan
> 
> Some progress, I got further.  But still another build problem below...
> First I did:
> git reset --hard
> git clean -d -f
> I'm still on the stable branch:
> [root@rhelG xenomai-git-master]# git status
> HEAD detached at origin/stable/v3.2.x
> And 'git diff' returns nothing , indicating I made no changes.
> 
> then I did this again:

Please run scripts/bootstrap first, just to be sure configure and
makefiles are up-to-date.

Jan

> ./configure --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64"
> LDFLAGS=-m32 host_alias=i686-linux
> To Florians question: I got that configure line from Jan a year ago
> and I've been using it successfully since then. I think 'i686-linux'
> is appropriate as I want to generate 32 bit libraries to link my 32
> bit apps against.
> 
> Then I did: make
> libcobalt linked ok! No more  missing cobalt_lookup_vdso, but then the
> build stalls here:
> ...
>   CC       libtrank_la-posix.lo
>   CC       libtrank_la-native.lo
>   CCLD     libtrank.la
> make[2]: Leaving directory '/usr/src/xenomai-git-master/lib/trank'
> make[2]: Entering directory '/usr/src/xenomai-git-master/lib'
> make[2]: Nothing to be done for 'all-am'.
> make[2]: Leaving directory '/usr/src/xenomai-git-master/lib'
> make[1]: Leaving directory '/usr/src/xenomai-git-master/lib'
> Making all in config
> make[1]: Entering directory '/usr/src/xenomai-git-master/config'
> make[1]: Nothing to be done for 'all'.
> make[1]: Leaving directory '/usr/src/xenomai-git-master/config'
> Making all in include
> make[1]: Entering directory '/usr/src/xenomai-git-master/include'
> make  all-recursive
> make[2]: Entering directory '/usr/src/xenomai-git-master/include'
> Making all in boilerplate
> make[3]: Entering directory '/usr/src/xenomai-git-master/include/boilerplate'
> make[3]: Nothing to be done for 'all'.
> make[3]: Leaving directory '/usr/src/xenomai-git-master/include/boilerplate'
> Making all in copperplate
> make[3]: Entering directory '/usr/src/xenomai-git-master/include/copperplate'
> make[3]: *** No rule to make target 'wrappers.h', needed by 'all-am'.  Stop.
> make[3]: Leaving directory '/usr/src/xenomai-git-master/include/copperplate'
> 
> Incidentally I already did a 'make install' after building xeno 3.2.1
> from the official tarball, so /usr/xenomai is in good order.
> How do I get past this wrappers.h problem ?
> 
> thanks   -C Smith
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux

