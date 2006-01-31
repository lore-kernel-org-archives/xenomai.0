Message-ID: <43DF2E8A.8020504@domain.hid>
Date: Tue, 31 Jan 2006 10:31:54 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared irqs v.5
References: <b647ffbd0601180617v38c990f0w@domain.hid>		<43D41364.6000300@domain.hid>	<b647ffbd0601230841o51fbc5d2o@domain.hid>
	<43D527AA.8020105@domain.hid>
In-Reply-To: <43D527AA.8020105@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Dmitry Adamushko wrote:

<snip>

>>
>>To achieve this,
>>
>>1) xnintr_t should be extended with a "name" field;
>>
>>2) rt_intr_create() should contain a "name" argument and not use
>>auto-generation (as "irqN") any more.
>>

Ok, sounds reasonable. This said, since this change would alter the interrupt API 
for the native skin, we should better do it asap, i.e. before 2.1 is out, so that 
we don't have to break the compatibility again in a few weeks/months. There is no 
urge to have the shared IRQ support available for 2.1, but the visible changes at 
the API level needed to have it in the future should be put in place early.

>>or
>>
>>ll /proc/xenomai/registry/interrupts
>>
>>3
>>5
>>
>>Those are directories and e.g.
>>
>>ll /proc/xenomai/registry/interrupts/5
>>
>>driver2
>>driver3
>>
>>Those are "files" and contain the same information as now.
>>
>>This is harder to implement since the registry interface should be extended
>>(for each skin).
> 
> 
> Isn't just the native skin using this registry? Anyway, as the preferred

(yep)

> way of registering IRQ handlers should be via RTDM, and RTDM does not
> use the registry, go for the simplest solution. /proc/xenomai/interrupts
> is more important in my eyes.
> 

Ack. The native skin is only one of the available interfaces, and IRQ channels are 
interface-independent resources, so this would be better controlled at nucleus 
level. As an aside, the POSIX skin is very important in the picture too, and 
getting full access to the shared IRQ support/features from there is utterly 
important.

> 
>>
>>>...
>>
>>>Jan
>>>
>>>
>>>PS: Still at home?
>>
>>
>>Yes. This week I'm going to Belgium to attend a few meeting with some
>>customers of my potential employer. So my next step for the nearest future
>>will be finally determined there :)
> 
> 
> Best wishes! Just avoid too much extra work, here is already enough to
> do. ;)
> 
> 
>>
>>How many degrees Centigrade? I guess our current -9°C
>>
>>>here in Hannover must appear ridiculous, almost subtropical warm to you.
>>>;)
>>
>>
>>Hey, I'm not from Syberia :o) This is a kind of common delusion I guess as
>>the whole former USSR is assotiated with cold winters, bears, eak.. KGB etc.
>>:o)
> 
> 
> "Former"? Did I missed something? :)
> 
> 
>>from wikipedia.com (about Belarus) :
>>
>>"The climate <http://en.wikipedia.org/wiki/Climate> ranges from harsh
>>winters <http://en.wikipedia.org/wiki/Winter> (average January temperatures
>>are in the range −8 °C to −2 °C) to cool and moist
>>summers<http://en.wikipedia.org/wiki/Summer>(average temperature 15 °C
>>to 20 °C)."
>>
>>Actually, last days it was very cooooold - even about -30C. This happens
>>from time to time but very rare (once in a few years or so) and it's not
>>considered as something normal here. e.g. schools were closed a few last
>>days when the temperature was below -25. Actually, the weather is getting
>>crazy last years and not only here :)
>>
>>[1] http://www.microsoft.com/whdc/system/sysperf/apic.mspx
>>
>>>
>>--
>>Best regards,
>>Dmitry Adamushko
>>
> 
> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

