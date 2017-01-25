From: Henning Schild <henning.schild@siemens.com>
Date: Wed, 25 Jan 2017 16:08:36 +0100
Message-Id: <20170125150837.14161-2-henning.schild@siemens.com>
In-Reply-To: <20170125150837.14161-1-henning.schild@siemens.com>
References: <20170125150837.14161-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 2/3] scripts/xeno-config: apply the assert_nrt
	wrappers on all skins
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

There are basically two classes of wrappers. Those that actually change
the implementation, and those that just assert that certain calls are
not made from a realtime context. The latter are usefull for all skins
and should always be applied.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 configure.ac                  | 12 +++++++-----
 debian/libxenomai-dev.install |  1 +
 lib/cobalt/Makefile.am        |  4 +++-
 lib/cobalt/assert.wrappers    |  2 ++
 lib/cobalt/cobalt.wrappers    |  2 --
 scripts/xeno-config-cobalt.in |  4 ++--
 6 files changed, 15 insertions(+), 10 deletions(-)
 create mode 100644 lib/cobalt/assert.wrappers

diff --git a/configure.ac b/configure.ac
index f61543a..5b9f518 100644
--- a/configure.ac
+++ b/configure.ac
@@ -824,17 +824,19 @@ dnl Build wrapping information. XENO_POSIX_WRAPPERS lists all wrapping
 dnl directives in a format the linker understands, for building the
 dnl in-tree executables which require POSIX symbol wrapping.
 
+   assert_wrappers="$topdir/lib/cobalt/assert.wrappers"
    cobalt_wrappers="$topdir/lib/cobalt/cobalt.wrappers"
    if [[ $ac_cv_ld_file_option = yes ]]; then
-	XENO_POSIX_WRAPPERS="-Wl,@$cobalt_wrappers"
+	XENO_POSIX_WRAPPERS="-Wl,@$assert_wrappers -Wl,@$cobalt_wrappers"
    else
-	XENO_POSIX_WRAPPERS=`while read wrap_option symbol ; do \
-			echo -n "-Wl,$wrap_option,$symbol " ; \
-		done < $cobalt_wrappers`
+	XENO_POSIX_WRAPPERS=`cat $assert_wrappers $cobalt_wrappers | \
+			while read wrap_option symbol ; do \
+				echo -n "-Wl,$wrap_option,$symbol " ; \
+			done`
    fi
 
    AC_SUBST(XENO_POSIX_WRAPPERS)
-   AC_SUBST([CONFIG_STATUS_DEPENDENCIES], ["$cobalt_wrappers"])
+   AC_SUBST([CONFIG_STATUS_DEPENDENCIES], ["$assert_wrappers $cobalt_wrappers"])
 fi
 
 dnl
diff --git a/debian/libxenomai-dev.install b/debian/libxenomai-dev.install
index 7b107cb..6d7eb7b 100644
--- a/debian/libxenomai-dev.install
+++ b/debian/libxenomai-dev.install
@@ -2,5 +2,6 @@ usr/include
 usr/lib/*.la
 usr/lib/*.a
 usr/lib/*.so
+usr/lib/assert.wrappers
 usr/lib/cobalt.wrappers
 usr/lib/dynlist.ld
diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
index 576122d..459b207 100644
--- a/lib/cobalt/Makefile.am
+++ b/lib/cobalt/Makefile.am
@@ -46,10 +46,12 @@ libcobalt_la_CPPFLAGS =			\
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(libdir)
 	$(INSTALL_DATA) $(srcdir)/cobalt.wrappers $(DESTDIR)$(libdir)
+	$(INSTALL_DATA) $(srcdir)/assert.wrappers $(DESTDIR)$(libdir)
 
 uninstall-local:
 	$(RM) $(DESTDIR)$(libdir)/cobalt.wrappers
+	$(RM) $(DESTDIR)$(libdir)/assert.wrappers
 
-EXTRA_DIST = cobalt.wrappers
+EXTRA_DIST = cobalt.wrappers assert.wrappers
 
 SUBDIRS = arch
diff --git a/lib/cobalt/assert.wrappers b/lib/cobalt/assert.wrappers
new file mode 100644
index 0000000..7164858
--- /dev/null
+++ b/lib/cobalt/assert.wrappers
@@ -0,0 +1,2 @@
+--wrap malloc
+--wrap free
diff --git a/lib/cobalt/cobalt.wrappers b/lib/cobalt/cobalt.wrappers
index bf7a810..91bd5ef 100644
--- a/lib/cobalt/cobalt.wrappers
+++ b/lib/cobalt/cobalt.wrappers
@@ -94,8 +94,6 @@
 --wrap fclose
 --wrap syslog
 --wrap vsyslog
---wrap malloc
---wrap free
 --wrap gettimeofday
 --wrap __vfprintf_chk
 --wrap __vprintf_chk
diff --git a/scripts/xeno-config-cobalt.in b/scripts/xeno-config-cobalt.in
index d102d04..3e1f64c 100644
--- a/scripts/xeno-config-cobalt.in
+++ b/scripts/xeno-config-cobalt.in
@@ -235,8 +235,8 @@ if test x$do_ldflags = xy; then
 	echo "no API specified, missing --skin before --ldflags" 1>&2
 	exit 1
     fi
-    ldflags=
-    test x$compat = xy && ldflags="-ltrank "
+    ldflags="`dump_wrappers assert.wrappers`"
+    test x$compat = xy && ldflags="-ltrank $ldflags"
     copperplate=
     for skin in $skin_list; do
 	case "$skin" in
-- 
2.10.2


