Message-ID: <465D3053.2040002@domain.hid>
Date: Wed, 30 May 2007 10:05:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <465D2BE1.1080302@domain.hid>
In-Reply-To: <465D2BE1.1080302@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig81E2A8BAA8FB648B45772CAE"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [Newbie question]Segmentation fault with
 user-space binary
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodolfo Bamberg <rolfetas@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig81E2A8BAA8FB648B45772CAE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodolfo Bamberg wrote:
> Hi
> I get a segmentation fault when I run my user-space RT app (native skin=
).
> I did the following steps:
> - Cross-Compiled the Kernel with Xenomai support for an i386 target.
> - I Cross - Compiled Xenomai with uClibc: run ./configure using the
> --host=3Di386-linux-uclibc option, and using the new configure.in I rea=
d
> about in the uClibC discussion.
> - I wrote a test program that includes <native/task.h> and
> <native/timer.h>.
> - I then got this segmentation faults and I reduced my program to not
> using xenomai and only printing something. I igured out that the
> "-lnative" lib directive in the makefile was causing the problem.

Looks like the init code of libnative that is executed automatically on
program start is involved here.

> Do you know what might be the problem??

Could you attach gdb to your program and check where it segfaults
precisely? Also, does the same crash happens with "latency", the Xenomai
benchmark tool based on Native services?

> Thanks!
>=20
> Rodolfo Bamberg
>=20
> Here's my makefile:
>=20
>     obj-m            :=3D hallo.o    rt_process.o
>     RTAI_INCLUDE_DIR

That looks like legacy. ;)

> :=3D/home/rodolfo/kernel/linux-2.6.20-xenomai/include/xenomai
>     XENOMAI_INCLUDE_DIR_USP
> :=3D/home/rodolfo/xenomai/xenomai-2.3.1/src/include
>     XENOMAI_INCLUDE_DIR_USP2:=3D/home/rodolfo/xenomai/xenomai-2.3.1/inc=
lude
>     XENOMAI_INCLUDE_LIB_USP :=3D/tftpboot/192.168.0.2/usr/xenomai/lib
>=20
>=20
> default:
>=20
>     i386-linux-uclibc-gcc -I$(XENOMAI_INCLUDE_DIR_USP)
> -I$(XENOMAI_INCLUDE_DIR_USP2) -lnative -L$(XENOMAI_INCLUDE_LIB_USP) -o
> rt_process_user rt_process_user.c
>     chmod a+x rt_process_user
>=20
> clean:
>     rm -f *.mod.c *.o *.ko rt_process
>=20
>=20

Jan


--------------enig81E2A8BAA8FB648B45772CAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGXTBTniDOoMHTA+kRApAwAJ0folLV8MRiEgov8pxz/8KOLS9YlACfWM9d
vxv3RHkwuQFrJJlXsg3MpFM=
=00YQ
-----END PGP SIGNATURE-----

--------------enig81E2A8BAA8FB648B45772CAE--

