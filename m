Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE08C09
	for <xenomai@lists.linux.dev>; Mon,  9 Jan 2023 19:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVV8AuyucXgURU3ry4QF9OyFVWr3VN5OB0NzlwvLHrfx4VT1uOIrh2RCnAx9+pRx3Ua0CoxYmqGt01lHIWRNrJH+QVsVcBSEX9j+6UjEnTbUQwOP49cSRoNPSaAd8IqoH1CERGxafO6BSva5kC1SbPjINZKS0IW8kocWJMvpbG+f/rMUNSUXK7a8rCSNvgnfbBXRTwqtZ7CeM1E4+XORgstATqYTTORidb0dqzhUyYDSrkokX9vtt1ULLIFO3/tDh6vMT8cFBCsDRbIrELYEwsBUN7df4h1sAQPlv1cL3y9hnS9yhIzac7CD+b6K1mxYtsNnaVTGzc5XFcaVQHRr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B/DyjZAQIMDWDS9ry9W9zLJzV4TnUC4v7LswoQOQ3E=;
 b=oJViWRKwxAFeTZW5Wad3yxyLQiCrDgWkz1TWgMW/gcyNPHFO2rqxGqM7D43eYDeAo5U/W5YrsAkEzNZjs6lvnESFh6J/tCBBd5eEyNkEegrBQh+UZOEUJkauVdTcRiXQn90Yh0O3RdcX4PiIhVRCM+ZtXsKS9MGUPRGs+DVI9O9vIIQdsyiKaaALkxzipdu9aoiLl0t8gN2bQH3zvP0ZFFgJu/+inUDw+aYoqhkpvD79420wcoLd/hzV2Iti8JdM2FDx+IuFbMExl/wrXccVVU3jbldOo+e3DlImqDPau3nSSWV3dcFmpJnBuKkBkKF07Mu8coMyPHwry+IEr55avQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B/DyjZAQIMDWDS9ry9W9zLJzV4TnUC4v7LswoQOQ3E=;
 b=hp07xKa/4pyX4lu4o05sbH9QK5rNeWmKH9UKAibkSD8k5ERSNI0AAMCJtUH5eiih1ivlPy65jfOMZNVungzKkBojtacUVXPhfSh0VC3dCYKvQFsgHnk4TQEg+XJyQrZAH82tobaASh3/J6TffFjYGC8JeduJ6XgY/LmfijiYtPoa+FodtOJzLuTkJO1YD1p3n/AblTxB/i/V4+MLe0WqOVq3sUegL4LAsgMM39MokvVT1CLk1qNFDBdRH8FWv9p5B4MBPL7Bd1xvqXaWe8pS0xul0asyPVewwltelxhWNnUdyghgNQvK7aglurKL048tmtcgPwUazZHIWkrGmpz5Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 19:30:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 19:30:53 +0000
Message-ID: <e5464ba0-d82c-3c4a-0821-80349ab158f1@siemens.com>
Date: Mon, 9 Jan 2023 20:30:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: "failed to allocate main tcb" error
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Mauro S." <mau.salvi@tin.it>, xenomai@lists.linux.dev
References: <9e3a4efe-f967-09c0-e8bb-df8d7e8140a9@tin.it>
 <198d2e2a-eb01-0822-67ff-895e8c2f1856@web.de>
 <f3167be0-db2a-2676-4866-d2690172a412@tin.it>
 <fa74110f-f02a-3ef3-4690-bd6690700ee6@web.de>
 <d33591ec-f2be-3898-b87e-904d7da77bf1@tin.it>
 <7c281c36-f7d9-71f1-2346-cb00ac5334d7@web.de>
 <7f782cbd-7353-7573-7768-e61a2c885c88@tin.it>
 <30fdc0c6-d807-c062-2e98-c63f3a9d55b7@web.de>
 <641ab944-2cda-0f4b-00bd-73bd553495bb@tin.it>
 <ab51d02f-3403-7057-4403-f704ae278e74@web.de>
 <b8a7ea5c-1412-1bc6-8684-e8d2eacb2274@tin.it>
 <1c345c13-bd40-b8b2-31c0-0fd87ab95162@tin.it>
 <adcd0951-2bef-64b3-62ff-de30641538fb@siemens.com>
