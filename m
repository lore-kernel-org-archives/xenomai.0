From: "=?iso-8859-1?Q?Hans_S=F8ndergaard_(HSO)?=" <HSO@VIAUC.DK>
Date: Sat, 3 May 2008 10:21:14 +0200
Message-ID: <2220D86D21B55040AB683933DBD97B5A263A38ECAA@FND-MAILB03.VIA.DK>
References: <2220D86D21B55040AB683933DBD97B5A263A38E8E0@domain.hid>
	<2ff1a98a0804290518x59f92346mfdf32c84055a10fe@domain.hid>
	<2220D86D21B55040AB683933DBD97B5A263A38EC01@domain.hid>
	<18457.59929.12465.572294@domain.hid>
	<4819F7A6.1010809@domain.hid>
In-Reply-To: <4819F7A6.1010809@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai on AT91SAM9260
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "rpm@xenomai.org" <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

The patch worked, and we are now able to compile the userspace libraries as=
 well as the kernel.

Thank you very much!

Hans S=F8

-----Original Message-----
From: Philippe Gerum [mailto:philippe.gerum@domain.hid] On Behalf Of Philipp=
e Gerum
Sent: 1. maj 2008 19:03
To: Gilles Chanteperdrix
Cc: Hans S=F8ndergaard (HSO); xenomai@xenomai.org
Subject: Re: [Xenomai-help] Xenomai on AT91SAM9260

Gilles Chanteperdrix wrote:
> Hans S=F8ndergaard (HSO) wrote:
>  > Hi,
>  >
>  > Thanks for the answer.
>  > We are now trying to install Xenomai 2.4.3 using Linux 2.6.24 on AT91S=
AM9260,
>  > but have a problem:
>  >
>  > Is it possible to disable the building of the posix skin when
>  > configuring the user space libraries for Xenomai?
>  >
>  > I have tried --disable-posix-skin, but this had no effect.
>  >
>  > The reason why I ask is that the building of src/skins/posix/init.c
>  > fails like this:
>  >
>  > [stk@domain.hid posix]$ arm-linux-uclibc-gcc -DHAVE_CONFIG_H -I. -I../../=
../src/inc
>  > lude -I../../../../xenomai-2.4.3/src/skins/posix -O2 -D_GNU_SOURCE -D_=
REENTRANT
>  > -Wall -pipe -march=3Darmv5 -D__XENO__ -D__IN_XENO__ -Wstrict-prototype=
s -I../../..
>  > /../xenomai-2.4.3/include -I../../../../xenomai-2.4.3/include/posix -M=
T libpthre
>  > ad_rt_la-init.lo -MD -MP -MF .deps/libpthread_rt_la-init.Tpo -c ../../=
../../xeno
>  > mai-2.4.3/src/skins/posix/init.c  -fPIC -DPIC -o .libs/libpthread_rt_l=
a-init.o
>  > In file included from ../../../src/include/asm/xenomai/atomic.h:78,
>  >                  from ../../../../xenomai-2.4.3/include/nucleus/system=
.h:27,
>  >                  from ../../../src/include/asm/xenomai/system.h:135,
>  >                  from ../../../../xenomai-2.4.3/include/nucleus/types.=
h:40,
>  >                  from ../../../../xenomai-2.4.3/include/nucleus/queue.=
h:25,
>  >                  from ../../../../xenomai-2.4.3/include/nucleus/timeba=
se.h:30,
>  >                  from ../../../../xenomai-2.4.3/include/nucleus/timer.=
h:27,
>  >                  from ../../../../xenomai-2.4.3/include/nucleus/thread=
.h:26,
>  >                  from ../../../../xenomai-2.4.3/include/posix/pthread.=
h:150,
>  >                  from /home/stk/brick/mb9200/buildroot/build_arm/stagi=
ng_dir/bin
>  > -ccache/../lib/gcc/arm-linux-uclibc/4.1.1/../../../../arm-linux-uclibc=
/sys-inclu
>  > de/bits/uClibc_mutex.h:16,
>  >                  from /home/stk/brick/mb9200/buildroot/build_arm/stagi=
ng_dir/bin
>  > -ccache/../lib/gcc/arm-linux-uclibc/4.1.1/../../../../arm-linux-uclibc=
/sys-inclu
>  > de/bits/uClibc_stdio.h:120,
>  >                  from /home/stk/brick/mb9200/buildroot/build_arm/stagi=
ng_dir/bin
>  > -ccache/../lib/gcc/arm-linux-uclibc/4.1.1/../../../../arm-linux-uclibc=
/sys-inclu
>  > de/stdio.h:73,
>  >                  from ../../../../xenomai-2.4.3/src/skins/posix/init.c=
:20:
>  > ../../../src/include/asm/xenomai/syscall.h: In function 'xeno_arm_feat=
ures_check
>  > ':
>  > ../../../src/include/asm/xenomai/syscall.h:295: error: 'stderr' undecl=
ared (firs
>  > t use in this function)
>  > ../../../src/include/asm/xenomai/syscall.h:295: error: (Each undeclare=
d identifi
>  > er is reported only once
>  > ../../../src/include/asm/xenomai/syscall.h:295: error: for each functi=
on it appe
>  > ars in.)
>  >
>  > Obviously there is something wrong with the include path used:
>  > uClibc_mutex.h should not include 'pthread.h' in the Xenomai
>  > distribution but rather the version in uClibc itself.
>  >
>  > Why this happens I'm trying to discover.
>  >
>  > The complete configure I'm using is:
>  >
>  > ../xenomai-2.4.3/configure --build=3Di686-pc-linux-gnu --host=3Darm-li=
nux-uclibc --enable-arm-mach=3Dat91sam926x --enable-arm-tsc
>  >
>  > Thanks in advance.
>
> Well, I understand that it may not be important to you if you do not
> intend to use the posix skin, but we should try and solve this issue
> (which seems to be a uclibc issue). Including posix skin pthread.h
> instead of libc pthread.h should be no problem, since posix skin
> pthread.h include the libc pthread.h. The problem here is due to the
> fact that asm-arm/syscall.h is trying to use stderr whereas we are at
> the very beginning of stdio.h where stderr is not defined yet.
>
> I have to admit that I have no idea here other than defining a function
> in init.c which calls fprintf and to call this function instead of
> fprintf in asm-arm/syscall.h
>
> Philippe, any better idea ?
>

