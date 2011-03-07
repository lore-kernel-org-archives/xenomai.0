Message-ID: <4D752CDB.5030904@domain.hid>
Date: Mon, 07 Mar 2011 20:07:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTik7MKLjvrZY1BsowqBtodJoP7fUt6--H4WOS-W4@domain.hid>	<4D74975F.4050009@domain.hid>	<4D74C683.1020904@domain.hid>
	<AANLkTi=0kGcZwfTesBKbQ9u6OedaUU8vsMogAbhYceN+@mail.gmail.com>
In-Reply-To: <AANLkTi=0kGcZwfTesBKbQ9u6OedaUU8vsMogAbhYceN+@mail.gmail.com>
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
> OK, it looks like I would basically have to replace gpioirq-hw.h
> bare-bones GPIO driver for the beagle to get this to work.  Other than
> that, am I correct that the hardware configuration would be two boards
> connected to each other using two GPIO pins for trigger and response?

Well, the gpiolib functions are safe to be used from real-time domain.

> 
> On a related note, I'm trying to figure out what exactly the latency
> program measures.  From the code, it looks like it's measuring timer
> jitter and latency (ie it registers a timer for 1mS from now, the when
> the timer fires the timer procedure records how far current time is
> from the requested fire time).  Is this correct?

It is measuring the user-space thread, kernel-space thread, or
kernel-space timer interrupt latency depending on whether you use -t0,
-t1, or -t2. If prior to running the latency test you do:
echo 0 > /proc/xenomai/latency
the measured latency is the same as what the latency will be for any
interrupt, not just the timer, with the exception of the GPIO demuxed
interrupts, which should have slightly larger latencies, due to the fact
that they need to be decoded.

On omap3530, the user-space worst case user-space scheduling latency
should be around 55us at 1kHz, and 35us at 10kHz, if you use the
user-space tsc emulation. I still have not tested the 3730.

> 
> Lastly, I'm trying to get some idea of context switch latency.  I see
> a man page for "switchbench" but can't seem to find code or binaries
> for switchbench.  Any ideas?  I've been using switchtest instead.  It
> seems like switchtest fires up a bunch of threads and measure how man
> context switches it can do among them.  On my board, I see about
> 10,000/sec.  Is this equivalent to a 100uS context switch time?  Maybe
> it's a stupid question, but something tells me these two things may
> not be equivalent.

No, switchtest sleeps from time to time, so, the count of context
switches does not mean anything. The aim of switchtest is rather to
stress the machine with many context switches, including testing FPU
switches, in order to find errors in these routines. Note that the worst
case user-space thread scheduling latency path includes a context
switch, so, the context switch time can not be larger than the result
given by the "latency" test.

switchbench was been renamed wakeup-time so time ago.

-- 
					    Gilles.

