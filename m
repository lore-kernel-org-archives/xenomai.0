Message-ID: <0b1ec490-5d7b-3ca7-7b2a-952db122d50d@siemens.com>
Date: Thu, 17 Feb 2022 15:08:23 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] ipipe: Fix ipipe level irq end
Content-Language: en-US
References: <94f8dc12-d019-4736-2423-bfacc6b3b0b2@siemens.com>
 <20220217084830.712756-1-gunter.grau@philips.com>
 <a5e996c5-f198-b74d-11b6-9a609462dadc@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <a5e996c5-f198-b74d-11b6-9a609462dadc@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gunter Grau <gunter.grau@philips.com>, xenomai@xenomai.org

On 17.02.22 15:05, Jan Kiszka via Xenomai wrote:
> On 17.02.22 09:48, Gunter Grau via Xenomai wrote:
>> The following commit in the vanilla kernel introduced
>> a check for the cached interrupt mask flag in mask_irq():
>>
>> bf22ff45bed6 ("genirq: Avoid unnecessary low level irq function calls")
>>
>> This means if the flag is not serviced correctly
>> the real bit in the hardware interrupt controller may not be
>> cleared or set.
>> The __ipipe_end_level_irq() function does not follow this rule.
>> It unmasks the bit in the hardware without setting the cached flags
>> accordingly. So after the first level interrupt is finished the
>> mask cache has a wrong state. If now the next interrupt fires,
>> the mask_irq() function will not really mask the interrupt in
>> the hardware which causes a interrupt storm after reenabeling
>> the hard irqs.
>> The fix now also updates the shadow flag correctly.
> 
> Missed that your "signed-of-by" was not here. Mind to follow up to confirm
> 

Signed-off-by: ...

> https://developercertificate.org/
> 
> ? A reply with that line would suffice (need to fix up the patch anyway,
> wrong send address).
> 
> Thanks,
> Jan
> 
>> ---
>>  kernel/irq/chip.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> index 7c03e2931189..ff9a8b3f33db 100644
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -988,6 +988,7 @@ void __ipipe_ack_level_irq(struct irq_desc *desc)
>>  void __ipipe_end_level_irq(struct irq_desc *desc)
>>  {
>>         desc->irq_data.chip->irq_unmask(&desc->irq_data);
>> +       irq_state_clr_masked(desc);
>>  }
>>
>>  void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
>> --
>> 2.25.1


-- 
Siemens AG, Technology
Competence Center Embedded Linux

