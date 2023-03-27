Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524B63B6
	for <xenomai@lists.linux.dev>; Mon, 27 Mar 2023 17:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dt7knGiDpYoH2B+ZEGN8O15E5h84Rl4UgaVrIZ1HTWhD6KwNTfZdRo6/6urhSX/acP1vKYenFmBOpc1/kUUyabU+O+jtRLCjdF3NS/sr4qAvoDqK/YzGQcEpn6BuUu6hEIoM2dZBoUc+XRzPXqa3SQzOlAoog68LefgqKPq2d3nioKL8MW4FthCv4SYAu5dWCHFy3FL6bHyr6i2NScYLujkVMBIOVlAVjT0E2iF8thzkJfL6Q9QIaSnogd6gp+qXpx9Qqov8KxzfOJU+0zOfDbP+4CJK30dNYIjq26Jk5Q5GWjtXvg1BiK2GnPt5GWV4yzpnkzC+z3OxnOUekOgJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6mmMMZFULPPytVA764jsGhTUpBzLvSHYn1BASHod1Y=;
 b=LmkZoU4eb5pAna3gVi+0n4GzOHJ1vuu4zJ9J3XfQVPWJjAk5hpS1rFs27jhOYkep7uh8od8wwVFZ8Xi+BvlawrVIsl72wb0qYaJPlGoQAuL//lnCQigxAj61yLsqSEfFNhuYoEuEfFVHtKHyAyASf9pwqcxriM9uKUhOkNvakJtMBGHaSM8FSF/qEf7N9qv229EXfdjQXNWQlgorEwzOUNI3it3zgk2/WACm76hvx/5Tl0kUlJxydMey8jlUzOrA89oSs0vhjN0xHXw1IMu5lSYRKTwVqBmWhA1xfA1AJrCtnQRKWvy/pDotTDEVPsnMKd6XDkTIWG4UpuE4qdw0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6mmMMZFULPPytVA764jsGhTUpBzLvSHYn1BASHod1Y=;
 b=DbSvFG+qskqyu8tmEKKnuoAV+1W5ju9VIf8qTjecEblMxA6TsaeU3a+KMI/QxRBTRIW4XcjMouQloau8+8uqHeOndF+VWSi8T4de1a5vv9KOO0ctsYl4TSx1UmS9TPSaoXacIjXeZUpqTCaSrwruftyRVuZtb0wnCAeKs9XNWN6fMuLRQqpL1v1bwlj+499zncyakjjaaOJeUQ8qK8k7WveQ/yOdKhhq2Cc0iZ3UFkQVdjL1JfTanE+2J+HgdiUDU9Kn/B8B2wquEOp8TGNM/zQ3I8/gGJd16m8tBl9wN4l5Kms6hcUqfxd/kOzOb3NOxyufiRB1L6U8P/xgyiUMQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AM7PR10MB3496.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16; Mon, 27 Mar
 2023 17:30:14 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::70fa:c4d2:5d95:aa96]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::70fa:c4d2:5d95:aa96%9]) with mapi id 15.20.6178.038; Mon, 27 Mar 2023
 17:30:08 +0000
