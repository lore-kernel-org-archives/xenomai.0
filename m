Message-ID: <440466C6.9050706@domain.hid>
Date: Tue, 28 Feb 2006 16:05:42 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Page faults
References: <fd6a47a90602280622o4cfb2b79g@domain.hid>
In-Reply-To: <fd6a47a90602280622o4cfb2b79g@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig31C30E1965A9151868DB0EC3"
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig31C30E1965A9151868DB0EC3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeroen Van den Keybus wrote:
> I'm observing a considerable amount of Page Faults (5090 after an hour =
or
> so), each one associated with a MSW increase in /proc/xenomai/stat. I'm=

> missing RT deadlines on those occasions and I want to fix it, so I woul=
d
> like to know what Page Faults actually are.
>=20

Maybe not all of your user memory is cleanly locked and got swapped out
(swapping activated?). If you don't see kernel oopses and your programs
don't receive segfaults, these faults are references to swapped out or
not yet mapped in pages. BTW, what does the kernel console tell you?

The deadline misses as a result are "normal": your RT thread gets
switched to secondary mode to handle the fault, and handling it may take
some time...

Jan


--------------enig31C30E1965A9151868DB0EC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEBGbGniDOoMHTA+kRAgcRAJ951EddOnJwCnziQaZi/IvtY+GnhACeMKXK
MouewEvQEtffynZUhSI1guI=
=iRtS
-----END PGP SIGNATURE-----

--------------enig31C30E1965A9151868DB0EC3--

