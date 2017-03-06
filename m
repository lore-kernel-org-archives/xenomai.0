From: Henning Schild <henning.schild@siemens.com>
Date: Mon,  6 Mar 2017 15:00:48 +0100
Message-Id: <20170306140049.23493-1-henning.schild@siemens.com>
In-Reply-To: <aa57407e-6064-eebf-6d9f-be2ba864d633@xenomai.org>
References: <aa57407e-6064-eebf-6d9f-be2ba864d633@xenomai.org>
Subject: [Xenomai] [PATCH 1/2] cobalt: fix for incorrect assert wrappers
	commit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Fixes: ebc039b62c40e

Be consistent with wrapping the asserts with every compiler invokation.
Now you can add arbitrary symbols to assert.wrappers without the linker
complaining about them missing.
That problem lead me to include weak dummies for libstdc++ functions in
be90f09cf2770 .

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 configure.ac         | 13 ++++++++++---
 scripts/wrap-link.sh |  2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4792e46..70990d2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -799,9 +799,14 @@ dnl in-tree executables which require POSIX symbol wrapping.
    assert_wrappers="$topdir/lib/cobalt/assert.wrappers"
    cobalt_wrappers="$topdir/lib/cobalt/cobalt.wrappers"
    if [[ $ac_cv_ld_file_option = yes ]]; then
-	XENO_POSIX_WRAPPERS="-Wl,@$assert_wrappers -Wl,@$cobalt_wrappers"
+	XENO_POSIX_WRAPPERS="-Wl,@$cobalt_wrappers"
+	XENO_ASSERT_WRAPPERS="-Wl,@$assert_wrappers"
    else
-	XENO_POSIX_WRAPPERS=`cat $assert_wrappers $cobalt_wrappers | \
+	XENO_POSIX_WRAPPERS=`cat $cobalt_wrappers | \
+			while read wrap_option symbol ; do \
+				echo -n "-Wl,$wrap_option,$symbol " ; \
+			done`
+	XENO_ASSERT_WRAPPERS=`cat $assert_wrappers | \
 			while read wrap_option symbol ; do \
 				echo -n "-Wl,$wrap_option,$symbol " ; \
 			done`
@@ -809,13 +814,15 @@ dnl in-tree executables which require POSIX symbol wrapping.
 
    AC_SUBST(XENO_POSIX_WRAPPERS)
    AC_SUBST([CONFIG_STATUS_DEPENDENCIES], ["$assert_wrappers $cobalt_wrappers"])
+else
+   XENO_ASSERT_WRAPPERS=""
 fi
 
 dnl
 dnl Build the Makefiles
 dnl
 
-XENO_AUTOINIT_LDFLAGS='$(top_builddir)/lib/boilerplate/init/bootstrap-internal.o'" -Wl,--wrap=main -Wl,--dynamic-list=$topdir/scripts/dynlist.ld"
+XENO_AUTOINIT_LDFLAGS='$(top_builddir)/lib/boilerplate/init/bootstrap-internal.o'" -Wl,--wrap=main -Wl,--dynamic-list=$topdir/scripts/dynlist.ld $XENO_ASSERT_WRAPPERS"
 AC_SUBST(XENO_AUTOINIT_LDFLAGS)
 
 XENO_CORE_LIB=$rtcore_type/lib${rtcore_type}.la
diff --git a/scripts/wrap-link.sh b/scripts/wrap-link.sh
index 1b8c3f4..0e50586 100755
--- a/scripts/wrap-link.sh
+++ b/scripts/wrap-link.sh
@@ -138,7 +138,7 @@ while test $# -gt 0; do
 	    next_is_wrapped_symbol=:
 	    ;;
 
-	-Wl,--wrap,main|-Wl,--wrap=main|-Wl,--dynamic-list=*)
+	-Wl,--wrap,main|-Wl,--wrap=main|-Wl,--dynamic-list=*|-Wl,@*assert.wrappers)
 	    # special case so that we can interpose on the main()
 	    # routine. For this we need this wrapping to take place in
 	    # the second stage.
-- 
2.10.2


