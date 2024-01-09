Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F51273FA
	for <xenomai@lists.linux.dev>; Tue,  9 Jan 2024 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ty6zB24G"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 05BA2240006
	for <xenomai@lists.linux.dev>; Tue,  9 Jan 2024 10:39:57 +0000 (UTC)
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by spool.mail.gandi.net (Postfix) with ESMTP id 15D7C9415DB
	for <xenomai@xenomai.org>; Tue,  9 Jan 2024 10:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=RKCGFPwsqaJBm1v5DnBXvatXGq7kzymt40l+D+7HoCk=;
	b=Ty6zB24G+YvV8520C6HONJcEmsqQoj5SmdEB84YIB+KoYUl7iK5OlR+Pc0JwTp
	c83EoyW9aUbF849KlaZBnMumxaxNTMu1e3Bz1rbnCMbR6X33nyxBIW8KKDSKtJ8j
	QDx+hXKRebPRRnUhpi+QjMG0aRzoN78YLSWbqxJWkWN+g=
Received: from [10.10.80.200] (unknown [219.142.137.151])
	by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wDn7x9zIp1lL76iAw--.45784S2;
	Tue, 09 Jan 2024 18:39:47 +0800 (CST)
Message-ID: <b9325306-e748-4837-95d0-380c893dc9a3@163.com>
Date: Tue, 9 Jan 2024 18:39:47 +0800
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: calling __get_cpu_fpsimd_context twice in a row when
 kernel_neon_begin running
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <867aed54-563a-4c06-b750-4a7727e6e4c0@163.com>
 <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
From: linz <powertree@163.com>
In-Reply-To: <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7x9zIp1lL76iAw--.45784S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JrykAr4xtF4rKF18JF1xuFg_yoWxAr1Dpr
	W5CFyjkw48JryYqay7Gr1jvF1FqwnxCFy7JFWktryxAF15Xr1UZF18A3y3KFZ7Ww18ury7
	tryUX3WxtryDtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRsL0nUUUUU=
X-CM-SenderInfo: psrzv2pwuhvqqrwthudrp/xtbBEBNglWVOBhfr+wABsd
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=163.com header.s=s110527 header.b=Ty6zB24G;
	dmarc=pass (policy=none) header.from=163.com;
	spf=pass (spool.mail.gandi.net: domain of powertree@163.com designates 45.254.50.220 as permitted sender) smtp.mailfrom=powertree@163.com

Thank you very much for your suggestion. Currently, our hardware 
products do not support linux kernel 6.6. If upgrading, we will test it out.

