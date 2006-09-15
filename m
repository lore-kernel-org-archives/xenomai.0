Subject: Re: [Xenomai-core] No hardware interrupts with xenomai on ppc405
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4505A75B.8000601@domain.hid>
References: <4503EB88.2040309@domain.hid>
	<1157988739.4991.11.camel@domain.hid> <450584D7.6050009@domain.hid>
	<200609111904.16512.matthias.fuchs@domain.hid>
	<4505A75B.8000601@domain.hid>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 16:18:35 +0200
Message-Id: <1158329916.5072.11.camel@domain.hid>
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Mon, 2006-09-11 at 20:13 +0200, Wolfgang Grandegger wrote:
> Matthias Fuchs wrote:
> > On Monday 11 September 2006 17:46, Wolfgang Grandegger wrote:
> >>> A possible explanation is that configurations only using the timer IRQ
> >>> are not affected, since the decrementer is not subject to this issue
> >>> (the tick handler returns XN_ISR_NOENABLE anyway).
> >> I run RT-Socket-CAN on a CAN PCI Card on my MPC5200 without any 
> >> problems, so far (under Linux 2.4). Here the end function of the PIC:
> >>
> >>    static void
> >>    mpc5xxx_ic_end(unsigned int irq)
> >>    {
> >>          if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
> >>                  mpc5xxx_ic_enable(irq);
> >>    }
> >>
> >> Matthias, have you printed out the value of status? I'm just curious.
> >>
> >> Wolfgang.
> > 
> > Here it comes:
> > bash-3.00# ./bin/rtcansend rtcan0 -i 0 1 2 3 4
> > _end: status=00000042
> > bash-3.00# ./bin/rtcansend rtcan0 -i 0 1 2 3 4
> > _end: status=00000042
> > bash-3.00# ./bin/rtcansend rtcan0 -i 0 1 2 3 4
> > _end: status=00000042
> > 
> > So it's IRQ_DISABLED (=2).
> 
> In 2.6 the interrupts are disabled by default. Then the attached patch 
> for Xenomai should help.


Applied, thanks.

-- 
Philippe.



