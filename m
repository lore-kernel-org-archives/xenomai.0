Message-ID: <43DDE3DB.6070106@domain.hid>
Date: Mon, 30 Jan 2006 11:00:59 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Missing IRQ end function on PowerPC
References: <43CE1C28.6060001@domain.hid>	<17359.34362.870823.168739@domain.hid>	<43CF8ECF.4020805@domain.hid>
	<17359.37814.257893.95482@domain.hid>
	<43DD481B.4010603@domain.hid> <43DDCB6D.8060405@domain.hid>
In-Reply-To: <43DDCB6D.8060405@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Gilles Chanteperdrix wrote:
>>
>>>Wolfgang Grandegger wrote:
>>> > Therefore we need a dedicated function to re-enable interrupts in
>>>the  > ISR. We could name it *_end_irq, but maybe *_enable_isr_irq is
>>>more  > obvious. On non-PPC archs it would translate to *_irq_enable.
>>>I  > realized, that *_irq_enable is used in various place/skins and
>>>therefore  > I have not yet provided a patch.
>>>
>>>The function xnarch_irq_enable seems to be called in only two functions,
>>>xintr_enable and xnintr_irq_handler when the flag XN_ISR_ENABLE is set.
>>>
>>>In any case, since I am not sure if this has to be done at the Adeos
>>>level or in Xenomai, we will wait for Philippe to come back and decide.
>>>
>>
>>->enable() and ->end() all mixed up illustrates a silly x86 bias I once
>>had. We do need to differentiate the mere enabling from the IRQ epilogue
>>at PIC level since Linux does it - i.e. we don't want to change the
>>semantics here.
>>
>>I would go for adding xnarch_end_irq -> rthal_irq_end to stick with the
>>Linux naming scheme, and have the proper epilogue done from there on a
>>per-arch basis.
>>
>>Current uses of xnarch_enable_irq() should be reserved to the
>>non-epilogue case, like xnintr_enable() i.e. forcibly unmasking the IRQ
>>source at PIC level outside of any ISR context for such interrupt (*).
>>XN_ISR_ENABLE would trigger a call to xnarch_end_irq, instead of
>>xnarch_enable_irq. I see no reason for this fix to leak to the Adeos
>>layer, since the HAL already controls the way interrupts are ended
>>actually; it just does it improperly on some platforms.
>>
>>(*) Jan, does rtdm_irq_enable() have the same meaning, or is it intended
>>to be used from the ISR too in order to revalidate the source at PIC level?
>>
> 
> 
> Nope, rtdm_irq_enable() was never intended to re-enable an IRQ line
> after an interrupt, and the documentation does not suggest this either.
> I see no problem here.
>

Ok, so no change would be needed here to implement what's described above.

> Jan
> 


-- 

Philippe.

