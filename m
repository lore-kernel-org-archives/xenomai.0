Message-ID: <481EECDC.7060304@domain.hid>
Date: Mon, 05 May 2008 13:17:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <481AA6B5.9070508@domain.hid> <481AC93E.3030107@domain.hid>
	<481AD5C2.6030607@domain.hid> <481AD90C.2090902@domain.hid>
	<481AD9E5.4000102@domain.hid> <481AE18A.2070803@domain.hid>
	<481AE503.2060609@domain.hid> <481AE850.8090807@domain.hid>
	<481AF022.7020505@domain.hid> <481AF29B.4040609@domain.hid>
In-Reply-To: <481AF29B.4040609@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] MSI Interrupt Crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> PS: We really do want to call mask/unmask instead of disable/enable in any case, because ->disable()
>>>>> became a nop in 2.6.21, so we just can't rely on its default action anyway. This is a separate
>>>>> issue, that caused rthal_irq_disable() not to actually mask the interrupt when the I/O APIC is enabled.
>>>> Hmmmm... That makes me scratch my head. Could this change have some
>>>> impact on I-pipe as well? We are currently pulling hairs here as some
>>>> SCSI adapter is flooding us with spurious IRQs during init, but only if
>>>> I-pipe is enabled.
>>>>
>>> __ipipe_enable_irq/__ipipe_disable_irq are not doing the right thing anymore,
>>> but, AFAICT, this would only affect callers of ipipe_virtualize_irq and
>>> ipipe_control_irq, using IPIPE_ENABLE_MASK.
>>>
>>> Btw, are those APIC-based SMP spurious interrupts, or 8259-based ones?
>> x86-64, APIC, fasteoi. But it is no SMP artifact (maxcpus=1 makes no
>> difference). So far only one machine type is affected. And there is a
>> higher chance to get over the initialization with kernel 2.6.23 than
>> with .24. After that point, everything is fine.
>>
>> Unfortunately, the box is highly contended (and also horribly slow at
>> boot), so testing and debugging is a lengthy process. Therefore, I'm
>> primarily collecting ideas about potential reasons.
>>
> 
> Food for thought - no idea if that will make a difference for you, but I noticed
> that doing it the other way was required for some boxes, so maybe yours is on
> the other side of the fence...
> 
> diff --git a/arch/x86/kernel/io_apic_64.c b/arch/x86/kernel/io_apic_64.c
> index bc82e4d..8d74218 100644
> --- a/arch/x86/kernel/io_apic_64.c
> +++ b/arch/x86/kernel/io_apic_64.c
> @@ -1500,10 +1500,10 @@ static void ack_apic_level(unsigned int irq)
>  	 * from being delayed, waiting for a high priority interrupt
>  	 * handler running in a low priority domain to complete.
>  	 */
> +	__ack_APIC_irq();
>  	spin_lock(&ioapic_lock);
>  	__mask_IO_APIC_irq(irq);
>  	spin_unlock(&ioapic_lock);
> -	__ack_APIC_irq();
>  #endif /* CONFIG_IPIPE */
>  }

Thanks, but makes no difference here. Will have to dig deeper - once
/this/ issue is on the top of my plist again... :-/

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

