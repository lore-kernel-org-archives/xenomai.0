Subject: Re: [Xenomai-core] [RFC][PATCH 1/2] real-time print library
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45D8AB43.8050609@domain.hid>
References: <45D6C4B6.7010302@domain.hid> <1171714345.18347.25.camel@domain.hid>
	<45D73EC0.2030601@domain.hid> <1171759490.18347.162.camel@domain.hid>
	<45D8AB43.8050609@domain.hid>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 13:10:32 +0100
Message-Id: <1171973433.5044.5.camel@domain.hid>
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

On Sun, 2007-02-18 at 20:38 +0100, Jan Kiszka wrote: 
> Philippe Gerum wrote:
> > On Sat, 2007-02-17 at 18:43 +0100, Jan Kiszka wrote: 
> >> Philippe Gerum wrote:
> >>> On Sat, 2007-02-17 at 10:02 +0100, Jan Kiszka wrote:
> >>>> The code is stuffed into src/rtprint for now as patch 2/2 will need this
> >>>> lib to be built before the skin libraries. Better suggestions are
> >>>> welcome though.
> >>> I basically agree that we need to provide more
> >>> co-scheduler-based-rt-safe services, so a non-intrusive print out
> >>> support should be welcome. A few things more:
> >> Actually, rt-safe printing is independent of co- vs. native scheduling.
> >> Even with a fully preemptible kernel, the worst-case complexity of
> >> normal printf may not be acceptable. I think rt_printf is generally
> >> useful in real-time programs.
> > 
> > You seem to be talking specifically about a (non-intrusive) trace
> > logging feature, rather than plain printf() then, because the latter
> > does not make much sense to be used in a real-time scenario unless the
> > caller does accept to pay the price of running a complex operation
> > anyway.
> 
> No, I'm also talking about plain printf scenarios from hard-RT threads.
> There is a difference between just doing a fairly simple snprintf to
> format the output and going into the kernel to write it to some console,
> file, network link, or whatever.
> 

Right, but your patch seems to focus on printf() so far, hence my
argument. [Btw, glibc's snprintf() called from rt_vsnprintf() is likely
going to compete for the file lock in the MT_SAFE_IO case, which might
not be what you want, if you don't want to take the mode switch penalty
upon contention].

> > 
> > If, on the other hand, you want to provide more efficient replacements
> > of existing standard routines in terms of performance, then those should
> > bear the standard names. Otherwise, people would start mixing printf()
> > and rt_printf() in their application [experience already showed us that
> > it's inevitable], and for instance, you would start receiving complaints
> > about inaccurate output order, leading to incorrect interpretation of
> > traces, because both implementations would obviously rely on distinct
> > internal buffers.
> 
> I agree that there is an ordering issue when writing to stdout or stderr
> /wrt to standard glibc routines.

I was primarily talking about calling printf() then rt_printf() (or the
other way around), which would not give any guarantee about the output
sequence.

>  But the question is where to draw the
> line. We surely do not want to redirect each and every file write to a
> server thread _automatically_ (would be quite a performance PITA...)

You would still have access to the __real_xxx counterparts anyway.
> just because some fprintf may otherwise happen to come out in an
> unexpected order. We cannot avoid that the user has to be - to some
> degree - really _aware_ of what (s)he's doing.
> 

My point is different, and it goes beyond the printf() case. IOW, should
a developer:

a) have to verify whether rt_printf(), rt_vsprintf(), rt_vsnprintf()
etc. exist in some API we would provide, and decide to use them in
replacement of the original glibc calls, and understand the consequences
about predictability if they don't.

or

b) have to verify whether printf(), vsprintf(), vsnprintf() etc. are
documented as members of the calls Xenomai "hardens" when she happen to
need them, and understand the consequences about predictability if they
don't.

In both cases, such developer _must_ know what he's doing anyway, in
order to ask himself either one of those questions in the first place,
so this is clearly not about telling people "life is good because call
shadowing exists, just breath and live cluelessly". It's whether you
want them to use a specific API, or to use a hardened subset of the
original one.

