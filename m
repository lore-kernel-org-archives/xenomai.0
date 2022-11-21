Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489A279C5
	for <xenomai@lists.linux.dev>; Mon, 21 Nov 2022 18:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qikr7O1Mcz6ibG9PIkyo0ZeMUSuC3cjmnRqmdFZwfXWn9juTk33I/1XQApgksNFeyWBQwv89y7jB3Ozhd5Rt/vAmSWFtKX1fhqe9abjYkCra2IjlvuhZARWV2hvF0Jf7f3nB6saVOK9Zz4gEjZ0pvJl3VeYZKq+s3+5UM9bYQ0knPBUiCe8sYGXY+9k9ecW+t3mt/CARta+fu4DOmv69e523cXSrSGSSWGu9HTcr+7Z5LcLhQWISzZTFwfiSQDxeoQOxUknB78aM3Lmwoin79PuBnmM32MnKRAcAsu8u2kwrLwjMzFf9clgDRdQDf3tTfBcdg1K3xpDsQwHw8Hi7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp8gC0GItiVcWQGzEpg/yrqyPVgaWjYL8chdz1SGRM8=;
 b=T21eGsBEn98n0BIYjbJzFvINqxfHxBGbcR2tVGfLrq4IS0+ZXyrZHkmFQQUR4jExlGXgjFt9J1bfuqIm78zaZQeQ7Fh01z1+hssOafQ2midSyMTt33njvZt5ZHvi4Sz56kOmKUoeaFQrLaHLU8UDBRH8ChiC3D6NLmk5r653bQcWlO4gsKG6rsW0TeEjPihdlZ0XQBm/sBV27NMRSqodmgiv2dwT5MqgfBRQ3uU70tg7yKVxrUYlIxsf03c2wMTbFVx1U7wSg2aT1SaNOmrw1yq/lAo9+tuf/yHI4ruoAquK1cE0EnjXlXrxj/EmrC9/HoUge3Zqv1wIyeoch7dLpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp8gC0GItiVcWQGzEpg/yrqyPVgaWjYL8chdz1SGRM8=;
 b=dGhLtcbaRnQI6rl+1BuftjeFdBKdW3bb8irnkVnzSjSXByxHYGjELHAnozF28I60cuU5D5R7UIK4PwOBS7lRv29UHzOnxY3kkpsmMQr2m526uTo8l8OrOY0/Ugmd6/cCe5CcZ4wABZBEA0THtwYpVxBUbhreIvZTXFhOSzngoMQ5DC988f66YJcA3Tlp1peyXiRY/QKsj2io/HwLDyZ8Q72DD3MeEjr8XXjHNjete309zZvM/XpsoKYIZj2v5rO8rn5Ng2nzPi8eHshXj8ttd4GlBaivYXe6G9jntew55u1HjAxKkPzSR/14HY/bKmKjKRYUWdLhwC1J4d9wfH/o4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3344.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 18:36:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 18:36:21 +0000
