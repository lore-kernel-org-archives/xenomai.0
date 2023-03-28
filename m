Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2054.outbound.protection.outlook.com [40.107.15.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74534947A
	for <xenomai@lists.linux.dev>; Tue, 28 Mar 2023 16:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLYvhDtgFvS81AWuv7ivgfq6fsSZ+QG4kPLrLGYH4esSVKVpu/t5z4eJVquz8Rd/VrVj596rnlxleA4wkpfILS5EYVGJnwKqtbdTYnBSpqdthrqjDQiQjRbO2ic2b4wSChp5AvNUyY95sfDVmxI2/vpzYrtPu5EFFbfhUIEfIMHZOUx49iPh8d6QEGZweaYTk0RPuKXjunr9Hap+5pkbE9OXGyjirKDWOEFT6N/o1P5/rxfR+JyvQpHAyGEKeK41BU08piExWYP+B+b6SHuxclQN0qfpH6T0F2oVjqZnzQhsu3dstzLHFfD8MO1tjdR4cuXreGcBzq3y4z9zSu0u2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAXJNCvpF4nEBiNnaAdmyFfp6rAZKwnwnEvV3XHIGPg=;
 b=HGhb8fBMethnUcjZOV4WvcDeXe3zwpCm0bF2Kd2Ou5xNvUenm5qfEple8s/7NKx73lRa9APY6YTk2fFNn4JoouGt5pfHZs/dcmdMw4cTFLtuUf1o+9sldBxlvOxzuQRX16bbMh1XdI2BjmOickUFGs/K9rJeWxD8OdygvQ/wsgj49mXyGMhhS2X6vqX8NEWarNHNPqc4wfjN8TohNg21qIGDlW6kTohGewM9FrAnobfFwWKaKaQ4izEc7vF72qAAkXpVxi2g+1b//UhDgiI+Wmdy2RR1WXevo/p8ht8hWfPC+dEzQsIf+GfWOuH3uMOQA4zGQVb5GwXO5ZPqIswB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAXJNCvpF4nEBiNnaAdmyFfp6rAZKwnwnEvV3XHIGPg=;
 b=WdSHwAYLz6Ckm3DAnUSnNpT5VdsFBWnXI+MpXCApyMhDxQji2e7d4n50sKahdeYs9wQfCJ8nGdE+eFxdKfJvSbwYlwHDIVWv7uLj3gUyWgwiBjDGi3hmW72I3PiumVGpiqMVDEcprK6kx5WzulcKp608sbFpQMs5oLvD9tUWzTWyzWfztrZ5mVXjjnA47OvKxQ7TsKJMyaerD35/TMjhLd0pVizNVjLu5uisQcvw8q6UGnPAsf2QO9EM6nyZXD59unWSVA+b1Ewoc0VCThp8AcWwQVRdQFAzn2km0nWVrN5MwC7xY0aGDB+eWJb72A2TxTMjyKj8SKQO9ZDU13+iXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DU0PR10MB7923.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:321::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16; Tue, 28 Mar
 2023 16:01:54 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::70fa:c4d2:5d95:aa96]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::70fa:c4d2:5d95:aa96%9]) with mapi id 15.20.6254.018; Tue, 28 Mar 2023
 16:01:54 +0000
