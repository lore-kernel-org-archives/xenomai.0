Message-ID: <45AE67AF.2020105@domain.hid>
Date: Wed, 17 Jan 2007 19:15:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xeno_16550A and 8250.nr_uarts=0
References: <45A68383.3070203@domain.hid>
	<45A6CB80.9060306@domain.hid>	<45A802CD.8010606@domain.hid>
	<45AA3D26.2040409@domain.hid> <45AB8CC0.8020008@domain.hid>
	<45AD4144.1060006@domain.hid>
In-Reply-To: <45AD4144.1060006@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFD7B0589091053B099918254"
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFD7B0589091053B099918254
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> Jan Kiszka wrote:
>> Here is an untested variant of your patch, implementing my ideas. I
>> currently don't have my hands on any hardware that is able to stress t=
he
>> code appropriately, and you have the ultimate test case anyway. So
>> please let me know if it works for you. Note: You /should/ be able to
>> leave the irq parameter open with this approach.
>=20
> I applied the v2 patch and recompiled the kernel with xeno_16550A built=

> in.  Everything seems to work fine for me with and without the irq
> parameter specified.
>=20

OK, it's applied now to SVN trunk. Hope you don't mind that I credited
your contribution. :)

Jan


--------------enigFD7B0589091053B099918254
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFrmevniDOoMHTA+kRAm02AJ9pKyv8vtOE8boh/RN/hHE81Nl6lwCfaBu3
JJ13q3EUIbSsoDHWB2YwKfU=
=VC3O
-----END PGP SIGNATURE-----

--------------enigFD7B0589091053B099918254--

