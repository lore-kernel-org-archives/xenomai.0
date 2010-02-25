Message-ID: <4B86C214.3020407@domain.hid>
Date: Thu, 25 Feb 2010 19:31:48 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B6E8167.6010907@domain.hid>	<4B76B7F2.2050303@domain.hid>	<4B76C045.2070602@domain.hid>	<1266140329.27019.17.camel@domain.hid>	<4B867EB5.9090504@domain.hid>
	<4B867FF9.2020709@domain.hid> <4B868228.10206@domain.hid>
	<4B868CC1.6030103@domain.hid>
In-Reply-To: <4B868CC1.6030103@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig55287CC6090C137CB4E53163"
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jeff Weber <jweber@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig55287CC6090C137CB4E53163
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

Am 25.02.2010 15:44, schrieb Jeff Weber:
> Hello Stefan:
>=20
> I've been watching with interest the recent active work integrating
> Debian and Xenomai.  I am currently porting an embedded application to
> Xenomai, and am surveying candidate Linux distributions.
>=20
> I did a test build, install of Xenomai on a Debian Lenny distributionI
> per the HOWTO:
> http://xenomai.org/index.php/Xenomai_quick_build_quide
>=20
> and updated my grub menu.lst with the new kernel, and all worked well.
> I did spend a significant amount of time tuning my kernel config file t=
o
> my target board.
>=20
> Can you help me understand the advantages of using the Debian packages,=

> over the process I followed above?  I am still unclear on the advantage=
s
> of using the Debian Xenomia packages.

Advantages:
- Installing software is easy, maintaining a system is harder. Using debi=
an
  packages helps you upgrading/removing xenomai on a system.
- If you need xenomai on more than one machine, you build once and instal=
l
  the same deb's on all machines.
- You are testing different distributions now. If you install distributio=
n xyz
  on your system and want later to switch back to lenny, you just have to=

  keep the deb's and you are fine. Nothing to compile.
- You don't need any xenomai knowhow to install a deb. If, for example, y=
our
  co-worker needs to be able to setup xenomai too and he has the deb's a
  simple "dpkg -i *.deb" on a lenny system will do it and it will work,
  and you can enjoy your holidays ;-)

> Which kernels can I use?
>=20
> Do I still need to tune a kernel config file?

You still need to tune the config and build a kernel, there is no binary
kernel-image with xenomai support. However, if you use make-kpkg to build=

the kernel it will build a *.deb. If you install this deb you dont
have to fiddle with grub menu.lst, the kernel is automatically added.

Please always CC the mailing list. Thank you.

Regards
Stefan

> If not, how is the kernel pre-configured?
>=20
> thanks,
> Jeff



--------------enig55287CC6090C137CB4E53163
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLhsIZIPTw9rIdn6oRAhFVAJ9BgZ6QEkqTatuQ2ypHFW09bP3begCeKUzR
WfG2EdYxlHSYCW0ZZvKusS8=
=vl/W
-----END PGP SIGNATURE-----

--------------enig55287CC6090C137CB4E53163--

