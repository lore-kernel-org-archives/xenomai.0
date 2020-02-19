From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] libs: Add linking dependencies to libraries
Message-ID: <4d132aef-75ce-3b7a-21b7-d8f8afde1967@siemens.com>
Date: Wed, 19 Feb 2020 13:31:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This ensures that no optimization will drop dependencies of our shared
objects, preventing to load them via dlopen without explicitly loading
those dropped dependencies first. See also
https://xenomai.org/pipermail/xenomai/2020-February/042449.html

As trank now explicitly depends on alchemy, reorder the build to ensure
that the latter is available before the former is built (analogy is
only moved for consistency reasons).

Reported-by: Antoine Hoarau <antoine@flr.io>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/Makefile.am         | 11 +++++++----
 lib/alchemy/Makefile.am |  4 ++++
 lib/analogy/Makefile.am |  2 ++
 lib/psos/Makefile.am    |  4 ++++
 lib/trank/Makefile.am   |  4 ++++
 lib/vxworks/Makefile.am |  4 ++++
 6 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/lib/Makefile.am b/lib/Makefile.am
index c927a9bd85..e909030564 100644
--- a/lib/Makefile.am
+++ b/lib/Makefile.am
@@ -1,10 +1,7 @@
 SUBDIRS = boilerplate
 
 if XENO_COBALT
-SUBDIRS +=	\
-	cobalt	\
-	analogy	\
-	trank
+SUBDIRS += cobalt
 else
 SUBDIRS += mercury
 endif
@@ -16,6 +13,12 @@ SUBDIRS +=		\
 	vxworks		\
 	psos
 
+if XENO_COBALT
+SUBDIRS += 		\
+	analogy		\
+	trank
+endif
+
 DIST_SUBDIRS = 		\
 	alchemy		\
 	analogy		\
diff --git a/lib/alchemy/Makefile.am b/lib/alchemy/Makefile.am
index 5362695ed2..f97bd69bf8 100644
--- a/lib/alchemy/Makefile.am
+++ b/lib/alchemy/Makefile.am
@@ -2,6 +2,10 @@ lib_LTLIBRARIES = libalchemy.la
 
 libalchemy_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
 
+libalchemy_la_LIBADD =						\
+	@XENO_CORE_LDADD@					\
+	$(top_builddir)/lib/copperplate/libcopperplate.la
+
 libalchemy_la_SOURCES =	\
 	init.c		\
 	internal.c	\
diff --git a/lib/analogy/Makefile.am b/lib/analogy/Makefile.am
index e53d8a11ab..4c6f0de013 100644
--- a/lib/analogy/Makefile.am
+++ b/lib/analogy/Makefile.am
@@ -2,6 +2,8 @@ lib_LTLIBRARIES = libanalogy.la
 
 libanalogy_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 1:0:0 -lm
 
+libanalogy_la_LIBADD = @XENO_CORE_LDADD@
+
 libanalogy_la_SOURCES =	\
 	async.c		\
 	descriptor.c	\
diff --git a/lib/psos/Makefile.am b/lib/psos/Makefile.am
index 4eb7ad84ce..6fe50881cc 100644
--- a/lib/psos/Makefile.am
+++ b/lib/psos/Makefile.am
@@ -2,6 +2,10 @@ lib_LTLIBRARIES = libpsos.la
 
 libpsos_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
 
+libpsos_la_LIBADD =						\
+	@XENO_CORE_LDADD@					\
+	$(top_builddir)/lib/copperplate/libcopperplate.la
+
 libpsos_la_SOURCES =	\
 	init.c		\
 	internal.h	\
diff --git a/lib/trank/Makefile.am b/lib/trank/Makefile.am
index 816a1a4047..ee353c6f20 100644
--- a/lib/trank/Makefile.am
+++ b/lib/trank/Makefile.am
@@ -3,6 +3,10 @@ lib_LTLIBRARIES = libtrank.la
 
 libtrank_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
 
+libtrank_la_LIBADD =						\
+	@XENO_CORE_LDADD@					\
+	$(top_builddir)/lib/alchemy/libalchemy.la
+
 libtrank_la_SOURCES =	\
 	init.c		\
 	internal.c	\
diff --git a/lib/vxworks/Makefile.am b/lib/vxworks/Makefile.am
index a123864079..4217a994b0 100644
--- a/lib/vxworks/Makefile.am
+++ b/lib/vxworks/Makefile.am
@@ -2,6 +2,10 @@ lib_LTLIBRARIES = libvxworks.la
 
 libvxworks_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
 
+libvxworks_la_LIBADD =						\
+	@XENO_CORE_LDADD@					\
+	$(top_builddir)/lib/copperplate/libcopperplate.la
+
 libvxworks_la_SOURCES = \
 	init.c		\
 	errnoLib.c	\
-- 
2.16.4

