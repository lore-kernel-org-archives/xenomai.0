Message-ID: <47C0819E.8040000@domain.hid>
Date: Sat, 23 Feb 2008 21:27:10 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <47BF446E.50300@domain.hid> <47C02848.70604@domain.hid>
In-Reply-To: <47C02848.70604@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gpioirqbench: measuring external interrupt
	latencies
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
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> I'm proud to announce "gpioirqbench", a benchmark tool to measure
>> external interrupt latencies. It is derived from Jan's irqbench [1] for
>> the PC. Instead of using the serial or parallel port, it uses GPIO pins
>> on embedded systems. It measures the time between the generation of an
>> interrupt triggered by a GPIO pin and the reply by either the interrupt
>> service routine, a kernel-space task or a user-space task. As reply,
>> another GPIO pin will be toggled. The setup consists of two systems, the
>> log host and the test target. The log host triggers the interrupt on the
>> test target and measures the latency. This benchmark is primarily for
>> Xenomai/RTDM, but it can also be used for plain Linux or even Linux-rt
>> (with the real-time preemption patch).
> 
> Nice stuff! Still I have a few conceptual questions: :->

I did expect them ;-).

> 1. Why do you need a Xenomai measurement host? On first glance, you are
>    just spinning on the reply for the RT target. Why not use plain Linux
>    for this to increase portability? Most beautiful would be a pure
>    userspace approach like for irqbench. What prevents this here?

Well, I'm not a hardware expert and therefore it was not obvious to me
how to connect GPIO pins to the standard PC. To avoid electrical
incompatibilities, I chose my good old TQM855L module as log host.
I agree, that this solution is rather special and that the one for
irqbench would be much better. Any ideas how to interface GPIO pins with
the PC?

> 2. Do you see a chance to integrate the target'S GPIO interface into the
>    exiting irqbench backend? That would make it easy to merge the
>    Xenomai version into the tree.

In the end I preferred to make a separated distribution, as various
parts are very hardware specific and the driver can also be built as
normal Linux character device driver.

Wolfgang.

