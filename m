From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] xeno-test updates [rfc patch]
Date: Fri, 21 Apr 2006 12:53:44 +0900
References: <4447D9CA.9010809@domain.hid>
In-Reply-To: <4447D9CA.9010809@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IdFSEVXjPBnRXCz"
Message-Id: <200604211253.44735.rlenglet@domain.hid>
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

--Boundary-00=_IdFSEVXjPBnRXCz
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jim Cromie wrote:
> Ive started adding to xeno-test, as outlined previously (plus
> some)
[...]
> - -v flag gets whole config (from either source)
[...]
> Dont apply yet, not tested recently.
[...]

When this patch is applied, please also apply the attached patch 
to the manpage for the new -v option.

-- 
Romain LENGLET

--Boundary-00=_IdFSEVXjPBnRXCz
Content-Type: text/x-diff; charset="utf-8";
	name="xeno-test-verboseoptiondoc_2006-04-21.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno-test-verboseoptiondoc_2006-04-21.patch"

--- xenomai/ChangeLog	2006-04-21 12:39:16.309296664 +0900
+++ xenomai-xenotestverboseoption/ChangeLog	2006-04-21 12:48:38.149883912 +0900
@@ -1,3 +1,8 @@
+2006-04-21  Romain Lenglet <rlenglet@domain.hid>
+
+	* doc/man/xeno-test.man.in: Add documentation for the new -v option
+	added to the xeno-test script.
+
 2006-04-20  Jan Kiszka  <jan.kiszka@domain.hid>
 
 	* ksrc/skins/rtdm/device.[ch], ksrc/skins/rtdm/module.c: Catch
--- xenomai/doc/man/xeno-test.man.in	2006-04-19 18:06:11.448935160 +0900
+++ xenomai-xenotestverboseoption/doc/man/xeno-test.man.in	2006-04-21 12:47:25.918864696 +0900
@@ -9,11 +9,11 @@
 .\" Xenomai distribution.
 .\"
 .pc
-.TH XENO-TEST 1 "2006-04-19" "@PACKAGE_VERSION@" "Xenomai"
+.TH XENO-TEST 1 "2006-04-21" "@PACKAGE_VERSION@" "Xenomai"
 .SH NAME
 xeno\-test \- Tests and measures the performance of a Xenomai installation
 .SH SYNOPSIS
-\fBxeno\-test\fP [\fB\-w\fP \fIworkloads\fP] [\fB\-d\fP \fIdevice\fP] [\fB\-W\fP \fIcommand\fP] [\fB\-p\fP \fIcommand\fP] [\fB\-L\fP [\fB\-N\fP \fIprefix\fP]] [\fB\-m\fP | \fB\-M\fP \fIemail\fP] [\fB\-s\fP] [\fB\-l\fP \fIsamples\fP] [\fB\-h\fP [\fB\-H\fP \fIcategories\fP] [\fB\-B\fP \fIgranularity\fP]] [\fB\-T\fP \fIseconds\fP [\fB\-q\fP]] [\fB\-\-\fP] [\fIargs\fP] ...
+\fBxeno\-test\fP [\vB\-v\fP] [\fB\-w\fP \fIworkloads\fP] [\fB\-d\fP \fIdevice\fP] [\fB\-W\fP \fIcommand\fP] [\fB\-p\fP \fIcommand\fP] [\fB\-L\fP [\fB\-N\fP \fIprefix\fP]] [\fB\-m\fP | \fB\-M\fP \fIemail\fP] [\fB\-s\fP] [\fB\-l\fP \fIsamples\fP] [\fB\-h\fP [\fB\-H\fP \fIcategories\fP] [\fB\-B\fP \fIgranularity\fP]] [\fB\-T\fP \fIseconds\fP [\fB\-q\fP]] [\fB\-\-\fP] [\fIargs\fP] ...
 .SH DESCRIPTION
 \fBxeno\-test\fP measures the performance of Xenomai, by executing Xenomai's \fBlatency\fP and \fBklatency\fP tests while generating a high workload on the system.
 The default command that is executed to simulate workload (if no alternate command is specified with a \fB-W\fP \fIcommand\fP option) is:
@@ -34,6 +34,9 @@
 .SH OPTIONS
 These following options are specific to \fBxeno\-test\fP:
 .TP
+\fB\-v\fP
+Outputs more verbose tests results on the standard output.
+.TP
 \fB\-w\fP \fIworkloads\fP
 The number of workload commands to execute simultaneously. By default, this number is \fB1\fP.
 .TP
@@ -119,6 +122,9 @@
 .BR uname (1)
 .SH HISTORY
 .TP
+2006-04-21
+Updated to document the new -v option.
+.TP
 2006-04-19
 Updated to document the new -m and -M options.
 .TP

--Boundary-00=_IdFSEVXjPBnRXCz--

