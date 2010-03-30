Message-ID: <4BB1C0DB.40709@domain.hid>
Date: Tue, 30 Mar 2010 11:14:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <507168.65506.qm@domain.hid>,
	<4BAF58F7.7070707@domain.hid>
	<B66DE711C138E84F96E6A2EDD078830B5F2A4D39D0@domain.hid>
	<4BB1287B.6020205@domain.hid>
	<4BB1BEF2.5040600@domain.hid>
In-Reply-To: <4BB1BEF2.5040600@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem to cross-compile
	Xenomai	user-space	support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrice Kadionik <kadionik@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Patrice Kadionik wrote:
> Le 30/03/2010 00:23, Gilles Chanteperdrix a =C3=A9crit :
>> Huan Fang wrote:
>>   =20
>>> eck_vdso-check-vdso.o ../../skins/native/libnative.la -lpthread -lm
>>> libtool: link: ../../../scripts/wrap-link.sh nios2-linux-gcc -Wl,-elf=
2flt -o check-vdso check_vdso-check-vdso.o  ../../skins/native/.libs/libn=
ative.a -lpthread -lm
>>> check-vdso.elf2flt(.text+0x16c): In function `main':
>>> : undefined reference to `xeno_sem_heap'
>>> check-vdso.elf2flt(.text+0x170): In function `main':
>>> : undefined reference to `xeno_sem_heap'
>>> collect2: ld returned 1 exit status
>>> make[3]: *** [check-vdso] Erreur 1
>>> make[3]: quittant le r=C3=A9pertoire =C2=AB /home/sonda/Desktop/xenom=
ai-2.5.1/src/testsuite/unit =C2=BB
>>> make[2]: *** [all-recursive] Erreur 1
>>> make[2]: quittant le r=C3=A9pertoire =C2=AB /home/sonda/Desktop/xenom=
ai-2.5.1/src/testsuite =C2=BB
>>> make[1]: *** [all-recursive] Erreur 1
>>> make[1]: quittant le r=C3=A9pertoire =C2=AB /home/sonda/Desktop/xenom=
ai-2.5.1/src =C2=BB
>>> make: *** [all-recursive] Erreur 1
>>>
>>> what can I do? Please help
>>>     =20
>> Please try xenomai 2.5.2
>>
>>
>>   =20
> Hi Gilles,
>=20
> I've done this with the 2.5.2 version and I have had the same problem. =

> It is the consequence of another one earlier in the compilation process=
=2E
> After the xenomai configuration for NIOS II:
> $ ./configure --host=3Dnios2-linux
>=20
> the generated src/include/xeno_config.h configuration file has=20
> CONFIG_XENO_FASTSYNCH not configured:
> ...
> /* config */
> /* #undef CONFIG_XENO_FASTSYNCH */
> ...
>=20
> If you make the compilation, it fails on the src/skins/common/sem_heap.=
c=20
> compilation.
> You have in this files 2 similar functions
> line 100: static void xeno_init_sem_heaps_inner(void)
> and
> line 118: void xeno_init_sem_heaps(void)
>=20
> There is a mismatch in the src/skins/common/sem_heap.h file according t=
o=20
> the CONFIG_XENO_FASTSYNCH definition (during Xenomai configuration).
> In this case it conflits with the macro #define xeno_init_sem_heaps()=20
> line 9 in the src/skins/common/sem_heap.h file and the void=20
> xeno_init_sem_heaps(void) in the src/skins/common/sem_heap.c
>=20
> I don't know what in the right correction to do in the=20
> src/skins/common/sem_heap.h file according to the CONFIG_XENO_FASTSYNCH=
=20
> definition.
>=20
> If I suppress the line 9 (#define ...) in the=20
> src/skins/common/sem_heap.h file, it compiles until problems for=20
> src/testsuite/unit  tool:
> cond-torture.c file. Line 56: problem with the  "if else" structure whe=
n=20
> HAVE_PTHREAD_MUTEXATTR_SETPROTOCOL is not defined (the case here).
> check-vdso.c compilation: in the src/testsuite/unit/Makefile.in file,=20
> the @CONFIG_XENO_FASTSYNCH_TRUE@ controls the check-vdso compilation. i=
t=20
> is not completely inhibited when CONFIG_XENO_FASTSYNCH is not configure=
d=20
> (the case here).
>=20
> I have corrected by hand these 2 problems and Xenomai v2.5.2 is OK on m=
y=20
> NIOS II board.
>=20
> Gilles, what is the right modification to make on the=20
> src/skins/common/sem_heap.h file when CONFIG_XENO_FASTSYNCH is not=20
> defined during Xenomai configration?

We want everything to be compiled even without FASTSYNCH. So, please try
the following patch:

diff --git a/src/skins/common/sem_heap.h b/src/skins/common/sem_heap.h
index d799a37..16dedda 100644
--- a/src/skins/common/sem_heap.h
+++ b/src/skins/common/sem_heap.h
@@ -3,10 +3,6 @@

 #include <xeno_config.h>

-#ifdef CONFIG_XENO_FASTSYNCH
 void xeno_init_sem_heaps(void);
-#else /* !CONFIG_XENO_FASTSYNCH */
-#define xeno_init_sem_heaps()
-#endif /* !CONFIG_XENO_FASTSYNCH */

 #endif /* XENO_SEM_HEAP_H */
diff --git a/src/testsuite/unit/Makefile.am b/src/testsuite/unit/Makefile=
=2Eam
index d94e53f..8966883 100644
--- a/src/testsuite/unit/Makefile.am
+++ b/src/testsuite/unit/Makefile.am
@@ -92,8 +92,6 @@ cond_torture_native_LDADD =3D \
 	../../skins/common/libxenomai.la \
 	-lpthread -lm

-if CONFIG_XENO_FASTSYNCH
-
 check_vdso_SOURCES =3D check-vdso.c

 check_vdso_CPPFLAGS =3D \
@@ -107,8 +105,6 @@ check_vdso_LDADD =3D \
 	../../skins/common/libxenomai.la \
 	-lpthread -lm

-endif
-
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(rundir)
 	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in >
$(DESTDIR)$(rundir)/.runinfo
diff --git a/src/testsuite/unit/Makefile.in b/src/testsuite/unit/Makefile=
=2Ein
index 3d536a8..5125678 100644
--- a/src/testsuite/unit/Makefile.in
+++ b/src/testsuite/unit/Makefile.in
@@ -64,13 +64,10 @@ arith_DEPENDENCIES =3D ../../skins/native/libnative.l=
a \
 arith_LINK =3D $(LIBTOOL) --tag=3DCC $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) =
