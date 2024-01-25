Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D41FAD
	for <xenomai@lists.linux.dev>; Thu, 25 Jan 2024 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706152719; cv=none; b=bSfsbRm5Ho7jyuQ9VI36PPJ2KnwTmCxbL4tCNAWSE+MLln3OowuDsxPgCVEtBhaEpF0eehSvIkac3wxxZgdkrk2N9KSwHPlAIeDkx0SkRCGdAfBw3n8Epj1iwtLMRWflsVk//q0ry2tUpd//cKehVyXGGNrdcnZFO7QaqjlT3qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706152719; c=relaxed/simple;
	bh=5FYs+sAKqcX50EtK0/D2mqcvYaNP4QyZIg9ZEpbI2kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kb0VUhNKJljdfin7Pw6r7o7/6INj1kwxfzna3Exd1UXup3tLkJ/db5V+4kBYkvY2p7Xi19yUyiER55WhRSqpcNAHPRgISa+eH68/izPrkxir0h0A8xJKZr4HFb2OFo28ttRG2Adw90EbVZbCfG+wCYZwb2K5Uu6XKPCj7TzOzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BYrtiXIr; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BYrtiXIr"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 09CD2240002;
	Thu, 25 Jan 2024 03:18:29 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
	by spool.mail.gandi.net (Postfix) with ESMTP id 45DBC94105B;
	Thu, 25 Jan 2024 03:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Ro1pZYQ980irE6Ga5oy4o4T9vWkFDKeQsxS5iM1LQQ8=;
	b=BYrtiXIrZFSuxuKI3sCv4a9a6MkrgJV/u5X7QcfIRbc7vKgCtFXSOFMAtJpG94
	h94ywoWHvBn3ah4ENKcpkM+vmj8QGvulJyMmoR5/o9WSUcwXKnHu1DSTB0/hFFS4
	r62Svt97/7LVRVhc1/4uXLMGidCInVf48BY3PyirQGDtc=
Received: from [10.10.80.177] (unknown [219.142.137.151])
	by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wD33wL80rFlsqjUAw--.33288S2;
	Thu, 25 Jan 2024 11:18:20 +0800 (CST)
Message-ID: <79e83ee2-7406-43c1-9a71-e79cb2cbd127@163.com>
Date: Thu, 25 Jan 2024 11:18:20 +0800
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
 "xenomai@xenomai.org" <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>
References: <867aed54-563a-4c06-b750-4a7727e6e4c0@163.com>
 <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
 <77c3e1fd-dab9-4b7c-b4f7-67c38dfc37bc@siemens.com>
From: linz <powertree@163.com>
In-Reply-To: <77c3e1fd-dab9-4b7c-b4f7-67c38dfc37bc@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33wL80rFlsqjUAw--.33288S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3uF47KF4xurW7AF15KFyfJFb_yoW8Gw1kCo
	WfXr17ta1kCrn8J3sxAanrGa45W39rZF43Zr1S9rW5AFn7JryUJryrGr1kXw48tFZrGFy5
	Aw1UJw4kCa4ag3Z7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RCJP_DUUUU
X-CM-SenderInfo: psrzv2pwuhvqqrwthudrp/1tbiqB5wlWVOB7l9NQAAsO
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=163.com header.s=s110527 header.b=BYrtiXIr;
	dmarc=pass (policy=none) header.from=163.com;
	spf=pass (spool.mail.gandi.net: domain of powertree@163.com designates 220.181.12.196 as permitted sender) smtp.mailfrom=powertree@163.com

I think my patch is not suitable after listening to your suggestions.
And I don't have any other good solutions.

I think x86 is ok because there is no operation of writing global 
variables in the critical zone.

kernel_fpu_begin
     =>kernel_fpu_begin_mask
=>preempt_disable // enter the critical zone
         =>WARN_ON_FPU(!irq_fpu_usable());
         =>WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
         =>flags = hard_cond_local_irq_save(); // leave the critcal zone


But in arm64, there is operation of writing global variables in the 
critical zone, unfortunernaly.
efi_call_rts
   =>__efi_fpsimd_begin
     =>kernel_neon_begin
       =>get_cpu_fpsimd_context
=>hard_preempt_disable // disable interrupt, enter the critical zone
=>__get_cpu_fpsimd_context //  first call, modify global variable 
fpsimd_context_busy
=>hard_cond_local_irq_restore // enable interrupt, leave the critcal zone

