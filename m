Subject: Re: Useless dovetail hacks
References: <55694df3-85a8-cca8-1801-d55a4e7f0e53@siemens.com>
 <87ft7os284.fsf@xenomai.org>
 <9c76bfeb-f114-0c29-f048-fb51679ad0de@siemens.com>
 <87k0wzdk3h.fsf@xenomai.org>
 <025d306d-4a61-044b-851f-c5c429266af6@siemens.com>
 <87h7rz6svg.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f697d9cf-6a7e-458d-3920-2cbd7a7c3727@siemens.com>
Date: Mon, 21 Sep 2020 07:53:05 +0200
MIME-Version: 1.0
In-Reply-To: <87h7rz6svg.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: song <chensong@tj.kylinos.cn>, Henning Schild <henning.schild@siemens.com>, "Pirou, Florent" <florent.pirou@intel.com>, "Hu, Mingliang" <mingliang.hu@intel.com>, "Wang, Rick Y" <rick.y.wang@intel.com>, xenomai@xenomai.org

On 18.09.20 18:17, Philippe Gerum wrote:
>>>>>
>>>>> - how to solve the general issue of driver bit rotting over Cobalt/RTDM?
>>>>>     (e.g. can, uart, spi, rtnet)
>>>>
>>>> Drivers for hardware that deceased a decade ago or so should probably be
>>>> removed (RTnet hosts several candidates). The rest depends on users
>>>> looking for it. Latest when things stop to build and no one notices, we
>>>> should start removing more agressively. The next major release should
>>>> probable be used to sweep the corners.
>>>>
>>>> As we know, there is no magic answer to this problem. When you split
>>>> scheduling and, thus, also synchronization primitives, you automatically
>>>> create a second world for drivers. Sharing setup and resource management
>>>> logic with Linux, which we do to a certain degree already, mitigates
>>>> this a bit but will never solve this fundamental issue. So, only
>>>> interfaces/hw that matter enough will see the required extra effort to
>>>> run over co-kernel environments.
>>>>
>>> I agree. However, with hindsight and quite some time spent working
>>> on
>>> this issue with EVL, I believe that in many cases, it is possible to
>>> merge the "dual kernel" execution logic into the common driver semantics
>>> in a way which does not require having a separate driver stack, but
>>> rather the common driver model knowing about the out-of-band/primary
>>> mode contexts.
>>> If we cannot make the whole driver run happily in primary mode for
>>> the
>>> reasons you mentioned, it may still be possible to define a set of
>>> simple operations which may do so provided they are mutually exclusive
>>> with the regular driver work, and have them live directly into the
>>> original driver, instead of forking off of the latter to implement an ad
>>> hoc driver, which is pretty much signing up for bit rot down the
>>> road. Although there are still two competing execution contexts (primary
>>> vs secondary in Xenomai's lingo) and only very few bridges between them,
>>> such level of integration limits the amount of -semantically- redundant
>>> code between both.
>>> SPI, DMA, and GPIOs are a no brainer for this and are already
>>> available
>>> in such form, serial and network need more analysis because their
>>> execution contexts are either more clumsy/complex. I also got the PCM
>>> portion of the Alsa stack enabled with a complete I/O path over the
>>> real-time context, from the user (ioctl) request to send/recv frames to
>>> some i2s device, via DMA transactions controlled by the PCM core. As
>>> weird as it may seem, it is actually not that intrusive, and works quite
>>> well, including at insane acquisition rates for feeding an audio
>>> pipeline. There is still some work ahead to fix rough edges, but the
>>> fundamentals look sane.
>>> Overall, the idea is not about preventing people to depend on some
>>> abstract driver interface like RTDM would they wish to, but instead to
>>> make this indirection optional when a deeper integration with the common
>>> device driver model is possible and preferred.
>>> Of course, the whole idea only makes sense if one is willing to
>>> maintain
>>> the real-time core directly into the linux kernel tree, which is how EVL
>>> is maintained.
>>
>> Right, and we will see how well that will scale with an increasing
>> number of drivers patched - even just slightly - in order to add
>> out-of-band support.
>>
> 
> Well, maintaining drivers based on forked code which departed years ago
> from a mainline implementation is hardly easier. There is also some fine
> print with maintaining a separate driver stack: this prevents particular
> devices to be shared between the mainline kernel and the real-time
> core. For instance, the real-time SPI framework is currently restricted
> to using PIO for transfers because there is no generic way to share the
> DMA engine, which would enable real-time capable channels alongside
> common ones (the same goes for uart devices). This issue excludes the
> stock Xenomai implementation from a number of designs where you cannot
> afford to dedicate a CPU core entirely to handle traffic with those
> devices, would that even be enough or acceptable (thermal issues and so
> on).
> 
> Dovetail provides such generic interface, therefore it has to be
> maintained across all kernel releases it is ported to (which has not
> been an issue so far).
> 
> To sum up, and as often, this is a trade-off: either address merge
> conflicts, or live with obsolescence, lagging hardware support, and in
> some cases face plain bit rot. The I/O driver support for Cobalt
> illustrates this:
> 
> analogy: not maintained for the past 11 years. A couple of acquisition
> devices supported, only one added since the initial merge back in
> 2009. The whole stack has bit rot since then.
> 
> can: sporadic updates over the years mostly to cope with upstream kernel
> API changes, a handful of additional controllers added since 2011. Some
> drivers may not work with recent hardware, like it happened with i.mx7d
> flexcan controllers a couple of years ago. This triggered a full
> reimplementation (#c6f278d62) starting from a recent upstream driver
> baseline, then merging in the RTDM support piecemeal by
> reverse-engineering the obsolete implementation. This was painful.
> 
> spi: three controllers supported (for bcm2835, sun6i, omap2), with two
> additions since the inception of the real-time SPI framework back in
> 2016, latest this year (omap2).
> 
> serial: three controllers supported (16550, mpc52xx, imx). No addition
> since 2012.
> 
> net: many NIC drivers received no maintenance since last time hell
> froze. More problematic, some drivers are quite complex (e.g. igb),
> rebasing the RTnet changes on top of a new upstream version is a
> daunting task. Therefore, such task was rarely tackled.
> 
> gpio: Six controllers supported (granted, it takes a couple of one
> liners to register a new one since the I-pipe actually does most of the
> required work). Four were added since the inception of the GPIO
> framework back in 2016.
> 
> To sum up, there has been little expansion of the device support over
> the years to say the least, and it is still limited in scope. This is
> either because there was no need to support more devices for most use
> cases, or because adding more hardware support is inherently difficult
> in the current model. The fact that many real-time drivers are actually
> managing custom devices might explain this too (there cannot be any
> conflicting merge with upstream by definition in this case).
> 
> It boils down to assessing which is more likely, between occasionally
> fixing merge conflicts in upstream drivers, or facing obsolete driver
> support for new hardware in forked copies of the mainline code.  The
> former can be mitigated by limiting the real-time support to
> well-defined and simple operations, in addition to tracking the kernel
> development tip closely enough so that the differences between releases
> are manageable. I see no fix for the latter though: once the original
> code is forked, the only practical way to keep up with mainline is to
> rewrite the RTDM-based driver, each time the obsolescence has become too
> bad to cope with.
> 

The truth is likely in the middle: Maintainable baseline drivers, like 
for GPIO, SPI, DMA, are probably better kept in-tree as they are also 
more easy to maintain there. When Dovetail does of that, we all benefit.

How more complex stacks that require not only replacing a few locks are 
best handled is to be seen IMHO. RTnet is a good example where the 
current way does not work for the drivers. However, if you started to 
patch tons of in-tree drivers as needed for deterministic operation, 
rebasing the baseline patch will quickly become much more work than it 
is already. That can't be the solution either.

Possibly the answer is splitting the patches more. The baseline should 
not depend on people doing lifting also for lots of drivers, many of 
them limited to certain archs or SOCs. What we primarily need is the 
baseline to be handy and maintainable.

>>>
>>>>>
>>>>> - with hindsight, is maintaining a unified API support between the
>>>>>     I-pipe and preempt-rt environments via libcopperplate still relevant,
>>>>>     compared to the complexity this brings into the code base? Generally
>>>>>     speaking, should Xenomai still pledge to support both environments
>>>>>     transparently (which is still not fully the case in absence of a
>>>>>     modern native RTDM implementation), or should the project exclusively
>>>>>     (re-)focus on its dual kernel technology instead?
>>>>
>>>> Also a very good question. I've seen contributions and reports for the
>>>> mercury setup in the past, but it is very hard to estimate its relevance
>>>> today - or its potential when preempt-rt is mainline.
>>>>
>>>> My guess is that today mercury is highly under-tested in our regular
>>>> development and may only work "by chance". Lifting it into automated
>>>> testings would be no rocket science, but maintaining it when it needs
>>>> care would require someone stepping up - or a clear benefit for the
>>>> overall quality of the code base.
>>>>
>>> Mercury can be seen as a by-product of abstracting the common RTOS
>>> features in libcopperplate in order to support legacy RTOS emulation,
>>> without having to bloat the kernel with exotic APIs (unlike Xenomai
>>> 2.6). As libcopperplate mediates between the app and the real-time core,
>>> it has been fairly simple to split the implementation between dual
>>> kernel and native preemption support for each of these features.
>>> In other words, you should still be able to provide API emulation
>>> without native preemption support.
>>>
>>>>>
>>>>> - should an orphaned stack like Analogy be kept in, knowing that nobody
>>>>>     really cared over the years to maintain it since it was merged, back
>>>>>     in 2009?
>>>>
>>>> See above.
>>>>
>>>>>
>>>>> - could significant limitations such as the poor SMP scalability of the
>>>>>     Cobalt core be lifted?
>>>>
>>>> This is a mid- to long-term goal, at least to the degree that
>>>> independent applications could run contention free when they are bound
>>>> to different cores and do not have common resources.
>>> The timer management code is still a common resource you cannot
>>> unshare
>>> in Cobalt, unless the code is refactored in a way which decouples it
>>> from the nklock rules. So as long as a CPU may run real-time tasks, it
>>> has to receive clock ticks, therefore the ugly big lock will be required
>>> to serialize accesses to the timer management code. Because that code
>>> has locking dependencies on the scheduler implementation, the path to a
>>> better scalability should start with protecting the timer machinery
>>> without relying on that lock.
>>>
>>>>
>>>> However, fine-grained locking does not come for free and can quickly
>>>> lead to complex lock nesting and - at least theoretically - even worse
>>>> results. So this will have to be a careful transition. Or EVL proves to
>>>> have solved that better in all degrees, and we just jump over.
>>>>
>>> I believe that the issue of dropping the nklock has been an
>>> unfortunate
>>> bogeyman since this idea was first floated circa 2008. Obviously, this
>>> is not trivial, and this process has to be gradual, removing all
>>> roadblocks one after another, which includes rewriting portions of
>>> touchy code (like xnsynch). However, the final implemention is far from
>>> being that complex. On the contrary, the resulting code is much simpler
>>> in the end. To give practical details, a basic lock nesting hierarchy
>>> which would fit the Cobalt scheduler can be as simple as:
>>> 	thread->lock
>>> 		run_queue->lock
>>> 		       timer_base->lock
>>> No more than three nesting levels would be needed to cover the basic
>>> timer and scheduling systems. I can only tell about my experience
>>> following this process with the EVL core, which as you know started off
>>> from the Cobalt core: after a year running this new scalable
>>> implementation with no more big lock inside, I believe the effort to get
>>> there was well worth it, not only in terms of SMP performance, but it
>>> also helped a lot cleaning up the internal interfaces, such as the core
>>> synchronization mechanisms.
>>> Last but not least, this effort also helped in addressing the issue
>>> of
>>> stale references to core objects in a reliable way. Cobalt most often
>>> relies on holding the nklock in order to prevent a user (request) from
>>> referring to a core object while some other thread might be dismantling
>>> it. In some cases, this approach is fragile enough to require the
>>> memory-independent, opaque handle representing the object to be
>>> re-validated multiple times to make sure the underlying stuff was not
>>> wiped out under our feet while we had to temporarily release the big
>>> lock for whatever reason. This also means that destructors of internal
>>> objects have to hold the big lock, which ends up not looking pretty in
>>> latency figures (the jitter caused by hitting ^C when switchtest runs on
>>> 4+ CPUs is noticeable).
>>> In other words, once one agrees that there should be no big lock
>>> anymore, the conversation has to start about how to protect against
>>> stale references in a proper, more efficient way.
>>
>> RCU - which is not simple to get right. But it can solve many of the
>> issues where the setup/teardown time does not matter.
> 
> Agreed, that would be the canonical way of solving such issue. Today,
> both the I-pipe and Dovetail impose that the companion core do not rely
> on RCU for maintaining versioned objects which may be accessed from the
> out-of-band execution stage. Conversely, they enforce that no EQS is
> deemed active for a CPU if that CPU runs out-of-band/primary mode code,
> including in user-space.

I was not thinking up the kernel's RCU, rather our own implementation.

[...]
>>> Still, this decoupling may have spared many projects/companies from
>>> having to maintain their own Xenomai-enabled linux tree for a slew of
>>> possible Xenomai and kernel release combos over time. In other words,
>>> those companies might have been outsourcing this long-running
>>> maintenance task to the Xenomai project, throughout their product(s)
>>> lifetime. Some of them may have been happy with the result, other may
>>> have faced issues with some broken Xenomai/linux/architecture combo they
>>> had to fix, we actually don't know how to assess how successful this
>>> strategy might have been for them given the endemic deficit in feedback.
>>> Which brings me back to the point of high demand for long-term
>>> support:
>>> for sure such support is certainly a requirement in our field, but is
>>> properly maintaining and thoroughly testing more than a couple of
>>> real-time core/linux combos on a handful of CPU architectures at any
>>> point in time, something anyone of us can pledge given the resources at
>>> hand? Are Siemens or Intel planning for anything like this?
>>>
>>
>> As written above: The focus on enabling LTS is a reasonable compromise
>> that helps to cover the vast majority of the use cases, I would say.
> 
> I would disagree for non-x86 ecosystems. There, people may go for a
> vendor kernel in order to start a project asap on the vendor's latest
> hardware, regardless of whether we may consider this to be wrong in the
> first place. At any rate, LTS/SLTS by definition is rarely an option for
> enabling the most recent embedded hardware.

The very same is true for the majority of ARM vendors. I do not see a 
single one NOT basing their downstream mess on a non-LTS kernel anymore. 
That's why this strategy is working for many years now. You do not need 
intermediate kernels in practice anymore, even if you have a vendor tree.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

