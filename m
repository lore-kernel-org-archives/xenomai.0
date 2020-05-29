Subject: Re: Xenomai-3.1 make fails when configured -mx32 on 64bit kernel
References: <90c644a07db5444384a22e8d26c075e1@mts.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <01e10d16-6dfb-d460-4ef4-45e51ccb9af0@siemens.com>
Date: Fri, 29 May 2020 19:35:30 +0200
MIME-Version: 1.0
In-Reply-To: <90c644a07db5444384a22e8d26c075e1@mts.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Rosenow, Jim" <jim.rosenow@mts.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 29.05.20 16:49, Rosenow, Jim via Xenomai wrote:
> Kernel version:
> Linux debian-10-64bit 4.4.218-xenomai-3.1 #1 SMP PREEMPT Fri May 29 04:49=
:06 CDT 2020 x86_64 GNU/Linux
>=20
> Ipipe version:
> ipipe-core-4.4.218-cip44-x86-23.patch
>=20
> 32bit configured -m32 builds and runs as does the default 64bit version:
> ../configure --enable-pshared --enable-smp CFLAGS=3D"-m32" LDFLAGS=3D"-m3=
2"
>=20
> 32bit configured -mx32 does not build, see below.
> Thanks,
> Jim
>=20
> ../configure --enable-pshared --enable-smp CFLAGS=3D"-mx32" LDFLAGS=3D"-m=
x32"
>=20
> root@debian-10-64bit:~/Xenomai/xenomai-3.1/build# make
> Making all in doc
> make[1]: Entering directory '/root/Xenomai/xenomai-3.1/build/doc'
> Making all in gitdoc
> make[2]: Entering directory '/root/Xenomai/xenomai-3.1/build/doc/gitdoc'
> make[2]: Leaving directory '/root/Xenomai/xenomai-3.1/build/doc/gitdoc'
> Making all in doxygen
> make[2]: Entering directory '/root/Xenomai/xenomai-3.1/build/doc/doxygen'
> make[2]: Nothing to be done for 'all'.
> make[2]: Leaving directory '/root/Xenomai/xenomai-3.1/build/doc/doxygen'
> Making all in asciidoc
> make[2]: Entering directory '/root/Xenomai/xenomai-3.1/build/doc/asciidoc'
> make[2]: Nothing to be done for 'all'.
> make[2]: Leaving directory '/root/Xenomai/xenomai-3.1/build/doc/asciidoc'
> make[2]: Entering directory '/root/Xenomai/xenomai-3.1/build/doc'
> make[2]: Nothing to be done for 'all-am'.
> make[2]: Leaving directory '/root/Xenomai/xenomai-3.1/build/doc'
> make[1]: Leaving directory '/root/Xenomai/xenomai-3.1/build/doc'
> Making all in lib
> make[1]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib'
> Making all in boilerplate
> make[2]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/boilerpl=
ate'
> make  all-recursive
> make[3]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/boilerpl=
ate'
> Making all in init
> make[4]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/boilerpl=
ate/init'
>   CC       libbootstrap_a-bootstrap.o
>   AR       libbootstrap.a
> ar: `u' modifier ignored since `D' is the default (see `U')
>   CC       libbootstrap_pic_la-bootstrap.lo
>   CCLD     libbootstrap-pic.la
> ar: `u' modifier ignored since `D' is the default (see `U')
> make[4]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/boilerpla=
te/init'
> make[4]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/boilerpl=
ate'
>   CC       libavl_la-avl.lo
>   CCLD     libavl.la
> ar: `u' modifier ignored since `D' is the default (see `U')
>   CC       libversion_la-version.lo
>   CCLD     libversion.la
> ar: `u' modifier ignored since `D' is the default (see `U')
>   CC       iniparser/libiniparser_la-dictionary.lo
>   CC       iniparser/libiniparser_la-iniparser.lo
>   CCLD     libiniparser.la
> ar: `u' modifier ignored since `D' is the default (see `U')
>   CC       libboilerplate_la-ancillaries.lo
>   CC       libboilerplate_la-heapmem.lo
>   CC       libboilerplate_la-hash.lo
>   CC       libboilerplate_la-setup.lo
>   CC       libboilerplate_la-time.lo
>   CC       libshavl_la-avl.lo
>   CCLD     libshavl.la
> ar: `u' modifier ignored since `D' is the default (see `U')
>   CC       tlsf/libtlsf_la-tlsf.lo
>   CCLD     libtlsf.la
> ar: `u' modifier ignored since `D' is the default (see `U')
>   CCLD     libboilerplate.la
> ar: `u' modifier ignored since `D' is the default (see `U')
>   CC       version-version.o
>   CCLD     version
> make[4]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/boilerpla=
te'
> make[3]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/boilerpla=
te'
> make[2]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/boilerpla=
te'
> Making all in cobalt
> make[2]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt'
> Making all in arch
> make[3]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/a=
rch'
> Making all in x86
> make[4]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/a=
rch/x86'
> Making all in include
> make[5]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/a=
rch/x86/include'
> Making all in asm
> make[6]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/a=
rch/x86/include/asm'
> Making all in xenomai
> make[7]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/a=
rch/x86/include/asm/xenomai'
> make[7]: Nothing to be done for 'all'.
> make[7]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/ar=
ch/x86/include/asm/xenomai'
> make[7]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/a=
rch/x86/include/asm'
> make[7]: Nothing to be done for 'all-am'.
> make[7]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/ar=
ch/x86/include/asm'
> make[6]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/ar=
ch/x86/include/asm'
> make[6]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/a=
rch/x86/include'
> make[6]: Nothing to be done for 'all-am'.
> make[6]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/ar=
ch/x86/include'
> make[5]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/ar=
ch/x86/include'
> make[5]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/a=
rch/x86'
>   CC       libarch_la-features.lo
>   CCLD     libarch.la
> ar: `u' modifier ignored since `D' is the default (see `U')
> make[5]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/ar=
ch/x86'
> make[4]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/ar=
ch/x86'
> make[4]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/a=
rch'
> make[4]: Nothing to be done for 'all-am'.
> make[4]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/ar=
ch'
> make[3]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt/ar=
ch'
> make[3]: Entering directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt'
>   CC       libcobalt_la-attr.lo
>   CC       libcobalt_la-clock.lo
> In file included from ../../../lib/cobalt/clock.c:32:
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/tsc.h: =
In function =91cobalt_read_tsc=92:
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/tsc.h:3=
4:54: error: left shift count >=3D width of type [-Werror=3Dshift-count-ove=
rflow]
>   return ((unsigned long)__a) | (((unsigned long)__d) << 32);
>                                                       ^~
> In file included from ../../../lib/cobalt/clock.c:31:
> ../../../lib/cobalt/clock.c: In function =91__cobalt_clock_getres=92:
> /root/Xenomai/xenomai-3.1/kernel/cobalt/arch/x86/include/asm/xenomai/uapi=
/syscall.h:22:28: error: =91__COBALT_X32_BASE=92 undeclared (first use in t=
his function)
>  #define __xn_syscall_base  __COBALT_X32_BASE
>                             ^~~~~~~~~~~~~~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:196:10: note: in definition of macro =91DO_SYSCALL=92
>    : "0" (name) ASM_ARGS_##nr  \
>           ^~~~
> /root/Xenomai/xenomai-3.1/kernel/cobalt/arch/x86/include/asm/xenomai/uapi=
/syscall.h:27:60: note: in expansion of macro =91__xn_syscall_base=92
>  #define __xn_syscode(__nr) (__COBALT_SYSCALL_BIT | (__nr + __xn_syscall_=
base))
>                                                             ^~~~~~~~~~~~~=
~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:202:13: note: in expansion of macro =91__xn_syscode=92
>   DO_SYSCALL(__xn_syscode(op), nr, args)
>              ^~~~~~~~~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:211:37: note: in expansion of macro =91XENOMAI_DO_SYSCALL=92
>  #define XENOMAI_SYSCALL2(op,a1,a2)  XENOMAI_DO_SYSCALL(2,op,a1,a2)
>                                      ^~~~~~~~~~~~~~~~~~
> ../../../lib/cobalt/clock.c:104:9: note: in expansion of macro =91XENOMAI=
_SYSCALL2=92
>   ret =3D -XENOMAI_SYSCALL2(sc_cobalt_clock_getres, clock_id, tp);
>          ^~~~~~~~~~~~~~~~
> /root/Xenomai/xenomai-3.1/kernel/cobalt/arch/x86/include/asm/xenomai/uapi=
/syscall.h:22:28: note: each undeclared identifier is reported only once fo=
r each function it appears in
>  #define __xn_syscall_base  __COBALT_X32_BASE
>                             ^~~~~~~~~~~~~~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:196:10: note: in definition of macro =91DO_SYSCALL=92
>    : "0" (name) ASM_ARGS_##nr  \
>           ^~~~
> /root/Xenomai/xenomai-3.1/kernel/cobalt/arch/x86/include/asm/xenomai/uapi=
/syscall.h:27:60: note: in expansion of macro =91__xn_syscall_base=92
>  #define __xn_syscode(__nr) (__COBALT_SYSCALL_BIT | (__nr + __xn_syscall_=
base))
>                                                             ^~~~~~~~~~~~~=
~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:202:13: note: in expansion of macro =91__xn_syscode=92
>   DO_SYSCALL(__xn_syscode(op), nr, args)
>              ^~~~~~~~~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:211:37: note: in expansion of macro =91XENOMAI_DO_SYSCALL=92
>  #define XENOMAI_SYSCALL2(op,a1,a2)  XENOMAI_DO_SYSCALL(2,op,a1,a2)
>                                      ^~~~~~~~~~~~~~~~~~
> ../../../lib/cobalt/clock.c:104:9: note: in expansion of macro =91XENOMAI=
_SYSCALL2=92
>   ret =3D -XENOMAI_SYSCALL2(sc_cobalt_clock_getres, clock_id, tp);
>          ^~~~~~~~~~~~~~~~
> ../../../lib/cobalt/clock.c: In function =91__cobalt_clock_gettime=92:
> /root/Xenomai/xenomai-3.1/kernel/cobalt/arch/x86/include/asm/xenomai/uapi=
/syscall.h:22:28: error: =91__COBALT_X32_BASE=92 undeclared (first use in t=
his function)
>  #define __xn_syscall_base  __COBALT_X32_BASE
>                             ^~~~~~~~~~~~~~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:196:10: note: in definition of macro =91DO_SYSCALL=92
>    : "0" (name) ASM_ARGS_##nr  \
>           ^~~~
> /root/Xenomai/xenomai-3.1/kernel/cobalt/arch/x86/include/asm/xenomai/uapi=
/syscall.h:27:60: note: in expansion of macro =91__xn_syscall_base=92
>  #define __xn_syscode(__nr) (__COBALT_SYSCALL_BIT | (__nr + __xn_syscall_=
base))
>                                                             ^~~~~~~~~~~~~=
~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:202:13: note: in expansion of macro =91__xn_syscode=92
>   DO_SYSCALL(__xn_syscode(op), nr, args)
>              ^~~~~~~~~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:211:37: note: in expansion of macro =91XENOMAI_DO_SYSCALL=92
>  #define XENOMAI_SYSCALL2(op,a1,a2)  XENOMAI_DO_SYSCALL(2,op,a1,a2)
>                                      ^~~~~~~~~~~~~~~~~~
> ../../../lib/cobalt/clock.c:204:10: note: in expansion of macro =91XENOMA=
I_SYSCALL2=92
>    ret =3D -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime, clock_id, tp);
>           ^~~~~~~~~~~~~~~~
> ../../../lib/cobalt/clock.c: In function =91__cobalt_clock_settime=92:
> /root/Xenomai/xenomai-3.1/kernel/cobalt/arch/x86/include/asm/xenomai/uapi=
/syscall.h:22:28: error: =91__COBALT_X32_BASE=92 undeclared (first use in t=
his function)
>  #define __xn_syscall_base  __COBALT_X32_BASE
>                             ^~~~~~~~~~~~~~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:196:10: note: in definition of macro =91DO_SYSCALL=92
>    : "0" (name) ASM_ARGS_##nr  \
>           ^~~~
> /root/Xenomai/xenomai-3.1/kernel/cobalt/arch/x86/include/asm/xenomai/uapi=
/syscall.h:27:60: note: in expansion of macro =91__xn_syscall_base=92
>  #define __xn_syscode(__nr) (__COBALT_SYSCALL_BIT | (__nr + __xn_syscall_=
base))
>                                                             ^~~~~~~~~~~~~=
~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:202:13: note: in expansion of macro =91__xn_syscode=92
>   DO_SYSCALL(__xn_syscode(op), nr, args)
>              ^~~~~~~~~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:211:37: note: in expansion of macro =91XENOMAI_DO_SYSCALL=92
>  #define XENOMAI_SYSCALL2(op,a1,a2)  XENOMAI_DO_SYSCALL(2,op,a1,a2)
>                                      ^~~~~~~~~~~~~~~~~~
> ../../../lib/cobalt/clock.c:240:9: note: in expansion of macro =91XENOMAI=
_SYSCALL2=92
>   ret =3D -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id, tp);
>          ^~~~~~~~~~~~~~~~
> ../../../lib/cobalt/clock.c: In function =91__cobalt_clock_adjtime=92:
> /root/Xenomai/xenomai-3.1/kernel/cobalt/arch/x86/include/asm/xenomai/uapi=
/syscall.h:22:28: error: =91__COBALT_X32_BASE=92 undeclared (first use in t=
his function)
>  #define __xn_syscall_base  __COBALT_X32_BASE
>                             ^~~~~~~~~~~~~~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:196:10: note: in definition of macro =91DO_SYSCALL=92
>    : "0" (name) ASM_ARGS_##nr  \
>           ^~~~
> /root/Xenomai/xenomai-3.1/kernel/cobalt/arch/x86/include/asm/xenomai/uapi=
/syscall.h:27:60: note: in expansion of macro =91__xn_syscall_base=92
>  #define __xn_syscode(__nr) (__COBALT_SYSCALL_BIT | (__nr + __xn_syscall_=
base))
>                                                             ^~~~~~~~~~~~~=
~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:202:13: note: in expansion of macro =91__xn_syscode=92
>   DO_SYSCALL(__xn_syscode(op), nr, args)
>              ^~~~~~~~~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:211:37: note: in expansion of macro =91XENOMAI_DO_SYSCALL=92
>  #define XENOMAI_SYSCALL2(op,a1,a2)  XENOMAI_DO_SYSCALL(2,op,a1,a2)
>                                      ^~~~~~~~~~~~~~~~~~
> ../../../lib/cobalt/clock.c:255:9: note: in expansion of macro =91XENOMAI=
_SYSCALL2=92
>   ret =3D -XENOMAI_SYSCALL2(sc_cobalt_clock_adjtime, clock_id, tx);
>          ^~~~~~~~~~~~~~~~
> ../../../lib/cobalt/clock.c: In function =91__cobalt_clock_nanosleep=92:
> /root/Xenomai/xenomai-3.1/kernel/cobalt/arch/x86/include/asm/xenomai/uapi=
/syscall.h:22:28: error: =91__COBALT_X32_BASE=92 undeclared (first use in t=
his function)
>  #define __xn_syscall_base  __COBALT_X32_BASE
>                             ^~~~~~~~~~~~~~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:196:10: note: in definition of macro =91DO_SYSCALL=92
>    : "0" (name) ASM_ARGS_##nr  \
>           ^~~~
> /root/Xenomai/xenomai-3.1/kernel/cobalt/arch/x86/include/asm/xenomai/uapi=
/syscall.h:27:60: note: in expansion of macro =91__xn_syscall_base=92
>  #define __xn_syscode(__nr) (__COBALT_SYSCALL_BIT | (__nr + __xn_syscall_=
base))
>                                                             ^~~~~~~~~~~~~=
~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:202:13: note: in expansion of macro =91__xn_syscode=92
>   DO_SYSCALL(__xn_syscode(op), nr, args)
>              ^~~~~~~~~~~~
> /root/Xenomai/xenomai-3.1/lib/cobalt/arch/x86/include/asm/xenomai/syscall=
.h:213:42: note: in expansion of macro =91XENOMAI_DO_SYSCALL=92
>  #define XENOMAI_SYSCALL4(op,a1,a2,a3,a4) XENOMAI_DO_SYSCALL(4,op,a1,a2,a=
3,a4)
>                                           ^~~~~~~~~~~~~~~~~~
> ../../../lib/cobalt/clock.c:312:9: note: in expansion of macro =91XENOMAI=
_SYSCALL4=92
>   ret =3D -XENOMAI_SYSCALL4(sc_cobalt_clock_nanosleep,
>          ^~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [Makefile:632: libcobalt_la-clock.lo] Error 1
> make[3]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt'
> make[2]: *** [Makefile:805: all-recursive] Error 1
> make[2]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib/cobalt'
> make[1]: *** [Makefile:426: all-recursive] Error 1
> make[1]: Leaving directory '/root/Xenomai/xenomai-3.1/build/lib'
> make: *** [Makefile:459: all-recursive] Error 1
>=20

Indeed, something regressed. No one tests this path.

Are you seriously considering x32? It's a dead end [1], and I would
rather consider removing it. Or someone needs to pick up the ball, fix
this and also ensure it's hooked up in CI and eventually testing - at
least as long as our test environment support it.

Jan

[1] https://lwn.net/Articles/774734/

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

