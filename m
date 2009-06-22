Message-ID: <4A3F7228.3080201@domain.hid>
Date: Mon, 22 Jun 2009 13:59:36 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <1245669529.7250.3.camel@domain.hid>
In-Reply-To: <1245669529.7250.3.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA320C00A60AFFCDB993DE79A"
Subject: Re: [Xenomai-core] Problem running klatency test
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Shashank Bhatia <shashank.bhatia@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA320C00A60AFFCDB993DE79A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Shashank Bhatia schrieb:
> Dear All,
>=20
>           I could manage to compile my patched kernel on ubuntu using
> the following guide : https://wiki.ubuntu.com/KernelTeam/GitKernelBuild=

>=20
> Now when i installed Xenomai, i could run the latency tests, but when i=

> tried to run the kernel space latency test, i found the following error=
=2E
>=20
>=20
> root@domain.hid# ./run=20
> *
> *
> * Type ^C to stop this application.
> *
> *
> open(/proc/xenomai/registry/native/pipes/klat_pipe): No such file or
> directory
> modprobe klat_mod or try the -P option?

1) go to your xeno-patched kernel tree
2) make menuconfig
3) navigate to Real-time sub-system ---> Drivers ---> Testing Drivers
4) enable 'Timer benchmark driver'
5) a new options pops up: 'Kernel-only latency measurement module'
6) enable this option
7) rebuild kernel & install kernel & reboot
8) try again, if you enabled it as a module (M) and not built-in (*)
   use modprobe to load to module

kisda

> The dmesg | grep Xenomai gave the following output:
> [    4.353912] I-pipe: Domain Xenomai registered.
> [    4.353949] Xenomai: hal/i386 started.
> [    4.354530] Xenomai: real-time nucleus v2.4.8 (Lords Of Karma)
> loaded.
> [    4.354612] Xenomai: SMI-enabled chipset found
> [    4.354623] Xenomai: SMI workaround enabled
> [    4.354647] Xenomai: starting native API services.
> [    4.354650] Xenomai: starting POSIX services.
> [    4.354693] Xenomai: starting RTDM services.
>=20
>=20
>=20
> Thanks in advance
>=20
>=20
> -------------------------------------
> Hi-Tech Gears Limited, Gurgaon, India
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>=20



--------------enigA320C00A60AFFCDB993DE79A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKP3IuIPTw9rIdn6oRAqSIAJ4437SODf5SkZZRuNfQ1KPatd/btwCdEv+u
EnEkYiYt0m9cGyf3wQjj6zA=
=IX1B
-----END PGP SIGNATURE-----

--------------enigA320C00A60AFFCDB993DE79A--

