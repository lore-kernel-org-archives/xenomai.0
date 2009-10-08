Message-ID: <4ACDA5A9.6070408@domain.hid>
Date: Thu, 08 Oct 2009 10:41:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580910080127k766f2407o317ae8a2ce088b4a@domain.hid>
In-Reply-To: <1f3e02580910080127k766f2407o317ae8a2ce088b4a@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Support for ARCH_MV88F6290
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Didenko Sergey <didenkos@domain.hid>
Cc: xenomai@xenomai.org

Didenko Sergey wrote:
> Dear Xenomai Experts,
> 
> So far I did not progress too much.
> 
> What I have now is that patched Linux is starting to boot as original
> kernel and it hangs right after line
> [42949373.240000] ata1: SATA max UDMA/133 irq 27
> As you can see after line
> 
> [42949373.230000] ?^<6>Xenomai: real-time nucleus v2.4.9.1 (Big Bad
> Moon) loaded.
> 
> System does not go to timer_interrupt() function any more.

That is expected. Once Xenomai runs, it takes over the timer interrupt.

> 
> What I'm worring about is that the system has 2 timers, one is
> free-running with disabled interrupts, second one is interrupt-driven
> clockevent timer.

No problem. Use the clockevent timer for hardware timer, use the
free-running counter for tsc emulation.

> 
> =========================== Code - Start
> (...)
> =========================== Code - End
> 
> According to HOWTO Xenomai needs free-running counter, in my case it is
> Timer 0, but all functions are configured to work with Timer 1, which is
> not free running.
> 
> What would you sugest to do?

No, the howto does not say that you need a free-running counter. It
shows the example of a free-running counter and tell you to look at the
integrator or s3cxxxx code if you want to know how to implement the
I-pipe support for a decrementer. The reason being that I wrote the
howto, and I never had to work with a decrementer.

If you really want us to help you should show us the code that you
added, not the code that we can already find in the linux kernel sources.

-- 
                                          Gilles


