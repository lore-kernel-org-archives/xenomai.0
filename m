Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 8 Nov 2007 15:10:35 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB283@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: [Xenomai-core] [PATCH] Wrong -lpthread/-lrt order in
	testsuite/clocktest/Makefile.am ?
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

Testing xenomai-2.4-rc5, I've encountered the following link error:

powerpc-linux-uclibc-gcc -Wl,--wrap -Wl,pthread_create ....
-Wl,--wrap -Wl,mmap -Wl,--wrap -Wl,munmap -o clocktest
clocktest-clocktest.o  ../../skins/posix/.libs/libpthread_rt.a -lpthread
-lrt
.../powerpc-linux-uclibc/lib/libpthread.so: undefined reference to
`__wrap_mmap'
.../powerpc-linux-uclibc/lib/librt.so: undefined reference to
`__wrap_close'
.../powerpc-linux-uclibc/lib/libpthread.so: undefined reference to
`__wrap_munmap'
collect2: ld returned 1 exit status
gmake[4]: *** [clocktest] Error 1
$ powerpc-linux-uclibc-gcc --version
powerpc-linux-uclibc-gcc (GCC) 3.4.3
$ powerpc-linux-uclibc-ld --version
GNU ld version 2.16.90.0.1 20050408

If I swap the order of libpthread_rt.a and -lpthread -lrt, the link
succeeds.
I guess it has to do with the fact that a library which provides symbols
has to be after in the link order of a module which needs them.
Is it still okay with regard to pthread function wrapping?

--- src/testsuite/clocktest/Makefile.am 16 Sep 2007 17:20:32 -0000
1.1.1.1
+++ src/testsuite/clocktest/Makefile.am 8 Nov 2007 14:01:33 -0000
@@ -9,7 +9,7 @@
 clocktest_LDFLAGS =3D $(XENO_POSIX_WRAPPERS) $(XENO_USER_LDFLAGS)

 clocktest_LDADD =3D \
-	../../skins/posix/libpthread_rt.la -lpthread -lrt
+	-lpthread -lrt ../../skins/posix/libpthread_rt.la

 install-data-local:
	$(mkinstalldirs) $(DESTDIR)$(testdir)

Here is the resulting command line (only -lrt is swapped actually):
powerpc-linux-uclibc-gcc -Wl,--wrap -Wl,pthread_create ....
-Wl,--wrap -Wl,mmap -Wl,--wrap -Wl,munmap -o clocktest
clocktest-clocktest.o  -lrt ../../skins/posix/.libs/libpthread_rt.a
-lpthread

--=20
Stephane

