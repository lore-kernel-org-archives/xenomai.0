Message-ID: <487E29B9.40904@domain.hid>
Date: Wed, 16 Jul 2008 19:02:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <487E1BE8.1000306@domain.hid>
In-Reply-To: <487E1BE8.1000306@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Error propagating ISR to Linux domain
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Benjamin ZORES <benjamin.zores@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Benjamin ZORES wrote:
> Hi,
> 
> I've encountered a little problem when trying to propagate an ISR from 
> Xenomai to Linux context.
> 
> To sum up clearly, I'm writing an RT kernel module that drives a PCI card.
> I've registered a nucleus ISR handler on the IRQ attributed to this card.
> 
> On some systems, this IRQ is dedicated to this PCI card only.
> Though, on others, it is shared with other peripherals.
> Hence, I need to forward/propagate this IRQ to Linux domain for other 
> drivers to handle it
> when the IRQ has not been initiated by my PCI card.

If you also need deterministic IRQ handling in the shared case, that
approach won't fly. It may work to some degree if there are significant
gaps between the individual IRQs, so significant that one can assume
Linux will always be reactive enough to handle the last forwarded IRQ
(and thus release the line before the RT event arrives).

The only truly deterministic solution is to write minimal IRQ handlers
for the involved Linux devices in RT space, ie. for Xenomai. RT-IRQ
sharing works nicely.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

