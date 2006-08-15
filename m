Message-ID: <44E1BC1F.7030208@domain.hid>
Date: Tue, 15 Aug 2006 14:20:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Buildbot cannot compile xenoma:
	rtcanconfig	refences pthread_kill
References: <200608150949.30029.niklaus.giger@domain.hid>	
	<44E182B8.8000300@domain.hid> <1155642921.4327.7.camel@domain.hid>
In-Reply-To: <1155642921.4327.7.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB5F6FA83560244A34492C3D1"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB5F6FA83560244A34492C3D1
Content-Type: multipart/mixed; boundary="------------000902040506000202070401"

This is a multi-part message in MIME format.
--------------000902040506000202070401
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Tue, 2006-08-15 at 10:15 +0200, Jan Kiszka wrote:
>> Niklaus Giger wrote:
>>> Hi
>>>
>>> All my PPC based compilation fail with something like
>>>
>>> ccache gcc -rdynamic -o .libs/rtcanconfig=20
>>> rtcanconfig.o  -L/mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc=
/src/skins/native -L/mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/=
src/skins/rtdm /mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/s=
kins/rtdm/.libs/librtdm.so -Wl,--rpath -Wl,/usr/xenomai/lib
>>> /mnt/data.ng/buildslave/buildbot/quick-ppc/build/ppc/src/skins/rtdm/.=
libs/librtdm.so:=20
>>> undefined reference to `pthread_kill'
>>> http://ngiger.dyndns.org/buildbot/ppc/builds/229/step-mk_xeno/0
>>> Is this only a PPC problem? It appears first with build 226, which re=
ferred to=20
>>> revisions 1433 and 1434. Details see=20
>>> http://ngiger.dyndns.org/buildbot/ppc/builds/226
>>>
>>> Jan, could you please have a look at the error, as it seems to me tha=
t you=20
>>> reduced the lib dependencies a little bit too much?
>> Well, neither rtcanconfig nor librtdm have explicit dependencies on
>> libpthread. Unfortunately, the generic skin init code now drags in
>> pthread_kill when the linker fails to remove xeno_handle_mlock_alert f=
or
>> librtdm. That doesn't happen with my gcc-4.1, likely older compilers a=
re
>> less smart.
>>
>> Anyone any ideas how to solve it WITHOUT adding -lpthread to librtdm?
>=20
> Could you develop a bit more, i.e. what's the issue with adding this
> dependency?

It's simply unneeded. This is only a single tiny tool, but we may see
more of them in the future, so I would like to clean this up now.

>=20
>>  I
>> would say either move that functions to a separate module
>=20
> The reason to have this code in nucleus/bind.h is that we don't have an=
y
> dependency on common libs aside of the ones providing the skin syscalls=
,
> and we try to avoid code duplication by not implementing this stuff int=
o
> each and every init.c files.
>=20
>>  or include it
>> via a separate header that all skins include except rtdm.
>>
>=20
> I'm still reluctant to make RTDM an exception to the common rule,
> especially to fix a compiler issue.

Actually, the issue is slightly broader, though with varying
significance. The current approach drags xeno_handle_mlock_alert and
xeno_sigxcpu_no_mlock multiple times into the skin lib. Even with
gcc-4.1 that increases libnative by a few data bytes, under 3.3 by ~300
byte of dead code (overall increase of /lib with 3.3: 32 Kbyte).

The attached patch solves both the linking issue and avoids multiple
static includes of code and variables that are only required once. I
think it's cleaner this way, following the idea of asm/bits/ (BTW,
should it become a asm-generic/bits header?).

Jan

--------------000902040506000202070401
Content-Type: text/plain;
 name="separate_mlock_alert.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="separate_mlock_alert.patch"

Index: include/nucleus/mlock_alert.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/mlock_alert.h	(revision 0)
+++ include/nucleus/mlock_alert.h	(revision 0)
@@ -0,0 +1,37 @@
+#ifndef _XENO_NUCLEUS_MLOCK_ALERT_H
+#define _XENO_NUCLEUS_MLOCK_ALERT_H
+
+#ifndef __XENO_SIM__
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <pthread.h>
+
+__attribute__ ((weak))
+int xeno_sigxcpu_no_mlock =3D 1;
+
+__attribute__ ((visibility ("internal")))
+void xeno_handle_mlock_alert(int sig)
+{
+	struct sigaction sa;
+
+	if (xeno_sigxcpu_no_mlock) {
+		fprintf(stderr, "Xenomai: process memory not locked "
+			"(missing mlockall?)\n");
+		fflush(stderr);
+		exit(4);
+	}
+
+	/* XNTRAPSW was set for the thread but no user-defined handler
+	   has been set to override our internal handler, so let's
+	   invoke the default signal action. */
+
+	sa.sa_handler =3D SIG_DFL;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags =3D 0;
+	sigaction(SIGXCPU, &sa, NULL);
+	pthread_kill(pthread_self(), SIGXCPU);
+}
+#endif /* __XENO_SIM__ */
+
+#endif /* _XENO_NUCLEUS_MLOCK_ALERT_H */
Index: include/nucleus/bind.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/bind.h	(revision 1440)
+++ include/nucleus/bind.h	(working copy)
@@ -6,33 +6,9 @@
 #include <string.h>
 #include <errno.h>
 #include <signal.h>
-#include <pthread.h>
 #include <asm/xenomai/syscall.h>
=20
-__attribute__ ((weak))
-int xeno_sigxcpu_no_mlock =3D 1;
-
-static void xeno_handle_mlock_alert(int sig)
-{
-	struct sigaction sa;
-
-	if (xeno_sigxcpu_no_mlock) {
-		fprintf(stderr,
-			"Xenomai: process memory not locked (missing mlockall?)\n");
-		fflush(stderr);
-		exit(4);
-	}
-
-	/* XNTRAPSW was set for the thread but no user-defined handler
-	   has been set to override our internal handler, so let's
-	   invoke the default signal action. */
-
-	sa.sa_handler =3D SIG_DFL;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags =3D 0;
-	sigaction(SIGXCPU, &sa, NULL);
-	pthread_kill(pthread_self(), SIGXCPU);
-}
+void xeno_handle_mlock_alert(int sig);
=20
 static inline int
 xeno_bind_skin(unsigned skin_magic, const char *skin, const char *module=
)
Index: src/skins/rtai/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/rtai/init.c	(revision 1440)
+++ src/skins/rtai/init.c	(working copy)
@@ -20,6 +20,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <rtai/syscall.h>
+#include <nucleus/mlock_alert.h>
=20
 int __rtai_muxid =3D -1;
=20
Index: src/skins/posix/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/posix/init.c	(revision 1440)
+++ src/skins/posix/init.c	(working copy)
@@ -26,6 +26,7 @@
 #include <posix/posix.h>
 #include <posix/syscall.h>
 #include <rtdm/syscall.h>
+#include <nucleus/mlock_alert.h>
=20
 int __pse51_muxid =3D -1;
 int __rtdm_muxid =3D -1;
Index: src/skins/vxworks/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/vxworks/init.c	(revision 1440)
+++ src/skins/vxworks/init.c	(working copy)
@@ -23,6 +23,7 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <vxworks/vxworks.h>
+#include <nucleus/mlock_alert.h>
=20
 pthread_key_t __vxworks_tskey;
=20
Index: src/skins/vrtx/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/vrtx/init.c	(revision 1440)
+++ src/skins/vrtx/init.c	(working copy)
@@ -23,6 +23,7 @@
 #include <stdlib.h>
 #include <pthread.h>
 #include <vrtx/vrtx.h>
+#include <nucleus/mlock_alert.h>
=20
 pthread_key_t __vrtx_tskey;
=20
Index: src/skins/native/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/native/init.c	(revision 1440)
+++ src/skins/native/init.c	(working copy)
@@ -24,6 +24,7 @@
 #include <pthread.h>
 #include <native/syscall.h>
 #include <native/task.h>
+#include <nucleus/mlock_alert.h>
=20
 pthread_key_t __native_tskey;
=20

--------------000902040506000202070401--

--------------enigB5F6FA83560244A34492C3D1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE4bwjniDOoMHTA+kRAqAYAJ9upgmNdf/9+/8/kWkLB2N1XSyTPQCfRkc+
Hix9on6ro13fbM3JlOXdOkQ=
=jL01
-----END PGP SIGNATURE-----

--------------enigB5F6FA83560244A34492C3D1--

