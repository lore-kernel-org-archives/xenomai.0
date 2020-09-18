References: <55694df3-85a8-cca8-1801-d55a4e7f0e53@siemens.com>
 <87ft7os284.fsf@xenomai.org>
 <9c76bfeb-f114-0c29-f048-fb51679ad0de@siemens.com>
 <87k0wzdk3h.fsf@xenomai.org>
 <025d306d-4a61-044b-851f-c5c429266af6@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Useless dovetail hacks
Message-ID: <87h7rz6svg.fsf@xenomai.org>
In-reply-to: <025d306d-4a61-044b-851f-c5c429266af6@siemens.com>
Date: Fri, 18 Sep 2020 18:17:40 +0200
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: song <chensong@tj.kylinos.cn>, Henning Schild <henning.schild@siemens.com>, "Pirou, Florent" <florent.pirou@intel.com>, "Hu, Mingliang" <mingliang.hu@intel.com>, "Wang, Rick Y" <rick.y.wang@intel.com>, xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 12.09.20 18:40, Philippe Gerum wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 11.09.20 18:32, Philippe Gerum wrote:
>>>>
>>>> Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:
>>>>
>>>>> Hi all,
>>>>>
>>>>> to permit sharing the work of porting Xenomai over dovetail, I finally
>>>>> pushed my baseline hacks to [1]. You can "use" that on [2] (use
>>>>> fa1e9ba5e822, 0d68e5607286 leaks evl bits and is broken)
>>>>
>>>> Fixed on top of [2] now, thanks.
>>>>
>>>
>>> Thanks, confirmed!
>> Ok. I'll push this to 5.9-rc4 too.
>> 
>>>
>>>>> just like you
>>>>> would for an I-pipe kernel (prepare-kernel.sh). The thing builds for me,
>>>>> it even starts and gives a prompt, but that's because of
>>>>>
>>>>> [    1.186025] [Xenomai] init failed, code -19
>>>>>
>>>>> All the timing stuff is not mapped yet. Like a lot of other things. ETIME...
>>>>>
>>>>
>>>> This rough enumeration of what would change in Cobalt as a result of
>>>> rebasing on Dovetail still applies:
>>>>
>>>> https://xenomai.org/pipermail/xenomai/2020-February/042488.html
>>>>
>>>> To summarize this, a significant issue would involve switching the
>>>> xntimer abstraction to nanosecs, dropping all references to the internal
>>>> time unit which may be used by the clock and timer devices (e.g. TSC on
>>>> x86, free running counters from assorted ARM/aarch64 timers).
>>>
>>> I'm thinking of running with timers/clocks that have a 1:1 translation
>>> in first step. Obviously, that is not optimal.
>>>
>>>>
>>>> Overall, switching to Dovetail entails disabling a significant amount of
>>>> low-level code from Cobalt, which implements features the former already
>>>> handles (like core context switch support, fpu sharing between execution
>>>> stages, shared interrupt support [in xnintr] and reading the POSIX
>>>> clocks from the real-time context via the generic vDSO).
>>>>
>>>>> Please raise your hand when you'd like to join this endeavor, then we
>>>>> can discuss a split-up of tasks. Next steps would be:
>>>>>
>>>>> - make it initialize dovetail properly and activate Xenomai
>>>>> - hack on it until Xenomai tasks work properly
>>>>> - look at the result an decide how to integrate with I-pipe or whether
>>>>>    to make this Xenomai 3.2 without any I-pipe support
>>>>
>>>> Assuming you meant that an option might be to enable Xenomai 3.1 to run
>>>> over Dovetail, I would say that a Dovetail-based Cobalt core implies
>>>> Xenomai 3.2+ instead, because 3.1.x is deemed stable, therefore the ABI
>>>> changes involved in such a transition should not make their way into the
>>>> stable tree.  There is also the issue of ppc32 and x86_32, which
>>>> Dovetail does not support.
>>>
>>> x86_32 is long gone, no one needs this anymore. ppc32 is different, but
>>> we would not hold breath if one arch is not able to follow in time. I
>>> wouldn't see an issue with leaving a combination initially unsupported.
>>>
>>> Anyway, the criteria for 3.2 vs. 3.1 enhancement is whether we can keep
>>> the kernel-user ABI stable. I have no concrete feeling for that yet.
>>> Primarily, we are working on the kernel internals. But prio is on being
>>> able to move forward, and if that is much simpler via a new major
>>> release, than we will do that.
>>>
>>>>
>>>> Although having both ABIs live side-by-side in a way that would maintain
>>>> backward compat with I-pipe kernels might be done, the result would not
>>>> be pretty implementation-wise: redundancies and ugly wrappings to be
>>>> expected in libcobalt, and two set of build settings for the latter
>>>> depending on which ABI is targeted to avoid indirect calls all over the
>>>> place. Which would also require having separate sets of user-space
>>>> libraries, specifically built for one IRQ pipeline core or the
>>>> other, adding to the confusion.
>>>
>>> Can you give some example where ipipe concepts "leak" into userspace?
>>>
>> The ARM port exports the current clocksource counter to user-space
>> via
>> MMIO mapping in order for application processes to perform fast readings
>> (i.e. arch/arm/include/asm/xenomai/uapi/tsc.h). Then comes the ticks to
>> nanosecs translation from the read value via the arith code, both in
>> kernel and libcobalt.
>> Also, Dovetail reworked the foreign syscall identification scheme on
>> ARM. The I-pipe relies on a specific SWI instruction argument signature
>> (0xF0042) to detect syscalls which shall be directed to the real-time
>> core. The reason is rooted into the OABI/EABI call convention split,
>> Xenomai still supporting both of them.  With other architectures, the
>> I-pipe makes this decision on the syscall number instead (i.e. checking
>> the MSB). Now that OABI is pretty much dead, Dovetail has aligned the
>> ARM implementation on the common rule for encoding a co-kernel syscall,
>> supporting EABI only. In other words, the way XENOMAI_SYSCALL() expands
>> on ARM would differ between an I-pipe and a Dovetail-based system.
>
> OK, so ARM is our primary problem here. If it remains the only one, we
> may consider excluding that arch from a stable dovetail port and 
> covering it again from timely scheduled major release.

