Message-ID: <45D34A6F.9050406@domain.hid>
Date: Wed, 14 Feb 2007 18:44:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] pthread_make_periodic_np and clock_gettime
References: <5D63919D95F87E4D9D34FF7748CE2C2A8018AD@ARVMAIL1.mra.roland-man.biz>	<45D20F8E.9040900@domain.hid>
	<17874.6444.25366.622467@domain.hid>
In-Reply-To: <17874.6444.25366.622467@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7AE3981C554EA454DF5FA9D7"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Roderik_Wildenburg@domain.hid, Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7AE3981C554EA454DF5FA9D7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Roderik_Wildenburg@domain.hid wrote:
>  > > Can anybody tell me, how I have to set the 2. parameter (starttp) =
of
>  > > pthread_make_periodic_np ?
>  > > When I use clock_gettime to fill startp I get a giant timeout valu=
e in
>  > > the /proc/xenomai/sched list and my task never gets periodic.
>  > >=20
>  > > Is this just a problem of my hardware(PPC)/xenomai(2.3) combinatio=
n or
>  > > does anybody else have the same problem.=20
>  > >=20
>  > > See attached code example for easier testing.
>  > >=20
>  >=20
>  > Confirmed over v2.3.x in periodic mode, aperiodic is fine. Gilles?
>=20
> Ok. I will have a look at it.
>=20

Hmm, something went wrong here. I think I passed a too fast tick_arg to
the kernel yesterday which smashed the timing. I'm now running the
pperiodic demo at tick_arg=3D1000000 successfully.

So, Roderik, either you did some similar mistake, or it's a PPC issue.

Jan


--------------enig7AE3981C554EA454DF5FA9D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF00pvniDOoMHTA+kRAqT5AJ9kAM1tIibYUlA5T211MfJBKAQTCQCfSuuf
SeP7TSdPXOwl9Fow5t18kM0=
=MZJe
-----END PGP SIGNATURE-----

--------------enig7AE3981C554EA454DF5FA9D7--

