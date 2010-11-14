From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CDD8AA1.4060407@domain.hid>
References: <20101007115728.GA24500@domain.hid>
	<1288025329.26618.132.camel@domain.hid>  <4CC5C80E.2070004@domain.hid>
	<1288033731.26618.161.camel@domain.hid>  <4CC5D742.9080307@domain.hid>
	<1288034435.26618.164.camel@domain.hid>  <4CC5D8FF.5080109@domain.hid>
	<1288041166.26618.182.camel@domain.hid>  <4CC5F525.7040206@domain.hid>
	<1288042858.26618.204.camel@domain.hid>  <4CC5FAE6.6010305@domain.hid>
	<1288068231.26618.224.camel@domain.hid> <4CC665A1.9040707@domain.hid>
	<4CC72D27.3010607@domain.hid> <1288243034.1816.14.camel@domain.hid>
	<4CC926BE.7040105@domain.hid>  <1288251968.1816.22.camel@domain.hid>
	<1289142959.1842.295.camel@domain.hid> <4CD6D22C.2030708@domain.hid>
	<4CD8FFC4.5040202@domain.hid> <1289291217.1957.16.camel@domain.hid shift>
	<4CD908AD.9000202@domain.hid> <1289295412.1957.32.camel@domain.hid>
	<4CD948BB.4040201@domain.hid> <1289551711.1937.108.camel@domain.hid>
	<4CDD055C.6040103@domain.hid> <1289570246.1937.422.camel@domain.hid>
	<4CDD4F85.6030009@domain.hid> <1289583759.1937.517.camel@domain.hid>
	<4CDD8AA1.4060407@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 14 Nov 2010 22:28:46 +0100
