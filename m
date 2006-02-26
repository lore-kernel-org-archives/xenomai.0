Message-ID: <44020109.8060608@domain.hid>
Date: Sun, 26 Feb 2006 20:27:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Problems compiling r600 for PPC
References: <200602252125.17105.niklaus.giger@domain.hid>
In-Reply-To: <200602252125.17105.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5710090B518BFD0CB8BA8506"
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
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5710090B518BFD0CB8BA8506
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Hi everybody
>=20
> I had the following problem building the kernel:
> kernel/built-in.o: In function=20
> `rtdm_mmap_buffer':/mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/kernel/xeno=
mai/skins/rtdm/drvlib.c:1386:=20
> undefined reference to `virt_to_phys'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [_all] Error 2
>=20
> Adding a=20
> #include <asm/io.h>
> in kernel/xenomai/skins/rtdm/drvlib.c
> fixed my compile problem. Is this the correct solution for the other=20
> architectures also?
>=20

Looks reasonable. It's fixed now, thanks for reporting.

Jan


--------------enig5710090B518BFD0CB8BA8506
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEAgEJniDOoMHTA+kRAqa8AJ98upQP8sV3ByDFW5j7k8kEXXV59gCeOznF
F7ZQcxF1qyfmFaVcbs/WEtA=
=cUO+
-----END PGP SIGNATURE-----

--------------enig5710090B518BFD0CB8BA8506--

