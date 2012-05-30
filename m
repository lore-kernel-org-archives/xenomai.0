MIME-Version: 1.0
In-Reply-To: <4FC4E086.8090702@xenomai.org>
References: <CAKKWdtcDaTBSc5mr1MWEhvDyx45r-D-2rOxA_BE+aVdR595GaA@mail.gmail.com>
	<4FC4E086.8090702@xenomai.org>
Date: Wed, 30 May 2012 18:09:45 +0430
Message-ID: <CAKKWdtcFrw8XnwZhg2e9ixXE2Uh8PuRd6Xy=ysAHcvi-Pp0=ZA@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] What is the Xenomai time limit?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear Philippe,

Much appreciate for the reply.

Latency test seems to give some statistics about the system at the
time of the test.

I was looking for an exact maximum time so that scheduling latency is
always below that time.

I figured it out that even adding a new hardware may effect the
maximum scheduling latency. Is that true? If I add a new hardware and
its driver, it can mask the interrupts for example. Can it make the
xenomai system non real-time?

Regards

> On 05/29/2012 02:38 PM, ali hagigat wrote:
>>
>> We know that Xenomai can create hard real time tasks and it means that
>> the real time tasks will be executed up to a specific time. My
>> question is about that time. How much is that time?(100 micro seconds,
>> 150 usec, or...)
>
>
> Do you mean maximum latency? If so, you only have to run the "latency" test
> program on your board (/usr/xenomai/bin/latency for a default install).
>
> With modern hardware, 100 us on x86 is considered a bug.
>
>
>> I know that it may depend on the architecture and the software platform.
>> I want to know how can i determine that time for my x86 32-bit PC
>> system? and besides what major factors are effecting the time?
>
>
> Assuming time == latency, major arch-independent factors include bus
> locking, MMU handling (e.g. see issues with VIVT caches on ARM), cache
> artifacts caused by concurrent linux activity in general (which may cause
> real-time code to be evicted during idle phases by non-rt code).
>
> x86-wise, there is some more issues to keep an eye on:
>
> - Hyperthreading (not nice to -rt requirements)
> - SMI sources (causing IRQ-disabling BIOS code to be invoked directly by
> special interrupts not going through the programmable interrupt controller,
> so we can't block them, and don't know when they happen).
> - Some graphic card adapters (causing hw stalls to favor their own
> throughput)
> - Some graphic card drivers, most often proprietary, disabling interrupts
> for too long.
> - Some cycle-hungry x86 cache invalidation instructions (wbinv).
> - The legacy x86 PIT (i8254) when used, which goes through a legacy ISA bus,
> as expensive as ~1.5-2.5 us for each I/O access (you need at least two of
> them to program the next clock tick). Fortunately, you won't need it on a
> modern x86 platform, unless really unlucky.
>
> Oh well, other that that, x86 is almost fine for -rt stuff.
>
>> Any answer will be much appreciated.
>>