Message-ID: <1289770126.1934.693.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel oopses when killing realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2010-11-12 at 19:42 +0100, Jan Kiszka wrote: 
> Am 12.11.2010 18:42, Philippe Gerum wrote:
> > On Fri, 2010-11-12 at 15:30 +0100, Jan Kiszka wrote: 
> >> Am 12.11.2010 14:57, Philippe Gerum wrote:
> >>> On Fri, 2010-11-12 at 10:14 +0100, Jan Kiszka wrote:
> >>>> Am 12.11.2010 09:48, Philippe Gerum wrote:
> >>>>> On Tue, 2010-11-09 at 14:12 +0100, Jan Kiszka wrote:
> >>>>>> Am 09.11.2010 10:36, Philippe Gerum wrote:
> >>>>>>> On Tue, 2010-11-09 at 09:39 +0100, Jan Kiszka wrote:
> >>>>>>>> Am 09.11.2010 09:26, Philippe Gerum wrote:
> >>>>>>>>> On Tue, 2010-11-09 at 09:01 +0100, Jan Kiszka wrote:
> >>>>>>>>>> Am 07.11.2010 17:22, Jan Kiszka wrote:
> >>>>>>>>>>> Am 07.11.2010 16:15, Philippe Gerum wrote:
> >>>>>>>>>>>> The following patches implements the teardown approach. The basic idea
> >>>>>>>>>>>> is:
> >>>>>>>>>>>> - neither break nor improve old setups with legacy I-pipe patches not
> >>>>>>>>>>>> providing the revised ipipe_control_irq call.
> >>>>>>>>>>>> - fix the SMP race when detaching interrupts.
> >>>>>>>>>>>
> >>>>>>>>>>> Looks good.
> >>>>>>>>>>
> >>>>>>>>>> This actually causes one regression: I've just learned that people are
> >>>>>>>>>> already happily using MSIs with Xenomai in the field. This is perfectly
> >>>>>>>>>> fine as long as you don't fiddle with rtdm_irq_disable/enable in
> >>>>>>>>>> non-root contexts or while hard IRQs are disable. The latter requirement
> >>>>>>>>>> would be violated by this fix now.
> >>>>>>>>>
> >>>>>>>>> What we could do is handle this corner-case in the ipipe directly, going
> >>>>>>>>> for a nop when IRQs are off on a per-arch basis only to please those
> >>>>>>>>> users,
> >>>>>>>>
> >>>>>>>> Don't we disable hard IRQs also then the root domain is the only
> >>>>>>>> registered one? I'm worried about pushing regressions around, then to
> >>>>>>>> plain Linux use-cases of MSI (which are not broken in anyway - except
> >>>>>>>> for powerpc).
> >>>>>>>
> >>>>>>> The idea is to provide an ad hoc ipipe service for this, to be used by
> >>>>>>> the HAL. A service that would check the controller for the target IRQ,
> >>>>>>> and handle MSI ones conditionally. For sure, we just can't put those
> >>>>>>> conditionally bluntly into the chip mask handler and expect the kernel
> >>>>>>> to be happy.
> >>>>>>>
> >>>>>>> In fact, we already have __ipipe_enable/disable_irq from the internal
> >>>>>>> Adeos interface avail, but they are mostly wrappers for now. We could
> >>>>>>> make them a bit more smart, and handle the MSI issue as well. We would
> >>>>>>> then tell the HAL to switch to using those arch-agnostic helpers
> >>>>>>> generally, instead of peeking directly into the chip controller structs
> >>>>>>> like today.
> >>>>>>
> >>>>>> This belongs to I-pipe, like we already have ipipe_end, just properly
> >>>>>> wrapped to avoid descriptor access. That's specifically important if we
> >>>>>> want to emulate MSI masking in software. I've the generic I-pipe
> >>>>>> infrastructure ready, but the backend, so far consisting of x86 MSI
> >>>>>> hardening, unfortunately needs to be rewritten.
> >>>>>>
> >>>>>>>
> >>>>>>> If that ipipe "feature" is not detected by the HAL, then we would
> >>>>>>> refrain from disabling the IRQ in xnintr_detach. In effect, this would
> >>>>>>> leave the SMP race window open, but since we need recent ipipes to get
> >>>>>>> it plugged already anyway (for the revised ipipe_control_irq), we would
> >>>>>>> still remain in the current situation:
> >>>>>>> - old patches? no SMP race fix, no regression
> >>>>>>> - new patches? SMP race fix avail, no regression
> >>>>>>
> >>>>>> Sounds good.
> >>>>>
> >>>>> Now that I slept on it, I find the approach of working around pipeline
> >>>>> limitations this way, to be incorrect.
> >>>>>
> >>>>> Basically, the issue is that we still don't have 100% reliable handling
> >>>>> of MSI interrupts (actually, we only have partial handling, and solely
> >>>>> for x86), but this is no reason to introduce code in the pipeline
> >>>>> interface which would perpetuate this fact. I see this as a "all or
> >>>>> nothing" issue: either MSI is fully handled and there shall be no
> >>>>> restriction on applying common operations such as masking/unmasking on
> >>>>> the related IRQs, or it is not, and we should not export "conditionally
> >>>>> working" APIs.
> >>>>>
> >>>>> In the latter case, the responsibility to rely on MSI support belongs to
> >>>>> the user, which then should know about the pending restrictions, and
> >>>>> decides for himself whether to use MSI. So I'm heading to this solution
> >>>>> instead:
> >>>>>
> >>>>> - when detaching the last handler for a given IRQ, instead of forcibly
> >>>>> disabling the IRQ line, the nucleus would just make sure that such IRQ
> >>>>> is already in a disabled state, and bail out on error if not (probably
> >>>>> with a kernel warning to make the issue obvious).
> >>>>
> >>>> Fiddling with the IRQ "line" state is a workaround for the missing
> >>>> synchronize_irq service in Xenomai/I-pipe. If we had this, all this
> >>>> disabling become unneeded.
> >>>
> >>> Actually, no. The synchronize irq service in the pipeline could have
> >>> been introduced weeks ago in a snap, provided Xenomai did not call
> >>> ipipe_virtualize_irq holding a lock with irqs off - this is in essence
> >>> what my first patch to Pavel did, but could not work for the reason
> >>> mentioned. That is what the patch we are discussing now is all about:
> >>> clearing issues in Xenomai first.
> >>>
> >>> Additionally, having an IRQ disabled is a requirement to properly
> >>> synchronize that IRQ later, it is not an option. It is part of the sync
> >>> protocol actually. If you don't do this, it lacks a basic guarantee, it
> >>> can't work.
> >>
> >> The required pattern from driver POV is
> >>  - disable IRQ at device level
> >>  - flush pending IRQs
> >>  - deregister handler
> >>
> >> Linux does the last two steps in reverse order as it synchronizes
> >> descriptor changes against descriptor usage internally. I-pipe requires
> >> the above ordering (unless my patch is used to harden
> >> ipipe_virtualize_irq against NULL handlers). Still, the driver should
> >> find step 2 and 3 as part of rtdm_irq_free. That's all.
> >>
> > 
> > It looks like you are omitting the disable IRQ line step which free_irq
> > does when no more handler is attached to the line. You don't seem to
> > take into account that pipeline-wise, synchronizing an IRQ upon shutdown
> > requires to mask it first at PIC level, either.
> 
> Disabling at IRQ controller level is a step which is not conceptually
> required to perform a safe shutdown. It is likely applied to suppress
> spurious IRQs due to buggy hardware.

