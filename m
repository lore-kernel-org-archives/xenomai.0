Message-ID: <504B9CCD.9030701@xenomai.org>
Date: Sat, 08 Sep 2012 21:30:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50484FCA.50909@xenomai.org> <5049DA96.90200@xenomai.org>
In-Reply-To: <5049DA96.90200@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RFC: slow tsc optimization
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <Xenomai@xenomai.org>

On 09/07/2012 01:29 PM, Gilles Chanteperdrix wrote:

> On 09/06/2012 09:24 AM, Gilles Chanteperdrix wrote:
> 
>>
>> Hi,
>>
>> The last few days, I have been working on getting the "rdtsc"
>> instruction replaced with a call to a tsc emulation function dynamically
>> at run time. It turned out to be easy with the Linux "alternative"
>> mechanism, since it implements replacements based on CPU capabilities,
>> and the TSC is such a capability. This modification allows to compile a
>> kernel with Xenomai that will run on any x86_32 platform.
>>
>> Now, when running kernels without tsc using the PIT based tsc emulation,
>> I found out something pretty obvious, this PIT based tsc emulation is
>> slow, it takes 4us every time we call it. And the nucleus reads the tsc
>> a number of times when a timer interrupt happens up to the wake up of
>> the latency user-space task:
>> - at the very beginning of the timer interrupt
>> - after the execution of the latency thread timer
>> - in the timer programming function, to compute the timer delay
>> - in the middle of the context switch, if the "statistics collection"
>> feature is enabled
>> - in the xnpod_wait_thread_periodic function, after the context switch,
>> in order to compute the number of timer overruns.
>>
>> That is 20us, and the thread is not yet running in user-space.
>>
>> So, I have been thinking about reducing the number of calls to the PIT,
>> unfortunately keeping the last tsc value around and reusing it is a bit
>> heavy, and implies modifications which are completely useless for the
>> non PIT case (which should be the vast majority), and in fact, the tsc
>> emulation code has to keep the last read value, since it is required to
>> convert clocksources with less than 64 bits to a 64 bits value. So, I
>> propose the following approach:
>>
>> The I-pipe core will provide two tsc reading functions:
>> ipipe_read_tsc which reads the counter
>> ipipe_read_tsc_fast which will read the tsc if the cpu has a tsc, or
>> return the last value read if the tsc is emulated.
> 
> 
> An update on this work. In fact the "read_tsc_fast" should be the most
> common operation, and really reading the PIT counter is not. And reading
> the slow tsc should be made at some critical points so that the fast_tsc
> is reasonably accurate. So, in fact I implemented:
> ipipe_read_tsc, which returns the last tsc value, and is replaced with
> rdtsc when available
> ipipe_read_slow_tsc, which reads the emulated tsc, and is also replaced
> with rdtsc when available,
> ipipe_touch_tsc, which reads the emulated tsc, but is replaced with a
> nop when rdtsc is available.
> 
> Now, the real remaining problem is where to use
> ipipe_touch_tsc/ipipe_read_slow_tsc, to have a rasonable accuracy, but
> not read the hardware tsc too often.
> 
> I implemented the following approach: the tsc is read at every entry
> point of the nucleus, that is: interrupts, xenomai syscalls, events for
> xenomai tasks. We also need to reread the tsc before programming the
> next shot, in order to avoid programming too long delays (with a restart
> of xntimer_tick_aperiodic if we find out that the delay is too short,
> instead of going through another irq). All in all, these are fairly
> lightweight modifications, and the latency test seems reasonable. Even
> on a kernel with statistics collection enabled. I suspect the statistics
> are a bit off, but at least they are there.
> 
> Since we read the tsc twice per interrupt, and reading it takes 4us, the
> minimum latency is around 8us, I thought about including the tsc latency
> (twice) into the nktimerlat latency, but this results in negative
> latencies, and anyway, we should leave the choice to the user to do that
> with /proc/xenomai/latency if he wants.
> 
> Now the remaining issues are:
> - kernel-space code. We can trap insmod/rmmod in losyscall, but if an
> RTDM driver ioctl method takes a long time to execute, or when a
> kernel-space thread runs long tasks before calling xenomai services, it
> may use old clock data
> - the time of a syscall is always at least 4us. That is a bit stupid
> when, say, for instance you want to lock a mutex, to read the tsc, lock
> the mutex, then return to user space. Working this around seems
> complicated. We could for instance add a "NOTSC" syscall flag to
> indicate that the tsc should not be read before a syscall callback, but
> modifying correctly the syscall tables to add this flag to the proper
> syscalls is probably not so easy. For instance, when statistics
> collection is enabled, we want to read the tsc before locking the mutex,
> since if there is a context switch, we will need the value for updating
> the statistics.
> 


Some benchmarks on atom. In the second try "pit, one read", we do not
re-read the emulated tsc before programming the timer, we avoid loosing
4us, at the expense of the precision of the timer tick.

http://sisyphus.hd.free.fr/~gilles/core-3.4-latencies/atom2.png

-- 
                                                                Gilles.

