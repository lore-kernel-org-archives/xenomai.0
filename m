Subject: Re: Useless dovetail hacks
References: <55694df3-85a8-cca8-1801-d55a4e7f0e53@siemens.com>
 <87ft7os284.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9c76bfeb-f114-0c29-f048-fb51679ad0de@siemens.com>
Date: Fri, 11 Sep 2020 21:16:38 +0200
MIME-Version: 1.0
In-Reply-To: <87ft7os284.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
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
Cc: "Pirou, Florent" <florent.pirou@intel.com>, "Hu, Mingliang" <mingliang.hu@intel.com>, "Wang, Rick Y" <rick.y.wang@intel.com>, xenomai@xenomai.org

On 11.09.20 18:32, Philippe Gerum wrote:
> 
> Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:
> 
>> Hi all,
>>
>> to permit sharing the work of porting Xenomai over dovetail, I finally
>> pushed my baseline hacks to [1]. You can "use" that on [2] (use
>> fa1e9ba5e822, 0d68e5607286 leaks evl bits and is broken)
> 
> Fixed on top of [2] now, thanks.
> 

Thanks, confirmed!

>> just like you
>> would for an I-pipe kernel (prepare-kernel.sh). The thing builds for me,
>> it even starts and gives a prompt, but that's because of
>>
>> [    1.186025] [Xenomai] init failed, code -19
>>
>> All the timing stuff is not mapped yet. Like a lot of other things. ETIME...
>>
> 
> This rough enumeration of what would change in Cobalt as a result of
> rebasing on Dovetail still applies:
> 
> https://xenomai.org/pipermail/xenomai/2020-February/042488.html
> 
> To summarize this, a significant issue would involve switching the
> xntimer abstraction to nanosecs, dropping all references to the internal
> time unit which may be used by the clock and timer devices (e.g. TSC on
> x86, free running counters from assorted ARM/aarch64 timers).

I'm thinking of running with timers/clocks that have a 1:1 translation
in first step. Obviously, that is not optimal.

> 
> Overall, switching to Dovetail entails disabling a significant amount of
> low-level code from Cobalt, which implements features the former already
> handles (like core context switch support, fpu sharing between execution
> stages, shared interrupt support [in xnintr] and reading the POSIX
> clocks from the real-time context via the generic vDSO).
> 
>> Please raise your hand when you'd like to join this endeavor, then we
>> can discuss a split-up of tasks. Next steps would be:
>>
>> - make it initialize dovetail properly and activate Xenomai
>> - hack on it until Xenomai tasks work properly
>> - look at the result an decide how to integrate with I-pipe or whether
>>   to make this Xenomai 3.2 without any I-pipe support
> 
> Assuming you meant that an option might be to enable Xenomai 3.1 to run
> over Dovetail, I would say that a Dovetail-based Cobalt core implies
> Xenomai 3.2+ instead, because 3.1.x is deemed stable, therefore the ABI
> changes involved in such a transition should not make their way into the
> stable tree.  There is also the issue of ppc32 and x86_32, which
> Dovetail does not support.

x86_32 is long gone, no one needs this anymore. ppc32 is different, but
we would not hold breath if one arch is not able to follow in time. I
wouldn't see an issue with leaving a combination initially unsupported.

Anyway, the criteria for 3.2 vs. 3.1 enhancement is whether we can keep
the kernel-user ABI stable. I have no concrete feeling for that yet.
Primarily, we are working on the kernel internals. But prio is on being
able to move forward, and if that is much simpler via a new major
release, than we will do that.

> 
> Although having both ABIs live side-by-side in a way that would maintain
> backward compat with I-pipe kernels might be done, the result would not
> be pretty implementation-wise: redundancies and ugly wrappings to be
> expected in libcobalt, and two set of build settings for the latter
> depending on which ABI is targeted to avoid indirect calls all over the
> place. Which would also require having separate sets of user-space
> libraries, specifically built for one IRQ pipeline core or the
> other, adding to the confusion.

Can you give some example where ipipe concepts "leak" into userspace?

> 
> On a more general note, isn't the issue about which should be the final
> kernel release the project would pledge to support with Xenomai 3.1.x?
> 
> As of today, Xenomai 3.1 is (almost) running kernel 5.4 LTS over the
> I-pipe, at least on x86. If things go as usual upstream, the next LTS
> kernel is going to be post-5.7, which means the effort in porting the
> I-pipe to the next LTS release may be quite significant, with many
> conflicts to expect between the upstream changes and the pipeline code
> starting from kernel 5.8, particularly for x86. For this reason, keeping
> the Cobalt core compatible with the I-pipe beyond kernel 5.4, adding
> support for Dovetail the right way in the meantime seems a hard nut to
> crack maintenance-wise.

Having a 5.4 I-pipe in reach definitely relaxes our pressure to move the
core over dovetail and do many necessary and reasonable refactoring
along that. 5.10 will most likely by the next LTS, and that is what the
dovetail porting is targeting.

