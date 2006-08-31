Subject: Re: [Xenomai-core] [patch, RFC] detect unhandled interrupts
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44F7346D.20602@domain.hid>
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
	<1157013092.4359.11.camel@domain.hid>  <44F7346D.20602@domain.hid>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 21:31:58 +0200
Message-Id: <1157052719.4359.70.camel@domain.hid>
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

On Thu, 2006-08-31 at 21:11 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Tue, 2006-08-29 at 21:28 +0200, Dmitry Adamushko wrote:
> >> Hello,
> >>
> >> Jan has rised this question initially and I was struggling last week
> >> to get his request eventually done :)
> >>
> >> The main idea is to prevent system lockups when the cross domain IRQ
> >> sharing isn't properly used (there were a number of reports recently).
> >>
> >> So here is an initial patch as well as some related critics (yep, I
> >> critisize my own patch).
> > 
> > [...]
> > 
> > Applied, thanks.
> > 
> 
> Unless I'm currently doing something completely wrong, it looks like it
> doesn't work as it should. :(
> 
> I attached a xeno_16550A to the Ethernet NIC's IRQ line and opened the
> serial port - lock-up.
> 
> Ok, and now I enabled shared IRQ support:
> 
> kernel/xenomai/nucleus/intr.c: In function 'xnintr_irq_handler':
> kernel/xenomai/nucleus/intr.c:399: error: 'xnintr_t' has no member named
> 'unhandled'
> kernel/xenomai/nucleus/intr.c:404: error: 'xnintr_t' has no member named
> 'unhandled'
> 
> Looks like our patch review failed... :-/
> 

I've just committed two trivial fixes concerning the declaration and
initialization of xnintr::unhandled in the !shared case.

> Jan
> 
-- 
Philippe.



