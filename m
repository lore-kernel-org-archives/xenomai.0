Date: Tue, 1 Apr 2008 12:36:47 +0200
From: Robert Schwebel <r.schwebel@domain.hid>
Message-ID: <20080401103647.GR13814@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Subject: [Xenomai-core] [PATCH][SOLO] add sparse support
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

This patch adds static analysis support with sparse to the xenomai-solo
makefiles. To enable sparse checking, use

	./configure --with-sparse[=PATH]

and run 'make sparse' afterwards. I don't have a good idea right now how
to avoid this extra step; it would be much nicer if every call to
$(COMPILE) could be substituted by a sparse call plus the original one,
but I didn't find a good method for that yet that also works with the
libtool calls.

Signed-off-by: Robert Schwebel <r.schwebel@domain.hid>

---
 Makefile.am         |   18 +++++++++++++++++-
 base/Makefile.am    |    6 ++++++
 configure.in        |   32 ++++++++++++++++++++++++++++++++
 psos/Makefile.am    |    6 ++++++
 vxworks/Makefile.am |    5 +++++
 5 files changed, 66 insertions(+), 1 deletion(-)

Index: xenomai-solo/base/Makefile.am
===================================================================
--- xenomai-solo.orig/base/Makefile.am	2008-03-30 21:29:12.000000000 +0200
+++ xenomai-solo/base/Makefile.am	2008-03-30 21:29:46.000000000 +0200
@@ -36,3 +36,9 @@
 	-DTLSF_USE_LOCKS=1 -DUSE_MMAP=1 -DUSE_SBRK=1
 
 EXTRA_DIST = tlsf/README
+
+sparse:
+	@for i in $(libxenomai_la_SOURCES) $(libtlsf_la_SOURCES); do \
+		$(SPARSE) $(CHECKFLAGS) $$i; \
+	done
+
Index: xenomai-solo/configure.in
===================================================================
--- xenomai-solo.orig/configure.in	2008-03-30 21:29:12.000000000 +0200
+++ xenomai-solo/configure.in	2008-03-30 21:29:14.000000000 +0200
@@ -70,6 +70,38 @@
 	esac])
 AC_MSG_RESULT(${debug_symbols:-no})
 
+dnl Sparse check (default: off)
+
+sparse=
+AC_MSG_CHECKING(whether to enable sparse)
+AC_ARG_WITH(sparse,
+    AC_HELP_STRING([--with-sparse@<:@=PATH@:>@], [activate static code analysis with sparse]),
+    [case "$withval" in
+    y | yes) sparse=sparse ;;
+    n | no)  sparse= ;;
+    *) sparse=$withval
+    esac],
+    [sparse=],[]
+)
+if test -n "$sparse" ; then
+    AC_MSG_RESULT(yes)
+    AC_SUBST(SPARSE, $sparse)
+    AC_MSG_CHECKING(whether sparse=$sparse is executable)
+    if test "`$sparse 2>&1 > /dev/null; echo $?`" = "0"; then
+        AC_MSG_RESULT(yes)
+        AC_SUBST(SPARSE, $sparse)
+    else
+        AC_MSG_RESULT(no)
+        AC_MSG_ERROR($sparse is not executable)
+    fi
+else
+    AC_MSG_RESULT(no)
+    AC_SUBST(SPARSE, true)
+fi
+
+checkflags="-nostdinc -isystem \$(SYSROOT)/usr/include -isystem `$CC -print-file-name=include` -Wbitwise -Wno-transparent-union -D_GNU_SOURCE -D_XOPEN_SOURCE=500 -D_REENTRANT \$(DEFS) \$(DEFAULT_INCLUDES) \$(INCLUDES) \$(AM_CPPFLAGS) \$(CPPFLAGS)"
+AC_SUBST(CHECKFLAGS, $checkflags)
+
 dnl Enable assertions (default: off)
 
 AC_MSG_CHECKING(whether assertions should be enabled)
Index: xenomai-solo/Makefile.am
===================================================================
--- xenomai-solo.orig/Makefile.am	2008-03-30 21:29:12.000000000 +0200
+++ xenomai-solo/Makefile.am	2008-03-30 21:29:14.000000000 +0200
@@ -1,6 +1,15 @@
 ACLOCAL_AMFLAGS=-I config
 
-SUBDIRS = base vxworks psos include config scripts
+SRC_SUBDIRS= \
+	base \
+	vxworks \
+	psos
+
+SUBDIRS = \
+	$(SRC_SUBDIRS) \
+	include \
+	config \
+	scripts
 
 EXTRA_DIST =
 
@@ -11,3 +20,10 @@
 
 install-user:
 	$(MAKE) install
+
+sparse:
+	@for i in $(SRC_SUBDIRS); do \
+		echo; \
+		make -C $$i sparse; \
+	done
+
Index: xenomai-solo/psos/Makefile.am
===================================================================
--- xenomai-solo.orig/psos/Makefile.am	2008-03-30 21:29:12.000000000 +0200
+++ xenomai-solo/psos/Makefile.am	2008-03-30 21:29:14.000000000 +0200
@@ -22,3 +22,9 @@
 	-I$(top_srcdir)/include
 
 EXTRA_DIST =
+
+sparse:
+	@for i in $(libpsos_la_SOURCES); do \
+		$(SPARSE) $(CHECKFLAGS) $$i; \
+	done
+
Index: xenomai-solo/vxworks/Makefile.am
===================================================================
--- xenomai-solo.orig/vxworks/Makefile.am	2008-03-30 21:29:53.000000000 +0200
+++ xenomai-solo/vxworks/Makefile.am	2008-03-30 21:30:10.000000000 +0200
@@ -24,3 +24,8 @@
 	-I$(top_srcdir)/include
 
 EXTRA_DIST = testsuite
+
+sparse:
+	@for i in $(libvxworks_la_SOURCES); do \
+		$(SPARSE) $(CHECKFLAGS) $$i; \
+	done

-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


