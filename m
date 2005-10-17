From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] Cosmetic changes to script xeno-config + man page
Date: Tue, 18 Oct 2005 02:17:41 +0900
References: <200510170157.58507.rlenglet@domain.hid>
	<4353D250.9050807@domain.hid>
In-Reply-To: <4353D250.9050807@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1y9UD3FQYLp3CAY"
Message-Id: <200510180217.41806.rlenglet@domain.hid>
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

--Boundary-00=_1y9UD3FQYLp3CAY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> if you see an error, please provide a proper patch.

Here is a patch that includes the correction of xeno-config.in 
and the manpage. If someone wants to add it to the patch tracker 
on the Gna! project page, please do it.

> I cannot see the error youve 'corrected' below..

You will see in the patch. ;)
The usage mentionned --module-cxxflags and --kernel-cxxflags that 
are not allowed, and the actual set of accepted options is 
larger than previously displayed in the usage.

> In fact, youve added one;  -v doesnt work,  --v does.

Thanks, corrected in this patch.

If someone applies the patch to the repository, it will be 
necessary to run autoreconf once (to regenerate configure and 
man/GNUmakefile.in). It does not work on my system, apparently 
because my versions of automake and autoconf are too recent, and 
some rule files seem to not be included in the repository.



I am currently working on manpages for xeno-load(1) and 
runinfo(5) (for the format of .runinfo files). I will send a 
patch with these.

-- 
Romain Lenglet

--Boundary-00=_1y9UD3FQYLp3CAY
Content-Type: text/x-diff; charset="iso-8859-1";
	name="xeno-config-manual.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno-config-manual.patch"

--- xenomai/GNUmakefile.am	2005-10-08 06:11:23.000000000 +0900
+++ xenomai-man/GNUmakefile.am	2005-10-18 01:44:09.813960500 +0900
@@ -12,7 +12,8 @@
 	scripts \
 	@XENO_MAYBE_DOCDIR@ \
 	$(subdirs) \
-	config
+	config \
+	man
 
 EXTRA_DIST = CREDITS makefile Kconfig README.INSTALL README.QUICKINSTALL TROUBLESHOOTING @XENO_MAYBE_SIMDIR@
 
--- xenomai/configure.in	2005-10-15 23:44:26.000000000 +0900
+++ xenomai-man/configure.in	2005-10-18 01:54:33.004907500 +0900
@@ -1474,6 +1474,7 @@
 	include/nucleus/asm-ppc64/GNUmakefile \
 	include/nucleus/asm-ia64/GNUmakefile \
 	include/nucleus/asm-uvm/GNUmakefile \
+	man/GNUmakefile \
 	nucleus/GNUmakefile \
 	scripts/GNUmakefile \
 	scripts/xeno-config \
