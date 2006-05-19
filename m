Date: Fri, 19 May 2006 16:19:19 -0400 (EDT)
Message-Id: <200605192019.k4JKJJFN007810@domain.hid>
From: Gary Wallace <wallace@domain.hid>
Subject: Re: [Xenomai-help] Almost running - kernel BUG in add_preempt_count
	at	kernel/sched.c:2819!
References: <B4D14EA407C38B4DAF92B8EAC9249D7F02D0F285@domain.hid>
	<446E2107.8060504@domain.hid>
Reply-To: wallace@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid, xenomai@xenomai.org
Cc: Jim.Rosenow@domain.hid

  My story is the same as Jim's except I used 2.6.16.6 and a gcc 3.3.3
cross compiler.  The ipipe patch applies just fine after the motorola
patch.  Building with ipipe disabled results in a kernel that boots
and runs just fine.  When ipipe is enabled, I sometimes get the error
Jim received, sometimes the kernel just hangs.  There is never a stack
trace on the console.  I've tried ipipe versions 1.2-01, 1.2-03,
1.3-00, 1.3-02, and 1.3-03, all with the same results (either the
kernel hangs or I get the kernel BUG error).

  I haven't been able to get the board to boot without using the
motorola patch.

  I have tried building with ipipe-tracer, but this results in compile
errors (the tracer patch applies just fine).  Here are the compile
errors when ipipe-tracer is enabled:

# make
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  UIMAGE  arch/ppc/boot/images/uImage
"mkimage" command not found - U-Boot images will not be built
  Image: arch/ppc/boot/images/uImage not made
  AS      arch/ppc/boot/simple/head.o
  AS      arch/ppc/boot/simple/relocate.o
  CC      arch/ppc/boot/simple/misc.o
  CC      arch/ppc/boot/simple/misc-mv64x60.o
powerpc-750-linux-gnu-objcopy -O elf32-powerpc \
        --add-section=.image=arch/ppc/boot/images/vmlinux.gz \
        --set-section-flags=.image=contents,alloc,load,readonly,data \
        arch/ppc/boot/simple/dummy.o arch/ppc/boot/simple/image.o
powerpc-750-linux-gnu-ld -T /usr/src/linux-2.6.14.6-ppc/arch/ppc/boot/ld.script -Ttext 0x00800000 -Bstatic -o arch/ppc/boot/simple/zvmlinux arch/ppc/boot/simple/head.o arch/ppc/boot/simple/relocate.o arch/ppc/boot/simple/misc.o arch/ppc/boot/simple/misc-mv64x60.o arch/ppc/boot/simple/image.o arch/ppc/boot/common/lib.a arch/ppc/boot/lib/lib.a
arch/ppc/boot/simple/misc.o(.text+0x10): In function `get_mem_size':
arch/ppc/boot/simple/misc.c:87: undefined reference to `_mcount'
arch/ppc/boot/simple/misc.o(.text+0x54): In function `decompress_kernel':
arch/ppc/boot/simple/misc.c:93: undefined reference to `_mcount'
arch/ppc/boot/simple/misc.o(.text+0x4b8): In function `board_isa_init':
arch/ppc/boot/simple/misc.c:274: undefined reference to `_mcount'
arch/ppc/boot/simple/misc.o(.text+0x4f8): In function `load_kernel':
arch/ppc/boot/simple/misc.c:281: undefined reference to `_mcount'
arch/ppc/boot/simple/misc-mv64x60.o(.text+0x10): In function `mv64360_get_mem_size':
arch/ppc/boot/simple/misc-mv64x60.c:31: undefined reference to `_mcount'
arch/ppc/boot/simple/misc-mv64x60.o(.text+0xbc):arch/ppc/boot/simple/misc-mv64x60.c:51: more undefined references to `_mcount' follow
make[2]: *** [arch/ppc/boot/simple/zvmlinux] Error 1
make[1]: *** [simple] Error 2
make: *** [zImage] Error 2
# 

  Thanks for your help.

Gary

--------------------------------

>Date: Fri, 19 May 2006 21:48:23 +0200
>From: Jan Kiszka <jan.kiszka@domain.hid>
>
>Rosenow, Jim wrote:
>> Sorry for the missing history.
>>=20
>> I started with a vanilla 2.6.14-7 kernel from kernel.org, I patched it
>> with a Motorola patch to enable the features specific to the mvme5500.
>> I built under ELDK 4.0 and the kernel ran just fine.
>>=20
>> Next I retrieved xenomai-2.1.1 and followed the install instructions.
>> The adeos version adeos-ipipe-2.6.14-1.2.03.patch.  This patch applied
>> and I rebuilt the kernel.  I ran into a problem with xmon not compiling=
>
>> so I removed that switch from the kernel hacking menu and it built fine=
>=2E
>>=20
>> That brings us to now.
>>=20
>> In reference to your recommendation, can I simply disable ipipe and
>> leave xenomai enabled and expect the kernel to run?  I thought there wa=
>s
>> a pretty close coupling between the two.
>
>No, you are right, this is not possible. I meant booting with both ipipe
>and xenomai disabled.
>
>Is your board able to boot without the Motorola patches? If yes, does
>the problem persist? BTW, did the ipipe patch apply cleanly on top of
>the Motorola patch or did you have to fix some hunks?
>
>
>@all: What will help to track this down are back-traces of the crash.
>Does the console contain a stack trace as well? If not, try using the
>ipipe-tracer (additional patch [1]) and put an
>ipipe_trace_panic_freeze() + ipipe_trace_panic_dump() before that BUG()
>(with the same condition, of course). Actually, this tool can report
>more than a stack trace. It records a full function call history and may
>reveal where the ipipe patch left the correct path.
>
>Jan
>
>
>PS: Just in case you thought about this, switching the ipipe patch to
>1.3 may only hide the problem. The newer patches contain optimisations,
>not bug fixes of the 1.2 series.
>
>
>[1] http://download.gna.org/adeos/patches/v2.6/ppc/tracer
>
>
>--------------enig3E9EB408FAB645DA563A41F7
>Content-Type: application/pgp-signature; name="signature.asc"
>Content-Description: OpenPGP digital signature
>Content-Disposition: attachment; filename="signature.asc"
>
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.4.2 (GNU/Linux)
>Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
>iD8DBQFEbiEHniDOoMHTA+kRAsQcAJ9XRpE7p4B9NnJGhXt3pYuR0GIy7gCfaVTM
>p53WAlSlQn1qptZIMkKmGO4=
>=YWny
>-----END PGP SIGNATURE-----
>
>--------------enig3E9EB408FAB645DA563A41F7--
>