handle_arch_irq_pipelined // Latency timer interrupt triggered
=>handle_irq_pipelined_finish
   =>irq_exit_pipeline
     =>xnsched_run
       =>__xnsched_run
         =>pipeline_schedule
           =>run_oob_call
             =>___xnsched_run
               =>pipeline_switch_to
                 =>dovetail_context_switch
                   =>__switch_to
                     =>fpsimd_thread_switch
                       =>__get_cpu_fpsimd_context // second call

So, I think there are more todos on arm64. Do you have any other good 
suggestions?


When the call trace is trigger on arm64, the ftrace is as follows:

    kworker/u16:1-503     [003] ...1  3037.586789: kernel_neon_begin 
<-__efi_fpsimd_begin
    kworker/u16:1-503     [003] ...1  3037.586789: hard_preempt_disable 
<-kernel_neon_begin // enter the critical zone
    kworker/u16:1-503     [003] D..1  3037.586790: preempt_count_add 
<-hard_preempt_disable
    kworker/u16:1-503     [003] D..2  3037.586790: 
__get_cpu_fpsimd_context 
<-kernel_neon_begin                                     // first call 
__get_cpu_fpsimd_context
    kworker/u16:1-503     [003] D..2  3037.586790: __fpsimd_save 
<-kernel_neon_begin
    kworker/u16:1-503     [003] D..2  3037.586791: 
fpsimd_flush_cpu_state <-kernel_neon_begin
// when hard_cond_local_irq_restore finishes, leave the critcal zone
// ftrace can't get hard_cond_local_irq_restore because it's macro
// in function kernel_neon_begin, hard_cond_local_irq_restore enable the 
interrupt
    kworker/u16:1-503     [003] D..2  3037.587260: handle_irq_pipelined 
<-handle_arch_irq_pipelined                                 // the 
latency timer interrupt is trigger, so the interrupt is disabled again
    kworker/u16:1-503     [003] D..2  3037.587261: 
handle_irq_pipelined_prepare <-handle_irq_pipelined
    kworker/u16:1-503     [003] D..2  3037.587261: preempt_count_add 
<-handle_irq_pipelined_prepare
    kworker/u16:1-503     [003] D.~2  3037.587261: preempt_count_add 
<-handle_irq_pipelined_prepare
    kworker/u16:1-503     [003] D.~2  3037.587262: gic_handle_irq 
<-handle_irq_pipelined
    kworker/u16:1-503     [003] D.~2  3037.587262: irq_find_mapping 
<-gic_handle_irq
    kworker/u16:1-503     [003] D.~2  3037.587262: rcu_oob_prepare_lock 
<-irq_find_mapping
    kworker/u16:1-503     [003] D.~2  3037.587263: __rcu_read_lock 
<-irq_find_mapping
    kworker/u16:1-503     [003] D.~2  3037.587263: __rcu_read_unlock 
<-irq_find_mapping
    kworker/u16:1-503     [003] D.~2  3037.587263: rcu_oob_finish_lock 
<-irq_find_mapping
    kworker/u16:1-503     [003] D.~2  3037.587264: generic_pipeline_irq 
<-gic_handle_irq
    kworker/u16:1-503     [003] D.~2  3037.587264: 
generic_pipeline_irq_desc <-generic_pipeline_irq
    kworker/u16:1-503     [003] D.~2  3037.587265: 
handle_percpu_devid_irq <-generic_pipeline_irq_desc
    kworker/u16:1-503     [003] D.~2  3037.587265: handle_oob_irq 
<-handle_percpu_devid_irq
    kworker/u16:1-503     [003] D.~2  3037.587265: handle_oob_irq.part.0 
<-handle_oob_irq
    kworker/u16:1-503     [003] D.~2  3037.587265: do_oob_irq 
<-handle_oob_irq.part.0
    kworker/u16:1-503     [003] D.~2  3037.587266: 
arch_timer_handler_phys <-do_oob_irq
    kworker/u16:1-503     [003] D.~2  3037.587266: 
xnintr_core_clock_handler <-arch_timer_handler_phys
    kworker/u16:1-503     [003] D.~2  3037.587267: ___xnlock_get 
<-xnintr_core_clock_handler
    kworker/u16:1-503     [003] D.~2  3037.587267: xnclock_tick 
<-xnintr_core_clock_handler
    kworker/u16:1-503     [003] D.~2  3037.587267: 
