From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] xeno-test manpage patch
Date: Sat, 29 Apr 2006 18:03:47 +0900
References: <200604251502.12312.rlenglet@domain.hid>
	<4452307D.5060108@domain.hid>
In-Reply-To: <4452307D.5060108@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zvyUE7gQcvJ3p1N"
Message-Id: <200604291803.47373.rlenglet@domain.hid>
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

--Boundary-00=_zvyUE7gQcvJ3p1N
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Here is a patch for the manpages.


Jim Cromie wrote:
> Romain Lenglet wrote:
> > Added documentation for the new -U option, and did some
> > cleanups.
>
> FYI,
>
> a few *tiny* issues.
>
> -d   eg: /dev/hda1 might be better than /dev/hda/,  and drop
> trailing slash.
>
> -m, -M.    log-file not required.
>
> -N   path can be /absolute too, not just ../relative
>
> -p 'cmd'   no longer run between latencies, just before &
> after
>
> pass-thru:
>
>  -s -T 10 -q    the 10 is now 120.

Done.

> more subtly - your intro doesnt express the defaulting
> behavior that this section does describe.
> any pass-thru provided with turn off those defaults, so if you
> just use -h, the test will output lines
> each second, and never finish, so you dont get histogram (IIRC
> - you may get it from ^C handler).
> Im not at all sure its worth touching, and I should probably
> change the defaults to add histogram,
> and drop quiet.

Added warning line:
"Any user-specified set of options overrides this default set of 
options."

> -h implies -s   (its just easier that way)

Done.

