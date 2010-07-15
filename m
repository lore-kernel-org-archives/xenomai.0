Message-ID: <4C3EF86D.1050703@domain.hid>
Date: Thu, 15 Jul 2010 14:00:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <loom.20100714T170447-439@domain.hid>
In-Reply-To: <loom.20100714T170447-439@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Does this config optimally fit my Hardware?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jmf <xeno.nonono@domain.hid>
Cc: xenomai@xenomai.org

jmf wrote:
> Dear all,
> 
> I've set up a Xenomai system with Ubuntu 10.04 32bit/2.6.32-21/2.5.3 and
> everything seems to be fine (I'm new to Linux and RT anyway). However, I'd like
> to make sure that the kernel config is optimally adapted to my hardware (Intel
> Atom board, 945GCLF2, 4 cores with Hyperthreading, one RT thread only runs
> on CPU 1, the others are free).
> 
> I'm especially unsure about the timers/clocks, whether 8254, TSC, the counter
> on the LAPIC or HPET will be used and what would be preferable (HPET rather
> than TSC?). Btw, on startup I also get "MT-Bios Bug: 8264 timer not connected
> to IO-APIC". Could anyone tell me if my config fits my hardware?

Xenomai only know two timer sources, the 8254 and the LAPIC. LAPIC is
better. The choice is made at compilation time. So, if LAPIC is enabled
and Xenomai works, it means that Xenomai is happily using the LAPIC and
that your configuration is optimal with regard to timer sources.

As for the clock sources, the two possible ar 8254 and TSC. Again, if
your kernel has TSC enabled and Xenomai starts, it means that it is
using it.

So, the reste of the options (HPET, etc...) only affect non real-time
processes.

> 
> User-space support with default options:
> 
> --enable-x86-tsc TRUE
> --enable-smp FALSE

You can probably enable --enable-x86-sep for better performances.

> 
> Kernel config:
> 
> CONFIG_HPET_TIMER y (HPET enabled in BIOS)
> CONFIG_HIGH_RES_TIMERS y
> CONFIG_XENO_HW_SMI_WORKAROUND y

Ok. Be sure that this option does not cause any problem before
activating it (see the TROUBLESHOOTING guide).

If you are worried about performances, please be sure to disable any
Xenomai and I-pipe debugging options.

> CONFIG_SMP y
> CONFIG_CPU_FREQ false ("# CONFIG_CPU_FREQ is not set")
> CONFIG_APM false ("# CONFIG_APM is not set")
> CONFIG_ACPI_PROCESSOR false ("# CONFIG_ACPI_PROCESSOR is not set")
> CONFIG_ACPI y
> CONFIG_SCHED_SMT y
> CONFIG_INPUT_PCSPKR m (?)
> CONFIG_PCSPKR_PLATFORM y
> CONFIG_X86_LOCAL_APIC y
> CONFIG_X86_IO_APIC y
> CONFIG_X86_TSC y
> 
> (tell me when I should post the complete config file)


-- 
					    Gilles.

