Message-ID: <472653D0.6040105@domain.hid>
Date: Mon, 29 Oct 2007 22:42:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4726513D.9020308@domain.hid>
In-Reply-To: <4726513D.9020308@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB5A69C9C2ACE69BC5B8793AE"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH] janitorial: remove i8253_lock conversion
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB5A69C9C2ACE69BC5B8793AE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Unless I'm utterly wrong, there are practically only two use cases
> regarding the PIT: Either Linux has complete hold of it for clocksource=

> and/or clockevent usage, or the RT domain takes it over, also
> completely. In both cases the RT domain does not need to use the
> i8253_lock (see Xenomai). So let's remove the hunks that harden this
> lock for no good (upcoming 2.6.24 would otherwise require even
> _extended_ patching). Patch addresses i386, but this cleanup should be
> applicable to x86_64 likewise.
>=20
> Jan

PS: voyager hunk was uncompilable anyway.


--------------enigB5A69C9C2ACE69BC5B8793AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHJlPQniDOoMHTA+kRAu9+AJ4+gXdZopeuOzl50efV9KywDjG/eACeOY31
qdhLSsfATRivuiL+lXYJOa8=
=SXXM
-----END PGP SIGNATURE-----

--------------enigB5A69C9C2ACE69BC5B8793AE--