Your interpretation is broader than what the kernel doc actually says.
Only shared IRQs are mentioned as candidates for device disabling first
in free_irq(), simply because we may need the IRQ line to remain enabled
for other drivers, that is the only documented prerequisite.

My interpretation of disable_irq() in __free_irq(), is that it keeps the
invariant that an IRQ line should remain disabled until a handler is
registered. Dealing with buggy hardware is a useful side-effect, which
also happens to deal with buggy drivers not doing device_disable
properly.

Many linux drivers - particularly in the embedded space - assume to deal
with non-shared interrupts, which they expect to be in a disable state
before they call request_irq for them. I'm not saying this is correct in
theory, but quite common in practice.

> > 
> >> Jan 
> >>>
> >>>>
> >>>>>
> >>>>> - track the IRQ line state from xnintr_enable/xnintr_disable routines,
> >>>>> so that xnintr_detach can determine whether the call is legit. Of
> >>>>> course, this also means that any attempt to take sideways to
> >>>>> enable/disable nucleus managed interrupts at PIC level would break that
> >>>>> logic, but doing so would be the root bug anyway.
> >>>>>
> >>>>> The advantage of doing so would be three-fold:
> >>>>>
> >>>>> - no pipeline code to acknowledge (or even perpetuate) the fact that MSI
> >>>>> support is half working, half broken. We need to fix it properly, so
> >>>>> that we can use it 100% reliably, from whatever context commonly allowed
> >>>>> for enabling/disabling IRQs (and not "from root domain with IRQs on"
> >>>>> only). Typically, I fail to see how one would cope with such limitation,
> >>>>> if a real-time handler detects that some device is going wild and really
> >>>>> needs to shut it down before the whole system crashes.
> >>>>
> >>>> MSIs are edge-triggered. Only broken hardware continuously sending bogus
> >>>> messages can theoretically cause troubles. In practice (ie. in absence
> >>>> of broken HW), we see a single spurious IRQ at worst.
> >>>>
> >>>
> >>> The driver should be able to work the same way whether it deals with MSI
> >>> support, or is given pinned (level) IRQs.
> >>
> >> Exactly my point, thus rtdm_irq_disable in driver code is a no-go.
> >>
> > 
> > Since you don't have such things as shared MSIs, the only issue is with
> > non-shared handling. And disabling the interrupt line for a non-shared
> > handler which is being deregistered makes sense, in all cases, MSI or
> > not. The fact that MSI support is broken today for us does not mean that
> > we should design a broken xnintr_detach API to cope with that -
> > hopefully temporary - limitation. So, xnarch_disable_irq in
> > xnintr_detach is obviously correct, even if we currently have to refrain
> > from doing this for non-shared handlers because of MSI.
> 
> It is not incorrect, but it must not be mandatory for proper shutdown.
> 

Not for shutdown, but for consistency of interrupt states.

> > 
> >>>
> >>>>>
> >>>>> - we enforce the API usage requirement to disable an interrupt line with
> >>>>> rtdm_irq_disable(), before eventually detaching the last IRQ handler for
> >>>>> it, which is common sense anyway.
> >>>>
> >>>> That's an easy-to-get-wrong API. It would apply to non-shared IRQs only
> >>>> (aka MSIs). No-go IMHO.
> >>>
> >>> - the software does not want to share MSIs, or something is quite wrong
> >>> - xnintr_detach() is broken by design in its current implementation for
> >>> shared handlers, because it leaves the decision to mask the IRQ line to
> >>> the user. This could not work for multiple non-cooperating drivers
> >>> sharing an IRQ, at least not in a raceless way.
> >>
> >> It works (minus the missing synchronize_irq) if you disable the IRQ at
> >> device level as drivers normally do.
> > 
> > synchronize_irq without prior IRQ disabling does not work for the
> > pipeline. So relying on synchronize_irq to only mask at device level
> > without disabling the IRQ line just does not work.
> 
> It is not implemented, but it is not impossible. It takes
> synchronization on hard IRQ context exits on all CPUs and waiting on
> deassertion of any pending bit for that IRQ in question. That is surely
> implementable if we wanted to.
> 

