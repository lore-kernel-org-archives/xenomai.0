MIME-Version: 1.0
In-Reply-To: <4D752CDB.5030904@domain.hid>
References: <AANLkTik7MKLjvrZY1BsowqBtodJoP7fUt6--H4WOS-W4@domain.hid>
	<4D74975F.4050009@domain.hid> <4D74C683.1020904@domain.hid>
	<AANLkTi=0kGcZwfTesBKbQ9u6OedaUU8vsMogAbhYceN+@mail.gmail.com>
	<4D752CDB.5030904@domain.hid>
Date: Mon, 7 Mar 2011 16:18:34 -0500
Message-ID: <AANLkTimnZRTFO3u1bn2b+8PfGhnf9XZNKUvpCtwA4Mvc@domain.hid>
From: Eric Eric <ericrebates@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Mar 7, 2011 at 2:07 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Eric Eric wrote:
>> OK, it looks like I would basically have to replace gpioirq-hw.h
>> bare-bones GPIO driver for the beagle to get this to work. =A0Other than
>> that, am I correct that the hardware configuration would be two boards
>> connected to each other using two GPIO pins for trigger and response?
>
> Well, the gpiolib functions are safe to be used from real-time domain.

Hmm, it looked like gpioirqbench went through some pain to -not- use
gpiolib and to manually configure and operate the hardware, so I
assumed this was not safe.  It's certainly a more pleasant task using
gpiolib.  It does beg the question why gpioirqbench isn't doing this.

>
>>
>> On a related note, I'm trying to figure out what exactly the latency
>> program measures. =A0From the code, it looks like it's measuring timer
>> jitter and latency (ie it registers a timer for 1mS from now, the when
>> the timer fires the timer procedure records how far current time is
>> from the requested fire time). =A0Is this correct?
>
> It is measuring the user-space thread, kernel-space thread, or
> kernel-space timer interrupt latency depending on whether you use -t0,
> -t1, or -t2. If prior to running the latency test you do:
> echo 0 > /proc/xenomai/latency
> the measured latency is the same as what the latency will be for any
> interrupt, not just the timer, with the exception of the GPIO demuxed
> interrupts, which should have slightly larger latencies, due to the fact
> that they need to be decoded.

Right, but is it possible to discern actual latency from timer
hardware jitter?  Or is this particular timer of sufficient precision
that the jitter is orders of magnitude lower than the latency?

>
> On omap3530, the user-space worst case user-space scheduling latency
> should be around 55us at 1kHz, and 35us at 10kHz, if you use the
> user-space tsc emulation. I still have not tested the 3730.

This seems consistent with my results, assuming I'm using 1kHZ.  Are
you referring to CONFIG_XENO_OPT_TIMING_VIRTICK here?

>
>>
>> Lastly, I'm trying to get some idea of context switch latency. =A0I see
>> a man page for "switchbench" but can't seem to find code or binaries
>> for switchbench. =A0Any ideas? =A0I've been using switchtest instead. =
=A0It
>> seems like switchtest fires up a bunch of threads and measure how man
>> context switches it can do among them. =A0On my board, I see about
>> 10,000/sec. =A0Is this equivalent to a 100uS context switch time? =A0May=
be
>> it's a stupid question, but something tells me these two things may
>> not be equivalent.
>
> No, switchtest sleeps from time to time, so, the count of context
> switches does not mean anything. The aim of switchtest is rather to
> stress the machine with many context switches, including testing FPU
> switches, in order to find errors in these routines. Note that the worst
> case user-space thread scheduling latency path includes a context
> switch, so, the context switch time can not be larger than the result
> given by the "latency" test.
>
> switchbench was been renamed wakeup-time so time ago.

Got it, it may be worth filing a bug to rename the man page.  My
results were 24/26/46uS, which seems consistent with my other results
and with your advice.

Thanks again.

- Eric

>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

