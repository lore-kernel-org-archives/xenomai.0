Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2079.outbound.protection.outlook.com [40.107.15.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D46FAB
	for <xenomai@lists.linux.dev>; Tue, 21 Feb 2023 16:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jltur4KIdyJpqFrNwgzguF4RvLLrwHW6kHnPEUdt1GwDr+sJNK8BSo3U2DYLkqgst/wMT0MhmYD3/kROAqn6CTMB8qzwi9CxGIIiCB0JubwolztpELJuoDSM5FbF7M55u9z2MLAwxm7bQQQ0PLk194MV1TRbTymUJMrxqLrayw4Kwv/p0JRl+WG1LJ/53LNtsgpykOty6IeHCvDP4CEbzUpDPU84bbGepI3/Tt+GAiiaI/gdDCbaxPW9odItc/YzKk5fsVdxps+ee2eOPBgxbFd1tx9pl0Kr05J6gXWUnHMhIhGv7DarIwNxBJFGkw8v3Pc+vCp9jZVxeGRU10lPGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTT12Aata0V8xLhnAX4mQr3LaBrUwbznsDhsvfjCdwo=;
 b=GdCW5nHQGxvMHAB5+0MfsiAXj/u1nsr0RP65HRM0rpFlioDBJaY4OfZvoK/I0zEe76BCASfTUY/GpY3n7yG9lEDZuYy+WZgjqGvKMZ37Q0h3K7NOudCjgd9wWzK5dBAOHQjhUtyuvh9GnTi0sodOgyevUHjCI+NzDHrXmP0j/g1JRw1On6j5hHUjLvhKRPaecaeeMB2JnmoYIN63Xm5qyGrAgAMQow+ZrMqYRJEYqU2ZCP7N4412fAiVv6S0I4szEfoSPCM2oNoEKo/1IDjvp+tbLqDHMr9p5V/a96cEmeoRZGwxQkwb1mRYOgPWaQ2iq5grnQ4olP/w1FVhWsyMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTT12Aata0V8xLhnAX4mQr3LaBrUwbznsDhsvfjCdwo=;
 b=Tui4a/IKILb15N+03IP0poDDOsINwFnzNuFKw6rp75/ePy9koXhGfjWmF93fFNCGuDMe4ufkzg4R40u2umtne47y6ONId7xKO49MqSSoweFGfXpMKXQXRjKZ5mJ32PQ2RDipCccCK4dljxf9r+n1e4K544Jnq/E+acMY3Z8yOfbdcy3lW8aLNPu90voGW7mDE05qNy0TfgP4mymKqwV0GB5NBrGkv0jRYldToe0DqA3e7amxdtga1JJRKh/LhR1vFpjemDvzQtTAEoTdr6NvQlKm0aXp9koQxdMTco5mUhT3FtpMUZPBvONVXNcVvrO9os1sY+IqWtzKD4qGqbA+Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Tue, 21 Feb
 2023 16:57:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 16:57:41 +0000
Message-ID: <023a8783-e78e-94e2-fd2a-0bf959b886de@siemens.com>
Date: Tue, 21 Feb 2023 17:57:35 +0100
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <02c53276-6a36-8377-4792-575274793c66@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:610:e5::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dcd2742-b43a-49a7-1836-08db142cbea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2+jZiygrRfcT6qeJ4d7pzkGhXlL971UQgw9IBKps7CX2lL0GAFDlwpbsusBBSqOa+YFVTspzsi8tOc5w7A3B5ysjemH0jb842k5JtBJZWDtYEO8H3cpqcqWRWFSwh89TPGCxVSgZ7UI7NppyV872DYgAX1lJzMTci2vQUwMwp6OPiOOJoxOYV3h6x7yR72lJt/XZ0/QEdqdA19vG76yTTu9kyemkBHdaDKI2XeRKtDZKnrVyMxtUTPSbqWuCgAYmBz/3v9CEONRCCPBhndn7weh3yQoMhDYF47U/LOkjpdBOGLIO/7Y/wuYx5VzGl0kpv+WWstrfvzam6vd6Bdqs0k4bsdpeQrV2EfNuxW5IRHYyygnRcGugUpT1DtJEErXVJw96+1FnveH0ESybS8a1EyR+YnrSFWQRT+rv3Yxzr3OYP29cbDaGs5OHwry5V4Aq4EAqZ+qRJVbjzUY1Od33wKl97f917+B6aPHuV3kFRuomCllCNzd6sXRMFHDFavvbDsSDuuCPW0m23rcHChcUr757H6wU79vB2LUTyLR7DSiywfFvYi9Ugyd33J8P85BQuVwGN7tV7wR8wQai3zW6PlS/nfKpZRR8gHFb3FjHYP8Ivc94pcG72iBeIWH7Vp/04/DzHYLCpYStkR2h3Ryj/XOTFW1Rc80D5yK75mrw+25ORP59nqn2xkTuCcPnzYJ8zQXlU45/TEX4TLKMLaoK7UQnyZrZkRMAI9XtzJzacWfJ09kqpgkXj4ag/GamOc/L
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199018)(186003)(41300700001)(31686004)(8936002)(36756003)(82960400001)(44832011)(5660300002)(86362001)(31696002)(6486002)(6512007)(26005)(66946007)(83380400001)(4326008)(316002)(110136005)(66556008)(6506007)(6666004)(8676002)(66476007)(53546011)(2906002)(2616005)(38100700002)(478600001)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z09SQXdmdWxBN1VqY0lmQzJXYlBXMER5SVdNcXJTQ25IT1NDYXdlYnl2RXM5?=
 =?utf-8?B?VmhVV2N6Y0tLZXhYTTU0a3NKYnBoUmR3cy9UN0Jjc3pSY3FCT1RlVEdUTHF6?=
 =?utf-8?B?Ujd3T2xWSlZnazYzQ2dublNpRzZtd1hsUHZJZ2pJdmlFd1U4Szk4U0VHZnFU?=
 =?utf-8?B?QlQ2RjlHZDZjb1hUaGxubTNlelpkN2svZ1JLU3czeDlaV25KWXkxbFM1ckY5?=
 =?utf-8?B?V3U0b2FNNS9xY1dDY2Z5b2k4OGlqWWpsUm5EMXcySUpWNnVMWERJTXZwVllN?=
 =?utf-8?B?aVlKRHFmd2ZiZHltOHlpYjVZcFEyaGlQS3RlRC9oSlRKbVJ0aW1OOXZ6MkdO?=
 =?utf-8?B?VFppZ0xwZFo4cHJtK0N3QVVCajZmaVplNVlpUUJkcjVXWlc3ZjBKcno5T3Jl?=
 =?utf-8?B?TzFLWlFVbmUyb0Q2blVlaVptRFNZSXlsSzEyOUI2VjNyNnhQdDRLZ1h4YXZ5?=
 =?utf-8?B?WUp6M2xESXhCYWJiN05ZSklESzV4VWpYc3B5cGFEck8yOGh0QkZ1UnBCRWha?=
 =?utf-8?B?RmVsNXlLZm81Q3R1YTBpZkwyL1VaMlBIY2hmbHNMakZNK1B4MWVaZjdkSDhi?=
 =?utf-8?B?NElzdEttYkdIcnFlWGRkZUVOSktId3FmSkpkaHZBckdZTkdXMVFtSTRuazJ4?=
 =?utf-8?B?R2ZwMWtkNnQ4TXBGcjI2WjlBb3FzL2ZOU0RKSXFwRiswRjV5alZ4dlRTVnpE?=
 =?utf-8?B?QVpXdlM3NUNnNVFHNENFRURTb3FkVEo5UkxXbXZySFRQeTJwUlBtdGlQZnhh?=
 =?utf-8?B?WmZlREtsekNsL3lqS20zT21zelpXUlJRd2hpeUNRb2M3K3dpVWM1V2s2RkFj?=
 =?utf-8?B?QkF6MU5NUE9GYW5waVk3VTdpOUZOYUFEUVVaTldrSFVLeFNKdm1UQldwKzhF?=
 =?utf-8?B?STdreGwvUlVRd1lZZXI3c0ViamJnTE92ZlVBSzhSQTR0Rld0YURLaEZ1TkQx?=
 =?utf-8?B?QzlJeTNZVFh0RTl5WE85Z1FMaHlsK0lUa1ZSam5kTTN4Y0w2NXBXam9MWHdE?=
 =?utf-8?B?bVgwa05yc1J2UTVtZ2MyRDdaaDN2NUpqaGVXYU1nNUlmOWViK1JoZWVOOUxE?=
 =?utf-8?B?ZW83c1JtREQwUjRweittNUE1SS9pYUxnaDZiR3NuQi9OMGdnUmN1WnNXZk1F?=
 =?utf-8?B?ZE1qNkRZQTBvZXFUVFdKeDYyckhzalRORkp5bDlaQ2UxdWRoeFl6YjZHNjlM?=
 =?utf-8?B?TjBiL0VvbE9sL1hDUjI2VmljWDlBMncyeUF5VFB2UCtIWTFXZVdtTTd2YTVL?=
 =?utf-8?B?cVFpY3BDVzFCazFZclh2RGxvdm1WWWNzelp6Zmg4Rnk4VE05MTdYcUEvK2lw?=
 =?utf-8?B?bzBWcDNVQ3pZMEx4LzF6d2FPUTJOVGMxZ3k5bWNOcjgzcDhMZjhUYXFFWm5V?=
 =?utf-8?B?S0lUa1V6Q1QxR3JQenRFa00zcklsMHBTeVdwbXJyOGZ6L1Q3NC9HOFVuUkdv?=
 =?utf-8?B?b3Q2TjZ5VnUyR0J6RXNkZlpzTGdxai81bzZMUkdVWElJRjMxNDA4WmJ4S2I4?=
 =?utf-8?B?NEs4U1FkQUJsVFJSS1U1b2VEbndycTlmM1RSTXhPczZNOVJLWWVubm5uQlMz?=
 =?utf-8?B?Mk9hTDRFVnNlRzlRVENSbHVLb2tzaEJtRE5jYXl4akZsK1RCNVRHYnk4U1lq?=
 =?utf-8?B?c1dFZ0FiNUUxNDQvOXVCejJvbFdYMGlJV1VNRzRvZzl4VkZHVFUvdXJjSHpN?=
 =?utf-8?B?OHluc3ZDdklyMXNSRUJiRjZ4SmhnL3ZiYTJDNzgrRGlJNlVOcFZlNENocDVs?=
 =?utf-8?B?Y0JTeTJaazFqd0VyMjZscFdpWHdjdHJ2MUwwNng3VXpYSHpUZkhseWw2SGZs?=
 =?utf-8?B?aG9WWklieWZIWjlKWC9yeWpwdmlZT0tLemR5MzRWRWwvL3lZUURMd2lBK1pp?=
 =?utf-8?B?MlNmSXI0TlBIM2NPUFVGb1pnTGl4aFVLaXgzVmYxQlJ0MkE3TnlETWxLVlhD?=
 =?utf-8?B?U2pVWFM3N2RsdVZSb0tMUmsycm1oaHZsSHJOSjV5ZVlVYS96Nlh1bGpDdXZ2?=
 =?utf-8?B?aUs1MGtjNGpNRTlNcHhVMEVENGphSEJqd3JlazRmRjlqbUxWRkl5WTFFNENI?=
 =?utf-8?B?ZTYxSjdSazV5VDQxUG8zeVZFMXEwMWNuQzdlUmNBVFEyZkdiMGROMHF4anNN?=
 =?utf-8?B?TE54a2lPTWQ2Z2lUaEczWWpURHpCRHM5Zk1uVXNFUnI5dzJwc001VnRxKzdI?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcd2742-b43a-49a7-1836-08db142cbea6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 16:57:41.5073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiftY0DQnfGYLeehwfAXTzq4ztI12/vmxFMtEu1JkX6uMpjeOe7awJeDGQ3K2KxLzPkXRWzjD/gY/VxLGRUVTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7890

