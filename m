From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
Date: Mon, 19 Mar 2007 12:46:15 +0100
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<E1HTDZN-0006rl-2g@domain.hid>
	<45FE7578.4000306@domain.hid>
In-Reply-To: <45FE7578.4000306@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HTGJc-0001oC-Bc@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Wolfgang Grandegger wrote:
> Sebastian Smolorz wrote:
> > Sebastian Smolorz wrote:
> >> Hi Jan,
> >>
> >> Jan Kiszka wrote:
> >>> Wolfgang Grandegger wrote:
> >>>> you know, on the SJA1000 the bus error interrupt can result in high
> >>>> error interrupt rates and even hang the system on slow processors.
> >>>> Just unplugging the CAN cable can cause such interrupt flooding. This
> >>>> problem
> >>>>
> >>>> popped up again recently and Sebastian proposed:
> >>>>> Last summer we had a discussion about the BEI issue on the
> >>>>> socketcan-ML. Two additional handling policies popped up:
> >>>>> 1. The interface could restart itself after an amount of BEIs, thus
> >>>>>    taking responsibility from the user application.
> >>>>> 2. The BEI could be completely disabled if no one is interested in
> >>>>>    this ype of error frame.
> >>>>
> >>>> As 2. is also my preferred solution, I have implemented it. The only
> >>>> downside is that you do not see the error counter increasing when
> >>>> /proc/rtcan/devices is inspected. We also discussed 1., but
> >>>> RT-Socket-CAN does not restart the CAN controller by purpose and just
> >>>> stoppping it requires user intervention.
> >>>
> >>> And if there is someone listening, how is the flooding issue on cable
> >>> unplug etc. solved by option 2?
> >>
> >> Hm, maybe we could implement 1 additionally (but without automatical
> >> restart)?
> >
> > A more precise suggestion: What about letting BEIs appear until passive
> > mode is reached and if the TX error counter doesn't count up any more
> > (indication of start-up situation discovered by the SJA1000) the driver
> > ceases to read out ECC any further (thanks Stephane for the hint). The
> > controller would be still operating but not reporting BEIs any more.
> > There has to be some mechanism to let BEIs through after the situation
> > has normalized. Maybe the driver could check inside the interrupt handler
> > if active mode was reached again after the above situation occured.
>
> Well, this is rather sophisticated and needs some more careful
> evaluation. We might also reach the passive level slowly without
> flooding. Furthermore, the method should also be applicable for other
> controllers.
>
> Let's implement 1. and downscaled printk and wait for the users reaction
> , see also my other mail. Then we should bring up this discussion again
> on the Socket-CAN-ML to negotiate a common solution.
>
> OK?

OK. It was only a hot-of-the-brain-proposal. ;-)

-- 
Sebastian

