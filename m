Message-ID: <446F5803.8030607@domain.hid>
Date: Sat, 20 May 2006 19:55:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Almost running - kernel BUG in add_preempt_count
	at	kernel/sched.c:2819!
References: <B4D14EA407C38B4DAF92B8EAC9249D7F02D0F285@domain.hid>
	<446E2107.8060504@domain.hid>
	<200605192019.k4JKJJFN007810@domain.hid>
In-Reply-To: <200605192019.k4JKJJFN007810@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig68595AC7403A26BF2CDBB8C3"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, wallace@domain.hid
Cc: xenomai@xenomai.org, Jim.Rosenow@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig68595AC7403A26BF2CDBB8C3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gary Wallace wrote:
>   My story is the same as Jim's except I used 2.6.16.6 and a gcc 3.3.3
> cross compiler.  The ipipe patch applies just fine after the motorola
> patch.  Building with ipipe disabled results in a kernel that boots
> and runs just fine.  When ipipe is enabled, I sometimes get the error
> Jim received, sometimes the kernel just hangs.  There is never a stack
> trace on the console.  I've tried ipipe versions 1.2-01, 1.2-03,
> 1.3-00, 1.3-02, and 1.3-03, all with the same results (either the
> kernel hangs or I get the kernel BUG error).
>=20
>   I haven't been able to get the board to boot without using the
> motorola patch.
>=20
>   I have tried building with ipipe-tracer, but this results in compile
> errors (the tracer patch applies just fine).  Here are the compile
> errors when ipipe-tracer is enabled:
>=20
> # make
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   UIMAGE  arch/ppc/boot/images/uImage
> "mkimage" command not found - U-Boot images will not be built
>   Image: arch/ppc/boot/images/uImage not made
>   AS      arch/ppc/boot/simple/head.o
>   AS      arch/ppc/boot/simple/relocate.o
>   CC      arch/ppc/boot/simple/misc.o
>   CC      arch/ppc/boot/simple/misc-mv64x60.o
> powerpc-750-linux-gnu-objcopy -O elf32-powerpc \
>         --add-section=3D.image=3Darch/ppc/boot/images/vmlinux.gz \
>         --set-section-flags=3D.image=3Dcontents,alloc,load,readonly,dat=
a \
>         arch/ppc/boot/simple/dummy.o arch/ppc/boot/simple/image.o
> powerpc-750-linux-gnu-ld -T /usr/src/linux-2.6.14.6-ppc/arch/ppc/boot/l=
d.script -Ttext 0x00800000 -Bstatic -o arch/ppc/boot/simple/zvmlinux arch=
/ppc/boot/simple/head.o arch/ppc/boot/simple/relocate.o arch/ppc/boot/sim=
ple/misc.o arch/ppc/boot/simple/misc-mv64x60.o arch/ppc/boot/simple/image=
=2Eo arch/ppc/boot/common/lib.a arch/ppc/boot/lib/lib.a
> arch/ppc/boot/simple/misc.o(.text+0x10): In function `get_mem_size':
> arch/ppc/boot/simple/misc.c:87: undefined reference to `_mcount'
> arch/ppc/boot/simple/misc.o(.text+0x54): In function `decompress_kernel=
':
> arch/ppc/boot/simple/misc.c:93: undefined reference to `_mcount'
> arch/ppc/boot/simple/misc.o(.text+0x4b8): In function `board_isa_init':=

> arch/ppc/boot/simple/misc.c:274: undefined reference to `_mcount'
> arch/ppc/boot/simple/misc.o(.text+0x4f8): In function `load_kernel':
> arch/ppc/boot/simple/misc.c:281: undefined reference to `_mcount'
> arch/ppc/boot/simple/misc-mv64x60.o(.text+0x10): In function `mv64360_g=
et_mem_size':
> arch/ppc/boot/simple/misc-mv64x60.c:31: undefined reference to `_mcount=
'
> arch/ppc/boot/simple/misc-mv64x60.o(.text+0xbc):arch/ppc/boot/simple/mi=
sc-mv64x60.c:51: more undefined references to `_mcount' follow
> make[2]: *** [arch/ppc/boot/simple/zvmlinux] Error 1
> make[1]: *** [simple] Error 2
> make: *** [zImage] Error 2
> #=20
>=20

Philippe, can you comment on this? I do not have an PPC build
environment at hand.

@Gary: Do you get the same error without the Motorola patch?

Jan


--------------enig68595AC7403A26BF2CDBB8C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEb1gDniDOoMHTA+kRAraTAJ9mo2/LOEzYhaNCtloffaeV9vgdygCfSv5Q
odCfyQJNAi1kysgs/4JyEgM=
=+FYJ
-----END PGP SIGNATURE-----

--------------enig68595AC7403A26BF2CDBB8C3--

