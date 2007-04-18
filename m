Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Apr 2007 11:19:52 +0200
Message-ID: <899865CA54E4444DAF2E3639C04C5F4805EC7A@trillian.at.omicron.at>
In-Reply-To: <17957.52859.203341.949031@domain.hid>
From: "Richard Cochran" <richard.cochran@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] [PATCH] Adeos support for IXP4xx
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org, xenomai@xenomai.org

> -----Original Message----- From: Gilles Chanteperdrix
>=20
> The reason for not looping is that Adeos never looses interrupts. If
> we leave the loop and Linux gets delayed, then the lost ticks will
> be accounted for twice: one time because Xenomai will have posted
> the missed timer interrupts, one time because of the loop. So, we
> remove the loop.

Got it.

I'll post a new patch today with your corrections.

> It's explained in the wiki. The PXA timer does not tick if
> programmed with too short delays. To see if IXP4XX has the same
> problem, remove the "if" and run latency with a tight period, so
> that the timer is reprogrammed with short delays. If latency
> misteriously hangs, then you have the same problem as PXA, and you
> should look for the minimum delay by trial and errors.

AFAICT, the only hardware minimum would be 4 ticks (60 nanoseconds at
66.66 MHz), because you cannot set the two low order bits in the
reload register. However, since the ISR requires at least a few
microseconds, perhaps we should set some sanity value, like 5 usec.

Thanks,
Richard

