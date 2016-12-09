References: <884477039.8840647.1480697545181.ref@mail.yahoo.com>
 <884477039.8840647.1480697545181@mail.yahoo.com>
 <daba9179-e8ae-9eea-325f-fc7735aee1ea@xenomai.org>
 <691807707.9610188.1480791921515@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <17386f93-13b4-e79b-475e-c63f2f78e5f9@xenomai.org>
Date: Fri, 9 Dec 2016 15:31:32 +0100
MIME-Version: 1.0
In-Reply-To: <691807707.9610188.1480791921515@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FAILURE rt_thread_body:116: no
 SIGDEBUG_MIGRATE_PRIOINV received on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <giuliomoro@yahoo.it>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/03/2016 08:05 PM, Giulio Moro wrote:
> I now rebuilt the kernel according to your recommendations (full config file here 
> http://pastebin.com/fb623kSQ ), and then built the user-space library with 
> --disable-debug --with-core=cobalt --enable-pshared --build=arm
> 
> Latency results have improved over the previous build:
> RTS| 1.487| 6.459| 46.364| 0| 0| 00:03:19/00:03:19
> 
> With the new configuration, I do NOT get the FAILURE rt_thread_body:116 error when running xeno-test.

There is an ARM board exhibiting the same issue here; some runtime
condition seems to be defeating the test. Will check.

> 
>> - did you run the autotuner to calibrate the core clock?
> 
> I run the autotuner buy I get large variations between successive runs, so I am not sure which values I should echo to /proc/xenomai/clock/coreclk :
> 
> == auto-tuning started, period=1000000 ns (may take a while)
> irq gravity... 999 ns
> kernel gravity... 6499 ns
> user gravity... 5999 ns
> == auto-tuning completed after 21s
> == auto-tuning started, period=1000000 ns (may take a while)
> irq gravity... 2999 ns
> kernel gravity... 5499 ns
> user gravity... 6999 ns
> == auto-tuning completed after 24s
> == auto-tuning started, period=1000000 ns (may take a while)
> irq gravity... 3499 ns
> kernel gravity... 3499 ns
> user gravity... 5499 ns
> == auto-tuning completed after 23s
> == auto-tuning started, period=1000000 ns (may take a while)
> irq gravity... 999 ns
> kernel gravity... 2999 ns
> user gravity... 4499 ns
> 
> What do these values mean?

See there:
http://www.xenomai.org/documentation/xenomai-3/html/man1/autotune/index.html

> Are they supposed to vary so much? What can I do about it?
> 

Yes, they can vary, the effect of cache management can be significant on
latency (especially on ARM systems, depending on the cache model and/or
controller). In addition, the autotuner uses heuristics to figure out
the best calibration values, which may cause the results to fluctuate a
bit across calls.

This said, the figures you report are counts of nanoseconds, so a
variation of 3 us at worst on a BBB is quite small. If the application
can't cope with this variation for carrying out real-time duties, then
using a Linux system on a general-purpose OMAP SoC may not be the best
option for running it anyway.

Keep in mind that unlike a traditional RTOS fully controlling the
hardware, this is a dual kernel system, where a GPOS and a RTOS core are
fundamentally competing for the hardware resources.
e.g. plain Linux activity happily evicting cachelines used by Xenomai as
soon as the latter temporary sleeps, adding delays due to cache misses
when it resumes.

You can observe a manifestation of such competition by comparing the
worst case latency figures obtained from sampling at 1Khz (the default
on ARM) and 10Khz (latency -p 100).

> Thanks,
> Giulio
> 
> PS: For reference, these are the latency performance on the same board with Xenomai 2.6 on Linux 3.8.13
> RTS| 3.666| 6.958| 46.124| 0| 0| 00:15:10/00:15:10

Which is comparable to 3.0.x.

> (I have no way to run the autotuner there as I did not build the library myself so I don't have the utility).
> 

The autotuner appeared in Xenomai 3.x, you won't find it in a 2.x
release anyway.

-- 
Philippe.

