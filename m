Message-ID: <441845EA.3070602@domain.hid>
Date: Wed, 15 Mar 2006 17:50:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid>	<4417C14A.2010900@domain.hid>
	<17432.6129.478721.712374@domain.hid>
In-Reply-To: <17432.6129.478721.712374@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF767431C791BB64E7A8A4F12"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF767431C791BB64E7A8A4F12
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Likely too simple: The periodic IRQ seems to pop up on every CPU so =
that
>  > the TSC could be recorded, but will this happen synchronously? At le=
ast
>  > we will see (IRQ) jitters, and those jitters could already create in=
 the
>  > single-CPU case a non-monotonic clock...
>=20
> I do not know how this issue is solved in Linux, but there seem to be a=

> simple solution: before adding the tsc offset to the last tick time,
> this tsc offset should be compared with the tick duration in tsc
> counts; if it is greater, then replace with the tick duration in tsc.
>=20

Hmm, I would rather express it in absolute tsc values, i.e. always save
the tuple (absolute_tsc, jiffies):

[timer IRQ]
new_tsc =3D read_rsc() - old_tsc;
if (new_tsc < old_tsc + period_in_tsc_ticks)
	new_tsc =3D old_tsc + period_in_tsc;
old_tsc =3D new_tsc;

Disclaimer: I haven't thought about potential accuracy side effects of
this implementation, e.g. what would happen over the long term if the
condition is always fulfilled and executed...

Jan


--------------enigF767431C791BB64E7A8A4F12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGEXqniDOoMHTA+kRAlFZAJ4k5SZx6//H6JoyHZWgIiCqn9jiggCfQrXV
X/KoWAKil8eE8e0UUk3yedQ=
=yuB2
-----END PGP SIGNATURE-----

--------------enigF767431C791BB64E7A8A4F12--