Message-ID: <1550a773-6461-5006-3686-d5f2f7e78ee4@siemens.com>
Date: Mon, 27 Mar 2023 19:30:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: RFC: System hang / deadlock on Linux 6.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|AM7PR10MB3496:EE_
X-MS-Office365-Filtering-Correlation-Id: a452f438-6948-4c74-ebc7-08db2ee8e90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8S0aTjh79VwWXk+SkSu3LLf1Zx2nrUpP8/Kdbg/neD46vQYzZwUiU7yzf1sR41ZGRzWEaQVQJ5TPFF5kQY7pnVmcbV4lnvhewWeGLawL/GTP83aqi6DPMqDKcq8D5ULL52i32LZ4KRx6t/gfzC0R1k5ZjdYS7g+I2K66nS6tOieFiCMNVX0HWs4y8UqGHKKJU03JZ98dpVHc+jXhjkLiyU+3cu3WaBR3ZLHT7At3YJGs3jY5vJ9TsOIK2+sX/xCRMeGo/TIcMfAdAgv53aif3Rve8X4cAQ1xZLYIcAAk15Nd+L6ee2548zharP/ihIfS0UsjTpAiu9Y8+lE6l4tnYcknsLtx/5MRV+EW2uWaIrzHYUTpx23j0R+AaD4WzmsYpDzNSHM13U8OWADggFiNFlEYkMYOYJprFrkPpfyPFdS6WWBxO2frEF93ykjHOE1B4tFa3eYw+bmMEXF5WH6tAMPJXp1RpcAtlEM0XcKIpq29mupHLm5BKoaNSuG6kpWe8mnmz8U9TjitY+JyB/kyAUXRnFHL2Lgoklr5G3M2NRg5t7HTU2kgobAqNaFK5c+xEesyl5yN6EUn7lLl6kG7vu0h/QXbyredNLHvXKRTZVkpJOR61d2SgkR154wG3MlqnlEAOOyAAuwidUpedJnRqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(38100700002)(82960400001)(31696002)(36756003)(44832011)(8936002)(86362001)(5660300002)(6666004)(6506007)(186003)(54906003)(66946007)(41300700001)(316002)(478600001)(6486002)(31686004)(6916009)(66556008)(4326008)(6512007)(66476007)(8676002)(83380400001)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M21yc0dCREkyRG5zZzhZN09EK0VRUTJOdk1GcWdvOWZXTnFUSjFEMXV4aTlk?=
 =?utf-8?B?RkpESDZwMTVJY2JCd0pCeVNEOWtFaEVlSFZjdHNJTGpsNjRtL21ESUpEVzFa?=
 =?utf-8?B?V0pyYWZIb1ZkVExVdlAwS3A0QXpzampnUXJlVnk0WFp0NGVOV3lxRHJxM3hR?=
 =?utf-8?B?UWlYOHdsNlZDYmVVSU5hOVM5ejdjaHJWdzdkd2U2UmJBSGRRaW1oUmhRNE8v?=
 =?utf-8?B?bEtZRXBpdmJqN0Zla3B2TVQrSlJGVC9YcDA5WU0vZ1ZGNE5yUnN0UnpxSzBD?=
 =?utf-8?B?K1NhQy8wNmRhTTlnR1ZqY3orVjdMd0ZNV3RFVno2WXNYM2VWQkRqdTJ3OUgx?=
 =?utf-8?B?TStGeHdLRW96MDZ6azV6MFkyK0xvTHZsYlZnZWlhYWZQaWQ1SnlycGFxenBI?=
 =?utf-8?B?TEliRlVqSTFxRVBOV1lWZjFzdFVYbUU0YkdBMTBkYk13SnBEVzJ3YXMrN3hz?=
 =?utf-8?B?UU9JV1REalRGN0c4UzhIWmRsN1o1d2JPWVhLUDlrYTMrbG40aTVORXM4WkFq?=
 =?utf-8?B?eWc1eXdDazJxbXJVaXJ6dkFCQm9OVmdMTTkyRUlrOUJGQzRXV0JiSklXK0FR?=
 =?utf-8?B?em4vSFBpdy9HaU9GL0JrWHRpNDhrUzk2Q2ZXSzFPL1JjWTM3UWJHMm9OQzJQ?=
 =?utf-8?B?ZXJjRytOM3hGMFdmam11eUk3M2Z0aDBneURUdzd4SkFUUFYxc29HcWVTU1Zl?=
 =?utf-8?B?VU9RQWtGYVI4UXpuZ2RDdWFQWURHWlNCUTlyQnFYMVJMNHlVWFdZVktKUFJz?=
 =?utf-8?B?eGw0b3g0VjJVV1YrbXZWRmZwYnhidTZwbStzeWp3TE5iZlhML1BwTHBGYUMv?=
 =?utf-8?B?NW9YMTZmYmdjTFg3QWc0MzhnYlpta09reXhEVzdUbXdVT1RHMXVxNXYweGdw?=
 =?utf-8?B?UW1tS000SWdIQ1BVOVRyeXE2VFpydlA1MnlDVGozcmgzVyszSlQ4V3NkL1h5?=
 =?utf-8?B?V2dvSGZKWGRuNFRuVEhTeUFBTnVvNkduTUgvWHhCWlZkOXdwallOSmJPRm0r?=
 =?utf-8?B?U2VqVzlnSEQzVHJuZldpUSsvM2FVbjA2ODYvdkxEc242ZVNXMFBHa2VJWUFV?=
 =?utf-8?B?UjJwZnllMG15eDZUOUp5UmxySXNWcmlySWRQdnAyY0xWUkxhSjRsZ1loQkRX?=
 =?utf-8?B?QWlpU2VJczQ1NTdRenJKYjJnRlQrMU13VHBuVGpkai9KMDdUMW42QlgzQmFY?=
 =?utf-8?B?dWJFdzA5Sy9BOThVY01IOHhkMG5ZNXNEWndFMGovYmhIaVM5bktHQTdZa3pv?=
 =?utf-8?B?bnE5RUJxd3V3OEhWNCtnUEtVdy84QXYycFVEVTc5MlkzOXdiTFBEaVk0THo1?=
 =?utf-8?B?ZWsvNVh1N0xDcWFRQmxVbURsNXFaYUFlWkFHWlYzeHlDVEt2OHA0TzlicEdL?=
 =?utf-8?B?aDduaGhqRlU3S1ltVDhaTk1scWNBWC8zMlIySjhYMEhDV21LL1cxTFVQcTNX?=
 =?utf-8?B?VXV6bG9lcHV3TGtUZWJ0MEdNUFBWQUY5dUVFbUlWcUk0TU5Oampnb21YQzUz?=
 =?utf-8?B?NnUxK3JzMHIrclpWY2hKUWo1MU9wdmxhYitsRE4xU0NSN2dnZDcrOG4yRkxn?=
 =?utf-8?B?SHl2MHZXV0N3bEdMWnpUVzZUU2o0MkdZSE51MnR0Q0FYaEFNREJPdWEwQWlJ?=
 =?utf-8?B?K1lGdmZGOFlaZWxrZTBOV252b1NXZzFMMEd2Y1hhM2tVOVM3all3dHJndjFj?=
 =?utf-8?B?RVM3MmpaaE9adHIzU2hYb1pqbDdHNDQ5L2Jic1RHc0VEejdYTk1LTFh6YnBi?=
 =?utf-8?B?ZVBZVUlqU25xWnpIMlladVY1RS9HZEs1RXdoTGdNQkJuZjdaU0xLNVhQd0lD?=
 =?utf-8?B?YXlkNUN3MytMV0VDV1lrd0czSDZicGdEWWYvbFdVOTZrTS9QMWFBM1M0YlE1?=
 =?utf-8?B?S1NuZEF3OHgrUVA2TUZ4YVF5TVYxWkY4QVZNcG9HSjNYRU81TnZHckw1WFQv?=
 =?utf-8?B?blZZYTZKZnY5anF6VmlwTjU4cHUwRUNweGUyUVFqNk11b3JlOGtTUmgydjdL?=
 =?utf-8?B?RWZVZDVMZGNRUUlRemJ0OVoyYlAxWTg5Z2syKy84R3RCMW94aG9UamJqdW1Z?=
 =?utf-8?B?TlZKTS9WOWZ2RzZkMW9reGJXMHNuM1Z4OUF4aVJ4RUp5bi9XVVUwS1p3c3Jt?=
 =?utf-8?B?RHI2ekxvckJucytwb2hzTVhyRDV2ZE5mSVoya3ZaTDcxUk0wdjFBMTNBaFV4?=
 =?utf-8?B?VStMTFp2aDExeXZEOXQ0U0ZoSHdHNDNHWER1aVNkejZ4UHYzY0hKY3VLQ2hX?=
 =?utf-8?B?a0dGUEtmMHFYQlZndFEvNjRnUjdnPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a452f438-6948-4c74-ebc7-08db2ee8e90c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 17:30:08.1535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzwEcGW7OvdTktbaS819RlHbftJiNkH47jAuDccWB4Wve0D5Qd7cLe7y8vqXEhZK0JLc/YJK7iqEFiitr3xgyGWMLANj3c41Bx2PWPjw1oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3496