No, but I do have an almost as ugly one to suggest:

--- include/asm-arm/syscall.h   (revision 3729)
+++ include/asm-arm/syscall.h   (working copy)
@@ -222,7 +222,6 @@
 #define XENOMAI_SYSARCH_TSCINFO                 4

 #ifndef __KERNEL__
-#include <stdio.h>
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -230,6 +229,8 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <limits.h>
+#include <error.h>
+#include <errno.h>

 __attribute__((weak)) struct __xn_tscinfo __xn_tscinfo =3D {
        type: -1
@@ -291,17 +292,15 @@
        err =3D XENOMAI_SYSCALL2(__xn_sys_arch,
                               XENOMAI_SYSARCH_TSCINFO, &__xn_tscinfo);
        if (err) {
-         error:
-               fprintf(stderr, "Xenomai: Your board/configuration does not=
"
-                       " allow tsc emulation in user-space: %d\n", err);
-               exit(EXIT_FAILURE);
+         fail:
+               error(EXIT_FAILURE, err,
+                     "Xenomai: Your board/configuration does not"
+                     " allow tsc emulation in user-space\n");
        }

        fd =3D open("/dev/mem", O_RDONLY | O_SYNC);
-       if (fd =3D=3D -1) {
-               perror("Xenomai init: open(/dev/mem)");
-               exit(EXIT_FAILURE);
-       }
+       if (fd =3D=3D -1)
+               error(EXIT_FAILURE, errno, "Xenomai init: open(/dev/mem)");

        page_size =3D sysconf(_SC_PAGESIZE);

@@ -313,10 +312,8 @@
                phys_addr =3D (unsigned long) __xn_tscinfo.u.fr.counter;
                addr =3D mmap(NULL, page_size, PROT_READ, MAP_SHARED,
                            fd, phys_addr & ~(page_size - 1));
-               if (addr =3D=3D MAP_FAILED) {
-                       perror("Xenomai init: mmap(/dev/mem)");
-                       exit(EXIT_FAILURE);
-               }
+               if (addr =3D=3D MAP_FAILED)
+                       error(EXIT_FAILURE, errno, "Xenomai init: mmap(/dev=
/mem)");

                __xn_tscinfo.u.fr.counter =3D
                        ((volatile unsigned *)
@@ -330,10 +327,8 @@
                phys_addr =3D (unsigned long) __xn_tscinfo.u.dec.counter;
                addr =3D mmap(NULL, page_size, PROT_READ, MAP_SHARED,
                            fd, phys_addr & ~(page_size - 1));
-               if (addr =3D=3D MAP_FAILED) {
-                       perror("Xenomai init: mmap(/dev/mem)");
-                       exit(EXIT_FAILURE);
-               }
+               if (addr =3D=3D MAP_FAILED)
+                       error(EXIT_FAILURE, "Xenomai init: mmap(/dev/mem)")=
;

                __xn_tscinfo.u.dec.counter =3D
                        ((volatile unsigned *)
@@ -342,18 +337,15 @@
        }
 #endif /* CONFIG_XENO_ARM_HW_DIRECT_TSC =3D=3D __XN_TSC_TYPE_DECREMENTER *=
/
        case __XN_TSC_TYPE_NONE:
-               goto error;
+               goto fail;

        default:
-               fprintf(stderr,
-                       "Xenomai: kernel/user tsc emulation mismatch.\n");
-               exit(EXIT_FAILURE);
+               error(EXIT_FAILURE, err,
+                     "Xenomai: kernel/user tsc emulation mismatch.\n");
        }

-       if (close(fd)) {
-               perror("Xenomai init: close(/dev/mem)");
-               exit(EXIT_FAILURE);
-       }
+       if (close(fd))
+               error(EXIT_FAILURE, errno, "Xenomai init: close(/dev/mem)")=
;
 #endif /* CONFIG_XENO_ARM_HW_DIRECT_TSC */
 }
 #define xeno_arch_features_check() xeno_arm_features_check()

--
Philippe.


