Subject: Re: [Xenomai-core] [PATCH 1/2] kill cookie in xntimer_t
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44BD7355.60507@domain.hid>
References: <44BD7355.60507@domain.hid>
Content-Type: text/plain
Date: Wed, 19 Jul 2006 10:28:37 +0200
Message-Id: <1153297717.5026.10.camel@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

On Wed, 2006-07-19 at 01:48 +0200, Jan Kiszka wrote:
> [This is only the simplest part of a potential larger xntimer
> restructuring. Other parts need to be rebased, rewritten, or even
> rethought yet. One goal is to get the abstraction closer to the kernel's
> hrtimer, another one is to check for potential optimisations. More
> information will follow the next days or so.]
> 
> 
> Almost all users of xntimer_t embed this object in the same meta-object
> they later define as cookie of the timer handler. Thus, a simple
> container_of could also serve to obtain the cookie in the handler.
> 
> This conversion is performed by the attached patch. It also handles the
> only exception of the rule above: the vwworks skin requires a trampoline
> handler for its wdog now. Philippe confirmed earlier that this is
> acceptable.

Applied, thanks.

> 
> Jan
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



