Message-ID: <44BF62FE.6080404@domain.hid>
Date: Thu, 20 Jul 2006 13:03:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strange behaviour w/mutex&semaphore
References: <FDBBB5CC70676540B3EF7CFE83FD94E04F5517@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E04F5517@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA8F7C9837721C179363E9C8F"
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
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA8F7C9837721C179363E9C8F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

ROSSIER Daniel wrote:
> Hi all,
>=20
> I've a strange behaviour with the attached piece of code.
> It's really simple: there are 3 tasks and we're spinning within the tas=
k in order
> to simulate task load.
>=20
> It's a pure academic exercice, so don't try to think about the usefulne=
ss of this code ;-)
>=20
>=20
> Actually, after insmod'ing the code into the kernel, the system freezes=
 and
> the "meteoDataAcquisition" task is suspended runaway by the internal xe=
nomai watchdog.
>=20
> Why?
>=20
> Anything wrong in this code?

Check the values you assign to rt_task_set_periodic. Kind of... fast?

>=20
> Thanks for any advice.
>=20
> Daniel
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help



--------------enigA8F7C9837721C179363E9C8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEv2L+niDOoMHTA+kRAhJ/AJ9MUScA0xKPdvXCrVq33Hvu+jdqQgCdHnyS
Tiz72bEoj4o/t/40huLkS2o=
=C7SJ
-----END PGP SIGNATURE-----

--------------enigA8F7C9837721C179363E9C8F--

