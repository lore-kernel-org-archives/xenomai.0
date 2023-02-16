Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9635E7B
	for <xenomai@lists.linux.dev>; Thu, 16 Feb 2023 09:53:22 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 4E7D71C0015
	for <xenomai@lists.linux.dev>; Thu, 16 Feb 2023 09:53:20 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	by spool.mail.gandi.net (Postfix) with ESMTPS id F0D44740047
	for <xenomai@xenomai.org>; Thu, 16 Feb 2023 09:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGbeuxnja586/zGSm4ROu/Ag2LEcQb55X/CGCI6XtfDSJe8HZmJPgSdb1WK5Ci4jqLremt/vxBt9kWnE7HpWjC6kycWOIAbH0FhJ6yk1gwdxt3TpY1j7rHfir0kINVWq2gobX4tayJur4Zg9A7sBgIctK8LluvnxJC1Abb6g4AiG40M8GoxbXJVF/gMqaKowEot+Xqy78wINmw3CnrFmGoQgZUwCAS0mu3LqZ0mJPXfHrakpY8eLB4wl4ShuJZduURb6Ilr54JN1wbiWxVMNDr1NbdfTOZNjrU4JccZXOaf9qqnbXgP8I56GNTLwzY5f3NtYggVNTXQZTRs+QapxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SW7KhonI2wb4KO+vvISdC6HMfrpEQTT40gcVBN2Lrc4=;
 b=IeyYnqlI3JQXWXnRKivRWhWr3XlkxYH/+qWtPnZEwZcsa2BJIwyNcfeFyfAOiSgFM2F5EAxCH/Tu0vNLe4z8iptozBM7v+8qszHCMuQHYAD+9u70kDP1qkXW8GYpYPEdWsabWc2PEFKR93MVlS1HSVJDjVkrobAKvU+drz0P+YS1XoOqNSsIHLb1WakeAi2FAmglRUPtwxbIpC1fsKXDyEEw2OvfsUJbvZgrhv8a6Hi30DvLcaPVdZ5N+5udw15+tHAcCNfbRfaFPF/ht0DwFytadnuI8A4teUKNp90OZ/9qDRr2cdJwN9QrTt2runjG9ZTowUoNlu7syRpTlzcLiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW7KhonI2wb4KO+vvISdC6HMfrpEQTT40gcVBN2Lrc4=;
 b=Qvh9Mmg/qe62yco1XsilJTNkynuVBTHPqXRZkI1/cJak0FvFvdyQ0Q9fm34dCqLT4pzy215srMkCjJu77U2yQiniwbzXNA4MEG/+QufNI5TIB2I4XgK80wzEh95Rarjp4sa8sY8IzSt6zZDL8xYkj2rTOOEhHEstR1nNUN3g54Z5OtSXShY4FFuy/S0y/wmVn7O2h4GNWI2yg8Gpkjyx8VdcmDtUdMkSCJAvlefxWAyktGcYpwVuyb1zONJ4YYS1fo5UV9UvNyIjCAVaQhZagCKX9EFDI7crrh1/f/QUsd/ixW+pfdL8tDhzla6uF8AWBMwnGFiAxfuqAl1Yx4JS5Q==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3299.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:188::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Thu, 16 Feb
 2023 09:53:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 09:53:17 +0000
Message-ID: <fd22514f-1ff9-a413-ac64-7f5513885235@siemens.com>
Date: Thu, 16 Feb 2023 10:53:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: I found the jitter was greater, when using the patch
 "cobalt/init: Fail if CPU 0 is missing from real-time CPU mask"
