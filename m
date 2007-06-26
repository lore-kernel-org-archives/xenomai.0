Message-ID: <4681332D.2030105@domain.hid>
Date: Tue, 26 Jun 2007 17:39:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <15cf230500002197@domain.hid>
In-Reply-To: <15cf230500002197@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA96CF943468BFD510AB55FD1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] accessing context switch counter from rttask
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gsellmann Peter <Peter.Gsellmann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA96CF943468BFD510AB55FD1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gsellmann Peter wrote:
> Hi!
>=20
> I searched for a while and found this snippet
>=20
> RT_TASK *rt =3D rt_task_self();
> int x =3D rt->thread_base.stat.csw;
>=20
> should give the number of context switches, but:
> RT_TASK in non-kernel mode is only RT_TASK_PLACEHOLDER so i have no
> access to thread_base!
>=20
> Is there an official way to get this info (w/o opening
> "/proc/xenomai/...")?
>=20

Not yet. You could extend RT_TASK_INFO with this statistic (obtained via
rt_task_inquire). There is currently work in progress to add accumulated
execution times to the same interface, so this extension would fit quite
well. Patches always welcome.

Jan


--------------enigA96CF943468BFD510AB55FD1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgTMtniDOoMHTA+kRAtazAJ44lJLkQElFF2aJpucTbUt5WbkE/QCfSWwB
QdwptFmre5VZRjiF4G7gVpI=
=b2Pc
-----END PGP SIGNATURE-----

--------------enigA96CF943468BFD510AB55FD1--