在 2024/1/9 17:33, Jan Kiszka 写道:
> On 09.01.24 10:16, linz wrote:
>> Hi, I find a call tracing when I use xenomai v3.2.2 branch and test
>> latency testsuit, the Call trace is as follows
>>
>> [  777.563100] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000000000002c0
>> [  777.563101] Mem abort info:
>> [  777.563102]   ESR = 0x96000004
>> [  777.563103]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [  777.563104]   SET = 0, FnV = 0
>> [  777.563104]   EA = 0, S1PTW = 0
>> [  777.563105] Data abort info:
>> [  777.563105]   ISV = 0, ISS = 0x00000004
>> [  777.563106]   CM = 0, WnR = 0
>> [  777.563107] user pgtable: 4k pages, 48-bit VAs, pgdp=000000200c513000
>> [  777.563108] [00000000000002c0] pgd=0000000000000000,
>> p4d=0000000000000000
>> [  777.563110] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> [  777.563118] CPU: 3 PID: 149 Comm: kworker/u16:2 Not tainted
>> 5.10.153-dovetail3 #2
> Could you check if the issue persists with latest v6.6-dovetail1-rebase?
> Just to avoid that we are missing some fix backports in 5.10.
>
>> [  777.563119] IRQ stage: Xenomai
>> [  777.563120] Workqueue: efi_rts_wq efi_call_rts
>> [  777.563121] pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO BTYPE=--)
>> [  777.563121] pc : xnthread_relax+0x78/0x1d4
>> [  777.563122] lr : xnthread_relax+0x78/0x1d4
>> [  777.563122] sp : ffff80001001bbf0
>> [  777.563123] x29: ffff80001001bbf0 x28: ffff001f809daa00
>> [  777.563124] x27: ffff001f803426c8 x26: ffff80001001c000
>> [  777.563126] x25: ffff800010018000 x24: ffff0020f6f93008
>> [  777.563127] x23: 0000000080000085 x22: 0000000000000003
>> [  777.563129] x21: ffff001f809daa00 x20: 0000000000000001
>> [  777.563130] x19: 0000000000000000 x18: 0000000000000000
>> [  777.563132] x17: 0000015a8ca44dbc x16: 0000000000000013
>> [  777.563133] x15: ffff800010f892a8 x14: 0000000000000002
>> [  777.563135] x13: 0000000000000043 x12: 0000000000000040
>> [  777.563136] x11: ffff001f804dab58 x10: ffff001f804dab5a
>> [  777.563137] x9 : 00000000000003c0 x8 : 0000000000000000
>> [  777.563139] x7 : 0000000000000000 x6 : 0000000000000001
>> [  777.563140] x5 : ffff0020f6f8ece0 x4 : 0000000000000000
>> [  777.563142] x3 : ffff0020f6f8eae0 x2 : ffff8020e5a57000
>> [  777.563143] x1 : 0000000000000003 x0 : 0000000000000002
>> [  777.563144] Call trace:
>> [  777.563145]  xnthread_relax+0x78/0x1d4
>> [  777.563146]  handle_oob_trap_entry+0x78/0x1b0
>> [  777.563146]  __oob_trap_notify+0x40/0x70
>> [  777.563147]  do_debug_exception+0x170/0x1c4
>> [  777.563147]  el1_dbg+0x34/0x50
>> [  777.563148]  el1_sync_handler+0x9c/0xd0
>> [  777.563148]  el1_sync+0x88/0x140
>> [  777.563149]  __get_cpu_fpsimd_context+0x2c/0x40
>> [  777.563150]  __switch_to+0x20/0x120
>> [  777.563150]  dovetail_context_switch+0x6c/0x130
>> [  777.563151]  pipeline_switch_to+0x10/0x20
>> [  777.563151]  ___xnsched_run+0x174/0x25c
>> [  777.563152]  run_oob_call+0x88/0x174
>> [  777.563153]  handle_irq_pipelined_finish+0x1d8/0x1ec
>> [  777.563153]  handle_irq_pipelined+0x38/0x50
>> [  777.563154]  handle_arch_irq_pipelined+0x10/0x20
>> [  777.563155]  el1_irq+0xdc/0x1c0
>> [  777.563155]  0x203626c4
>> [  777.563156]  0x20361190
>> [  777.563156]  0x203615b4
>> [  777.563156]  0x20361660
>> [  777.563157]  0x20361da0
>> [  777.563157]  0x203609ec
>> [  777.563158]  __efi_rt_asm_wrapper+0x28/0x4c
>> [  777.563159]  efi_call_rts+0x204/0x3d0
>> [  777.563159]  process_one_work+0x1cc/0x350
>> [  777.563160]  worker_thread+0x138/0x46c
>> [  777.563160]  kthread+0x154/0x160
>> [  777.563161]  ret_from_fork+0x10/0x3c
>> [  777.563162] Code: 97ff4dae f000a180 91236000 97ffdde7 (f9416260)
>> [  777.563162] ---[ end trace 5ef18d81e2ade362 ]---
>> [  777.563163] note: kworker/u16:2[149] exited with preempt_count 33554434
>>
>>
>> The reason is when kernel_neon_begin is called, it calls
>> __get_cpu_fpsimd_context. Then xenomai oob interrupt triggers function
>> named __switch_to, which calls  __get_cpu_fpsimd_context again.
>> Calling this function twice in a row will trigger a call trace.
>> The function call relationship is as follows:
>>
>> efi_call_rts
>>    =>__efi_fpsimd_begin
>>      =>kernel_neon_begin
>>        =>get_cpu_fpsimd_context
>>          =>hard_preempt_disable  // disable interrupt
>>          =>__get_cpu_fpsimd_context    // *first call*
>>        =>hard_cond_local_irq_restore  // enable interrupt
>>
>>        handle_arch_irq_pipelined // Latency timer interrupt triggered
>>          =>handle_irq_pipelined_finish
>>            =>irq_exit_pipeline
>>              =>xnsched_run
>>                =>__xnsched_run
>>                  =>pipeline_schedule
>>                    =>run_oob_call
>>                      =>___xnsched_run
>>                        =>pipeline_switch_to
>>                          =>dovetail_context_switch
>>                            =>__switch_to
>>                              =>fpsimd_thread_switch
>>                                =>__get_cpu_fpsimd_context //*second call*
>>
>>
>> The fixed up patch is as follows:
>>
>>  From f0cb2b2f3174789eb8348feff6abdc7dbdafc8c4 Mon Sep 17 00:00:00 2001
>> From: zhanglin <powertree@163.com>
>> Date: Tue, 9 Jan 2024 17:08:20 +0800
>> Subject: [PATCH] arm64/fpsimd: fix bug for calling __get_cpu_fpsimd_context
>>   twice in a row when kernel_neon_begin running
>>
>> ---
>>   arch/arm64/kernel/fpsimd.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 01a4774a2..bc180d0cf 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -44,6 +44,10 @@
>>   #include <asm/traps.h>
>>   #include <asm/virt.h>
>>
>> +#ifdef CONFIG_KERNEL_MODE_NEON
>> +#include <cobalt/kernel/sched.h>
>> +#endif
>> +
>>   #define FPEXC_IOF    (1 << 0)
>>   #define FPEXC_DZF    (1 << 1)
>>   #define FPEXC_OFF    (1 << 2)
>> @@ -1367,6 +1371,7 @@ void kernel_neon_begin(void)
>>
>>       BUG_ON(!may_use_simd());
>>
>> +    xnsched_lock();
> This would be a laying violation: dovetail has no knowledge of Xenomai,
> and it also serves EVL with a different API. But we will find a fitting
> locking construct here quickly once we understood the issue completely
> (or I - need to spend some calm cycles later).
>
>>       get_cpu_fpsimd_context(flags);
>>
>>       /* Save unsaved fpsimd state, if any: */
>> @@ -1397,6 +1402,7 @@ void kernel_neon_end(void)
>>           return;
>>
>>       put_cpu_fpsimd_context(flags);
>> +    xnsched_unlock();
>>   }
>>   EXPORT_SYMBOL(kernel_neon_end);
>>
> Jan
>

