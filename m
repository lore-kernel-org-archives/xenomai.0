Message-ID: <49ECBEE6.2060201@domain.hid>
Date: Mon, 20 Apr 2009 20:28:54 +0200
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
>     or the kernel. I couldn't get it to freeze this time during the
>     latency tests.
> 
>     Is there anything else that I need to do to get the watchdog to
>     do something?

The watchdog is probably working. The fact that you get the problem with
the interrupt pipeline enabled but not Xenomai proves that the culprit
is not Xenomai's timer interception. So, what probably happens is that
only Linux' timer is not working when you experience "hang ups". You can
check that by checking the irqs count in /proc/xenomai/irq when latency
is running.

In any case, you should run without NO_HZ and should try to disable high
res timers to see if it helps further.

> I believe that today I will finally receive the new computers that I
> ordered. So hopefully these problems won't turn up again on them.
> Regardless, I would have liked to have figured out what the problem
> was, just in case it is something serious that just happens less often
> on newer computers.

Well, trying to solve an issue which happens on a machine with faulty
RAM is not really interesting. So, unless you are able to test the same
machine with working RAM, I would suggest to stop spending time on this
issue.

-- 
					    Gilles.

