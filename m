Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A857F
	for <xenomai@lists.linux.dev>; Fri, 17 Feb 2023 08:21:40 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 1366E20004
	for <xenomai@lists.linux.dev>; Fri, 17 Feb 2023 08:21:32 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2087.outbound.protection.outlook.com [40.107.6.87])
	by spool.mail.gandi.net (Postfix) with ESMTPS id C67C2740059
	for <xenomai@xenomai.org>; Fri, 17 Feb 2023 08:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=No6sQn6oTFj6/S470nlxQBGv89I/qKzBQGa3sTOBcsv+kbm+KOcxjtRWom4N8ItaTl9r4PdJ5zZNn4tS7QZ3R5Dw8MNjn53XEnXfGnnfyGX4IKnFYFI6zPNf2b46FkbH8298JnlCMwZnUGkkUZheIaFEX/6/HDBTU6Ggl6q5V57A+1mVz0rDaEfgyV6KBuURCicZbsNicZfv2jPjcpos8JJsVt2P6vvns2Ac3gjhFE0vx2HC0OsDVIRXtnO8HMcRKyrcOlGPKQFCSEUmQnUCzhkEaNvHiE+Jl2JaFAjeqadBfK6OaGe2xov64Uk2sdXZXc6rGKUqqEXPjkJSATEObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpyAu29gKmmfQ68Kcww0vS+sUDdgu7iWVMopG6qGarQ=;
 b=ncfb6U78eYcJ4cTd6Wh2oPbOuOakp7SEI39CJ7NLSMiK3hkuUwJtIH1+WMyGxw2OAgogcr8QylZihdzIzqB2lkl2BY2Rx/hQ1T07pubkMRT9jmSxAMpyAZPYNyKSZCFqU3KFmAc8QeEClqPjd0igl7ZbA4JdkZwl98sxYS3qtL5HqlgKFRT3s0brqZxEQ1cFzZqnBSobT0qGwfgzp/JOHoK2i/DgJEz/68VD/bxFT7X5zVnYkl3miPU4h2R2UIYsEa4HQFWbcf3v+H9lEdyVVCtEgBMVbr0AzGxoZhdhTtnZqmLiiIlIsH3ATI/l6ujUVbweEun9N0e6nMZTB1Q2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpyAu29gKmmfQ68Kcww0vS+sUDdgu7iWVMopG6qGarQ=;
 b=QzJf/l9fBGFiIRidE0284ouDMDEtEIUnV2OdA90I1zkJHiexTW5PZrM0wINQjpXRJYesS8q7S7pmySCXCuE96ej9h3joPmsoQhQUPrbNm38E99JUwJ/jMX4xz1lBEGCrFWmvYKqvKXe7nhrsZOzwaNDRW73HdQvVM9O2XHyQ/dkb30NMvfbVrGlxQ1ilUI5HBt4LA88e7i6NGiotnP50MaAfYgSuJog/GkvmhHV4NYrSEIQJFCjnO3KSFVCOYsjTr5Bhbty/Pahz56ikDGoV4PaIDmBQ6jHm4fxa36M9n2KEb2lLCUPGsuiNmSYKopkj7U+8OfuVHewdMTn/HU4sXw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3288.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 08:21:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 08:21:30 +0000
Message-ID: <e98f8ab5-0242-46e9-ba7a-e3235dd00292@siemens.com>
Date: Fri, 17 Feb 2023 09:21:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: I found the jitter was greater, when using the patch
 "cobalt/init: Fail if CPU 0 is missing from real-time CPU mask"
Content-Language: en-US
To: linz <powertree@163.com>, xenomai@xenomai.org
References: <6b1485d5-c10f-e607-916e-138b9d3ccf75@163.com>
 <fd22514f-1ff9-a413-ac64-7f5513885235@siemens.com>
 <b5410402-4c54-ac6e-63fb-3db8075b8589@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <b5410402-4c54-ac6e-63fb-3db8075b8589@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MRXP264CA0028.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3288:EE_
