Message-ID: <451B0978.5020108@domain.hid>
Date: Thu, 28 Sep 2006 01:30:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Problems booting after Adeos patch
References: <451AEEED.1050708@domain.hid>
In-Reply-To: <451AEEED.1050708@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0B2816F6E59B8F4815E92B64"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: "J.D. Yamokoski" <yamokosk@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0B2816F6E59B8F4815E92B64
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

J.D. Yamokoski wrote:
> Greetings,
>=20
> I have recently run into some trouble trying to boot a custom configed
> linux kernel with Adeos. During boot the system seems to have problems
> with the SATA hard drives with messages like,
>=20
> ata1: slow completion (cmd ef)
> ATA: abnormal status 0x0FF
> ata1: command 0x25 timeout, stat 0x50 host-stat 0x24
>=20
> And then finally towards the end of the boot sequence, I get "ALERT!
> /dev/sda3 does not exist. Dropping to a shell!"
>=20
> I am using a highly modified config customized for this machine
> (Highlights of the config: It excludes a lot of drivers, SMP build, and=

> both SATA-as-SCSI-driver and the regular PCI IDE driver are enabled.)
> Unpatched this customized kernel works fine. And as expected, if I use =
a
> more general config file (one that came with my distro) the Adeos
> patched kernel boots normally. Its just the combination of Adeos and
> customized config that seems to be the problem. Does anything jump out
> at anyone? I have include my config file with this email.
>=20

What I-pipe patch version are you using?

Could you try with CONFIG_PCI_MSI disabled? There has been other reports
on MSI issues recently, maybe yours belong to the same group.

Thanks,
Jan


PS: Unrelated to the problem but maybe still interesting: If you plan to
use Adeos/I-pipe as a real-time enabler (e.g. with Xenomai), you should
switch off CONFIG_ACPI_PROCESSOR, CONFIG_CPU_FREQ, and CONFIG_APM.
Recent Xenomai versions should warn you about this fact as well.


--------------enig0B2816F6E59B8F4815E92B64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFGwl/niDOoMHTA+kRAnJcAJ0VUDjz+WSGtSTe6zisaRjjKQyZ+QCdHEH/
xTRS4c26EhTflc3qCIhyO3k=
=zHuJ
-----END PGP SIGNATURE-----

--------------enig0B2816F6E59B8F4815E92B64--