In-Reply-To: <adcd0951-2bef-64b3-62ff-de30641538fb@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df98477-6d3b-4a5c-db88-08daf27805ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QH+P/GosuOZM4P0oeO2tYHlsF9nE7l4qfzxqS0XW16SBReHXIhmUwNumLypZiNE4j8zStc3bMK6oC66ijUteGBWUztEs2gefIpIr7+KxSqtsXQdr5UMbdudgMGhwBT2E9YRH+Nh4Zj2giGESWQDQVi61ZMmpRMv19CgO8M+4jjQiUSKc4rKwJInwrN8Dp974+g1/rDNaWe25j3v7iQa2RVcK212EYa2VZPq/pw3PSk2C9fzDadBFKix/OnLVv4HeQwMnkZE7pbZHSeAGiqsgQiTq9HtWyfVxZ5Ix7y3CIcUr3+jlbT9i0nujP6ixSV/1fJlwROv1MsAneeEAiqEhGecp5UaNuOp4kgYrTdT8HbHTQDB1RMqX05dlk2s1nkF3HlAg2R6tDaSWDk6jgfGIhWsuzwFnbdoKf/2J4MO21qgsJcunVZtNa9bmZoojHwWjwcMIiBhirRgpVAOWwxVVYsJT+Emk1L1IXZtOPYKPZI4gkoKXqcE1cuOZJs/g+ecd3/X8GuyaC8+ZrQVXWfAOrQ4RPD9gHxZqtQVGJRmlBoTTYfjSnJs7rNVsZOWXUbcjN/prGekuKzXi+rtjoRBqjvBzwh6qBI4WdvrR/NlpNQV25Mo/mKXn989IkjAs6CYhXX52rfNWqn5UaZwbpd2GQYfwyRzCTSDfyZrzxc/s/QOqud9AfcpOzAYpYCYMH5QUrfuZxJjOsh8/82pvZMLfSo2okLFjJRPytvhscQXjzf4ktNxvmwQtjCFsMuMFT9hD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199015)(31686004)(36756003)(31696002)(86362001)(66476007)(8676002)(41300700001)(66556008)(66946007)(82960400001)(38100700002)(6506007)(53546011)(966005)(26005)(6486002)(478600001)(186003)(5660300002)(44832011)(8936002)(2906002)(316002)(83380400001)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjgyNG1Qa2F4WE15RVNCd3p5WjhzMmVsZGN3UnhvenVSd1JWT0RNWUhBWW1t?=
 =?utf-8?B?YXo2by93RFlib1pFbkxUVHZyeGNLbFcwRStXNE0wKy9iY2pSWEtPNGVsbzBX?=
 =?utf-8?B?bXhuQ09jS3A3SllmYThxRTVldDRDeE12emJFVnl0c3Z0RXo1TVNHTi8zUG5k?=
 =?utf-8?B?bnNwWTR5Vy91Q1R2dkF4bVR3QzgrdS8vUkhIRWJuK0Q3T0lpc29QOFF0ZTFR?=
 =?utf-8?B?anl4U2xWS0FlaTZRU0llcThoZzhIbFlLY05KWVZBZytPalhsU3dNYmN5U0Iy?=
 =?utf-8?B?cnI0TGRuREQ5MEZWVmszcGdmcExDTHZmajRMU3hiVHFiVTVlWHpsYTR4NmZt?=
 =?utf-8?B?K2JUS3lWZlFSaDNRUEhiamtYZWoyeUtqbFZ5aVNmVVVZVVFtdUsyeDlJekhh?=
 =?utf-8?B?WnkyZ3JzU3lVanRtTEd5SmNKZ1AwQUg5ZGxTWWRGcEpyOXpsblBIQTd2RVdT?=
 =?utf-8?B?QTBYMm9HOWVsZUwzMzR0WkJYKys3bDk4ejNSM3hJOHhyVWVUS00wMXdFY0sx?=
 =?utf-8?B?RmgvT2NzVy9TTjdDZE1zWGh5b21uK2ZBU3FxZzJLcC9ac3ZTTW1oV0dhZzBJ?=
 =?utf-8?B?WTJjU2N1WGtTWWZRVDVnTnViOFA5RGgwdnlUbWFnRkVrczloVWF3OXk5NWQv?=
 =?utf-8?B?a21aZ29odEZ5OG5oNmpoVXJUV0Q2VTBvWTVWaXlIOWVsbHVFMzFzNjZMNHVG?=
 =?utf-8?B?UnhtSFZoelV4ZzlvU3IrUHhyQkdRM2NHLzZiWldmbTA5UHZlZUlKTExuQXEr?=
 =?utf-8?B?aUxuQmdvSWprSHIvM1RscGdLYkxGRWtlR3FXYzdLVkk1RU5wTm9DVzd2RHJM?=
 =?utf-8?B?SVRnbjI1T2xzenU2NlJoWVpaNGw2eFJkamsyRndTKzducWtTKzcweGZpSHVj?=
 =?utf-8?B?U01HMENsR2JjQXlkbS95Uk5PdHZyT3BBLzJpeFoyMXFNNEovSUVnVFhpb3RP?=
 =?utf-8?B?dXNjU3Vja1dXeGNyQmRpWFlrdm91bEVBTlB4RjEwRmhjQ09Sb1RTS3AwVkRz?=
 =?utf-8?B?dG8vZERmOENZWVVKZzBaK1FYZjBxdFZkazl4alRtLzBkdTFjc1JVUnRXajRT?=
 =?utf-8?B?ZXROOGlFeWRzaUZOWUtEVWFjbEJ0aVc0UFFVTWtpQ3dUTzNuOXBQeU5SZVRq?=
 =?utf-8?B?VnQyZlR3L2prY0lPbUVDZ0ZnbXJVbW1XZW54QmgzTXFkenpBMGYrb1FpVjBJ?=
 =?utf-8?B?Z2NFV1Y1VkZmTWkxbXI5R001eTdiK1BLSSs5K2wrWFFSWkQzUDliVEp0ZTVQ?=
 =?utf-8?B?QXZnanhtNlgwUWd3YVE2Q0ZGRVFwV1BUWVJWSkhoOG9GQTZ1bUNtUUFTcGJO?=
 =?utf-8?B?eHZkM29uQTdqeHh4WVROcnFzR1hqcERoQ0d6RzZaSk5mbmtFOXErZEk1dHA5?=
 =?utf-8?B?RXZ0TzhlNEtyQWZSRVJpbnNZTUYvMFQvQU5wNURtU3Nrbzl5Q3pKek0rSXJW?=
 =?utf-8?B?WTVJUTZ2K21BZXZlZVowa1pXSWxpeGhqM0VrTnBLZUc0R00xMXNGN1hlUGxW?=
 =?utf-8?B?N1FmVDMrQU0xbko1aGhQazFRMStER0R4NzJmS1JhYmttbmZ4QlR3bXpNU1pC?=
 =?utf-8?B?ZGVaU3hpeGppdm43Z3RWcG5YSUpaTWZDbS9ldG95dGVnc25KSWhrMmtoNWs2?=
 =?utf-8?B?Z1FTaVVGSzRwVUt2cnljeHRzY1J4RFQxY2QrK1lZYUlqSzZXaktySUdBVnpk?=
 =?utf-8?B?V3UzcU5GQmdJUU9XZVd2V01jS1V4dWxwS0JOQUROWVlZY2NaKzBqczEwSFZv?=
 =?utf-8?B?R0VEanhQRUJyblJLZi95azdwVXVHVmJyZHgxWUppZ0hIZElJRE1WNGo1aEFr?=
 =?utf-8?B?OGRQNk9NUjYrbzIvekpkc3RYQVY5Wmo2Szcrb01IQ1VoajVrczkwallSQVZq?=
 =?utf-8?B?U2xXZDhjbGlxUHUvTVZweER2VjBOSFdwQUt4NnM2YTdkcWJLZ05nQVNXTU13?=
 =?utf-8?B?LzFNTDFyUDk4UllIT0xvQ3lybFJtNVpXUVZpa3VQbXVTYlhFamxTNlY3NXV0?=
 =?utf-8?B?L2VMUCtReDVxZ0FNWkNOTkM1TXNQbFQ4UFZvOXJ1eVVmY0N4a3VFa0N4QW85?=
 =?utf-8?B?ZTA3djJicnNXWlN0bk9MT0R1SVBOMjNZVmRzS3M4eURYT3RCbjhIQUwwZjdD?=
 =?utf-8?B?RnVCdlQrbFVxV2lZc2lUOEY2YlFrWmVCNkxiMTlRaEhqZms2NUVoZjM3MUdh?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df98477-6d3b-4a5c-db88-08daf27805ca
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:30:53.5059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4573malm3d4F1yOgcYtGJM14rxm8yTjlAHpZ7LuxCqdzooRbZSnrzBAbcgVOeovDZ8Sql0TsSO3r3QCIix4Dqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6996

