Subject: Re: Antwort: Re: [Xenomai-core] Questions about pSOS task mode and
	task priority
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45C05975.3060900@domain.hid>
References: <OF5910DE28.1586BCD6-ONC125726F.005E4D75@domain.hid>
	<1169832375.3346.67.camel@domain.hid>  <45BDF5D8.4020607@domain.hid>
	<1170204016.21219.49.camel@domain.hid>  <45C05975.3060900@domain.hid>
Content-Type: text/plain
Date: Wed, 31 Jan 2007 10:10:49 +0100
Message-Id: <1170234649.25426.4.camel@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Markus Osterried <Markus.Osterried@domain.hid>, xenomai@xenomai.org, Thomas Necker <Thomas.Necker@domain.hid>

On Wed, 2007-01-31 at 09:55 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Mon, 2007-01-29 at 14:25 +0100, Gilles Chanteperdrix wrote:
> > 
> >>Philippe Gerum wrote:
> >>
> >>>On Fri, 2007-01-26 at 18:16 +0100, Thomas Necker wrote:
> >>>
> >>>
> >>>>So it clearly states that a non-preemtible task may block (and 
> >>>>rescheduling occurs in
> >>>>this case).
> >>>
> >>>
> >>>Ok, so this is a must fix. Will do. Thanks for reporting.
> >>
> >>I had a look at the OSEK specification, it also has non-preemptible
> >>tasks. So, I guess we should add an xnpod_locked_schedule that simply does
> >>
> >>if (xnthread_test_state(xnpod_current_sched()->runthread, XNLOCK)) {
> >>	xnpod_unlock_sched();
> >>	xnpod_lock_sched();
> >>} else
> >>	xnpod_schedule();
> >>
> >>and call this xnpod_locked_schedule() instead of xnpod_schedule() in
> >>these skins.
> > 
> > 
> > The more I think of it, the more it becomes obvious that the current
> > implementation of the scheduler locks is uselessly restrictive.
> > Actually, the only thing we gain from not allowing threads to block
> > while holding such kind of lock is the opportunity to panic at best if
> > the debug switch is on, or to go south badly if not.
> > 
> > Even the pattern above would not solve the issue in fact, because things
> > like xnsynch_sleep_on() which fire a rescheduling call would have to
> > either get a special argument telling us about the policy in this
> > matter, or forcibly unlock the scheduler behind the curtains before
> > calling xnpod_suspend() internally. While we are at it, we would be
> > better off incorporating the latter at the core, and assume that
> > callers/skins that do _not_ want to allow sleeping schedlocks did the
> > proper sanity checks to prevent this before running the rescheduling
> > procedure. Other would just benefit from the feature.
> > 
> > In short, the following patch against 2.3.0 stock fixes the issue,
> > allowing threads to block while holding the scheduler lock. 
> 
> Ok, but this means that the skins which use XNLOCK with the previous
> meaning need fixing.
> 

Only those which really wanted - i.e. by design - to return an error
flag (or the board to lockup or panic) in case of a thread going to
sleep while holding the schedlock. This change does not affect the
schedlock semantics otherwise.

-- 
Philippe.



