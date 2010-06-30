Message-ID: <4C2BB70E.7020309@domain.hid>
Date: Wed, 30 Jun 2010 23:28:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimKEFqaOGLrvLhpf0FqqdTkAPraazAnbuUGMa0V@mail.gmail.com>	<4C289319.4050807@domain.hid>
	<4C289FF2.6010208@domain.hid> <4C28A71F.8030902@domain.hid>
In-Reply-To: <4C28A71F.8030902@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ conflict issues with and ESD PMC card.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Stefan Kisdaroczi wrote:
>> Salut Gilles,
>>
>> i need to jump in.
>>
>> Am 28.06.2010 14:18, schrieb Gilles Chanteperdrix:
>>> Nape Ibrahim Lentsoane wrote:
>>>> Hello,
>>>>
>>>> I've been having this problem for some time now and I hope someone from
>>>> the Xenomai community can help.
>>>> Basically, my kernel does not want to boot with PMC card. I have managed
>>>> to use console redirection of messages
>>>> to the serial port and I can see the error messages. From what I can
>>>> see, there is a problem with '/xnintr_irq_handler/' due
>>>> to this message at boot time: /Xenomai: xnintr_irq_handler: IRQ10 not
>>>> handled. Disabling IRQ line./
>>> As repeated many times, disabling ACPI has been known to cause such
>>> issues. So, you should keep ACPI enabled, only ACPI_PROCESSOR needs to
>>> be disabled.
>>>
>>> For IRQ conflicts, see:
>>> http://www.xenomai.org/index.php/FAQs#What_can_I_do_if_Xenomai_and_Linux_devices_share_the_same_IRQ.3F
>> I had to consult this wiki already multiple times (every time I get a new box...)
>> It's ok, but there is not really a solution. Currently I have one pci-card
>> and a rtdm driver. I got my unshared realtime IRQ after disabling the soundcard.
>>
>> At the end of the year I need to be able to use three of these cards and
>> five realtime serial connections in one machine. I already have sleepless
>> nights ;-) and hope I understood something wrong...
>>
>> AFAIK with 2.6.31 "threaded IRQ's" were merged to mainline. Would it be possible
>> now for IPIPE to pass down the IRQ's to linux so that the IRQ is handled, but
>> the IRQ-Thread is not started ? Or something like ?
>>
> 
> It's still not that simple. Threaded IRQs per se do not solve the issue,
> neither in upstream nor for Xenomai.
> 
> What they do, though, is to lay the ground for slowing enabling RT-safe
> IRQ-sharing in more and more Linux drivers: Given a proper split-up
> between top-half and threaded handler, you now have the means (with
> upstream) or at least the blueprint (for Xenomai) how to quickly silence
> an IRQ line at device level. For Xenomai, these handler would have to be
> made co-scheduling-safe and could then be registered against RTDM as
> shared RT-IRQs. Still, this issue cannot be addressed automatically, it
> has to be developed driver by driver.

If what you want is run the top-half ahead of the pipeline, you do not
need RTDM. I-pipe can do it (the way we do interrupts demultiplexing on
embedded platforms).

I am not sure we want the issue to be addressed automatically, it looks
dangerous for the determinism.

-- 
					    Gilles.

