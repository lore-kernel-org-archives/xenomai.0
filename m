Message-ID: <49ECC04C.10708@domain.hid>
Date: Mon, 20 Apr 2009 20:34:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0904201026330.23588@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904201026330.23588@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Tests with 2.5rc1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai@xenomai.org

Martin Shepherd wrote:
> Over the weekend I experimented with Xenomai 2.5-rc1. Unfortunately
> the freeze problems that I have been experiencing continued with this
> update. I have tried a lot of things to home in on the problem.
> 
> 1. First I tried swapping memory sticks again, but the symtoms
>     didn't change.
> 
> 2. Then I tried enabling the local-APIC and NMI watchdog at compile
>     time with a threshold of 200us, and set lapic=1 and nmi_watchdog=2
>     on the kernel invokation line in grub. The following messages from
>     dmesg showed that this was being picked up:
> 
>     [    0.000000] Local APIC disabled by BIOS -- reenabling.
>     [    0.000000] Found and enabled local APIC!
>     [    0.000000] mapped APIC to ffffb000 (fee00000)
>     ...
>     [    0.029054] Using local APIC timer interrupts.
>     [    0.029057] calibrating APIC timer ...
>     [    0.032000] ... lapic delta = 1250114
>     [    0.032000] ... PM timer delta = 357974
>     [    0.032000] ... PM timer result ok
>     [    0.032000] ..... delta 1250114
>     [    0.032000] ..... mult: 53688631
>     [    0.032000] ..... calibration result: 800072
>     [    0.032000] ..... CPU clock speed is 850.0310 MHz.
>     [    0.032000] ..... host bus clock speed is 200.0072 MHz.
>     ...
>     [    0.140956] Xenomai: NMI watchdog started (threshold=200 us).
> 
>     However this didn't seem to do anything whenever the system hung,
>     and I later unfroze it by moving the mouse, even though the system
>     clock lost seconds of time.  It froze many times during the
>     switchbench part of xeno-test, without any complaints from Xenomai

The freeze during switchbench is normal. There should be a message
telling you so and telling you not to try and interrupt switchbench.

-- 
					    Gilles.

