Message-ID: <462E14CB.7070109@domain.hid>
Date: Tue, 24 Apr 2007 16:31:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <6fe1d5d0704240718t4d220b8dv4d6ddc3ae227f1c@domain.hid>
In-Reply-To: <6fe1d5d0704240718t4d220b8dv4d6ddc3ae227f1c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF95C01567CC7201A09D325D3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Driver port to xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sven Kjaergaard <sven.kjaergaard@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF95C01567CC7201A09D325D3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sven Kjaergaard wrote:
> Hi,
>=20
> I have to port a driver mainly written for VxWorks to Xenomai. In this
> way, I link it with the vxworks skin and it built successfully.
>=20
> But when inserting the module in the kernel (with debug nucleus set)
> the following  error occur meaning that the driver is in the linux
> domain and not in the priority one. What did I missed ? Did I have to
> convert some call to rthal_ ones for those where the corresponding
> function exists ? I don't think rtdm is mandatory for driver writting
> ?

RTDM is not mandatory, just recommended for future driver development.
Mainly because it increases portability (and re-usability) across skins
and motivates the definition of generic driver interfaces.

>=20
> TIA for any tips,
> Sven
>=20
> Xenomai: fatal: attempt to suspend root thread ROOT
>   CPU  PID    PRI      TIMEOUT  STAT      NAME
>   0    0       -1      0        00400080  ROOT
> Timer: periodic [tickval=3D1000000 ns, elapsed=3D10965]
>=20
> [<c00223f0>] (show_stack+0x0/0x54) from [<c0060d34>] (xnpod_suspend_thr=
ead
> +0x24c/0)[<c0060ae8>] (xnpod_suspend_thread+0x0/0x58c) from [<bf006418>=
]
> (taskDelay+0x7c/0x)[<bf00639c>] (taskDelay+0x0/0x120 [xeno_vxworks]) fr=
om
> [<bf011130>] (bus_init+) r6 =3D BF016304  r5 =3D C1CAF400  r4 =3D 00000=
3E8
> [<bf011090>] (bus_init+0x0/0x6a4 [rtconbus]) from [<bf01a0f8>]
> (rtconbus_init+) r7 =3D BF015B00  r6 =3D C28633FC  r5 =3D C1CAF400  r4 =
=3D BF015C80
> [<bf01a000>] (rtconbus_init+0x0/0x284 [rtconbus]) from [<c0051c6c>]
> (sys_init_modu) r4 =3D BF015B00 [<c0051b34>] (sys_init_module+0x0/0x15b=
8)
> from [<c001e3a4>] (ret_fast_syscall+0x0/)

Argh, your mailer makes reading this backtrace not very handy. Anyway,
you called taskDelay over the root thread, here in the context of
module_init of your driver. Either switch to true Linux suspension
services (usleep, msleep, etc.) for initialisation work or move that
work already into a (temporary?) VxWorks task.

[There is the chance that we will do such context wrapping on demand in
a future release, but that doesn't help right now.]

Jan


--------------enigF95C01567CC7201A09D325D3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLhTQniDOoMHTA+kRApNtAJsHygzNLSVAxatIF2fAe6bU3YHimQCfSrMd
Vy6bTdpct2z9mNBqVZojOiU=
=1UMr
-----END PGP SIGNATURE-----

--------------enigF95C01567CC7201A09D325D3--

