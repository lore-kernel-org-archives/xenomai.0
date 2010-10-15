Message-ID: <4CB84D5D.6090106@domain.hid>
Date: Fri, 15 Oct 2010 14:47:25 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4CB06CE9.9090204@domain.hid>	
	<1287070938.1628.20.camel@domain.hid>
	<4CB72B5D.1070304@domain.hid>
	<1287073013.1628.25.camel@domain.hid>
	<4CB743FA.20504@domain.hid> <4CB7482C.9060602@domain.hid>
	<4CB753EC.9010107@domain.hid> <4CB75976.6040302@domain.hid>
	<4CB7F73F.2050509@domain.hid> <4CB835DE.3060600@domain.hid>
In-Reply-To: <4CB835DE.3060600@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [forge] irqbench removal
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 10/15/2010 01:07 PM, Wolfgang Grandegger wrote:
> On 10/15/2010 08:39 AM, Jan Kiszka wrote:
>> Am 14.10.2010 21:26, Wolfgang Grandegger wrote:
>>> On 10/14/2010 09:03 PM, Jan Kiszka wrote:
>>>> Am 14.10.2010 20:13, Wolfgang Grandegger wrote:
>>>>> Hi Jan,
>>>>>
>>>>> On 10/14/2010 07:55 PM, Jan Kiszka wrote:
>>>>>> Am 14.10.2010 18:16, Philippe Gerum wrote:
>>>>>>> On Thu, 2010-10-14 at 18:10 +0200, Jan Kiszka wrote:
>>>>>>>> Am 14.10.2010 17:42, Philippe Gerum wrote:
>>>>>>>>> On Sat, 2010-10-09 at 15:23 +0200, Jan Kiszka wrote:
>>>>>>>>>> Philippe,
>>>>>>>>>>
>>>>>>>>>> irqbench does not inherently depend on a third I-pipe domain. It is a
>>>>>>>>>> useful testcase, the only in our portfolio that targets a peripheral
>>>>>>>>>> device use case. In fact, it was only of the first test cases for Native
>>>>>>>>>> RTDM IIRC.
>>>>>>>>>>
>>>>>>>>>> Please revert the removal and then cut out only the few parts that
>>>>>>>>>> actually instantiate an additional domain (i.e. mode 3.
>>>>>>>>>
>>>>>>>>> So, what do we do with this? Any chance we move to arch-neutral code for
>>>>>>>>> this test?
>>>>>>>>
>>>>>>>> Arch-neutral is impossible due to the inherent hardware dependency. But
>>>>>>>> I'm waiting on some comments by Wolfgang on their work as that's
>>>>>>>> probably the best requirements source for multi-arch support.
>>>>>>>
>>>>>>> I mean that the bulk of the code could be made arch-neutral, with only
>>>>>>> callouts to solve the arch-dependent/uart issues. Typically, 16550's are
>>>>>>> not uncommon on powerpc, but we obviously don't program them via
>>>>>>> ioports. A second level of indirection could provide the entire chip
>>>>>>> handling, to fit other uarts, maybe?
>>>>>>
>>>>>> If there are suitable UARTs around, refactoring the code accordingly and
>>>>>> maybe adding support for one of them as reference would be a good next
>>>>>> step. But first I would like to understand (or recall - I think Wolfgang
>>>>>> once explained it) the motivations for not going this path with the
>>>>>> gpiobench test and learn its requirements to avoid doing refactorings
>>>>>> twice or more.
>>>>>
>>>>> Well, it's a long time ago that I wrote gpioirqbench, which is derived
>>>>> from Jan's irqbench. Obviously, it uses GPIO pins to signal events
>>>>> instead of signals from the parallel port or serial line. I never
>>>>> supported the serial line for embedded boards.
>>>>
>>>> What was the reason? That it is too often blocked by a terminal?
>>>
>>> Mainly because there is no RTserial driver for the serial interface on
>>> the embedded boards, e.g. for the PSC, SCC. Furthermore, they are
>>> usually handled by firmware with ring buffers, dma, etc. which would
>>> introduce additional delays. They might be negligible, though.
>>>
>>>>> You can get the code with:
>>>>>
>>>>>   $ git clone git://git.denx.de/gpioirqbench
>>>>>
>>>>> It uses a simple hw abstruction layer defined in target/gpioirq-hw.h:
>>>>>
>>>>> http://git.denx.de/?p=gpioirqbench.git;a=blob;f=target/gpioirq-hw.h;h=76849da0964c7dbb6831fe02374922dcf89b3bb1;hb=HEAD
>>>>
>>>> Is this abstracting the target side, right?
>>>
>>> Yep.
>>>
>>>>> Don't know if it's generic enough to support the parallel and serial
>>>>> port interface as well. Anyway, with working generic GPIO lib support,
>>>>> it's quite simple to support new hardware, e.g. i.MX31 boards.
>>>>>
>>>>> The host side to measure precisely the latency is even more tricky.
>>>>
>>>> Depends. If you can map the GPIO output on something RS232 or parallel
>>>> port compatible, you are done. Usually, there is always some x86 box
>>>
>>> THe GPIO lines of most embedded boards don't like 5V. The are specified
>>> for 3.3V plus something less than 5V. I was thinking about that already
>>> but finally didn't want to damage the board. A 3.3V serial interface on
>>> the PC would be fine, though.
>>
>> Sounds like we just need a voltage divider for RS232 -> GPIO. The other
>> way should be fine as everything above 3 V is considered High, and I
>> think to remember that even the invalid range of +/-3 V is reported as
>> Low by typical (PC-)UARTs.
> 
> I just googled around a bit and found:
> 
>   http://www.rs232-converters.com/rs232-to_ttl3.3_converters.htm

Or at ebay: http://shop.ebay.at/i.html?_kw=ttl&_kw=converter

Wolfgang.