I would say that having a stable milestone drop support for any
architecture, even with the promise to reinstate it at a later point,
would seem odd to most users.

> But it
> definitely means we need a major update branch from which we may
> backport certain patches to stable if they can benefit other archs.
>

In fact most architectures would be excluded in this case, as I
mentioned ARM in its broadest definition: aarch32 and aarch64 for which
Cobalt provides fast MMIO access to the clock source that way, and ppc32
for which there is no Dovetail port.  Therefore a port of the stable
Cobalt tree to Dovetail could only target a single architecture: x86_64.

>> 
>>>>
>>>> On a more general note, isn't the issue about which should be the final
>>>> kernel release the project would pledge to support with Xenomai 3.1.x?
>>>>
>>>> As of today, Xenomai 3.1 is (almost) running kernel 5.4 LTS over the
>>>> I-pipe, at least on x86. If things go as usual upstream, the next LTS
>>>> kernel is going to be post-5.7, which means the effort in porting the
>>>> I-pipe to the next LTS release may be quite significant, with many
>>>> conflicts to expect between the upstream changes and the pipeline code
>>>> starting from kernel 5.8, particularly for x86. For this reason, keeping
>>>> the Cobalt core compatible with the I-pipe beyond kernel 5.4, adding
>>>> support for Dovetail the right way in the meantime seems a hard nut to
>>>> crack maintenance-wise.
>>>
>>> Having a 5.4 I-pipe in reach definitely relaxes our pressure to move the
>>> core over dovetail and do many necessary and reasonable refactoring
>>> along that. 5.10 will most likely by the next LTS, and that is what the
>>> dovetail porting is targeting.
>>>
>>>>
>>>> Out of curiosity, are there teams at Intel/Siemens planning for this
>>>> already?
>>>
>>> Intel stepped up to work with the I-pipe 5.4 port for x86 and would also
>>> like to support with the dovetail work. At Siemens we are looking at the
>>> y2038 conversion and the dovetail baseline. For the former topic
>>> Chensong is joining us.
>>>
>> An approach that worked well for EVL is to combine the y2038 and
>> 32-bit
>> compat mode (aarch32->aarch64) efforts. Many (if not most) syscall32
>> wrappers which Cobalt implements are actually addressing the long-type
>> representation issue with timespecs, which y2038 also has to solve.
>> 
>
> Worth to look along this patch - adding Chengsong and Henning.
>
>> At the end of the day, syscall32 wrapping became pointless (granted, the
>> EVL core only needs three system calls, one of which receives those data
>> structures, but the Cobalt ABI could be reworked in a similar fashion).
>> Reducing the number of system call entries Cobalt implements would also
>> go a long way towards libcobalt compatibility with Valgrind.
>
> I don't think the number of entry points matters. The number of
> dispatched functions affected by problematic data structures or 
> parameters does.

