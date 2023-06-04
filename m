Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3334FC17
	for <xenomai@lists.linux.dev>; Sun,  4 Jun 2023 19:42:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7gW/mPUKdPyI5E8x9ipN1qPWsToyyb0hcO8DioH1fGr+GcwxM3ZYOlO89iA+l7JU4IBT+CZCPROol+gPFAIsDj937hZXsz68fAmLuRV3t/yzU7/8Y24PIXXycoCdp75wK05Xx2+sPO5NjyNuDSIhmoU+M5X7cbYkQtCOoeMaLQgBTRCIc3FFmqpJmKEDOUHXcIDYH4jYbXZZbUdfqmXB59v+1AhR2nPjCEKxGeT/6SVvjc9Lof2dG0c1TT+xbnDXoiGYamPVr7OiBrfLrYeXnCRjM8dSPBN3741gkrO2AXRFjM2IVN1RAqSrjOocBcrtzGtJZB4KJJeAbymJgQ3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4aGvcI+JMu1slpcTOVDLJViS0jObp31vir6lvtXRQM=;
 b=Dw0JhYe/EZiHFqWIact89ld6/fiWyQJ4ONRvW85N3kEDHXYS8SXYFz/WO88aM4NGjflR/+U3glbB4HY5E0FD9RiO9drLJsOprh6hdsviYVUlmCSylk3qnPxdPHH9CWIzbp9GDer7owOp1QSwAoicyBvC60ByOGz+JKKCcnbevqoqpf84abRXxrJxWUDaKzviDR2TnFK2HcjOb25Dkgd8yYVRJvQ2eN5cDDXVqcqqlEKjL8ijOnQGfoKyMq8pQ5JRCgvid11ptX2p66901DrUyZ/Sh4iW4sAUJSNaDX8n1FyZwxG5xA5j35/AT13ekE17IRSGy/bYw+jONLM3VlJ0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4aGvcI+JMu1slpcTOVDLJViS0jObp31vir6lvtXRQM=;
 b=O6J6I5gutKi4FArGsXxp6QAnQqA/WqdXHqLd8Jga6uf6ARv+/afySKXrTLUl40AqghUJeQVvNKItvaiD0CjQ5fCsBs3zu756QDCTo5vze5iqpIRD1XBvJr/X2rcGxUhjLWhD9v5Rj+Hb18ptY4w3irB/qbD68+KhaKBQeQIVVVEsz0r8wK+0DTBLBWSPmeDmFvVeVzA9AgsTulQRHK+HWiXv8hqu2PJ+1kqfl8e09WAwil0P498pO/Sm/FcaRMRY9O/TZI0u8/gFI08OEThk1mPGoTpb3PJjXqu6YzEF2dMbW2RkGL9h5+y/RghWB04CIvH1XpVl/Krb3kwnuJWlPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8303.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Sun, 4 Jun
 2023 19:42:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.030; Sun, 4 Jun 2023
 19:42:08 +0000
Message-ID: <d1d58b04-25f9-78a2-c244-db16e67bae9d@siemens.com>
Date: Sun, 4 Jun 2023 21:42:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Secondary Mode backtraces
Content-Language: en-US
To: C Smith <csmithquestions@gmail.com>, xenomai@lists.linux.dev,
 Xenomai List <xenomai@xenomai.org>