X-MS-Office365-Filtering-Correlation-Id: 8222d98b-9cea-424c-a9b2-08db10bff8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c9VFKBF3oElXoa690qIF+NXieu68M5YwcKQdt7MzOwRLRKEnP1UOUL4RvtkHP3FedsnEh0P90Zpy/k3IumcKYI7Rf3OpI8eCE4sTl2/k1TDZVSJ0yMTPgqjrj7Ps9bbrUYyRCyrJT2OJyGIIeoL0GBhMOHe4jSim9dcNyZ3sSuCfRfcz8/RpTJBWmg6sI5mptU52/jxJpV8M8jOc2yL/qteu8wTPH5uAKuocnEiWsTDRUtul7nRlDo2c5FUS9UMnwToxINHvIadh87oGdjG0JdYFjujLyn+YX4QMsFBwyJZnTT+PAi81lDQlJlwoRwDL9hXE8r5CstDxLzvs7fo3KctPxKLA7PDQzC2zv5WMuOoAfGH6CEm3dpstAQNZTiUQEOw1OZ7ieZAEVFXb10wRaJk3O0tW0dZrQGh7U8pFKxxDf4jwOnx5QHJWla4h6kFzqQLOGNloEyCfLamVsD/g1Lws9x9X+9v1Ah2Yvm5nhhVXci0/rWawGD47XgHHmTn9TqrsIBdd98RI8P4VQ6da3R8WHphZNmW3yXRetbrLGFrjcCukyP/ZYwXHES2JC1kHIu8vnxLz7Xr6ZMtmdUCMMLMkRK+owtp6UK1t68MrmoPW8rb4RfGajsgGVhMFjR66de4O4HHb/HWMDFkLw9XTqGStmzC14huDatLiPUorzbNJv2K9/xoV9WOcOoW2HbbRj7+XvVbQn38xhkEmzCAEsohISSloynm2aQFWB7Gk2zA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199018)(6486002)(966005)(83380400001)(82960400001)(86362001)(31696002)(38100700002)(6666004)(53546011)(6512007)(6506007)(186003)(26005)(2616005)(36756003)(5660300002)(41300700001)(31686004)(44832011)(478600001)(8936002)(316002)(2906002)(66946007)(8676002)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFNqQnB6VkN4UW91Wm5BSytuYkZyRDcrd2ZMMmg3Q2V3dzRCMTBzVkFxbjhZ?=
 =?utf-8?B?QkJDdEIzWmxyOU9wR081SHB0TVc4Qm55V1lMTmM2WW5iWkdURTl2d3UzdW9W?=
 =?utf-8?B?WlZRSGJJWUJUYS9BL0laMDdUZkk5cGtzN1VWNkZ2cXo0dWkyRWJsNWYyNFZ3?=
 =?utf-8?B?OGlrbjN6NTVSbUNCZCtmeis2K0MwMzVRM2F6Q1pUZEJiQ2xOZ3FoWWV6d2cx?=
 =?utf-8?B?YmhuR21sZlVwdWhQdkVHZ3JtenE0ZHpBMy90Q0NJNVk2dDlENXRBRDBEaFpS?=
 =?utf-8?B?OXAxN210YWc4cE02Z2N1QWdqMU05ZytVcldDeVA2Z0dFMGFRNG1SdHhxOGIy?=
 =?utf-8?B?S1NuZ21kOEhacVpHbXlYR0N5TUlaT3lYeEVTTHNFTDRheGpJcWFMWG5xSzFz?=
 =?utf-8?B?Y0F1NXU4UG9jZGo0QVhMTWIxU2lvdWZjblV5SDNxa2NkaE9nVDI4QzJSUlVq?=
 =?utf-8?B?cklnbE4xM0FEOGlTK3lwb3hla3JRMzdGMnhrd3J5NmV2d1p6dERyYVJPbWpm?=
 =?utf-8?B?OFZkV01kOFl6eDlpTjhNZW1pSGxIWjBLTEg0TUY2T2dEa0JiR2ZKR3l4anB5?=
 =?utf-8?B?ZWFweHZNMTZNZHRnR3NQdHY5NndacjZScndlN0Q0amtRNHVRbnVBVkpZSTJQ?=
 =?utf-8?B?eG9CVjBGemFaTVAyeXQ3Y2FMVXFYcHBoSzFhVkhVRzBraXZPSlhuOXAzYnBS?=
 =?utf-8?B?ZFNrWlpHOW1hNVNyY0VnNGR0NDVySjRIYVVqR3dwTEtCUDN4M1pPQ243N3pq?=
 =?utf-8?B?eG92a2JJM1Z5WW55d2xHMjBmaVJ6WnVrQ2JCd1M4QmFCVTBiWERNZ0daMHhn?=
 =?utf-8?B?MHVhV2VnMUxRUk4xR2I1OHJqYlphdDdNVjkrd2NGMXkySDA0NUpwQldVNEs2?=
 =?utf-8?B?VXFnaURQTWhQMElXZ3U2SnZUQWNLSURwM01zQU15KzcvZHZ0cFhVUXBXRUxH?=
 =?utf-8?B?RFRIazQ0ejB3L1k3a3RGd2FZRU1RYXYwVmNpSW56WTFlTzl6emJaeDRZSFdQ?=
 =?utf-8?B?TmZWVjdCc20yNWJOdDg0ZVlNVkxKZXZ0RnVkS3hzRnpOV1RHNGtLUTZXQWcz?=
 =?utf-8?B?a1Q4dVI2T2dkeWkrc1JKMytpL0N1VklYZ2YweHNlVEJvbGRvamJTcVBwa2ky?=
 =?utf-8?B?aHNaNENqbXRIV3ZyWFVIcUM5SXlUUDM1UmY1RjFlTDQyVDVRU1g4d3BDM1BC?=
 =?utf-8?B?by85OWY1ZGxMM3AzSGxOMTFuMThPMTZNTHZoUGpRNmtFVHlKRUhHUDRHNVBR?=
 =?utf-8?B?d2JCRWVPcnFtdHNDVU5KRy9GU2ZLOG1mbnpIQTh4RlRYMWxrejRkZjNURDhu?=
 =?utf-8?B?TER3SXNuQzVpOFBMd251MEZlUDZ5L09RRlU3SVhIUkV0ZnBmc25SbUJkeW52?=
 =?utf-8?B?aWJyRHFmRjEzK3FPR2RrdEtLNUVCNmZPVmRxMVJFNE12WXZYa3Q2VCtpYyt3?=
 =?utf-8?B?QzdGQzRWMGJPdmtTdnZPNy9Nc3ByeUNFSno1SzljYXhaMk5SUFViVU9rM1RW?=
 =?utf-8?B?TDcvTHZ4ZDl4SS8xbE1MejB5WDJERXBHNi83QU5KNERrTlJoS3BYZGtnN2dh?=
 =?utf-8?B?OThReGxhWWg5SUFYU1MzT2pyUlkvM3RVc1F5Zi9yTWxES05oSnN5SjlyZG80?=
 =?utf-8?B?eDhlbjZOM1pVRmhJVitPVk9Ya3l3UXNFZnYvWHJXUlY3R0dmMU5uZkNodEJi?=
 =?utf-8?B?MzBXcjlPdVc4Q0xTQStNWDhyRjNxekdTUzVKa1ZwbWpNSjB2YWx0UW12NWlT?=
 =?utf-8?B?cE1qNEoxSUN4WkF6V3d3UXM4QlhnclVTRURHL05BMkVhUy9KUk45ZHA5bEdu?=
 =?utf-8?B?cWtsa1BaaThxT3NBUHBTNWVsRzlDcGtqN0lWL0s0VXRKam5KVHp2b210VDlG?=
 =?utf-8?B?YVliK2wxdFVnYy9QRTFuUnU3Nkpzb2RpRW4yRlNvaUM4aTArbmVBdGJHV3BN?=
 =?utf-8?B?R0IwYVlYbHJOQnh2ZjMybjM0VktqWEk2OFJicmdNNlZXRSs2S1lEUFBQZmNU?=
 =?utf-8?B?WTVWeUJzbys5MG1OSjMxSkUzazdxR3VyWnQ0N1BybkVIanhsMGNpNFlzSFJv?=
 =?utf-8?B?MXFUY3BTN2ZmZG0xNVRQU3FZdHVWRDM2VmdkQUVrNkNRQkduNG5yVDF3bXVm?=
 =?utf-8?B?cnlYamNvUVVRMlVJL2JydmRkcnRMVzdBV0R2SXJZKzBwSmVUVElaUDJlSmJQ?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8222d98b-9cea-424c-a9b2-08db10bff8d7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 08:21:30.3831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYtXPnJVq5hZzrkbskD6tADK/tVGhdlWU8prIHS+ZKrCXpK0Gluulsxavq9JuFPMi1PT5RyQdwz5/tjhN8mg9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3288