Agreed. The latter is usually a factor of the former though. This is the
case for Cobalt at least.

> IOCTLs of drivers that have incompatible specific
> interfaces defined would be the best example - but I think we don't
> have many affected thanks to nanosecs_abs/rel_t.
>
>> 
>>>>
>>>> Also, are there any discussions about what the next major Xenomai
>>>> release (i.e. post-3.1) should aim at, particularly in the context of
>>>> upstream's plans to merge the last preempt-rt bits in the 5.10
>>>> timeframe? Should this major Xenomai release be exclusively about
>>>> solving the I-pipe maintenance issue by rebasing Cobalt over Dovetail?
>>>
>>> It is surely the primary topic, along with y2038 (with our without
>>> backward compatibility) and associated cleanups. Rather than putting
>>> more on the table, I would prefer getting that release done in a timely
>>> manner, in order to have recent kernel and, thus, also hardware support.
>>>
>>>>
>>>> Could this be also an opportunity to have an all-out conversation about
>>>> the best way to ensure Xenomai stays relevant in the years to come as a
>>>> enabler for a particular class of real-time applications? Are there any
>>>> discussions about the scope and purpose of what Xenomai as a system
>>>> should provide? such as (and not exclusively):
>>>>
>>>> - is API emulation of legacy RTOS (VxWorks, pSOS) still relevant in this
>>>>    day and age? Corollary: is allowing people to develop their own flavor
>>>>    of whatever real-time API something Xenomai should still provide
>>>>    support for.
>>>
>>> That is a valid question, and I would also like to hear voices from the
>>> user community on that.
>>>
>>> We do have one of such use case on out side at Siemens, and it's clear
>>> that we will need a certain level of customization on top for some more
>>> years to come. Reducing it is clearly a goal, just a longer effort.
>>>
>> If the interface you mention is the one I'm aware of, you would only
>> need a limited portion of libcopperplate to support it. The work to
>> support this API mostly happens in kernel space, over the so-called
>> "personality" abstraction Cobalt implements.
>> 
>>>>
>>>> - how to solve the general issue of driver bit rotting over Cobalt/RTDM?
>>>>    (e.g. can, uart, spi, rtnet)
>>>
>>> Drivers for hardware that deceased a decade ago or so should probably be
>>> removed (RTnet hosts several candidates). The rest depends on users
>>> looking for it. Latest when things stop to build and no one notices, we
>>> should start removing more agressively. The next major release should
>>> probable be used to sweep the corners.
>>>
>>> As we know, there is no magic answer to this problem. When you split
>>> scheduling and, thus, also synchronization primitives, you automatically
>>> create a second world for drivers. Sharing setup and resource management
>>> logic with Linux, which we do to a certain degree already, mitigates
>>> this a bit but will never solve this fundamental issue. So, only
>>> interfaces/hw that matter enough will see the required extra effort to
>>> run over co-kernel environments.
>>>
>> I agree. However, with hindsight and quite some time spent working
>> on
>> this issue with EVL, I believe that in many cases, it is possible to
>> merge the "dual kernel" execution logic into the common driver semantics
>> in a way which does not require having a separate driver stack, but
>> rather the common driver model knowing about the out-of-band/primary
>> mode contexts.
>> If we cannot make the whole driver run happily in primary mode for
>> the
>> reasons you mentioned, it may still be possible to define a set of
>> simple operations which may do so provided they are mutually exclusive
>> with the regular driver work, and have them live directly into the
>> original driver, instead of forking off of the latter to implement an ad
>> hoc driver, which is pretty much signing up for bit rot down the
>> road. Although there are still two competing execution contexts (primary
>> vs secondary in Xenomai's lingo) and only very few bridges between them,
>> such level of integration limits the amount of -semantically- redundant
>> code between both.
>> SPI, DMA, and GPIOs are a no brainer for this and are already
>> available
>> in such form, serial and network need more analysis because their
>> execution contexts are either more clumsy/complex. I also got the PCM
>> portion of the Alsa stack enabled with a complete I/O path over the
>> real-time context, from the user (ioctl) request to send/recv frames to
>> some i2s device, via DMA transactions controlled by the PCM core. As
>> weird as it may seem, it is actually not that intrusive, and works quite
>> well, including at insane acquisition rates for feeding an audio
>> pipeline. There is still some work ahead to fix rough edges, but the
>> fundamentals look sane.
>> Overall, the idea is not about preventing people to depend on some
>> abstract driver interface like RTDM would they wish to, but instead to
>> make this indirection optional when a deeper integration with the common
>> device driver model is possible and preferred.
>> Of course, the whole idea only makes sense if one is willing to
>> maintain
>> the real-time core directly into the linux kernel tree, which is how EVL
>> is maintained.
>
> Right, and we will see how well that will scale with an increasing
> number of drivers patched - even just slightly - in order to add 
> out-of-band support.
>

Well, maintaining drivers based on forked code which departed years ago
from a mainline implementation is hardly easier. There is also some fine
print with maintaining a separate driver stack: this prevents particular
devices to be shared between the mainline kernel and the real-time
core. For instance, the real-time SPI framework is currently restricted
to using PIO for transfers because there is no generic way to share the
DMA engine, which would enable real-time capable channels alongside
common ones (the same goes for uart devices). This issue excludes the
stock Xenomai implementation from a number of designs where you cannot
afford to dedicate a CPU core entirely to handle traffic with those
devices, would that even be enough or acceptable (thermal issues and so
on).

Dovetail provides such generic interface, therefore it has to be
maintained across all kernel releases it is ported to (which has not
been an issue so far).

To sum up, and as often, this is a trade-off: either address merge
conflicts, or live with obsolescence, lagging hardware support, and in
some cases face plain bit rot. The I/O driver support for Cobalt
illustrates this:

analogy: not maintained for the past 11 years. A couple of acquisition
devices supported, only one added since the initial merge back in
2009. The whole stack has bit rot since then.

can: sporadic updates over the years mostly to cope with upstream kernel
API changes, a handful of additional controllers added since 2011. Some
drivers may not work with recent hardware, like it happened with i.mx7d
flexcan controllers a couple of years ago. This triggered a full
reimplementation (#c6f278d62) starting from a recent upstream driver
baseline, then merging in the RTDM support piecemeal by
reverse-engineering the obsolete implementation. This was painful.

spi: three controllers supported (for bcm2835, sun6i, omap2), with two
additions since the inception of the real-time SPI framework back in
2016, latest this year (omap2).

serial: three controllers supported (16550, mpc52xx, imx). No addition
since 2012.

net: many NIC drivers received no maintenance since last time hell
froze. More problematic, some drivers are quite complex (e.g. igb),
rebasing the RTnet changes on top of a new upstream version is a
daunting task. Therefore, such task was rarely tackled.

gpio: Six controllers supported (granted, it takes a couple of one
liners to register a new one since the I-pipe actually does most of the
required work). Four were added since the inception of the GPIO
framework back in 2016.

To sum up, there has been little expansion of the device support over
the years to say the least, and it is still limited in scope. This is
either because there was no need to support more devices for most use
cases, or because adding more hardware support is inherently difficult
in the current model. The fact that many real-time drivers are actually
managing custom devices might explain this too (there cannot be any
conflicting merge with upstream by definition in this case).

It boils down to assessing which is more likely, between occasionally
fixing merge conflicts in upstream drivers, or facing obsolete driver
support for new hardware in forked copies of the mainline code.  The
former can be mitigated by limiting the real-time support to
well-defined and simple operations, in addition to tracking the kernel
development tip closely enough so that the differences between releases
are manageable. I see no fix for the latter though: once the original
code is forked, the only practical way to keep up with mainline is to
rewrite the RTDM-based driver, each time the obsolescence has become too
bad to cope with.

>> 
>>>>
>>>> - with hindsight, is maintaining a unified API support between the
>>>>    I-pipe and preempt-rt environments via libcopperplate still relevant,
>>>>    compared to the complexity this brings into the code base? Generally
>>>>    speaking, should Xenomai still pledge to support both environments
>>>>    transparently (which is still not fully the case in absence of a
>>>>    modern native RTDM implementation), or should the project exclusively
>>>>    (re-)focus on its dual kernel technology instead?
>>>
>>> Also a very good question. I've seen contributions and reports for the
>>> mercury setup in the past, but it is very hard to estimate its relevance
>>> today - or its potential when preempt-rt is mainline.
>>>
>>> My guess is that today mercury is highly under-tested in our regular
>>> development and may only work "by chance". Lifting it into automated
>>> testings would be no rocket science, but maintaining it when it needs
>>> care would require someone stepping up - or a clear benefit for the
>>> overall quality of the code base.
>>>
>> Mercury can be seen as a by-product of abstracting the common RTOS
>> features in libcopperplate in order to support legacy RTOS emulation,
>> without having to bloat the kernel with exotic APIs (unlike Xenomai
>> 2.6). As libcopperplate mediates between the app and the real-time core,
>> it has been fairly simple to split the implementation between dual
>> kernel and native preemption support for each of these features.
>> In other words, you should still be able to provide API emulation
>> without native preemption support.
>> 
>>>>
>>>> - should an orphaned stack like Analogy be kept in, knowing that nobody
>>>>    really cared over the years to maintain it since it was merged, back
>>>>    in 2009?
>>>
>>> See above.
>>>
>>>>
>>>> - could significant limitations such as the poor SMP scalability of the
>>>>    Cobalt core be lifted?
>>>
>>> This is a mid- to long-term goal, at least to the degree that
>>> independent applications could run contention free when they are bound
>>> to different cores and do not have common resources.
>> The timer management code is still a common resource you cannot
>> unshare
>> in Cobalt, unless the code is refactored in a way which decouples it
>> from the nklock rules. So as long as a CPU may run real-time tasks, it
>> has to receive clock ticks, therefore the ugly big lock will be required
>> to serialize accesses to the timer management code. Because that code
>> has locking dependencies on the scheduler implementation, the path to a
>> better scalability should start with protecting the timer machinery
>> without relying on that lock.
>> 
>>>
>>> However, fine-grained locking does not come for free and can quickly
>>> lead to complex lock nesting and - at least theoretically - even worse
>>> results. So this will have to be a careful transition. Or EVL proves to
>>> have solved that better in all degrees, and we just jump over.
>>>
>> I believe that the issue of dropping the nklock has been an
>> unfortunate
>> bogeyman since this idea was first floated circa 2008. Obviously, this
>> is not trivial, and this process has to be gradual, removing all
>> roadblocks one after another, which includes rewriting portions of
>> touchy code (like xnsynch). However, the final implemention is far from
>> being that complex. On the contrary, the resulting code is much simpler
>> in the end. To give practical details, a basic lock nesting hierarchy
>> which would fit the Cobalt scheduler can be as simple as:
>> 	thread->lock
>> 		run_queue->lock
>> 		       timer_base->lock
>> No more than three nesting levels would be needed to cover the basic
>> timer and scheduling systems. I can only tell about my experience
>> following this process with the EVL core, which as you know started off
>> from the Cobalt core: after a year running this new scalable
>> implementation with no more big lock inside, I believe the effort to get
>> there was well worth it, not only in terms of SMP performance, but it
>> also helped a lot cleaning up the internal interfaces, such as the core
>> synchronization mechanisms.
>> Last but not least, this effort also helped in addressing the issue
>> of
>> stale references to core objects in a reliable way. Cobalt most often
>> relies on holding the nklock in order to prevent a user (request) from
>> referring to a core object while some other thread might be dismantling
>> it. In some cases, this approach is fragile enough to require the
>> memory-independent, opaque handle representing the object to be
>> re-validated multiple times to make sure the underlying stuff was not
>> wiped out under our feet while we had to temporarily release the big
>> lock for whatever reason. This also means that destructors of internal
>> objects have to hold the big lock, which ends up not looking pretty in
>> latency figures (the jitter caused by hitting ^C when switchtest runs on
>> 4+ CPUs is noticeable).
>> In other words, once one agrees that there should be no big lock
>> anymore, the conversation has to start about how to protect against
>> stale references in a proper, more efficient way.
>
> RCU - which is not simple to get right. But it can solve many of the
> issues where the setup/teardown time does not matter.

Agreed, that would be the canonical way of solving such issue. Today,
both the I-pipe and Dovetail impose that the companion core do not rely
on RCU for maintaining versioned objects which may be accessed from the
out-of-band execution stage. Conversely, they enforce that no EQS is
deemed active for a CPU if that CPU runs out-of-band/primary mode code,
including in user-space.

>
>> 
>>>>
>>>> - is guaranteeing that a single Cobalt release can run over the span of
>>>>    tenths of upstream kernel releases still affordable and sound
>>>>    maintenance-wise? Although some users may be happy with such
>>>>    guarantee, this also limits improvements in the real-time core by
>>>>    having to stick to the least common denominator when it comes to
>>>>    leveraging the latest host kernel features to date, leading to code
>>>>    obsolescence and noisy wrappers (currently, Cobalt must implement
>>>>    things in a way which must build and run on top of kernel 3.10, which
>>>>    is 7-years old).
>>>
>>> We may still have stuff lying around that was designed for making 3.10
>>> happy and was never cleaned up, but even 3.0.x is limited to 4.4 by now
>>> (likely no one is testing older kernels with it).
>>>
>>> I still see value in decoupling the RT core from the kernel, at least as
>>> long as the kernel reasonably permits this. In our domain, there is a
>>> high demand for long-term support, and providing that for n-kernel
>>> versions is already hard when looking at the core patches and its fixes
>>> at different releases. Adding the whole scheduling core and APIs to that
>>> will not make things easier IMHO. Unless someone convinces upstream to
>>> merge a co-scheduling core, that would obviously change the rules...
>>>
>> I see multiple aspects in this discussion which relate to distinct
>> goals
>> and endeavors. I won't discuss the issue of merging a co-scheduling core
>> upstream, because although this would indeed lift many maintenance
>> problems for such core, I don't see this as a prereq for implementing a
>> maintenance process more aligned on what happens upstream. In fact, I
>> would say that the opposite is true: more coupling would be required for
>> submitting anything upstream.
>> I believe it is fair to say that only a tiny fraction of the kernel
>> releases Xenomai 3 officially supports (35 releases or so since v3.10)
>> is routinely tested, only the most recent are, and most of them on x86
>> hardware, thanks to the work of the Siemens team on CI. Not to speak
>> about the actual test coverage (most of the I/O driver support is
>> unlikely to be tested on a regular basis, most of the tests exercise the
>> core system calls instead).
>> Therefore, although there is a single Xenomai code base which in
>> theory
>> might still build on top of any of these ~35 releases, and despite the
>> fact that you are careful about not introducing potential regressions
>> when accepting new code, it would be fairly hazardous to derive from
>> this any practical guarantee that Xenomai 3 would work just fine on
>> every possible legacy kernel release down to v3.10. That validation part
>> is being taken care of by interested users themselves. So I would say
>> that there may be a perceived upside about maintaining the RT core
>> outside of the target kernel tree, but in practice, this only applies to
>> a few kernel releases, with decent but limited test coverage fitting the
>> resources, likely starting with v4.4 as you mentioned.
>> In addition, we have to acknowledge the fact that among the projects
>> deploying Xenomai in industrial solutions, quite a few of them are
>> running vendor kernels, particularly in the ARM world (I'll refrain from
>> trying to figure out why this pain may be self-inflicted for no valid
>> reason in many cases). Since Xenomai (and EVL the same way) exclusively
>> targets mainline kernels, the "one code base for many kernels" perceived
>> advantage I mentioned earlier looks even more shallow there.
>
> Not sure about that. If mainline kernel A < B is supported by the
> core, A <= vendor kernel X <= B would actually be covered as
> well. Provided the vendor didn't mess things up.
>
> Luckily, the need for vendor kernels is constantly falling.
> We are
> also pushing our suppliers hard to improve that further. Almost
> everyone relevant is upstreaming by now, "just" the pace is still
> insufficient.

This is still a fact that vendors fundamentally aim at enabling a device
in order to market it quickly, then move on to the next device
asap. This obviously does not favor long-term maintenance, and does not
help in upstreaming the device support code "quickly enough" (if at all
in many instances).

> And we you are still in need for downstream, e.g. due to
> release timing, you are generally well aligned via LTS and also CIP
> kernels.
>

>> Still, this decoupling may have spared many projects/companies from
>> having to maintain their own Xenomai-enabled linux tree for a slew of
>> possible Xenomai and kernel release combos over time. In other words,
>> those companies might have been outsourcing this long-running
>> maintenance task to the Xenomai project, throughout their product(s)
>> lifetime. Some of them may have been happy with the result, other may
>> have faced issues with some broken Xenomai/linux/architecture combo they
>> had to fix, we actually don't know how to assess how successful this
>> strategy might have been for them given the endemic deficit in feedback.
>> Which brings me back to the point of high demand for long-term
>> support:
>> for sure such support is certainly a requirement in our field, but is
>> properly maintaining and thoroughly testing more than a couple of
>> real-time core/linux combos on a handful of CPU architectures at any
>> point in time, something anyone of us can pledge given the resources at
>> hand? Are Siemens or Intel planning for anything like this?
>> 
>
> As written above: The focus on enabling LTS is a reasonable compromise
> that helps to cover the vast majority of the use cases, I would say.

I would disagree for non-x86 ecosystems. There, people may go for a
vendor kernel in order to start a project asap on the vendor's latest
hardware, regardless of whether we may consider this to be wrong in the
first place. At any rate, LTS/SLTS by definition is rarely an option for
enabling the most recent embedded hardware.

Although I would refrain from basing the entire reasoning on this
particular case, it is still frequent enough not to dismiss it as
irrelevant in the equation.

> SLTS (CIP) maintenance will be handled as long as there is financial
> backing by users.
>
> I don't see a need to support intermediate kernels actively, except
> for head development (if we had the time...). Users sitting for
> products on random trees (including non-stable vendor stuff) need to
> feel the pain of doing things completely wrong, and many are realizing
> that by now.

I don't think the issue at stake is about picking LTS/CIP vs development
tip. This is about how many releases one does pledge to maintain
concurrently over time, guaranteeing that some of them which are deemed
stable do share the same real-time core ABI and feature set. Focusing on
a limited set of kernel releases certainly helps, which ones is a
different issue.

-- 
Philippe.

