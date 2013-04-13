Message-ID: <51698AE9.7000603@xenomai.org>
Date: Sat, 13 Apr 2013 18:42:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5148C728.6000101@gmail.com> <5148CEA9.7060700@xenomai.org>
In-Reply-To: <5148CEA9.7060700@xenomai.org>
Content-Type: text/plain; charset=UTF-8
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
To: Manuel Huber <manuel.h87@gmail.com>
Cc: xenomai@xenomai.org

On 03/19/2013 09:46 PM, Gilles Chanteperdrix wrote:

> On 03/19/2013 09:14 PM, Manuel Huber wrote:
> 
>> Hello!
>>
>> We use a AMD FX-61000 CPU together with Xenomai 2.6.2.1 and Kernel
>> 3.5.7 (thanks to Jan Kiszka) and I was wondering if it's possible to
>> further decrease the latency of the system. I currently can get more
>> than 30 us when interacting with the system.
>>
>> My first guess was the graphics card + graphics card driver because I
>> read about such problems and tested another graphics card which caused
>> a huge amount of extra-latency... I tried to get the real system
>> latency by booting the system in recovery mode (single) with vga=792
>> option + setting the nouveau driver on the blacklist... This seems to
>> work, but I still get roughly the same latencies (>20us) even after
>> 1hour by using the latency program in interrupt mode (-t 2). Only a
>> few times the latency grows beyond 10us but still it does... I have
>> unplugged the usb mouse and keyboard before running the test and
>> started ten instances of burnK7 with nice -n -20.  I also tried
>> booting with isolcpus=2,3 and assigned the latency program to cpu 3
>> (-c 3). This didn't really improve the worst case latency (still the
>> same setup as above, no gui, single). Is it possible to further
>> decrease latency (especially worst case latency) by using one cpu just
>> for real-time tasks? Is there some other way to keep Linux from using
>> a core?
>>
>> The next thing I want to test is using 64bits; It seems rational that
>> using 32 bits with 16GB ram causes some extra latencies but is it
>> possible that it causes about 10 us extra? Is there some other option
>> I can tune? I know that the I-Pipe system isn't trivial but to me,
>> using interrupts seems pretty low-level and I would expect this to
>> have minimal latency (and jitter). I don't want to complain, it's just
>> that my supervisor asked me about the source of the latency and I
>> can't really explain... After having read just about all papers
>> about I-Pipe, I still don't have a deep understanding of the system.
>> Is there a good reference I missed?
> 
> 
> First, to know where the latency comes from, enable the I-pipe tracer,
> and run latency with the "-f" option.
> 
> Now, common ways to reduce latencies are:
> - optimize the kernel for size
> - disable high res timers, you can try fiddling with the various preempt
> settings, this used to have a big impact on code size, but with the
> "optimize for size" option, they no longer seem to have one.
> - check what the processor does when idle; if it enters C1 state, try to
> avoid that with the BIOS settings, or pass "nohlt" on the kernel command
> line.


Some more advices after some tests:
- try passing "idle=poll" on the kernel command line
- disable MTRR

-- 
                                                                Gilles.

