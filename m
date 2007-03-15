Subject: Re: [Xenomai-help] HPET timer
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200703151521.58317.jweber@domain.hid>
References: <200703151521.58317.jweber@domain.hid>
Content-Type: text/plain
Date: Thu, 15 Mar 2007 23:52:42 +0100
Message-Id: <1173999162.8193.65.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

On Thu, 2007-03-15 at 15:21 -0500, Jeff Weber wrote:
> I found the advisory against using the HPET timer in the wiki FAQ, and disabled both
> 	CONFIG_HPET_TIMER
> 	CONFIG_HPET_EMULATE_RTC
> 
> in my kernel config.  Now I am having intermittent faults reading the TSC on my x86 CPU.
> Occasionally, reads of the TSC go backwards.  The tracer also shows one of my Xenomai
> kernel threads going into an infinite loop reading the TSC:
> 
> :|  +*end     0xffffff05  -798    0.675  common_interrupt+0x34 (do_gettimeofday+0x59)
> :   +*func                -797    0.585  get_offset_tsc+0x8 (do_gettimeofday+0x2a)
> :   +*func                -797    0.571  get_offset_tsc+0x8 (do_gettimeofday+0x2a)
> :   +*func                -796    0.496  get_offset_tsc+0x8 (do_gettimeofday+0x2a)
> ...
> ad infinitum
> 
> This behavior runs contrary to all the Xenomai configuration advice.  I would like
> to keep the HPET timer disabled so I can eventually upgrade to Xenomai-2.3.
> 
> Any idea on what's happining with my HPET timer?
> 

Not yet. I still don't find anything in the HPET support code that would
particularly confuse the I-pipe, but nonetheless, it has been reported
that CONFIG_HPET_TIMER did break some configurations when enabled.
I still need to check this on proper hardware and find out why.

> config:
> linux-2.6.17.14
> ipipe-1.5-00
> xenomai-2.2.4
> cpu = VIA Nehemiah
> flags = fpu vme de pse tsc msr cx8 sep mtrr pge cmov pat mmx fxsr sse up rng rng_en ace ace_en
> motherboard:  Hercules EBX
> kernel config:
> # CONFIG_M586TSC is not set
> CONFIG_X86_TSC=y
> # CONFIG_HPET_TIMER is not set
> 
> 	thanks,
-- 
Philippe.