\
 	--mode=3Dlink $(CCLD) $(AM_CFLAGS) $(CFLAGS) $(arith_LDFLAGS) \
 	$(LDFLAGS) -o $@
-am__check_vdso_SOURCES_DIST =3D check-vdso.c
-@domain.hid =3D  \
-@domain.hid@	check_vdso-check-vdso.$(OBJEXT)
+am_check_vdso_OBJECTS =3D check_vdso-check-vdso.$(OBJEXT)
 check_vdso_OBJECTS =3D $(am_check_vdso_OBJECTS)
-@domain.hid =3D  \
-@domain.hid@	../../skins/native/libnative.la \
-@domain.hid@	../../skins/common/libxenomai.la
+check_vdso_DEPENDENCIES =3D ../../skins/native/libnative.la \
+	../../skins/common/libxenomai.la
 check_vdso_LINK =3D $(LIBTOOL) --tag=3DCC $(AM_LIBTOOLFLAGS) \
 	$(LIBTOOLFLAGS) --mode=3Dlink $(CCLD) $(AM_CFLAGS) $(CFLAGS) \
 	$(check_vdso_LDFLAGS) $(LDFLAGS) -o $@
@@ -130,7 +127,7 @@ SOURCES =3D $(arith_SOURCES) $(check_vdso_SOURCES) \
 	$(cond_torture_native_SOURCES) $(cond_torture_posix_SOURCES) \
 	$(mutex_torture_native_SOURCES) $(mutex_torture_posix_SOURCES) \
 	$(wakeup_time_SOURCES)
-DIST_SOURCES =3D $(arith_SOURCES) $(am__check_vdso_SOURCES_DIST) \
+DIST_SOURCES =3D $(arith_SOURCES) $(check_vdso_SOURCES) \
 	$(cond_torture_native_SOURCES) $(cond_torture_posix_SOURCES) \
 	$(mutex_torture_native_SOURCES) $(mutex_torture_posix_SOURCES) \
 	$(wakeup_time_SOURCES)
@@ -368,16 +365,16 @@ cond_torture_native_LDADD =3D \
 	../../skins/common/libxenomai.la \
 	-lpthread -lm

-@domain.hid =3D check-vdso.c
-@domain.hid =3D \
-@domain.hid@	@XENO_USER_CFLAGS@ \
-@domain.hid@	-I$(top_srcdir)/include
+check_vdso_SOURCES =3D check-vdso.c
+check_vdso_CPPFLAGS =3D \
+	@XENO_USER_CFLAGS@ \
+	-I$(top_srcdir)/include

-@domain.hid =3D @XENO_USER_LDFLAGS@
-@domain.hid =3D \
-@domain.hid@	../../skins/native/libnative.la \
-@domain.hid@	../../skins/common/libxenomai.la \
-@domain.hid@	-lpthread -lm
+check_vdso_LDFLAGS =3D @XENO_USER_LDFLAGS@
+check_vdso_LDADD =3D \
+	../../skins/native/libnative.la \
+	../../skins/common/libxenomai.la \
+	-lpthread -lm

 EXTRA_DIST =3D runinfo.in
 all: all-am


--=20
					    Gilles.