Message-ID: <0835bd39-0dc8-e767-b39d-ee316f6b7ffd@siemens.com>
Date: Mon, 21 Nov 2022 19:36:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: "suspicious RCU usage" in heapcheck driver
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3344:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5f15e8-8ed3-49a5-636c-08dacbef4969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CrWOk+91lb24RRTNTKi5H/UoABjx4rcwz2EY4dTw/ICn23zV1RWk6weg7caMufCCUX/wS4THuI7AYU/BwHMUOM2CZwkk7Oru8VEG0HpYI2rrmyGg9QBGs5QN8e3u4qbZHWuzE1jUaefiACO8tW6ssP4B+4wPoxO2YlL99hxi5tszNM+AX42gTuKEbCh+1aL/O0PsOJkCpj+bg4VD2IZNB5fZUAgFGgJx9SGBKDGpRIDVB1crvbn9xsIOK39q4w0OILFcHstpsrrr0YBmY/Y8vpdvzUPlLmHErmiFPO9/pInFfyETeXH1SksIhqg/zmE55lvTkOZNI9kdBD6xkgZFKst5iDO6c/8e1taMGX2M6FGaqAHxU7mZBo93FPrabFzCR7FpX+1YaYv4t4GHxA075gTmSX2YFWyVRKcSU1BcZLyKtGR9QEbc98QFblrfkpqzXnEpdNxBlAdAEt/JK/3KAYzUWGWYrAWoOF9sO4gDaKARKcBnXtp9cRtTN+NIb2ZIh322iEgN8qve8Yfq1YM5KbI5lFr9mpQxb4JgoBbajTXrwbgxo1X+DSMWn2RCAXoUBZvaRg/17yZzJ/FxU6/F1c1/ztBDg9gb5lb1Jqd22V/ScTMnjorduGiWBQGYioLSe0geU/eVILyP7HZrHf9FwsmyCtjMfbMHxWGXGegyeLrRpzztPVrtHHxArog+Jw6v6UcwC8HbfILs/2EV8Ch7xvLe1Rm//yyq7LROm+7Bn0xRXYg55We3YfqO9Mt7gC0+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(38100700002)(83380400001)(41300700001)(66476007)(82960400001)(8676002)(316002)(66946007)(66556008)(2906002)(2616005)(8936002)(5660300002)(44832011)(6512007)(6506007)(26005)(186003)(110136005)(966005)(478600001)(6486002)(31686004)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjZPMVh5RGVXZ2ZJYmx5UmhFNTJBTTZOY3gwZ2RZbnVNL3k0SU5zUTQ5anNl?=
 =?utf-8?B?YVhXOTA5bi8wck1hYmoxaExGQ0FtdDlTM092N1R1N3hIMXlkSnYzVW9qZTNR?=
 =?utf-8?B?RUhaY3B5N1FKa1g3R0lsd2o4MjFpLyt5NmlFM0ZEZ2NzYlpLSTdMZHd5NSty?=
 =?utf-8?B?eTVPS2RObDhLdnJhQmFKNVdSclpSamRqMFFzUzc1QmpuTmFJeGk1citaMEJF?=
 =?utf-8?B?WStzdUlIaFdFRFpuRnR2OXRrdzZkbkN6QmxmVTkrdENmVC8xZGJTczBQOTNz?=
 =?utf-8?B?cDhwdGpXN0NFb2RhN0pac1hUd1BPTU1RTm0veWwra0NtMkhvNVdmVmN4Y2o2?=
 =?utf-8?B?Z2IzQ2V6a2l3VmNCQjNVK29GM1JZZ043TG1Tb00wQ1NraFY2NnBGcys5dk02?=
 =?utf-8?B?M01kUjdWLzBkV2xUWHJNWG43cDJOVlBzaVJjakZ3N1p1VWlDbTBQcWdzd3ZR?=
 =?utf-8?B?L0JQUXJaZW5JYWVRRFYzd0Erb0xBRmJ3b3ppWkVNN2NiUjR3QUpEWHB3MEFU?=
 =?utf-8?B?V3JkcFBvSmdJRVVDTE9nSllySkRyQWxYeE1FaWlBNnZVUnBKSk1uS091RDFu?=
 =?utf-8?B?YWpUWWwvbldSWFg2REpVSkRSMjlLK1RHYnFYZXFndnZQTDhIY3J4cjgwV3Z2?=
 =?utf-8?B?NnIrRVhicUk0eElhWnFPWkpEWDY1aGxhL0VPS3pqL0J3bWJCRHlkZUhLQlpv?=
 =?utf-8?B?M2tSYUJmeGNyMjJEMGUyOXI4STVtWjd1ME5PcFh2cGhibGE5OHFhMndETGdT?=
 =?utf-8?B?OERSRjJtaUZ3V0ZnRVRtbU5QdCtscXd3Y3prZGlCRUEyNXZ6TWNCQjBTeFBY?=
 =?utf-8?B?NkYzKzB6QTR5VEF1TzQxQmlyZ3FhMVhpVmhqL1A5aDFQZ0tobGZTbkIzeDhn?=
 =?utf-8?B?MkVMZWFaNDhtWFdlZG8xL0Zyck0wM3EwQi9IK2xVM2k4KzgwdVdIbTJ1U1Ni?=
 =?utf-8?B?UXltVXYvVUQ5YmpjU3JxM1hybm93TkxpejVaL0R1amZjUDM5Z280R2UyU3dU?=
 =?utf-8?B?cC9PZTZPSE9HOGJRa0RrQTJ0RmlIQ0ZWVG5uajBmajBFWWd5V3lZd0VSSFV0?=
 =?utf-8?B?YVVNNW0ra2U4VnBzSXFrR3JaMjJVVlJhTzlyQTZpM0dkejJrTitCQTNQNzBC?=
 =?utf-8?B?djdIb3dkWXFRbTh2bEcwek1adGVORUU4K0YwUGFNeEhrNjhkQk1QOVJDZko2?=
 =?utf-8?B?Qmk1em90TnZnNVZNZEJmWmc3MVdOOW9mTys1N2c2dkFrVFdzTXdxeDE0MjJJ?=
 =?utf-8?B?VklXMno0dmZSVTlZWnRWNURFUHhkbCtTdG5XQmVEcVdHZnRNMUhOUnVnN2NX?=
 =?utf-8?B?RU5BeW1ZVElKcnVaOG9LOXVwc0w1Y2N1eXY4TGFmUTNTMWNrdHdJNEZWMGN0?=
 =?utf-8?B?NTlYMTQ4MGUzS1dNZ3dwNU96Z1kvbXpHeHZnelEvVXBTa3IyVkdlWGtKamVu?=
 =?utf-8?B?Um5ja1JaSUw3Y1h4elJpT1R5L0VMVVEySGRITkdsMHJuK3pnWWpNcHREQ3c3?=
 =?utf-8?B?WVJVM2JoUjVsRjZWN29Xc1hsTUYrTGJHQ1hqUmFvWHEyVzBsZDFVVUtZVHBa?=
 =?utf-8?B?Si9HNVNkV0xLY29SV1BIZ2NjZVZmQzczRUxXcmJZQ05uTktaa2RKMkU4cG1x?=
 =?utf-8?B?dTU4ZnNXb0twbjJoM0tqVEZGWmx3VFlMYlRSV0x4MXd1cjYwRmlWMUlhdTcz?=
 =?utf-8?B?eDRqU3VVQmRIdzhTR0FxM0VrQjc1ZUc1dGU1V2tYVFlsS0hzUCtIZC9IZXNr?=
 =?utf-8?B?QVVnU0U1Q3cwYTlrdG1KdEU1dEcvUWZGd2tvajg3WGFSWmNpSXhxSGZ3Z1px?=
 =?utf-8?B?SGlOeFNtS0VyUXMwYmprOWtoN3BMUmNMSk9zd2k2SUFPellpbFRpYTJYdGVu?=
 =?utf-8?B?cjhOK1crdlJYa2tiekxTcVRub05LTnFtS0pkNVpCeDhjL3U4MVNMelBwbEJX?=
 =?utf-8?B?cThtMVk5VTY4RzRJa1Mxekc1SDVvc2lOdVNGRUgvTHZsdUo2cUxiSE54NVdw?=
 =?utf-8?B?ZTVtK2ZqQWxueGR1OWZDU3FLRU5Hc0NTUEFDaVFFKzBHaSt2dVZmZlJEVlFM?=
 =?utf-8?B?OFZib0JyYVp4a1ZkcXpINHNJMTJHT2xqVkkyN3hYODUyLzFpNnYrVnF1ZWsr?=
 =?utf-8?B?OG52TmZvVXY3L05UdkxUZmtmaHN6ZURZc29Nb3hIaVVzdVRWdFhoUDVFVGpH?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5f15e8-8ed3-49a5-636c-08dacbef4969
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 18:36:21.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoSnyS76ImwFct3vzbhHzDeHWziYqyCPhQZ/Rcn+dLTPQ+e5nsR2uoTTFLL6WTLkSBh1hwRFuR3ZFLQT5b4EMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3344