--- xenomai/man/GNUmakefile.am	1970-01-01 09:00:00.000000000 +0900
+++ xenomai-man/man/GNUmakefile.am	2005-10-18 01:43:50.464751250 +0900
@@ -0,0 +1,2 @@
+man1_MANS = xeno-config.man
+dist_man1_MANS = $(man1_MANS)
--- xenomai/man/xeno-config.man	1970-01-01 09:00:00.000000000 +0900
+++ xenomai-man/man/xeno-config.man	2005-10-18 02:04:16.497373500 +0900
@@ -0,0 +1,120 @@
+'\" t
+.\" ** The above line should force tbl to be a preprocessor **
+.\" Man page for xeno-config
+.\"
+.\" Copyright (C) 2005 Romain Lenglet <rlenglet@domain.hid>
+.\"
+.\" You may distribute under the terms of the GNU General Public
+.\" License as specified in the file COPYING that comes with the
+.\" Xenomai distribution.
+.\"
+.pc
+.TH XENO-CONFIG 1 "2005-10-17" "1.9.9" "Xenomai"
+.SH NAME
+xeno-config \- Display Xenomai libraries configuration
+.SH SYNOPSIS
+.\" The general command line
+.B xeno-config
+.br
+\fBxeno-config\fP \fB\-\-v\fP | \fB\-\-verbose\fP
+.br
+.B xeno-config \-\-help
+.br
+\fBxeno-config\fP [\fB\-\-version\fP] [\fB\-\-cc\fP] [\fB\-\-cross\-compile\fP] [\fB\-\-arch\fP] [\fB\-\-subarch\fP] [\fB\-\-prefix\fP] [\fB\-\-config\fP] [\fB\-\-mod*\-cflags\fP|\fB\-\-module\-cflags\fP|\fB\-\-kernel\-cflags\fP] [\fB\-\-xeno\-cflags\fP|\fB\-\-fusion\-cflags\fP] [\fB\-\-xeno\-ldflags\fP|\fB\-\-fusion\-ldflags\fP] [\fB\-\-posix\-cflags\fP] [\fB\-\-posix\-ldflags\fP] [\fB\-\-uvm\-cflags\fP] [\fB\-\-uvm\-ldflags\fP] [\fB\-\-linux\-dir\fP|\fB\-\-linux\fP] [\fB\-\-linux\-ver*\fP|\fB\-\-linux\-version\fP] [\fB\-\-mod*\-dir\fP|\fB\-\-module\-dir\fP] [\fB\-\-sym*\-dir\fP|\fB\-\-symbol\-dir\fP] [\fB\-\-lib*\-dir\fP|\fB\-\-library\-dir\fP|\fB\-\-libdir\fP|\fB\-\-user\-libdir\fP]
+.SH DESCRIPTION
+\fBxeno-config\fP is a script that is used to to display the compiler and linker flags that are required for building applications that use Xenomai.
+Any combination of options can be chosen (except \fB\-\-verbose\fP and \fB\-\-help\fP) to display configuration information, and options can be given in any order.
+The command output one line for each option, in the same order as the options.
+
+When \fBxeno-config \-\-verbose\fP is executed, all configuration information is displayed in a different, human-readable format.
+
+When \fBxeno-config\fP is executed without any options, the output is equivalent to than when executing \fBxeno-config \-\-verbose\fP then \fBxeno-config \-\-help\fP.
+
+.\" ********************************************************************
+.SH OPTIONS
+In an option's description, a \fB*\fP in the option name is meant as a wildcard. For instance, \fB\-\-mod\-cflags\fP, \fB\-\-modu\-cflags\fP and \fB\-\-modanything\-cflags\fP are all valid and synonymous options.
+.TP
+.B \-\-v, \-\-verbose
+Outputs all configuration information, in a human-readable format.
+.TP
+.B \-\-help
+Outputs the list of available command-line options.
+.TP
+.B \-\-version
+Outputs one line with the installed Xenomai version.
+.TP
+.B \-\-cc
+Outputs one line with the path to the C compiler command used to compiled Xenomai.
+.TP
+.B \-\-cross\-compile
+Outputs one line with the name prefix of the commands used to compile Xenomai, in the case it was cross-compiled.
+The ouput line is empty if it was not cross-compiled.
+.TP
+.B \-\-arch
+Outputs one line with the architecture to compile to, e.g. i386.
+.TP
+.B \-\-subarch
+Outputs one line with the sub-architecture to compile to.
+The ouput line is empty if not compiling to a specific sub-architecture.
+.TP
+.B \-\-prefix
+Outputs one line with the absolute path to the base Xenomai installation directory.
+.TP
+.B \-\-config
+Outputs one line with the absolute path to the configuration file used to compile Xenomai.
+.TP
+.B \-\-mod*\-cflags, \-\-module\-cflags, \-\-kernel\-cflags
+Outputs one line with the C compiler command-line options that are necessary to compile Linux kernel modules that use the Xenomai Linux kernel modules.
+.TP
+.B \-\-xeno\-cflags, \-\-fusion\-cflags
+Outputs one line with the C compiler command-line options that are necessary to compile applications that use the Xenomai libraries.
+The \fB\-\-fusion\-cflags\fP option variant is for backward compatibility only, to be used to compile RTAI/Fusion-based applications.
+.TP
+.B \-\-xeno\-ldflags, \-\-fusion\-ldflags
+Outputs one line with the C compiler command-line options that are necessary to link applications against the Xenomai libraries.
+The \fB\-\-fusion\-ldflags\fP option variant is for backward compatibility only, to be used to link RTAI/Fusion-based applications.
+.TP
+.B \-\-posix\-cflags
+Outputs one line with the C compiler command-line options that are necessary to compile applications that use Xenomai's Posix-compatible layer library.
+.TP
+.B \-\-posix\-ldflags
+Outputs one line with the C compiler command-line options that are necessary to link applications against Xenomai's Posix-compatible layer library.
+.TP
+.B \-\-uvm\-cflags
+Outputs one line with the C compiler command-line options that are necessary to compile applications that use Xenomai's User-space Virtual Machine library.
+.TP
+.B \-\-uvm\-ldflags
+Outputs one line with the C compiler command-line options that are necessary to link applications against Xenomai's User-space Virtual Machine library.
+.TP
+.B \-\-linux\-dir, \-\-linux
+Outputs one line with the absolute path to the Linux kernel sources used to compile Xenomai.
+.TP
+.B \-\-linux\-ver*, \-\-linux\-version
+Outputs one line with the version of the Linux kernel Xenomai has been compiled against.
+.TP
+.B \-\-mod*\-dir, \-\-module\-dir
+Outputs one line with the absolute path to Xenomai's kernel modules.
+This path may be different from the path to the stock Linux kernel modules.
+.TP
+.B \-\-sym*\-dir, \-\-symbol\-dir
+Outputs one line with the absolute path to the directory of Xenomai's kernel modules symbol files.
+This path may be different from the path to the symbol files of the stock Linux kernel modules.
+.TP
+.B \-\-lib*\-dir, \-\-library\-dir, \-\-libdir, \-\-user\-libdir
+Outputs one line with the absolute path to Xenomai's libraries.
+.SH "RETURN CODES"
+.TP
+.B 0
+Successful script execution.
+.TP
+.B 1
+The
+.B \-\-posix\-ldflags
+option has been given but Posix support is not available in Xenomai,
+or no option has been given on the command-line.
+.SH "SEE ALSO"
+.BR xeno-info (1),
+.BR xeno-load (1),
+.BR xeno-test (1)
+.SH HISTORY
+2005-10-17 \- Written by Romain Lenglet <rlenglet@domain.hid>
--- xenomai/scripts/xeno-config.in	2005-10-11 18:35:56.000000000 +0900
+++ xenomai-man/scripts/xeno-config.in	2005-10-18 01:47:04.408872000 +0900
@@ -37,6 +37,7 @@
 Usage xeno-config OPTIONS
 Options :
         --help
