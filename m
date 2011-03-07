Message-ID: <4D754DD5.3010006@domain.hid>
Date: Mon, 07 Mar 2011 22:27:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik7MKLjvrZY1BsowqBtodJoP7fUt6--H4WOS-W4@domain.hid>	<4D74975F.4050009@domain.hid>	<4D74C683.1020904@domain.hid>	<AANLkTi=0kGcZwfTesBKbQ9u6OedaUU8vsMogAbhYceN+@mail.gmail.com>	<4D752CDB.5030904@domain.hid>
	<AANLkTimnZRTFO3u1bn2b+8PfGhnf9XZNKUvpCtwA4Mvc@domain.hid>
In-Reply-To: <AANLkTimnZRTFO3u1bn2b+8PfGhnf9XZNKUvpCtwA4Mvc@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] irqloop hangs on Beagleboard ARM with
	2.5.5.2/2.6.33
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Eric <ericrebates@domain.hid>
Cc: xenomai@xenomai.org

Eric Eric wrote:
> On Mon, Mar 7, 2011 at 2:07 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> Eric Eric wrote:
>>> OK, it looks like I would basically have to replace gpioirq-hw.h
>>> bare-bones GPIO driver for the beagle to get this to work.  Other than
>>> that, am I correct that the hardware configuration would be two boards
>>> connected to each other using two GPIO pins for trigger and response?
>> Well, the gpiolib functions are safe to be used from real-time domain.
> 
> Hmm, it looked like gpioirqbench went through some pain to -not- use
> gpiolib and to manually configure and operate the hardware, so I
> assumed this was not safe.  It's certainly a more pleasant task using
> gpiolib.  It does beg the question why gpioirqbench isn't doing this.

The reason is historical.

> 
>>> On a related note, I'm trying to figure out what exactly the latency
>>> program measures.  From the code, it looks like it's measuring timer
>>> jitter and latency (ie it registers a timer for 1mS from now, the when
>>> the timer fires the timer procedure records how far current time is
>>> from the requested fire time).  Is this correct?
>> It is measuring the user-space thread, kernel-space thread, or
>> kernel-space timer interrupt latency depending on whether you use -t0,
>> -t1, or -t2. If prior to running the latency test you do:
>> echo 0 > /proc/xenomai/latency
>> the measured latency is the same as what the latency will be for any
>> interrupt, not just the timer, with the exception of the GPIO demuxed
>> interrupts, which should have slightly larger latencies, due to the fact
>> that they need to be decoded.
> 
> Right, but is it possible to discern actual latency from timer
> hardware jitter?  Or is this particular timer of sufficient precision
> that the jitter is orders of magnitude lower than the latency?

I would expect the timer to have a very small jitter. Since it is
multi-MHz, it would be a bit awkward if it had a latency greater than 1us.

Anyway, it is true that we have a small uncertainty here, due to the
fact that we are treating all timers as if they were decrementers, so,
we are computing a delay, then programming it a bit later, trying to
account for the programming latency of the timer, whereas the omap3
timer, like many timers, at least on ARM, is a free-running counter with
a match registers, so that we could get really precise programming.

But this should account for 1 or 2us uncertainty, still far from 55us.
One day, we will fix this...

> 
>> On omap3530, the user-space worst case user-space scheduling latency
>> should be around 55us at 1kHz, and 35us at 10kHz, if you use the
>> user-space tsc emulation. I still have not tested the 3730.
> 
> This seems consistent with my results, assuming I'm using 1kHZ.  Are
> you referring to CONFIG_XENO_OPT_TIMING_VIRTICK here?

I am referring to --enable-arm-mach=omap3 passed to Xenomai user-space
compilation configure script (which automatically enables --enable-arm-tsc).

>> No, switchtest sleeps from time to time, so, the count of context
>> switches does not mean anything. The aim of switchtest is rather to
>> stress the machine with many context switches, including testing FPU
>> switches, in order to find errors in these routines. Note that the worst
>> case user-space thread scheduling latency path includes a context
>> switch, so, the context switch time can not be larger than the result
>> given by the "latency" test.
>>
>> switchbench was been renamed wakeup-time so time ago.
> 
> Got it, it may be worth filing a bug to rename the man page.  My
> results were 24/26/46uS, which seems consistent with my other results
> and with your advice.

We forgot the man-page, sorry.

-- 
                                                                Gilles.

