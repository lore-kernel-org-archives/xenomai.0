Message-ID: <4667AA4D.6070505@domain.hid>
Date: Thu, 07 Jun 2007 08:48:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7289437c0706060801i299d6881w31cc5ffee3444ace@domain.hid>	<DD39B5C3F4963040ADC9768BE7E430CB01FAF561@domain.hid>	<1181143109.17978.101.camel@domain.hid>
	<7289437c0706062254v2a386894oeb498459877d5086@domain.hid>
In-Reply-To: <7289437c0706062254v2a386894oeb498459877d5086@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2460B21D66DEAC112220C957"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Cyclictest
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2460B21D66DEAC112220C957
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Perrine Martignoni wrote:
>> Did you double-check that you were not testing Xenomai with the
>> "vanilla" cyclictest, ie. the one without libpthread_rt dependencies..=
=2E?
>> See "ldd cyclictest" when in doubt.
>=20
> Yes, I did. I wanted to know performances of cyclictest without Xenomai=
 to
> compare.
> And I thought that even with Xenomai in the kernel, I would have the sa=
me
> result.

Then re-read Philippe's comment please.

If you want to test average performance, rather use something like lmbenc=
h.

Jan


--------------enig2460B21D66DEAC112220C957
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZ6pOniDOoMHTA+kRAnF9AJ9uENWieFrvdv1x5cFGIi/1rAA7iQCfTlp8
u48+VRSYrisAsXf4zHpIgL4=
=PHbr
-----END PGP SIGNATURE-----

--------------enig2460B21D66DEAC112220C957--

