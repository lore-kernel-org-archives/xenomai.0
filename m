From: Philippe Gerum <rpm@xenomai.org>
Subject: Dovetail <-> PREEMPT_RT hybridization
Message-ID: <2c2da877-f9e7-9be7-d659-c51235738bc0@xenomai.org>
Date: Mon, 20 Jul 2020 22:47:29 +0200
MIME-Version: 1.0
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
To: Evl <evl@evlproject.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


FWIW, I'm investigating the opportunity for rebasing Dovetail - and therefore
the EVL core - on the PREEMPT_RT code base, ahead of the final integration of
the latter into the mainline kernel tree. In the same move, the goal would be
to leverage the improvements brought by native preemption with respect to
fine-grained interrupt protection, while keeping the alternate scheduling [1]
feature, which still exhibits significantly shorter preemption times and much
cleaner jitter compared to what is - at least currently - achievable with a
plain PREEMPT_RT kernel under meaningful stress.

With such hybridization, the Dovetail implementation should be even simpler.
Companion cores based on it could run on the out-of-band execution stage
unimpeded by other forms of preemption disabling in the in-band kernel (e.g.
locks). This would preserve the most significant advantage of the pipelining
model when it comes to reliable response times for applications at a modest
processing cost by a lightweight real-time infrastructure.

This work entails porting the latest Dovetail code base I have been working on
lately from 5.8 back to 5.6-rt, since this is the most recent public release
of PREEMPT_RT so far. In addition, interrupt-free sections which are deemed
too long for the companion core on top to cope with, need to be identified in
the target PREEMPT_RT release so that they could be mitigated (see below for
an explanation about how it could be done). In the future, a way to automate
such research should be looked for, since finding these spots is likely going
to be the boring task to carry out each time this new Dovetail implementation
is ported to the next PREEMPT_RT release. Plus, the truckload of other tricky
issues I may have overlooked.

If anyone is interested in participating in this work, let me know. I cannot
guarantee success, but the data I have collected over time with both the dual
kernel and native preemption models leaves me optimistic about the outcome if
they are combined the right way.

-- Nitty-gritty details about why and how to do this

Those acquainted with the interrupt pipelining technique Dovetail implements
[2] may already know that decoupling the interrupt mask flag as perceived by
the CPU from the one perceived by the kernel induces a number of tricky
issues. We want interrupts to be unmasked in the CPU as long as possible while
the kernel runs; to this end local_irq_*() helpers are switched to a
software-based implementation which virtualizes the interrupt mask as
perceived by the kernel, while leaving interrupts enabled in the CPU,
postponing the delivery of IRQs blocked by the virtual masking until they are
accepted again by the kernel (aka "stall bit"). This is a plain simple
log-if-blocked-then-replay-when-unblocked game [3].

However, we also have to synchronize the hardware and software interrupt masks
in some specific places of the kernel in order to keep some hardware and
software logic happy. Two examples come to mind, there are more of them:

- hardware-wise, we want updates to some registers to remain fully atomic
despite the fact interrupt pipelining is in effect. For arm64, we have to
ensure that updates to the translation table registers (TTBRs) cannot be
preempted, likewise for updates to the CR4 register on x86 which is notably
used during TLB management.  In both cases, we have to locally revert/override
the changes Dovetail implicitly did by re-introducing CPU-based forms of
interrupt disabling, instead of the software-based one.

- software-wise, maintaining the LOCKDEP logic usable in a pipelined system
requires fixing up the virtual interrupt mask on kernel boundaries between
kernel and user mode, so that it properly reflects what the locking validation
engine expects at all times. This has been the most time-consuming work in a
number of Dovetail upgrades to recent kernel releases, 5.8-rc included.
Besides, I'm still not happy with the way this is done, which looks like
playing whack-a-mole to some extent.

Many of these issues are hard to identify, some may not be trivial to address
(LOCKDEP support can become really ugly in this respect). Several other
sub-systems like CPU idleness and power management have similar requirements
for particular code paths.

Now, we may have another option for gaining fine-grained interrupt protection,
which would build on the relentless work the PREEMPT_RT folks did about
shrinking the interrupt-free sections in the kernel code to the bare minimum
which is acceptable for native preemption, by threading IRQs and introducing
sleeping locks mainly.

Instead of systematizing the virtualization of the local_irq_*() helpers, we
could switch them back to their original - hardware-based - behavior, adding
controlled mask-breaking statements manually to any remaining problematic code
path. Such statement would enable interrupts in the CPU while blocking them
for the in-band kernel, using a local, non-pervasive variant of the current
interrupt pipeline.

Within those long interrupt-free sections created by the in-band code, the
companion core would nevertheless be allowed to process pending interrupts
immediately while maintaining the interrupt protection for the in-band kernel.
Identifying these sections for enabling the out-of-band code to preempt
locally should be a matter of properly using the irqsoff tracer, provided the
trace_hardirqs* instrumentation is correct.

e.g. roughly sketching a possible use case:

__schedule()
lock(rq) /* hard irqs off */
...
context_switch()
	switch_mm
	switch_to
...
unlock(rq) /* hard irqs on */

The interrupt-free section above could amount to tenths of microseconds on
armv7 under significant pressure (especially with a sluggish L2 outer cache)
and would prevent the out-of-band (companion) core to preempt in the meantime.
To address this, switching the virtual interrupt state could be done manually
by some dedicated service, say, "oob_synchronize()", which would first stall
the in-band stage to keep the code interrupt-free in-band wise, then allow any
pending hard IRQ to be taken by toggling the CPU mask flag, possibly some of
which the companion core would handle. Other IRQs to be handled by the in-band
code would have to wait into a deferred interrupt log until hard IRQs are
generally re-enabled later on, which is what happens today with the common
pipelining technique on a broader scope.

__schedule()
lock(rq) /* hard irqs off */
...
context_switch()
	switch_mm
	cond_sync_oob(); /* pending IRQs are synchronized for oob only */
	switch_to
...
unlock(rq) /* hard irqs on */

Ideally, switch_mm() should allow out-of-band IRQs to flow normally while
changing the memory context for in-band tasks - we once had that for armv4/5
in the early days of the I-pipe, but this would require non-trivial magic to
do this properly in current kernels. So maybe next when all the rest is
functional.

Congrats if you read up to there. Comments welcome as usual.

[1] https://evlproject.org/dovetail/altsched/
[2]
https://www.usenix.org/legacy/publications/library/proceedings/micro93/full_papers/stodolsky.txt
[3] https://evlproject.org/dovetail/pipeline/#virtual-i-flag

-- 
Philippe.

