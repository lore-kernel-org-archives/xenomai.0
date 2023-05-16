Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16123C3
	for <xenomai@lists.linux.dev>; Tue, 16 May 2023 06:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUNBKIdWb0XsF3knWgWFfDaoOopVxlk3GKAHQXWm/0bPDybQLr+V7pvzUdXn5XehlYSKtNO1B0ZjisuEYYLCrTBt/4h1uXED7fVUG7QTvCqZscgGkwjl/2yPc5nxMfSmSx8X/3/fHpZhEyKnTBGQ0/VzDg39DtgFcUV0vSqZDWlAH1+KnD1E9nNUmT6te3f7eX4HrploQ2//RxRTWN01EDwesOTwiWGDt2JEccildkhos4oy1mBjvfdru0iw3ZLoS7RvQ3MC571ywOvDO3b4tnIdDBoDyKqe6je1OYkp9j9Vd9V81KkOmxBZ9ySzv0W+Xf/8YdGm7KFP+fA+JqzJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS5L88MW730AlwbyIZx5TqknpceOYoPZ5rpd38NEK9U=;
 b=cHLdy54RSfQAJrlBRiwAFJgxoEMf8bCUE5tN97n14wyGrsELz74Neh/6MBNb2OELXIkU9OU0lq6l8/2f+UI0provP5BjmjzcNwSpaT80Djj/Fm5R/BCNjL0NC3Uhdg5WrKg0ZyoX8PkzeOMIAh6nmp42w+OES/pux56C+66bfffvfUA5lumGFGJP7XZspUXj2pyQz+E5Yg7+RFuc3b0PZE6GSee8g+3S3SElvagNh3ZJah0ldKzyPNfY0bmO/eSQExadTqOVf1UUV4ibUBf6eiu+o4mEUIkGIWdpItMTdH91q5E7sRncCgHXcnhIDQB5Xi2l5YU25b4VJQY5EbBW1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS5L88MW730AlwbyIZx5TqknpceOYoPZ5rpd38NEK9U=;
 b=ZRnUbxvBW+5kZpZfaS8G+FKP2rRrcMLnuwCDizzpvClyXY9n1wm6Kdguem5g2vSXPdtBjhpGzvreRL2I25Rq0m61lUsB/gnEVpY8hVC5/ilu4BIEEEafZADsDX9s2xtB+iWSIMHR+uRr5JXZEL+g+/hrdRVlnYI0buDTeukOV1aYB06I3Nvdm3hZ7f05A8+0DTTmnHpPk1/aOpi6R1lqbRIwbCeZoMbDowtopTCCQmw7yyfUgs7fbm8RjpxaJl5FRfsJlYotV9VH8L6buSsk0H19GPtq7J6S3sRXwKA+9Na2Twuzpvgggzk7UcHvN2SuxzKRnmdTY7h0oK1uTpzxEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3287.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Tue, 16 May
 2023 06:52:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.032; Tue, 16 May 2023
 06:52:43 +0000
Message-ID: <b02f4b5d-0efe-bb2e-0440-5ae7431bcf5f@siemens.com>
Date: Tue, 16 May 2023 08:52:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
Content-Language: en-US
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
 "Schaffner, Tobias" <tobias.schaffner@siemens.com>
References: <20230509131355.3003275-1-johannes.kirchmair@sigmatek.at>
 <VE1PR08MB4909999B96106DD25AE0D19D92769@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <7bb48d32-0c2f-18bc-8d66-cf969e6be74b@siemens.com>
 <VE1PR08MB4909DAD1B4F37E9F4D51B2E792789@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <6ef7cc61-bdce-6f7e-57e1-8a272f468252@siemens.com>
 <VE1PR08MB4909E886F447456685BA6DAF92799@VE1PR08MB4909.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <VE1PR08MB4909E886F447456685BA6DAF92799@VE1PR08MB4909.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:610:5a::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3287:EE_
