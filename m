MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18368.23813.430770.37223@domain.hid>
Date: Sat, 23 Feb 2008 18:51:01 +0100
In-Reply-To: <47C021F3.20002@domain.hid>
References: <47C020A9.3050704@domain.hid>
	<47C021F3.20002@domain.hid>
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
 > At least when SMP is enable, already __xnlock_get becomes far too
 > heavy-weighted for being inlined. xnlock_put is fine now, but looking
 > closer at the disassembly still revealed a lot of redundancy related to
 > acquiring and releasing xnlocks. In fact, we are mostly using
 > xnlock_get_irqsave and xnlock_put_irqrestore. Both include fiddling with
 > rthal_local_irq_save/restore, also heavy-weighted on SMP.
 > 
 > So this patch turns the latter two into uninlined functions which
 > reduces the text size or nucleus and skins significantly on x86-64/SMP
 > (XENO_OPT_DEBUG_NUCLEUS disabled):

I think the human idea of how long an inline function can be is far more
restrictive than what a processor can take. When looking at assembly
code, you always find the code long, whereas in reality it is not that
long for a processor. 

Besides, IMO, the proper way to uninline xnlock operations is to leave
the non contended case inline, and to move the spinning out of line.

And this is something we should not do without measuring its impact.

-- 


					    Gilles Chanteperdrix.