Content-Language: en-US
To: linz <powertree@163.com>, xenomai@xenomai.org
References: <6b1485d5-c10f-e607-916e-138b9d3ccf75@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6b1485d5-c10f-e607-916e-138b9d3ccf75@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3299:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5bc74b-7a66-41ec-f60b-08db1003a10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cAMXB91TeeukIZomEQr40nHhHm9imAcM0NhRA6NRrv+eDROCq/vrAv+HhhO2t6hzSJFo9ulm1KjEUSfW6NCVdQxarMUGbKQoy5/HUTFKEcyZUKtauYrssOI8j8HMtgcvIHMrt6a/ccfMd6HiTarCqYB3oDEj2UXEUwEWuZrUjWIaadvdG/fwIORYV4I9I/c5P5uhy3lh5r2Md70IPsHw303ctWggep+syO7jRrWOoTjC6Z+taR2+/1M2JhHcilUJI3om2IIUrssqD/CwjuQW+iXgJ3zBDBufhHZVy+0f+FhUPxjCy1XGQXXfJ/4VM5bNLY5QS7NmQwXYLb/MTV+EU6/rFq4V1F7OF+CWBWlSyyDG3lRDRo+fAeLSD6EYfYVc1QoS3H6ZiZgFKSx8EBmi0tisF6XJBPV8z5GSQqU1QhCOtiwgkOoHQYOGMistNzP3nZZcS86peXGNJ71937Y8TqvMu6BBrM5xHjM2C9EbsL9Yxos+8t/5pQFfuGsgZntuChuQiOBghCW0A7iqLZHQYXyw+wxP3RJjHroPAOOLOf+maSkNWGAJ6vU7gH15T2byoM5T3meTrsr96Tq0tz+rA2d2p/Y1uhdY6MPTjKo9S2VvoZC1BbOZvAbaw9MMIilyxSRyqH9jT/mykcm+72xRkoE0fwl2kuCoyEzKbzL/KHkXweVfI/eIEwLU1XVeqJYKs04S43lfury9lTfuwrGCWZUWg6HABfUwos87VgVmUuw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199018)(31686004)(66556008)(66476007)(66946007)(5660300002)(44832011)(8936002)(316002)(41300700001)(8676002)(36756003)(31696002)(82960400001)(86362001)(38100700002)(6512007)(186003)(478600001)(26005)(6506007)(53546011)(83380400001)(966005)(6486002)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aURLTThPeXlCdWswdFk4Q0h4OHdjWlVzcmxWUmxTQkxXaTBNMUhCSzUzT0dj?=
 =?utf-8?B?VVhZMkxhY0lCSCszUURBbE91TzFubmpzOGxaWFJiakVkK3pUZHQrb2dvV3Br?=
 =?utf-8?B?MG9sV1pyWlJKSXh5R0pRdFZMcWZQcFVlQndEMG1MUTFPQUZGd25zZVhQVmNq?=
 =?utf-8?B?VTVjTmhNZ0lQSnZnTkhtQ1pEOU56N3ZwWnZqWk83MmpmNVdkSWtJRjFDRWhW?=
 =?utf-8?B?K1dkYndxY3ZMem9ZR1FWRjNINlgyRlNTS25QWjVqM04yOXZoVHpKN2VweDRz?=
 =?utf-8?B?T2xYSE1UOGErOWwxaEZLMmdXSGdLMkxlcGJEN01OZ0R3NmtYWGZ2dkFGZ2Y1?=
 =?utf-8?B?SlJkOFpLblhJemN0RHYwaHRmOGxZaUdwbTVneUV1WUdZSVg4SjRoU0lUYWhJ?=
 =?utf-8?B?THpuUURibWZZTVFQeWEraVdqUWR3YVE1UTVNblpOakJRV0JZY2hsVUtSUS83?=
 =?utf-8?B?LzRWenlIUjdVM0ZOZnZycnFIN0pJM0J6WnhDeENnV0xXMUhGV0swaERreDNw?=
 =?utf-8?B?OER5NjQ5amNTVXpvVEFUZEx0bGJLV015ditBS3hDSmxlNko2bEpqRVBQUVlk?=
 =?utf-8?B?VjRkNEJWZEwvYlpQdHBRenFta2ZpU3RNWDhtOHRWbTRIMUZ5Z1NMTktNb0Zl?=
 =?utf-8?B?UHNEaEtTczJrY0o5MHl0aXd1ZE9wbjJaVzdLVU1IZ2U2VnVtL3JISUF4M0pN?=
 =?utf-8?B?cm5XQ3oxMjJPYklNanFZTlpwRStnazF5VjBYUzhjczZxQ1RZUGhlK01FZUZm?=
 =?utf-8?B?alFrNGpRdk1lVUJ5QmVOSCt5VEs5NnFZdnUwWXI3UEU1RlVYRDJSQXBuMTlW?=
 =?utf-8?B?WlZyWG0zbjFReFowbWVTM1EveFdyczZtWEtpNzlQRTB2cnVTcDJKUlNLTitx?=
 =?utf-8?B?UEhSeERSN2MxMU1HcEc5Uy9NVk11Tk5iZmhITjBGck1CQkFDS0pnNmxCT1N5?=
 =?utf-8?B?VnlKNlc2WVRaSWhQaTU4ZzdWbHhSNmlpQnhLSWwwa3FqWm1ENTYwa2Fpb3Bx?=
 =?utf-8?B?RGFpWnV5a1FjakJHaXpucnhSY29mYkNHRi9TT3piNlVwNE5BeWcvRjlRNURj?=
 =?utf-8?B?ZjI4eWpkNzVVRHYwbUtlOGNBSWpudG0wRkJwVmZEYTJNdi9GQzRVTTZ2TTNy?=
 =?utf-8?B?MmJvaGVJckFlVDRScksvMy9BRGo0c0NXc0p0encwb3M3aTVyNUV1bXhvTGk0?=
 =?utf-8?B?eFQvV0pGMWVUTkNzSXM0YTZEdkRyY09LbVJvckUyeEtRRWs3ZW83UWQ3QjhR?=
 =?utf-8?B?OURCOTdkaEVmOUxWbkhrd29QekRzLzMrenBocXpGUzRnQTVad0ltNnJIU2JR?=
 =?utf-8?B?Tkwrdm9RTXVFemVrSmIybC9EODVIWDNwK1dDMXdRMlhpWlppL3Y4Mlc0RE9G?=
 =?utf-8?B?MDN0dUVFS0x1RjI4ZHpZTzBtaFJFWEczOWJkMzg2NVZ5RWZTNUF4MSt2TThq?=
 =?utf-8?B?UkxmWHhZbXlvNmd3WTJ3U3JiMkZhVmlvSXFmRmRhMDEzSk5HcXQ1cmxncGxn?=
 =?utf-8?B?aU5sd3Z2dUtyRS9HejBvMHhUc01XZVBhUEk4KzUwTm5SNHBPcWczb3NYcUpn?=
 =?utf-8?B?Wi9McUFaKytaUHIyKzhucWhQZmNSWi9xRjN2dmpKUDFVc0hjUUYxOGJqL2Nj?=
 =?utf-8?B?dWd1dUlnSllCaHJDRTBoS3pMU1lxTzJMenFVSWo4KzdHUDY5ZHJLcmlydzRp?=
 =?utf-8?B?Y1dBWkZ1OHZqRTdEaEdjaHdwbllRMGdoakNqTnoxSC9QZy81OS9iRUJSQmNR?=
 =?utf-8?B?MXZBdVZPaVlwbVluR3pEdnJFelozQmdLRGltM3BMMWgrOFBFb1pPSVJrM2tR?=
 =?utf-8?B?QVAvSnYyYTJFYzUyUHg4ck13OURFZzJhbG15NmZNMzM4b0RWYXM0RG5EV1I0?=
 =?utf-8?B?THYvczRTalE3NW5lbUdlamlaODhQSGRSRU5xTFBvYzVyakJ0emo5cGl6RXdN?=
 =?utf-8?B?RU5keE0vWlJhQmNDclgwMWNOY3kvRko4a2JkcW5rU0V1S1FsajRQQnVNd2Ny?=
 =?utf-8?B?OFduV0k2eDhhdXBCNUN1WW5TM0JrSFhOcXN3ald3b2NUaFppeUl0ZUQvTGNP?=
 =?utf-8?B?cnRuaUpFNUR1Ujc1WVZtUERCdGhEYTJGRkcyelQxS0Mzb2hseG85TTB4MTdR?=
 =?utf-8?B?ZWErOHdiWXdXWSt4YkRXTC81aldHRHlDNUltcGNibXhidGdPNzI2VFRxTzZN?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5bc74b-7a66-41ec-f60b-08db1003a10c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 09:53:17.7078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0a7mM4zbn6MVjOG0DUt0/o9R93zTMLnQw/gAJLOsEUA6nUv+y/anPsYLlWZoge0JejgvkhDNkY+/7iCGuajmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3299