X-MS-Office365-Filtering-Correlation-Id: c1985416-5db7-4994-dbad-08db55da2584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VMT78Kn1jbBurKF3il3Fe4MMD+0WT/0TYc/QSsaQRMzNmEoCX05Xp2eKBjwJxhfVnFvEfuy0GaOj84Xb8IYxw//WVg7/YWv0zSQBfke7piOo6TkBaZ/OQ9PsxJR7+J16IUVkaXwM/dDVKYiL2bI1S4ENgsXWYQM2MecNgH8a1xxnuUyH+r4+26g8/7wdEJ/k2czYJZiTWXLJf679G90bgZuSHe2nxhHUs48luBpT8apTN6NQXOov49lwcKIKaYf7naxQECop2f/e6eEZl5Tg71s4ftwf99mHEqPLWofQeqz3tXBWLfGVA1n55UkwlliCyXsc2N2O/FMKAId34rnN+c7Eb25YvNWIQpvOZnsVcNtRoAVo+M8GmxPOor9fW+6J1BciYc3DYZ/JlCuppk3iF1eZhm0FE8PC81XYvLpQ7d1tQxjmRVjgc3X+K/mz81+HiAesjhH4J3tOgM3roGmuAwuc/tNszRebFLc7Cz7mVg+MMNhn0OJhHIVmCr9xh/UA9zUVB8NguUa02mbkpz5qNw20m20kIp678AOtqtTPkaF+o2A2UX6fD7YijAvarfkIuagNuQEE30NjleHM+2R2LOc5ZpWdwh8eP0WWBMUaCtA6cjkzLE6Z962OH4JQWX5yBexhWWXIrSIqEkM++cAodg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(2906002)(41300700001)(478600001)(316002)(44832011)(110136005)(6666004)(45080400002)(6486002)(31686004)(8936002)(6636002)(8676002)(66476007)(66556008)(66946007)(5660300002)(6506007)(6512007)(53546011)(26005)(186003)(82960400001)(2616005)(36756003)(86362001)(38100700002)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VElnR2FYQ0tFRG5aRWt3UndZTkpWUkNBRkk1QUNzVWtJMU5lOUt0RlQyWTBW?=
 =?utf-8?B?ZTJOU3FGOUc3RVovTk8vMVVjaVFnOW9NVnhJUFdNZHJneWwrRkNEMUJ4a056?=
 =?utf-8?B?RjJtMVNGM3YwYlIyYWlYZFZhVy8wTEU1NWZwdzBGRGVqZ0U3akRZNE12WHBV?=
 =?utf-8?B?QTdsb090dFg5Zngrend4NERzYUQ5cUliTysyU21wS0EwRU1kWnpMdGFpNUd5?=
 =?utf-8?B?VnFRcUVSMnlhcTFsOHZ2VmE1cGM3RWhHdG9ZOGdlNlUzNmVIbnpTZFVhQzNs?=
 =?utf-8?B?UU9oRG1kTGUxZjFEMmJqc0Q2blpGcDgzTkdJTVVaZU1IUXo3cVY3emYrSmxM?=
 =?utf-8?B?TDlwcnFaRVpYOVRGTVN6WXV1ZVpMSXFqbGcrZXRxSVI2Ly9oVkxsbm1DY01y?=
 =?utf-8?B?YWgwSnNCSHpXQ2IxRjY0N0txYXlMQjJxVllZaFdIdnlYd01BelFmVnppUDZR?=
 =?utf-8?B?a2F5QXd3WkpVWG5ieXZuN1JSSlEwM2F2Y1pmbzNreFlkdmo0cy9hTGpJRGNK?=
 =?utf-8?B?Ukwzem51UmFYZXZDMFFJQzdFWDViVERPWWZyajRVM0lVVi9YK2F2Ym5xek16?=
 =?utf-8?B?dUFwQndpcWtBZmtuTDNYMUZ1MFI2M0JSYlhpL0ZXcnJ5bU85bkQrSjNNc2ll?=
 =?utf-8?B?aVNRK2xpdFdjSytrbDh6TmhHbm9mbjZoZSs4eXA0TVNZaHYvei8zVGszemJv?=
 =?utf-8?B?ZThvcEFnM2txWkFuV0dvSW1tWVU5dE9TczB4WkNhdjg0d3RwYUxUTnZNY2hY?=
 =?utf-8?B?VUk1VU1JSGpVV0ZSdFpDNVFJRXlJS3paV3hiVTNIQzRFRGNIUzl0Q1o1VzZs?=
 =?utf-8?B?b0pERGxvdjI2aG05UHY4S0VYb2tQSktudXd0ek5FMkVadTJpb0dSQlRodllF?=
 =?utf-8?B?Z21tZHBsV0FjT1VDWUxlRVhBYzdGbFNxK2ZoZ2cvYk11ZG5yR1I1ZFp1eUtj?=
 =?utf-8?B?cUpSSUhlL1BNd1NhVEtWNmlIUHNLeGpQQzlVaFdNRTN6b3B1VnIrRUxWTms3?=
 =?utf-8?B?b0NteXliMVhvSEUvMjZ0c2VjWDFFQnhJYUxpQmJiWE93dTJPZ3htMW8rdit1?=
 =?utf-8?B?bE04NVhBYnlKc2Fia1pYd3B0NGNqMGY0OFpXV1BLcGIxNXZuK2M2RmlJR09J?=
 =?utf-8?B?OG9tanlLU09iMUNCZVVvbHlUUW1TNjIyb0NjYldFS1pxa01XMUJ1WCtRT0k1?=
 =?utf-8?B?dVRRZVNGcUtOQTVtZVpoZ29adTJKTW52a2J0NHNEVmpIeTdXVFpPcXlxOVE3?=
 =?utf-8?B?V0s2TFNJdExyenp5VjNmd2JrSCt6dDExL2Rtc1F4T2V6OW9DM2NNejVYSjJ2?=
 =?utf-8?B?NjRNSWZEQ2s0T1E1OXlic2U4cCtZam40M3FXajI4MlplQWh5TVlwYVpKQ2c3?=
 =?utf-8?B?TGptZk9yVXgyUVh4WjZOc1BFb3dqUThqUWp5TVp4am1CVU0wcUl6YmJhYU13?=
 =?utf-8?B?TDhqS2VVbkp2Y0pBa3VBY0prQXg2YWtPemljcEc1cm10YzVIZXBhNjVCRytH?=
 =?utf-8?B?ci9QeDRRYmNDNVdUdDdDMXZXb1pRSTVYakRBWEhQVWR2dGtxeThjM1BFNW95?=
 =?utf-8?B?N3luR25UQUQ1YzZGeGJDZnRIbFV1VUx2OERTd2NsbW9BYXVjejR6Kyt4c0pZ?=
 =?utf-8?B?RnU1REFRMUpLSHJGREFpbmxkMy9hemVEUDRyeG94MkJ5TXFlU3U1ZUNucmJw?=
 =?utf-8?B?SlBzVHhCUDVwY0JHU0V0dkM2YXlKalpQQStuWFdMbitFOFd1aW5ta0VsZDBF?=
 =?utf-8?B?YjEwVlhWWHQxaW96STcxNk01UmQ4YjNwS3dHY0pscHdDOWUxbDdQdmJsOUl6?=
 =?utf-8?B?RUcrbDJvaURsaUFCbUVMN0RFU09Vc3NoWUhqWFhnSnlzSldqcDRkbGEra203?=
 =?utf-8?B?NkZ3ZDEvMFZVbUVoYWJaUXFrT3F2QnBhK24vM21zYnJ0bTZDTlh0ZUpDbWNE?=
 =?utf-8?B?ejdIYWdDZElxWmE0V0k2Y0ozNmlqSFVvU3dUTGNoc3hXOEhVVzZkWWZPaG5w?=
 =?utf-8?B?VTBTUEdPcjIxY2doeGlGY2R4VCtKNk5jN2d5OThKZUd0Sm5tUGFzRVhFNU5C?=
 =?utf-8?B?aVFHbkd6OXpha2hvQ2FkMnZhNE5hVzVSZ3k2Q2FkM0FnbWxwZXU5NkVrQmJF?=
 =?utf-8?B?T2YvUnB2N1llUGlSaEFZNmladWlVcmg5Ty9MZnJMa1RhNEhJdndGajZRZDJj?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1985416-5db7-4994-dbad-08db55da2584
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 06:52:42.8002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFqig0Ekr4ZLtZSDP+y2p9COJDQm4UiHEgqMMDxrFtoF+q9CrzcZw9HlD46uWbLsu1IYOASD+d9y7xx9/0XhAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3287

