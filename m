From: Romain Lenglet <rlenglet@domain.hid>
Date: Tue, 25 Apr 2006 15:02:11 +0900
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ktbTEE9YsiFuqeQ"
Message-Id: <200604251502.12312.rlenglet@domain.hid>
Subject: [Xenomai-core] xeno-test manpage patch
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

--Boundary-00=_ktbTEE9YsiFuqeQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Added documentation for the new -U option, and did some cleanups.

-- 
Romain LENGLET

--Boundary-00=_ktbTEE9YsiFuqeQ
Content-Type: text/x-diff; charset="us-ascii";
	name="xeno-test-docupdateagain_2006-04-25.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno-test-docupdateagain_2006-04-25.patch"

--- xenomai/ChangeLog	2006-04-25 11:23:20.032161304 +0900
+++ xenomai-xeno-test-docupdate/ChangeLog	2006-04-25 14:56:27.087233456 +0900
@@ -1,3 +1,12 @@
+2006-04-25  Romain Lenglet <rlenglet@domain.hid>
+
+	* doc/man/xeno-test.man.in: Add documentation for the new -U option.
+	Correct the synopsis to reflect the depencency between -m, -M, -U and
+	-L. Remove references to long removed klatency test command.
+
+	* scripts/xeno-test.in: Typo: "UEL"->"URL". Remove documentation for
+	-u from printed usage until it is actually implemented.
+
 2006-04-24  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
 
 	* ksrc/skins/posix/syscall.c (__shm_open, __mmap_epilogue): Handle
--- xenomai/doc/man/xeno-test.man.in	2006-04-25 11:23:19.790198088 +0900
+++ xenomai-xeno-test-docupdate/doc/man/xeno-test.man.in	2006-04-25 14:58:55.723637288 +0900
@@ -9,23 +9,23 @@
 .\" Xenomai distribution.
 .\"
 .pc
-.TH XENO-TEST 1 "2006-04-21" "@PACKAGE_VERSION@" "Xenomai"
+.TH XENO-TEST 1 "2006-04-25" "@PACKAGE_VERSION@" "Xenomai"
 .SH NAME
 xeno\-test \- Tests and measures the performance of a Xenomai installation
 .SH SYNOPSIS
-\fBxeno\-test\fP [\fB\-v\fP] [\fB\-w\fP \fIworkloads\fP] [\fB\-d\fP \fIdevice\fP] [\fB\-W\fP \fIcommand\fP] [\fB\-p\fP \fIcommand\fP] [\fB\-L\fP [\fB\-N\fP \fIprefix\fP]] [\fB\-m\fP | \fB\-M\fP \fIemail\fP] [\fB\-s\fP] [\fB\-l\fP \fIsamples\fP] [\fB\-h\fP [\fB\-H\fP \fIcategories\fP] [\fB\-B\fP \fIgranularity\fP]] [\fB\-T\fP \fIseconds\fP [\fB\-q\fP]] [\fB\-\-\fP] [\fIargs\fP] ...
+\fBxeno\-test\fP [\fB\-v\fP] [\fB\-w\fP \fIworkloads\fP] [\fB\-d\fP \fIdevice\fP] [\fB\-W\fP \fIcommand\fP] [\fB\-p\fP \fIcommand\fP] [\fB\-L\fP [\fB\-N\fP \fIprefix\fP] [\fB\-m\fP | \fB\-M\fP \fIemail\fP | \fB\-U\fP \fIurl\fP]] [\fB\-s\fP] [\fB\-l\fP \fIsamples\fP] [\fB\-h\fP [\fB\-H\fP \fIcategories\fP] [\fB\-B\fP \fIgranularity\fP]] [\fB\-T\fP \fIseconds\fP [\fB\-q\fP]] [\fB\-\-\fP] [\fIargs\fP] ...
 .SH DESCRIPTION
-\fBxeno\-test\fP measures the performance of Xenomai, by executing Xenomai's \fBlatency\fP and \fBklatency\fP tests while generating a high workload on the system.
+\fBxeno\-test\fP measures the performance of Xenomai, by executing Xenomai's \fBlatency\fP tests while generating a high workload on the system.
 The default command that is executed to simulate workload (if no alternate command is specified with a \fB-W\fP \fIcommand\fP option) is:
 .RS
 .sp
 .B dd if=/dev/zero of=/dev/null
 .sp
 .RE
-The executed \fBlatency\fP and \fBklatency\fP tests periodically (every second) sample and print out the minimum, average, and maximum latency.
+The executed \fBlatency\fP tests periodically (every second) sample and print out the minimum, average, and maximum latency.
 However, by default, if no option is specified to \fBxeno\-test\fP, those tests are executed with the \fB\-q\fP option (see below), which disables the printing of samples.
 If the \fB\-q\fP option is not specified, samples are printed in groups separated by headers.
-In addition, \fBlatency\fP and \fBklatency\fP print statistics for all samples before terminating, and can also optionally print statistics for every group of samples (see the \fB\-s\fP option), and distribution histograms (see the \fB\-h\fP option).
+In addition, \fBlatency\fP print statistics for all samples before terminating, and can also optionally print statistics for every group of samples (see the \fB\-s\fP option), and distribution histograms (see the \fB\-h\fP option).
 
 If an invalid option is specified, \fBxeno\-test\fP prints out an usage help message and exits.
 
@@ -52,22 +52,28 @@
 In addition to such static arguments, the \fIargs\fP optional arguments passed to \fBxeno\-test\fP are appended to \fIcommand\fP to execute it. 
 .TP
 \fB\-p\fP \fIcommand\fP