> --  needed by testsuite/*/run scripts, not by xeno-test.  I
> dont recall every using it.

xeno-test uses getopts to parse options, and getopts parses -- to 
identify the end of options, e.g. if you run:
xeno-test -s -- -v
-v is not recognized as an option.

> BUGS
>
> -N   name is timestamped, giving uniqueness.  This is a
> caveat, not a bug

No, it is a feature. I added it into the documentation of -L 
and -N.
By the way, I suggest that you use a timestamp in the RFC 3339 
format (a subset of ISO 8601):
date "+%Y-%m-%d %H:%M:%S%:z"
or, assuming date is GNU date:
date --rfc-3339=seconds

> -p   oops.   Im open to suggestions whether this is worth
> fixing.
>
> (workload mgmt)
>
>    workload tasks arent always (ever?) restarted once they
> finish, so a real /dev/hda1 workload may end before your test
> does, causing non-uniform &
> unexpected load variations.
>
> workloads arent always killed if test is interrupted.

Added into the bugs section.



Now, it is my turn to make some remarks on xeno-test... ;)

1-
Option "-u" is in the list of options given to getopts: you 
should remove it for now.

2-
I don't know why there is a sort of option "-n" in the case:
        n)
            # accept note (from the outer process)
            notes=$OPTARG ;;
Those three lines should be removed: this is dead code.

-- 
Romain LENGLET

--Boundary-00=_zvyUE7gQcvJ3p1N
Content-Type: text/x-diff; charset="iso-8859-1";
	name="xeno-test-doc_2006-04-29.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno-test-doc_2006-04-29.patch"

--- xenomai/ChangeLog	2006-04-29 15:40:09.297135152 +0900
+++ xenomai-yetanotherdocupdate/ChangeLog	2006-04-29 17:37:21.349100760 +0900
@@ -1,3 +1,16 @@
+2006-04-29  Romain Lenglet <rlenglet@domain.hid>
+
+	* doc/man/xeno-test.man.in: Corrections about options: -d, -L, -N, -p.
+	Removed documented dependency between -m and -M, and -L or -N.
+	Removed History section: redundant with Xenomai's ChangeLog.
+	Modified documented set of default options passed to latency, to
+	reflect new value passed in -T option.
+	Other cleanups.
+
+	* doc/man/{runinfo.man.in,xeno-config.man.in,xeno-info.man.in,
+	xeno-load.man.in}: Removed History sections: redundant with Xenomai's
+	ChangeLog.
+
 2006-04-27  Dmitry Adamushko  <dmitry.adamushko@domain.hid>
 
 	* ksrc/skins/native/intr.c (rt_intr_delete):
--- xenomai/doc/man/runinfo.man.in	2006-03-28 14:12:36.105330472 +0900
+++ xenomai-yetanotherdocupdate/doc/man/runinfo.man.in	2006-04-29 17:35:52.185655664 +0900
@@ -2,7 +2,7 @@
 .\" ** The above line should force tbl to be a preprocessor **
 .\" Man page for runinfo
 .\"
-.\" Copyright (C) 2005 Romain Lenglet <rlenglet@domain.hid>
+.\" Copyright (C) 2005, 2006 Romain Lenglet <rlenglet@domain.hid>
 .\"
 .\" You may distribute under the terms of the GNU General Public
 .\" License as specified in the file COPYING that comes with the
@@ -148,8 +148,3 @@
 .BR insmod (8),
 .BR modprobe (8),
 .BR rmmod (8)
-.SH HISTORY
-.TP
-2005-10-18
-Written by Romain Lenglet <rlenglet@domain.hid>
-
--- xenomai/doc/man/xeno-config.man.in	2006-03-28 14:12:36.110329712 +0900
+++ xenomai-yetanotherdocupdate/doc/man/xeno-config.man.in	2006-04-29 17:35:59.321570840 +0900
@@ -2,7 +2,7 @@
 .\" ** The above line should force tbl to be a preprocessor **
 .\" Man page for xeno-config
 .\"
-.\" Copyright (C) 2005 Romain Lenglet <rlenglet@domain.hid>
+.\" Copyright (C) 2005, 2006 Romain Lenglet <rlenglet@domain.hid>
 .\"
 .\" You may distribute under the terms of the GNU General Public
 .\" License as specified in the file COPYING that comes with the
@@ -92,10 +92,3 @@
 .B \-\-posix\-ldflags
 option has been given but Posix support is not available in Xenomai;
 or an invalid argument has been given on the command-line.
-.SH HISTORY
-.TP
-2006-03-27
-Updated to match latest version of xeno-config.
-.TP
-2005-10-18
-Written by Romain Lenglet <rlenglet@domain.hid>
--- xenomai/doc/man/xeno-info.man.in	2006-03-28 14:12:36.107330168 +0900
+++ xenomai-yetanotherdocupdate/doc/man/xeno-info.man.in	2006-04-29 17:35:16.055148336 +0900
@@ -2,7 +2,7 @@
 .\" ** The above line should force tbl to be a preprocessor **
 .\" Man page for xeno-info
 .\"
-.\" Copyright (C) 2005 Romain Lenglet <rlenglet@domain.hid>
+.\" Copyright (C) 2005, 2006 Romain Lenglet <rlenglet@domain.hid>
 .\"
 .\" You may distribute under the terms of the GNU General Public
 .\" License as specified in the file COPYING that comes with the
@@ -18,8 +18,3 @@
 \fBxeno-info\fP outputs information about the release and version of the currently running Linux kernel, the versions of installed kernel-related tools such as compilation utitilies (gcc, make, ...) and filesystem utilities (mount, e2fsprogs, ...), and the names of currently loaded kernel modules.
 
 It is useful to include the output of the \fBxeno-info\fP command in any bug report to the Xenomai project.
-
-.SH HISTORY
-.TP
-2005-10-19
-Written by Romain Lenglet <rlenglet@domain.hid>
--- xenomai/doc/man/xeno-load.man.in	2006-03-28 14:12:36.108330016 +0900
+++ xenomai-yetanotherdocupdate/doc/man/xeno-load.man.in	2006-04-29 17:35:36.768999352 +0900
@@ -2,7 +2,7 @@
 .\" ** The above line should force tbl to be a preprocessor **
 .\" Man page for xeno-load
 .\"
-.\" Copyright (C) 2005 Romain Lenglet <rlenglet@domain.hid>
+.\" Copyright (C) 2005, 2006 Romain Lenglet <rlenglet@domain.hid>
 .\"
 .\" You may distribute under the terms of the GNU General Public
 .\" License as specified in the file COPYING that comes with the
@@ -59,7 +59,3 @@
 .SH "SEE ALSO"
 .BR runinfo (5),
 .BR sudo (8)
-.SH HISTORY
-.TP
-2005-10-18
-Written by Romain Lenglet <rlenglet@domain.hid>
--- xenomai/doc/man/xeno-test.man.in	2006-04-27 13:03:33.141968792 +0900
+++ xenomai-yetanotherdocupdate/doc/man/xeno-test.man.in	2006-04-29 17:56:57.771257408 +0900
@@ -2,18 +2,18 @@
 .\" ** The above line should force tbl to be a preprocessor **
 .\" Man page for xeno-test
 .\"
-.\" Copyright (C) 2005 Romain Lenglet <rlenglet@domain.hid>
+.\" Copyright (C) 2005, 2006 Romain Lenglet <rlenglet@domain.hid>
 .\"
 .\" You may distribute under the terms of the GNU General Public
 .\" License as specified in the file COPYING that comes with the
 .\" Xenomai distribution.
 .\"
 .pc
-.TH XENO-TEST 1 "2006-04-25" "@PACKAGE_VERSION@" "Xenomai"
+.TH XENO-TEST 1 "2006-04-29" "@PACKAGE_VERSION@" "Xenomai"
 .SH NAME
 xeno\-test \- Tests and measures the performance of a Xenomai installation
 .SH SYNOPSIS
-\fBxeno\-test\fP [\fB\-v\fP] [\fB\-w\fP \fIworkloads\fP] [\fB\-d\fP \fIdevice\fP] [\fB\-W\fP \fIcommand\fP] [\fB\-p\fP \fIcommand\fP] [\fB\-L\fP [\fB\-N\fP \fIprefix\fP] [\fB\-m\fP | \fB\-M\fP \fIemail\fP | \fB\-U\fP \fIurl\fP]] [\fB\-s\fP] [\fB\-l\fP \fIsamples\fP] [\fB\-h\fP [\fB\-H\fP \fIcategories\fP] [\fB\-B\fP \fIgranularity\fP]] [\fB\-T\fP \fIseconds\fP [\fB\-q\fP]] [\fB\-\-\fP] [\fIargs\fP] ...
+\fBxeno\-test\fP [\fB\-v\fP] [\fB\-w\fP \fIworkloads\fP] [\fB\-d\fP \fIdevice\fP] [\fB\-W\fP \fIcommand\fP] [\fB\-p\fP \fIcommand\fP] [\fB\-L\fP] [\fB\-N\fP \fIprefix\fP] [\fB\-m\fP | \fB\-M\fP \fIemail\fP | \fB\-U\fP \fIurl\fP] [\fB\-s\fP] [\fB\-l\fP \fIsamples\fP] [\fB\-h\fP [\fB\-H\fP \fIcategories\fP] [\fB\-B\fP \fIgranularity\fP]] [\fB\-T\fP \fIseconds\fP [\fB\-q\fP]] [\fB\-\-\fP] [\fIargs\fP] ...
 .SH DESCRIPTION
 \fBxeno\-test\fP measures the performance of Xenomai, by executing Xenomai's \fBlatency\fP tests while generating a high workload on the system.
 The default command that is executed to simulate workload (if no alternate command is specified with a \fB-W\fP \fIcommand\fP option) is:
@@ -27,12 +27,12 @@
 If the \fB\-q\fP option is not specified, samples are printed in groups separated by headers.
 In addition, \fBlatency\fP print statistics for all samples before terminating, and can also optionally print statistics for every group of samples (see the \fB\-s\fP option), and distribution histograms (see the \fB\-h\fP option).
 
+.SH OPTIONS
 If an invalid option is specified, \fBxeno\-test\fP prints out an usage help message and exits.
 
 You are strongly encouraged to use the \fB\-m\fP option, to anonymously help the Xenomai team collecting statistics about Xenomai's performance on the widest range of systems.
 
-.SH OPTIONS
-These following options are specific to \fBxeno\-test\fP:
+The following options are specific to \fBxeno\-test\fP:
 .TP
 \fB\-v\fP
 Produces more verbose tests results.
@@ -42,39 +42,44 @@
 .TP
 \fB\-d\fP \fIdevice\fP
 If the default workload command is to be executed, sets the input device to be read by \fBdd\fP to \fIdevice\fP instead of \fB/dev/zero\fP.
-For instance, specifying the device of a real hard-drive (e.g. \fB/dev/hda/\fP) is useful for generating interrupts with I/O.
+For instance, specifying the device of a real hard-drive (e.g. \fB/dev/hda1\fP) is useful for generating interrupts with I/O.
 The specified \fIdevice\fP must be mounted, and cannot be an NFS mount.
 .TP
 \fB\-W\fP \fIcommand\fP
 Executes the specified \fIcommand\fP to generate workload, instead of the default \fBdd if=/dev/zero of=/dev/null\fP command.
-
 If the command requires arguments, the command and its arguments must be quoted and passed as a single \fIcommand\fP argument.
 In addition to such static arguments, the \fIargs\fP optional arguments passed to \fBxeno\-test\fP are appended to \fIcommand\fP to execute it. 
 .TP
 \fB\-p\fP \fIcommand\fP
-Makes \fBxeno\-test\fP execute the specified \fIcommand\fP before, between and after the \fBlatency\fP executions. 
+Makes \fBxeno\-test\fP execute the specified \fIcommand\fP before and after all the \fBlatency\fP executions. 
 .TP
 \fB\-L\fP
-Activates logging of the tests results. The log file is created in the \fB/tmp/\fP directory, and is named \fBtest\-\fP\fIkernel_release\fP, where \fIkernel_release\fP is the release number of the running Linux kernel (as determined by executing \fBuname \-r\fP).
+Activates logging of the tests results.
+The log file is created in the \fB/tmp/\fP directory, and is named \fBtest\-\fP\fIkernel_release\fP\fB\-\fP\fItimestamp\fP, where \fIkernel_release\fP is the release number of the running Linux kernel (as determined by executing \fBuname \-r\fP), and \fItimestamp\fP is a textual representation of the current date and time (as determined by executing \fBdate\fP) used to reduce the risk of file name collisions.
+The log file name can be customized by using the \fB\-N\fP option instead of, or in conjunction with this option.
 .TP
 \fB\-N\fP \fIprefix\fP
-Prepends \fIprefix\fP\fB\-\fP to the log file name, hence if the \fB\-L\fP option is also specified the log file name is \fIprefix\fP\fB\-test\-\fP\fIkernel_release\fP.
-This option is useful to create the log file in a different directory than \fB/tmp/\fP, by specifying a \fIprefix\fP that starts with the relative path to that directory.
+Activates logging of the tests results.
+If the \fB\-L\fP option is also specified, prepends \fIprefix\fP to the log file name, hence the log file name is \fIprefix\fP\fBtest\-\fP\fIkernel_release\fP\fB\-\fP\fItimestamp\fP.
+If the \fB\-L\fP option is not specified, the log file name is \fIprefix\fP\fB\-\fP\fItimestamp\fP.
+This option is useful to create the log file in a different directory than \fB/tmp/\fP (default prefix when using the \fB\-L\fP option), by specifying a \fIprefix\fP which starts with an absolute directory path or a directory path relative to the working directory.
 .TP
 \fB\-m\fP
-Sends the tests results log file to the Xenomai team's email address (\fBxenotest.output@domain.hid), to help collecting statistics about Xenomai's performance. The email is sent using the system's mail(1) command. The email's sender address is \fBxenotest.sender@domain.hid, and the email's subject is \fB"xeno-test results"\fP.
+Sends the tests results to the Xenomai team's email address (\fBxenotest.output@domain.hid), to help collecting statistics about Xenomai's performance. The email is sent using the system's \fBmail\fP command. The email's sender address is \fBxenotest.sender@domain.hid, and the email's subject is \fB"xeno-test results"\fP.
 .TP
 \fB\-M\fP \fIemail\fP
-Similar to the \fB\-m\fP option, but sends the tests results log file to the specified email address instead of the default one.
+Similar to the \fB\-m\fP option, but sends the tests results to the specified email address instead of the default one.
 .TP
 \fB\-U\fP \fIurl\fP
-Uploads the tests results log file to the specified URL.
-If there is no file part in the specified \fIurl\fP, the log file name is appended to it to form the URL used for upload.
-The file is transmitted as an attachment, with the log file name as a filename, in an HTTP POST request of MIME type multi-part/form-data (like with a HTML-form-based file uploads).
-The upload is performed using the curl(1) command.
+Uploads the tests results to the specified URL.
+If there is no file part in the specified \fIurl\fP, and the \fB\-L\fP or \fB\-N\fP option is also specified, the log file name is appended to it to form the URL used for upload.
+The tests results are transmitted as the contents of an HTTP request using the PUT method.
+The upload is performed using the \fBcurl\fP command.
+This option fails silently (i.e. the tests results are not sent) if \fBcurl\fP is not available.
 .PP
 The following options are directly passed to the \fBlatency\fP test command executed by \fBxeno\-test\fP.
-If no such options are specified, the \fB\-s \-T 10 \-q\fP options are passed by default by \fBxeno\-test\fP.
+If no such options are specified, the \fB\-s \-T 120 \-q\fP options are implicitly passed by default by \fBxeno\-test\fP.
+Any user-specified set of options overrides this default set of options.
 .TP
 \fB\-s\fP
 Displays statistics (minimum, average, and maximum latencies) for every group of samples.
@@ -89,6 +94,7 @@
 Displays histograms of all sampled data, at the end of tests.
 The number of categories - or value intervals - of each histogram is determined by the \fB\-H\fP \fIcategories\fP option (default is \fB100\fP categories).
 The granularity - or bucket size -, used to separate latency samples into categories, is determined by the \fB\-B\fP \fIgranularity\fP option (default is \fB1000\fP ns).
+This option implies \fB\-s\fP.
 .TP
 \fB\-H\fP \fIcategories\fP
 The number of categories - or value intervals - of histograms to display if the \fB\-h\fP option is specified.
@@ -118,24 +124,13 @@
 .B 1
 An invalid option was specified.
 .SH KNOWN BUGS
-\fBxeno\-test\fP allows to specify the \fB\-N\fP \fIlogprefix\fP option without the \fB\-L\fP option, in which case the log file name is: \fIlogprefix\fP\fB\-\fP.
-
 \fBlatency\fP allows to specify the \fB\-H\fP \fIcategories\fP and \fB\-B\fP \fIgranularity\fP options without the \fB\-h\fP option, in which case they have no effect.
 
-It is possible to specify the period between samples (default is \fB1 second\fP) using the \fBlatency\fP command's \fB\-p\fP option, but this option cannot be passed through \fBxeno-test\fP.
+It is possible to specify the period between samples (default is \fB1 second\fP) using the \fBlatency\fP command's \fB\-p\fP option, but this option cannot be passed through \fBxeno-test\fP (this conflicts with \fBxeno-test\fP's own \fB\-p\fP option).
+
+The workload generation task (e.g., the default \fBdd if=/dev/zero of=/dev/null\fP command) may terminate before the tests are finished, which may produce inaccurate tests results. It may be necessary to specify an alternate command which lasts longer, using the \fB-W\fP \fIcommand\fP option.
+
+Workload processes may not be properly killed when \fBxeno-test\fP terminate.
 .SH "SEE ALSO"
 .BR xeno\-load (1),
 .BR uname (1)
-.SH HISTORY
-.TP
-2006-04-25
-Updated to document the new -U option. Removed references to the klatency command. Modified the synopsis to reflect the dependency of -m, -M and -U options on the -L option.
-.TP
-2006-04-21
-Updated to document the new -v option.
-.TP
-2006-04-19
-Updated to document the new -m and -M options.
-.TP
-2005-10-19
-Written by Romain Lenglet <rlenglet@domain.hid>

--Boundary-00=_zvyUE7gQcvJ3p1N--

