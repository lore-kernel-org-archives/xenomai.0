Message-ID: <45C3435C.6070803@domain.hid>
Date: Fri, 02 Feb 2007 14:57:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] rt_dev_open() returns -EBUSY
References: <AD78122AD7C05B4B936EBAD7F49738C0AB2B99@domain.hid>
	<AD78122AD7C05B4B936EBAD7F49738C0AB2B9A@square.bfh.ch>
In-Reply-To: <AD78122AD7C05B4B936EBAD7F49738C0AB2B9A@square.bfh.ch>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA629BDDB60E509B1ED4DE526"
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
To: Lauener Nathan <Nathan.Lauener@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA629BDDB60E509B1ED4DE526
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Lauener Nathan wrote:
> Hi,
> =20
> I solved the problem. I had to recompile the kernel with "local APCI on=

> uniprocessor" enabled.=20

This sounds more like you're shifting the issue, not really solving it.

> Now I have an other problem. As soon as I open a parallel port device m=
y
> system slows down dramatically, even without really using the opened
> driver. Any ideas are welcome.=20

How should we help without knowing your driver code? We need some common
ground to discuss any potential generic problem. Do the included
testcases work, e.g. timerbench or irqbench?

Jan


--------------enigA629BDDB60E509B1ED4DE526
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFw0NcniDOoMHTA+kRAr72AJ4sYTtQE/UGr0iBlfvhMZLcgrsZSQCfSC/V
sM8OVU55onp1QjLlJ1P+7jA=
=1y5Z
-----END PGP SIGNATURE-----

--------------enigA629BDDB60E509B1ED4DE526--

