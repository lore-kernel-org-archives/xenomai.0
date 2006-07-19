Message-ID: <44BE126B.4000209@domain.hid>
Date: Wed, 19 Jul 2006 13:07:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 3/2] kill XN_INFINITE xntimer delays
References: <44BDD70F.8080401@domain.hid>	<17598.1897.208601.381463@domain.hid>
	<1153305981.5036.33.camel@domain.hid>
In-Reply-To: <1153305981.5036.33.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9B30C20972EFFF26DAB0095E"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9B30C20972EFFF26DAB0095E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2006-07-19 at 12:20 +0200, Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>  > [Appendix to the xntimer cleanup series.]
>>  >=20
>>  > Having to take care for infinite delays in xntimer_start (i.e. to N=
OT
>>  > start the timer...) is a bit suboptimal given that his service migh=
t be
>>  > used heavily to restart timers. This patch converts the only user
>>  > (xnpod_start_timer again) and cleans up the timer code.
>>  >=20
>>  > Jan
>>  > ---
>>  >  ksrc/nucleus/pod.c   |   10 ++++++----
>>  >  ksrc/nucleus/timer.c |   34 ++++++++++++----------------------
>>  >  2 files changed, 18 insertions(+), 26 deletions(-)
>>  >=20
>>  > Index: xenomai/ksrc/nucleus/pod.c
>>  > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  > --- xenomai.orig/ksrc/nucleus/pod.c
>>  > +++ xenomai/ksrc/nucleus/pod.c
>>  > @@ -3095,10 +3095,12 @@ int xnpod_start_timer(u_long nstick, xni
>>  > =20
>>  >  	xntimer_set_sched(&nkpod->htimer, xnpod_sched_slot(XNTIMER_KEEPER=
_ID));
>>  > =20
>>  > -	xnlock_get_irqsave(&nklock, s);
>>  > -	xntimer_start(&nkpod->htimer, delta,
>>  > -		      XNARCH_HOST_TICK / nkpod->tickvalue);
>>  > -	xnlock_put_irqrestore(&nklock, s);
>>  > +	if (delta) {
>>
>> Should not this rather be if (XNARCH_HOST_TICK) ?
>=20
> Both work, even if using the macro would get the unused code optimized
> away. The bottom line is that we need to refrain from starting the time=
r

Optimising away sounds good to me :). As we are already on it, I would
second Gilles' suggestion. It also makes the code more readable ("we do
not need the following when XNARCH_HOST_TICK is 0").

> whenever the delta value is zero, since it's a clear sign that
> XNARCH_HOST_TICK is zero in the first place. In all other cases, the
> delta value must be non-zero, even if the elapsed portion of the curren=
t
> tick is null.
>=20
>>  > +		xnlock_get_irqsave(&nklock, s);
>>  > +		xntimer_start(&nkpod->htimer, delta,
>>  > +			      XNARCH_HOST_TICK / nkpod->tickvalue);
>>  > +		xnlock_put_irqrestore(&nklock, s);
>>  > +	}
>>



--------------enig9B30C20972EFFF26DAB0095E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEvhJrniDOoMHTA+kRAoGXAJ98fVMIVHv6flR4ziBlF30cOIE0IgCeJYj0
/Po0PrRP2Fi3sh2XE1KN7tM=
=9xpB
-----END PGP SIGNATURE-----

--------------enig9B30C20972EFFF26DAB0095E--

