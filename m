Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89262364
	for <xenomai@lists.linux.dev>; Mon,  3 Apr 2023 05:31:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPFqDltcBszzzyBYZkX83i7bf9iQSWPWujbs5K9KJrDTctqlY3FDdmO4pASaJKWjhMcOI7a9LuWU3QTrhoxN3j7zktLy3KLmjlT3JpzkZGH8hhL/9mVY/ubQnKip3JlQwCn6NOZXmfTng/LQiY9n7aBLimS7SR2dFHsExpOYCMJY503mxVTM9ICCCKsANbeIVzfRN1a87tCE6I6TJSj4WLSRydLoEK8OLlJE5OCm6Pj6ZXXyYY0ZwFdVkKqjRN505mRzGxxKqb3aK6JXF326vLnVo89RJN4ma+WfDSUzC7j4kVJi+opEoNG0dEKzZ2u5571oDhNn+hBD5f7PgsvwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsKpqb4whzF1Gw/kwZHvahpBFHopOtg4gekaphgxENo=;
 b=dunKe/1su41oRd8MbQmn7aoTrYT8MVbZBnwMp0MGC8AMc2NCM6ei27w/NcvKVGwoOUh+bu3W0hDYv/lUABlYYyOGxI59f1ao+KoAcoxczguCcizn2ojjuCWDgbGFXkpWzqZrE+j12ZaJ9ojMRyyPSAZUGOmGcYn5Hj2a5N4yOy5ecECxLrPeEJRevJMBWzonujl3MoyKBu9gLMlrwoeobqspZWr0bKyGh9OwrGY4QNy2YrBBI+onx6TLnGtSD6oTB60IQNUBrg2H0GdcCJOCyZbcqt42wosZL3h/hlTkeZNEz6sDgwueq1nRhWSKPsYW462AxOfZFOb7OldFE6olVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsKpqb4whzF1Gw/kwZHvahpBFHopOtg4gekaphgxENo=;
 b=FK/ycOqJr7mwJX27dZFB47f6td4ySA69c5fH04T66onAtqq1WTgAAV4EIDH94EtmqMoKOuPxU2RF5/B/XVj2zxkwfb8461AYPIj5bB28KqdELRkYkomZ7FNCsMXwi+WjWTcxnMpVoe6MO12poW7impM4uCIfDigazNmiwrW7k1XcGtIloOywjBSueOnS3NqI0KqS1fbfiPWjZXohI5FngmAwYJTxY4QlzB9gN7IaYbYLaLyXstbIHh2ixyeo7i5VEaCMqEpU0Ur7OJy+3gIEmXUfzqwwVh59gPReOY3EWy1IjDj8GMVjYCXxKbCih9pVDwtAxgBq4gNzpGTP8PCAnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.26; Mon, 3 Apr
 2023 05:31:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Mon, 3 Apr 2023
 05:31:32 +0000
