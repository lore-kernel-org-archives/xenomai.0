Message-ID: <843a47610811060628o3c321bc4wce3e7223611b971@domain.hid>
Date: Thu, 6 Nov 2008 09:28:39 -0500
From: "Matthew Fornero" <mfornero.lists@domain.hid>
Sender: mfornero@domain.hid
In-Reply-To: <4912F652.3020608@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <843a47610811040527v582d1aa0oce35d4278b6c6af9@domain.hid>
	<4910A0BD.8020808@domain.hid>
	<843a47610811051556y3b73ae28gebcdf0eeb2a8b800@domain.hid>
	<4912F652.3020608@domain.hid>
Subject: Re: [Xenomai-help] Masking / Disabling the local timer interrupt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Thu, Nov 6, 2008 at 8:51 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Matthew Fornero wrote:
>> On Tue, Nov 4, 2008 at 2:21 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Matthew Fornero wrote:
>>>> Hello,
>>>>
>>>> I have an application on x86 that uses an external event (either an
>>>> interrupt or a DMA write to a specific memory location) to trigger code
>>>> execution, and I believe the local timer interrupt is contributing a
>>>> significant amount of jitter. This is a bit of a unique case where the only
>>>> code that should be executing on that core is triggered by the event, so
>>>> there is no need for anything timer based.
>>>>
>>>> I'm using a dual core processor with a quiet system, and have placed all of
>>>> the "moveable" interrupts on CPU 0 (0-NR_IRQs using ipipe_set_irq_affinity).
>>>> Looking at /proc/xenomai/irq and /proc/interrupts shows only the local timer
>>>> interrupt increment on CPU 1. When using the DMA write to trigger execution,
>>>> placing "sti"/"cli" around the polling routine improves the jitter
>>>> substantially.
>>>>
>>>> Based on the above, is there some way to do one of the following:
>>>>
>>>> 1). Make a user space task higher priority than the timer interrupt
>>>>
>>>> or
>>>>
>>>> 2). A proper way to disable the local timer (vs. disabling all interrupts)
>>>> on specific cores, as these cores would only need to run event based
>>>> routines.
>>> You can disable Xenomai timer interrupt by calling xnpod_stop_timer in
>>> kernel-space. However, what you see in /proc/interrupt is not Xenomai
>>> timer it is Linux', and it causes a bit of jitter (the time for the
>>> I-pipe to mask, ack and return from interrupt). Disabling it would
>>> require butchery in Linux code, but maybe simply masking the timer
>>> interrupt could work.
>>>
>>> --
>>>                                            Gilles.
>>
>> I could not find any reference to the function xnpod_stop_timer in the
>> xenomai code (searched through the cross-reference).
>> I tried using xnarch_stop_timer(cpu), but this seems to disable the
>> timers across all CPUs, rather than just the one passed.
>> What I'd really like to do is simply mask the interrupt temporarily
>> while my critical section is executing (the DMA polling routine)-- is
>> there any way to do this? I can go into the local APIC and change the
>> mask bits, but using some sort of API seems like it'd be cleaner.
>
> xnpod_stop_timer no longer exists ! The function to disable irqs is
> rt_intr_disable if you use the native skin.
>
> --
>                                                 Gilles.
>

On Thu, Nov 6, 2008 at 8:51 AM, Gilles Chanteperdrix
- Show quoted text -
<gilles.chanteperdrix@xenomai.org> wrote:
> Matthew Fornero wrote:
>> On Tue, Nov 4, 2008 at 2:21 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Matthew Fornero wrote:
>>>> Hello,
>>>>
>>>> I have an application on x86 that uses an external event (either an
>>>> interrupt or a DMA write to a specific memory location) to trigger code
>>>> execution, and I believe the local timer interrupt is contributing a
>>>> significant amount of jitter. This is a bit of a unique case where the only
>>>> code that should be executing on that core is triggered by the event, so
>>>> there is no need for anything timer based.
>>>>
>>>> I'm using a dual core processor with a quiet system, and have placed all of
>>>> the "moveable" interrupts on CPU 0 (0-NR_IRQs using ipipe_set_irq_affinity).
>>>> Looking at /proc/xenomai/irq and /proc/interrupts shows only the local timer
>>>> interrupt increment on CPU 1. When using the DMA write to trigger execution,
>>>> placing "sti"/"cli" around the polling routine improves the jitter
>>>> substantially.
>>>>
>>>> Based on the above, is there some way to do one of the following:
>>>>
>>>> 1). Make a user space task higher priority than the timer interrupt
>>>>
>>>> or
>>>>
>>>> 2). A proper way to disable the local timer (vs. disabling all interrupts)
>>>> on specific cores, as these cores would only need to run event based
>>>> routines.
>>> You can disable Xenomai timer interrupt by calling xnpod_stop_timer in
>>> kernel-space. However, what you see in /proc/interrupt is not Xenomai
>>> timer it is Linux', and it causes a bit of jitter (the time for the
>>> I-pipe to mask, ack and return from interrupt). Disabling it would
>>> require butchery in Linux code, but maybe simply masking the timer
>>> interrupt could work.
>>>
>>> --
>>>                                            Gilles.
>>
>> I could not find any reference to the function xnpod_stop_timer in the
>> xenomai code (searched through the cross-reference).
>> I tried using xnarch_stop_timer(cpu), but this seems to disable the
>> timers across all CPUs, rather than just the one passed.
>> What I'd really like to do is simply mask the interrupt temporarily
>> while my critical section is executing (the DMA polling routine)-- is
>> there any way to do this? I can go into the local APIC and change the
>> mask bits, but using some sort of API seems like it'd be cleaner.
>
> xnpod_stop_timer no longer exists ! The function to disable irqs is
> rt_intr_disable if you use the native skin.
>
> --
>                                                 Gilles.
>

A couple of follow ups:

1). I have not been able to find the RT_INTR pointer associated with
the local APIC timer interrupt-- is there some documentation on this?
Basically, I would need something to pass to rt_intr_disable

2). rt_intr_disable looks like it will disable the interrupt across
all CPUs. Is there any way to disable the Xenomai local APIC timer
handler on just a single CPU?

-- Matthew Fornero

