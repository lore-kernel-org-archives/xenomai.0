From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17577.4096.436840.354535@domain.hid>
Date: Mon, 3 Jul 2006 14:39:28 +0200
Subject: Re: [Xenomai-core] Some questions about the ARM port (Integrator
	vs.	PXA)
In-Reply-To: <44A8D7A1.4E4E9D27@domain.hid>
References: <44A3919C.596DFDAE@vollmann.ch>
	<1151592402.19389.31.camel@domain.hid>
	<44A4C4CB.5F24DA68@domain.hid>
	<1151657621.3060.26.camel@domain.hid>
	<44A8B191.3DCC39C2@domain.hid> <44A8BA2E.9090106@domain.hid>
	<44A8D7A1.4E4E9D27@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Detlef Vollmann <dv@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Detlef Vollmann wrote:
 > It's not so difficult to work around the problem for a single system.
 > What's difficult is to find a solution in a framework that wasn't
 > built with such a problem in mind.

Actually, all architectures have a delay below which they can not be
reprogrammed fast enough. This delay is simply 0 for all of them.

How about rewriting rthal_timer_program_shot as:

static inline void rthal_timer_program_shot (unsigned long delay)
{
    if(delay < __ipipe_mach_min_delay)
        rthal_trigger_irq(RTHAL_TIMER_IRQ);
    else
        __ipipe_mach_set_dec(delay);
}

And define __ipipe_mach_min_delay to be 8 ticks for the PXA architecture ?

-- 


					    Gilles Chanteperdrix.