Received-SPF: pass (spool2: domain of siemens.com designates 40.107.6.87 as permitted sender) client-ip=40.107.6.87; envelope-from=jan.kiszka@siemens.com; helo=EUR04-DB3-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b="QzJf/l9f";
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.6.87 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=siemens.com

On 17.02.23 03:09, linz wrote:
> 
> 在 2023/2/16 17:53, Jan Kiszka 写道:
>> On 16.02.23 10:25, linz wrote:
>>> Hi, I met a question when using xenomai v3.2.2. The CPU on my
>>> development board has four cores, CPU0, CPU1, CPU2, CPU3 I used CPU0
>>> and CPU3 for xenomai, and CPU1 and CPU3 for linux. The bootargs is as
>>> follows: setenv bootargs  isolcpus=0,3 xenomai.supported_cpus=0x9
>>> nohz_full=0,3 rcu_nocbs=0,3 irqaffinity=1,2 nosoftlockup
>>> nmi_watchdog=0; Then I runned latency testsuit, I found the jitter
>>> was greater than before. So I tried to use ftrace to look for the
>>> reason, and found the thread runing in CPU0 and CPU3 compete for
>>> nklock. The ftrace is as follows:             sshd-2187    [000]
>>> *.~2  6695.901950: ___xnlock_get <-___xnsched_run
>>> /////////////////////////////////////////////// CPU0 got xnlock
>>>           <idle>-0       [003] *.~1  6695.901950:
>>> rcu_oob_prepare_lock <-irq_find_mapping           <idle>-0      
>>> [003] *.~1  6695.901951: __rcu_read_lock <-irq_find_mapping          
>>> <idle>-0       [003] *.~1  6695.901951: __rcu_read_unlock
>>> <-irq_find_mapping             sshd-2187    [000] *.~2  6695.901951:
>>> xnsched_pick_next <-___xnsched_run           <idle>-0       [003]
>>> *.~1  6695.901952: rcu_oob_finish_lock <-irq_find_mapping          
>>> <idle>-0       [003] *.~1  6695.901952: generic_pipeline_irq
>>> <-gic_handle_irq           <idle>-0       [003] *.~1  6695.901952:
>>> generic_pipeline_irq_desc <-generic_pipeline_irq            
>>> sshd-2187    [000] *.~2  6695.901953: ktime_get_mono_fast_ns
>>> <-___xnsched_run           <idle>-0       [003] *.~1  6695.901953:
>>> handle_percpu_devid_irq <-generic_pipeline_irq_desc            
>>> sshd-2187    [000] *.~2  6695.901953: arch_counter_read
>>> <-ktime_get_mono_fast_ns           <idle>-0       [003] *.~1 
>>> 6695.901953: handle_oob_irq <-handle_percpu_devid_irq          
>>> <idle>-0       [003] *.~1  6695.901954: do_oob_irq <-handle_oob_irq
>>>           <idle>-0       [003] *.~1  6695.901954:
>>> arch_timer_handler_phys <-do_oob_irq             sshd-2187    [000]
>>> *.~2  6695.901954: pipeline_switch_to <-___xnsched_run          
>>> <idle>-0       [003] *.~1  6695.901955: xnintr_core_clock_handler
>>> <-arch_timer_handler_phys           <idle>-0       [003] *.~1 
>>> 6695.901955: ___xnlock_get <-xnintr_core_clock_handler
>>> ///////////////////////////////////////////////  CPU3 wanted to get
>>> xnlock           <idle>-0       [003] *.~1  6695.901955:
>>> queued_spin_lock_slowpath <-___xnlock_get
>>> ///////////////////////////////////////////////  CPU3 failed and
>>> waited             sshd-2187    [000] *.~2  6695.901956:
>>> dovetail_context_switch <-pipeline_switch_to             sshd-2187   
>>> [000] *.~2  6695.901956: check_and_switch_context
>>> <-dovetail_context_switch             sshd-2187    [000] *.~2 
>>> 6695.901957: cpu_do_switch_mm <-check_and_switch_context            
>>> sshd-2187    [000] *.~2  6695.901958: post_ttbr_update_workaround
>>> <-cpu_do_switch_mm             sshd-2187    [000] *.~2  6695.901958:
>>> fpsimd_thread_switch <-__switch_to             sshd-2187    [000]
>>> *.~2  6695.901959: __get_cpu_fpsimd_context <-fpsimd_thread_switch
>>>             sshd-2187    [000] *.~2  6695.901960: __fpsimd_save
>>> <-fpsimd_thread_switch             sshd-2187    [000] *.~2 
>>> 6695.901960: __put_cpu_fpsimd_context <-fpsimd_thread_switch
>>>             sshd-2187    [000] *.~2  6695.901961:
>>> hw_breakpoint_thread_switch <-__switch_to             sshd-2187   
>>> [000] *.~2  6695.901962: uao_thread_switch <-__switch_to            
>>> sshd-2187    [000] *.~2  6695.901962:
>>> spectre_v4_enable_task_mitigation <-__switch_to            
>>> sshd-2187    [000] *.~2  6695.901963: spectre_v4_mitigations_off
>>> <-spectre_v4_enable_task_mitigation             sshd-2187    [000]
>>> *.~2  6695.901963: cpu_mitigations_off <-spectre_v4_mitigations_off
>>>             sshd-2187    [000] *.~2  6695.901964:
>>> spectre_v4_mitigations_off <-spectre_v4_enable_task_mitigation
>>>             sshd-2187    [000] *.~2  6695.901965: cpu_mitigations_off
>>> <-spectre_v4_mitigations_off             sshd-2187    [000] *.~2 
>>> 6695.901965: erratum_1418040_thread_switch <-__switch_to            
>>> sshd-2187    [000] *.~2  6695.901966: this_cpu_has_cap
>>> <-erratum_1418040_thread_switch             sshd-2187    [000] *.~2 
>>> 6695.901967: is_affected_midr_range_list <-this_cpu_has_cap
>>>             sshd-2187    [000] *.~2  6695.901967: mte_thread_switch
>>> <-__switch_to            <...>-2294    [000] *..2  6695.901968:
>>> inband_switch_tail <-__schedule
>>> /////////////////////////////////////////////// CPU0 switch thread
>>> sshd-2187 -> stress-2294            <...>-2294    [000] *..2 
>>> 6695.901969: preempt_count_add <-inband_switch_tail           
>>> <...>-2294    [000] *.~2  6695.901969: fpsimd_restore_current_oob
>>> <-dovetail_leave_inband            <...>-2294    [000] *.~2 
>>> 6695.901970: fpsimd_restore_current_state
>>> <-fpsimd_restore_current_oob            <...>-2294    [000] *.~2 
>>> 6695.901970: hard_preempt_disable <-fpsimd_restore_current_state
>>>            <...>-2294    [000] *.~2  6695.901971:
>>> __get_cpu_fpsimd_context <-fpsimd_restore_current_state           
>>> <...>-2294    [000] *.~2  6695.901972: __put_cpu_fpsimd_context
>>> <-fpsimd_restore_current_state            <...>-2294    [000] *.~2 
>>> 6695.901973: hard_preempt_enable <-fpsimd_restore_current_state
>>>            <...>-2294    [000] *.~2  6695.901973: ___xnlock_put
>>> <-xnthread_harden ///////////////////////////////////////////////
>>> CPU0 released xnlock           <idle>-0       [003] *.~1 
>>> 6695.901974: xnclock_tick <-xnintr_core_clock_handler
>>> /////////////////////////////////////////////// CPU3 got xnlock
>>> finally, but lost 901974-901955==19us I try to revert the patch
>>> "cobalt/init: Fail if CPU 0 is missing from real-time CPU mask
>>> "(website is
>>> https://source.denx.de/Xenomai/xenomai/-/commit/5ac4984a6d50a2538139193350eef82b60a42001), and then use the follow bootargs: setenv bootargs isolcpus=3 xenomai.supported_cpus=0x9 nohz_full=3 rcu_nocbs=3 irqaffinity=0,1,2 nosoftlockup nmi_watchdog=0; finally, the problem is resolved.
>> Why do you have to revert this commit? Your supported_cpus here still
>> contains CPU 0, thus should not trigger that check. Sorry, I wrote
>> wrongly, The bootargs should be: setenv bootargs isolcpus=3
>> xenomai.supported_cpus=0x8 nohz_full=3 rcu_nocbs=3 irqaffinity=0,1,2
>> nosoftlockup nmi_watchdog=0 So, I supported_cpus didn't contain CPU 0.
>> After reverting the patch, with the above bootargs, the jitter is less
>> than 7us using latency testsuit. But the jitter is about 15us using
>> latency testsuit using the follow bootargs: setenv bootargs
>> isolcpus=0,3 xenomai.supported_cpus=0x9 nohz_full=0,3 rcu_nocbs=0,3
>> irqaffinity=1,2 nosoftlockup nmi_watchdog=0; The reason is CPU0 and
>> CPU3 compete for xnlock, that is, results presented by ftrace.
>>> My question is: If I revert the patch, what is the impact on the
>>> system? Can you specify where CPU 0 is supposed to be real-time?
>> You can currently only specify setups where CPU 0 included because of
>> the mentioned restrictions in the cobalt core. I do not recall all
>> places where this assumption would be violated, just
>> kernel/cobalt/dovetail/tick.c: pipeline_timer_name() from quickly
>> re-reading the patch context. Can't you move all your RT workload to
>> CPU 0 and all non-RT to the others?
> 
> In the customer's actual environment,
> if moving all your RT workload to CPU 0 and all non-RT to the others,
> the customer will feel troublesome,
> because they feel incompatible with xenomai 3.1.x, that is, the ipipe
> core has no restrictions on CPU0.
> 

I wouldn't be surprised if that was just wrong in 3.1 to permit
excluding CPU 0 because the same internal assumptions applied. If you
were lucky, you just didn't trigger them.

If we want to relax this restriction, we need to systematically look for
all CPU0-assumptions and somehow resolve them.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

