Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01AB29AC
	for <xenomai@lists.linux.dev>; Tue, 28 Feb 2023 12:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfYtUnfPHvEDD7GiHStxscoOv1m8HzI2tvKHxOZhN1T0p+bLufRGPyqivKjvazSpeRtf/rNUEUGAx3H6ll613HSiwssA+1l9QhNd5ShwuQ0wjwW2vLYaYXmnJ6r+nQIo3b1ba1aaKXeNpwCevkLdDavLtQA/hfoLgHWD1H6WfTHYQ51jnTmzFek9OplGR0zTg9RNZ3tLX3GT+X3bRnxXfJ3A+tLixnJQ4IJ2IsDvU8pxgV03ZXU3MSy7e2WhXY5jFUO6BadCyw8f0jgluFwJ/JHOI8FkQ8jnmDfQcdfaFlVzwpbZgrhBVECvjyH/wuPNsmatD+yZUFpBwvHbEktXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VXtmvuPJcfb/5AhKLOvp6sIW7xQStkmbERmKtutqQk=;
 b=fWcK9oHmo26z3TN0sVKnJCWQxsNjInUUKCbHc0A7OgRwQF6te8PLW1SO9mYkpBa63HjfFUjyhGlgKBYrIHTNmOp1//60ouDkOr2fXglevbEWT4qn7bDmuIer30HP1h3JECaE0UibXbRZCnL0fDSlWaIq+qEYu9NokHGyWCxEeZ4IQcuzbnTW32P2TSmV3tVgL3CxE0QyCWOTTZ4JrG46QG+YfmQXUPnxwPBB+D+tbPIjC3nbU3T3pt7awTjmHa6E3r4QnojkJdUyBLbA9caFsnZCXO+ULHcGv9QK9T4OlYqpJVsKUhDwjlHpgKQVZy/j+QlGBc1XKwCMIr3XYNoiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VXtmvuPJcfb/5AhKLOvp6sIW7xQStkmbERmKtutqQk=;
 b=iWREQHED0dJ+h5dGdg/Clmeo51FaUXFhP82RRdPrEtv7RtGHnln4llD59Imz1u82mL3TjFt4O3lUywTPtQpXUvvwHz93K/D1kSvWD2dBxXFCoD9swrQjE3idtUvjU4LMaQ0MLwpED9D1Zsxv6oMMcyJoD7lGnDo8SFjN3qJfO4VCWhCNs/nNQ7+w6h+77Eq7z15d3qj1x5SYkC3/zXy4Q2OjSMFiRL+FIrZZyZ6WYWgTR10EeFLS1ei3nRnBla8pbDdmLAqZxJsOPuV5TovuokPqRJ+zf98J6ceux+kSAmlLrCpAqGfI+cuM9Q3cvDnRiM9QCp2AiNhDrB9qoOPaXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8131.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 12:51:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 12:51:39 +0000
Message-ID: <75e4fb40-027a-7e00-d565-ed765b1739a7@siemens.com>
Date: Tue, 28 Feb 2023 13:51:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Segfault on exit after commit ec804ffbd "lib/copperplate: Release
 main threadobj on exit"
