Received: from mslow2.mail.gandi.net (mslow2.mail.gandi.net [217.70.178.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB821C17
	for <xenomai@lists.linux.dev>; Fri, 26 Jan 2024 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236641; cv=none; b=MvcHetigRvXF9aLGz/g+3ZUxl5h6ETPlUYRqVkk+jhRu7n7HDTSq/0ztwizipC3ovmFubFaASRkXV+5CN/Rtx29mOjTquWepoDNvXT0c7In52nEcXU1nGWDi4nEM01TDhLZW6xMfKPDUgQivpxlaamYCSEwdJDTqYPVNmNmG2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236641; c=relaxed/simple;
	bh=vAWVC3a63KzfOfyUd/dIO2RTbH7pt/HKQsijBqUpt3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8b7iYBUfDstZCgNYGN5PbjdgDycOEwdwRQloKAAsDaZCtC9XZVoFsYd2fTBnlOT9tQxCYsb4gtG1JR5xBauljqTRC8cWUJmP4BYo9NdZib/UvOYztr8LWfee+gN4AKuGi8o/r+xpFFRLMMZBHhMl0QD9/RkNND8o9B5c6oL/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FAoE1s2T; arc=none smtp.client-ip=217.70.178.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FAoE1s2T"
Received: from redirect.mail.gandi.net (unknown [217.70.178.231])
	by mslow2.mail.gandi.net (Postfix) with ESMTP id 1D6F53A20CD
	for <xenomai@lists.linux.dev>; Fri, 26 Jan 2024 02:15:54 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id E0DE7100004;
	Fri, 26 Jan 2024 02:15:45 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
	by spool.mail.gandi.net (Postfix) with ESMTP id 2B438D80471;
	Fri, 26 Jan 2024 02:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=ZQ8t6w2CRqvc3LgUzg+BqLV5WSJmTamrS1RWuBwUdTI=;
	b=FAoE1s2TDQDRS7JodZJyACgXAWZe676jYBnijqSYmkQVL2r1Q2a1I/1Bg/ZcaY
	ZYdS3j6Fp7y54wzxo+98CUvIHX37Aq4yxZdsBDE6ZQRhA6l5dn6VrgJQEXeN/Fxb
	IOxjWFi8TppoAuu3VYcCkBhokcki0oLT+9wBKOzeuMdPI=
Received: from [10.10.80.177] (unknown [219.142.137.151])
	by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wDXn13GFbNlkVw9AQ--.19223S2;
	Fri, 26 Jan 2024 10:15:34 +0800 (CST)
Message-ID: <1a562046-dc19-4763-98c5-8446b5ef2e8f@163.com>
Date: Fri, 26 Jan 2024 10:15:34 +0800
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: calling __get_cpu_fpsimd_context twice in a row when
 kernel_neon_begin running
To: Jan Kiszka <jan.kiszka@web.de>, Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <867aed54-563a-4c06-b750-4a7727e6e4c0@163.com>
 <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
 <77c3e1fd-dab9-4b7c-b4f7-67c38dfc37bc@siemens.com>
 <79e83ee2-7406-43c1-9a71-e79cb2cbd127@163.com>
 <d799980b-fbfc-467b-87b7-5a4fbc6ddf50@web.de>
Content-Language: en-US
From: linz <powertree@163.com>
In-Reply-To: <d799980b-fbfc-467b-87b7-5a4fbc6ddf50@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXn13GFbNlkVw9AQ--.19223S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF4kXF1DuF1ktF17uw4fAFb_yoW7Wr4Upr
	W5Cryjkr48JryUZay7Jw4jq3WYqr17CFy7Jr4ktr17A3W5XF1UJF10y3y5GF97Ww18WFy7
	J34Uta4xtryDtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRsL0nUUUUU=
X-CM-SenderInfo: psrzv2pwuhvqqrwthudrp/1tbiqAdxlWVOB8xWygABs2
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=163.com header.s=s110527 header.b=FAoE1s2T;
	spf=pass (spool.mail.gandi.net: domain of powertree@163.com designates 220.181.12.199 as permitted sender) smtp.mailfrom=powertree@163.com;
	dmarc=pass (policy=none) header.from=163.com

This issue could result in a data access exception. And finally, the 
running core would get stuck.

[  777.563100] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000000002c0
[  777.563101] Mem abort info:
[  777.563102]   ESR = 0x96000004
[  777.563103]   EC = 0x25: DABT (current EL), IL = 32 bits
[  777.563104]   SET = 0, FnV = 0
[  777.563104]   EA = 0, S1PTW = 0
[  777.563105] Data abort info:
[  777.563105]   ISV = 0, ISS = 0x00000004
[  777.563106]   CM = 0, WnR = 0
[  777.563107] user pgtable: 4k pages, 48-bit VAs, pgdp=000000200c513000
[  777.563108] [00000000000002c0] pgd=0000000000000000, p4d=0000000000000000
[  777.563110] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  777.563118] CPU: 3 PID: 149 Comm: kworker/u16:2 Not tainted 
5.10.153-dovetail3 #2
[  777.563119] IRQ stage: Xenomai
[  777.563120] Workqueue: efi_rts_wq efi_call_rts
[  777.563121] pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO BTYPE=--)
[  777.563121] pc : xnthread_relax+0x78/0x1d4
[  777.563122] lr : xnthread_relax+0x78/0x1d4
[  777.563122] sp : ffff80001001bbf0
[  777.563123] x29: ffff80001001bbf0 x28: ffff001f809daa00
[  777.563124] x27: ffff001f803426c8 x26: ffff80001001c000
[  777.563126] x25: ffff800010018000 x24: ffff0020f6f93008
[  777.563127] x23: 0000000080000085 x22: 0000000000000003
[  777.563129] x21: ffff001f809daa00 x20: 0000000000000001
[  777.563130] x19: 0000000000000000 x18: 0000000000000000
[  777.563132] x17: 0000015a8ca44dbc x16: 0000000000000013
[  777.563133] x15: ffff800010f892a8 x14: 0000000000000002
[  777.563135] x13: 0000000000000043 x12: 0000000000000040
[  777.563136] x11: ffff001f804dab58 x10: ffff001f804dab5a
[  777.563137] x9 : 00000000000003c0 x8 : 0000000000000000
[  777.563139] x7 : 0000000000000000 x6 : 0000000000000001
[  777.563140] x5 : ffff0020f6f8ece0 x4 : 0000000000000000
[  777.563142] x3 : ffff0020f6f8eae0 x2 : ffff8020e5a57000
[  777.563143] x1 : 0000000000000003 x0 : 0000000000000002
[  777.563144] Call trace:
[  777.563145]  xnthread_relax+0x78/0x1d4
[  777.563146]  handle_oob_trap_entry+0x78/0x1b0
[  777.563146]  __oob_trap_notify+0x40/0x70
[  777.563147]  do_debug_exception+0x170/0x1c4
[  777.563147]  el1_dbg+0x34/0x50
[  777.563148]  el1_sync_handler+0x9c/0xd0
[  777.563148]  el1_sync+0x88/0x140
[  777.563149]  __get_cpu_fpsimd_context+0x2c/0x40
[  777.563150]  __switch_to+0x20/0x120
[  777.563150]  dovetail_context_switch+0x6c/0x130
[  777.563151]  pipeline_switch_to+0x10/0x20
[  777.563151]  ___xnsched_run+0x174/0x25c
[  777.563152]  run_oob_call+0x88/0x174
[  777.563153]  handle_irq_pipelined_finish+0x1d8/0x1ec
[  777.563153]  handle_irq_pipelined+0x38/0x50
[  777.563154]  handle_arch_irq_pipelined+0x10/0x20
[  777.563155]  el1_irq+0xdc/0x1c0
[  777.563155]  0x203626c4
[  777.563156]  0x20361190
[  777.563156]  0x203615b4
[  777.563156]  0x20361660
[  777.563157]  0x20361da0
[  777.563157]  0x203609ec
[  777.563158]  __efi_rt_asm_wrapper+0x28/0x4c
[  777.563159]  efi_call_rts+0x204/0x3d0
[  777.563159]  process_one_work+0x1cc/0x350
[  777.563160]  worker_thread+0x138/0x46c
[  777.563160]  kthread+0x154/0x160
[  777.563161]  ret_from_fork+0x10/0x3c
[  777.563162] Code: 97ff4dae f000a180 91236000 97ffdde7 (f9416260)
[  777.563162] ---[ end trace 5ef18d81e2ade362 ]---
[  777.563163] note: kworker/u16:2[149] exited with preempt_count 33554434

