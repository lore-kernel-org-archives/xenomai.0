Message-ID: <44786C8F.9070201@domain.hid>
Date: Sat, 27 May 2006 17:13:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7472B0FD30EC8FDCD68E15FE"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [sim] ... doesn't build
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7472B0FD30EC8FDCD68E15FE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I just tried to get the simulator from trunk built but failed here:

In file included from ../../../../xenomai/sim/../include/posix/posix.h:29=
,
                 from
=2E./../../../xenomai/sim/../ksrc/skins/posix/internal.h:24,
                 from
=2E./../../../xenomai/sim/../ksrc/skins/posix/thread.h:23,
                 from
=2E./../../../xenomai/sim/../ksrc/skins/posix/sched.c:48:
=2E./../../../xenomai/sim/../include/posix/pthread.h:246: conflicting
types for `pthread_attr_getaffinity_np'
/usr/include/pthread.h:383: previous declaration of
`pthread_attr_getaffinity_np'
=2E./../../../xenomai/sim/../include/posix/pthread.h:249: conflicting
types for `pthread_attr_setaffinity_np'
/usr/include/pthread.h:377: previous declaration of
`pthread_attr_setaffinity_np'

Looks like glibc-2.4 (that one comes with my opensuse 10.1) now also
knows get/setaffinity. Prototypes of glibc:

extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
                                        size_t __cpusetsize,
                                        __const cpu_set_t *__cpuset)
__THROW;
extern int pthread_attr_getaffinity_np (__const pthread_attr_t *__attr,
                                        size_t __cpusetsize,
                                        cpu_set_t *__cpuset) __THROW;

Moreover, I get tons of this warning:

/usr/include/bits/pthreadtypes.h:69: warning: unnamed struct/union that
defines no instances

But this is an "imported" issue, isn't it? Likely due to some picky gcc
switch during the simulator build.

Jan


PS: I already committed this tiny fix to make gcc-4.1 happy:

--- sim/vm/interrupt.h  (Revision 1140)
+++ sim/vm/interrupt.h  (Arbeitskopie)
@@ -145,7 +145,7 @@ public:
        return currentIrq;
     }

-    int MvmIrqManager::onHandlerP () {
+    int onHandlerP () {
        return !!getCurrentIrq();
     }


--------------enig7472B0FD30EC8FDCD68E15FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEeGyjniDOoMHTA+kRAjfIAJ47HV7KJ34YO8JAAr7f6dihC8kLEgCeKfrC
u3VR4pfXjQukRdgktnbvhUU=
=0LI7
-----END PGP SIGNATURE-----

--------------enig7472B0FD30EC8FDCD68E15FE--

