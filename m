Message-ID: <43EB56CC.6090609@domain.hid>
Date: Thu, 09 Feb 2006 15:50:52 +0100
From: Luotao Fu <devtty0@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Benchmarks
References: <b647ffbd0602090621o4501fb08t@domain.hid>
In-Reply-To: <b647ffbd0602090621o4501fb08t@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Hi folks,

Dmitry Adamushko schrieb:
> 
> Hi there,
> 
> after a preliminary discussion with Philipe and, well, a few days later
> than I expected, I'm starting a new effort of writting some simple (i.e.
> not
> too complex :) yet, hopefully, useful benchmarking utilites.
> 
> The idea of each utility is to emulate a certain use case but
> at the level which is significant enough to prove that
> the system is (or is not) working properly latency-wise.
> This, hopefully, will help to determine some bottlenecks and
> the parts of code that need to be reworked/tweaked.
> Then we may use such tests on release-by-release basis as indicators
> of either progress or regress we are making with a certain release.

Actually, I'm doing here some measurementstuffs to compare the Realtime
Performance of Xenomai and Preempt-RT stuffs. :-)

> 
> As an example, the first utility would implement the following use case :
> 
> (based on the latency program)
> 
> - a given number of periodic threads are running;
> 
> - configurable periods (so that e.g. a few threads can become active
>   at the same moment of time). Actually, that's what we would need.
> 
> - timer : periodic or apperiodic;

I've already implemented something in this way in POSIX. I took the
accuracy.c out of the posix demo from Gille and changed it. So that you
can start few threads with different nsleep duration. Except that it
writes a log, which can be plotted. The util does quite the same stuffs
like the cyclictest by Thomas Gleixner.

Further I implemented a tool for Interruptmeasurement with rtdm. Still
tuning on it, because the Pre-RT Kernel get ocassionally problems with
stability.

I even implemented Rhealstone Benchmark with xenomai-complaint Posix, it
however provides only middlevalues and might not be very interesting.

> 
> ...
> 
> the utility will not likely produce any screen-output during its work, but
> rather the comprehensive statistic in a handy form after finishing.
> 

Exactly what I thought :-)

> ---
> 
> other utils could make use of some scenarious where synch. primitives/
> rt_queue's/pipes could be highly used etc.
> 

Generally I'm quite interested on some xenomai specific latency
behaviour caused by i.E. Domain Switching, Function Wrapping and so on.
I'm still considering on some concrete Workload-scenarious.

> 
> I guess, Xenomai already provides a valid amount of functionality and it's
> quite stable for the time being. So it's time to work on optimizing it!
> 
> Everyone is wellcome to come up with any scenarios on which such utilities
> could be based.
> 
> Any comments on the one with a given number of threads are wellcome too.
> 

I'm now busy writing my stuffs together. no time to debug my hacks. so I
think I'd release them somehow later some time after I've given them
first to Jan for quice code review.

> 
> -- 
> Best regards,
> Dmitry Adamushko
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core

Cheers
Luotao Fu