On 21.02.23 11:40, Mauro S. wrote:
> Il 21/02/23 11:24, Mauro S. ha scritto:
>> Il 08/02/23 09:21, Jan Kiszka ha scritto:
>>> On 08.02.23 03:27, Chen, Hongzhan wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Mauro S. <mau.salvi@yahoo.com>
>>>>> Sent: Tuesday, February 7, 2023 9:46 PM
>>>>> To: xenomai@lists.linux.dev
>>>>> Subject: undefined reference to `fuse_main_real_compat25' when
>>>>> build with -
>>>>> -enable-registry
>>>>>
>>>>> Hi all,
>>>>>
>>>>> I'm bulding Xenomai 3.2.2 for x86_64.
>>>>>
>>>>> When I configure the library with --enable-registry, I get the error
>>>>>
>>>>>    ..
>>>>>      CCLD     rtcanrecv
>>>>>    libcopperplate.so: undefined reference to `fuse_main_real_compat25'
>>>>>    collect2: error: ld returned 1 exit status
>>>>>    ..
>>>>>
>>>>> libfuse-dev package is installed (the configure script finds fuse),
>>>>> and
>>>>> it has the function fuse_main_real_compat25 exported
>>>>>
>>>>>    readelf -Ws /usr/lib/x86_64-linux-gnu/libfuse.so | grep
>>>>> fuse_main_real_compat25
>>>>>     318: 000000000001a500    14 FUNC    GLOBAL DEFAULT   12
>>>>> fuse_main_real_compat25@@FUSE_2.6
>>>>
>>>> I do not know if it might be related to fuse version. In
>>>> configure.ac , it selects fuse version 25 but you are using 26?
>>>>
>>>> if test x$use_registry = xy; then
>>>>          PKG_CHECK_MODULES(FUSE, fuse)
>>>>          FUSE_CFLAGS="$FUSE_CFLAGS -DFUSE_USE_VERSION=25"
>>>>          AC_DEFINE(CONFIG_XENO_REGISTRY,1,[config])
>>>>         
>>>> AC_DEFINE_UNQUOTED(CONFIG_XENO_REGISTRY_ROOT,"$registry_root",[config])
>>>> Fi
>>>
>>> That's a good hint. I vaguely recall similar issues when building
>>> against a newer version and trying to run that against an older one on
>>> the target.
>>>
>>> Jan
>>>
>>
>> Hi all,
>>
>> Yes, I'm using libfuse compiled with FUSE_USE_VERSION=26.
>> I'm building in Yocto.
>>
>> I tried to
>> - change FUSE_USE_VERSION=26 in Xenomai: does not work
>> - change FUSE_USE_VERSION=25 in fuse and rebuild it: does not work
>>
>> I finally removed the can utils from the Xenomai build (I don't need
>> it) and the build completes correctly.
>>
>> Seems that the fuse symbols are not found only for can utils (don't
>> know why).
>>
>> Thanks, regards
>>
> 
> Replying to myself: Xenomai does build but does not work:
> 
> /usr/lib/libcopperplate.so.0: undefined symbol: fuse_main_real_compat25
> 
> Strange thing is that /usr/lib/libcopperplate.so.0 does not depend by
> libfuse2 (that have the fuse_main_real_compat25 symbol exported)
> 
> LD_TRACE_LOADED_OBJECTS=1 /lib/ld-linux-x86-64.so.2
> /usr/lib/libcopperplate.so.0
>     linux-vdso.so.1 (0x00007ffe6ed14000)
>     libcobalt.so.2 => /usr/lib/libcobalt.so.2 (0x00007f21fc308000)
>     libmodechk.so.0 => /usr/lib/libmodechk.so.0 (0x00007f21fc303000)
>     librt.so.1 => /lib/librt.so.1 (0x00007f21fc2f8000)
>     libpthread.so.0 => /lib/libpthread.so.0 (0x00007f21fc2d7000)
>     libc.so.6 => /lib/libc.so.6 (0x00007f21fc10a000)
>     /lib/ld-linux-x86-64.so.2 (0x00007f21fc355000)
> 
> Other hints? Thanks in advance, regards

If only can-utils are affected, it should be possible to spot some delta
in the Makefiles, the build logs or also the generated binaries of other
tools. There are many more tools, and the can-utils do not reference
fuse or the registry service explicitly.

And: Where does version 25 come from? Do you have it on the host, and
something actually leaks into the yocto build so that the host libs are
referenced?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

