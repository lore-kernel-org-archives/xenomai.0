Subject: Re: [Xenomai-core] [RFC][PATCH 1/2] real-time print library
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45D73EC0.2030601@domain.hid>
References: <45D6C4B6.7010302@domain.hid> <1171714345.18347.25.camel@domain.hid>
	<45D73EC0.2030601@domain.hid>
Content-Type: text/plain
Date: Sun, 18 Feb 2007 01:44:50 +0100
Message-Id: <1171759490.18347.162.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sat, 2007-02-17 at 18:43 +0100, Jan Kiszka wrote: 
> Philippe Gerum wrote:
> > On Sat, 2007-02-17 at 10:02 +0100, Jan Kiszka wrote:
> >> This is a stand-alone real-time library for printf services. It is
> >> embedded into the Xenomai user space part but actually doesn't depend
> >> on any Xenomai service, just using plain Linux POSIX.
> >>
> >> The librtprint API looks much like the printf(3) man page:
> > 
> > [...]
> > 
> >> Further features:
> >>  o Explicit or on-demand thread buffer creation
> >>  o Override of default buffer size and polling period via environment
> >>    variables ("RT_PRINT_BUFFER" and "RT_PRINT_PERIOD")
> >>  o Support for buffer names (useful for the following patch e.g.)
> >>  o Target output stream can be specified for each print invocation
> >>  o Breaks all builds except for x86 (missing ubarrier.h headers) :o)
> >>
> > 
> > ubarrier.h is redundant. include/asm-*/atomic.h is already there for
> > such purpose.
> 
> Guess you mean Xenomai's atomic.h, not the kernel ones.

Yes, since this needs to be user-space readable.

>  I didn't
> realised that it is also used from user space already. OK, will #define
> something like xnarch_rmb/wmb (or xnarch_read_memory_barrier?) in that
> file instead.
> 
> > 
> >> The code is stuffed into src/rtprint for now as patch 2/2 will need this
> >> lib to be built before the skin libraries. Better suggestions are
> >> welcome though.
> > 
> > I basically agree that we need to provide more
> > co-scheduler-based-rt-safe services, so a non-intrusive print out
> > support should be welcome. A few things more:
> 
> Actually, rt-safe printing is independent of co- vs. native scheduling.
> Even with a fully preemptible kernel, the worst-case complexity of
> normal printf may not be acceptable. I think rt_printf is generally
> useful in real-time programs.

You seem to be talking specifically about a (non-intrusive) trace
logging feature, rather than plain printf() then, because the latter
does not make much sense to be used in a real-time scenario unless the
caller does accept to pay the price of running a complex operation
anyway.

If, on the other hand, you want to provide more efficient replacements
of existing standard routines in terms of performance, then those should
bear the standard names. Otherwise, people would start mixing printf()
and rt_printf() in their application [experience already showed us that
it's inevitable], and for instance, you would start receiving complaints
about inaccurate output order, leading to incorrect interpretation of
traces, because both implementations would obviously rely on distinct
internal buffers.

> 
> > 
> > - looking beyond print out, we will probably want to iron more ANSI
> > services in the future. In order to prevent API proliferation, let's
> > consider the hardened print out support as the beginning of some
> > libansi_rt service collection.
> 
> I was already considering to include the TLSF memory allocator for
> real-time malloc/free into some Xenomai library, but there were still
> technical issues with its lacking 64-bit support e.g., preventing some
> quick-hack.
> 
> What further services do you have on your radar? My impression is that
> there will not be a lot beyond printing and memory allocation.
> 

And that would already be enough to explain why we would not want to ask
people to stuff their Makefile with LDFLAGS += -lrt_printf -lrt_malloc,
IMO. Because after a few years, my feeling is that the LDFLAGS would
grow out of any reasonable proportion, and our maintenance burden the
same way.

I would also consider things like stdio in general, not just printf, by
mean of server thread(s) the way you did it. Being able to send/receive
a file stream without resorting -at least explicitely- to a proxy thread
would simplify a bunch of existing applications for instance.

Aside of purely ANSI services, there are some POSIX/SVID calls which are
not relevant to libpthread_rt, but for which a hardened counterpart
would make sense over a co-kernel, like SunRPC (over RTNet's UDP, that
is), syslog routines, random, or libcrypt members for instance.

My point being that we cannot anticipate the exact list of features we
would want to harden in the future, but we do know already that
applications ported/created over Xenomai are always more complex, so we
will likely need more of those features. Componentization must have a
limit, and my guts feeling is that going for a specific API for each and
every feature would lead to maintenance chaos and user confusion.
Additionally, sharing internal routines common to those features would
be possible with a centralized architecture (unless we go for
yet-another-library exporting those routines).

> > 
> > - the same way libpthread_rt shadows 1003.1c services to iron them over
> > a co-scheduler, we should do the same for the ironed ANSI services. In
> > that sense, there is no need for rt_printf, rt_vsprintf and so on, we
> > just need to shadow printf, vsprintf and friends the same way we did for
> > pthread_create and such for substituting the 1003.1c support. Again, API
> > proliferation, especially of non-orthogonal stuff, needs to be fought
> > now. The bonus is that we would not have to ask people to rely on crufty
> > preprocessor tricks in order to compile their code in either real-time
> > layers X3 is going to provide (i.e. I-pipe-based co-scheduler and native
> > preemption). This would be consistent with the all-time Xenomai's
> > mantra, i.e. "integrate as seamlessly as you can, don't get uselessly
> > peculiar".
> > 
> 
> Think of RTDM: we have transparent overloading with the POSIX skin, but
> all others use the explicit selection via rt_dev prefix. I forgot to
> mention this, but my plan was to apply the same pattern for librtprint
> services.
> 
> I don't think we should overload every printf outside the POSIX skin's
> scope automatically. Well, at least for the native skin, which is in my
> opinion quite a lot about _explicit_ real-time programming, I would
> really prefer to keep it like it is even under Xenomai 3.
> 

IMO, the only way to make "explicit real-time programming" a rule is to
disable all access to real-time unsafe calls, i.e. basically to the
glibc, and this is obviously something we don't want to, because this
would contradict the fundamental goal of Xenomai toward integration
within the regular Linux programming model.

Because of this, that's a fact of life that users are most often going
to consider that a commonly used glibc routine they need is real-time
safe enough to be used until proven wrong (*), instead of suspecting
such routine to be unsafe a priori, and looking for a safe replacement
in some specific API we might provide (this is why we all had to warn a
number of people countless times on the list about their use of printf()
in deemed time-critical sections from various pieces of code they showed
us).

This is also the reason why I still think we should "upgrade" the
commonly used standard routines to be real-time aware by gradually
providing hardened replacements for them, not trying to convince people
about the fact that using standard routines might not be the right
solution to common problems in the real-time case.

(*) actually, the real problem is that some users might think that we
are smart enough to make deterministic and efficient code out of any
regular Linux service they might think of, albeit the founder of the
Xenomai project might be a total bonehead. Oh, well, anyway...

-- 
Philippe.



