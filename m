Subject: Re: [Xenomai-help] Xenomai + PREEMPT_RT
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1157554292.3541.28.camel@domain.hid>
References: <1157501591.22250.25.camel@domain.hid>
	<44FEA7F5.6090409@domain.hid>
	<1157554292.3541.28.camel@domain.hid>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 23:07:34 +0200
Message-Id: <1157576854.5064.81.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Walker <dwalker@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Wed, 2006-09-06 at 07:51 -0700, Daniel Walker wrote: 
> On Wed, 2006-09-06 at 12:50 +0200, Jan Kiszka wrote:
> > > Or even better, is anyone already doing work with these two
> > > technologies combined?
> > 
> > There once existed a combo patch (that I don't find ATM) of an ancient
> > -rt version + old Adeos, a combination that will more or less
> > automatically come again when PREEMPT_RT is mainline. Porting the
> > nucleus over PREEMPT_RT so that the skins can run "natively" is another
> > task yet to begin. Anyway, we are already including this perspective in
> > current design decisions when subsystems are revised or enhanced.
> 
> So I take it that designing the combined version is still taking place?
> 
> It sounds like the current direction is more of a straight merge. 
> Since PREEMPT_RT and Xenomai are somewhat parallel in purpose would
> there be any room to eliminate duplication between the two?

The current direction is about allowing the Xenomai core and interfaces
to run indifferently over the current co-kernel technology, or a native
preemption one, to get the real-time predictability.

Xenomai is all about the real-time interfaces it provides to
applications: emulation of legacy RTOS core APIs (e.g. VRTX, pSOS+,
VxWorks, ...) and standard specifications (e.g. POSIX 1003.1b, uITRON).
Additionally, the RTDM interface abstracts the underlying RTOS services
needed for implementing our real-time drivers for industrial devices
(e.g. CAN).

In other words, POSIX aside, all the rest would remain relevant,
including over a PREEMPT_RT kernel, particularly as a migration tool
from non-Linux environments.

-- 
Philippe.



