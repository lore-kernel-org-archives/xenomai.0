Message-ID: <985afe46-9ffd-c70c-0113-60ec82fe291b@siemens.com>
Date: Tue, 1 Mar 2022 21:34:37 +0100
Subject: Re: [I-pipe 4.4] [PATCH v2 1/4] ipipe: x86: Do not call BUG() in case
 of retriggered APIC vectors
Content-Language: en-US
References: <20220301125302.2368068-1-florian.bezdeka@siemens.com>
 <20220301125302.2368068-2-florian.bezdeka@siemens.com>
 <26f1909e-abb1-5e94-2b6a-dd2d50df4675@siemens.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <26f1909e-abb1-5e94-2b6a-dd2d50df4675@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 01.03.22 21:21, Jan Kiszka wrote:
> On 01.03.22 13:52, Florian Bezdeka wrote:
>> The CPU hotplugging code might re-trigger a vector. In that case the
>> vector is in the VECTOR_RETRIGGERED state. With this patch applied ipipe
>> does no longer call BUG() for such vectors.
>>
> 
> Doesn't this also avoids a BUG for spurious vectors (provided they can
> exist for other reasons than CPU offlining)?

Yes it does. Forgot to mention that...

> 
>> This is a backport from the 4.19 and 5.4 ipipe branches handling the
>> VECTOR_SHUTDOWN state. The VECTOR_SHUTDOWN case itself does not exist in
>> 4.4, but the VECTOR_RETRIGGERED case does.
>>
>> __ipipe_handle_irq() is now synchronized with do_IRQ().
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>  arch/x86/kernel/ipipe.c | 44 +++++++++++++++++++++++++++++++----------
>>  1 file changed, 34 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
>> index 739b5c37ec7b..6020739256f9 100644
>> --- a/arch/x86/kernel/ipipe.c
>> +++ b/arch/x86/kernel/ipipe.c
>> @@ -33,6 +33,7 @@
>>  #include <linux/mm.h>
>>  #include <linux/kgdb.h>
>>  #include <linux/ipipe_tickdev.h>
>> +#include <linux/ratelimit.h>
>>  #include <asm/asm-offsets.h>
>>  #include <asm/unistd.h>
>>  #include <asm/processor.h>
>> @@ -428,22 +429,44 @@ skip_kgdb:
>>  	return 0;
>>  }
>>  
>> +static inline int __ipipe_irq_from_vector(int vector, int *irq)
>> +{
>> +	struct irq_desc *desc;
>> +
>> +	if (vector >= FIRST_SYSTEM_VECTOR) {
>> +		*irq = ipipe_apic_vector_irq(vector);
>> +		return 0;
>> +	}
>> +
>> +	desc = __this_cpu_read(vector_irq[vector]);
>> +	if (likely(!IS_ERR_OR_NULL(desc))) {
>> +		*irq = irq_desc_get_irq(desc);
>> +		return 0;
>> +	}
>> +
>> +#ifdef CONFIG_X86_LOCAL_APIC
>> +	__ack_APIC_irq();
>> +#endif
>> +
>> +	if (desc == VECTOR_UNUSED) {
>> +		pr_emerg_ratelimited("%s: %d.%d Unexpected IRQ trap\n",
>> +				     __func__, smp_processor_id(), vector);
>> +	} else {
>> +		__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
>> +	}
>> +
>> +	return -1;
>> +}
>> +
>>  int __ipipe_handle_irq(struct pt_regs *regs)
>>  {
>>  	struct ipipe_percpu_data *p = __ipipe_raw_cpu_ptr(&ipipe_percpu);
>>  	int irq, vector = regs->orig_ax, flags = 0;
>>  	struct pt_regs *tick_regs;
>> -	struct irq_desc *desc;
>>  
>>  	if (likely(vector < 0)) {
>> -		vector = ~vector;
>> -		if (vector >= FIRST_SYSTEM_VECTOR)
>> -			irq = ipipe_apic_vector_irq(vector);
>> -		else {
>> -			desc = __this_cpu_read(vector_irq[vector]);
>> -			BUG_ON(IS_ERR_OR_NULL(desc));
>> -			irq = irq_desc_get_irq(desc);
>> -		}
>> +		if (__ipipe_irq_from_vector(~vector, &irq) < 0)
>> +			goto out;
>>  	} else { /* Software-generated. */
>>  		irq = vector;
>>  		flags = IPIPE_IRQF_NOACK;
>> @@ -477,7 +500,8 @@ int __ipipe_handle_irq(struct pt_regs *regs)
>>  		__ipipe_call_mayday(regs);
>>  
>>  	ipipe_trace_irqend(irq, regs);
>> -	
>> +
>> +out:
>>  	if (!__ipipe_root_p ||
>>  	    test_bit(IPIPE_STALL_FLAG, &__ipipe_root_status))
>>  		return 0;
> 
> Thanks, applied.
> 
> Jan
> 


