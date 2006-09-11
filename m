From: Matthias Fuchs <matthias.fuchs@domain.hid>
Subject: Re: [Xenomai-core] No hardware interrupts with xenomai on ppc405
Date: Mon, 11 Sep 2006 19:04:16 +0200
References: <4503EB88.2040309@domain.hid>
	<1157988739.4991.11.camel@domain.hid> <450584D7.6050009@domain.hid>
In-Reply-To: <450584D7.6050009@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609111904.16512.matthias.fuchs@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>

On Monday 11 September 2006 17:46, Wolfgang Grandegger wrote:
> > 
> > A possible explanation is that configurations only using the timer IRQ
> > are not affected, since the decrementer is not subject to this issue
> > (the tick handler returns XN_ISR_NOENABLE anyway).
> 
> I run RT-Socket-CAN on a CAN PCI Card on my MPC5200 without any 
> problems, so far (under Linux 2.4). Here the end function of the PIC:
> 
>    static void
>    mpc5xxx_ic_end(unsigned int irq)
>    {
>          if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
>                  mpc5xxx_ic_enable(irq);
>    }
> 
> Matthias, have you printed out the value of status? I'm just curious.
> 
> Wolfgang.

Here it comes:
bash-3.00# ./bin/rtcansend rtcan0 -i 0 1 2 3 4
_end: status=00000042
bash-3.00# ./bin/rtcansend rtcan0 -i 0 1 2 3 4
_end: status=00000042
bash-3.00# ./bin/rtcansend rtcan0 -i 0 1 2 3 4
_end: status=00000042

So it's IRQ_DISABLED (=2).

Matthias

