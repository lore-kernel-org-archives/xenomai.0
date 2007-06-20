Message-ID: <4679A2AD.5050102@domain.hid>
Date: Wed, 20 Jun 2007 23:57:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <467639BE.30504@domain.hid>	<467641F3.3010308@domain.hid>	<1182357772.6137.39.camel@domain.hid>	<18041.27025.80273.654686@domain.hid>	<4679778B.6080102@domain.hid>
	<18041.38156.744377.601270@domain.hid>
In-Reply-To: <18041.38156.744377.601270@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEE4A11DB0EF5315B2FE791CD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH-STACK] Synchronised timebases and more
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEE4A11DB0EF5315B2FE791CD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > I was afraid you would insist on this support. ;)
>=20
> Well, clock_settime is almost the only service missing in posix skin,
> and since I saw in Thomas Gleixner slides that one reason for not using=

> Xenomai is that its posix support is incomplete, I am eager to implemen=
t

Well, those slides are from a time when Thomas already made up his plans
(I watched his first LibeRTOS presentation in 2003...).

> the missing services (and to remove the sentence "xenomai posix skin is=

> a work in progress" from posix skin text file).

Anyway, your goal is valid.

>=20
>  >=20
>  > There are two ways to implement this:
>  >=20
>  >  A) The poor man's variant
>  >=20
>  >     On xntbase_adjust_time() (the code will change again, pay attent=
ion!
>  >     ;) ), iterate over all pending timers (or over all timers in the=

>  >     base that POSIX uses?) and fix those which do not have the recen=
tly
>  >     introduced XNTIMER_MONOTONIC flag set. "Poor man" because it's
>  >     simple, but it scales poorly.
>  >=20
>  >  B) The scalable but complex one
>  >=20
>  >     Introduce a second time base for each existing one (or for the o=
ne
>  >     that POSIX uses?), put in all the adjustable (realtime) timers. =
We
>  >     then only need to play with the base's clock offset on adjustmen=
t,
>  >     but we would also have to include that offset into timeout
>  >     considerations inside the timer interrupt handler.
>  >=20
>  > I wonder now if the number of use cases where people are playing wit=
h
>  > the wallclock all over the time while a significant amounts of timer=
s
>  > are pending is actually worth the troubles of B)... What do you thin=
k?
>=20
> I think one use of clock_settime would be to resync Xenomai clock with
> Linux one from time to time, but even if we implemented B, that would b=
e
> a bad idea because of the effect on timers. So, A would be enough for m=
e.

For the resync with any kind of external time source, I rather have a
scheme of one set-time during startup + continuous clock frequency
tuning in mind. As you say, permanently playing with the offset is _bad_.=


So only the question remains if we should apply the timer adjustment on
all bases or only the POSIX-related one.

Jan


--------------enigEE4A11DB0EF5315B2FE791CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGeaKuniDOoMHTA+kRAgXBAJ499fNPgDICJJZptSE0CrtNgcBVoQCfadFq
Jk0I3QVA1tbk66ebz4//Gro=
=S59C
-----END PGP SIGNATURE-----

--------------enigEE4A11DB0EF5315B2FE791CD--