ktime_get_mono_fast_ns <-xnclock_tick
    kworker/u16:1-503     [003] D.~2  3037.587268: arch_counter_read 
<-ktime_get_mono_fast_ns
    kworker/u16:1-503     [003] D.~2  3037.587268: timerfd_handler 
<-xnclock_tick
    kworker/u16:1-503     [003] D.~2  3037.587268: 
xnsynch_wakeup_one_sleeper <-timerfd_handler
    kworker/u16:1-503     [003] D.~2  3037.587269: ___xnlock_get 
<-xnsynch_wakeup_one_sleeper
    kworker/u16:1-503     [003] D.~2  3037.587269: xnthread_resume 
<-xnsynch_wakeup_one_sleeper
    kworker/u16:1-503     [003] D.~2  3037.587269: ___xnlock_get 
<-xnthread_resume
    kworker/u16:1-503     [003] D.~2  3037.587270: 
ktime_get_mono_fast_ns <-xnclock_tick
    kworker/u16:1-503     [003] D.~2  3037.587270: arch_counter_read 
<-ktime_get_mono_fast_ns
    kworker/u16:1-503     [003] D.~2  3037.587271: 
xnclock_core_local_shot <-xnclock_tick
    kworker/u16:1-503     [003] D.~2  3037.587271: 
ktime_get_mono_fast_ns <-xnclock_core_local_shot
    kworker/u16:1-503     [003] D.~2  3037.587271: arch_counter_read 
<-ktime_get_mono_fast_ns
    kworker/u16:1-503     [003] D.~2  3037.587272: 
pipeline_set_timer_shot <-xnclock_core_local_shot
    kworker/u16:1-503     [003] D.~2  3037.587272: 
arch_timer_set_next_event_phys <-pipeline_set_timer_shot
    kworker/u16:1-503     [003] D.~2  3037.587272: ___xnlock_put 
<-xnintr_core_clock_handler
    kworker/u16:1-503     [003] D.~2  3037.587273: gic_eoimode1_eoi_irq 
<-handle_percpu_devid_irq
    kworker/u16:1-503     [003] D.~2  3037.587273: 
handle_irq_pipelined_finish <-handle_irq_pipelined
    kworker/u16:1-503     [003] D.~2  3037.587273: preempt_count_sub 
<-handle_irq_pipelined_finish
    kworker/u16:1-503     [003] D.~2  3037.587274: ___xnsched_run 
<-run_oob_call
    kworker/u16:1-503     [003] D.~2  3037.587275: ___xnlock_get 
<-___xnsched_run
    kworker/u16:1-503     [003] D.~2  3037.587275: xnsched_pick_next 
<-___xnsched_run
    kworker/u16:1-503     [003] D.~2  3037.587276: 
ktime_get_mono_fast_ns <-___xnsched_run
    kworker/u16:1-503     [003] D.~2  3037.587276: arch_counter_read 
<-ktime_get_mono_fast_ns
    kworker/u16:1-503     [003] D.~2  3037.587276: pipeline_switch_to 
<-___xnsched_run
    kworker/u16:1-503     [003] D.~2  3037.587277: 
dovetail_context_switch <-pipeline_switch_to
    kworker/u16:1-503     [003] D.~2  3037.587277: 
check_and_switch_context <-dovetail_context_switch
    kworker/u16:1-503     [003] D.~2  3037.587277: cpu_do_switch_mm 
<-check_and_switch_context
    kworker/u16:1-503     [003] D.~2  3037.587278: 
post_ttbr_update_workaround <-cpu_do_switch_mm
    kworker/u16:1-503     [003] D.~2  3037.587278: fpsimd_thread_switch 
<-__switch_to
    kworker/u16:1-503     [003] D.~2  3037.587279: 
__get_cpu_fpsimd_context 
<-fpsimd_thread_switch                               // second call 
__get_cpu_fpsimd_context, similar with AA deadlock