Content-Language: en-US
To: "Mauro S." <mau.salvi@yahoo.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <233902a7-0911-06e8-a54b-dd7a1d568264.ref@yahoo.com>
 <233902a7-0911-06e8-a54b-dd7a1d568264@yahoo.com>
 <645dbe21-4dc6-1449-bf73-ea83165fa4d6@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <645dbe21-4dc6-1449-bf73-ea83165fa4d6@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:610:b1::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a3ae98-2428-4dd7-cdcc-08db198a88b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bwo7vNYqxz98cI8fSJ0FO/Tdr5jnZI2cyfZb9oTsLEoeblW4JUWCqvuuiN9C9wEczlxZXIm4J/shdFAvtQ3SS85Q41lMHVobFmAZOJpF/TCb2sR47ioicw76WNIpW0+VG3t+W4l1IzmApR9ui0/Td1dTvChr6Q+VQmwH1aZACN+W7yZjDpYeydSEwJXyDOd1wAlHC3r49Eqy4nlsylOpv+tAj0CnW0NKSFBy4bVMT1Gk8VvMNIqBMncCq5zAxhALNyIXQR15dsoW2tcuQXagFTWF3zwwVYdl4WhN2+3W+xVwv96uwn60lxO18kU9pM6ccRN89uquNzQWNLpEAGZ+j2nibmaUKgxYXEXGlYjyoQcAnprcM3S6Gpdd0gSVm0xrjMSUr3nOQArdxyk/hkAWQCmCVc2xR7j4ID0iYnsD9e4ezszxzip/4QgFK2DGOM2IbHEth9ZDyVuZyDxyPOLp8Ubt+ai47NWnW6OeXL2txUP9TiflaJsEjreBx8Vq/iWwBrsfIVqY92nsGgqK7nPGbeuanX2fFKD30IEufHhSK3w5vRXbRsrmHaXZonaLmv6b0UwT5+G9CVdWlRCPAi+nz5LxsMHMl7U9l3lPjDL/FvbarSS6JUpG/btuw+mEPDD+HJqhNtYQg7Gg98CaD+D7t6unCF1X2QAdeRpvphPmchAwFZUkpyN3wZBWrz4L4O9koLT580CaFbBT+HdEdL/u7c1gvmc+qRl0RajiF/f5U3M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199018)(31686004)(66899018)(316002)(36756003)(110136005)(86362001)(38100700002)(31696002)(82960400001)(6512007)(53546011)(83380400001)(6666004)(26005)(6506007)(186003)(2616005)(8936002)(5660300002)(6486002)(478600001)(2906002)(41300700001)(8676002)(44832011)(66946007)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFZueUxFb2NIb24yR1FTZzZIVCtOTE01SEhndzZiWW9CSGozeHFsalNtV2xj?=
 =?utf-8?B?Y3RmcmdVUzFpVExNbngwemI4RU1CVHVJbTF1b3p2NW1Vd0VZUFhpQzJwN0RQ?=
 =?utf-8?B?Wk1kQU5XTkxUQkFhcFJNamVyTGwxTDRMdnJEbXdvbk9iMVhGWitVR0J2Z1V3?=
 =?utf-8?B?T3F4Z0VGN1JDTFJ2VUN1ZTNSaUV2UGVpZThBMXlrU1ZBc1d4cTUrY09PYytw?=
 =?utf-8?B?dDlYUWRTMWM4YWRQcjRyZmtmNVRMOVZqUXcySEgrZnUzVzdLVmRicjZQTVkz?=
 =?utf-8?B?KzB4Uk44bU9ySk9RSlFDZXE5ZGFQcnZtWnRqVnQxdkRLUG4xU3NXdlRSUnds?=
 =?utf-8?B?bU9vWWNLZXlLV0ZZYWQ0NGFoTWNiUWJ2TjhsMjBRREQ5TmV1d2FtQnJMUUQv?=
 =?utf-8?B?ZWpjdlk1UUswYkpKWThxY0pDTUJ0T2ZJMGJGdi9RcVFXRmdmQnBjVzh5WWVp?=
 =?utf-8?B?M0laTXN3amIvUWR2YWQ1c2JQeFdsQUNFSi81U3F4c3RsemVkQkFxMTZlaHln?=
 =?utf-8?B?dU1aMFRSUzVxK2Mzak9zR3dpdmpLb2lRbDRpRnBtVWRpL1puMlFlUmtBWWhX?=
 =?utf-8?B?dHBLcS9LUEk3ZWdaTmhWWXpzSEc4YU5UQThiQ3gwR3MrRENJVkcranlsN290?=
 =?utf-8?B?MjZGUVFHUjhLaU8xU1R4RFdreElPeUlCeWpXVlczUnNhdjJLb1Q3L0QyNHFh?=
 =?utf-8?B?dU42NDhvNzdjVnkxVnV3UnRHaWZ1SGxFUjJNRlJhczEyUGlYVVJyLzFpYXhP?=
 =?utf-8?B?dFZBbkkvSGFyeUJTWldKRm41U09DdFoxdEVoZFR4WWg2RXJ6TGlFR0lVa1dX?=
 =?utf-8?B?L0pRb09FSEVOcGx5WCsrOHlJY25DRTBWMTVLaWlLanV1Ui83MkxWckFZTVE2?=
 =?utf-8?B?TVFkUHQ0aU9vSGxvVFAyMGoxSms0VWlLbzN0dGZ3cUZkMy8vRzFzZURWRzQw?=
 =?utf-8?B?RU5DUEh1VlRDaXV4Y3VXR2RJWVIyelRjODM3TFpqMTRiQnZyYUZhYVhxRDIz?=
 =?utf-8?B?RWlCWEFveVNHeWR1dFc5SGNPMWJZb0tLRytKZ3ZYK2Vtc3B5NGFaVzRkQkFD?=
 =?utf-8?B?bFJzbHZqdzV5TURieUFHdk1CQjBrV21DQTk4bnBQenF4UE4rMFo3cmFMWkgy?=
 =?utf-8?B?RE13UlNWTmxJcTNWcTg4RSs0eW1RcFVUUEd5SVBPaVRnRHJmbTNueDB4VWxN?=
 =?utf-8?B?NTRyYXliUjQwVXQ1Z2hFS01GNElWM3REODV2VTRlNlE3MVZ1NHRNS1lzSXVy?=
 =?utf-8?B?MlludWtWdW9mb2h1c1c4bjRsYkJzdXdlVjVhVWxXeUFiS1h6bFRUNkVRUkJH?=
 =?utf-8?B?ZElScjlmWTJ3TTU3bXZ1dWQ4NVM1aE9PcVRxdWd2d1lieU9FREp3eVpETGcx?=
 =?utf-8?B?SEdsTVFlQ0E1cFRGSFZFNVRQejZZNjRzUjVnb1RUWElGK0hpaEJhNytyZ3dm?=
 =?utf-8?B?NlRRWmJaUkdMbXpzMFNjUEtUdTdFam96VHlsZXp2MEZ0RUN6SXRac2FiOHJl?=
 =?utf-8?B?WXdzZXExOGtYQVVHZ0JJd0JRYUN3UWUxZjA4Zm1CNER6Mlo0c1FWZ0lnc2hl?=
 =?utf-8?B?a1pNQWoweWlEZ3hQZUcreVVQQmQ4WmlmMmJKZzJhRE1zbDBZNisxYitsTjdL?=
 =?utf-8?B?ckpFOFhYS1JFakJkTDgzZDR2ZnRqaU9oWC9IOFNLUzVhYm1UY1kra01wLy8x?=
 =?utf-8?B?dTJHS3gxdSt6L3ZYQTJBemZoK1VkeW1VbXVvV1Z4OUxGS2RlTU5pV3E1RGV3?=
 =?utf-8?B?OG5BY0ZFZFdlVlI3QzV6RU04dlNEeVhtNk1USTQzQnA4bDFyZ2gxVnpKRlFs?=
 =?utf-8?B?OGVpVy9IZ0FxVmJXQndDRVlnYVZ1Z2p5VElKWEdiYVZ0Q2xLSVFwd0ZQYkx0?=
 =?utf-8?B?ZkNkd0ptMG9IOW5iSXNKdUEwL0NpOWJOYTVCZ0NVSGhjY2hYYmFZMzh1K0w5?=
 =?utf-8?B?RjJGdG5HN08xTURVQzh6Q2Z3Qy9yVVNLVVE3REtkbEZISkNFWlVLaElmQTNJ?=
 =?utf-8?B?dk81OURKK0E1aE9WRXFvNFJheGNVeUxoWnpXWnJoeVZUTUQxSGVYQkhxckkv?=
 =?utf-8?B?bjNRcGR3Y0ZYRHFFYjUwRGhiY2JKcHh0TFpEc0ZWSGdtU09oZzFLak9CTzVJ?=
 =?utf-8?B?SnJaUmY3SEdBN1VTcVh0Q2JlajVsR29mcFgydU5pcWVsMThIK0hUV1NxQ0Fl?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a3ae98-2428-4dd7-cdcc-08db198a88b2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 12:51:39.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0R3vsw8RK69jGAM2Zna8Mx8Vv7YYMtPTpmYFdTPQHRLod6IwfQ537WU/QSwA2EPSfKwc1ppM8MIxohMilo/IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8131

