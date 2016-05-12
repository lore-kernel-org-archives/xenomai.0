Date: Thu, 12 May 2016 20:22:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160512182258.GR13285@hermes.click-hack.org>
References: <5734A9F8.10305@siemens.com>
 <20160512163142.GC18298@hermes.click-hack.org>
 <5734B43B.4040001@siemens.com> <5734BF98.3060704@xenomai.org>
 <5734C298.30205@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5734C298.30205@siemens.com>
Subject: Re: [Xenomai] RTDM syscalls & switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Thu, May 12, 2016 at 07:51:20PM +0200, Jan Kiszka wrote:
> On 2016-05-12 19:38, Philippe Gerum wrote:
> > On 05/12/2016 06:50 PM, Jan Kiszka wrote:
> >> On 2016-05-12 18:31, Gilles Chanteperdrix wrote:
> >>> On Thu, May 12, 2016 at 06:06:16PM +0200, Jan Kiszka wrote:
> >>>> Gilles,
> >>>>
> >>>> regarding commit bec5d0dd42 (rtdm: make syscalls conforming rather than
> >>>> current) - I remember a discussion on that topic, but I do not find its
> >>>> traces any more. Do you have a pointer
> >>>>
> >>>> In any case, I'm confronted with a use case for the old (Xenomai 2),
> >>>> lazy switching behaviour: lightweight, performance sensitive IOCTL
> >>>> services that can (and should) be called without any switching from both
> >>>> domains.
> >>>
> >>> Why not using a plain linux driver? ioctl_nrt callbacks are
> >>> redundant with plain linux drivers.
> >>
> >> Because that enforces the calling layer to either call the same service
> >> via a plain Linux device if the calling thread is currently relaxed or
> >> go for the RT device if the caller is in primary. Doable, but I would
> >> really like to avoid this pain for the users.
> >>
> >>>
> >>>>
> >>>> What were the arguments in favour of migrating threads to real-time first?
> >>>>
> >>>> I currently see the real need only for IOCTLs, but the question is then
> >>>> if we shouldn't go back to "__xn_exec_current" in all RTDM cases to
> >>>> avoid unwanted migration costs (which are significantly higher than
> >>>> syscall restarts).
> >>>
> >>> I do not find commit bec5d0dd42 in xenomai-2.6 git tree, and I do
> >>
> >> Xenomai 2 is still following the lazy scheme - we reverted that commit
> >> later on in 7df0c1d96b. Xenomai 3 changed it again with the commit above.
> >>
> >>> not remember merging this. However I find commit
> >>> 13bfdd477ab880499d2e8f3b82c49ef4d2cccff0 from 2010 which seems to
> >>> explain the reason pretty clear.
> >>>
> >>> At the time of the discussion we had concluded that it was the way
> >>> to go. With __xn_exec_current you may enter the ioctl_rt callback
> >>> from secondary domain, which is counter-intuitive, error-prone, and
> >>> forces you to cripple driver code for checks for the current domain.
> >>
> >> Nope, normal drivers are not affected as they just implement those
> >> services in the respective mode they want to support there and have a
> >> simple -ENOSYS for the rest (explicitly in IOCTLs or implicitly by
> >> leaving out the implementation of the counterpart handler).
> >>
> >>> It optimizes the secondary mode case at the expense of the primary
> >>> mode case which is the inverse of what should be done. With
> >>> __xn_exec_conforming, you have the guarantee to enter ioctl_rt over
> >>> primary domain and ioctl_nrt over secondary domain.
> >>>
> >>> See Philippe prose here also:
> >>> https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Adaptive_syscalls
> >>>
> >>
> >> Yes, unfortunately I didn't have the current use case at hand by then to
> >> argue against this change:
> >>
> >> We do not always need real-time context in a driver, specifically to
> >> perform certain IOCTLs. We do typically need a caller path that does not
> >> migrate RT threads to Linux without a reason, though. As migrating is
> >> far from free, migration ping-pong (we first migrate a conforming caller
> >> and then find out that there is no RT version for an IOCTL service) or
> >> needless switching for those services that can handle both domains has
> >> to be avoided.
> >>
> > 
> > The logic of your driver is broken: it wants to optimize on the number
> > of migration a thread does. That is wrong:
> > 
> > - either a thread has real-time requirements, in which case all services
> > it calls during normal operations are best served from primary mode by
> > definition, which the current RTDM logic honors.
> > 
> > - or, a thread does not have such requirements (e.g. SCHED_WEAK), in
> > which case the preferred mode of operation is secondary mode, which the
> > current RTDM logic honors too.
> 
> Where is SCHED_WEAK honoured in the syscall handling? To my
> understanding, the only thing that matters for __xn_exec_conforming is
> if the caller has a shadow or not.
> 
> > 
> > If an application switches mode frequently enough to be adversely
> > affected by the migration cost, then it is certainly mixing real-time
> > and regular Linux code within a thread's inner loop, which is not a RTDM
> > or Cobalt issue.
> > 
> > Cobalt is not migrating the threads without a reason, it is making sure
> > that your application knows a priori which context a call will be
> > handled from, without asking you to track the current mode, crippling
> > the driver code with in_nrt() or forced mode switches from the
> > application, like Gilles mentioned.
> 
> As pointed out, normal drivers (the majority) were and will never be
> affected by the laziness or eagerness of the syscall entry path - they
> need to handle both cases independently of the caller's preference any
> way. The cited Analogy case is an exception.

They are. See previous post.

I wonder however, since RTDM drivers are now also Linux driver,
could not the Linux driver branch to the _nrt handlers ?

This way you could use __real_ioctl to indicate that you know that
the thread is running in secondary mode and that you do not want it
to switch to primary mode even though it has a shadow.

-- 
					    Gilles.
https://click-hack.org

