Message-ID: <5058C5F6.3040406@xenomai.org>
Date: Tue, 18 Sep 2012 21:05:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <504F5F1B.4020806@siemens.com> <50550091.50002@xenomai.org>
	<505592B8.9000109@xenomai.org> <5056DBAD.1000903@xenomai.org>
	<5058AE95.2020103@siemens.com> <5058AF21.5000600@xenomai.org>
	<5058BC96.8090601@siemens.com> <5058BE17.5070304@xenomai.org>
	<5058C39C.8000407@siemens.com>
In-Reply-To: <5058C39C.8000407@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe/x86: kernel BUG due to missing
 IRQ_MOVE_CLEANUP_VECTOR entry in ipipe-core3.2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/18/2012 08:55 PM, Jan Kiszka wrote:

> On 2012-09-18 20:31, Gilles Chanteperdrix wrote:
>> On 09/18/2012 08:25 PM, Jan Kiszka wrote:
>>
>>> On 2012-09-18 19:28, Gilles Chanteperdrix wrote:
>>>> On 09/18/2012 07:25 PM, Jan Kiszka wrote:
>>>>> On 2012-09-17 10:13, Gilles Chanteperdrix wrote:
>>>>>> On 09/16/2012 10:50 AM, Philippe Gerum wrote:
>>>>>>> On 09/16/2012 12:26 AM, Gilles Chanteperdrix wrote:
>>>>>>>> On 09/11/2012 05:56 PM, Gernot Hillier wrote:
>>>>>>>>
>>>>>>>>> Hi there!
>>>>>>>>>
>>>>>>>>> While testing ipipe-core3.2 on an SMP x86 machine, I found a reproducible
>>>>>>>>> kernel BUG after some seconds after starting irqbalance:
>>>>>>>>>
>>>>>>>>> ------------[ cut here ]------------
>>>>>>>>> kernel BUG at arch/x86/kernel/ipipe.c:592!
>>>>>>>>> invalid opcode: 0000 [#1] SMP
>>>>>>>>> CPU 0
>>>>>>>>> Modules linked in: des_generic md4 i7core_edac psmouse nls_cp437 edac_core cifs serio_raw joydev raid10 raid456 async_pq async_xor xor async_memcpy async_raid6_recov usbhid hid mpt2sas scsi_transport_sas raid_class igb raid6_pq async_tx raid1 raid0 multipath linear
>>>>>>>>>
>>>>>>>>> Pid: 0, comm: swapper/0 Not tainted 3.2.21-9-xenomai #3 Siemens AG Healthcare Sector MARS 2.1/X8DTH
>>>>>>>>> RIP: 0010:[<ffffffff8101edec>]  [<ffffffff8101edec>] __ipipe_handle_irq+0x1bc/0x1d0
>>>>>>>>> RSP: 0018:ffffffff8177bbe0  EFLAGS: 00010086
>>>>>>>>> RAX: 000000000000d880 RBX: 00000000ffffffff RCX: 0000000000000092
>>>>>>>>> RDX: ffffffffffffffdf RSI: ffffffff8177bc18 RDI: ffffffff8177bbf8
>>>>>>>>> RBP: ffffffff8177bc00 R08: 0000000000000001 R09: 0000000000000000
>>>>>>>>> R10: ffff880624ebaef8 R11: 000000000029fbc4 R12: 000000000000d880
>>>>>>>>> R13: ffffffff8177bbf8 R14: ffff880624e00000 R15: ffff880624e0d880
>>>>>>>>> FS:  0000000000000000(0000) GS:ffff880624e00000(0000) knlGS:0000000000000000
>>>>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>>>>>>>>> CR2: 00007f452a2efb80 CR3: 0000000c114d3000 CR4: 00000000000006f0
>>>>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>>>> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
>>>>>>>>> Process swapper/0 (pid: 0, threadinfo ffffffff81778000, task ffffffff81787020)
>>>>>>>>> Stack:
>>>>>>>>>  0000000000000000 ffffffff8177bfd8 0000000000000063 ffff880624e1f9a8
>>>>>>>>>  ffffffff8177bca8 ffffffff815a44dd ffffffff8177bc18 ffffffff8177bca8
>>>>>>>>>  00000000815a373b 000000000029fbc4 ffff880624eba570 0000000000000000
>>>>>>>>> Call Trace:
>>>>>>>>>  [<ffffffff815a44dd>] irq_move_cleanup_interrupt+0x5d/0x90
>>>>>>>>>  [<ffffffff815a6649>] ? call_softirq+0x19/0x30
>>>>>>>>>  [<ffffffff810043d5>] do_softirq+0xc5/0x100
>>>>>>>>>  [<ffffffff81050955>] irq_exit+0xd5/0xf0
>>>>>>>>>  [<ffffffff815a6e1f>] do_IRQ+0x6f/0x100
>>>>>>>>>  [<ffffffff815a6db0>] ? __entry_text_end+0x5/0x5
>>>>>>>>>  [<ffffffff8101f4d3>] __ipipe_do_IRQ+0x83/0xa0
>>>>>>>>>  [<ffffffff8101f4d9>] ? __ipipe_do_IRQ+0x89/0xa0
>>>>>>>>>  [<ffffffff810b7aaa>] __ipipe_dispatch_irq_fast+0x16a/0x170
>>>>>>>>>  [<ffffffff810b87b9>] __ipipe_dispatch_irq+0xe9/0x210
>>>>>>>>>  [<ffffffff8101eca1>] __ipipe_handle_irq+0x71/0x1d0
>>>>>>>>>  [<ffffffff8159bae0>] common_interrupt+0x60/0x81
>>>>>>>>>  [<ffffffff8101f3c4>] ? __ipipe_halt_root+0x34/0x50
>>>>>>>>>  [<ffffffff8101f3b7>] ? __ipipe_halt_root+0x27/0x50
>>>>>>>>>  [<ffffffff8100b146>] default_idle+0x66/0x1a0
>>>>>>>>>  [<ffffffff810020cf>] cpu_idle+0xaf/0x100
>>>>>>>>>  [<ffffffff8157ec22>] rest_init+0x72/0x80
>>>>>>>>>  [<ffffffff81aeacca>] start_kernel+0x3b4/0x3bf
>>>>>>>>>  [<ffffffff81aea321>] x86_64_start_reservations+0x131/0x135
>>>>>>>>>  [<ffffffff81aea456>] x86_64_start_kernel+0x131/0x138
>>>>>>>>> Code: ff ff 0f 1f 44 00 00 48 83 a0 98 06 00 00 fe 4c 89 ee bf 20 00 00 00 e8 63 83 09 00 e9 f6 fe ff ff be 01 00 00 00 e9 ab fe ff ff <0f> 0b 66 90 eb fc 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 55
>>>>>>>>> RIP  [<ffffffff8101edec>] __ipipe_handle_irq+0x1bc/0x1d0
>>>>>>>>>  RSP <ffffffff8177bbe0> 
>>>>>>>>>
>>>>>>>>> This seems to be caused by a missing entry for IRQ_MOVE_CLEANUP_VECTOR
>>>>>>>>> in the per_cpu array vector_irq[].
>>>>>>>>>
>>>>>>>>> I found that ipipe_init_vector_irq() (which used to add the needed
>>>>>>>>> entry) was factored out from arch/x86/kernel/ipipe.c. This likely
>>>>>>>>> happened when porting from 2.6.38 to 3.1 - at least I can still see the
>>>>>>>>> code in ipipe-2.6.38-x86 and missed it in ipipe-core3.1 (and didn't find
>>>>>>>>> any x86-branch in-between).
>>>>>>>>
>>>>>>>>
>>>>>>>> If I understand correctly, ipipe_init_vector_irq is no longer needed
>>>>>>>> because the I-pipe core uses ipipe_apic_vector_irq for vectors above
>>>>>>>> FIRST_SYSTEM_VECTOR. All system vectors are above this limit... except
>>>>>>>> IRQ_MOVE_CLEANUP_VECTOR. So, your patch is correct. Another one which
>>>>>>>> should work is to handle the special case IRQ_MOVE_CLEANUP_IRQ in
>>>>>>>> __ipipe_handle_irq as well.
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> This is correct, but unfortunately, upstream reshuffles the IRQ vector
>>>>>>> space every so often, and does not restrict the special vectors to the
>>>>>>> system range anymore. Therefore, we should re-introduce a post-setup
>>>>>>> routine for the vector->irq map, grouping all fixups we need in one place.
>>>>>>>
>>>>>> I propose the following change:
>>>>>> http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=9d131dc33080cda3f7e40342210d9338dc0c3d02
>>>>>>
>>>>>> Which avoids listing explicitely the vectors we want to intercept, and
>>>>>> so, should allow some changes to happen in the kernel without having to
>>>>>> care too much (except for vectors sur as IRQ_MOVE_CLEANUP_VECTOR which
>>>>>> do not go through alloc_intr_gate, but this vector is the only exception,
>>>>>> for now).
>>>>>
>>>>> Crashes on boot, SMP at least. Investigating.
>>>>
>>>> Well, I tested it in SMP, so, the crash is probably due to some option I
>>>> could not activate (such as IRQ_REMAP, the one triggering the use of
>>>> IRQ_MOVE_CLEANUP_VECTOR). One thing is sure however, some #ifdef is
>>>> missing, because it does not compile in UP mode without APIC/IO-APIC.
>>>
>>> Not sure what the precise option difference is, but the bug is that you
>>> write to vector_irq before __setup_vector_irq is finished.
>>
>>
>> Well, yes, the writes to vector_irq should happen even before it is
>> started, that is the point. The test at the end of setup_vector_irq skip
>> the... Ah, wait, a hunk is missing (I did test this modification in the
>> middle of the LAPIC TPR modification, so the commit is not actually tested).
>>
>> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
>> index 93f84c9..91d1ee9 100644
>> --- a/arch/x86/kernel/apic/io_apic.c
>> +++ b/arch/x86/kernel/apic/io_apic.c
>> @@ -1290,9 +1290,15 @@ static void __clear_irq_vector(int irq, struct
>> irq_cfg *cfg)
>>  void __setup_vector_irq(int cpu)
>>  {
>>  	/* Initialize vector_irq on a new cpu */
>> -	int irq, vector;
>> +	int irq, vector, vectors_limit;
>>  	struct irq_cfg *cfg;
>>
>> +#ifndef CONFIG_IPIPE
>> +	vectors_limit = NR_VECTORS;
>> +#else
>> +	vectors_limit = first_system_vector;
>> +#endif /* CONFIG_IPIPE */
>> +
>>  	/*
>>  	 * vector_lock will make sure that we don't run into irq vector
>>  	 * assignments that might be happening on another cpu in parallel,
>> @@ -1317,7 +1323,10 @@ void __setup_vector_irq(int cpu)
>>  		per_cpu(vector_irq, cpu)[vector] = irq;
>>  	}
>>  	/* Mark the free vectors */
>> -	for (vector = 0; vector < NR_VECTORS; ++vector) {
>> +	for (vector = 0; vector < first_system_vector; ++vector) {
>> +		if (vector == IRQ_MOVE_CLEANUP_VECTOR)
>> +			continue;
>> +
>>  		irq = per_cpu(vector_irq, cpu)[vector];
>>  		if (irq < 0)
>>  			continue;
>>
>>
> 
> Err, that's not really getting cleaner or easier maintainable than the
> original version, does it? Also, some loop below this clears out certain
> vector_irq entries again - are you sure that this is what we want? I
> vaguely recall that there was a very good reason to patch vector_irq
> afterward...
> 

> Will post the old variant, at least for comparison.

rah, vectors_limit is not needed at all. I do not see which look you are
talking about.

-- 
                                                                Gilles.

