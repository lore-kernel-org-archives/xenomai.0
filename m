Subject: Re: [PATCH 5.4] x86: ipipe: Harden path between use_temporary_mm and
 unuse_temporary_mm
References: <3511af9f-f393-a226-0e41-a23d8c1577c8@siemens.com>
 <87ft0xfyj4.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4f5118a4-d362-7f18-fdcf-da22aabb7344@siemens.com>
Date: Mon, 15 Mar 2021 07:19:40 +0100
MIME-Version: 1.0
In-Reply-To: <87ft0xfyj4.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 14.03.21 18:14, Philippe Gerum wrote:
> 
> Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This is only called during early init, e.g. for switching alternatives.
>> Still, switch_mm_irqs_off would complain without this, and we are better
>> safe than sorry.
>>
> 
> The way this is done in Dovetail is fragile too, since the protection we
> have there still expects the pipeline entry code not to mess up on
> handling an interrupt, which defeats the purpose of such
> precaution. Besides, the temp_state should be snapshot under protection
> too. IOW, IRQs should be hard disabled fully while using the temporary
> mm.
> 
> Upstreaming a similar patch for Dovetail.

Just saw it: It's wrong as it left the hard_irq_save_full at the caller
site. Would raise a warning when debugging is enabled. Please fix.

Jan

> 
> Thanks,
> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> 4.19 is not affected. Dovetail solves this differently, via 
>> local_irq_save_full which is not available in I-pipe and not worth to 
>> introduce for this purpose.
>>
>>  arch/x86/include/asm/mmu_context.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
>> index 0d9dd08c2122..2b4afca4e15f 100644
>> --- a/arch/x86/include/asm/mmu_context.h
>> +++ b/arch/x86/include/asm/mmu_context.h
>> @@ -383,6 +383,7 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
>>  	temp_mm_state_t temp_state;
>>  
>>  	lockdep_assert_irqs_disabled();
>> +	hard_cond_local_irq_disable();
>>  	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
>>  	switch_mm_irqs_off(NULL, mm, current);
>>  
>> @@ -407,6 +408,7 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
>>  {
>>  	lockdep_assert_irqs_disabled();
>>  	switch_mm_irqs_off(NULL, prev_state.mm, current);
>> +	hard_cond_local_irq_enable();
>>  
>>  	/*
>>  	 * Restore the breakpoints if they were disabled before the temporary mm
> 
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

