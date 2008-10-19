Message-ID: <48FB73A9.2000302@domain.hid>
Date: Sun, 19 Oct 2008 19:51:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48FB693B.2080104@domain.hid> <48FB6D40.5090903@domain.hid>
In-Reply-To: <48FB6D40.5090903@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4297DBB6E01F5E1C1F5522DA"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [PATCH] x86: Don't instrument vdso functions
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4297DBB6E01F5E1C1F5522DA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> The mcount instrumentation is currently leaking into vdso functions.
>> Patch below fixes this (bits taken from 2.6.27).
>=20
> What are these vdso functions? Functions called from user-space?

They belong to a virtual lib that is automatically mapped into every
process. They provide the same functionality like vsyscalls, but with a
different way to address them (VDSO is more flexible, vsyscalls are legac=
y).

Jan


--------------enig4297DBB6E01F5E1C1F5522DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEUEARECAAYFAkj7c6sACgkQniDOoMHTA+kF3wCYzgW28odIzjsh4nOapvdXoNfC
cwCeOlL4KbHFXoNWZ5sFYAP0A3MPOJI=
=FlcB
-----END PGP SIGNATURE-----

--------------enig4297DBB6E01F5E1C1F5522DA--

