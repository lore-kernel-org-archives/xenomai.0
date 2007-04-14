Message-ID: <462078B1.40503@domain.hid>
Date: Sat, 14 Apr 2007 08:46:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <OFE36E288D.87F8020A-ONC12572BD.001EE37D-C12572BD.001F648E@br-automation.com>
In-Reply-To: <OFE36E288D.87F8020A-ONC12572BD.001EE37D-C12572BD.001F648E@br-automation.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig51D4F3D5E5417825958CC203"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Debug kernel module tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Erler <Andreas.Erler@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig51D4F3D5E5417825958CC203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andreas Erler wrote:
> Hello all,
>=20
> I have got a problem in my pci driver module which is freezing my syste=
m=20
> completely.
> I don't even have a chance to see the last messages written with printk=
=2E..
> So my question: is there any way to debug kernel module tasks like in=20
> RTLinux by connecting gdb over rtfifos?

For 2.6.16 and .17, I adapted kgdb to work with ipipe [1]. That means
you were able to attach gdb to your system via a serial nullmodem link.

Unfortunately, the kgbd development itself became unsteady again (it
stalled for more than half a year), so we have no recent vanilla kgdb
patches ATM. May change again in the future, but doesn't help right now.


What you can try meanwhile is to direct your console output to a serial
console and use ipipe_set_printk_sync(&rthal_root) to force synchronous
printk even for the Xenomai domain. Moreover, switch on debug support in
Xenomai, specifically CONFIG_XENO_OPT_DEBUG_RTDM and
CONFIG_XENO_OPT_WATCHDOG.

Jan

[1] http://download.gna.org/adeos/patches/v2.6/i386/kgdb/


--------------enig51D4F3D5E5417825958CC203
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGIHiyniDOoMHTA+kRAtZ3AJ90yqYHKoL6/5F/ymMLhRQbTC1tCgCfacsG
rOT/yiLSGUvlr1GNuv2uYVY=
=1kY4
-----END PGP SIGNATURE-----

--------------enig51D4F3D5E5417825958CC203--

