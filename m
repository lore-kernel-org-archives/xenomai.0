Message-ID: <4CCB0D22.4060406@domain.hid>
Date: Fri, 29 Oct 2010 20:06:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>	<4CC84327.9070202@domain.hid>	<4CC92786.3030509@domain.hid>	<4CC92902.4040904@domain.hid>	<4CC943A2.9020806@domain.hid>	<4CC94E0B.9070106@domain.hid>
	<4CC97448.3040205@domain.hid>	<4CC99129.50507@domain.hid>
	<4CC99215.80600@domain.hid>	<4CC9944D.8050909@domain.hid>
	<4CC9980C.6080003@domain.hid> <4CCB078C.1010102@domain.hid>
In-Reply-To: <4CCB078C.1010102@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3C38E33DCE66DF4C54300EC3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3C38E33DCE66DF4C54300EC3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 29.10.2010 19:42, Anders Blomdell wrote:
> Jan Kiszka wrote:
>=20
>>>> Please provide the full kernel log, ideally also with the I-pipe tra=
cer
>>>> (with panic tracing) enabled.
>>> Will reconfigure/recompile and do that, with full kernel log do you
>>> mean all
>>> bootup info?
>>
>> That's best to avoid missing some detail or doing Q&A ping-pong.
>=20
> Full trace attached (finally...)
>=20

You have to switch off CONFIG_DMA_API_DEBUG, it's incompatible with Xenom=
ai.

Jan


--------------enig3C38E33DCE66DF4C54300EC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkzLDScACgkQitSsb3rl5xSH8gCeK1c+f/aV5Lm2X5uM6J18lt7i
awwAnRF8pyLLKqfF+nfX24YASoYwUvAc
=MOku
-----END PGP SIGNATURE-----

--------------enig3C38E33DCE66DF4C54300EC3--