Yes, I don't challenge that. But it is not as trivial and cheap as it
may seem; for this to work we would need to serialize interrupts among
all CPUs with a per-descriptor lock at pipeline level, for introducing
some kind of "in progress" bit, because you can't rely on the pending
bit.

In short:

- using a dummy handler + busy wait would work, at the expense of more
overhead for handling every IRQ and perhaps more issues ahead.
- using a critical IPI to switch the irq in pass/discard on each CPU
synchronously works and actually fits the pipeline model, but requires
to drop all Xenomai locks while synchronizing to prevent deadlocks.

> > 
> >>>
> >>> So the issue is not that much about MSI vs pinned-type IRQs, it is
> >>> rather about shared vs non-shared interrupts. What we want is a sane API
> >>> and behavior for both types, which happens to fit the limited support we
> >>> have now for MSI, not the other way around.
> >>>
> >>> Therefore, until the MSI issue is fixed in the pipeline:
> >>>
> >>> - non-shared mode users should call xnintr_disable(irq) then
> >>> xnintr_detach(irq) explicitly. This is what everybody should do today
> >>> already (via rtdm_irq_disable() or whatever), since xnintr_detach() does
> >>> not disable the IRQ in the current implementation.
> >>
> >> No one should call rtdm_irq_disable today for whatever IRQ unless in
> >> very few exceptional cases. I think I should extend the documentation of
> >> rtdm_irq_enabled/disable ASAP to clarify their exceptional nature.
> >>
> > 
> > rtdm_irq_enable() is required to startup the IRQ line, since Xenomai
> > leaves interrupts in a disabled state at descriptor init time, so this
> > one is hardly exceptionally used.
> 
> Nope it isn't. That's rtdm_irq_request business for quite a while now -
> for a good reason: to avoid that driver writers introduce bugs by
> calling rtdm_irq_disable on shutdown.
> > 
> > rtdm_irq_disable() should be seldomly used indeed, provided the MSI
> > support is fixed. Until then, xnintr_detach won't be allowed to disable
> > non-shared interrupts. But if you discourage disabling IRQs in general
> > before detaching them, then you basically tell people that their driver
> > should not expect the system to help them in any way for synchronizing
> > IRQs, and this is something I disagree with.
> 
> Driver writers should not bother about internals of Xenomai here.
> rtdm_irq_disable before rtdm_irq_free is not required and should not
> show up in properly written drivers. If that's not true today or after
> upcoming fixes, Xenomai needs to be fixed.

This is not primarily a Xenomai issue, but two pipeline issues:

- disabling or enabling MSIs via the pipeline interface only from
restricted contexts.

- lack of built in synchronization mechanism in ipipe_virtualize_irq.

What has to be changed in Xenomai is the calling context for
ipipe_virtualize_irq, so that the latter allows proper synchronization
internally.

> 
> > 
> >>>
> >>> - shared mode users should only call xnintr_detach(irq), which would
> >>> then decide racelessly whether to disable the line. In essence, this
> >>> could never affect MSIs.
> >>>
> >>> When the MSI support is generally available with no limitation on
> >>> masking/unmasking contexts, then xnintr_detach() could be updated to
> >>> forcibly disable the detached IRQ in the non-shared case as well. At
> >>> worst, the legacy code would end up calling xnintr_disable() uselessly
> >>> when the pipeline fix is merged.
> >>>
> >>> What we can do in the meantime, is 1) fixing xnintr_detach() in the
> >>> shared case, 2) introducing an error check to prevent detaching
> >>> non-shared IRQs that are still enabled. That won't have any impact on
> >>> the partial MSI support we have today.
> >>>
> >>>>
> >>>>>
> >>>>> - absolutely no change for people who currently rely on partial MSI
> >>>>> support, provided they duly disable IRQ lines before detaching their
> >>>>> last handler via the appropriate RTDM interface.
> >>>>>
> >>>>> Can we deal on this?
> >>>>>
> >>>>
> >>>> Nope, don't think so. The only option I see (besides using my original
> >>>> proposal of a dummy handler for deregistering - still much simpler than
> >>>> the current patches) is to emulate MSI masking in the same run, thus
> >>>> providing solutions for both issues.
> >>>
> >>> The dummy handler solution is incomplete because it does not address the
> >>> IRQ disabling issue in xnintr_detach() for shared IRQs. This is the gist
> >>> of the patch I sent, actually.
> >>
> >> It is complete in this regard as it does not touch the line state. It
> >> actually implements the Linux pattern.
> >>
> > 
> > The linux pattern in free_irq(), which is semantically equivalent of
> > xnintr_detach() for us does include IRQ disabling when the last handler
> > is detached. Introducing the dummy handler looks a bit like papering
> > over the issue, so that weakly synchronized xnintr_detach() might be
> > sufficient. I don't agree there.
> 
> Linux disables the line after removing the handler. Disabling has no
> effect on ongoing interrupts that are about to pick up the action
> handler.
>  The key is: Linux does not crash on NULL action. So the dummy
> handler is the same thing, just without a spinlock and a conditional branch.
> 