References: <CA+K1mPG0PPv6vus7jOraBVJ1cQHoj3XnJcOud7v_7iNO5QyuVQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CA+K1mPG0PPv6vus7jOraBVJ1cQHoj3XnJcOud7v_7iNO5QyuVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ef1030-6826-4834-0264-08db6533c877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jg6a1OY1fro1nv3ZTxzD1lX4X4iimwoh39nePkG6rVf2oeWaRsQmAv4lMN7nGwhvewa6JIahLyuungWxGQhfsTAGFhNLZOUS5pigAmtD9gKSUTs5kGRPm9GfRnrMGOQjgCsYd8npDVefuTF+Okg41a4tEKMlgNZs5qg28RO12mDDmkXZI7ciC0d2MHAXkJB1z7kGXSZsVWmIz2aoz/ndPZ1WWrhjT+llUiwVTIj5NGz9m5Fn8GqhqX1vmDxshjcxV4s7+J7PTft/JuKYnhWnVW9xcMs8NUUy546i1D/n+7n2pOw0xeqJ5q0zWgQidN78xRbtfOGeslVfQ7KOk6Tzi+1totE1rk3KYcyHcXv79ggDsHrRRYNzRESwRMgiUC/raJwVJ9QtX596NhOw+krFQTT0LopRkrkdIMhZasXJC41s61tR2p//K+eeqV4u3WUCMMfenjH3TOus7cI5r7FOYYzZ0cEBq4Ju7t6XNJ2hmCQsM3a3sOwBJQ34NK10CwFCHdJru/77EIIF3kYkKnFvVQOfkS2JhRIj1wBSmN4lWN7cfkdHEsuQXyhSxpZvrJDS19FnWuHGj3CSkKkp4lb3gArb18pgYulBdRrPNOdn6kFtg7X4++umTW7JbI5qbgGMFForG+ZWDjSncGQezT7AZQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(186003)(66556008)(66476007)(316002)(66946007)(31686004)(3480700007)(7116003)(110136005)(41300700001)(44832011)(5660300002)(8936002)(8676002)(2906002)(478600001)(82960400001)(53546011)(6506007)(26005)(6512007)(31696002)(86362001)(38100700002)(36756003)(6486002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjBVVm9YMWFaL0VMWEtkeTBpNENkOWNROTNoU0Q3OVBSay9MZE43SVZmWVA2?=
 =?utf-8?B?YjhoSkhjeHBwclVKVFJzM3pnYTlyN1lyQzRCVEpCaVNCM1dlMEgwV2hudjJi?=
 =?utf-8?B?cDl3QTZDdHp1L01ETmtqOThDMUh5bXBiT0NTZENQQlpwejkzMXp4eHBKT2FM?=
 =?utf-8?B?Y3VscXZkU2JEQWZBVU5ZUnNYSmx4dVNnbzRRL210SnVrUTFQdXQ1SWR6UTZ6?=
 =?utf-8?B?alFYUHJwSGNKZzNHR1V0WE1YQjQrc3M4M09JTmw4c0xrRHZWQmFNbmJPUTNR?=
 =?utf-8?B?NkJaTmJIN2gzWTZJbUhhcGR6QjRuMnBERnpTcE5VeGpQdGhEU3paK0NIY3d2?=
 =?utf-8?B?d3ZKZmQwKy9YUnlobWF1UzJHQ1pBREJreDdmeXM4T3lIL3UyMktydmxGVi9G?=
 =?utf-8?B?UlBxOVU3Mm5ITlZwdjNBWWVxY1hhK09QSkZmM1B4U2ZncGJCSVdvWlpYbVdm?=
 =?utf-8?B?bWtDMExpZEN1VHNxWTJvQjJyN1FVcnVBL1g1WmhrMStMZ3Q4T0R5ZGxnamNw?=
 =?utf-8?B?S08rNzlDQlpLMDJBZlVSVkhyNDA4RlBuRjJWMnRYY3VVL2hPOHYrMnlpNlMx?=
 =?utf-8?B?ckdvWXZ6bGx4L3FHREUybTFHVnpyMXFXWXY1Zmg3VmpicnNJcGZDK3pBcnF6?=
 =?utf-8?B?TkxBWFBycDYyRys3c2xobVZvYzgrZzBjNFhJN1FiU0h4bzNSdWxoZ1A0OTlW?=
 =?utf-8?B?UU9xZmVMVkxYK3RtcU5OUlBOdWpOTkNxOW1NR0tyNlNwcFlFRzRnTWJrcGN0?=
 =?utf-8?B?QXNVVS92VXpQZGtxRHZRZDBWZmdWaXFBaGxpRjBhelI5VGN4UllFRm9YN25O?=
 =?utf-8?B?Z094UHVCZitPN0kvazhwTTUrV0ZQd2tyVldEMVllMkF0K3ZrZGdIVVZIQzNu?=
 =?utf-8?B?clVHWkFoUEFtNmozb2dkZEdEcHdyM2FWT0hqa2xRVXVmcjdNTGRuRExnWGNx?=
 =?utf-8?B?MmNKRlpTdlpReEdzbHdrNmNsYkxTQVNNbTRuL3RqdExlRlVMNEwxVmNtUXdB?=
 =?utf-8?B?OTJSbWVnMkJBZ2xTU3U1OEgrN2JvU3IxTmUyQkx5d3FGREJTSkoyQ2pnREc0?=
 =?utf-8?B?YXpiaUdyZi9rM3lrakhkeUR1RW9ya1I3Myt4eTBCT2pQNXF0MzV3bEw5NWRv?=
 =?utf-8?B?VjVMcXYrbzh5a1d2RSsvY3hZQzQ1bENHSklaaVNoOEFCWWM5SkdDTWxMblZa?=
 =?utf-8?B?cWpNYkx6Ym1IbkIrWXJFSE5RYWpZVHRiVTVCNTlwSWlmcVI3TWFQK01ibWU1?=
 =?utf-8?B?L1k4MWRNNzVzZW1IYStnZnU5bEd1U1V5STl1MlJJckV3ZW54UFY5WVVnV0Rv?=
 =?utf-8?B?RUQwOHRiSFd5YS96WmZTb0xldHJyRCtXY1doaDN3S0Q1NmRTdnoyeCsvTkMy?=
 =?utf-8?B?d3VwcHFSVjJrSUdQWGs1OTd6NWx6b3R3K0tRMUtuYWZNVDV2ZjlWcVgrUXNq?=
 =?utf-8?B?dXk1YThWbmorKzVQZFVvRXM3RHpTNU5idzZ4Nys0MFhDWmxRVzVZUm1FcVVr?=
 =?utf-8?B?YjAyNXZaQ2N6Uk8xVm9iQXdLR1d3elNNNXU2RldnOVI0djF4Y2RTSmUxcitQ?=
 =?utf-8?B?bDlmVURrajRpTDVqUzkzdWJ2MjZvaTFpUUd2VWZOMzNqa3lUemNzdDAvK0ZZ?=
 =?utf-8?B?ZEFtVUFoRitqd1ZhNmVKMkFhNWNHeDliNzdxNGxjS2NBNXlXVVhsbzJnU3ln?=
 =?utf-8?B?bDJpSGhRNnJhT2RNcXJqcGhsbE14czZBMEc4TStsMVBBVXdBTzNaUzloZHJ2?=
 =?utf-8?B?V1hPK0ltSmJhSDQ3S3hIb0FpeTVObkpocS83Yzl1M3NZcnVNRFVyeTBQY3dI?=
 =?utf-8?B?Y25ZL25jaXRrbHEvSks0RTRjUVJmOVlOMWRneitUNGJIUS9jYVVMaWI1eDhx?=
 =?utf-8?B?RHNTbDJ6Q01VSlRFT0pJby9NeWRwNThaaFlRdlFGYVlNTVFqUXZXM0FSd1hL?=
 =?utf-8?B?VVB3V0JRVWNmcURtUVlWK01weUdoWXhFYlhNOTFNSUN3K3dBbUZuY05lSjc4?=
 =?utf-8?B?UmNXT0lSVTJUbXdYT056aGg5cVFMQjBJVFZad3BHWm5JSy83VEdHM0FhMzdr?=
 =?utf-8?B?bDRyZFg1OUlST3NGMHRNQVNRQ2dIYXFKcWZCMk1CTHpDeExWYVFaajlrK2Va?=
 =?utf-8?Q?8+cOnAwhwgVwlU2sHZKKAWfUe?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ef1030-6826-4834-0264-08db6533c877
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 19:42:08.5102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wig55afkceH/jVi9JLOjQmr4dkadWa6L16734Qva21hrWehu62U5KgVmzn2pYTyU0q5II/1pmQvT7GyJvMxkvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8303

