Message-ID: <47C7058A.8080100@domain.hid>
Date: Thu, 28 Feb 2008 20:03:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2220D86D21B55040AB683933DBD97B5A014DF68EF2@domain.hid>
In-Reply-To: <2220D86D21B55040AB683933DBD97B5A014DF68EF2@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD7E76BE8C0FF210C68B01B65"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rt_intr_create fails, err = 38 (ENOSYS)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?=22Hans_S=F8ndergaard_=28HSO=29=22?= <HSO@VIAUC.DK>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD7E76BE8C0FF210C68B01B65
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hans S=F8ndergaard (HSO) wrote:
> My rt_tasks (periodic) and rt_events work now.
> Next I have started using interrupts: rt_intr_create.
>=20
> It fails with return value =3D 38 (ENOSYS).
>=20
> I follow the template from Xenomai's homepage: user_irq.c
>=20
> In .config I have set: CONFIG_XENO_NATIVE_INTR=3Dy.

Are you sure you are actually running the related kernel? At least, it
is one of my favorite mistakes to mess up the built and the actually
installed/execute kernel and modules. To check if the kernel (or the
modules, accordingly) contains those services run

objdump -t vmlinux | grep rt_intr

Jan


--------------enigD7E76BE8C0FF210C68B01B65
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHxwWKniDOoMHTA+kRAlKIAJ9+I/ZPSYQl9VAYW4aeJpYzhdf1PwCeM9Bl
qutYJdDFc/kxIbL/Hae0olA=
=nNYY
-----END PGP SIGNATURE-----

--------------enigD7E76BE8C0FF210C68B01B65--

