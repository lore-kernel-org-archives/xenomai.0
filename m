From: Bernhard Walle <bernhard.walle@domain.hid>
Date: Fri, 7 Apr 2006 22:32:49 +0200
Message-ID: <hsuig3-5kl.ln1@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: news <news@domain.hid>
Subject: [Xenomai-core] Xenosim 2.1 Compile Fixes
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

Hello,

following fixes were necessary to compile Xenosim 2.1 together with
Xenomai 2.1 on SUSE 10.0 with gcc 4.0.2. I hope it can be applied to
SVN. (If generated files are in SVN, autoreconf must be run.)

Thanks.


Regards,
  Bernhard

diff -Nur xenosim-2.1.0.orig/acinclude.m4 xenosim-2.1.0/acinclude.m4
--- xenosim-2.1.0.orig/acinclude.m4	2006-03-11 23:09:35.000000000 +0100
+++ xenosim-2.1.0/acinclude.m4	2006-04-07 21:48:59.000000000 +0200
@@ -76,13 +76,13 @@
 ac_cv_using_gcc_for_mvm_c=no, ac_cv_using_gcc_for_mvm_c=yes)])dnl
 if test $ac_cv_using_gcc_for_mvm_c = yes; then
 AC_MSG_RESULT(yes)
-AC_MSG_CHECKING([if C compiler supports -fwritable-strings -fdollars-in-identifiers])
+AC_MSG_CHECKING([if C compiler supports -fdollars-in-identifiers])
 save_CFLAGS="$CFLAGS"
-CFLAGS="-fwritable-strings -fdollars-in-identifiers -Werror"
+CFLAGS="-fdollars-in-identifiers -Werror"
 AC_CACHE_VAL(ac_cv_cc_mvm_moreflags,
 [AC_TRY_COMPILE([],
 [int i = 0; return i; ],
-ac_cv_cc_mvm_moreflags="-fwritable-strings -fdollars-in-identifiers", ac_cv_cc_mvm_moreflags="")])dnl
+ac_cv_cc_mvm_moreflags="-fdollars-in-identifiers", ac_cv_cc_mvm_moreflags="")])dnl
 MVM_CFLAGS="$ac_cv_cc_mvm_moreflags"
 CFLAGS="$save_CFLAGS"
 else
@@ -126,7 +126,7 @@
 else
 AC_MSG_RESULT(yes)
 fi
-MVM_CXXFLAGS="-fwritable-strings -fdollars-in-identifiers $ac_cv_cxx_mvm_noex $ac_cv_cxx_mvm_nonnull"
+MVM_CXXFLAGS="-fdollars-in-identifiers $ac_cv_cxx_mvm_noex $ac_cv_cxx_mvm_nonnull"
 CXXFLAGS="$save_CXXFLAGS"
 else
 AC_MSG_RESULT(no)
diff -Nur xenosim-2.1.0.orig/vmutils/statobj.h xenosim-2.1.0/vmutils/statobj.h
--- xenosim-2.1.0.orig/vmutils/statobj.h	2006-02-03 23:34:12.000000000 +0100
+++ xenosim-2.1.0/vmutils/statobj.h	2006-04-07 22:00:19.000000000 +0200
@@ -55,6 +55,9 @@
 class MvmFilter;
 class MvmScaler;
 class MvmTimeGraph;
+struct MvmHistogramExportMsg;
+struct MvmTimeGraphExportMsg;
+struct MvmStateDiagramExportMsg;
 
 extern double variance(double,
 		       double,


