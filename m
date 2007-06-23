From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <467CD519.1060802@domain.hid>
References: <467CD519.1060802@domain.hid>
Content-Type: text/plain
Date: Sat, 23 Jun 2007 12:25:45 +0200
Message-Id: <1182594345.6000.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Monotonic, realtime, and other timers
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai-core <xenomai@xenomai.org>

On Sat, 2007-06-23 at 10:08 +0200, Jan Kiszka wrote:
> Hi,
> 
> [just to save this early-Saturday-morning insight]
> 
> I think the xntimer interface is not yet ready to represent all required
> scenarios. What kind of timers are there? Let's start with POSIX:
> 
> 1. Realtime timers	- use realtime clock as base, re-tune
> 			  absolute(!) expiry dates if the realtime clock
> 			  changes
> 2. Monotonic timers	- use monotonic clock as base, don't re-adjust
> 			  during runtime
> 
> Now what we have in current trunk:
> 
> 3a. Realtime xntimers	- use wallclock_offset to calculate absolute
> 			  expiry dates, don't re-adjust during runtime
> 4a. Monotonic xntimers	- use raw jiffies/TSC as base, don't re-adjust
> 			  during runtime
> 
> And this is what we planed to introduce soon:
> 
> 3b. Realtime xntimers	- use wallclock offset to calculate absolute
> 			  expiry dates, re-adjust if the offset changes
> 			  during runtime

I merged this patch already, so this issue becomes top-ranked on the fix
list.

> 4b. Monotonic xntimers	- same as 4a
> 
> 3b and 4b almost perfectly match POSIX, one only has to pass relative
> realtime timers as monotonic ones (Linux does so too). But there are a
> lot of skins that potentially rely on 3a!

They do, but not only on the timer issue, but this also has an impact on
the time unit used to return the current time. I must admit that this is
becoming a mess.

>  At least the whole native
> skin, I would say. So we may actually need two knobs when starting an
> xntimer:
> 
>  A) Take wallclock offset into account when calculating internal expiry
>     date?
>  B) Re-tune the expiry date during runtime if the offset changes?
> 
> Reasonable combinations are none of both ("POSIX monotonic"), A
> ("Xenomai realtime"), and A+B ("POSIX realtime"). Am I right? Please
> comment.

Sorry, -ENOPARSE. Which is the alternative here?

> 
> Moreover, it looks to me like the monotonic API I introduced is not very
> handy (fortunately, there is no in-tree user yet). It has a sticky
> property, i.e. you set a persistent flag in the xntimer object if it
> ought to be monotonic. As xntimer structures are typically also
> persistent, you easily end up saving the current mode, setting your own,
> and restoring the old one once the timer fired -- to keep other users of
> the timer happy. E.g., think of RTDM doing some monotonic timing with a
> task while the owning skin may prefer realtime mode. I'm almost
> convinced now that passing a non-sticky mode on each xntimer_start
> (along with XN_ABSOLUTE/RELATIVE in the same parameter) will be more useful.
> 

This issue seems orthogonal to the more fundamental one: in which case
does RTDM need to recycle and _change_ the behaviour of timers owned by
other layers? A simple (code) illustration would help understanding the
issue, which is likely RTDM-specific, due to the transverse aspect of
this interface.

> Jan
> 
-- 
Philippe.



