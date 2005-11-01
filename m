Message-ID: <4367A60D.9030108@domain.hid>
Date: Tue, 01 Nov 2005 18:29:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] support for sharing IRQs
References: <OF52EBEF44.18C1609B-ONC12570AB.004913D2-C12570AB.004F9693@domain.hid>
	<200510312121.14160.dmitry.adamushko@domain.hid>
	<43675853.1000209@domain.hid>
	<200511011431.12506.dmitry.adamushko@domain.hid>
	<43677A2B.20600@domain.hid>
In-Reply-To: <43677A2B.20600@domain.hid>
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
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Dmitry Adamushko wrote:
> 
>>On Tuesday 01 November 2005 12:58, you wrote:
>>
>>
>>>>as "cockie" to the xnintr_irq_handler().
>>>>
>>>>The analogy is irq_desc_t vs. irqaction structures in Linux.
>>>>
>>>>This way, xnintr_irq_handler() can be called from adeos-ipipe layer
>>>>directly without the [2] layer.
>>>>
>>>>But that change looks quite invasive to me so far since
>>>>ipipe_domain::irqs::handler(irq - with a single parameter) is used all
>>>>over the map.
>>>
>>>I'd really prefer making one invasive change early in the process of
>>>addressing the issue than several kludges later to work around structural
>>>shortcomings, so no problem, go wild, I'm all ears.
>>>
>>
>>If we only want to get rid of the trampoline-thing then [2] + [3] would work 
>>out (btw, I have sent a message this morning where I tried to provide even 
>>some pseudo-code :) 
>>
>>But if we want to (think that we may) gain the adventage of having a more 
>>flexible irq-related support from the ipipe layer, then yep, those changes 
>>might look worthy. I thought that this way, we would even get rid of another 
>>per-irq (rthal_realtime_irq) array in hal/generic.c, maybe even from 
>>rthal_linux_irq too. The sole one is provided by the ipipe_domain structure 
>>and a set of generic interfaces e.g. via system.h so that the HAL or another 
>>layer may get access of it.
>>
>>e.g.
>>
>>the "cookie" remains opaque for the ipipe but when requested by 
>>HAL::rthal_irq_request() or NUCLEUS::xnintr_irq_handler() it's treated as a 
>>chain of ISR handlers.
>>
> 
> 
> Yep, that's also what I had in mind about potential ipipe changes and
> their use in the nucleus.
> 

Ok, let's go for those changes this way:

1. The I-pipe series needs to be updated so that an opaque cookie is passed to 
the handler; since we have a change in the interface, the 1.1 series has to be 
started for this purpose.

2. In order to let the people running the legacy RTAI/fusion and Xenomai 2.0.x 
series a reasonable amount of time to upgrade their patchset, the IRQ layer 
updates (sharing and trampoline suppression) will go to the Xenomai 2.1 dev 
branch. IOW, Xenomai 2.1 will be exclusively based on the I-pipe 1.1 series, 
which also means that Xenomai support for the oldgen Adeos and I-pipe 1.0 
patches will be discontinued after the Xenomai 2.0.x series is closed.

3. Changes in the IRQ layer will be made at nucleus level, which is the most 
efficient way to provide them.

It should be noted that as part of the build system refactoring, the real-time 
HAL has become a static portion of the Linux kernel, with its generic part being 
moved to the nucleus. IOW, the proposed changes will basically end up as 
redispatching some code inside the nucleus.

-- 

Philippe.

