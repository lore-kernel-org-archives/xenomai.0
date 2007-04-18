Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Apr 2007 07:21:18 +0200
Message-ID: <899865CA54E4444DAF2E3639C04C5F4805EC78@domain.hid>
In-Reply-To: <17957.2183.25570.823923@domain.hid>
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
> For reasons explained on the wiki, I would rather see
> ixp4xx_timer_interrupt implemented as:
>=20
> 	if (__ipipe_mach_timerstolen) {
> 		/* If some other domain has taken over the timer, then
> 		 * do nothing (ipipe has acked it, and the other
> 		 * domain has reprogramed it)
> 		 */
> 		timer_tick();
> 		last_jiffy_time +=3D LATCH;

Okay, I see. This comment, which I copied from other ARM code, is
misleading. In general, Linux cannot be sure that the "other domain"
will never lose interrupts. If there is only one other domain, and
that domain is Xenomai, then we trust it.

Even if Xenomai never loses a timer interrupt, is there some harm in
leaving the loop in?

IMHO, it makes the code more clear to leave the loop, since:

1. You see the connection to the unmodified Linux ISR.

2. The reason for _not_ looping is "invisible" knowledge.

> Why 8 ? It looks suspiciously like you just copied the PXA code.=20

Yes, indeed, it is copied. I put the question back to you: why 8 in
the PXA code?

If I know what 8 means, then I can put the right value for the
IXP4xx ;^)

(Probably this 8 really should be expressed as a macro-ized time
value)

Richard

