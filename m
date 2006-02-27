Message-ID: <4402C45C.10103@domain.hid>
Date: Mon, 27 Feb 2006 10:20:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
References: <b647ffbd0602150939g59256b2bx@domain.hid>	<b647ffbd0602210254p19086a0au@domain.hid>	<43FAF94C.4080709@domain.hid>	<43FAFE58.5060201@domain.hid>	<b647ffbd0602210848g321ffedei@domain.hid>	<43FB480E.9020808@domain.hid>	<43FB529B.3040207@domain.hid>	<43FB6102.1070004@domain.hid>	<b647ffbd0602220445k749d630j@domain.hid>	<43FDA8E2.5010806@domain.hid>	<b647ffbd0602251214h36768b46o@domain.hid>	<4401F8B4.9090707@domain.hid>	<4401FE4A.7010603@domain.hid>
	<4401FFA6.3010204@domain.hid> <4402B4D3.4050606@domain.hid>
In-Reply-To: <4402B4D3.4050606@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Anders Blomdell wrote:
> Jan Kiszka wrote:
> 
>> Philippe Gerum wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Dmitry Adamushko wrote:
>>>>
>>>>
>>>>> ...
>>>>> This said, I'm going to publish the shirq patch (after finalizing ISR
>>>>> return
>>>>> bits,
>>>>> where I still have some doubts) without enable/disable nesting 
>>>>> support.
>>>>> It can be supported at some point of time later, if it's really 
>>>>> needed.
>>>>>
>>>>
>>>>
>>>> Regarding enable/disable nesting and existing driver patterns: I
>>>> currently do the following on devices init via RTDM (and users may have
>>>> copied this):
>>>>
>>>> rtdm_irq_request(...);
>>>> <init_hardware, also clear pending IRQs of the device>
>>>> rtdm_irq_enable(...);
>>>>
>>>> But I do not disable the IRQ before rtdm_irq_free() again. Is this
>>>> unbalanced enabling still needed today? Is it even wrong these days?
>>>
>>>
>>> Looks unsafe, since nothing says that freeing the descriptor associated
>>> with some IRQ should disable this IRQ line at hw level. However, we
>>> would be correct to assume that no IRQ could happen after we have been
>>> asked to free its associated descriptor.
>>>
>>> Is
>>>
>>>> it arch-dependent?
>>>
>>>
>>> Nope. Both APIs are arch-agnostic anyway.
>>>
>>> I think the pattern dates back in RTAI times and was
>>>
>>>> needed for so far unused IRQs. Disabling them on device closure blocked
>>>> the line for later use under Linux.
>>>>
>>>
>>> We never had this problem with Xeno, since we always relied on the
>>> standard IRQ controllers defined by Linux for managing interrupt lines.
>>> IOW, Linux can undo what Xenomai did wrt IRQ line enabling/disabling.
>>>
>>
>>
>> So the enable is definitely needed and a disable on release should not
>> cause harm anymore? If that's the case, we could start re-introducing
>> rtdm_irq_disable before rtdm_irq_free again.
> 
> Except for interrupts shared between RT/non-RT, the don't need enable 
> (since they are enabled by Linux already), and probably doesn't fare 
> well with a final disable.
> 

That's the uncommon case by essence, for which a different set of rules already 
applies anyway.

>>
>>
>>>> I'm asking now in case we have to change the usage: we may better do it
>>>> early (e.g. with the introduction of Xenomai 2.1), so that the 
>>>> number of
>>>> surprises can be kept low when the underlying mechanisms get reworked
>>>> later.
>>>>


-- 

Philippe.

