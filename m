From: Romain Lenglet <rlenglet@domain.hid>
Date: Mon, 17 Oct 2005 01:57:58 +0900
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WaoUDNrwXRCMItT"
Message-Id: <200510170157.58507.rlenglet@domain.hid>
Subject: [Xenomai-core] Cosmetic changes to script xeno-config + man page
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

--Boundary-00=_WaoUDNrwXRCMItT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,


Here is a man page that I have written for xeno-config.
Philippe, you will have to create a "man" directory to contain 
that man file and an GNUmakefile.am file that contains:
man1_MANS = xeno-config.man
dist_man1_MANS = $(man1_MANS)

And add "man" to the SUBDIRS in the root GNUmakefile.am.


I will write man pages for xeno-info, xeno-load and xeno-test 
when I have some time this week.


By the way, I noticed that the output of function usage() in that 
script was wrong. Here is a correct version, to replace the one 
in scripts/xeno-config.in:
usage ()
{
cat <<EOF
Usage xeno-config OPTIONS
Options :
        --help
        -v,--verbose
        --version
        --cc
        --cross-compile
        --arch
        --subarch
        --prefix
        --config
        --mod*-cflags,--kernel-cflags
        --xeno-cflags,--fusion-cflags
        --xeno-ldflags,--fusion-ldflags
        --posix-cflags
        --posix-ldflags
        --uvm-cflags
        --uvm-ldflags
        --linux-dir,--linux
        --linux-ver*
        --mod*-dir
        --sym*-dir
        --lib*-dir,--libdir,--user-libdir
EOF
    exit $1
}


And I also noticed a few echos with unquoted "*" in function 
verbose(). Here is a correct version without any "*":
verbose ()
{
    echo xeno-config --verbose

    echo "   " --version="\"${XENO_VERSION}\""
    echo "   " --cc="\"$XENO_CC\""
    echo "   " --cross-compile="\"$CROSS_COMPILE\""
    echo "   " --arch="\"$XENO_TARGET_ARCH\""
    echo "   " --subarch="\"$XENO_TARGET_SUBARCH\""
    echo "   " --prefix="\"$XENO_PREFIX\""
    echo "   " --config="\"$XENO_CONFIG\""
    echo "   " --kernel-cflags="\"$XENO_KERNEL_CFLAGS\""

    echo "   " --xeno-cflags="\"$XENO_BASE_CFLAGS\""
    echo "   " --xeno-ldflags="\"$XENO_BASE_LDFLAGS\""
    echo "   " --posix-cflags="\"$XENO_POSIX_CFLAGS\""
    echo "   " --posix-ldflags="\"$XENO_POSIX_LDFLAGS\""
    echo "   " --uvm-cflags="\"=$XENO_UVM_CFLAGS \""
    echo "   " --uvm-ldflags="\"=$XENO_UVM_LDFLAGS\""

    echo "   " --module-dir="\"=$XENO_MODULE_DIR\""
    echo "   " --symbol-dir="\"$XENO_SYMBOL_DIR\""
    echo "   " --libdir="\"$XENO_LIBRARY_DIR\""
    echo "   " --linux-dir="\"$XENO_LINUX_DIR\""
    echo "   " --linux-version="\"$XENO_LINUX_VERSION\""
}


-- 
Romain Lenglet

--Boundary-00=_WaoUDNrwXRCMItT
Content-Type: application/x-troff-man;
  name="xeno-config.man"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno-config.man"

'\" t
.\" ** The above line should force tbl to be a preprocessor **
.\" Man page for xeno-config
.\"
.\" Copyright (C) 2005 Romain Lenglet <rlenglet@domain.hid>
.\"
.\" You may distribute under the terms of the GNU General Public
.\" License as specified in the file COPYING that comes with the
.\" Xenomai distribution.
.\"
.pc
.TH XENO-CONFIG 1 "2005-10-17" "1.9.9" "Xenomai"
.SH NAME
xeno-config \- Display Xenomai libraries configuration
.SH SYNOPSIS
.\" The general command line
.B xeno-config
.br
.B xeno-config
.RB \| \-v \||\| \-\-verbose \|
.br
.B xeno-config
.B \-\-help
.br
.B xeno-config
.RB [\| \-\-version \|]
.RB [\| \-\-cc \|]
.RB [\| \-\-cross\-compile \|]
.RB [\| \-\-arch \|]
.RB [\| \-\-subarch \|]
.RB [\| \-\-prefix \|]
.RB [\| \-\-config \|]
.RB [\| \-\-mod*\-cflags \||\| \-\-module\-cflags \||\| \-\-kernel\-cflags \|]
.RB [\| \-\-xeno\-cflags \||\| \-\-fusion\-cflags \|]
.RB [\| \-\-xeno\-ldflags \||\| \-\-fusion\-ldflags \|]
.RB [\| \-\-posix\-cflags \|]
.RB [\| \-\-posix\-ldflags \|]
.RB [\| \-\-uvm\-cflags \|]
.RB [\| \-\-uvm\-ldflags \|]
.RB [\| \-\-linux\-dir \||\| \-\-linux \|]
.RB [\| \-\-linux\-ver* \||\| \-\-linux\-version \|]
.RB [\| \-\-mod*\-dir \||\| \-\-module\-dir \|]
.RB [\| \-\-sym*\-dir \||\| \-\-symbol\-dir \|]
.RB [\| \-\-lib*\-dir \||\| \-\-library\-dir \||\| \-\-libdir \||\| \-\-user\-libdir \|]
.SH DESCRIPTION
.B xeno-config
is a script that is used to to display the compiler and linker flags that are required for building applications that use Xenomai.
Any combination of options can be chosen (except
.B \-\-verbose
and
.BR \-\-help)
to display configuration information, and options can be given in any order.
The command output one line for each option, in the same order as the options.

