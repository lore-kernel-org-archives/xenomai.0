Message-ID: <4BEB1C06.7030907@domain.hid>
Date: Wed, 12 May 2010 23:22:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BEB0A05.5020006@domain.hid> <4BEB0EF2.7020604@domain.hid>
In-Reply-To: <4BEB0EF2.7020604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig42FE855131F2D615EFCECAFC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] native kernel task example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramoncostacastello@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig42FE855131F2D615EFCECAFC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> On 05/12/2010 10:05 PM, Ramon wrote:
>> Hi,
>>
>> I'm looking for a very simple kernel task using native api.
>> A very simple one would be nice, a periodical task for example.
>>
>> I'm interested in the .c file and its Makefile.
>=20
> You can find examples in the "examples" directory of the Xenomai tree
> as documented here:
>=20
> http://xenomai.org/index.php/Examples
>=20
> http://www.rts.uni-hannover.de/xenomai/lxr/source/examples/native/trivi=
al-periodic.c
>=20
> might be what you are looking for.
>=20
> Wolfgang.

Just be warned that the in-kernel skin usage is considered deprecated
(with exception of RTDM). It may not be the best choice when starting
something new.

Jan


--------------enig42FE855131F2D615EFCECAFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvrHBUACgkQitSsb3rl5xRVGgCfXb2VV0Nu/6PWvFom05PO/rmm
rCYAoKYtBzWGZPG4OA1V4Awg7810r0KD
=EqGQ
-----END PGP SIGNATURE-----

--------------enig42FE855131F2D615EFCECAFC--

