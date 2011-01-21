From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.1.10.1101211400260.3495@domain.hid>
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
	<4D384CC9.2040303@domain.hid>
	<alpine.DEB.1.10.1101201702340.1990@domain.hid>
	<4D386922.5080807@domain.hid>
	<alpine.DEB.1.10.1101201811090.1990@domain.hid>
	<4D387148.3030306@domain.hid> <alpine.DEB.2.00.1101201943440.2425@domain.hid>
	<4D38886F.7060802@domain.hid>
	<alpine.DEB.1.10.1101211400260.3495@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 21 Jan 2011 15:12:58 +0100
Message-ID: <1295619178.1828.53.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

On Fri, 2011-01-21 at 14:09 +0100, Kolja Waschk wrote:
> >>> program, since you should be using #include <pthread.h>, instead of
> >>> #include <posix/pthread.h>, and more importantly, this program is
> >>
> >> Yes. That's an artefact of another problem which seems more toolchain-=
related
> >> in my case. Already noted in our issue tracking system. However, I tri=
ed to
> >
> > As reminder, the correct way to compile a xenomai posix skin program is
> > described here:
> > http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#=
Compilation_flags.
>=20
>=20
> It is impossible for me to use -I$(PREFIX)/include/posix so that I could =
simply
> #include <pthread.h> when using bfin-linux-uclibc-g++(!). The result when=
ever I
> just try to do something like #include <stdio.h> would be the following. =
It
> does work when using gcc instead of g++ (but that's obviously no option f=
or C++
> code)
>=20
>=20
> a.c: #include <stdio.h>
>=20
> bfin-linux-uclibc-g++ -D_GNU_SOURCE -D_REENTRANT -D__XENO__ \
>      -I$PREFIX/usr/include -I$PREFIX/usr/include/posix -c a.c
>=20
>=20
> In file included from /opt/uClinux/blackfin-linux-dist/staging/usr/includ=
e/nucleus/thread.h:25,
>                   from /opt/uClinux/blackfin-linux-dist/staging/usr/inclu=
de/posix/pthread.h:136,
>                   from /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclib=
c/bin/../bfin-linux-uclibc/runtime/usr/include/bits/uClibc_mutex.h:15,
>                   from /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclib=
c/bin/../bfin-linux-uclibc/runtime/usr/include/bits/uClibc_stdio.h:107,
>                   from /opt/uClinux-2010R1-RC5_tools-RC4/bfin-linux-uclib=
c/bin/../bfin-linux-uclibc/runtime/usr/include/stdio.h:72,
>                   from a.c:1:
> /opt/uClinux/blackfin-linux-dist/staging/usr/include/nucleus/types.h: In =
function =E2=80=98void xnobject_copy_name(char*, const char*)=E2=80=99:
> /opt/uClinux/blackfin-linux-dist/staging/usr/include/nucleus/types.h:113:=
 error: =E2=80=98snprintf=E2=80=99 was not declared in this scope
>=20

diff --git a/include/nucleus/types.h b/include/nucleus/types.h
index f49131c..28726df 100644
--- a/include/nucleus/types.h
+++ b/include/nucleus/types.h
@@ -29,6 +29,7 @@
 #endif /* !CONFIG_PREEMPT_RT */
 #else /* !__KERNEL__ */
 #include <stdio.h>
+#include <string.h>
 #include <sys/types.h>
 #include <errno.h>
 #ifndef BITS_PER_LONG
@@ -107,16 +108,14 @@ typedef atomic_flags_t xnflags_t;
=20
 #define XNOBJECT_NAME_LEN 32
=20
-static inline void xnobject_copy_name(char *dst, const char *src)
-{
-    if (src)
-	snprintf(dst, XNOBJECT_NAME_LEN, "%s", src);
-    else
-        *dst =3D '\0';
-}
+#define xnobject_copy_name(dst, src)					\
+	do {								\
+		strncpy((dst), (src) ?: "", XNOBJECT_NAME_LEN-1)	\
+			[XNOBJECT_NAME_LEN-1] =3D '\0';			\
+	} while (0)
=20
-#define xnobject_create_name(dst, n, obj) \
-    snprintf(dst, n, "%p", obj)
+#define xnobject_create_name(dst, n, obj)	\
+	snprintf(dst, n, "%p", obj)
=20
 #define minval(a,b) ((a) < (b) ? (a) : (b))
 #define maxval(a,b) ((a) > (b) ? (a) : (b))

>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Philippe.



