MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18368.26367.809400.757141@domain.hid>
Date: Sat, 23 Feb 2008 19:33:35 +0100
In-Reply-To: <47C06237.6080000@domain.hid>
References: <47C020A9.3050704@domain.hid> <47C021F3.20002@domain.hid>
	<18368.23813.430770.37223@domain.hid>
	<47C06237.6080000@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH 3/4] Uninline heavy locking functions
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
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > At least when SMP is enable, already __xnlock_get becomes far too
 > >  > heavy-weighted for being inlined. xnlock_put is fine now, but looking
 > >  > closer at the disassembly still revealed a lot of redundancy related to
 > >  > acquiring and releasing xnlocks. In fact, we are mostly using
 > >  > xnlock_get_irqsave and xnlock_put_irqrestore. Both include fiddling with
 > >  > rthal_local_irq_save/restore, also heavy-weighted on SMP.
 > >  > 
 > >  > So this patch turns the latter two into uninlined functions which
 > >  > reduces the text size or nucleus and skins significantly on x86-64/SMP
 > >  > (XENO_OPT_DEBUG_NUCLEUS disabled):
 > > 
 > > I think the human idea of how long an inline function can be is far more
 > > restrictive than what a processor can take. When looking at assembly
 > > code, you always find the code long, whereas in reality it is not that
 > > long for a processor. 
 > > 
 > > Besides, IMO, the proper way to uninline xnlock operations is to leave
 > > the non contended case inline, and to move the spinning out of line.
 > 
 > This patch is not just about uninlining xnlock, that's only one half of
 > the savings. The other one is irq-disabling via i-pipe. The problem with
 > our case is that we have no simple single check to find out that we are
 > on a fast ride. Rather, we have to do quite some calculations/lookups
 > before the first check, and we have to perform multiple checks even in
 > the best case.

This is my fault, a tradeoff I made, I thought that the atomic_cmpxchg
could be heavy on SMP systems, so I made a first check to see if we are
not recursing. But we can do the two operations in one move if we accept
to have a failing atomic_cmpxchg when recursing.


-- 


					    Gilles Chanteperdrix.

