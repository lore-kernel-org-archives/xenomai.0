Message-ID: <45C4A580.3000904@domain.hid>
Date: Sat, 03 Feb 2007 16:08:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rtdm over x86_64
References: <200702031313.20104.paul_c@domain.hid>
In-Reply-To: <200702031313.20104.paul_c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8AB445550F90B14CB348E1FC"
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
To: Paul <paul_c@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8AB445550F90B14CB348E1FC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Paul wrote:
> Hi Jan
>=20
>  Just a small patch to get the ball rolling with an x86_64 support..
>=20
> The attached resolves a compile time warning of:=20
>=20
> kernel/xenomai/skins/rtdm/core.c: In function =E2=80=98_rtdm_ioctl=E2=80=
=99:
> kernel/xenomai/skins/rtdm/core.c:408: warning: comparison is always fal=
se due=20
> to limited range of data type
>=20

Yeah, when looking at this issue with 64-bit glasses, this urgently
needs fixing (I wonder why ia64 didn't stumble yet?).

Your patch points in the right direction, but it needs a bit fine-tuning
and also has to include the ioctl handlers of drivers. I will work out a
fix and inform you. I'll have to rely on your test lab. :)

But first I need some build environment. A quick shot ended here when
trying to configure a patch and prepared 2.6.19 kernel:

# make ARCH=3Dx86_64 CC=3D"gcc -m64" oldconfig
=2E..
init/Kconfig:572: can't open file "arch/x86_64/xenomai/Kconfig"

Anyone any idea? Is something missing, or is the prepare script broken?

Jan


PS: Once we have in-tree RTDM services and drivers running, are you
interested in a RTnet excursion over x64? I should be able to make this
compile, but for testing...


--------------enig8AB445550F90B14CB348E1FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFxKWBniDOoMHTA+kRAnoFAJ4nixrXVPHPbNpADJvLrW20UJ354gCdGBxQ
zPmTEWf5qPJUQZu1ckW2o9A=
=y1c7
-----END PGP SIGNATURE-----

--------------enig8AB445550F90B14CB348E1FC--

