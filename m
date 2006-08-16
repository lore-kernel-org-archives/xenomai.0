Message-ID: <44E36F6A.7060004@domain.hid>
Date: Wed, 16 Aug 2006 21:18:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problem with installation
References: <20060816190510.20935.qmail@domain.hid>
In-Reply-To: <20060816190510.20935.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5014D80ED9637AC32966D5C3"
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
To: Nicola Pezzotti <nicola17@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5014D80ED9637AC32966D5C3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Nicola Pezzotti wrote:
> Hi all.
>     I'm trying to install Xenomai on my pc.
> To do that I'm following this guide
> http://www.captain.at/xenomai-2.1-installation.php
> I'm using Kubuntu 6.6, linux-2.6.17 kernel and xenomai-2.2.0
> I have runned the script prepare-kernel.sh with the correct option as i=
n
> README.INSTALL
> Everything go well untill I reboot the system, then I have those errors=

>=20
>=20
> Uncompressing Linux... ok, booting the kernel
> MP-BIOS bug 8254 timer not connected to IO-APIC
> Xenomai: incompatible timer mode(aperiodic found, need aperiodic)
                                                         ^^^^^^^^^
I guess this this is a typo, isn't it? I would expect "periodic" here.

> Xenomai: VxWorks skin init failed code -16
> Kernel Panic - not syncing: VFS Unable to mount root fs on unknow
> -block(0,0)

The VxWorks skin requires periodic timer mode. If you don't plan to use
it, drop it from the kernel config . If you do want it, either set
CONFIG_XENO_OPT_TIMING_PERIOD to some reasonable value (see also the
related kernel-config help), or turn the nucleus into a module and pass
the period via the module parameter "tick_arg" when insmod'ing
xeno_nucleus later.

>=20
> Someone can give me an help? where I can found an official installation=

> guide
> (Sorry for my bad english)
> Thanks

README.INSTALL and TROUBLESHOOTING are the official guides. For the
rest: you are already on the right list. ;)

Jan


--------------enig5014D80ED9637AC32966D5C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE429uniDOoMHTA+kRAqFlAKCA5tMZlM8x5tx0DGUqReskUO/D3ACfSubt
LtWakMmGGJn/oPr07f8nz8c=
=opIx
-----END PGP SIGNATURE-----

--------------enig5014D80ED9637AC32966D5C3--

