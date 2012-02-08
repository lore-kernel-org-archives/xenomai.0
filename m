Message-ID: <4F3267A9.9060001@domain.hid>
Date: Wed, 08 Feb 2012 13:16:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMak2D-YfDCvjbZiLFYGntYdDCJVPiYtwt5z8k=PPT-9yj3S5A@mail.gmail.com>	<4F3141D2.7000605@domain.hid>
	<CAMak2D_YWa_Dta3q8-E1yCq08a8bZ3Vm2FdHac8Ee=zcgh9emg@domain.hid>
In-Reply-To: <CAMak2D_YWa_Dta3q8-E1yCq08a8bZ3Vm2FdHac8Ee=zcgh9emg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] in-kernel periodic task latencies caused by
	dohell
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

On 02/08/2012 01:25 AM, Eric Eric wrote:
> Thanks, Gilles.  I enabled ipipe tracing but am a bit confused by what
> it's telling me.  What I would like to do is generate a trace during
> the timed section of the benchmark, and not anywhere else.  Looking at
> the output, it seems max and frozen contain traces of the longest path
> to date.  It's not clear to me how this maps to my benchmark
> latencies.  For example, I can sample max and/or frozen and add up the
> latency column and see them seemingly randomly exceed each other
> regardless of whether dohell is running.

The idea is to run latency with the -f option so that when you hit the
maximum with whatever load you are interested in, it is recorded. Be
aware though, that the tracer adds some overhead, so for instance your
24us latency may well turn into a 50us latency when run with the tracer.

> 
> Looking at http://www.xenomai.org/index.php/Xenomai:I-pipe_Tracer#API
> I see there are calls like xntrace_user_start and xntrace_user_stop.
> Is it possible to wrap the timed parts of the benchmarks with calls
> like this to get a more informative trace?

I do not really understand your problem. If you know that you hit the
maximum latency while running the cat /proc/interrupts loop, then
latency -f should do just fine.

> 
> Also, do you think the latency degradation may be due to the VIVT
> cache on the ARM?  I'm specifically referring to additional latency
> due to different address spaces when switching between Linux user-mode
> and Xenomai kernel.
> 

As I said, the fact that the maximum happens with cat /proc/interrupts
probably has nothing to do with kernel/user switches, as there are also
a lot of them with dd if=/dev/zero of=/dev/null. As for cache issues,
yes, most of the time latencies are due to cache issues, but OMAP3 does
not have a VIVT cache. Also note that to have a precise idea of the
worst case latency with some load, you should let the test run a lot of
time, sometimes the worst case takes time to happen.


-- 
                                                                Gilles.

