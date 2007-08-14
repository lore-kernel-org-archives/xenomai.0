From: Paul <paul_c@domain.hid>
Date: Tue, 14 Aug 2007 16:03:23 +0100
References: <46C0F888.5050405@domain.hid>
In-Reply-To: <46C0F888.5050405@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7QcwG0SfJD3GB3B"
Message-Id: <200708141603.23540.paul_c@domain.hid>
Subject: Re: [Xenomai-help] svn-buildpackage not working?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_7QcwG0SfJD3GB3B
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi Bill

On Tuesday 14 August 2007 01:34, Bill Gatliff wrote:
> Guys:
>
>
> Trying to put together a Xenomai package for my Debian "testing" PC.  It
> hangs here:
>
> # svn co ...; cd xenomai
> # svn-buildpackage -us -uc -rfakeroot
> ...
> rm: cannot remove /root/xenomai/debian/tmp//usr/include/xenomai: Is a
> directory
> make[4]: *** [install-data-local] Error 1
>
>
> Any ideas?

I reported this problem a couple of days ago on Xenomai-core along with a 
patch. FYI, same patch attached - You'll need to run scripts/bootstrap (and 
use --svn-ignore with svn-buildpackage).


Regards, Paul.




--Boundary-00=_7QcwG0SfJD3GB3B
Content-Type: text/x-diff;
  charset="us-ascii";
  name="includedir_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="includedir_fix.diff"

--- include/Makefile.am	(revision 2902)
+++ include/Makefile.am	(working copy)
@@ -1,4 +1,4 @@
-includedir = $(prefix)/include
+#includedir = $(prefix)/include
 
 include_HEADERS = \
 	rtdk.h
Index: sim/include/Makefile.am
===================================================================
--- sim/include/Makefile.am	(revision 2902)
+++ sim/include/Makefile.am	(working copy)
@@ -1,3 +1,3 @@
-includedir = $(prefix)/include/asm-sim
+includesubdir = $(prefix)/include/asm-sim
 
-nodist_include_HEADERS=$(CONFIG_HEADER)
+nodist_includesub_HEADERS=$(CONFIG_HEADER)
Index: sim/skins/posix/Makefile.am
===================================================================
--- sim/skins/posix/Makefile.am	(revision 2902)
+++ sim/skins/posix/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
 vpath %.c $(top_srcdir)/../ksrc/skins/posix
 
-includedir = $(prefix)/include/asm-sim
+includesubdir = $(prefix)/include/asm-sim
 
 CC = $(top_builddir)/gcic/gcic
 
@@ -42,7 +42,7 @@ nodist_libposix_sim_a_SOURCES = \
 	shm.c \
 	module.c
 
-include_HEADERS = \
+includesub_HEADERS = \
 	posix_overrides.h
 
 SUBDIRS = . testsuite demos

--Boundary-00=_7QcwG0SfJD3GB3B--

