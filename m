Message-ID: <4538BEC8.7080304@domain.hid>
Date: Fri, 20 Oct 2006 14:19:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Testsuite latency
References: <54b161f50610200324q625b79bcg45e1c3d0b2b19b77@domain.hid>
In-Reply-To: <54b161f50610200324q625b79bcg45e1c3d0b2b19b77@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0641FBFC1E3C862B60482732"
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
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0641FBFC1E3C862B60482732
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Frits de Klark wrote:
> Hello everyone,
>=20
> as sort of a newbie to Xenomai (and realtime Linux in general) I'm the
> moment running the (unmodified) latency test included in the testsuite =
 in
> different situations:
>=20
> Situation A: Running as little daemons as possible in the background. T=
he
> chart I produced from the testdata, after running it for about 15 minut=
es,
> without doing anything else on the machine, shows very stable results, =
that
> is: there a no visible peaks downwards. Iin the case of MAX for example=
,
> the
> value is most of the time between 2.7 and 2.9, occasionly going straigh=
t up
> in the air, but NEVER below 2.7.
> WORST is 5.33, BEST is 0.40.
>=20
> Situation B: Running 1 'unneccesary' daemon, mysqld, but performing no
> database operations whatsoever. The chart I produced from this testdata=
 (it
> also ran for 15 minutes) is completely different and the line represent=
ing
> MAX is going up and down all the time, it looks VERY unsteady.
> In this case WORST is 16.52 and BEST is 1.11.

Check xenomai/TROUBLESHOOTING for appropriate load to test for the worst
case.

Jan


--------------enig0641FBFC1E3C862B60482732
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFOL7IniDOoMHTA+kRAo/nAJ0feYi5wy0gWVO3fABRBl3tozltHACgg25N
jWLcT4sCkxFSPqBVIqGY7rw=
=jI6O
-----END PGP SIGNATURE-----

--------------enig0641FBFC1E3C862B60482732--