在 2024/1/25 17:43, Jan Kiszka 写道:
> On 25.01.24 04:18, linz wrote:
>> I think my patch is not suitable after listening to your suggestions.
>> And I don't have any other good solutions.
>>
>> I think x86 is ok because there is no operation of writing global
>> variables in the critical zone.
>>
>> kernel_fpu_begin
>>      =>kernel_fpu_begin_mask
>> =>preempt_disable // enter the critical zone
>>          =>WARN_ON_FPU(!irq_fpu_usable());
>>          =>WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
>>          =>flags = hard_cond_local_irq_save(); // leave the critcal zone
>>
>>
>> But in arm64, there is operation of writing global variables in the
>> critical zone, unfortunernaly.
>> efi_call_rts
>>    =>__efi_fpsimd_begin
>>      =>kernel_neon_begin
>>        =>get_cpu_fpsimd_context
>> =>hard_preempt_disable // disable interrupt, enter the critical zone
>> =>__get_cpu_fpsimd_context //  first call, modify global variable
>> fpsimd_context_busy
>> =>hard_cond_local_irq_restore // enable interrupt, leave the critcal zone
>>
>> handle_arch_irq_pipelined // Latency timer interrupt triggered
>> =>handle_irq_pipelined_finish
>>    =>irq_exit_pipeline
>>      =>xnsched_run
>>        =>__xnsched_run
>>          =>pipeline_schedule
>>            =>run_oob_call
>>              =>___xnsched_run
>>                =>pipeline_switch_to
>>                  =>dovetail_context_switch
>>                    =>__switch_to
>>                      =>fpsimd_thread_switch
>>                        =>__get_cpu_fpsimd_context // second call
>>
>> So, I think there are more todos on arm64. Do you have any other good
>> suggestions?
>>
> Philippe, some input on this issue would be helpful to know what the
> next step needs to be. It's still unclear to me how fundemental this
> issue is (false positive warning or real state corruption?).
>
> Thanks,
> Jan
>

