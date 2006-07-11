Message-ID: <44B3DA74.1070405@domain.hid>
Date: Tue, 11 Jul 2006 19:05:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] binding without root access..
References: <e325d110607110905i40097009n517ad8b05c4b6cb4@domain.hid>
In-Reply-To: <e325d110607110905i40097009n517ad8b05c4b6cb4@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig34EE54D2F6A09065A3A3A606"
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
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig34EE54D2F6A09065A3A3A606
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Kim Chuan Lim wrote:
> Hi all,
>=20
> Xenomai: binding failed: Operation not permitted.
>=20
> Is it possible for me to do the binding without switching to root?

Switch off XENO_OPT_SECURITY_ACCESS, but you will likely run on other
barriers later (like the number of mlock'able pages, essential for RT).
What is your motivation to run RT apps as non-root?

Jan


--------------enig34EE54D2F6A09065A3A3A606
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEs9p0niDOoMHTA+kRAmw7AJ9TNCycCNOouU1XDwgqzyoe8ndy3gCfcLHj
j3ErBYz2yJmuRvZ5WYSME38=
=9GW3
-----END PGP SIGNATURE-----

--------------enig34EE54D2F6A09065A3A3A606--

