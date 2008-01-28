Message-ID: <2ff1a98a0801280302j6dd97285o75d22a4bfc0efab0@domain.hid>
Date: Mon, 28 Jan 2008 12:02:51 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <479D1519.5020102@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0801020231k19be7d89k1a6f04b7d497cc34@domain.hid>
	<47977DE1.8060207@domain.hid>
	<2ff1a98a0801230953m2a67e614s6c921b3b6ec77c3c@domain.hid>
	<479788A5.80407@domain.hid>
	<2ff1a98a0801240218y1f09ae38w93e244a47218900@domain.hid>
	<479B7938.2000206@domain.hid>
	<18331.32587.725949.407764@domain.hid>
	<479BCE17.600@domain.hid> <18333.3277.36164.63798@domain.hid>
	<479D1519.5020102@domain.hid>
Subject: Re: [Xenomai-core] High latencies on ARM.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

On Jan 28, 2008 12:34 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>
> Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> >  > Gilles Chanteperdrix wrote:
> >  > > Philippe Gerum wrote:
> >  > >  > Gilles Chanteperdrix wrote:
> >  > >  > > On Jan 23, 2008 7:34 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> >  > >  > >> Gilles Chanteperdrix wrote:
> >  > >  > >>> On Jan 23, 2008 6:48 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> >  > >  > >>>> Gilles Chanteperdrix wrote:
> >  > >  > >>>>> Gilles Chanteperdrix wrote:
> >  > >  > >>>>>  > Please find attached a patch implementing these ideas. This adds some
> >  > >  > >>>>>  > clutter, which I would be happy to reduce. Better ideas are welcome.
> >  > >  > >>>>>  >
> >  > >  > >>>>>
> >  > >  > >>>>> Ok. New version of the patch, this time split in two parts, should
> >  > >  > >>>>> hopefully make it more readable.
> >  > >  > >>>>>
> >  > >  > >>>> Ack. I'd suggest the following:
> >  > >  > >>>>
> >  > >  > >>>> - let's have a rate limiter when walking the zombie queue in
> >  > >  > >>>> __xnpod_finalize_zombies. We hold the superlock here, and what the patch
> >  > >  > >>>> also introduces is the potential for flushing more than a single TCB at
> >  > >  > >>>> a time, which might not always be a cheap operation, depending on which
> >  > >  > >>>> cra^H^Hode runs on behalf of the deletion hooks for instance. We may
> >  > >  > >>>> take for granted that no sane code would continuously create more
> >  > >  > >>>> threads than we would be able to finalize in a given time frame anyway.
> >  > >  > >>> The maximum number of zombies in the queue is
> >  > >  > >>> 1 + XNARCH_WANT_UNLOCKED_CTXSW, since a zombie is added to the queue
> >  > >  > >>> only if a deleted thread is xnpod_current_thread(), or if the XNLOCKSW
> >  > >  > >>> bit is armed.
> >  > >  > >> Ack. rate_limit = 1? I'm really reluctant to increase the WCET here,
> >  > >  > >> thread deletion isn't cheap already.
> >  > >  > >
> >  > >  > > I am not sure that holding the nklock while we run the thread deletion
> >  > >  > > hooks is really needed.
> >  > >  > >
> >  > >  >
> >  > >  > Deletion hooks may currently rely on the following assumptions when running:
> >  > >  >
> >  > >  > - rescheduling is locked
> >  > >  > - nklock is held, interrupts are off
> >  > >  > - they run on behalf of the deletor context
> >  > >  >
> >  > >  > The self-delete refactoring currently kills #3 because we now run the
> >  > >  > hooks after the context switch, and would also kill #2 if we did not
> >  > >  > hold the nklock (btw, enabling the nucleus debug while running with this
> >  > >  > patch should raise an abort, from xnshadow_unmap, due to the second
> >  > >  > assertion).
> >  > >  >
> >  >
> >  > Forget about this; shadows are always exited in secondary mode, so
> >  > that's fine, i.e. xnpod_current_thread() != deleted thread, hence we
> >  > should always run the deletion hooks immediately on behalf of the caller.
> >
> > What happens if the watchdog kills a user-space thread which is
> > currently running in primary mode ? If I read xnpod_delete_thread
> > correctly, the SIGKILL signal is sent to the target thread only if it is
> > not the current thread.
> >
>
> I'd say: zombie queuing from xnpod_delete, then shadow unmap on behalf
> of the next switched context which would trigger the lo-stage unmap
> request -> wake_up_process against the Linux side and asbestos underwear
> provided by the relax epilogue, which would eventually reap the guy
> through do_exit(). As a matter of fact, we would still have the
> unmap-over-non-current issue, that's true.
>
> Ok, could we try coding a damn Tetris instead? Pong, maybe? Gasp...

Games for mobile phones then, because I am afraid games for consoles
or PCs are too complicated for me.

No, seriously, how do we solve this ? Maybe we could relax from
xnpod_delete_thread ?


-- 
                                               Gilles Chanteperdrix

