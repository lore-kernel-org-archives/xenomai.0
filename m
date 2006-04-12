Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Apr 2006 11:53:22 +0200
Message-ID: <54DC87D6AB55F34DAC460DFFF590346E2121A1@domain.hid>
From: "Meier, Hans" <Hans.Meier@domain.hid>
Subject: [Xenomai-core] Missing extern "C" { in include/posix/fcntl.h
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

Hi everybody,

Obviously a=20

#ifdef __cplusplus
extern "C" {
#endif

(only the first half of it, the closing '}' exists) is missing in
include/posix/fcntl.h, see the patch below.=20

The problem still exists in 2.1.0 as well as in trunk.

Hans


--- include/posix/fcntl.h	2006-04-12 10:24:14.000000000 +0200
+++ include/posix/fcntl.h	2006-04-12 10:24:47.000000000 +0200
@@ -40,6 +40,10 @@
 #include <time.h>
 #include_next <fcntl.h>
=20
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 int __real_open(const char *path, int oflag, ...);
=20
 #ifdef __cplusplus



