Message-ID: <4667D167.9030001@domain.hid>
Date: Thu, 07 Jun 2007 11:35:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7289437c0706060801i299d6881w31cc5ffee3444ace@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01FAF561@domain.hid>	<1181143109.17978.101.camel@domain.hid>	<7289437c0706062254v2a386894oeb498459877d5086@domain.hid>	<4667AA4D.6070505@domain.hid>	<7289437c0706070042gf4346ddj1c4ee3ac20a068d2@domain.hid>
	<4667BBBE.1040405@domain.hid> <4667CEF2.2050509@domain.hid>
	<4667D008.80109@domain.hid>
In-Reply-To: <4667D008.80109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Cyclictest
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
Cc: xenomai-help <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Perrine Martignoni wrote:
>>>
>>>
>>>>Ok. I'll do this.
>>>>
>>>>But I don't understand why the same application compiled without any links
>>>>with Xenomai give different results if there is Xenomai in the kernel.
>>>
>>>[Looking at your numbers again] Hmm, maybe some rounding issue of ticks
>>>due to whatever side-effect of I-pipe. We would first of all need the
>>>usual set of information (.config, involved versions) and also
>>>/sys/devices/system/clocksource/clocksource0/current_clocksource.
>>
>>Maybe what Perrine is observing is simply the overhead of the I-pipe ?
>>I mean, Linux is Xenomai idle task, so it is acceptable for Linux
>>numbers to be a bit worse than when Xenomai is not running.
> 
> 
> I bit worse is expected. But I think we are seeing 1 or 2 ticks wake-up
> delays here. As far as I understood, they are not due to Xenomai
> consuming significant cycles in the background, are they, Perrine?

What I see is latencies 5us longer. 5us on ARM is almost nothing, keep
in mind that a simple syscall on ARM already takes 10 us.

-- 
                                                 Gilles Chanteperdrix

