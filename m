Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Mar 2007 15:45:51 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB023@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: [Xenomai-core] [PATCH] check for shm_open/shm_unlink
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I have bumped on a compilation failure of Xenomai 2.3.1 with uClibc.
The shm_open/shm_unlink may not be available, at all.
So here's a basic patch against 2.3.1, FWIW.

diff -u -r1.1.1.5 configure.in
--- configure.in	26 Dec 2006 18:39:27 -0000	1.1.1.5
+++ configure.in	28 Mar 2007 13:33:30 -0000
@@ -567,6 +567,11 @@
 	AC_DEFINE(CONFIG_XENO_POSIX_AUTO_MLOCKALL,1,[config])
 fi
=20
+save_LIBS=3D"$LIBS"
+LIBS=3D"$LIBS -lrt"
+AC_CHECK_FUNCS([shm_open shm_unlink])
+LIBS=3D"$save_LIBS"
+
 dnl
 dnl Build the Makefiles
 dnl
--- src/skins/posix/shm.c	26 Dec 2006 18:39:00 -0000	1.1.1.1
+++ src/skins/posix/shm.c	28 Mar 2007 13:33:30 -0000
@@ -39,8 +39,10 @@
 	if (!err)
 		return fd;
=20
+#ifdef HAVE_SHM_OPEN
 	if (err =3D=3D ENOSYS)
 		return __real_shm_open(name, oflag, mode);
+#endif
=20
 	close(fd);
 	errno =3D err;
@@ -55,8 +57,10 @@
 	if (!err)
 		return 0;
=20
+#ifdef HAVE_SHM_UNLINK
 	if (err =3D=3D ENOSYS)
 		return __real_shm_unlink(name);
+#endif
 =09
 	errno =3D err;
 	return -1;

--=20
Stephane

