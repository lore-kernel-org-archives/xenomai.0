Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 2 Apr 2007 08:52:15 +0200
Message-ID: <899865CA54E4444DAF2E3639C04C5F4805EC63@domain.hid>
In-Reply-To: <200704010957.l319viZD032109@domain.hid>
From: "Richard Cochran" <richard.cochran@domain.hid>
Subject: [Adeos-main] Re: Re: Porting to Intel IXP425
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

> This is needed for machines where the hardware timer is based on a
> decrementer. But for machines with a free-running counter and a match
> register, reading the value of the free-running counter is
> simpler. IXP425 is in the  "free-running counter and match register
> category". So, its implementation should look like the one of the PXA.

The IXP425 does not have a match register, AFAICT.

It does have four 32-bit counters clocked at 66.66 MHz: a watch dog, a
free-running timestamp, and two general purpose timers.

The general purpose timers may be used either as one-shot timers
(count down to zero and stop) or as periodic times (count down,
automatically reload, and keep going).

I already have xenomai running on the IXP425, but I will have to take
a closer look at the timer code.

Richard

