Message-ID: <BLU436-SMTP255CBBB752AF876B985AFF7F01F0@phx.gbl>
References: <BLU436-SMTP777DC6298F62C65606DFEF0100@phx.gbl>
 <20151114123953.GN1820@hermes.click-hack.org>
 <BLU437-SMTP2BEF9B6C71BB45D72DA0EF0100@phx.gbl>
 <20151114182603.GS1820@hermes.click-hack.org>
 <BLU436-SMTP1376F8EA4728BE09736A4FEF01F0@phx.gbl>
 <20151115184359.GW1820@hermes.click-hack.org>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Sun, 15 Nov 2015 14:21:38 -0800
MIME-Version: 1.0
In-Reply-To: <20151115184359.GW1820@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] IPIPE patch for BCM2709/RPI2.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 15-11-15 10:43 AM, Gilles Chanteperdrix wrote:
> On Sat, Nov 14, 2015 at 04:14:04PM -0800, Mathieu Rondonneau wrote:
>> On 15-11-14 10:26 AM, Gilles Chanteperdrix wrote:
>>> On Sat, Nov 14, 2015 at 08:11:52AM -0800, Mathieu Rondonneau wrote:
>>>> On 15-11-14 04:39 AM, Gilles Chanteperdrix wrote:
>>>>> On Fri, Nov 13, 2015 at 09:31:23PM -0800, Mathieu Rondonneau wrote:
>>>>>>  #ifdef CONFIG_OF
>>>>>> @@ -333,6 +349,10 @@ static struct irq_chip armctrl_chip = {
>>>>>>  	.irq_mask = armctrl_mask_irq,
>>>>>>  	.irq_unmask = armctrl_unmask_irq,
>>>>>>  	.irq_set_wake = armctrl_set_wake,
>>>>>> +#ifdef CONFIG_IPIPE
>>>>>> +	.irq_hold = armctrl_mask_irq,
>>>>>> +	.irq_release = armctrl_unmask_irq,
>>>>>> +#endif
>>>>>
>>>>> Also, as explained during your lengthy discussion, you do not need
>>>>> to define irq_hold and irq_release here.
>>>>>
>>>> Kernel does not boot if I remove them (also explained in our lengthy
>>>> discussion). I think that's the part we did not understood each other.
>>>> I am happy to remove them if there is another workaround to get the
>>>> kernel booting.
>>>
>>> I can not find the mail where you explain what happens when you
>>> remove it. Could you explain it again, please?
>>>
>>> Regards.
>>>
>>
>> the doc refers to handle_fasteoi_irq
>> (http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#flow_handler)
>> but I think there are more corner cases (else if cases). There seems to
>> be a case also for the handle_percpu_devid_irq for fasteoi behavior (to
>> call mask/unmask). The code allows that only when irq_hold is defined.
>>
>> See the code from kernel/chip.c
>>
>> } else if (handle == handle_percpu_irq ||
>> 			   handle == handle_percpu_devid_irq) {
>> 			if (irq_desc_get_chip(desc) &&
>> 			    irq_desc_get_chip(desc)->irq_hold) {
>> 				desc->ipipe_ack = __ipipe_ack_fasteoi_irq;
>> 				desc->ipipe_end = __ipipe_end_fasteoi_irq;
>> 			} else {
>> 				desc->ipipe_ack = __ipipe_ack_percpu_irq;
>> 				desc->ipipe_end = __ipipe_nop_irq;
>> 			}
>> 		}
>>
>> In our earlier conversation you said this hack was for A9 only.
>> But it seems that this might be also needed for non-A9 (bcm2709) because
>> the mask and un-mask seems to be the one that are needed to be called.
>> this is the only reason I defined a irq_hold.
>>
>> Does irq_ack and irq_eoi are required for handle_percpu_devid_irq?
>> the doc does not cover that part and current platform does not use
>> those. Removing the irq_hold then fails because irq not getting handled.
>>
>> Currently handle_level_irq and handle_percpu_devid_irq share the same
>> irqchip, but that can not be the case if I define a irq_ack (irq_mask
>> will be called, then irq_ack, and then irq_unmask).
>>
>> So far defining irq_hold seems to be what is required for this platform
>> in order to call the mask/unmask without having two irqchip.
>>
>> I agree with you, this might look more like a hack.
>>
>> Is there another way to do this?
> 
> From what I understand:
> - on A9, the irqchip is shared between fasteoi irq and percpu irq
> - on other platforms (where handling percpu irq was first
> introduced), the irqchip is shared between percpu irq and another
> flow handler, probably not level irqs
> - on your platform, percpu irq shares the irqchip with level irqs,
> __ipipe_ack_percpu_irq does not work because it does not mask the
> irq, and this can not work with level irqs.
> 
> So, if implementing irq_hold works for this case, then let us keep
> it that way. The porting guide simply need to be updated for this
> case.
> 
Sounds good to me,
Thanks,
-Mathieu