Message-ID: <8cdb7db3-cf99-9fa7-be7e-d0104b74831b@siemens.com>
Date: Tue, 28 Mar 2023 18:01:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: RFC: System hang / deadlock on Linux 6.1
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@web.de>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <1550a773-6461-5006-3686-d5f2f7e78ee4@siemens.com>
 <09e26675-d1f5-7726-a803-6ee1fd01ecbb@web.de>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <09e26675-d1f5-7726-a803-6ee1fd01ecbb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::14) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|DU0PR10MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 982c87b4-550b-4f4b-8ba9-08db2fa5c037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oio8cvMudLuwxN9iOG9Ik1re3N8BY5A1vEQd5IeVbEFU4vAPrjQG2O9SL9a6QsoCZlAI1azzfR+CKNYjKK/+yFSgyINs9LFG/52WOMttSE2ro+sJgR1k0pO6rP1TF8eJityCES6tYPkeW/Op0eaEOH1S9QzIpGONXmepFdrLbxccT5k+U/TEvgfhXrpzgc92gaMlZ12NcGt+ZReldz30D+DgJZGpQ1WghFpG2a5GmWerKgspYk5YGA2oI07wQZSUCcfyebRBwsPMPKgQwHUb9A4i/zkZ18LgjAyCXcZFU9IQpmoJavawNJ3x7KkeCJS1eT4ehCirW+A/ukTU4idOoSry5rz3Ka4b0gjwlmLPczbsNqf2DAP08qF726djcvPMj9EpFOgUKoAjneVq4aqjJA2ueSIVGEFAEsBRNKara8p+PM2g/7sTS2wjk74gNCLCqBsX44gFRgvxKCxC6sMPu9GBag4WIOgn+V1At9tLqbDev6YH5+RPbN+ksdHgAqiEvwkuuDOc2elJo9JznzEVC9cmO7VPKSXdtk5Coz0RBNioJGBS864lzKqIZLdI1kPjhAzzMx+YKRK/AxiA0bAUyBxfF18zIidRd1Q48nQU2NlRzToGFS6ejILQpOhWpFQILcBqzje4Zf1/11PcZcTpAg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(66476007)(8676002)(4326008)(66946007)(5660300002)(316002)(66556008)(2906002)(31686004)(8936002)(53546011)(44832011)(6486002)(478600001)(41300700001)(6506007)(6512007)(186003)(83380400001)(2616005)(38100700002)(82960400001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFdpRnZVSkdTSkNCSEdGSUJzV0h1VFdXT2FnT3dQK25RdHhMQ1NPMjVmelhX?=
 =?utf-8?B?Y290ZVZwL2Z3R09mYlVzM1NiWFNGeEg2TUl1ZlpTS3Ewajk4WkM5Y0hIeFdI?=
 =?utf-8?B?YUFUMHovSCtEa1lmcklEc1JiMmNZWmFxMWdkSThua1BOWnAreHBwaXlqSW9y?=
 =?utf-8?B?TXQzWkdHamR5MDFoU1pWdkozYUlMdUhsM3ZUSVcyd0pLcDArRkFITWZRNjRu?=
 =?utf-8?B?U0svRGs2U3Z5NWljeTR4NGtDb1QyNnI4ZzZKK3hpVDZlUTM1UTErZkRROUhl?=
 =?utf-8?B?QmVRRVdpWllacTBDZHZ3RUxUeWl4WldEUUVNbHYyMXdvU0pGdUY3dFZHbVA3?=
 =?utf-8?B?OVh0OEZneDQvRmdhUWN6TzhKYXViWFFmWWdBU0dzL0g0OXJoUmJDRGcvaHRz?=
 =?utf-8?B?YU1tVjdhVEZxR01HamI0ZGgzVHZvUzJsK2xkQzVCRzFoTU4yNHFTTVBvT1I0?=
 =?utf-8?B?czFJQU9zUVZ0YTVyeVFBRk1SY1Fqc3czUVBVWWpwYjNoRmJldjYyWFh2dkRn?=
 =?utf-8?B?U3BBYmlKMDhEZzVJVEh5b0hVQ3RlMjNranE5VnpXUHFtWGtqU0t3c1NIQzNQ?=
 =?utf-8?B?VXhzVFZDT1VydGUrcHlqNnR0aEhnVnZDSk1JaDVtMk0zNzd5Tkw2dEJTVEoy?=
 =?utf-8?B?NEpPaU8ycDJRcG50aGhoQUlxWjlZQm4zcWtRb21PS1RhZ25sYTZkMlh6NnFJ?=
 =?utf-8?B?SFZRZUxuSTBpR0hwdnI0WTE1OVo3akxCajVtUUU0OTQxZkYzSU9xK2JacDNj?=
 =?utf-8?B?bFFMM0Y1RnJCRXZlVGJTOElHYVE4Q2lPK0ZubU11aHV3U01KOU1rbGZEY3Zr?=
 =?utf-8?B?VXp2TW42VVYrS2ozSk9rTWR5SFVXU0FqM0RyQlltRGY2REM3ejN6K3JjR2Zr?=
 =?utf-8?B?NjhRc0hPbHRocHRIQkJ5Z2RIYVE1bFNRL2k3a3ZWNFZjM2NTYm4yS3prK0FD?=
 =?utf-8?B?ODZJOGtQTDZhbTdhOUJLZ2l4ODdjRkloSUhHQ2tFd3BRUzdLS1ZZeHdDRVNo?=
 =?utf-8?B?T1hkdEVlMTlRWVNtbmdreGpOM2FyaGcrdnB3bkxTTTIrY0trUEhOa20zcW9S?=
 =?utf-8?B?djFLelNOSVdiWDNPblIyOTZRVzA4cnVWdTlJekZjVGJ2QUc2QTBpOVo4S2Y0?=
 =?utf-8?B?U1kwelhlR2xyQ1hkd1g0S3VXRHNtbTBRcTJoeHlmbkxVYnN0L3B4TW9kWVd2?=
 =?utf-8?B?WkNZM080QnYzTnh2OHcxZ3RqcFRsVk1ING1KWW1yYmY5Zzl1OVNBRktOVGND?=
 =?utf-8?B?dnVjZ0dSb0hpQmUvWUV0c3J3MDVONmEwdlR3a083VTJFTmQ0WDYxczdBUFVm?=
 =?utf-8?B?eVF5cWdXOWxYNFNRNDkyWVF5NjR5aUx1OWNzNDJzYUE0dW1QWDc3VWxhT043?=
 =?utf-8?B?b2hvTnZmdFNvS3d1ZjltYkg5NmhQLzF2RUZOMlZlNHdNMUduMGVwUWlnMW1x?=
 =?utf-8?B?a2MyZS9RRTlzRnZBZ0hZMmNzYUxDeVBPRCtGMmtTakNHVkNMTGlubVFLbTF5?=
 =?utf-8?B?cUU5bi9MTEcrc0VtRVFxNHlReFlsR3hEZGZscWg5OUtYZE9iQ295YWpZdnFw?=
 =?utf-8?B?bm5uSHFXSXlzQ1EvdnZtNFR3aUFOS3plWTZjMUdUSUlTUk10bkNub2oxMHk4?=
 =?utf-8?B?b25BTksrazQ0bjRYQ1hqUE5Zei9pVmFPYWw1L1dTMFpsVzBLY2xkQlRoSVY3?=
 =?utf-8?B?UEE2WmUwTTMrVVVKODRwYm5CQVJ0Z29jZVo2ckM3VXFSRU1xa3VJdDdMcENO?=
 =?utf-8?B?SGJZZnd0N0RwUy9JTXRvOGJDUWdnYTZ4eGYxblRjaVVHaEpJWGExTFkvQUZl?=
 =?utf-8?B?RGNEQ0locisybmdxb1lnSkhCQ245aFcycnV0TlE3bWhlOVVKd2VoVTdkZC94?=
 =?utf-8?B?K3BSeUZkKzBweTdzRUZzYmRKWmFPeStRQk9tOHh0N2dJWG1NTFBIWVdGY2lo?=
 =?utf-8?B?ZGhMb1ZVZnhIVW8rU3NNdkMySzk0c21BWkZRbDZlbkVNeXVHbVlKQWRGWmY2?=
 =?utf-8?B?aVlncGpYSjA2SG9QbUR1b1pwa282QUV1U2QrZyszK0lHYzFIQ2puRXJyNU1P?=
 =?utf-8?B?SklGTS9KdmlQUEJjbkZTbHlURHhxN09YbStlZDczNjFDRE5hYW5LdEVRZ253?=
 =?utf-8?B?WGZMS2lEUXVFL0R5MTR1aFhYZlZwbmIxZWdUQ1ZlZjlCQTB3WFowM2g0a3JJ?=
 =?utf-8?B?QVNncmZ2RHcrL2s1K1JieXplZGZ6eU1HanFZYkM3UFFjeS9salFkeU9jamgz?=
 =?utf-8?B?NHBQV2oxN1hSdkFmTko0ek9lMzlnPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982c87b4-550b-4f4b-8ba9-08db2fa5c037
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 16:01:54.5728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQJvyx6/6zqvkqg/o5jpMmSeZsWZIYkRCEvsWSD+g7Di+1yf/zrICoqwavzGDPktQFbTWq1zhOOV7Q8lzsutPllp7fp+QfBTQKb9DrePE0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7923

On 28.03.23 01:01, Jan Kiszka wrote:
> On 27.03.23 19:30, Florian Bezdeka wrote:
>> Hi all,
>>
>> I'm currently investigating an issue reported by an internal customer. When
>> trying to run Xenomai (next branch) on top of Dovetail (6.1.15) in an virtual
>> environment (VirtualBox 7.0.6) a complete system hang / deadlock can be
>> observed.
>>
>> I was not able to reproduce the locking issue myself, but I'm able to "stall"
>> the system by putting a lot of load on the system (stress-ng). After 10-20
>> minutes there is no progress anymore.
>>
>> The locking issue reported by the customer:
>>
>> [    5.063059] [Xenomai] lock (____ptrval____) already unlocked on CPU #3
>> [    5.063059]           last owner = kernel/xenomai/pipeline/intr.c:26 (xnintr_core_clock_handler(), CPU #0)
>> [    5.063072] CPU: 3 PID: 130 Comm: systemd-udevd Not tainted 6.1.15-xenomai-1 #1
>> [    5.063075] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VM 12/01/2006
>> [    5.063075] IRQ stage: Xenomai
>> [    5.063077] Call Trace:
>> [    5.063141]  <TASK>
>> [    5.063146]  dump_stack_lvl+0x71/0xa0
>> [    5.063153]  xnlock_dbg_release.cold+0x21/0x2c
>> [    5.063158]  xnintr_core_clock_handler+0xa4/0x140
>> [    5.063166]  lapic_oob_handler+0x41/0xf0
>> [    5.063172]  do_oob_irq+0x25a/0x3e0
>> [    5.063179]  handle_oob_irq+0x4e/0xd0
>> [    5.063182]  generic_pipeline_irq_desc+0xb0/0x160
>> [    5.063213]  arch_handle_irq+0x5d/0x1e0
>> [    5.063218]  arch_pipeline_entry+0xa1/0x110
>> [    5.063222]  asm_sysvec_apic_timer_interrupt+0x16/0x20
>> ...
>>
>> After reading a lot of code I realized that the so called paravirtualized
>> spinlocks are being used when running under VB (VirtualBox):
>>
>> [    0.019574] kvm-guest: PV spinlocks enabled
>>
>> vs. Qemu:
>>
>> Qemu (with -enable-kvm):
>> [    0.255790] kvm-guest: PV spinlocks disabled, no host support
>>
>> The good news: With CONFIG_PARAVIRT_SPINLOCKS=n (or "nopvspin" on the kernel
>> cmdline) the problem disappears.
>>
>> The bad news: As Linux alone (and dovetail without Xenomai patch) runs fine,
>> even with all the stress applied, I'm quite sure that we have a (maybe
>> longstanding) locking bug.
>>
>> RFC: I'm now testing the patch below, which is already running fine for some
>> hours now. Please let me know if all of this makes sense. I might have
>> overlooked something.
>>
>> If I'm not mistaken the following can happen on one CPU:
>>
>> // Example: taken from tick.c, proxy_set_next_ktime()
>> xnlock_get_irqsave(&nklock, flags);
>> // root domain stalled, but hard IRQs are still enabled
> 
> OOB + hard IRQs stalled (xnlock_get_irqsave -> splhigh -> oob_irq_save).
> 
>>
>> 	// PROXY TICK IRQ FIRES
>> 	// taken from intr.c, xnintr_core_clock_handler()
>> 	xnlock_get(&nklock);	// we already own the lock
> 
> If this code runs under the assumption that hard-IRQs and OOB is stalled
> while they are not, we indeed have a problem. Please check where that
> may have gone wrong.

My warnings used to check the context actually never triggered so far,
but the system is still entering the broken state. Some further findings:

- nklock internally uses a arch_spinlock_t for locking
- nklock is used by the proxy timer tick IRQ, so very "often"
- arch_spinlock_t is very rarely used in Linux, I found only a couple
  of usages inside x86 code (dumpstack.c, hpet.c, tsc_sync.c)
- arch_spinlock_t might use the PV optimized spinlock operations
- Most other spinlocks (especially in dovetail) are based on
  raw_spinlock
- raw_spinlock does not use PV optimized operations

That might be the reason why Linux alone runs fine.

I'm now asking myself if the PV spinlock implementation provided by
virtualbox has a bug... As virtualbox is to some degree based on KVM
that might be a KVM bug as well...

Let me try to force the slow path for arch_spinlock_t. Maybe my vCPUs
never come back...

Florian

> 
> Jan
> 
>> 	xnclock_tick(&nkclock);
>> 	xnlock_put(&nklock);	// we unconditionally release the lock
>> 	// EOI
>>
>> // back in proxy_set_next_ktime(), but nklock released!
>> // Other CPU might already own the lock
>> sched = xnsched_current();
>> ret = xntimer_start(&sched->htimer, delta, XN_INFINITE, XN_RELATIVE);
>> xnlock_put_irqrestore(&nklock, flags);
>>
>>
>> To avoid unconditional lock release I switched to xnlock_{get,put}_irqsave() in
>> xnintr_core_clock_handler. I think it's correct. Additionally stalling the
>> root domain should not be an issues as hard IRQs are already disabled.
>>
>> diff --git a/kernel/cobalt/dovetail/intr.c b/kernel/cobalt/dovetail/intr.c
>> index a9459b7a8..ce69dd602 100644
>> --- a/kernel/cobalt/dovetail/intr.c
>> +++ b/kernel/cobalt/dovetail/intr.c
>> @@ -22,10 +22,11 @@ void xnintr_host_tick(struct xnsched *sched) /* hard irqs off */
>>  void xnintr_core_clock_handler(void)
>>  {
>>         struct xnsched *sched;
>> +       unsigned long flags;
>>
>> -       xnlock_get(&nklock);
>> +       xnlock_get_irqsave(&nklock, flags);
>>         xnclock_tick(&nkclock);
>> -       xnlock_put(&nklock);
>> +       xnlock_put_irqrestore(&nklock, flags);
>>
>> Please let me know what you think!
>>
>> Best regards,
>> Florian
>>
> 

