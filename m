Subject: Re: Antwort: Re: [Xenomai-core] Questions about pSOS task mode and
	task priority
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45C0615B.5060909@domain.hid>
References: <OF5910DE28.1586BCD6-ONC125726F.005E4D75@domain.hid>
	<1169832375.3346.67.camel@domain.hid>  <45BDF5D8.4020607@domain.hid>
	<1170204016.21219.49.camel@domain.hid>  <45C05975.3060900@domain.hid>
	<1170234649.25426.4.camel@domain.hid>  <45C0615B.5060909@domain.hid>
Content-Type: text/plain
Date: Wed, 31 Jan 2007 11:24:23 +0100
Message-Id: <1170239063.25426.29.camel@domain.hid>
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

On Wed, 2007-01-31 at 10:28 +0100, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> >>>In short, the following patch against 2.3.0 stock fixes the issue,
> >>>allowing threads to block while holding the scheduler lock. 
> >>
> >>Ok, but this means that the skins which use XNLOCK with the previous
> >>meaning need fixing.
> >>
> > 
> > 
> > Only those which really wanted - i.e. by design - to return an error
> > flag (or the board to lockup or panic) in case of a thread going to
> > sleep while holding the schedlock. This change does not affect the
> > schedlock semantics otherwise.
> > 
> 
> I do not understand how it works, I mean, how do you know, in
> xnpod_schedule, if xnpod_schedule was voluntarily called by the current
> thread, or was called upon reception of an interruption ?
> 

You don't have to care about this issue. Is the current thread
preemptable when considering the scheduling state is the right issue to
care of, and the answer is that such thread must not be blocked at the
time the XNLOCK bit is checked. It turns out that checking for
preemptability in xnpod_schedule() only when the current thread has no
blocking bits armed is enough (this test from xnpod_schedule() has moved
compared to the previous implementation). Now, if the current thread
enters xnpod_schedule() with some blocking bits set into its state mask,
then the test for preemptability is bypassed and the rescheduling takes
place as usual, which gives us sleeping schedlocks. Since the formerly
global schedlock nesting count has been moved to the per-thread TCB,
there is no need for explicit save/restore of such information either.

In any case, if the current thread has locked the scheduler and is still
in a ready-to-run state, you don't want anyone to be able to switch it
out, be it ISR or thread. ISRs could still call xnpod_suspend() against
the current thread though and force it out when returning from the outer
interrupt frame by a call to xnpod_schedule(), which is ok, and if you
think of it, much saner than the former implementation that would deny
_any_ rescheduling of a thread which happened to be suspended from the
current interrupt context. Too bad for emergency measures.

-- 
Philippe.



