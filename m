Message-ID: <47C27C3F.9080307@domain.hid>
Date: Mon, 25 Feb 2008 09:28:47 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <47BF446E.50300@domain.hid> <47C02848.70604@domain.hid>
	<47C0819E.8040000@domain.hid> <47C27772.1060005@domain.hid>
In-Reply-To: <47C27772.1060005@domain.hid>
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
>> Jan Kiszka wrote:
>>> Wolfgang Grandegger wrote:
>>>> Hello,
>>>>
>>>> I'm proud to announce "gpioirqbench", a benchmark tool to measure
>>>> external interrupt latencies. It is derived from Jan's irqbench [1] for
>>>> the PC. Instead of using the serial or parallel port, it uses GPIO pins
>>>> on embedded systems. It measures the time between the generation of an
>>>> interrupt triggered by a GPIO pin and the reply by either the interrupt
>>>> service routine, a kernel-space task or a user-space task. As reply,
>>>> another GPIO pin will be toggled. The setup consists of two systems,
>>>> the
>>>> log host and the test target. The log host triggers the interrupt on
>>>> the
>>>> test target and measures the latency. This benchmark is primarily for
>>>> Xenomai/RTDM, but it can also be used for plain Linux or even Linux-rt
>>>> (with the real-time preemption patch).
>>> Nice stuff! Still I have a few conceptual questions: :->
>>
>> I did expect them ;-).
>>
>>> 1. Why do you need a Xenomai measurement host? On first glance, you are
>>>    just spinning on the reply for the RT target. Why not use plain Linux
>>>    for this to increase portability? Most beautiful would be a pure
>>>    userspace approach like for irqbench. What prevents this here?
>>
>> Well, I'm not a hardware expert and therefore it was not obvious to me
>> how to connect GPIO pins to the standard PC. To avoid electrical
>> incompatibilities, I chose my good old TQM855L module as log host.
>> I agree, that this solution is rather special and that the one for
>> irqbench would be much better. Any ideas how to interface GPIO pins with
>> the PC?
> 
> Misunderstanding: I'm not talking about porting the host part to a PC,
> that is a different thing and surely involves some hardware work (unless
> the PC board already has compatible IO ports). I was talking about
> running the host part on _plain_ Linux on whatever arch providing the IO
> hardware, and maybe also running it without a kernel helper (by poking
> directly into to IO - if that is feasible). Latency-wise there is no
> need for a RTOS on the host side as you run the critical part with IRQs
> disabled.

A "good" processor does *not* allow to enable/disable interrupts in
user-space. Therefore a pure user-space solution with interrupts
disabled is not possible on PowerPC. My first idea was to use a software
independent hardware timer and to stop it by an external signal (in
capture mode). Nevertheless, using a standard PC as log host is still
attractive. Maybe there are some cheap GPIO-PCI cards avaliable.

>>
>>> 2. Do you see a chance to integrate the target'S GPIO interface into the
>>>    exiting irqbench backend? That would make it easy to merge the
>>>    Xenomai version into the tree.
>>
>> In the end I preferred to make a separated distribution, as various
>> parts are very hardware specific and the driver can also be built as
>> normal Linux character device driver.
> 
> I don't want to replace your distribution, I want to enhance the Xenomai
> benchmark that comes with the releases. And maybe I also want to trigger
> the development of more standard benchmark tools (compatible kernel/user
> APIs on the targets, reusable host-side tools). :)

Yep.

Wolfgang.

