Message-ID: <4BA4EF75.7010202@domain.hid>
Date: Sat, 20 Mar 2010 16:53:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BA39C3D.1040802@domain.hid>
In-Reply-To: <4BA39C3D.1040802@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCB3397A9C461B1CBE2B24773"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] crash after termination
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCB3397A9C461B1CBE2B24773
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stefan Kisdaroczi wrote:
> hi all,
>=20
> after termination of my xenomai applications, my box crashed often (3 o=
f 4 times) with xenomai 2.5.1.
> Today I updated to current git-2.5, rebuilt xenomai and the kernel. Sti=
ll crashes.
> I have captured two traces over a serial connection. I have attached th=
e kernel config, the two
> traces and the cpuinfo (UP x86 Pentium III). Help is welcome. Thank you=
=2E

Both crashes seem to be caused by corrupted skbs. There are (at least)
two uncommon network component in your kernel: ARCNET and ISDN. Do you
make use of them or are they just passively loaded? If the former: Can
you retry without them? (The Kernel's ISDN stuff is of, well, mixed
quality, and ARCNET is so old and uncommon that the code /may/ have
bit-rotted - just an attempt to detract the attention from Xenomai. :) )

What other network components are actively involved in your scenario?

Jan


--------------enigCB3397A9C461B1CBE2B24773
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuk73gACgkQitSsb3rl5xSOrQCg0o7qod9aZyh52cwmr/QUuVj6
HEEAniX1bsH4o167bvuGDGf5Ouki1ebJ
=Bfbb
-----END PGP SIGNATURE-----

--------------enigCB3397A9C461B1CBE2B24773--

