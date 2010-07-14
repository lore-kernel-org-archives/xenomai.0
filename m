From: jmf <xeno.nonono@domain.hid>
Date: Wed, 14 Jul 2010 16:10:32 +0000 (UTC)
Message-ID: <loom.20100714T170447-439@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Does this config optimally fit my Hardware?
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

Dear all,

I've set up a Xenomai system with Ubuntu 10.04 32bit/2.6.32-21/2.5.3 and
everything seems to be fine (I'm new to Linux and RT anyway). However, I'd like
to make sure that the kernel config is optimally adapted to my hardware (Intel
Atom board, 945GCLF2, 4 cores with Hyperthreading, one RT thread only runs
on CPU 1, the others are free).

I'm especially unsure about the timers/clocks, whether 8254, TSC, the counter
on the LAPIC or HPET will be used and what would be preferable (HPET rather
than TSC?). Btw, on startup I also get "MT-Bios Bug: 8264 timer not connected
to IO-APIC". Could anyone tell me if my config fits my hardware?

User-space support with default options:

--enable-x86-tsc TRUE
--enable-smp FALSE

Kernel config:

CONFIG_HPET_TIMER y (HPET enabled in BIOS)
CONFIG_HIGH_RES_TIMERS y
CONFIG_XENO_HW_SMI_WORKAROUND y
CONFIG_SMP y
CONFIG_CPU_FREQ false ("# CONFIG_CPU_FREQ is not set")
CONFIG_APM false ("# CONFIG_APM is not set")
CONFIG_ACPI_PROCESSOR false ("# CONFIG_ACPI_PROCESSOR is not set")
CONFIG_ACPI y
CONFIG_SCHED_SMT y
CONFIG_INPUT_PCSPKR m (?)
CONFIG_PCSPKR_PLATFORM y
CONFIG_X86_LOCAL_APIC y
CONFIG_X86_IO_APIC y
CONFIG_X86_TSC y

(tell me when I should post the complete config file)


