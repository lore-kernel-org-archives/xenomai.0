Message-ID: <4443CA1B.3010504@domain.hid>
Date: Mon, 17 Apr 2006 19:02:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4443BF6E.907@domain.hid>
	<17475.49504.514098.178400@domain.hid>
In-Reply-To: <17475.49504.514098.178400@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0749EDD9E6D384F842194FC4"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] Re: [PATCH] clean up latest ipipe-tracing changes
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0749EDD9E6D384F842194FC4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > (...). Finally, I do not see a need for marking a static inline func=
tion
>  > non-traced. (...)
>=20
> Marking a function inline does not guarantee that the said function wil=
l
> always be inlined, especially since with 2.6.16, inline no longer
> necessary means __attribute__((always_inline)).
>=20

Yep, correct, though this particular function should only be non-inlined
by a confused compiler. So, shouldn't we rather convert this function
into a macro or mark it as always_inline? A review of the tracer for
further clarifications is required, I guess.

Jan


--------------enig0749EDD9E6D384F842194FC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEQ8oeniDOoMHTA+kRAsFJAJ9ABVfvzcsjQR5N8vyHcPbTVBO+SQCeMwAA
7iq4Xy6NlBJN+P/Ee7k1T8A=
=CHN3
-----END PGP SIGNATURE-----

--------------enig0749EDD9E6D384F842194FC4--