On 28.02.23 13:10, Mauro S. wrote:
> Il 21/02/23 15:13, Mauro S. ha scritto:
>> Hi all,
>>
>> I'm using Xenomai 3.2.2 at commit ec804ffbd, kernel 5.4.228, cobalt
>> mode, on a Atom x5-E8000 x86-64.
>>
>> Since I trarted to use the commit in message, I have a subtle segfault
>> when I close my application.
>>
>> I managed to reduce the case in the simple code attached to the message.
>> If you run the script, almost always the
>> xeno-test-session-segfault-mainproc generates a segfault at exit.
>>
>> Analyzing the core, the involved code is always the same:
>>
>> #0  0x00007ff729498400 in __hash_key () from /usr/lib/libcobalt.so.2
>> #1  0x00007ff729498897 in hash_remove () from /usr/lib/libcobalt.so.2
>> #2  0x00007ff7294b49ac in syncluster_delobj () from
>> /usr/lib/libcopperplate.so.0
>> #3  0x00007ff7294ce06d in ?? () from /usr/lib/libalchemy.so.0
>> #4  0x00007ff7294b6774 in semobj_destroy () from
>> /usr/lib/libcopperplate.so.0
>> #5  0x00007ff7294ce216 in rt_sem_delete () from /usr/lib/libalchemy.so.0
>> #6  0x0000559ca0298651 in SubDummyFn (arg=<optimized out>) at
>> main_proc.c:55
>> #7  0x00007ff7294cca0a in ?? () from /usr/lib/libalchemy.so.0
>> #8  0x00007ff7294b5ce9 in ?? () from /usr/lib/libcopperplate.so.0
>> #9  0x00007ff729494f7e in ?? () from /usr/lib/libcobalt.so.2
>> #10 0x00007ff729461ea4 in start_thread (arg=<optimized out>) at
>> pthread_create.c:477
>> #11 0x00007ff72937859f in clone () at
>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>>
>> Reverting the commit in object the segfault disappears.
>>
>> Applying the commit to 3.1 branch results in the same problem.
>>
>> Seems to be a corruption of the session memory shared between
>> processes caused by the atexit() callback introduced by the commit.
>>
>> Some notes:
>> - seems that it depends on when the xeno-test-session-segfault-secproc
>> exits: if exit happens during the SubDummy tasks start, the segfault
>> is generated, otherwise no
>> - seems to be related with the number of calls of the
>> xeno-test-session-segfault-secproc: with only one call (change i == 2
>> with i == 1 at main_proc.c:139 and remove one call in the script), the
>> problem does not happen
>>
>> Thanks in advance, regards.
>>
> 
> Hi all,
> 
> just a kind ping.
> 
> Is there anything I can do to try to solve this problem / do you have
> some indications?
> 
> Thanks in advance, regards
> 

Sorry, the original email didn't make it to my inbox, but I see it now
in the archives. Will try to have a look but would also welcome if
someone else can debug deeper.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