I tend to prefer b) because:
- I tend to find much easier to tell people "you may use a subset of the
API you already know", than "you must use another API to access a
functional subset of the API you already know". The fact that original
symbols would just have to be prefixed by rt_ does not change this fact:
it's another API.
- when running Xenomai apps over native preemption, finding rt_* and
non-rt versions of the same symbol would look preposterous, and the
point about X3 is to allow people to move freely from one real-time
layer to another (i.e. co-kernel to native preemption and the other way
around), without any impact on their code.

But, I definitely agree with you that b) is error-prone if nothing is
made to strongly warn about potential misuses, and strenghtening the
mode switch alert policy may be a mean to do that.

> > 
> >>> - looking beyond print out, we will probably want to iron more ANSI
> >>> services in the future. In order to prevent API proliferation, let's
> >>> consider the hardened print out support as the beginning of some
> >>> libansi_rt service collection.
> >> I was already considering to include the TLSF memory allocator for
> >> real-time malloc/free into some Xenomai library, but there were still
> >> technical issues with its lacking 64-bit support e.g., preventing some
> >> quick-hack.
> >>
> >> What further services do you have on your radar? My impression is that
> >> there will not be a lot beyond printing and memory allocation.
> >>
> > 
> > And that would already be enough to explain why we would not want to ask
> > people to stuff their Makefile with LDFLAGS += -lrt_printf -lrt_malloc,
> > IMO. Because after a few years, my feeling is that the LDFLAGS would
> > grow out of any reasonable proportion, and our maintenance burden the
> > same way.
> 
> So your point is single vs. multiple rt-helper libs? I don't see a
> problem bundling fairly small services (a few kB) into a single lib,
> common to all skins. But once it takes a bit more to provide a certain
> service, we have to keep memory-restricted embedded applications in
> mind. Configuring features at build time is one way. Providing
> reasonably clustered libraries is another. Hard to draw a line now
> without having all components already at hand or at least in mind.
> 

My point is about avoiding this approach:
http://www.slac.stanford.edu/exp/glast/flight/sw/vxdocs/vxworks/ref/libIndex.htm#A

> > 
> > I would also consider things like stdio in general, not just printf, by
> > mean of server thread(s) the way you did it. Being able to send/receive
> > a file stream without resorting -at least explicitely- to a proxy thread
> > would simplify a bunch of existing applications for instance.
> 
> Yeah, the way rt_printf writes out data might be extended to a common
> pattern also for other stdio output services. If async stdio-like
> reading is also worth providing in a generic way is something I would
> like to see backed up by concrete application scenarios. Maybe.
> 
> > 
> > Aside of purely ANSI services, there are some POSIX/SVID calls which are
> > not relevant to libpthread_rt, but for which a hardened counterpart
> > would make sense over a co-kernel, like SunRPC (over RTNet's UDP, that
> > is), syslog routines, random, or libcrypt members for instance.
> > 
> > My point being that we cannot anticipate the exact list of features we
> > would want to harden in the future, but we do know already that
> > applications ported/created over Xenomai are always more complex, so we
> > will likely need more of those features. Componentization must have a
> > limit, and my guts feeling is that going for a specific API for each and
> > every feature would lead to maintenance chaos and user confusion.
> > Additionally, sharing internal routines common to those features would
> > be possible with a centralized architecture (unless we go for
> > yet-another-library exporting those routines).
> 
> Well, would you be more happy if we call the printing library
> libstdio_rt without yet implementing all the related services, but
> pointing out the potential path of this lib in the future?
> 

There would remain the malloc support issue, which would obviously not
fit in the stdio lib.