On a pipelined kernel, disabling the IRQ means raising the IPIPE_LOCK
bit as well as silencing the line at PIC level, which does prevent
further dispatching immediately for any interrupt which has been taken,
but did not reach the dispatch call yet.

Ongoing handlers on remote CPUs will finish before the critical IPI is
taken and set the IRQ in pass mode. Finally, spurious IRQs still pending
at hardware level will skip the domain because of the latter action.

> > 
> >>
> >>>
> >>> Besides, I'm still scratching my head: how would introducing a dummy
> >>> handler help dealing with that sequence?
> >>>
> >>> CPU0					CPU1
> >>>
> >>> xnintr_disable => mask irq		<irq>
> >>
> >> No disable here, mask must be at device level
> >> .
> >>
> >>> xnintr_detach				real-time handler
> >>> 	<install dummy handler>			<touch device>
> >>> 					ipipe_end_irq() => unmask irq
> >>
> >> xnarch_synchronize_irq
> >>
> > 
> > No, it is too late. It assumes the driver could somehow prevent CPU1
> > from touching the device before the dummy handler could be installed by
> > ipipe_virtualize_irq. But synchronizing and releasing a pipelined IRQ
> > must be done in that order, and all locks dropped, with interrupts
> > enabled on CPU0.

I was wrong: we don't need interrupts enabled to enforce a critical
entry, but we have to drop all locks.

>  I can't see how just replacing mask_irq by mask_device
> > would work any better, and prevent CPU0 from receiving an unexpected IRQ
> > from the device it is supposed to have disabled a few instructions
> > before. This is where disabling the IRQ comes into play, /me think.
> 
> Receiving that IRQ is not an issue at all. It is for us as the pipeline
> crashes. Linux swallows it, and after synchronize_irq, there is no more
> risk that the deregistered handler could still be in use.
> 

The problem is not about receiving one IRQ. This is about having
touch_device re-enabling the hardware inadvertently, in a way which may
cause the board to be hammered by a level-triggered IRQ with no way to
clear it at device level from the now dummy handler. That would be a bit
too much to swallow.

I understand you want to fix this by keeping Xenomai's interrupt lock
held until xnintr_detach has fully synchronized, but then, you need the
busy wait option to be available for synchronizing, but implementing it
would induce overhead in the hot path.

> > 
> >>>
> >>> Then, on whichever CPU, we could receive a device IRQ as we touched the
> >>> hardware before leaving the handler, passing that IRQ to the root domain
> >>> which has no proper handler for it:
> >>>
> >>> - lucky scenario: the device is in a state that won't cause it to kick
> >>> yet another interrupt even if the last one was not serviced, and we just
> >>> end up with a nifty spurious IRQ message in the kernel log.
> >>>
> >>> - out of luck: we touched the device on CPU1 in a way that claims for a
> >>> specific action by the software, which won't be able to perform it
> >>> because it is now branching to the dummy handler. Whether we have some
> >>> code to silence the device (and not only the IRQ line) before or after
> >>> we detach the IRQ on CPU0 does not fix the issue, since we have no
> >>> synchronization between the CPUs whatsoever.
> >>>
> >>
> >> The driver is responsible for synchronizing its shutdown sequence
> >> between the cleanup code and any of its in-flight IRQs. If that handler
> >> reenables the IRQ that the shutdown code just disabled (all at device
> >> level, of course), something is seriously broken - but not on Xenomai
> >> side. As I explained before: That potential in-flight IRQ becomes
> >> spurious at the point the drivers starts the shutdown, thus can safely
> >> be ignored.
> > 
> > For mask_device to be useful in SMP, I guess we both agree that we need
> > some kind of barrier for synchronizing in flight IRQs before they become
> > not only spurious IRQs, but also deadly ones. Reading the kernel code, I
> > can understand how this is done, both in disable_irq() and __free_irq():
> > first disable the device in the driver, then disable the line, then
> > synchronize. The barrier mechanism is there.
> 
> The barrier is the descriptor lock (to protect against future events on
> the line) and then synchronize_irq (to protect against already running
> events).
> 

