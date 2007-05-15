Message-ID: <464988B2.80407@domain.hid>
Date: Tue, 15 May 2007 12:17:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <002701c79675$ac700130$c67ba8c0@domain.hid>
In-Reply-To: <002701c79675$ac700130$c67ba8c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCFFB2CDBBDC24C9EBFF13A18"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Booting fails: Kernel panic
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonas Witt <Jonas@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCFFB2CDBBDC24C9EBFF13A18
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jonas Witt wrote:
> Hello everyone,
>=20
> =20
>=20
> i thought that it would be better if i started a new thread for this:
>=20
> =20
>=20
> I have some trouble with getting xenomai to run on a PC/104 device with=
 AMD
> Geode GX processor (Debian 4.0 is installed). My development platform w=
hich
> is running a Athlon64 (with Kubuntu 6.06) is already doing fine. For te=
sting
> purposes i tried using the same kernel-bulid (2.6.20.11 kernel with 2.3=
=2E1
> xenomai) for both by selecting a 486-processor in the menuconfig. It wo=
rks
> on my Athlon64 but on the PC/104 after copying the files i cannot boot.=
 On
> the first boot it said directly that xenomai failed to load (and all th=
e
> RT-interfaces after that).. all with errorcode -19. I am not able to
> reproduce that output, though. After that i turned off APIC to see if i=
t
> changes something and then i got further in the boot process but now
> stopping with:
>=20
> =20
>=20
> /bin/dash: error while loading shared libraries: libc.so.6: cannot open=

> shared object file: No such file or directory
>=20

Do you happen to use i686 libs on your Geode, instead of i586? Check
what your distro installed.

> =20
>=20
> Now it does not seem to change anything whether the ,noapic' parameter =
is
> passed to the kernel or not, though. This is all kind of strange, becau=
se i
> already had xenomai running successfully on that platform, but i am not=
 able
> to get it running again.. (in other kernel building attempts the system=

> booted but xenomai was not loaded (in /proc was no xenomai folder) and =
yes..
> i did boot the right kernel).=20
>=20
> =20
>=20
> The PC/104 has a 500Mhz AMD Geode GX processor and 512MB Ram. It uses a=
 1GB
> Flashdisk that is plugged in via the IDE port (shows up as hda). To bui=
ld
> the xenomai-kernel i modified the config from the running Debian 4.0 sy=
stem.
>=20
> =20
>=20
> Could a problem stem from the fact that i copied the files to that mach=
ine
> and did not build them on the same machine?
>=20
> =20
>=20
> I really hope someone can help me with this..=20
>=20
> Thanks in advance!
>=20
> =20
>=20
> Jonas
>=20
>=20

Jan


--------------enigCFFB2CDBBDC24C9EBFF13A18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGSYiyniDOoMHTA+kRAtDuAJ9iPKtIF1/swAM8B4Iccb1x0ngi+wCeLkv1
kCYU2p5Wcr6oNPehlXOKpqI=
=scYh
-----END PGP SIGNATURE-----

--------------enigCFFB2CDBBDC24C9EBFF13A18--

