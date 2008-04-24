Message-ID: <4810B072.6050603@domain.hid>
Date: Thu, 24 Apr 2008 12:08:18 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <48100D81.9090109@domain.hid> <481048A0.7040101@domain.hid>
In-Reply-To: <481048A0.7040101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Cannot end interrupt from user space:
 add	rt_intr_end call ?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>


Hi Philippe,

thank you for the patch !

> xnarch_end_irq() basically calls the ->unmask() method of the interrupt chip
> descriptor, which is the same as calling rt_intr_enable(). Before you do that,
>   
If I read the sources correctly, for "edge" and "simple" interrupt, 
xnarch_end_irq() calls nothing, for "percpu" it calls ->eoi() . For 
"level", "fasteoi", and "demux", it calls ->unmask().

So calling rt_intr_enable from user space would not always do the same 
as xnarch_end_irq from the kernel, wouldn't it ?

Tomas



Philippe Gerum wrote:
> Tomas Kalibera wrote:
>   
>> Hi,
>>
>> I think that when I handle interrupts from user space, I cannot 
>> correctly use I_NOAUTOENA. The thing is that this flag in fact means "do 
>> not call automatically xnarch_end_irq". The xnarch_end_irq call usually 
>> maps to unmasking the interrupt, but not always - depending on interrupt 
>> type (sometimes in eoi, sometimes is nop).
>>
>> I was thinking that it would be nice if I could call something like 
>> "xnarch_end_irq" (i.e. rt_intr_end) from user space, so that I could 
>> correctly use I_NOAUTOENA to control the flow of interrupts.
>>
>>     
>
> What would this buy you? xnarch_irq_end() would still handle the unmasking logic
> depending on the interrupt type, because it knows how the interrupt was
> acknowledged in the first place -- in contrast, the application does not and
> should not.
>
> xnarch_end_irq() basically calls the ->unmask() method of the interrupt chip
> descriptor, which is the same as calling rt_intr_enable(). Before you do that,
> you may want to try the attached patch, which makes sure that
> rt_intr_enable/disable are eagerly routed to unmask/mask on x86 for post-2.6.18
> kernels. That patch is expected to solve the "rt_intr_disable() not masking
> IO-APIC interrupt" issue we discussed earlier.
>
>   
>> Cheers,
>> Tomas
>>
>>
>>
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
>>
>>     
>
>
>   