+        --v,--verbose
         --version
         --cc
         --cross-compile
@@ -44,19 +45,18 @@
         --subarch
         --prefix
         --config
-        --module-cflags,--kernel-cflags
-        --module-cxxflags,--kernel-cxxflags
+        --mod*-cflags,--kernel-cflags
         --xeno-cflags,--fusion-cflags
         --xeno-ldflags,--fusion-ldflags
         --posix-cflags
         --posix-ldflags
         --uvm-cflags
         --uvm-ldflags
-        --linux-dir
-        --linux-version
-        --module-dir
-        --symbol-dir
-        --library-dir
+        --linux-dir,--linux
+        --linux-ver*
+        --mod*-dir
+        --sym*-dir
+        --lib*-dir,--libdir,--user-libdir
 EOF
     exit $1
 }
@@ -81,11 +81,11 @@
     echo "   " --uvm-cflags="\"=$XENO_UVM_CFLAGS \""
     echo "   " --uvm-ldflags="\"=$XENO_UVM_LDFLAGS\""
 
-    echo "   " --mod*-dir="\"=$XENO_MODULE_DIR\""
-    echo "   " --sym*-dir="\"$XENO_SYMBOL_DIR\""
-    echo "   " --libdir="\"$XENO_LIBRARY_DIR\""
+    echo "   " --module-dir="\"=$XENO_MODULE_DIR\""
+    echo "   " --symbol-dir="\"$XENO_SYMBOL_DIR\""
+    echo "   " --library-dir="\"$XENO_LIBRARY_DIR\""
     echo "   " --linux-dir="\"$XENO_LINUX_DIR\""
-    echo "   " --linux-ver*="\"$XENO_LINUX_VERSION\""
+    echo "   " --linux-version="\"$XENO_LINUX_VERSION\""
 }
 
 if test $# -eq 0; then

--Boundary-00=_1y9UD3FQYLp3CAY--