Hi all,

I'm currently investigating an issue reported by an internal customer. When 
trying to run Xenomai (next branch) on top of Dovetail (6.1.15) in an virtual
environment (VirtualBox 7.0.6) a complete system hang / deadlock can be 
observed.

I was not able to reproduce the locking issue myself, but I'm able to "stall"
the system by putting a lot of load on the system (stress-ng). After 10-20 
minutes there is no progress anymore.

The locking issue reported by the customer:

[    5.063059] [Xenomai] lock (____ptrval____) already unlocked on CPU #3
[    5.063059]           last owner = kernel/xenomai/pipeline/intr.c:26 (xnintr_core_clock_handler(), CPU #0)
[    5.063072] CPU: 3 PID: 130 Comm: systemd-udevd Not tainted 6.1.15-xenomai-1 #1
[    5.063075] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VM 12/01/2006
[    5.063075] IRQ stage: Xenomai
[    5.063077] Call Trace:
[    5.063141]  <TASK>
[    5.063146]  dump_stack_lvl+0x71/0xa0
[    5.063153]  xnlock_dbg_release.cold+0x21/0x2c
[    5.063158]  xnintr_core_clock_handler+0xa4/0x140
[    5.063166]  lapic_oob_handler+0x41/0xf0
[    5.063172]  do_oob_irq+0x25a/0x3e0
[    5.063179]  handle_oob_irq+0x4e/0xd0
[    5.063182]  generic_pipeline_irq_desc+0xb0/0x160
[    5.063213]  arch_handle_irq+0x5d/0x1e0
[    5.063218]  arch_pipeline_entry+0xa1/0x110
[    5.063222]  asm_sysvec_apic_timer_interrupt+0x16/0x20
...

After reading a lot of code I realized that the so called paravirtualized 
spinlocks are being used when running under VB (VirtualBox):

[    0.019574] kvm-guest: PV spinlocks enabled

vs. Qemu:

Qemu (with -enable-kvm):
[    0.255790] kvm-guest: PV spinlocks disabled, no host support

The good news: With CONFIG_PARAVIRT_SPINLOCKS=n (or "nopvspin" on the kernel 
cmdline) the problem disappears.

The bad news: As Linux alone (and dovetail without Xenomai patch) runs fine,
even with all the stress applied, I'm quite sure that we have a (maybe 
longstanding) locking bug.

