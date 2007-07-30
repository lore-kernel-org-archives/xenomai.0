Message-ID: <46ADC332.5040909@domain.hid>
Date: Mon, 30 Jul 2007 12:53:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1078462.1185791528606.JavaMail.ngmail@domain.hid>
In-Reply-To: <1078462.1185791528606.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD91F3D076875700BC46DA264"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] V2.3.3 and kernel 2.6.22?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD91F3D076875700BC46DA264
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi everybody,
>=20
> I want to know if it is possible to use Xenomai 2.3.3 with the Adeos pa=
tch
> adeos-ipipe-2.6.22-i386-1.9-01.patch (e.g. from the Xenomai svn trunk)?=

> Or is the 2.3.3 limited to those Adeos patches that are part of the 2.3=
=2E3 release?
>=20
> If it is possible to use the adeos-ipipe-2.6.22 patch, what risks could=
 be caused by this
> "not official" patch?

As Philippe explained earlier, this won't work because Xenomai 2.4
required some deeper modifications to adopt the new clockevent subsystem
that came with 2.6.21 for i386. Those changes will not be backported to
the official stable 2.3 series in order to avoid regressions. But you
are free to do such a backport on your own - though I would rather
suggest to _first_ test 2.4-rc1 if it doesn't work as well (given that
it also includes the global affinity patch...).

>=20
> Or more general: What is the relation between Xenomai and Adeos patches=
?
> Are the Adeos patches used (and tested) somewhere outside of Xenomai?=20
> Or is it always the bundle Adeos + Xenomai?

Xenomai is the only true official user of Adeos/I-pipe. Still, there are
furthers as you may know: RTAI adapts the patches for its own use
regularly (but fails to cooperate on the development, even doesn't
report any glitches of the patches). And there is at least one user
group at Siemens A&D (N=FCrnberg) as you can grab from the archives. But
they changed the patches significantly and are probably yet on some
older kernel (2.6.15).

HTH,
Jan


--------------enigD91F3D076875700BC46DA264
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGrcMyniDOoMHTA+kRAqFqAJ4ubgiyqkMhQF2nuzwPWvJA5mjC5gCaAzM0
mBlERXTyS8tMEW7Juya4MJQ=
=s5sm
-----END PGP SIGNATURE-----

--------------enigD91F3D076875700BC46DA264--