When
.B xeno-config \-\-verbose
is executed, all configuration information is displayed in a different, human-readable format.

When
.B xeno-config
is executed without any options, the output is equivalent to than when executing
.B xeno-config \-\-verbose
then
.B xeno-config
.BR \-\-help .

.\" ********************************************************************
.SH OPTIONS
In an option's description, a
.B *
in the option name is meant as a wildcard. For instance,
.BR \-\-mod\-cflags,
.B \-\-modu\-cflags
and
.B \-\-modanything\-cflags
are all valid and synonymous options.
.TP
.B \-v, \-\-verbose
Outputs all configuration information, in a human-readable format.
.TP
.B \-\-help
Outputs the list of available command-line options.
.TP
.B \-\-version
Outputs one line with the installed Xenomai version.
.TP
.B \-\-cc
Outputs one line with the path to the C compiler command used to compiled Xenomai.
.TP
.B \-\-cross\-compile
Outputs one line with the name prefix of the commands used to compile Xenomai, in the case it was cross-compiled.
The ouput line is empty if it was not cross-compiled.
.TP
.B \-\-arch
Outputs one line with the architecture to compile to, e.g. i386.
.TP
.B \-\-subarch
Outputs one line with the sub-architecture to compile to.
The ouput line is empty if not compiling to a specific sub-architecture.
.TP
.B \-\-prefix
Outputs one line with the absolute path to the base Xenomai installation directory.
.TP
.B \-\-config
Outputs one line with the absolute path to the configuration file used to compile Xenomai.
.TP
.B \-\-mod*\-cflags, \-\-module\-cflags, \-\-kernel\-cflags
Outputs one line with the C compiler command-line options that are necessary to compile Linux kernel modules that use the Xenomai Linux kernel modules.
.TP
.B \-\-xeno\-cflags, \-\-fusion\-cflags
Outputs one line with the C compiler command-line options that are necessary to compile applications that use the Xenomai libraries.
The
.B \-\-fusion\-cflags
option variant is for backward compatibility only, to be used to compile RTAI/Fusion-based applications.
.TP
.B \-\-xeno\-ldflags, \-\-fusion\-ldflags
Outputs one line with the C compiler command-line options that are necessary to link applications against the Xenomai libraries.
The
.B \-\-fusion\-ldflags
option variant is for backward compatibility only, to be used to link RTAI/Fusion-based applications.
.TP
.B \-\-posix\-cflags
Outputs one line with the C compiler command-line options that are necessary to compile applications that use Xenomai's Posix-compatible layer library.
.TP
.B \-\-posix\-ldflags
Outputs one line with the C compiler command-line options that are necessary to link applications against Xenomai's Posix-compatible layer library.
.TP
.B \-\-uvm\-cflags
Outputs one line with the C compiler command-line options that are necessary to compile applications that use Xenomai's User-space Virtual Machine library.
.TP
.B \-\-uvm\-ldflags
Outputs one line with the C compiler command-line options that are necessary to link applications against Xenomai's User-space Virtual Machine library.
.TP
.B \-\-linux\-dir, \-\-linux
Outputs one line with the absolute path to the Linux kernel sources used to compile Xenomai.
.TP
.B \-\-linux\-ver*, \-\-linux\-version
Outputs one line with the version of the Linux kernel Xenomai has been compiled against.
.TP
.B \-\-mod*\-dir, \-\-module\-dir
Outputs one line with the absolute path to Xenomai's kernel modules.
This path may be different from the path to the stock Linux kernel modules.
.TP
.B \-\-sym*\-dir, \-\-symbol\-dir
Outputs one line with the absolute path to the directory of Xenomai's kernel modules symbol files.
This path may be different from the path to the symbol files of the stock Linux kernel modules.
.TP
.B \-\-lib*\-dir, \-\-library\-dir, \-\-libdir, \-\-user\-libdir
Outputs one line with the absolute path to Xenomai's libraries.
.SH "RETURN CODES"
.TP
.B 0
Successful script execution.
.TP
.B 1
The
.B \-\-posix\-ldflags
option has been given but Posix support is not available in Xenomai,
or no option has been given on the command-line.
.SH "SEE ALSO"
.BR xeno-info (1),
.BR xeno-load (1),
.BR xeno-test (1)
.SH HISTORY
Mon Oct 17 2005 \- Written by Romain Lenglet <rlenglet@domain.hid>

--Boundary-00=_WaoUDNrwXRCMItT--