Not the descriptor lock per se since it is dropped before synchronizing,
only what you do within this locked section is part of the barrier, such
as raising the disabled flag in that descriptor to prevent further
handling and unmasking in the various irq flow handlers. But I guess we
are in fact using different names to refer to the same "locking"
action. 

> 
> > 
> > What kind of construct would you then recommend to Xenomai driver
> > writers, to have the same guarantee with only the driver doing
> > "disable_device" and Xenomai doing "synchronize"? This is what I'm
> > likely missing.
> > 
> 
> my_device_disable_irqs();
> rtdm_irq_free();
> 
> That must suffice, and Xenomai must be fixed to guarantee this.

Xenomai is not the issue, it should be able to call ipipe_virtualize_irq
and expect proper synchronization of the shut down irq, this is the gist
of the matter. There is no reason for the nucleus to implement permanent
workarounds for shortcomings in the pipeline, and there is absolutely no
reason to ask each and every driver to implement yet another ad hoc irq
synchronization mechanism to work around the same shortcomings.

For the time being, the patch synchronizes externally via
ipipe_control_irq from rthal_irq_release, but this is a kludge, the
proper solution is to fold this with the I-pipe irq deregistration code,
just like free_irq does for the regular kernel. This kludge is only a
temporary measure to plug the race, until ipipe_virtualize_irq is
eventually fixed.

For that to happen, we must call ipipe_virtualize_irq with all Xenomai
locks dropped, hence the patch, to prepare for fixing the pipeline. 

> If
> rtdm_irq_free also automatically disables the line is irrelevant for the
> driver writer, it's an implementation detail for Xenomai - nothing I
> vote against in principle once we can provide soft-IRQ masking for MSI
> or whatever problematic IRQ type.
> 

Soft-masking could be obtained playing a variant of the
ipipe_irq_lock/unlock game, with a deferred execution of the
msi_mask/unmask_irq calls when the root domain resumes.

Regarding the pending SMP race, I will push that fix upstream based on
the one I submitted earlier, but amended with a change which should be
functionally equivalent to this:

diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
index 0cf66f4..3d5c64c 100644
--- a/ksrc/nucleus/intr.c
+++ b/ksrc/nucleus/intr.c
@@ -844,7 +844,7 @@ int xnintr_detach(xnintr_t *intr)
 	 * be running concurrently on any remote CPU before we tell
 	 * the pipeline to release the IRQ.
 	 */
-	xnarch_disable_irq(intr->irq);
+	___ipipe_lock_irq(&rthal_domain, ipipe_processor_id(), intr->irq);
 	/*
 	 * We use the teardown flag to prevent further attachment on
 	 * the same IRQ line, after we dropped the lock to release the
@@ -860,6 +860,10 @@ int xnintr_detach(xnintr_t *intr)
 	ret = xnintr_irq_release(intr);
 	xnlock_get(&intrlock);
 	__clear_bit(intr->irq, teardown);
+	xnlock_put_irqrestore(&intrlock, s);
+	xnarch_disable_irq(intr->irq);
+
+	return 0;
  out:
 	xnlock_put_irqrestore(&intrlock, s);
 
This way, we will have the IRQ line disabled upon last detach with some
guarantee against driver/hardware issues before synchronizing, no
leakage when doing so on the RTDM API, and we won't break MSI usage. I
just need to find a way to bury the __ipipe_lock_irq() call into some
HAL-level interface.

If at some point, anyone comes with a better approach than the teardown
+ critical IPI sequence, then we will reconsider the issue.

-- 
Philippe.






