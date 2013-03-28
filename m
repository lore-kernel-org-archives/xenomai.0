Message-ID: <51543FD9.6080707@gmail.com>
Date: Thu, 28 Mar 2013 14:04:25 +0100
From: Manuel Huber <manuel.h87@gmail.com>
MIME-Version: 1.0
References: <5148C728.6000101@gmail.com> <5148CEA9.7060700@xenomai.org>
	<515175FA.4030901@gmail.com> <51518D16.2050803@xenomai.org>
	<5154161F.8030608@gmail.com> <51543B8D.3000301@xenomai.org>
In-Reply-To: <51543B8D.3000301@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Decrease Latency (below 10 us) on x32 or x32_64?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 2013-03-28 13:46, Gilles Chanteperdrix wrote:
> On 03/28/2013 11:06 AM, Manuel Huber wrote:
>
>> On 2013-03-26 12:57, Gilles Chanteperdrix wrote:
>>> On 03/26/2013 11:18 AM, Manuel Huber wrote:
>>>
>>>> Hello!
>>>>
>>>> Sorry for the delay. I have re-compiled the Kernel with the I-pipe
>>>> tracer enabled, and I disabled the HPET. Then, I tried to reset the
>>>> tracer by writing 0 to /proc/ipipe/trace/frozen and some string to
>>>> /proc/ipipe/trace/max. Then I started the latency program with the -f
>>>> option for some minutes and afterwards captured the variables in
>>>> /proc/ipipe/trace/. One test has been made in single-user mode and
>>>> without the nouveau driver (plain-vga_300.txt) and the other trace has
>>>> been made in normal multi-user mode with gdm running (and the nouveau
>>>> driver; gui_300.txt). There is one trace without any USB-device
>>>> attached (plain-vga_300_no_usb.txt), but I'm not sure if that makes
>>>> any difference.
>>>>
>>>> I hope I used the I-pipe tracer correctly. I'm sorry to bother you
>>>> again, but I can't interpret the results :( Maybe you could interpret
>>>> the trace, if you have time for it...
>>> The traces are too short. Try:
>>> echo 1000 > /proc/ipipe/trace/back_trace_points
>>>
>>> There should be at least a "tick@" trace indicating the time when the
>>> timer was supposed to tick and when it did not, so that we have an idea
>>> of the latency.
>>>
>>> What is the period you use for the latency test?
>>>
>> Hello!
>>
>> Sorry, I have run the same tests again, just with back_trace_points
>> set to 1000. I've run the latency tool for 5 minutes with a period of
>> 100 us (default).
>
> Well, there is only one strange spot:
> :|  # func                 -31	  0.324  ipipe_timer_set+0x9 (xntimer_next_local_shot+0xc4)
> :|  # func                 -31+   8.732  lapic_next_event+0x3 (ipipe_timer_set+0x77)
> :|  # func                 -22+   3.484  __xnpod_schedule+0x9 (xnintr_clock_handler+0x124)
> :|  # func                 -19+   5.443  __xnlock_spin+0x9 (T.1349+0x55)
> :|  # [ 1996] Xorg    -1   -13	  0.211  __xnpod_schedule+0x69 (xnintr_clock_handler+0x124)
>
> Which would indicate that maybe the bus is busy with another core.
> But strangely the latency is around 36us as measure with the other traces.
>  From your traces, I do not see anything pathological.
>
>> I don't think it's related, but xeno-test fails on the machine, and I
>> think it's because of CONFIG_XENO_OPT_SYS_HEAPSZ. I have multiplied it
>> with a factor of 6 (as described here:
>> http://osdir.com/ml/linux.real-time.xenomai.users/2007-03/msg00251.html).
>
> And the error message is...?
>
Hello!

>  From your traces, I do not see anything pathological.
Would you expect the timing to be better with a 64bit-Kernel? Could
it be related to memory management overhead of the Kernel...

> And the error message is...?
Oh, sorry; The message was:
ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory
I multiplied CONFIG_XENO_OPT_SYS_HEAPSZ and CONFIG_XENO_OPT_SYS_STACKPOOLSZ
each by a factor of 6. The resulting values are:
CONFIG_XENO_OPT_SYS_HEAPSZ = 1536
CONFIG_XENO_OPT_SYS_STACKPOOLSZ = 768

I got the info from an old posting you wrote and it fixed the
problem as expected.



