Message-ID: <4BDD4103.5090609@domain.hid>
Date: Sun, 02 May 2010 11:08:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BD5987A.2050804@domain.hid> <4BD59A48.5070002@domain.hid>	
	<4BD5BA03.5000101@domain.hid>	
	<1272331158.28983.287.camel@domain.hid>	<4BD68843.4030806@domain.hid>	
	<1272356029.28983.333.camel@domain.hid>	
	<4BD69F7D.9060006@domain.hid>	
	<1272359559.28983.380.camel@domain.hid>	
	<4BD6AE1E.6050704@domain.hid>	
	<1272360740.28983.382.camel@domain.hid>	
	<4BD6AFC2.1090300@domain.hid>	
	<1272361898.28983.395.camel@domain.hid>	
	<4BD6BF21.20303@domain.hid>	
	<1272734766.2440.46.camel@domain.hid>
	<4BDC6924.2070302@domain.hid>
	<1272740361.2440.49.camel@domain.hid>
In-Reply-To: <1272740361.2440.49.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2DE50D444BD65E31525BBD93"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] nucleus: Plug race between
	rpi_clear_remote and rpi_next
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2DE50D444BD65E31525BBD93
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sat, 2010-05-01 at 19:47 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Don't you think that, quoting yourself:
>>>
>>> "I have to confess, I do not understand how the patch may relate to o=
ur
>>> crash. But that's because I still only have a semi-understanding of t=
his
>>> frightening complex RPI code"
>>>
>>> does not fit that well with any kind of strong assertion made later o=
n
>>> the same topic, not backed by facts?
>> See, as long as you do not directly explain why my concerns on this
>> naturally racy construct were not valid (I brought up quite a few
>> concrete questions),
>=20
> Which were answered. And you seem to consider that a construct is racy
> by design without taking care of understanding why they could be
> perfectly valid in the proper context. This is what I was pointing out,=

> all time long.

Depends on the POV. But what counts is the outcome of this, and that's a
fix.

Jan


--------------enig2DE50D444BD65E31525BBD93
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvdQQkACgkQitSsb3rl5xR7NgCfX4tqqLgz9r4W5O/sxYvr7Dia
V34AoK0iS7iHK+0x8DnTf+xibQ1lY+R2
=O9lk
-----END PGP SIGNATURE-----

--------------enig2DE50D444BD65E31525BBD93--