On 16.05.23 08:46, Johannes Kirchmair wrote:
> Hello, 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Montag, 15. Mai 2023 12:38
>> To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>;
>> xenomai@lists.linux.dev; Schaffner, Tobias <tobias.schaffner@siemens.com>
>> Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
>>
>> CAUTION: External E-Mail !
>>
>> On 15.05.23 08:50, Johannes Kirchmair wrote:
>>>> -----Original Message-----
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>> Sent: Freitag, 12. Mai 2023 19:39
>>>> To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>;
>>>> xenomai@lists.linux.dev; Schaffner, Tobias <tobias.schaffner@siemens.com>
>>>> Subject: Re: [PATCH 1/3] [POC] test implementaion of rt-signals
>>>>
>>>> CAUTION: External E-Mail !
>>>>
>>>> On 09.05.23 15:17, Johannes Kirchmair wrote:
>>>>> Hello Jan and Tobias,
>>>>>
>>>>> I just dropped the patches on the mailing list.
>>>>> For the dovetail functions I took a rather naive approach, using most of the
>>>> frame setup code provided by Linux.
>>>>> I just tested it for 32bit and 64bit x86 Applications and it seems to work.
>>>>>
>>>>> I also added a tool rt_signal_hist that runs in a cycle and measures the time an
>>>> exception handling takes.
>>>>> It is afterwards put into an txt file that reassembles an histogram of the
>> timings.
>>>>>
>>>>> Unfortunately as a 32bit application the rt_signal_hist tool does not run to
>>>> completion, printing the following:
>>>>> " Xenomai/cobalt: sleeping while holding mutex
>>>>> CPU time limit exceeded"
>>>>>
>>>>> Maybe the naive approach is not so reliable ;-/
>>>>> Hope I find the time the look into it.
>>>>>
>>>>
>>>> I looked into the x86 signalframe helpers before and found some traces
>>>> of locking that make them incompatible - if I rember correctly. After
>>>> that, I dropped the idea of just removing the "static".
>>> Do you remember where you saw the locking in the code, was it rather obvious
>> or hidden?
>>> When I had a look I did not see locking in the functions I used, so I thought
>> dropping the "static" would be fine.
>>>
>>> Would you still try to use some of the functions Linux provides?
>>>
>>
>> I don't recall too many details, specficially not which kernel version I
>> looked at. Maybe part of my concerns was that I started from
>> setup_rt_frame (rseq_signal_deliver), rather than x64_setup_rt_frame & Co.
>>
>> I was now digging into 6.3, and one area that is sensitive is the FPU
>> handling. We end up in fault_in_readable, and I'm not sure yet if that
>> is ok. The whole FPU save/restore needs a careful check, or more, if we
>> are not violating the assumptions of OOB.
>>
>> But did you run your code with full lock debugging enabled already? Did
>> you stress faulting sigframe setups/restores? That would be needed as well.
> 
> Yes, thought about activating debugging in kernel, yesterday. Resulting in the following kernel output:
> [   83.338288] ------------[ cut here ]------------
> [   83.338292] WARNING: CPU: 3 PID: 268 at mm/memory.c:5640 __might_fault+0x28/0x30
> [   83.338299] Modules linked in:
> [   83.338301] CPU: 3 PID: 268 Comm: signal_test_tas Tainted: G        W          6.3.0+ #7
> [   83.338304] Hardware name: Default string Default string/Default string, BIOS 5.19 04/28/2022
> [   83.338305] IRQ stage: Xenomai
> [   83.338306] RIP: 0010:__might_fault+0x28/0x30
> [   83.338308] Code: 90 90 f3 0f 1e fa 0f 1f 44 00 00 55 65 8b 05 57 11 24 6a 48 89 e5 a9 00 00 00 02 75 06 5d c3 cc cc cc cc 9c 58 f6 c4 02 75 f3 <0f> 0b 5d c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> [   83.338311] RSP: 0000:ffffafbc417d3cb8 EFLAGS: 00010046
> [   83.338313] RAX: 0000000000000006 RBX: 00000000df53adbc RCX: ffffafbc417d3d68
> [   83.338314] RDX: 00000000000002b4 RSI: 0000000000000060 RDI: ffffffff9782ead0
> [   83.338315] RBP: ffffafbc417d3cb8 R08: ffffafbc417d3e48 R09: 0000000000000001
> [   83.338316] R10: 0000000000000001 R11: 0000000000000000 R12: 00000000df53af40
> [   83.338317] R13: ffffafbc417d3db8 R14: 0000000002000000 R15: 0000000000000000
> [   83.338318] FS:  0000000000000000(0000) GS:ffff966e2e000000(0063) knlGS:00000000df53bb40
> [   83.338320] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [   83.338321] CR2: 00000000f7ee7080 CR3: 0000000006550000 CR4: 0000000000350ee0
> [   83.338323] Call Trace:
> [   83.338325]  <TASK>
> [   83.338328]  copy_fpstate_to_sigframe+0xaa/0x410
> [   83.338335]  get_sigframe+0xdc/0x2e0
> [   83.338339]  ia32_setup_rt_frame+0x67/0x2f0
> [   83.338343]  dovetail_setup_rt_signal_frame+0x43/0x50
> [   83.338346]  xnthread_handle_rt_signals+0xf2/0x130
> [   83.338349]  ? handle_head_syscall+0x179/0x550
> [   83.338352]  ? __pfx_CoBaLt_sigaction+0x10/0x10
> [   83.338355]  ? handle_head_syscall+0x179/0x550
> [   83.338357]  ? __pfx_CoBaLt_sigaction+0x10/0x10
> [   83.338359]  handle_oob_trap_entry+0x1b6/0x3c0
> [   83.338362]  ? syscall_enter_from_user_mode_work+0x31/0xb0
> [   83.338366]  __oob_trap_notify+0x2f/0x40
> [   83.338368]  exc_invalid_op+0xb7/0x110
> [   83.338371]  asm_exc_invalid_op+0x1f/0x30
> [   83.338374] RIP: 0023:0x5659868a
> [   83.338376] Code: Unable to access opcode bytes at 0x56598660.
> [   83.338377] RSP: 002b:00000000df53b1c0 EFLAGS: 00010246
> [   83.338378] RAX: 00000000f453ff4d RBX: 000000005659b000 RCX: 0000000000000000
> [   83.338379] RDX: 0000000000000012 RSI: 00000000f453ff4d RDI: 00000000f7ed3ac8
> [   83.338380] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [   83.338381] R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
> [   83.338382] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   83.338386]  </TASK>
> [   83.338387] irq event stamp: 0
> [   83.338388] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [   83.338389] hardirqs last disabled at (0): [<ffffffff95cb68eb>] copy_process+0x7fb/0x21b0
> [   83.338393] softirqs last  enabled at (0): [<ffffffff95cb68ef>] copy_process+0x7ff/0x21b0
> [   83.338395] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   83.338396] ---[ end trace 0000000000000000 ]---
> 
> Do you think, this is related to the message I get on execution.

I don't think so unless we actually ran into a fault in your 32-bit case.

This one here is unhappy that a fault might be taken with hard IRQs off,
see __might_fault:

 #if defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP)
 void __might_fault(const char *file, int line)
 {
+       /*
+        * When running over the oob stage (e.g. some co-kernel's own
+        * thread), we should only make sure to run with hw IRQs
+        * enabled before accessing the memory.
+        */
+       if (running_oob()) {
+               WARN_ON_ONCE(hard_irqs_disabled());
+               return;
+       }

> 
> Other question: By "stress faulting" you mean running tests while generating a lot of cpu load?

No, I meant constructing fault-causing sigframes or stacks so that we
actually take faults. Normally, the involved memory should all be
present and locked into the process.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