Received-SPF: pass (spool2: domain of siemens.com designates 40.107.20.50 as permitted sender) client-ip=40.107.20.50; envelope-from=jan.kiszka@siemens.com; helo=EUR05-DB8-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b="Qvh9Mmg/";
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 40.107.20.50 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=siemens.com

On 16.02.23 10:25, linz wrote:
> Hi, I met a question when using xenomai v3.2.2.
> The CPU on my development board has four cores, CPU0, CPU1, CPU2, CPU3
> I used CPU0 and CPU3 for xenomai, and CPU1 and CPU3 for linux. The
> bootargs is as follows:
> setenv bootargs  isolcpus=0,3 xenomai.supported_cpus=0x9 nohz_full=0,3
> rcu_nocbs=0,3 irqaffinity=1,2 nosoftlockup nmi_watchdog=0;
> 
> Then I runned latency testsuit, I found the jitter was greater than before.
> So I tried to use ftrace to look for the reason, and found the thread
> runing in CPU0 and CPU3 compete for nklock.
> The ftrace is as follows:
> 
>             sshd-2187    [000] *.~2  6695.901950: ___xnlock_get
> <-___xnsched_run /////////////////////////////////////////////// CPU0
> got xnlock
>           <idle>-0       [003] *.~1  6695.901950: rcu_oob_prepare_lock
> <-irq_find_mapping
>           <idle>-0       [003] *.~1  6695.901951: __rcu_read_lock
> <-irq_find_mapping
>           <idle>-0       [003] *.~1  6695.901951: __rcu_read_unlock
> <-irq_find_mapping
>             sshd-2187    [000] *.~2  6695.901951: xnsched_pick_next
> <-___xnsched_run
>           <idle>-0       [003] *.~1  6695.901952: rcu_oob_finish_lock
> <-irq_find_mapping
>           <idle>-0       [003] *.~1  6695.901952: generic_pipeline_irq
> <-gic_handle_irq
>           <idle>-0       [003] *.~1  6695.901952:
> generic_pipeline_irq_desc <-generic_pipeline_irq
>             sshd-2187    [000] *.~2  6695.901953: ktime_get_mono_fast_ns
> <-___xnsched_run
>           <idle>-0       [003] *.~1  6695.901953:
> handle_percpu_devid_irq <-generic_pipeline_irq_desc
>             sshd-2187    [000] *.~2  6695.901953: arch_counter_read
> <-ktime_get_mono_fast_ns
>           <idle>-0       [003] *.~1  6695.901953: handle_oob_irq
> <-handle_percpu_devid_irq
>           <idle>-0       [003] *.~1  6695.901954: do_oob_irq
> <-handle_oob_irq
>           <idle>-0       [003] *.~1  6695.901954:
> arch_timer_handler_phys <-do_oob_irq
>             sshd-2187    [000] *.~2  6695.901954: pipeline_switch_to
> <-___xnsched_run
>           <idle>-0       [003] *.~1  6695.901955:
> xnintr_core_clock_handler <-arch_timer_handler_phys
>           <idle>-0       [003] *.~1  6695.901955: ___xnlock_get
> <-xnintr_core_clock_handler
> ///////////////////////////////////////////////  CPU3 wanted to get xnlock
>           <idle>-0       [003] *.~1  6695.901955:
> queued_spin_lock_slowpath <-___xnlock_get
> ///////////////////////////////////////////////  CPU3 failed and waited
>             sshd-2187    [000] *.~2  6695.901956:
> dovetail_context_switch <-pipeline_switch_to
>             sshd-2187    [000] *.~2  6695.901956:
> check_and_switch_context <-dovetail_context_switch
>             sshd-2187    [000] *.~2  6695.901957: cpu_do_switch_mm
> <-check_and_switch_context
>             sshd-2187    [000] *.~2  6695.901958:
> post_ttbr_update_workaround <-cpu_do_switch_mm
>             sshd-2187    [000] *.~2  6695.901958: fpsimd_thread_switch
> <-__switch_to
>             sshd-2187    [000] *.~2  6695.901959:
> __get_cpu_fpsimd_context <-fpsimd_thread_switch
>             sshd-2187    [000] *.~2  6695.901960: __fpsimd_save
> <-fpsimd_thread_switch
>             sshd-2187    [000] *.~2  6695.901960:
> __put_cpu_fpsimd_context <-fpsimd_thread_switch
>             sshd-2187    [000] *.~2  6695.901961:
> hw_breakpoint_thread_switch <-__switch_to
>             sshd-2187    [000] *.~2  6695.901962: uao_thread_switch
> <-__switch_to
>             sshd-2187    [000] *.~2  6695.901962:
> spectre_v4_enable_task_mitigation <-__switch_to
>             sshd-2187    [000] *.~2  6695.901963:
> spectre_v4_mitigations_off <-spectre_v4_enable_task_mitigation
>             sshd-2187    [000] *.~2  6695.901963: cpu_mitigations_off
> <-spectre_v4_mitigations_off
>             sshd-2187    [000] *.~2  6695.901964:
> spectre_v4_mitigations_off <-spectre_v4_enable_task_mitigation
>             sshd-2187    [000] *.~2  6695.901965: cpu_mitigations_off
> <-spectre_v4_mitigations_off
>             sshd-2187    [000] *.~2  6695.901965:
> erratum_1418040_thread_switch <-__switch_to
>             sshd-2187    [000] *.~2  6695.901966: this_cpu_has_cap
> <-erratum_1418040_thread_switch
>             sshd-2187    [000] *.~2  6695.901967:
> is_affected_midr_range_list <-this_cpu_has_cap
>             sshd-2187    [000] *.~2  6695.901967: mte_thread_switch
> <-__switch_to
>            <...>-2294    [000] *..2  6695.901968: inband_switch_tail
> <-__schedule /////////////////////////////////////////////// CPU0 switch
> thread sshd-2187 -> stress-2294
>            <...>-2294    [000] *..2  6695.901969: preempt_count_add
> <-inband_switch_tail
>            <...>-2294    [000] *.~2  6695.901969:
> fpsimd_restore_current_oob <-dovetail_leave_inband
>            <...>-2294    [000] *.~2  6695.901970:
> fpsimd_restore_current_state <-fpsimd_restore_current_oob
>            <...>-2294    [000] *.~2  6695.901970: hard_preempt_disable
> <-fpsimd_restore_current_state
>            <...>-2294    [000] *.~2  6695.901971:
> __get_cpu_fpsimd_context <-fpsimd_restore_current_state
>            <...>-2294    [000] *.~2  6695.901972:
> __put_cpu_fpsimd_context <-fpsimd_restore_current_state
>            <...>-2294    [000] *.~2  6695.901973: hard_preempt_enable
> <-fpsimd_restore_current_state
>            <...>-2294    [000] *.~2  6695.901973: ___xnlock_put
> <-xnthread_harden /////////////////////////////////////////////// CPU0
> released xnlock
>           <idle>-0       [003] *.~1  6695.901974: xnclock_tick
> <-xnintr_core_clock_handler
> /////////////////////////////////////////////// CPU3 got xnlock finally,
> but lost 901974-901955==19us
> 
> 
> I try to revert the patch "cobalt/init: Fail if CPU 0 is missing from
> real-time CPU mask "(website is
> https://source.denx.de/Xenomai/xenomai/-/commit/5ac4984a6d50a2538139193350eef82b60a42001),
> and then use the follow bootargs: setenv bootargs isolcpus=3
> xenomai.supported_cpus=0x9 nohz_full=3 rcu_nocbs=3 irqaffinity=0,1,2
> nosoftlockup nmi_watchdog=0;
> finally, the problem is resolved.

Why do you have to revert this commit? Your supported_cpus here still
contains CPU 0, thus should not trigger that check.

> 
> My question is:
> If I revert the patch, what is the impact on the system?
> Can you specify where CPU 0 is supposed to be real-time?

You can currently only specify setups where CPU 0 included because of
the mentioned restrictions in the cobalt core. I do not recall all
places where this assumption would be violated, just

kernel/cobalt/dovetail/tick.c: pipeline_timer_name()

from quickly re-reading the patch context. Can't you move all your RT
workload to CPU 0 and all non-RT to the others?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

