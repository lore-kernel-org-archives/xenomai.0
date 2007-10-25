Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Oct 2007 18:43:37 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB266@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] Problems building Xenomai 2.4-rc4 and linux2.6.23
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert Gubler <rgubler@domain.hid>, xenomai@xenomai.org

Robert Gubler wrote:
[...]
>=A0=A0 AS=A0=A0=A0=A0=A0=A0arch/i386/boot/compressed/head.o
>=A0=A0 CC=A0=A0=A0=A0=A0=A0arch/i386/boot/compressed/misc.o=20
> In file included from include/linux/ipipe_base.h:29,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0from =
include/linux/kernel.h:17,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0from =
include/asm/system.h:4,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0from =
include/asm/processor.h:18,=20
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0from =
include/asm/thread_info.h:16,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0from =
include/linux/thread_info.h:21,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0from =
include/linux/preempt.h:9,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0from =
include/linux/spinlock.h:49,=20
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0from =
include/linux/vmalloc.h:4,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0from =
arch/i386/boot/compressed/misc.c:14:
> include/asm/ipipe_base.h:26:25: error: irq_vectors.h: No such file or
> directory
> make[2]: *** [arch/i386/boot/compressed/misc.o] Error 1
> make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2
> make: *** [bzImage] Error 2

I had the same issue with this setup(*). It went away when I switched=20
the subarch from CONFIG_X86_GENERICARCH (default with FC) to =
CONFIG_X86_PC.

setup:
linux-2.6.23.1.tar.bz2
xenomai-2.4-rc4.tar.bz2
adeos-ipipe-2.6.23-i386-1.10-10.patch

If you do need GENERICARCH, you can tweak =
arch/i386/boot/compressed/Makefile
and add -I${yourlinuxabsolutepath}/include/asm-i386/mach-default to =
CFLAGS.

BTW, I had also to patch include/asm-i386/mach-default/mach_time.h,
adding a missing #include <linux/bcd.h> for BCD macros.

--=20
Stephane

