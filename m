From: Romain Lenglet <rlenglet@domain.hid>
Date: Mon, 27 Mar 2006 18:11:14 +0900
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zw6JEEqF3kBq4gv"
Message-Id: <200603271811.15128.rlenglet@domain.hid>
Subject: [Xenomai-core] xeno-config.man update patch
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

--Boundary-00=_zw6JEEqF3kBq4gv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Here is a patch that updates the manpage for xeno-config: many 
options have been removed.

I have checked the other manpages: they seem up-to-date.

-- 
Romain LENGLET

--Boundary-00=_zw6JEEqF3kBq4gv
Content-Type: text/x-diff; charset="us-ascii";
	name="xenoconfigman-update_2006-03-27.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xenoconfigman-update_2006-03-27.patch"

--- xenomai/ChangeLog	2006-03-27 16:29:36.497437408 +0900
+++ xenomai-newman/ChangeLog	2006-03-27 18:06:37.297541288 +0900
@@ -1,3 +1,8 @@
+2006-03-27  Romain Lenglet <rlenglet@domain.hid>
+
+	* doc/man/xeno-config.man.in: Updated to match the latest revision of
+	the xeno-config script.
+
 2006-03-26  Philippe Gerum  <rpm@xenomai.org>
 
 	* ksrc/arch/i386/patches: Upgrade to 2.6.16-1.2-01.
@@ -148,7 +153,7 @@
 	* ksrc/skins/posix/registry.c (pse51_node_lookup): Use different
 	namespaces for different objects types.
 
-2006-02-27  Romain Lenglet <rlenglet@domain.hid>
+2006-03-08  Romain Lenglet <rlenglet@domain.hid>
 
 	* scripts/prepare-kernel.sh: Added options to select changes to ignore
 	and to not include in the output patch file when the --outpatch option
--- xenomai/doc/man/xeno-config.man.in	2006-02-27 09:51:54.785445304 +0900
+++ xenomai-newman/doc/man/xeno-config.man.in	2006-03-27 18:06:51.743345192 +0900
@@ -9,7 +9,7 @@
 .\" Xenomai distribution.
 .\"
 .pc
-.TH XENO-CONFIG 1 "2005-10-18" "@PACKAGE_VERSION@" "Xenomai"
+.TH XENO-CONFIG 1 "2006-03-27" "@PACKAGE_VERSION@" "Xenomai"
 .SH NAME
 xeno-config \- Display Xenomai libraries configuration
 .SH SYNOPSIS
@@ -20,20 +20,18 @@
 .br
 .B xeno-config \-\-help
 .br
-\fBxeno-config\fP [\fB\-\-version\fP] [\fB\-\-cc\fP] [\fB\-\-cross\-compile\fP] [\fB\-\-arch\fP] [\fB\-\-subarch\fP] [\fB\-\-prefix\fP] [\fB\-\-config\fP] [\fB\-\-mod*\-cflags\fP|\fB\-\-module\-cflags\fP|\fB\-\-kernel\-cflags\fP] [\fB\-\-xeno\-cflags\fP|\fB\-\-fusion\-cflags\fP] [\fB\-\-xeno\-ldflags\fP|\fB\-\-fusion\-ldflags\fP] [\fB\-\-posix\-cflags\fP] [\fB\-\-posix\-ldflags\fP] [\fB\-\-uvm\-cflags\fP] [\fB\-\-uvm\-ldflags\fP] [\fB\-\-linux\-dir\fP|\fB\-\-linux\fP] [\fB\-\-linux\-ver*\fP|\fB\-\-linux\-version\fP] [\fB\-\-mod*\-dir\fP|\fB\-\-module\-dir\fP] [\fB\-\-sym*\-dir\fP|\fB\-\-symbol\-dir\fP] [\fB\-\-lib*\-dir\fP|\fB\-\-library\-dir\fP|\fB\-\-libdir\fP|\fB\-\-user\-libdir\fP]
+\fBxeno-config\fP [\fB\-\-version\fP] [\fB\-\-cc\fP] [\fB\-\-arch\fP] [\fB\-\-prefix\fP] [\fB\-\-xeno\-cflags\fP] [\fB\-\-xeno\-ldflags\fP] [\fB\-\-posix\-cflags\fP] [\fB\-\-posix\-ldflags\fP] [\fB\-\-uvm\-cflags\fP] [\fB\-\-uvm\-ldflags\fP] [\fB\-\-lib*\-dir\fP|\fB\-\-library\-dir\fP|\fB\-\-libdir\fP|\fB\-\-user\-libdir\fP]
 .SH DESCRIPTION
 \fBxeno-config\fP is a script that is used to to display the compiler and linker flags that are required for building applications that use Xenomai.
 Any combination of options can be chosen (except \fB\-\-verbose\fP and \fB\-\-help\fP) to display configuration information, and options can be given in any order.
 The command output one line for each option, in the same order as the options.
 
-When \fBxeno-config \-\-verbose\fP is executed, all configuration information is displayed in a different, human-readable format.
+When \fBxeno-config \-\-verbose\fP is executed, all configuration information is displayed in a different, more human-readable format.
 
 When \fBxeno-config\fP is executed without any options, the output is equivalent to than when executing \fBxeno-config \-\-verbose\fP then \fBxeno-config \-\-help\fP.
 
 .\" ********************************************************************
 .SH OPTIONS
-In an option's description, a \fB*\fP in the option name is meant as a wildcard. For instance, \fB\-\-mod\-cflags\fP, \fB\-\-modu\-cflags\fP and \fB\-\-modanything\-cflags\fP are all valid and synonymous options.
-.TP
 .B \-\-v, \-\-verbose
 Outputs all configuration information, in a human-readable format.
 .TP