On 09.01.23 14:00, Jan Kiszka wrote:
> On 05.01.23 21:25, Mauro S. wrote:
>> Il 22/12/22 16:42, Mauro S. ha scritto:
>>> Il 22/12/22 15:11, Jan Kiszka ha scritto:
>>>> On 22.12.22 14:57, Mauro S. wrote:
>>>>> Il 21/12/22 17:04, Jan Kiszka ha scritto:
>>>>>> On 21.12.22 16:25, Mauro S. wrote:
>>>>>>> Il 21/12/22 16:11, Jan Kiszka ha scritto:
>>>>>>>> On 21.12.22 15:57, Mauro S. wrote:
>>>>>>>>> Il 21/12/22 15:48, Jan Kiszka ha scritto:
>>>>>>>>>> On 21.12.22 15:45, Mauro S. wrote:
>>>>>>>>>>> Il 21/12/22 15:29, Jan Kiszka ha scritto:
>>>>>>>>>>>> On 21.12.22 10:05, Mauro S. wrote:
>>>>>>>>>>>>> Hi all,
>>>>>>>>>>>>>
>>>>>>>>>>>>> I'm using Xenomai 3.1.2 on a x86-64 Atom processor, with
>>>>>>>>>>>>> Copperplate and
>>>>>>>>>>>>> pshared enabled. Linux kernel is 5.4.181.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I have a main application, and another service application that
>>>>>>>>>>>>> connects
>>>>>>>>>>>>> to the main one using shared session.
>>>>>>>>>>>>>
>>>>>>>>>>>>> After some time the main application is running, the service
>>>>>>>>>>>>> application
>>>>>>>>>>>>> stops to connect to the main one with the error
>>>>>>>>>>>>>
>>>>>>>>>>>>>          0"004.166| BUG in main_overlay(): [main] failed to
>>>>>>>>>>>>> allocate main
>>>>>>>>>>>>> tcb
>>>>>>>>>>>>>
>>>>>>>>>>>>> Digging a bit in the code, I found that the failing function is
>>>>>>>>>>>>> the
>>>>>>>>>>>>> xnmalloc() call in
>>>>>>>>>>>>> lib/copperplate/threadobj.c:__threadobj_alloc().
>>>>>>>>>>>>> If I understood correctly, this function tries to allocate some
>>>>>>>>>>>>> space
>>>>>>>>>>>>> from the shared heap. But the shared heap is almost free
>>>>>>>>>>>>>
>>>>>>>>>>>>>        # cat /proc/xenomai/heap
>>>>>>>>>>>>>          TOTAL      FREE  NAME
>>>>>>>>>>>>>        4194304   3616512  system heap
>>>>>>>>>>>>>        1048576   1041776  shared heap
>>>>>>>>>>>>>        1048576   1048480  private heap[14505]
>>>>>>>>>>>>>          36864     19968  xddp-pool@0
>>>>>>>>>>>>>          24576      7680  xddp-pool@10
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> This is the code that triggers the message:
>>>>>>>>>>>>
>>>>>>>>>>>>              if (pthread_key_create(&threadobj_tskey,
>>>>>>>>>>>> finalize_thread))
>>>>>>>>>>>>                      early_panic("failed to allocate TSD key");
>>>>>>>>>>>>
>>>>>>>>>>>> pthread_key_create has nothing to do with xnmalloc. That's a
>>>>>>>>>>>> plain
>>>>>>>>>>>> glibc
>>>>>>>>>>>> service, and its documentation says:
>>>>>>>>>>>>
>>>>>>>>>>>>             The pthread_key_create() function shall fail if:
>>>>>>>>>>>>
>>>>>>>>>>>>             EAGAIN The system lacked the necessary resources to
>>>>>>>>>>>> create
>>>>>>>>>>>> another thread-specific data key, or the system-imposed limit on
>>>>>>>>>>>> the
>>>>>>>>>>>> total number of keys per process {PTHREAD_KEYS_MAX} has been
>>>>>>>>>>>> exceeded.
>>>>>>>>>>>>
>>>>>>>>>>>>             ENOMEM Insufficient memory exists to create the key.
>>>>>>>>>>>>
>>>>>>>>>>>> Already checked THOSE conditions? Are you possibly creating
>>>>>>>>>>>> threads
>>>>>>>>>>>> without cleaning them up completely?
>>>>>>>>>>>>
>>>>>>>>>>>> Jan
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Hi Jan,
>>>>>>>>>>>
>>>>>>>>>>> thank you.
>>>>>>>>>>> Sorry but I can't figure out how the code you specified (that
>>>>>>>>>>> panics
>>>>>>>>>>> generating the message "failed to allocate TSD key") could
>>>>>>>>>>> trigger the
>>>>>>>>>>> "failed to allocate main tcb" message.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> https://source.denx.de/Xenomai/xenomai/-/blob/v3.1.2/lib/copperplate/threadobj.c#L86
>>>>>>>>>>
>>>>>>>>>> That's the only line in Xenomai which raises this message. If you
>>>>>>>>>> don't
>>>>>>>>>> believe it triggered it, start your application in gdb and put a
>>>>>>>>>> breakpoint on that panic line.
>>>>>>>>>>
>>>>>>>>>> Jan
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I believe thet this code triggers the message "failed to
>>>>>>>>> allocate TSD
>>>>>>>>> key".
>>>>>>>>>
>>>>>>>>> But I get the message "failed to allocate main tcb", that is in the
>>>>>>>>> same
>>>>>>>>> file, but at the line #1790.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Ah, sorry, you are right. Didn't read careful enough.
>>>>>>>
>>>>>>> Ok, no problem :-)
>>>>>>>
>>>>>>>>
>>>>>>>> Could the heap be fragmented after lots and lots of
>>>>>>>> allocations/releases? But what is also a bit strange is that the
>>>>>>>> main
>>>>>>>> thread is continuously mapped. Are you restarting the main
>>>>>>>> application
>>>>>>>> for every request?
>>>>>>>>
>>>>>>>
>>>>>>> The main application is started once and keeps running, but
>>>>>>> internally
>>>>>>> creates and destroys many Xenomay tasks.
>>>>>>>
>>>>>>> During the main application lifetime (that can be long), the service
>>>>>>> application reads some statistics from the main application, prints
>>>>>>> these statistics and exits. Then, the main application is never
>>>>>>> restarted, and the service application is restarted for every
>>>>>>> request,
>>>>>>> that happens every 5 seconds (but the error seems not dependent on
>>>>>>> the
>>>>>>> service application restart period length).
>>>>>>
>>>>>> Ok, so the service applications are mapping its main thread against
>>>>>> Xenomai, and that as pshared apps using the shared heap.
>>>>>>
>>>>>
>>>>> Yes, exactly.
>>>>>
>>>>>>>
>>>>>>> On another device I have a similar (but not same) main
>>>>>>> application, and
>>>>>>> the same service application, and this problem does not show.
>>>>>>>
>>>>>>> Then, the problem should be located in the main application, but I
>>>>>>> can't
>>>>>>> figure out where the problem could be.
>>>>>>
>>>>>> As the allocation happens against a shared, global heap, the issue may
>>>>>> be global as well. You could either try to trace the
>>>>>> allocation/release
>>>>>> pattern against the shared heap and look for anomalies or even factor
>>>>>> out that pattern into a stand-alone reproducer.
>>>>>
>>>>> Thanks for your suggestions. Trace the allocation/release pattern would
>>>>> be a huge work for this application, then I started with a simple test:
>>>>> enlarge the heap sizes.
>>>>> Before I had a 4096kb system heap, 1024kb shared heap, 1024kb
>>>>> private heap.
>>>>> Now I have a 8192kb system heap, 4096kb shared heap, 2048kb private
>>>>> heap.
>>>>> Nothing, the error happens again. Could this be a clue that this is not
>>>>> a fragmentation problem and could be a heap corruption problem?
>>>>
>>>> Not impossible. The control structures should be heading the allocated
>>>> memory blocks, thus could get corrupted if some other user overwrites
>>>> its assigned block.
>>>>
>>>>>
>>>>> During tests, I also noted that when the error starts to happen, no
>>>>> tasks in main applications are created/deleted. But there are some
>>>>> queues and pipes communications active, then the heap could be used by
>>>>> them.
>>>>
>>>> All objects that could now be used across processes are allocated on the
>>>> shared heap if pshared is on. So we are not only looking at task objects
>>>> and their life cycles.
>>>>
>>>>>
>>>>> I will continue investigating on this problem. If you have some other
>>>>> ideas/hints, I'll be glad to hear them.
>>>>
>>>> Try reducing factors that could contribute to it, e.g. the types of
>>>> objects used. That may help narrowing down the actual trigger.
>>>>
>>>> Jan
>>>>
>>>
>>> Thanks Jan, I will do some tests and (hopefully) come back with results.
>>
>> Hi Jan,
>>
>> sorry for the delay.
>>
>> Attached there is the code of two small test programs able to reproduce
>> the problem. There is also the script to start them.
>>
>> Briefly, the "xeno-test-tcb-allocate-mainproc" application creates two
>> rt buffers (request and response) and waits indefinitely on the request
>> buffer. On the request buffer, the "xeno-test-tcb-allocate-secproc"
>> writes a request and waits for the response on the response buffer. When
>> the request is received by the "mainproc", the "mainproc" sends a
>> response with an incremental counter on the response buffer, and returns
>> to wait requests. "secproc" receives the response, prints its content
>> and exits.
>>
>> "secproc" is launched every 0.5 seconds. After about four minutes
>> running, the "secproc" starts to fail at launch with the error
>>
>>    BUG in main_overlay(): [main] failed to allocate main tcb
>>
> 
> Thanks, reproduced, now trying to understand.
> 

We are leaking the main tcb on the shared heap. That heap - and I also 
regularly forget this - is not tracked by the kernel but purely in 
userspace. Enable the registry, and you can watch /var/run/xenomai
/root/test/system/heaps going up with every secondary call. This seems 
to be needed because the normal pthread-key cleanup handler is not 
called on main exits:

diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index f4588a17a8..56d0f1b231 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -1770,6 +1770,11 @@ int threadobj_set_schedprio(struct threadobj *thobj, int priority)
 	return threadobj_set_schedparam(thobj, policy, &param_ex);
 }
 
+static void main_exit(void)
+{
+	threadobj_free(threadobj_current());
+}
+
 static inline int main_overlay(void)
 {
 	struct threadobj_init_data idata;
@@ -1806,6 +1811,8 @@ static inline int main_overlay(void)
 	threadobj_prologue(tcb, NULL);
 	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
 
+	atexit(main_exit);
+
 	return 0;
 }

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

