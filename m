Message-ID: <46383422.50007@domain.hid>
Date: Wed, 02 May 2007 08:48:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <bJZU8yAy.1178088859.4958920.dchabal@domain.hid>
In-Reply-To: <bJZU8yAy.1178088859.4958920.dchabal@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig98F9A1811242A855E6581639"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai unstable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: CHABAL David <david.chabal@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig98F9A1811242A855E6581639
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

CHABAL David wrote:
> Hello everybody,
>=20
> I have a problem of stability with Xenomai.

Well, you are running the unstable version of Xenomai, what do you
expect? ;)

There are two patches pending for x86_64. One is here [1], I think the
other is not yet publicly available, there is only an i386 version [2].
The latter could bite you if CONFIG_PCI_MSI is on. Is it? Your .config
may help us.

>=20
> When I run the program xenomai/examples/rtdm/profiles/serial/cross-link=
,
> the first execution is correct, I quit with Ctrl-C, I launch again
> and... my PC is frozen.
>=20
> I have this behavior with my own dev and other binaries of the Xeno
> distrib.
> The PC either freeze or reboot.

If above doesn't help, you could try to catch the last words of your box
via serial console.

>=20
> My box is a HP dc7700 with a Pentium D (dual core) 3.4Ghz.
>=20
> I use the Mandriva free 2007.0 (64 bits) patched with:
> - adeos-ipipe-2.6.20-x86_64-1.0-06.patch
> and
> - a version of Xenomai checkouted from the trunk, revision 2381 (becaus=
e
> the 2.3.1 doesn't support the x86_64 arch in prepare-kernel.sh).
>=20
> I boot with the "noapic" option, otherwise the Linux kernel doesn't
> boot (dark screen, common problem with the dc7700). A Moxa PCI card wit=
h

common =3D=3D also with vanilla Linux?

> 8 serial ports is also installed.
>=20
> I've tried a lot of things with my .config:
> - compiling for generic x86_64
> - enable/disable HPET/MTRR/Nucleus Debug support
> - fire the SMP support but the box doesn't boot anymore

I.e. !CONFIG_SMP doesn't boot at all when CONFIG_IPIPE is enabled? Same
here: try the patch and !CONFIG_PCI_MSI, then catch the console output.

Thanks for reporting!
Jan

[1] https://mail.gna.org/public/adeos-main/2007-04/msg00075.html
[2] https://mail.gna.org/public/xenomai-help/2007-04/msg00213.html


--------------enig98F9A1811242A855E6581639
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGODQiniDOoMHTA+kRAtr4AJ9rwN+9dj4PQFR6EhSb5McsGR0wPgCfcF2w
qhbT9nIc/3B3o4YSUNAKzOc=
=is+F
-----END PGP SIGNATURE-----

--------------enig98F9A1811242A855E6581639--

