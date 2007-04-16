From: Paul <paul_c@domain.hid>
Date: Mon, 16 Apr 2007 23:56:29 +0100
References: <1176585372.15994.14.camel@domain.hid>
	<17955.64120.90606.670609@domain.hid>
In-Reply-To: <17955.64120.90606.670609@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_d8/IG+Zevo0k//U"
Message-Id: <200704162356.29116.paul_c@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Support EABI enabled kernels on ARM
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

--Boundary-00=_d8/IG+Zevo0k//U
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi Gilles

On Monday 16 April 2007 23:36, Gilles Chanteperdrix wrote:
> And by the way, I am running Debian Etch, and its
> version of autotools seems to complain that we do not use datarootdir in
> xeno-config.in...

Attached, a trivial patch to fix the datarootdir warning.


Regards, Paul.




--Boundary-00=_d8/IG+Zevo0k//U
Content-Type: text/x-diff;
  charset="us-ascii";
  name="datarootdir_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="datarootdir_fix.patch"

Index: scripts/xeno-config.in
===================================================================
--- scripts/xeno-config.in	(revision 2393)
+++ scripts/xeno-config.in	(working copy)
@@ -4,6 +4,7 @@ staging=${DESTDIR}
 prefix="@prefix@"
 exec_prefix="@exec_prefix@"
 libdir="@libdir@"
+datarootdir="@datarootdir@"
 datadir="@datadir@"
 pkgdatadir="${datadir}/@PACKAGE@"
 includedir="@includedir@"
@@ -20,7 +21,7 @@ XENO_POSIX_WRAPPERS="${staging}${libdir}
 XENO_POSIX_FAST_WRAPPING="@LD_FILE_OPTION@"
 XENO_LIBRARY_DIR="${staging}${libdir}"
 
-unset prefix exec_prefix libdir datadir pkgdatadir includedir
+unset prefix exec_prefix libdir datadir datarootdir pkgdatadir includedir
 
 usage ()
 {

--Boundary-00=_d8/IG+Zevo0k//U--