@@ -44,35 +42,20 @@
 Outputs one line with the installed Xenomai version.
 .TP
 .B \-\-cc
-Outputs one line with the path to the C compiler command used to compiled Xenomai.
-.TP
-.B \-\-cross\-compile
-Outputs one line with the prefix that was prepended to the command names used to compile Xenomai, e.g. if it was cross-compiled.
-The ouput line is empty if no prefix was prepended to command names.
+Outputs one line with the path to the C compiler command that was used to compiled Xenomai.
 .TP
 .B \-\-arch
 Outputs one line with the architecture to compile to, e.g. i386.
-.TP
-.B \-\-subarch
-Outputs one line with the sub-architecture to compile to.
-The ouput line is empty if not compiling to a specific sub-architecture.
+May be different from the architecture of the currently running system, if cross-compiling.
 .TP
 .B \-\-prefix
 Outputs one line with the absolute path to the base Xenomai installation directory.
 .TP
-.B \-\-config
-Outputs one line with the absolute path to the configuration file used to compile Xenomai.
-.TP
-.B \-\-mod*\-cflags, \-\-module\-cflags, \-\-kernel\-cflags
-Outputs one line with the C compiler command-line options that are necessary to compile Linux kernel modules that use the Xenomai Linux kernel modules.
-.TP
-.B \-\-xeno\-cflags, \-\-fusion\-cflags
+.B \-\-xeno\-cflags
 Outputs one line with the C compiler command-line options that are necessary to compile applications that use the Xenomai libraries.
-The \fB\-\-fusion\-cflags\fP option variant is for backward compatibility only, to be used to compile RTAI/Fusion-based applications.
 .TP
-.B \-\-xeno\-ldflags, \-\-fusion\-ldflags
+.B \-\-xeno\-ldflags
 Outputs one line with the C compiler command-line options that are necessary to link applications against the Xenomai libraries.
-The \fB\-\-fusion\-ldflags\fP option variant is for backward compatibility only, to be used to link RTAI/Fusion-based applications.
 .TP
 .B \-\-posix\-cflags
 Outputs one line with the C compiler command-line options that are necessary to compile applications that use Xenomai's Posix-compatible layer library.
@@ -86,29 +69,15 @@
 .B \-\-uvm\-ldflags
 Outputs one line with the C compiler command-line options that are necessary to link applications against Xenomai's User-space Virtual Machine library.
 .TP
-.B \-\-linux\-dir, \-\-linux
-Outputs one line with the absolute path to the Linux kernel sources used to compile Xenomai.
-.TP
-.B \-\-linux\-ver*, \-\-linux\-version
-Outputs one line with the version of the Linux kernel Xenomai has been compiled against.
-.TP
-.B \-\-mod*\-dir, \-\-module\-dir
-Outputs one line with the absolute path to Xenomai's kernel modules.
-This path may be different from the path to the stock Linux kernel modules.
-.TP
-.B \-\-sym*\-dir, \-\-symbol\-dir
-Outputs one line with the absolute path to the directory of Xenomai's kernel modules symbol files.
-This path may be different from the path to the symbol files of the stock Linux kernel modules.
-.TP
 .B \-\-lib*\-dir, \-\-library\-dir, \-\-libdir, \-\-user\-libdir
 Outputs one line with the absolute path to Xenomai's libraries.
+In the \fB\-\-lib*\-dir\fP option name, the \fB*\fP is meant as a wildcard: \fB\-\-lib\-dir\fP, \fB\-\-libfoo\-dir\fP and \fB\-\-libbar\-dir\fP are all valid and synonymous options.
 .SH "ENVIRONMENT VARIABLES"
 .TP
 .B DESTDIR
 If the \fBDESTDIR\fP variable is set, its content is prepended to the Xenomai installed directories and files names output by the
-\fB\-\-prefix\fP, \fB\-\-config\fP, \fB\-\-module\-dir\fP, \fB\-\-symbol\-dir\fP and \fB\-\-library\-dir\fP
-options, and to the Xenomai installation directories in the flags output by the
-\fB\-\-kernel\-cflags\fP, \fB\-\-xeno\-cflags\fP, \fB\-\-xeno\-ldflags\fP, \fB\-\-posix\-cflags\fP, \fB\-\-posix\-ldflags\fP, \fB\-\-uvm\-cflags\fP and \fB\-\-uvm\-ldflags\fP
+\fB\-\-prefix\fP and \fB\-\-library\-dir\fP options, and to the Xenomai installation directories in the flags output by the
+\fB\-\-xeno\-cflags\fP, \fB\-\-xeno\-ldflags\fP, \fB\-\-posix\-cflags\fP, \fB\-\-posix\-ldflags\fP, \fB\-\-uvm\-cflags\fP and \fB\-\-uvm\-ldflags\fP
 options.
 
 If \fBDESTDIR\fP was set when compiling and installing Xenomai, e.g. for cross-compilation, \fBDESTDIR\fP must be set to the same value before calling \fBxeno-config\fP, in order to output valid directory and file names.
@@ -120,7 +89,12 @@
 .B 1
 The
 .B \-\-posix\-ldflags
-option has been given but Posix support is not available in Xenomai,
-or no option has been given on the command-line.
+option has been given but Posix support is not available in Xenomai;
+or an invalid argument has been given on the command-line.
 .SH HISTORY
-2005-10-18 \- Written by Romain Lenglet <rlenglet@domain.hid>
+.TP
+2006-03-27
+Updated to match latest version of xeno-config.
+.TP
+2005-10-18
+Written by Romain Lenglet <rlenglet@domain.hid>

--Boundary-00=_zw6JEEqF3kBq4gv--

