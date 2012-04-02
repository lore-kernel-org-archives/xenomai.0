Message-ID: <4F7A133E.7000505@domain.hid>
Date: Mon, 02 Apr 2012 22:59:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4F4150C8.7040104@domain.hid> <4F4278ED.9090802@domain.hid>
	<4F478285.8020105@domain.hid> <4F47A161.9010704@domain.hid>
	<4F79C838.2070609@domain.hid> <4F79CBAA.6040107@domain.hid>
	<4F7A0F11.3080504@domain.hid> <4F7A128C.4040706@domain.hid>
In-Reply-To: <4F7A128C.4040706@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3B014B187888D3AA07E33B32"
Subject: Re: [Adeos-main] Reworking ipipe timer subsystem,
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Adeos <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3B014B187888D3AA07E33B32
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-04-02 22:56, Jan Kiszka wrote:
>> No luck, I am using qemu 0.12.5, there is no -global option documented=
,
>=20
> Err, that's prehistoric. Use stable 1.0.x at least to receive proper
> HPET support.

Oh, and there is one further pitfall: You need to provide
-no-kvm-irqchip to use the HPET with MSI support because qemu-kvm does
not forward those MSIs to the kernel irqchip model. I'm sitting on
patches...

Jan


--------------enig3B014B187888D3AA07E33B32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk96Ez4ACgkQitSsb3rl5xT+WACgh0v6YKqH91qEtLrn/mXu5I/i
jSsAn2l9TNA/AQUMB5P50MM9vUs51GG/
=CSnD
-----END PGP SIGNATURE-----

--------------enig3B014B187888D3AA07E33B32--