-Makes \fBxeno\-test\fP execute the specified \fIcommand\fP before, between and after the \fBlatency\fP and \fBklatency\fP tests.
+Makes \fBxeno\-test\fP execute the specified \fIcommand\fP before, between and after the \fBlatency\fP executions. 
 .TP
 \fB\-L\fP
-Activates logging. The log file is created in the current directory, and is named \fBtest\-\fP\fIkernel_release\fP, where \fIkernel_release\fP is the release number of the running Linux kernel (as determined by executing \fBuname \-r\fP).
+Activates logging of the tests results. The log file is created in the \fB/tmp/\fP directory, and is named \fBtest\-\fP\fIkernel_release\fP, where \fIkernel_release\fP is the release number of the running Linux kernel (as determined by executing \fBuname \-r\fP).
 .TP
 \fB\-N\fP \fIprefix\fP
 Prepends \fIprefix\fP\fB\-\fP to the log file name, hence if the \fB\-L\fP option is also specified the log file name is \fIprefix\fP\fB\-test\-\fP\fIkernel_release\fP.
-This option is useful to create the log file in a different directory, by specifying a \fIprefix\fP that starts with the relative path to that directory.
+This option is useful to create the log file in a different directory than \fB/tmp/\fP, by specifying a \fIprefix\fP that starts with the relative path to that directory.
 .TP
 \fB\-m\fP
-Sends the results of the tests to the Xenomai team's email address, to help collecting statistics about Xenomai's performance. The email is sent using the system's mail(1) command.
+Sends the tests results log file to the Xenomai team's email address (\fBxenotest.output@domain.hid), to help collecting statistics about Xenomai's performance. The email is sent using the system's mail(1) command. The email's sender address is \fBxenotest.sender@domain.hid, and the email's subject is \fB"xeno-test results"\fP.
 .TP
 \fB\-M\fP \fIemail\fP
-Sends the results of the tests to the specified email address. The email is sent using the system's mail(1) command.
+Similar to the \fB\-m\fP option, but sends the tests results log file to the specified email address instead of the default one.
+.TP
+\fB\-U\fP \fIurl\fP
+Uploads the tests results log file to the specified URL.
+If there is no file part in the specified \fIurl\fP, the log file name is appended to it to form the URL used for upload.
+The file is transmitted as an attachment, with the log file name as a filename, in an HTTP POST request of MIME type multi-part/form-data (like with a HTML-form-based file uploads).
+The upload is performed using the curl(1) command.
 .PP
-The following options are directly passed to the \fBlatency\fP and \fBklatency\fP test commands executed by \fBxeno\-test\fP.
+The following options are directly passed to the \fBlatency\fP test command executed by \fBxeno\-test\fP.
 If no such options are specified, the \fB\-s \-T 10 \-q\fP options are passed by default by \fBxeno\-test\fP.
 .TP
 \fB\-s\fP
@@ -93,7 +99,7 @@
 By default, this number is \fB1000\fP ns.
 .TP
 \fB\-T\fP \fIseconds\fP
-The period, in seconds, during which \fBlatency\fP and \fBklatency\fP tests are respectively executed.
+The period, in seconds, during which \fBlatency\fP tests are executed.
 If that option is not specified, the tests execute infinitely until the user types \fBCONTROL-C\fP (i.e. sends a SIGINT signal to them).
 .TP
 \fB\-q\fP
@@ -114,14 +120,17 @@
 .SH KNOWN BUGS
 \fBxeno\-test\fP allows to specify the \fB\-N\fP \fIlogprefix\fP option without the \fB\-L\fP option, in which case the log file name is: \fIlogprefix\fP\fB\-\fP.
 
-\fBlatency\fP and \fBklatency\fP allow to specify the \fB\-H\fP \fIcategories\fP and \fB\-B\fP \fIgranularity\fP options without the \fB\-h\fP option, in which case they have no effect.
+\fBlatency\fP allows to specify the \fB\-H\fP \fIcategories\fP and \fB\-B\fP \fIgranularity\fP options without the \fB\-h\fP option, in which case they have no effect.
 
-It is not possible to specify the period between samples (default is \fB1 second\fP) since this is not configurable for \fBklatency\fP, although this may be configured for \fBlatency\fP through this command's \fB\-p\fP option.
+It is possible to specify the period between samples (default is \fB1 second\fP) using the \fBlatency\fP command's \fB\-p\fP option, but this option cannot be passed through \fBxeno-test\fP.
 .SH "SEE ALSO"
 .BR xeno\-load (1),
 .BR uname (1)
 .SH HISTORY
 .TP
+2006-04-25
+Updated to document the new -U option. Removed references to the klatency command. Modified the synopsis to reflect the dependency of -m, -M and -U options on the -L option.
+.TP
 2006-04-21
 Updated to document the new -v option.
 .TP
--- xenomai/scripts/xeno-test.in	2006-04-25 11:23:17.825496768 +0900
+++ xenomai-xeno-test-docupdate/scripts/xeno-test.in	2006-04-25 14:57:42.056836344 +0900
@@ -20,8 +20,7 @@
   -v		verbose
   -M <email>	sends output to given addr
   -m		sends output to xenotest.output@domain.hid
-  -U <url>	uploads output to given UEL
-  -u		uploads output to (TBD)
+  -U <url>	uploads output to given URL
 	
   # following options are passed thru to latency
   -s	print statistics of sampled data (default on)

--Boundary-00=_ktbTEE9YsiFuqeQ--