On 03.06.23 22:38, C Smith wrote:
> I have RT userspace app which is failing and switching to secondary mode.
> I'm wondering if there is a way to get a more informative backtrace in my
> SIGXCPU handler.
> 
> I'm using xenomai 3.1.2, kernel 4.19.229 on an X68 CPU, and my app is compiled
> with -g3 debugging symbols, it is not optimized. I have a signal
> handler to catch secondary mode:
>  signal(SIGXCPU, warn_upon_switch); // in case Xenomai switches to
> non-realtime mode
> I just added code to generate a backtrace :
>  warn_upon_switch()
>  ...
>   nentries = backtrace(bt, sizeof(bt) / sizeof(bt[0]));
>   backtrace_symbols_fd(bt, nentries, fileno(stdout)); /* print
> function strings, offsets */
> 
> I am now running the app and waiting for another Secondary mode
> switch, to get a backtrace,
> but the time between the last two failures was 7 days.  In the
> meantime, I did a test where I forced a switch to secondary mode (by
> calling glibc open()) in an arbitrary place in my RT thread,
> which gave me a backtrace to investigate:
> 
>  10:23:22.843077: /xdevel/bin/my_app() [0x807cbf4]
>  10:23:22.840927: linux-gate.so.1(__kernel_vsyscall+0x9) [0xf7f6eb69]
>  10:23:22.841009:
> /usr/xenomai/lib/libcobalt.so.2(__cobalt_open64+0x3e) [0xf7c74b2e]
>  10:23:22.843335: /xdevel/bin/my_app() [0x807c98e]
>  10:23:22.843410: /usr/xenomai/lib/libcopperplate.so.0(+0x5405) [0xf7c91405]
>  10:23:22.843486: /lib/libpthread.so.0(+0x6e99) [0xf7c49e99]
> 
> The first line of the backtrace referencing my app is the second line of
> my SIGXCPU handler - not helpful. The second reference into my app is
> more informative:
>  addr2line -f -e main/my_app 0x807c98e
>  Periodic_routine
>  /home/xuser/src/xdevel3.5/my_app/main/my_app.c:24057
> 
> That Periodic_routine() line 24057 is the line just /after/ the call
> to my function Find_devices() in which is my intentional switch to
> secondary mode.
> So the problem is that the backtrace did not catch secondary mode on
> the proper line inside
> Find_devices() but it blamed a line just after that function returned.
> 
> * Is there any way to make the backtrace more accurate, like an inline ASSERT
> or something?
> 

Did you try backtracing from the signal handler using gdb already? Also,
there is a smokey test for this (sigdebug), though not for the accuracy
of backtraces. Maybe worth to play with that as well. I suspect the
issue is which the symbol information here, not where the signal is raised.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

