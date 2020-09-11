References: <55694df3-85a8-cca8-1801-d55a4e7f0e53@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Useless dovetail hacks
In-reply-to: <55694df3-85a8-cca8-1801-d55a4e7f0e53@siemens.com>
Date: Fri, 11 Sep 2020 18:32:59 +0200
Message-ID: <87ft7os284.fsf@xenomai.org>
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
Cc: "Pirou, Florent" <florent.pirou@intel.com>, "Hu,
 Mingliang" <mingliang.hu@intel.com>, "Wang, Rick Y" <rick.y.wang@intel.com>, xenomai@xenomai.org


Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:

> Hi all,
>
> to permit sharing the work of porting Xenomai over dovetail, I finally
> pushed my baseline hacks to [1]. You can "use" that on [2] (use
> fa1e9ba5e822, 0d68e5607286 leaks evl bits and is broken)

Fixed on top of [2] now, thanks.

> just like you
> would for an I-pipe kernel (prepare-kernel.sh). The thing builds for me,
> it even starts and gives a prompt, but that's because of
>
> [    1.186025] [Xenomai] init failed, code -19
>
> All the timing stuff is not mapped yet. Like a lot of other things. ETIME...
>

This rough enumeration of what would change in Cobalt as a result of
rebasing on Dovetail still applies:

https://xenomai.org/pipermail/xenomai/2020-February/042488.html

To summarize this, a significant issue would involve switching the
xntimer abstraction to nanosecs, dropping all references to the internal
time unit which may be used by the clock and timer devices (e.g. TSC on
x86, free running counters from assorted ARM/aarch64 timers).

Overall, switching to Dovetail entails disabling a significant amount of
low-level code from Cobalt, which implements features the former already
handles (like core context switch support, fpu sharing between execution
stages, shared interrupt support [in xnintr] and reading the POSIX
clocks from the real-time context via the generic vDSO).

> Please raise your hand when you'd like to join this endeavor, then we
> can discuss a split-up of tasks. Next steps would be:
>
> - make it initialize dovetail properly and activate Xenomai
> - hack on it until Xenomai tasks work properly
> - look at the result an decide how to integrate with I-pipe or whether
>   to make this Xenomai 3.2 without any I-pipe support

Assuming you meant that an option might be to enable Xenomai 3.1 to run
over Dovetail, I would say that a Dovetail-based Cobalt core implies
Xenomai 3.2+ instead, because 3.1.x is deemed stable, therefore the ABI
changes involved in such a transition should not make their way into the
stable tree.  There is also the issue of ppc32 and x86_32, which
Dovetail does not support.

Although having both ABIs live side-by-side in a way that would maintain
backward compat with I-pipe kernels might be done, the result would not
be pretty implementation-wise: redundancies and ugly wrappings to be
expected in libcobalt, and two set of build settings for the latter
depending on which ABI is targeted to avoid indirect calls all over the
place. Which would also require having separate sets of user-space
libraries, specifically built for one IRQ pipeline core or the
other, adding to the confusion.

On a more general note, isn't the issue about which should be the final
kernel release the project would pledge to support with Xenomai 3.1.x?

As of today, Xenomai 3.1 is (almost) running kernel 5.4 LTS over the
I-pipe, at least on x86. If things go as usual upstream, the next LTS
kernel is going to be post-5.7, which means the effort in porting the
I-pipe to the next LTS release may be quite significant, with many
conflicts to expect between the upstream changes and the pipeline code
starting from kernel 5.8, particularly for x86. For this reason, keeping
the Cobalt core compatible with the I-pipe beyond kernel 5.4, adding
support for Dovetail the right way in the meantime seems a hard nut to
crack maintenance-wise.

Out of curiosity, are there teams at Intel/Siemens planning for this
already?

Also, are there any discussions about what the next major Xenomai
release (i.e. post-3.1) should aim at, particularly in the context of
upstream's plans to merge the last preempt-rt bits in the 5.10
timeframe? Should this major Xenomai release be exclusively about
solving the I-pipe maintenance issue by rebasing Cobalt over Dovetail?

Could this be also an opportunity to have an all-out conversation about
the best way to ensure Xenomai stays relevant in the years to come as a
enabler for a particular class of real-time applications? Are there any
discussions about the scope and purpose of what Xenomai as a system
should provide? such as (and not exclusively):

- is API emulation of legacy RTOS (VxWorks, pSOS) still relevant in this
  day and age? Corollary: is allowing people to develop their own flavor
  of whatever real-time API something Xenomai should still provide
  support for.

- how to solve the general issue of driver bit rotting over Cobalt/RTDM?
  (e.g. can, uart, spi, rtnet)

- with hindsight, is maintaining a unified API support between the
  I-pipe and preempt-rt environments via libcopperplate still relevant,
  compared to the complexity this brings into the code base? Generally
  speaking, should Xenomai still pledge to support both environments
  transparently (which is still not fully the case in absence of a
  modern native RTDM implementation), or should the project exclusively
  (re-)focus on its dual kernel technology instead?

- should an orphaned stack like Analogy be kept in, knowing that nobody
  really cared over the years to maintain it since it was merged, back
  in 2009?

- could significant limitations such as the poor SMP scalability of the
  Cobalt core be lifted?

- is guaranteeing that a single Cobalt release can run over the span of
  tenths of upstream kernel releases still affordable and sound
  maintenance-wise? Although some users may be happy with such
  guarantee, this also limits improvements in the real-time core by
  having to stick to the least common denominator when it comes to
  leveraging the latest host kernel features to date, leading to code
  obsolescence and noisy wrappers (currently, Cobalt must implement
  things in a way which must build and run on top of kernel 3.10, which
  is 7-years old).

Is anyone having thoughts - and even plans - about any of these issues?

Thanks,

-- 
Philippe.