> 
> Out of curiosity, are there teams at Intel/Siemens planning for this
> already?

Intel stepped up to work with the I-pipe 5.4 port for x86 and would also
like to support with the dovetail work. At Siemens we are looking at the
y2038 conversion and the dovetail baseline. For the former topic
Chensong is joining us.

> 
> Also, are there any discussions about what the next major Xenomai
> release (i.e. post-3.1) should aim at, particularly in the context of
> upstream's plans to merge the last preempt-rt bits in the 5.10
> timeframe? Should this major Xenomai release be exclusively about
> solving the I-pipe maintenance issue by rebasing Cobalt over Dovetail?

It is surely the primary topic, along with y2038 (with our without
backward compatibility) and associated cleanups. Rather than putting
more on the table, I would prefer getting that release done in a timely
manner, in order to have recent kernel and, thus, also hardware support.

> 
> Could this be also an opportunity to have an all-out conversation about
> the best way to ensure Xenomai stays relevant in the years to come as a
> enabler for a particular class of real-time applications? Are there any
> discussions about the scope and purpose of what Xenomai as a system
> should provide? such as (and not exclusively):
> 
> - is API emulation of legacy RTOS (VxWorks, pSOS) still relevant in this
>   day and age? Corollary: is allowing people to develop their own flavor
>   of whatever real-time API something Xenomai should still provide
>   support for.

That is a valid question, and I would also like to hear voices from the
user community on that.

We do have one of such use case on out side at Siemens, and it's clear
that we will need a certain level of customization on top for some more
years to come. Reducing it is clearly a goal, just a longer effort.

> 
> - how to solve the general issue of driver bit rotting over Cobalt/RTDM?
>   (e.g. can, uart, spi, rtnet)

Drivers for hardware that deceased a decade ago or so should probably be
removed (RTnet hosts several candidates). The rest depends on users
looking for it. Latest when things stop to build and no one notices, we
should start removing more agressively. The next major release should
probable be used to sweep the corners.

As we know, there is no magic answer to this problem. When you split
scheduling and, thus, also synchronization primitives, you automatically
create a second world for drivers. Sharing setup and resource management
logic with Linux, which we do to a certain degree already, mitigates
this a bit but will never solve this fundamental issue. So, only
interfaces/hw that matter enough will see the required extra effort to
run over co-kernel environments.

> 
> - with hindsight, is maintaining a unified API support between the
>   I-pipe and preempt-rt environments via libcopperplate still relevant,
>   compared to the complexity this brings into the code base? Generally
>   speaking, should Xenomai still pledge to support both environments
>   transparently (which is still not fully the case in absence of a
>   modern native RTDM implementation), or should the project exclusively
>   (re-)focus on its dual kernel technology instead?

Also a very good question. I've seen contributions and reports for the
mercury setup in the past, but it is very hard to estimate its relevance
today - or its potential when preempt-rt is mainline.

My guess is that today mercury is highly under-tested in our regular
development and may only work "by chance". Lifting it into automated
testings would be no rocket science, but maintaining it when it needs
care would require someone stepping up - or a clear benefit for the
overall quality of the code base.

> 
> - should an orphaned stack like Analogy be kept in, knowing that nobody
>   really cared over the years to maintain it since it was merged, back
>   in 2009?

See above.

> 
> - could significant limitations such as the poor SMP scalability of the
>   Cobalt core be lifted?

This is a mid- to long-term goal, at least to the degree that
independent applications could run contention free when they are bound
to different cores and do not have common resources.

However, fine-grained locking does not come for free and can quickly
lead to complex lock nesting and - at least theoretically - even worse
results. So this will have to be a careful transition. Or EVL proves to
have solved that better in all degrees, and we just jump over.

> 
> - is guaranteeing that a single Cobalt release can run over the span of
>   tenths of upstream kernel releases still affordable and sound
>   maintenance-wise? Although some users may be happy with such
>   guarantee, this also limits improvements in the real-time core by
>   having to stick to the least common denominator when it comes to
>   leveraging the latest host kernel features to date, leading to code
>   obsolescence and noisy wrappers (currently, Cobalt must implement
>   things in a way which must build and run on top of kernel 3.10, which
>   is 7-years old).

We may still have stuff lying around that was designed for making 3.10
happy and was never cleaned up, but even 3.0.x is limited to 4.4 by now
(likely no one is testing older kernels with it).

I still see value in decoupling the RT core from the kernel, at least as
long as the kernel reasonably permits this. In our domain, there is a
high demand for long-term support, and providing that for n-kernel
versions is already hard when looking at the core patches and its fixes
at different releases. Adding the whole scheduling core and APIs to that
will not make things easier IMHO. Unless someone convinces upstream to
merge a co-scheduling core, that would obviously change the rules...

Jan

> 
> Is anyone having thoughts - and even plans - about any of these issues?
> 
> Thanks,
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

