Message-ID: <4437782C.9030203@domain.hid>
Date: Sat, 08 Apr 2006 10:45:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] bad/slow TSC hw  detected by  2.6.17-rc1-mm1
References: <4436C5DF.6060005@domain.hid>
In-Reply-To: <4436C5DF.6060005@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7F3950146C01F82E32BFD785"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7F3950146C01F82E32BFD785
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jim Cromie wrote:
> FYI,
>=20
> Ive just built 17-rc1-mm1, and noted that the new time-keeping-system
> http://lwn.net/Articles/176837/
>=20
> can now detect the buggy TSC on my GEODE-sc1100 cpu,
> and also that its apparently fixable by adding 'idle=3Dpoll' to
> kernel-boot-line.

Keeps your CPU safe and warm, I guess. ;)

>=20
> Apr  7 11:42:01 truck kernel: [   19.160016] Kernel command line:
> console=3DttyS0,115200n81 root=3D/dev/nfs
> nfsroot=3D192.168.42.1:/nfshost/truck
> nfsaddrs=3D192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekr=
is:eth0
> panic=3D5 initrd=3Dinitrd-2.6.17-rc1-mm1-sk.img=20
> BOOT_IMAGE=3Dvmlinuz-2.6.17-rc1-mm1-sk
> Apr  7 11:42:01 truck kernel: [   24.314851] Time: tsc clocksource has
> been installed.
> Apr  7 11:42:01 truck kernel: [   29.977802] TSC appears to be running
> slowly. Marking it as unstable
> Apr  7 11:42:01 truck kernel: [   20.460000] Time: pit clocksource has
> been installed.
>=20
> Apr  7 12:35:56 truck kernel: [   21.562573] Kernel command line:
> console=3DttyS0,115200n81 root=3D/dev/nfs
> nfsroot=3D192.168.42.1:/nfshost/truck
> nfsaddrs=3D192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekr=
is:eth0
> panic=3D5 initrd=3Dinitrd-2.6.17-rc1-mm1-sk.img idle=3Dpoll
> BOOT_IMAGE=3Dvmlinuz-2.6.17-rc1-mm1-sk
> Apr  7 12:35:56 truck kernel: [   21.563049] using polling idle threads=
=2E
> Apr  7 12:35:56 truck kernel: [   28.393469] Time: tsc clocksource has
> been installed.
>=20
>=20
> hope this is useful,
> jimc
>=20

Jan


--------------enig7F3950146C01F82E32BFD785
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEN3gsniDOoMHTA+kRAqNlAJ9k4IwbGzwrdVuVX2IdfJ6qniUtMgCfVCA2
Iq+3B/Gpla2p+KiFthyM0jg=
=+tQf
-----END PGP SIGNATURE-----

--------------enig7F3950146C01F82E32BFD785--

