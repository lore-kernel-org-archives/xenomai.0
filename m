From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v8 4/4] libs: Silence installation output of libtool
Date: Mon, 14 Mar 2022 11:01:02 +0100
Message-ID: <384dd6c827443b339472751cf770187b601f756f.1647252062.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1647252062.git.jan.kiszka@siemens.com>
References: <cover.1647252062.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/alchemy/Makefile.am     | 2 ++
 lib/analogy/Makefile.am     | 2 ++
 lib/cobalt/Makefile.am      | 2 ++
 lib/copperplate/Makefile.am | 2 ++
 lib/mercury/Makefile.am     | 3 ++-
 lib/psos/Makefile.am        | 2 ++
 lib/smokey/Makefile.am      | 2 ++
 lib/trank/Makefile.am       | 3 ++-
 lib/vxworks/Makefile.am     | 2 ++
 9 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/alchemy/Makefile.am b/lib/alchemy/Makefile.am
index d350912ffe..12f8fab536 100644
--- a/lib/alchemy/Makefile.am
+++ b/lib/alchemy/Makefile.am
@@ -43,6 +43,8 @@ libalchemy@CORE@_la_CPPFLAGS =				\
 	-I$(top_srcdir)/include				\
 	-I$(top_srcdir)/lib
 
+AM_LIBTOOLFLAGS = --silent
+
 EXTRA_DIST = testsuite
 
 SPARSE = sparse
diff --git a/lib/analogy/Makefile.am b/lib/analogy/Makefile.am
index 4c6f0de013..98dbfbf325 100644
--- a/lib/analogy/Makefile.am
+++ b/lib/analogy/Makefile.am
@@ -21,3 +21,5 @@ libanalogy_la_CPPFLAGS =		\
 	@XENO_USER_CFLAGS@		\
 	-I$(top_srcdir)/include 	\
 	-I$(top_srcdir)/lib/boilerplate	
+
+AM_LIBTOOLFLAGS = --silent
diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index b3003cd957..3159695b37 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -54,6 +54,8 @@ libmodechk_la_CPPFLAGS =		\
 	-I$(top_srcdir)/include/cobalt	\
 	-I$(top_srcdir)/include
 
+AM_LIBTOOLFLAGS = --silent
+
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(libdir)
 	$(INSTALL_DATA) $(srcdir)/cobalt.wrappers $(DESTDIR)$(libdir)
diff --git a/lib/copperplate/Makefile.am b/lib/copperplate/Makefile.am
index 671e87d79c..c6edea9853 100644
--- a/lib/copperplate/Makefile.am
+++ b/lib/copperplate/Makefile.am
@@ -51,6 +51,8 @@ libcopperplate@CORE@_la_SOURCES += heapobj-malloc.c
 endif
 endif
 
+AM_LIBTOOLFLAGS = --silent
+
 SUBDIRS = .
 
 if XENO_REGISTRY
diff --git a/lib/mercury/Makefile.am b/lib/mercury/Makefile.am
index d2b06211fd..4866038f6d 100644
--- a/lib/mercury/Makefile.am
+++ b/lib/mercury/Makefile.am
@@ -1,4 +1,3 @@
-
 lib_LTLIBRARIES = libmercury.la
 
 libmercury_la_SOURCES =
@@ -7,3 +6,5 @@ libmercury_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0 -lpthread -lrt
 
 libmercury_la_LIBADD = \
 	../boilerplate/libboilerplate.la
+
+AM_LIBTOOLFLAGS = --silent
diff --git a/lib/psos/Makefile.am b/lib/psos/Makefile.am
index f54b26001d..cbfe457adf 100644
--- a/lib/psos/Makefile.am
+++ b/lib/psos/Makefile.am
@@ -28,6 +28,8 @@ libpsos@CORE@_la_CPPFLAGS =					\
 	-I$(top_srcdir)/include				\
 	-I$(top_srcdir)/lib
 
+AM_LIBTOOLFLAGS = --silent
+
 EXTRA_DIST = testsuite
 
 SPARSE = sparse
diff --git a/lib/smokey/Makefile.am b/lib/smokey/Makefile.am
index 2674e32876..45fd95e5f2 100644
--- a/lib/smokey/Makefile.am
+++ b/lib/smokey/Makefile.am
@@ -11,3 +11,5 @@ libsmokey@CORE@_la_CPPFLAGS =			\
 	@XENO_USER_CFLAGS@		\
 	-I$(top_srcdir)/include		\
 	-I$(top_srcdir)/lib
+
+AM_LIBTOOLFLAGS = --silent
diff --git a/lib/trank/Makefile.am b/lib/trank/Makefile.am
index ec15367d36..c19dd8960c 100644
--- a/lib/trank/Makefile.am
+++ b/lib/trank/Makefile.am
@@ -1,4 +1,3 @@
-
 lib_LTLIBRARIES = libtrank@CORE@.la
 
 libtrank@CORE@_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
@@ -19,3 +18,5 @@ libtrank@CORE@_la_CPPFLAGS =		\
 	-D__XENO_COMPAT__	\
 	-I$(top_srcdir)/include	\
 	-I$(top_srcdir)/lib
+
+AM_LIBTOOLFLAGS = --silent
diff --git a/lib/vxworks/Makefile.am b/lib/vxworks/Makefile.am
index 37b8caf7b5..a1d0d62112 100644
--- a/lib/vxworks/Makefile.am
+++ b/lib/vxworks/Makefile.am
@@ -37,6 +37,8 @@ libvxworks@CORE@_la_CPPFLAGS =				\
 	-I$(top_srcdir)/include				\
 	-I$(top_srcdir)/lib
 
+AM_LIBTOOLFLAGS = --silent
+
 EXTRA_DIST = testsuite
 
 SPARSE = sparse
-- 
2.34.1