Message-ID: <03cf4874-9a8a-12c6-00f4-6ee435180128@siemens.com>
Date: Mon, 3 Apr 2023 07:31:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: RFC: System hang / deadlock on Linux 6.1
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Jan Kiszka <jan.kiszka@web.de>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <1550a773-6461-5006-3686-d5f2f7e78ee4@siemens.com>
 <09e26675-d1f5-7726-a803-6ee1fd01ecbb@web.de>
 <8cdb7db3-cf99-9fa7-be7e-d0104b74831b@siemens.com>
 <de2ff0a777bc4d42a4d788c16061b7ed245b7616.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <de2ff0a777bc4d42a4d788c16061b7ed245b7616.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d813fe-7a85-449c-5b70-08db3404aeb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uWQCOyPdCInTXLkGcqkEjqDOV0OQPNQIUgm4EcUuGNED7UWyBzG/14KbCSegL+vfHmnIqiyhHSRQN1DcXS3CgoNQJ0Di3UstsJwZre1I7SwuHX6GGXp4+HFK6ILNQxZoow6Jj4tTF1MYA1Dm4Gz5E5ZiOg57Op0O/K2v2vyOooKYcpr5o8RiVu3Smo8uGJ19kWjpT9LqL+GKW5eP6N8nyT/fVqZcpQlLS8JJDTLZ+3klk0UlIvfa08gxBqdXItSwgVB1cYQJMR1h+Pfp1vUNQobwqYIeM6WWI8E7k4nNEhDgEnlFE/CEUMQ0r9gr9baElZ6wg8IUf7D5dn3cogUiWFh5MrEgetpV6NUffulbrfE7H6372Xo1l0X9Y7ungDAIrdI13bDQkTPWzNyYublm+e1WzINXNcjtLFLgSlaik909JZxyHBv74Fz1+SHewW5WkuiRYC0J1W00Ag9ys7WGws7fhpBZ/Fqtzi+Prrd5uInmq4BRn2sVX6AJpVKYTs7UXeVbf8uiK2JCeFBMBzVN/zp1zIrl9TJ2vk4/lQNT6IrIMPmCFZrlKItvRkrqDaE60Xb3ZDUM8SKczRJKdHsi59vZ3MTsZX993aGjUlkuPYALcsie/r7aTbUEd4OD9KPmmMmKkUnnVQ1UNX+5RFULBQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(41300700001)(4326008)(8936002)(82960400001)(26005)(110136005)(316002)(5660300002)(31696002)(38100700002)(86362001)(44832011)(66476007)(66556008)(66946007)(31686004)(8676002)(478600001)(2906002)(83380400001)(6486002)(2616005)(186003)(36756003)(53546011)(6506007)(6666004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1ZuWHdVaGF5cEdueTg5bENNMTR1QSt6ZHFJMkxCL2cyK3hvRzYzbElXUTNl?=
 =?utf-8?B?ejZ6Y0dLR1NEMkdJNVo3dFFFSzFzNGxhZ0pDQUk1ZHRmbFZGM3dCQktVVGtQ?=
 =?utf-8?B?ZWdqS2Ezb0NoSWZLay9zamZaaXc4bFcxTjVEYTFUcDZxMTc3S3hVMUpLQmZJ?=
 =?utf-8?B?Sy8zVVNHQjRHZEo1TlBFSlBjTkFLWktXdjVhUUVqVmJJZTU0K0pwRFpQazNP?=
 =?utf-8?B?aFprem4zZG1LWmZ3U3RvTVF1aUt4VlNQTk1DelE0M1BXUnhpMnlyZkhOWTd2?=
 =?utf-8?B?QUN5UmdsVHp5Q3hrU1BuZ3puQlpRaGpTaStWTzFRMG9MOWxBZ3VmTDhCZGFw?=
 =?utf-8?B?YXN1d1kvend0Z2xaUTV6YjJESkNIaUxjdnJHQ25vYWtsZGN2cnJzd1Z0RFhr?=
 =?utf-8?B?Q0lWY1UxRzFvdFNQMU1zVU05ZFovREp2VDFLTGpMSzNWRUdCbW4rVERzUUdy?=
 =?utf-8?B?M2tuNWFHTTFpZzdaa2xTV2VGUWNuM3ZrbWJocWtCZTdUMHpoK21oVmhqYm05?=
 =?utf-8?B?bmF1Z2VoVUNZalMxWkJkenpmMjFhRWFsMXZDOUozenZ4SXhKWnVHM3JNWjFY?=
 =?utf-8?B?dEVhVHBNUWNUZ0lXeHE2YytTd0tOYU1XSjBmNFY4OWVGYW1MU3JzK0xOZDRl?=
 =?utf-8?B?K2ZhS1drNCtrWkU0b2wzQWZoVktKTUJhTEJPVGp1SWNLaFYyQWRUcjdIUnhx?=
 =?utf-8?B?U0RtMkRaUFUzZm91UHBCZGVRZ0FxWkthM09kcjNxWUh2SFlzVmlIb3VMck90?=
 =?utf-8?B?N0xybHJrNWRwQWtaZUlBK2lJbUt4NW1wTG9DOWRsZWJockVqVVdrQ3ZCUFR3?=
 =?utf-8?B?NUVzSm9WbzFpRWtOVnlacVR2cDliVUgxVk5tbzVLK0JQejVqTFQ2YkM0Rmpw?=
 =?utf-8?B?eFdldnBvM0pJbERPcGtKbGVHanFlZk96ZE5YN29YUjBsL2lCQWJuWmU2c3l3?=
 =?utf-8?B?MTYveCtNcmpRT1RHTm5PTjBTbFlnSkx2KzU4ZTJBYXVhYlU2WS8vT2FGRmts?=
 =?utf-8?B?OW9rR05UdVFwRVFVMGNPVlE2T0Z2VHIvVkZUc29kZTZHWlJKdG5EL1dVNGVm?=
 =?utf-8?B?aU8xUlRNQzZMV2FhUkhNbytmNEtGbnU0RVF6ZXEwcG00QlVmajl6RW8wN01l?=
 =?utf-8?B?cGdneElLZDdnZStHYVBHdzUrL3Zta3lrelp0Y01BOFU2R3VMU3lZVmxvNmw3?=
 =?utf-8?B?UG4zeFVkZXVOVGlLd2IrTDlvS3dOdVdoWG9CSlFPeDJqZ2doZnVOODFPUm4r?=
 =?utf-8?B?UjlTbm9XbUcwL0RBbFl5akNoK252NUExWnB4Y2dKSStkZG1PSE9MY0U4MXc0?=
 =?utf-8?B?M1BGWDhTeGY4eCtKM2FYQ2lYN0ZTc1ZvL3gyYXFXYjB6ZHRyMHRQNk82K2Zw?=
 =?utf-8?B?d1BvaUFHSFN4YXA1TWR2aENsN214OGh0OUE5WXk5UkE2TmRoZ041QmN6Qk5r?=
 =?utf-8?B?Z2Rpc3ZmdVRXNGpUcWEyR2J1clNJRW9qS29hZnJZd2FabFZHai8waytpby83?=
 =?utf-8?B?bzdQWW5BUnN3TFJra05qVHFSUWVuSXU4YTROY05qSDUxQlpIaVBDQXg4dy9y?=
 =?utf-8?B?MHRPS1BpQ29ucVBrdkRtRXdzU0ZiRTgwNUtiT1cwZTJOem1kMU96dHNNdVNq?=
 =?utf-8?B?bjRZWXZaTGVrektLa2dVWTA5bjhkWXVZcE54d205SGNBMW5GRXdXcjRoajBX?=
 =?utf-8?B?d1pBU2M0MEJ0Qm5zSC9GVllLa04wN2J6d2w2aXFtK1dBb0tKOEhpVC9KT09z?=
 =?utf-8?B?UW9YempJZUt6OTg3RStEc2VKNSt2OHpSS3pwM0tUTUk4VzFmME9XZ3hmQVRW?=
 =?utf-8?B?dkhsYmkxY1VnbE9lWmhLOGhzeVlYK3dzbHE2VUc2NkxPU1VPY2ZUOEhvejB1?=
 =?utf-8?B?Z2l5cGRiaEwzKzFRN2JwdzdndUI5ZStJZ1E5TW9UZHE2L1U5ZzI5d3ZFMFlo?=
 =?utf-8?B?QjErUWJqbVlVZUVkNjl3aDcwUHRXcnRhano0TVIrc09LS1JXSnBSaWRxWDd1?=
 =?utf-8?B?TDNoU3F1Y2s5b0xrZnpnWEVLTC9TVDlZaGxWQTFERUd2NmlxVW8xaXpOL2Jn?=
 =?utf-8?B?emZUTjVvRFp3QjZySndVb1JXZlVKUmdleTRmMDduTjBXSWNUMXh4K1RUSUd6?=
 =?utf-8?B?MVlUdS85NjRWT0xEODlZN3puR1ZOQ29KR1V0b1hOeWliKzcxNjM5UW9Ka00v?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d813fe-7a85-449c-5b70-08db3404aeb6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 05:31:32.0676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIST4mqTA6zf5CwINEh8RHVKG7Xqqn25IWNn1LS+icEXGOpHuMLLewmgNeoQXrq7iKN1dyweudsPXdQiZwbEkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7268

On 30.03.23 18:13, Florian Bezdeka wrote:
> On Tue, 2023-03-28 at 18:01 +0200, Florian Bezdeka wrote:
>> On 28.03.23 01:01, Jan Kiszka wrote:
>>> On 27.03.23 19:30, Florian Bezdeka wrote:
>>>> Hi all,
>>>>
>>>> I'm currently investigating an issue reported by an internal customer. When
>>>> trying to run Xenomai (next branch) on top of Dovetail (6.1.15) in an virtual
>>>> environment (VirtualBox 7.0.6) a complete system hang / deadlock can be
>>>> observed.
>>>>
>>>> I was not able to reproduce the locking issue myself, but I'm able to "stall"
>>>> the system by putting a lot of load on the system (stress-ng). After 10-20
>>>> minutes there is no progress anymore.
>>>>
>>>> The locking issue reported by the customer:
>>>>
>>>> [    5.063059] [Xenomai] lock (____ptrval____) already unlocked on CPU #3
>>>> [    5.063059]           last owner = kernel/xenomai/pipeline/intr.c:26 (xnintr_core_clock_handler(), CPU #0)
>>>> [    5.063072] CPU: 3 PID: 130 Comm: systemd-udevd Not tainted 6.1.15-xenomai-1 #1
>>>> [    5.063075] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VM 12/01/2006
>>>> [    5.063075] IRQ stage: Xenomai
>>>> [    5.063077] Call Trace:
>>>> [    5.063141]  <TASK>
>>>> [    5.063146]  dump_stack_lvl+0x71/0xa0
>>>> [    5.063153]  xnlock_dbg_release.cold+0x21/0x2c
>>>> [    5.063158]  xnintr_core_clock_handler+0xa4/0x140
>>>> [    5.063166]  lapic_oob_handler+0x41/0xf0
>>>> [    5.063172]  do_oob_irq+0x25a/0x3e0
>>>> [    5.063179]  handle_oob_irq+0x4e/0xd0
>>>> [    5.063182]  generic_pipeline_irq_desc+0xb0/0x160
>>>> [    5.063213]  arch_handle_irq+0x5d/0x1e0
>>>> [    5.063218]  arch_pipeline_entry+0xa1/0x110
>>>> [    5.063222]  asm_sysvec_apic_timer_interrupt+0x16/0x20
>>>> ...
>>>>
>>>> After reading a lot of code I realized that the so called paravirtualized
>>>> spinlocks are being used when running under VB (VirtualBox):
>>>>
>>>> [    0.019574] kvm-guest: PV spinlocks enabled
>>>>
>>>> vs. Qemu:
>>>>
>>>> Qemu (with -enable-kvm):
>>>> [    0.255790] kvm-guest: PV spinlocks disabled, no host support
>>>>
>>>> The good news: With CONFIG_PARAVIRT_SPINLOCKS=n (or "nopvspin" on the kernel
>>>> cmdline) the problem disappears.
>>>>
>>>> The bad news: As Linux alone (and dovetail without Xenomai patch) runs fine,
>>>> even with all the stress applied, I'm quite sure that we have a (maybe
>>>> longstanding) locking bug.
>>>>
>>>> RFC: I'm now testing the patch below, which is already running fine for some
>>>> hours now. Please let me know if all of this makes sense. I might have
>>>> overlooked something.
>>>>
>>>> If I'm not mistaken the following can happen on one CPU:
>>>>
>>>> // Example: taken from tick.c, proxy_set_next_ktime()
>>>> xnlock_get_irqsave(&nklock, flags);
>>>> // root domain stalled, but hard IRQs are still enabled
>>>
>>> OOB + hard IRQs stalled (xnlock_get_irqsave -> splhigh -> oob_irq_save).
>>>
>>>>
>>>> 	// PROXY TICK IRQ FIRES
>>>> 	// taken from intr.c, xnintr_core_clock_handler()
>>>> 	xnlock_get(&nklock);	// we already own the lock
>>>
>>> If this code runs under the assumption that hard-IRQs and OOB is stalled
>>> while they are not, we indeed have a problem. Please check where that
>>> may have gone wrong.
>>
>> My warnings used to check the context actually never triggered so far,
>> but the system is still entering the broken state. Some further findings:
>>
>> - nklock internally uses a arch_spinlock_t for locking
>> - nklock is used by the proxy timer tick IRQ, so very "often"
>> - arch_spinlock_t is very rarely used in Linux, I found only a couple
>>   of usages inside x86 code (dumpstack.c, hpet.c, tsc_sync.c)
>> - arch_spinlock_t might use the PV optimized spinlock operations
>> - Most other spinlocks (especially in dovetail) are based on
>>   raw_spinlock
>> - raw_spinlock does not use PV optimized operations
>>
>> That might be the reason why Linux alone runs fine.
>>
>> I'm now asking myself if the PV spinlock implementation provided by
>> virtualbox has a bug... As virtualbox is to some degree based on KVM
>> that might be a KVM bug as well...
>>
>> Let me try to force the slow path for arch_spinlock_t. Maybe my vCPUs
>> never come back...
> 
> Short update:
> 
> Seems the slowpath matters, especially when there is noticeable load on
> the host itself. The vCPU is "parked" and it's simply taking too long
> until it is back on the CPU. In my case I'm running into an AHCI
> timeout in most cases, rootfs unaccessable, system "dead".
> 
> Still wondering how the "lockdep" error above can actually happen. This
> was on a different host, so maybe a different problem.
> 

It might be that the PV code is not playing according to dovetail rules,
e.g. not always using virtualized irq-enable/disable or not using hard
disabling when actually needed. Tracing the call path, along with the
virtual and physical irq states, may help. Any this may easier be
debugged over KVM with pv-spinlocks enabled.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

