From: Paul <paul_c@domain.hid>
Date: Fri, 10 Aug 2007 22:35:28 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hoNvGM0jPCR2IIb"
Message-Id: <200708102235.29011.paul_c@domain.hid>
Subject: [Xenomai-core] Patch for configure --includedir
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

--Boundary-00=_hoNvGM0jPCR2IIb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


There is a small problem when --includedir is passed to configure which bites 
int the install-data-local rule in include/Makefile.am - The includedir 
variable is overridden by $(prefix)/include which causes a fatal error when 
attempting to generate symlinks.

For example:

 ./configure --prefix=/tmp/foo --includedir=/usr/foo

 make install DESTDIR=/tmp/testit

<snip>
rm -f /tmp/testit/tmp/foo/include/asm
ln -s asm-x86_64 /tmp/testit/tmp/foo/include/asm
ln: creating symbolic link `/tmp/testit/tmp/foo/include/asm' to `asm-x86_64': 
No such file or directory
make[3]: *** [install-data-local] Error 1
make[3]: Leaving directory `/tmp/xenomai/include'


Regards, Paul.




--Boundary-00=_hoNvGM0jPCR2IIb
Content-Type: text/x-diff;
  charset="us-ascii";
  name="includedir_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="includedir_fix.diff"

--- include/Makefile.am	(revision 2902)
+++ include/Makefile.am	(working copy)
@@ -1,4 +1,4 @@
-includedir = $(prefix)/include
+#includedir = $(prefix)/include
 
 include_HEADERS = \
 	rtdk.h
Index: sim/include/Makefile.am
===================================================================
--- sim/include/Makefile.am	(revision 2902)
+++ sim/include/Makefile.am	(working copy)
@@ -1,3 +1,3 @@
-includedir = $(prefix)/include/asm-sim
+includesubdir = $(prefix)/include/asm-sim
 
-nodist_include_HEADERS=$(CONFIG_HEADER)
+nodist_includesub_HEADERS=$(CONFIG_HEADER)
Index: sim/skins/posix/Makefile.am
===================================================================
--- sim/skins/posix/Makefile.am	(revision 2902)
+++ sim/skins/posix/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
 vpath %.c $(top_srcdir)/../ksrc/skins/posix
 
-includedir = $(prefix)/include/asm-sim
+includesubdir = $(prefix)/include/asm-sim
 
 CC = $(top_builddir)/gcic/gcic
 
@@ -42,7 +42,7 @@ nodist_libposix_sim_a_SOURCES = \
 	shm.c \
 	module.c
 
-include_HEADERS = \
+includesub_HEADERS = \
 	posix_overrides.h
 
 SUBDIRS = . testsuite demos

--Boundary-00=_hoNvGM0jPCR2IIb--

