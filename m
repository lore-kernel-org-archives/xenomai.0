Subject: Re: [Xenomai-core] Re: [patch, RFC] detect unhandled interrupts
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44F592AD.2000900@domain.hid>
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
	<44F49A6C.5050603@domain.hid>
	<b647ffbd0608291334u4182e78bub6d874e252abbbc9@domain.hid>
	<44F592AD.2000900@domain.hid>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 19:55:47 +0200
Message-Id: <1156960547.4323.68.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org

On Wed, 2006-08-30 at 15:29 +0200, Jan Kiszka wrote:
> Dmitry Adamushko wrote:
> > On 29/08/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >>
> >> Dmitry Adamushko wrote:
> >>
> >> I think the additional costs of maintaining an error counter are almost
> >> negligible. The test is in the unlikely path, and the first condition
> >> already keeps us away from touching the counter.
> > 
> > 
> > But it's updated (unhandled = 0) any time the ISR(s) report something
> > different from XN_ISR_NONE.  Hence, it's at the beginning of the xnintr_t
> > structure, hopefully, at the same cache line with other highly-used members
> > (i.e. isr, cookie and hits).
> 
> Mmh, considering this and also the existing code I wonder if we could
> optimise this a bit. I'm only looking at xnintr_irq_handler now (sharing
> is slow anyway): currently the intr object is touched both before
> (naturally...) and after the call to the ISR handler. Maybe we can push
> all accesses before the handler for the fast path. E.g.:
> 
> int unhandled = intr->unhandled;
> 
> intr->unhandled = 0;
> ++intr->hits;
> s = intr->isr(...);
> 
> if (s == XN_ISR_NONE) {
> 	intr->unhandled = ++unhandled;
> 	if (unhandled == XNINTR_MAX_UNHANDLED)
> 		ALARM!
> }
> 

Without speculating whether this could actually reduce cache misses or
not when the branch is taken, the main issue I see here is that we would
optimize the error case, at the expense of an additional memory fetching
in the common case, and perhaps one CPU register available less for
processing the normal path in the worst scenario, which would not be
particularly efficient on x86.

> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