在 2024/1/10 12:43, Jan Kiszka 写道:
> On 09.01.24 10:33, Jan Kiszka wrote:
>> On 09.01.24 10:16, linz wrote:
>>> Hi, I find a call tracing when I use xenomai v3.2.2 branch and test
>>> latency testsuit, the Call trace is as follows
>>>
>>> [  777.563100] Unable to handle kernel NULL pointer dereference at
>>> virtual address 00000000000002c0
>>> [  777.563101] Mem abort info:
>>> [  777.563102]   ESR = 0x96000004
>>> [  777.563103]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [  777.563104]   SET = 0, FnV = 0
>>> [  777.563104]   EA = 0, S1PTW = 0
>>> [  777.563105] Data abort info:
>>> [  777.563105]   ISV = 0, ISS = 0x00000004
>>> [  777.563106]   CM = 0, WnR = 0
>>> [  777.563107] user pgtable: 4k pages, 48-bit VAs, pgdp=000000200c513000
>>> [  777.563108] [00000000000002c0] pgd=0000000000000000,
>>> p4d=0000000000000000
>>> [  777.563110] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>>> [  777.563118] CPU: 3 PID: 149 Comm: kworker/u16:2 Not tainted
>>> 5.10.153-dovetail3 #2
>> Could you check if the issue persists with latest v6.6-dovetail1-rebase?
>> Just to avoid that we are missing some fix backports in 5.10.
>>
>>> [  777.563119] IRQ stage: Xenomai
>>> [  777.563120] Workqueue: efi_rts_wq efi_call_rts
>>> [  777.563121] pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO BTYPE=--)
>>> [  777.563121] pc : xnthread_relax+0x78/0x1d4
>>> [  777.563122] lr : xnthread_relax+0x78/0x1d4
>>> [  777.563122] sp : ffff80001001bbf0
>>> [  777.563123] x29: ffff80001001bbf0 x28: ffff001f809daa00
>>> [  777.563124] x27: ffff001f803426c8 x26: ffff80001001c000
>>> [  777.563126] x25: ffff800010018000 x24: ffff0020f6f93008
>>> [  777.563127] x23: 0000000080000085 x22: 0000000000000003
>>> [  777.563129] x21: ffff001f809daa00 x20: 0000000000000001
>>> [  777.563130] x19: 0000000000000000 x18: 0000000000000000
>>> [  777.563132] x17: 0000015a8ca44dbc x16: 0000000000000013
>>> [  777.563133] x15: ffff800010f892a8 x14: 0000000000000002
>>> [  777.563135] x13: 0000000000000043 x12: 0000000000000040
>>> [  777.563136] x11: ffff001f804dab58 x10: ffff001f804dab5a
>>> [  777.563137] x9 : 00000000000003c0 x8 : 0000000000000000
>>> [  777.563139] x7 : 0000000000000000 x6 : 0000000000000001
>>> [  777.563140] x5 : ffff0020f6f8ece0 x4 : 0000000000000000
>>> [  777.563142] x3 : ffff0020f6f8eae0 x2 : ffff8020e5a57000
>>> [  777.563143] x1 : 0000000000000003 x0 : 0000000000000002
>>> [  777.563144] Call trace:
>>> [  777.563145]  xnthread_relax+0x78/0x1d4
>>> [  777.563146]  handle_oob_trap_entry+0x78/0x1b0
>>> [  777.563146]  __oob_trap_notify+0x40/0x70
>>> [  777.563147]  do_debug_exception+0x170/0x1c4
>>> [  777.563147]  el1_dbg+0x34/0x50
>>> [  777.563148]  el1_sync_handler+0x9c/0xd0
>>> [  777.563148]  el1_sync+0x88/0x140
>>> [  777.563149]  __get_cpu_fpsimd_context+0x2c/0x40
>>> [  777.563150]  __switch_to+0x20/0x120
>>> [  777.563150]  dovetail_context_switch+0x6c/0x130
>>> [  777.563151]  pipeline_switch_to+0x10/0x20
>>> [  777.563151]  ___xnsched_run+0x174/0x25c
>>> [  777.563152]  run_oob_call+0x88/0x174
>>> [  777.563153]  handle_irq_pipelined_finish+0x1d8/0x1ec
>>> [  777.563153]  handle_irq_pipelined+0x38/0x50
>>> [  777.563154]  handle_arch_irq_pipelined+0x10/0x20
>>> [  777.563155]  el1_irq+0xdc/0x1c0
>>> [  777.563155]  0x203626c4
>>> [  777.563156]  0x20361190
>>> [  777.563156]  0x203615b4
>>> [  777.563156]  0x20361660
>>> [  777.563157]  0x20361da0
>>> [  777.563157]  0x203609ec
>>> [  777.563158]  __efi_rt_asm_wrapper+0x28/0x4c
>>> [  777.563159]  efi_call_rts+0x204/0x3d0
>>> [  777.563159]  process_one_work+0x1cc/0x350
>>> [  777.563160]  worker_thread+0x138/0x46c
>>> [  777.563160]  kthread+0x154/0x160
>>> [  777.563161]  ret_from_fork+0x10/0x3c
>>> [  777.563162] Code: 97ff4dae f000a180 91236000 97ffdde7 (f9416260)
>>> [  777.563162] ---[ end trace 5ef18d81e2ade362 ]---
>>> [  777.563163] note: kworker/u16:2[149] exited with preempt_count 33554434
>>>
>>>
>>> The reason is when kernel_neon_begin is called, it calls
>>> __get_cpu_fpsimd_context. Then xenomai oob interrupt triggers function
>>> named __switch_to, which calls  __get_cpu_fpsimd_context again.
>>> Calling this function twice in a row will trigger a call trace.
>>> The function call relationship is as follows:
>>>
>>> efi_call_rts
>>>    =>__efi_fpsimd_begin
> BTW, calling into the firmware on core that is also supposed to do hard
> RT is a no-go. PREEMPT-RT turns off EFI runtime services for that
> reason. That's another topic, not the core of this issue here, though.
>
>>>      =>kernel_neon_begin
>>>        =>get_cpu_fpsimd_context
>>>          =>hard_preempt_disable  // disable interrupt
>>>          =>__get_cpu_fpsimd_context    // *first call*
>>>        =>hard_cond_local_irq_restore  // enable interrupt
>>>
>>>        handle_arch_irq_pipelined // Latency timer interrupt triggered
>>>          =>handle_irq_pipelined_finish
>>>            =>irq_exit_pipeline
>>>              =>xnsched_run
>>>                =>__xnsched_run
>>>                  =>pipeline_schedule
>>>                    =>run_oob_call
>>>                      =>___xnsched_run
>>>                        =>pipeline_switch_to
>>>                          =>dovetail_context_switch
>>>                            =>__switch_to
>>>                              =>fpsimd_thread_switch
>>>                                =>__get_cpu_fpsimd_context //*second call*
>>>
>>>
>>> The fixed up patch is as follows:
>>>
>>>  From f0cb2b2f3174789eb8348feff6abdc7dbdafc8c4 Mon Sep 17 00:00:00 2001
>>> From: zhanglin <powertree@163.com>
>>> Date: Tue, 9 Jan 2024 17:08:20 +0800
>>> Subject: [PATCH] arm64/fpsimd: fix bug for calling __get_cpu_fpsimd_context
>>>   twice in a row when kernel_neon_begin running
>>>
>>> ---
>>>   arch/arm64/kernel/fpsimd.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>>> index 01a4774a2..bc180d0cf 100644
>>> --- a/arch/arm64/kernel/fpsimd.c
>>> +++ b/arch/arm64/kernel/fpsimd.c
>>> @@ -44,6 +44,10 @@
>>>   #include <asm/traps.h>
>>>   #include <asm/virt.h>
>>>
>>> +#ifdef CONFIG_KERNEL_MODE_NEON
>>> +#include <cobalt/kernel/sched.h>
>>> +#endif
>>> +
>>>   #define FPEXC_IOF    (1 << 0)
>>>   #define FPEXC_DZF    (1 << 1)
>>>   #define FPEXC_OFF    (1 << 2)
>>> @@ -1367,6 +1371,7 @@ void kernel_neon_begin(void)
>>>
>>>       BUG_ON(!may_use_simd());
>>>
>>> +    xnsched_lock();
>> This would be a laying violation: dovetail has no knowledge of Xenomai,
>> and it also serves EVL with a different API. But we will find a fitting
>> locking construct here quickly once we understood the issue completely
>> (or I - need to spend some calm cycles later).
>>
> In addition, your changes make the sections kernel_neon_begin..end
> non-interruptible. I'm not sure that this is something desirable. It's
> also not what we do on x86 eg. for kernel_fpu_begin..end.
>
> Philippe, is the kernel neon section already interruptible by OOB
> scheduling and just the warning about the busy flag misleading here, or
> do we still have more todos?
>
> Jan
>
>>>       get_cpu_fpsimd_context(flags);
>>>
>>>       /* Save unsaved fpsimd state, if any: */
>>> @@ -1397,6 +1402,7 @@ void kernel_neon_end(void)
>>>           return;
>>>
>>>       put_cpu_fpsimd_context(flags);
>>> +    xnsched_unlock();
>>>   }
>>>   EXPORT_SYMBOL(kernel_neon_end);
>>>
>> Jan
>>

