MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18041.38156.744377.601270@domain.hid>
Date: Wed, 20 Jun 2007 22:58:52 +0200
In-Reply-To: <4679778B.6080102@domain.hid>
References: <467639BE.30504@domain.hid> <467641F3.3010308@domain.hid>
	<1182357772.6137.39.camel@domain.hid>
	<18041.27025.80273.654686@domain.hid>
	<4679778B.6080102@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH-STACK] Synchronised timebases and more
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > I was afraid you would insist on this support. ;)

Well, clock_settime is almost the only service missing in posix skin,
and since I saw in Thomas Gleixner slides that one reason for not using
Xenomai is that its posix support is incomplete, I am eager to implement
the missing services (and to remove the sentence "xenomai posix skin is
a work in progress" from posix skin text file).

 > 
 > There are two ways to implement this:
 > 
 >  A) The poor man's variant
 > 
 >     On xntbase_adjust_time() (the code will change again, pay attention!
 >     ;) ), iterate over all pending timers (or over all timers in the
 >     base that POSIX uses?) and fix those which do not have the recently
 >     introduced XNTIMER_MONOTONIC flag set. "Poor man" because it's
 >     simple, but it scales poorly.
 > 
 >  B) The scalable but complex one
 > 
 >     Introduce a second time base for each existing one (or for the one
 >     that POSIX uses?), put in all the adjustable (realtime) timers. We
 >     then only need to play with the base's clock offset on adjustment,
 >     but we would also have to include that offset into timeout
 >     considerations inside the timer interrupt handler.
 > 
 > I wonder now if the number of use cases where people are playing with
 > the wallclock all over the time while a significant amounts of timers
 > are pending is actually worth the troubles of B)... What do you think?

I think one use of clock_settime would be to resync Xenomai clock with
Linux one from time to time, but even if we implemented B, that would be
a bad idea because of the effect on timers. So, A would be enough for me.

-- 


					    Gilles Chanteperdrix.