> > 
> >>> - the same way libpthread_rt shadows 1003.1c services to iron them over
> >>> a co-scheduler, we should do the same for the ironed ANSI services. In
> >>> that sense, there is no need for rt_printf, rt_vsprintf and so on, we
> >>> just need to shadow printf, vsprintf and friends the same way we did for
> >>> pthread_create and such for substituting the 1003.1c support. Again, API
> >>> proliferation, especially of non-orthogonal stuff, needs to be fought
> >>> now. The bonus is that we would not have to ask people to rely on crufty
> >>> preprocessor tricks in order to compile their code in either real-time
> >>> layers X3 is going to provide (i.e. I-pipe-based co-scheduler and native
> >>> preemption). This would be consistent with the all-time Xenomai's
> >>> mantra, i.e. "integrate as seamlessly as you can, don't get uselessly
> >>> peculiar".
> >>>
> >> Think of RTDM: we have transparent overloading with the POSIX skin, but
> >> all others use the explicit selection via rt_dev prefix. I forgot to
> >> mention this, but my plan was to apply the same pattern for librtprint
> >> services.
> >>
> >> I don't think we should overload every printf outside the POSIX skin's
> >> scope automatically. Well, at least for the native skin, which is in my
> >> opinion quite a lot about _explicit_ real-time programming, I would
> >> really prefer to keep it like it is even under Xenomai 3.
> >>
> > 
> > IMO, the only way to make "explicit real-time programming" a rule is to
> > disable all access to real-time unsafe calls, i.e. basically to the
> > glibc, and this is obviously something we don't want to, because this
> > would contradict the fundamental goal of Xenomai toward integration
> > within the regular Linux programming model.
> 
> No, disabling such access is surely a no-go. But I really think we
> should strengthen the mode-switch detection, maybe be considering to
> invert its default (always or just for debugging). Mode-switch detection
> by the user space tracer could be a first step in this direction
> (without immediately breaking the API).
> 

Agreed, other means to strengthen the alerts about loss of
predictability should be found.

> > 
> > Because of this, that's a fact of life that users are most often going
> > to consider that a commonly used glibc routine they need is real-time
> > safe enough to be used until proven wrong (*), instead of suspecting
> > such routine to be unsafe a priori, and looking for a safe replacement
> > in some specific API we might provide (this is why we all had to warn a
> > number of people countless times on the list about their use of printf()
> > in deemed time-critical sections from various pieces of code they showed
> > us).
> > 
> > This is also the reason why I still think we should "upgrade" the
> > commonly used standard routines to be real-time aware by gradually
> > providing hardened replacements for them, not trying to convince people
> > about the fact that using standard routines might not be the right
> > solution to common problems in the real-time case.
> > 
> > (*) actually, the real problem is that some users might think that we
> > are smart enough to make deterministic and efficient code out of any
> > regular Linux service they might think of, albeit the founder of the
> > Xenomai project might be a total bonehead. Oh, well, anyway...
> > 
> 
> As I said, overloading, just trying to shadow the differences doesn't
> solve the problem automagically. You often need special configuration
> APIs for the shadowed one, thus you need understanding of its
> mechanisms. And you need access to the original functions because of
> drawbacks of the hardened variants (if they had none, we could just
> submit glibc or whatever patches...).
> Overloading is only as long comfortable as you _mostly_ make use of the
> replacement services in your application. Once it is the other way
> around, this automatism becomes quite a PITA. We luckily already have
> two programming models with POSIX vs. native skin matching both use
> cases, and I consider this a strength, not a weakness of Xenomai.

I did not say it was a weakness (even if I always thought that the
rt_dev interface to RTDM was redundant with the POSIXish one), but that
we should keep the finger on the bloat control when it comes to
co-kernel-specific-APIs, because as much as there is life beyond x86,
there is also life beyond co-kernels.

The natural tendency of Xenomai has always been to blur the frontier
between the regular Linux environment and the co-kernel environment, so
that people don't get schizophrenic when implementing a real-time
application over Xenomai, with powerful features on both sides, but no
ability to combine those strengthes efficiently. I'm convinced this has
some value in the picture too.

> 
> Granted, alternatives can cause confusion, and we may have to improve
> beginner guides on the homepage or wherever to underline and explain
> these differences more explicitly.
> 

Ack.

> Jan
> 
-- 
Philippe.



