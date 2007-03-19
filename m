From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] RT-Socket-CAN bus error handling (was CAN errors
	and real-time behaviour (IRQ raise forever and may lock system))
Date: Mon, 19 Mar 2007 09:21:02 +0100
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<45FD238F.2050009@domain.hid> <45FDA81F.2080004@domain.hid>
In-Reply-To: <45FDA81F.2080004@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HTD6v-0004qo-QI@mailer.emlix.com>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi Jan,

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
> > you know, on the SJA1000 the bus error interrupt can result in high
> > error interrupt rates and even hang the system on slow processors. Just
> > unplugging the CAN cable can cause such interrupt flooding. This problem
> >
> > popped up again recently and Sebastian proposed:
> >> Last summer we had a discussion about the BEI issue on the
> >> socketcan-ML. Two additional handling policies popped up:
> >> 1. The interface could restart itself after an amount of BEIs, thus
> >>    taking responsibility from the user application.
> >> 2. The BEI could be completely disabled if no one is interested in
> >>    this ype of error frame.
> >
> > As 2. is also my preferred solution, I have implemented it. The only
> > downside is that you do not see the error counter increasing when
> > /proc/rtcan/devices is inspected. We also discussed 1., but
> > RT-Socket-CAN does not restart the CAN controller by purpose and just
> > stoppping it requires user intervention.
>
> And if there is someone listening, how is the flooding issue on cable
> unplug etc. solved by option 2?

Hm, maybe we could implement 1 additionally (but without automatical restart)?

>
> What about something like option 3: After the first error occurred that
> may mark the beginning of a flood, disable that error interrupt until
> the next stop/start cycle or the user has read the event?

IIRC, there is no possibility to detect a "normal" bus error (acknowledge) 
appearing during normal operation from the one occuring when the cable is 
plugged off. The best indication is a high number of consecutive BEIs.

-- 
Sebastian