RFC: I'm now testing the patch below, which is already running fine for some
hours now. Please let me know if all of this makes sense. I might have 
overlooked something.

If I'm not mistaken the following can happen on one CPU:

// Example: taken from tick.c, proxy_set_next_ktime()
xnlock_get_irqsave(&nklock, flags);
// root domain stalled, but hard IRQs are still enabled

	// PROXY TICK IRQ FIRES
	// taken from intr.c, xnintr_core_clock_handler()
	xnlock_get(&nklock);	// we already own the lock
	xnclock_tick(&nkclock); 
	xnlock_put(&nklock);	// we unconditionally release the lock
	// EOI

// back in proxy_set_next_ktime(), but nklock released!
// Other CPU might already own the lock
sched = xnsched_current();
ret = xntimer_start(&sched->htimer, delta, XN_INFINITE, XN_RELATIVE);
xnlock_put_irqrestore(&nklock, flags);


To avoid unconditional lock release I switched to xnlock_{get,put}_irqsave() in
xnintr_core_clock_handler. I think it's correct. Additionally stalling the 
root domain should not be an issues as hard IRQs are already disabled.

diff --git a/kernel/cobalt/dovetail/intr.c b/kernel/cobalt/dovetail/intr.c
index a9459b7a8..ce69dd602 100644
--- a/kernel/cobalt/dovetail/intr.c
+++ b/kernel/cobalt/dovetail/intr.c
@@ -22,10 +22,11 @@ void xnintr_host_tick(struct xnsched *sched) /* hard irqs off */
 void xnintr_core_clock_handler(void)
 {
        struct xnsched *sched;
+       unsigned long flags;
 
-       xnlock_get(&nklock);
+       xnlock_get_irqsave(&nklock, flags);
        xnclock_tick(&nkclock);
-       xnlock_put(&nklock);
+       xnlock_put_irqrestore(&nklock, flags);
 
Please let me know what you think!

Best regards,
Florian

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

