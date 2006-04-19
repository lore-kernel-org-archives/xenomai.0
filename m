From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] [patch] xeno-test email addition
Date: Wed, 19 Apr 2006 12:55:08 +0900
References: <200604171047.51730.niklaus.giger@domain.hid>
	<4445068A.8000008@domain.hid> <44450CC2.4080505@domain.hid>
In-Reply-To: <44450CC2.4080505@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dSbREBTVJsLwwrw"
Message-Id: <200604191255.09080.rlenglet@domain.hid>
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

--Boundary-00=_dSbREBTVJsLwwrw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Philippe Gerum wrote:
> Jim Cromie wrote:
> > Jim Cromie wrote:
> >> Niklaus Giger wrote:
> >>> Hi
> >>>
> >>> Following a suggestion from Philippe Gerum I propose to
> >>> collect and prepare like this:
> >>>
> >>> a) Make it easy to collect information
> >>>
> >>> add -s/-c option to xeno-test, help text would look like
> >>> -s send output of xeno-test to xeno-stat@domain.hid -c
> >>> <name>  if -s, send also kernel config file to
> >>> xeno-stat@domain.hid
> >>
> >> attached patch adds new -m -M flags for xeno-test, (-s flag
> >> is taken, for statistics)
> >> former for a fixed addy (to be patched later), latter
> >> taking any email as arg.
> >>
> >> I didnt add -c <name>, since xeno-test already does
> >> something similar; if you build with
> >> CONFIG_IKCONFIG_PROC=y, xeno-test greps XENO out of
> >> /proc/config.gz
> >> (probably needs a few more grep terms, and perhaps a
> >> -verbose mode which cats the whole thing.)
> >>
> >> The -M option works, since I just received an email Id sent
> >> earlier, but I also sent one to xenomai-core, and it hasnt
> >> shown up yet. I suspect that the mail looks like spam, and
> >> has been rejected, since my hostname is not a real FQDN.
> >> So Im not so sure that email is the best way here, but it
> >> is conceptually simple.
> >
> > Oof.  Now attached.
>
> Applied, thanks.

Here is its little brother patch which updates the manpage.

-- 
Romain LENGLET

--Boundary-00=_dSbREBTVJsLwwrw
Content-Type: text/x-diff; charset="iso-8859-1";
	name="xeno-test-newoptions_2006-04-19.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno-test-newoptions_2006-04-19.patch"

--- xenomai/ChangeLog	2006-04-19 12:30:32.503520224 +0900
+++ xenomai-xenotestmail/ChangeLog	2006-04-19 12:49:28.379840776 +0900
@@ -1,3 +1,8 @@
+2006-04-19  Romain Lenglet <rlenglet@domain.hid>
+
+	* doc/man/xeno-test.man.in: Add documentation for the new -m and -M
+	options added to the xeno-test script.
+
 2006-04-18  Jim Cromie <jim.cromie@domain.hid>
 
 	* scripts/xeno-test.in: Add -[Mm] options for automated
--- xenomai/doc/man/xeno-test.man.in	2006-03-28 14:12:36.109329864 +0900
+++ xenomai-xenotestmail/doc/man/xeno-test.man.in	2006-04-19 12:48:53.585130376 +0900
@@ -9,11 +9,11 @@
 .\" Xenomai distribution.
 .\"
 .pc
-.TH XENO-TEST 1 "2005-10-19" "@PACKAGE_VERSION@" "Xenomai"
+.TH XENO-TEST 1 "2006-04-19" "@PACKAGE_VERSION@" "Xenomai"
 .SH NAME
-xeno\-test \- Tests and mesures the performance of a Xenomai installation
+xeno\-test \- Tests and measures the performance of a Xenomai installation
 .SH SYNOPSIS
-\fBxeno\-test\fP [\fB\-w\fP \fIworkloads\fP] [\fB\-d\fP \fIdevice\fP] [\fB\-W\fP \fIcommand\fP] [\fB\-p\fP \fIcommand\fP] [\fB\-L\fP [\fB\-N\fP \fIprefix\fP]] [\fB\-s\fP] [\fB\-l\fP \fIsamples\fP] [\fB\-h\fP [\fB\-H\fP \fIcategories\fP] [\fB\-B\fP \fIgranularity\fP]] [\fB\-T\fP \fIseconds\fP [\fB\-q\fP]] [\fB\-\-\fP] [\fIargs\fP] ...
+\fBxeno\-test\fP [\fB\-w\fP \fIworkloads\fP] [\fB\-d\fP \fIdevice\fP] [\fB\-W\fP \fIcommand\fP] [\fB\-p\fP \fIcommand\fP] [\fB\-L\fP [\fB\-N\fP \fIprefix\fP]] [\fB\-m\fP | \fB\-M\fP \fIemail\fP] [\fB\-s\fP] [\fB\-l\fP \fIsamples\fP] [\fB\-h\fP [\fB\-H\fP \fIcategories\fP] [\fB\-B\fP \fIgranularity\fP]] [\fB\-T\fP \fIseconds\fP [\fB\-q\fP]] [\fB\-\-\fP] [\fIargs\fP] ...
 .SH DESCRIPTION
 \fBxeno\-test\fP measures the performance of Xenomai, by executing Xenomai's \fBlatency\fP and \fBklatency\fP tests while generating a high workload on the system.
 The default command that is executed to simulate workload (if no alternate command is specified with a \fB-W\fP \fIcommand\fP option) is:
@@ -29,6 +29,8 @@
 
 If an invalid option is specified, \fBxeno\-test\fP prints out an usage help message and exits.
 
+You are strongly encouraged to use the \fB\-m\fP option, to anonymously help the Xenomai team collecting statistics about Xenomai's performance on the widest range of systems.
+
 .SH OPTIONS
 These following options are specific to \fBxeno\-test\fP:
 .TP
@@ -55,6 +57,12 @@
 \fB\-N\fP \fIprefix\fP
 Prepends \fIprefix\fP\fB\-\fP to the log file name, hence if the \fB\-L\fP option is also specified the log file name is \fIprefix\fP\fB\-test\-\fP\fIkernel_release\fP.
 This option is useful to create the log file in a different directory, by specifying a \fIprefix\fP that starts with the relative path to that directory.
+.TP
+\fB\-m\fP
+Sends the results of the tests to the Xenomai team's email address, to help collecting statistics about Xenomai's performance. The email is sent using the system's mail(1) command.
+.TP
+\fB\-M\fP \fIemail\fP
+Sends the results of the tests to the specified email address. The email is sent using the system's mail(1) command.
 .PP
 The following options are directly passed to the \fBlatency\fP and \fBklatency\fP test commands executed by \fBxeno\-test\fP.
 If no such options are specified, the \fB\-s \-T 10 \-q\fP options are passed by default by \fBxeno\-test\fP.
@@ -111,5 +119,8 @@
 .BR uname (1)
 .SH HISTORY
 .TP
+2006-04-19
+Updated to document the new -m and -M options.
+.TP
 2005-10-19
 Written by Romain Lenglet <rlenglet@domain.hid>

--Boundary-00=_dSbREBTVJsLwwrw--

