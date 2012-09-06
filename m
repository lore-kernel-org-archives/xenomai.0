Message-ID: <50484FCA.50909@xenomai.org>
Date: Thu, 06 Sep 2012 09:24:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] RFC: slow tsc optimization
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <Xenomai@xenomai.org>


Hi,

The last few days, I have been working on getting the "rdtsc"
instruction replaced with a call to a tsc emulation function dynamically
at run time. It turned out to be easy with the Linux "alternative"
mechanism, since it implements replacements based on CPU capabilities,
and the TSC is such a capability. This modification allows to compile a
kernel with Xenomai that will run on any x86_32 platform.

Now, when running kernels without tsc using the PIT based tsc emulation,
I found out something pretty obvious, this PIT based tsc emulation is
slow, it takes 4us every time we call it. And the nucleus reads the tsc
a number of times when a timer interrupt happens up to the wake up of
the latency user-space task:
- at the very beginning of the timer interrupt
- after the execution of the latency thread timer
- in the timer programming function, to compute the timer delay
- in the middle of the context switch, if the "statistics collection"
feature is enabled
- in the xnpod_wait_thread_periodic function, after the context switch,
in order to compute the number of timer overruns.

That is 20us, and the thread is not yet running in user-space.

So, I have been thinking about reducing the number of calls to the PIT,
unfortunately keeping the last tsc value around and reusing it is a bit
heavy, and implies modifications which are completely useless for the
non PIT case (which should be the vast majority), and in fact, the tsc
emulation code has to keep the last read value, since it is required to
convert clocksources with less than 64 bits to a 64 bits value. So, I
propose the following approach:

The I-pipe core will provide two tsc reading functions:
ipipe_read_tsc which reads the counter
ipipe_read_tsc_fast which will read the tsc if the cpu has a tsc, or
return the last value read if the tsc is emulated.

This would result in lighter modifications of the nucleus.

Or is treating this problem in fact useless because nobody uses xenomai
without a tsc?

Regards.

-- 
                                                                Gilles.