Hi Philippe,

while preparing Xenomai for recent kernels, switching prandom_u32 to
get_random_u32 [1], I triggered some RCU warning:

[  515.060011] =============================
[  515.060011] WARNING: suspicious RCU usage
[  515.060012] 6.1.0-rc5+ #10 Not tainted
[  515.060014] -----------------------------
[  515.060014] ../include/linux/rcupdate.h:740 rcu_read_lock() used
illegally while idle!
[  515.060017]
[  515.060017] other info that might help us debug this:
[  515.060017]
[  515.060017]
[  515.060017] rcu_scheduler_active = 2, debug_locks = 1
[  515.060019] RCU used illegally from extended quiescent state!
[  515.060019] 1 lock held by smokey/1435:
[  515.060021]  #0: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
__is_insn_slot_addr+0x5/0x120
[  515.060049]
[  515.060049] stack backtrace:
[  515.060050] CPU: 0 PID: 1435 Comm: smokey Not tainted 6.1.0-rc5+ #10
[  515.060053] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
[  515.060054] IRQ stage: Xenomai
[  515.060055] Call Trace:
[  515.060056]  <TASK>
[  515.060058]
[  515.060058] =============================
[  515.060059] WARNING: suspicious RCU usage
[  515.060060] 6.1.0-rc5+ #10 Not tainted
[  515.060061] -----------------------------
[  515.060061] ../include/linux/rcupdate.h:768 rcu_read_unlock() used
illegally while idle!
[  515.060063]
[  515.060063] other info that might help us debug this:
[  515.060063]
[  515.060063]
[  515.060063] rcu_scheduler_active = 2, debug_locks = 1
[  515.060065] RCU used illegally from extended quiescent state!
[  515.060065] 2 locks held by smokey/1435:
[  515.060067]  #0: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
__is_insn_slot_addr+0x5/0x120
[  515.060073]  #1: ffffffff82d63c60 (rcu_read_lock){....}-{1:2}, at:
__is_insn_slot_addr+0x5/0x120
[  515.060078]
[  515.060078] stack backtrace:
[  515.060078] CPU: 0 PID: 1435 Comm: smokey Not tainted 6.1.0-rc5+ #10
[  515.060081] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
[  515.060082] IRQ stage: Xenomai
[  515.060083] Call Trace:
[  515.060084]  <TASK>
[  515.060086]  dump_stack_lvl+0x7d/0xb5
[  515.060106]  __is_insn_slot_addr+0x10e/0x120
[  515.060112]  kernel_text_address+0xbf/0xd0
[  515.060126]  __kernel_text_address+0xe/0x40
[  515.060129]  show_trace_log_lvl+0x18c/0x3f0
[  515.060152]  ? dump_stack_lvl+0x7d/0xb5
[  515.060162]  dump_stack_lvl+0x7d/0xb5
[  515.060168]  __is_insn_slot_addr+0xd8/0x120
[  515.060171]  kernel_text_address+0xbf/0xd0
[  515.060176]  __kernel_text_address+0xe/0x40
[  515.060179]  show_trace_log_lvl+0x18c/0x3f0
[  515.060196]  ? dump_stack_lvl+0x7d/0xb5
[  515.060206]  dump_stack_lvl+0x7d/0xb5
[  515.060212]  inband_irq_save+0xa/0x30
[  515.060215]  get_random_u32+0x2f/0x230
[  515.060228]  heapcheck_ioctl+0xa42/0xbb0
[  515.060244]  ? ktime_get_mono_fast_ns+0x3b/0xa0
[  515.060260]  ? rtdm_fd_ioctl+0xec/0x340
[  515.060270]  rtdm_fd_ioctl+0xec/0x340
[  515.060284]  ? CoBaLt_fcntl+0x20/0x20
[  515.060286]  CoBaLt_ioctl+0xa/0x20
[  515.060288]  handle_head_syscall+0x115/0x5c0
[  515.060301]  pipeline_syscall+0x85/0x120
[  515.060307]  syscall_enter_from_user_mode+0x3f/0xa0
[  515.060312]  do_syscall_64+0x15/0xb0
[  515.060317]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

From my understanding of the code path we are taking here, it's a non-RT
IOCTL that should be fine to take random Linux locks or disable Linux
IRQs. But 5.10, 5.15 and 6.1 all complain about being idle here. Any
idea where we may confuse lockdep?

Jan

[1]
https://source.denx.de/Xenomai/xenomai/-/commit/91d4232ada71ab2f59709398f370df0c89857e76

-- 
Siemens AG, Technology
Competence Center Embedded Linux
