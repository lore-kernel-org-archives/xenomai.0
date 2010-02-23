Message-ID: <4B8407B5.10109@domain.hid>
Date: Tue, 23 Feb 2010 17:52:05 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B6E8167.6010907@domain.hid>
	<4B76B7F2.2050303@domain.hid>	<4B76C045.2070602@domain.hid>
	<1266140329.27019.17.camel@domain.hid>
In-Reply-To: <1266140329.27019.17.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE3FAB4B7873AA9F7AB61BC6A"
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE3FAB4B7873AA9F7AB61BC6A
Content-Type: multipart/mixed;
 boundary="------------040309090903040105030600"

This is a multi-part message in MIME format.
--------------040309090903040105030600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Am 14.02.2010 10:38, schrieb Philippe Gerum:
>=20
> <snip>
> In the future, maybe we could simply provide a wrapper script accepting=

> sub-commands, such as "xeno latency, xeno sigtest" etc, to be put
> into /usr/bin by distros, which would hide the actual location of those=

> binaries?
>
> In any case, thanks for your work so far. We probably need to discuss
> the packaging issues on this list, so that we get both consistency and
> usability in the future.
>=20
> Gilles and Roland, if this is fine with you, I'll handle the liaison
> role with upstream packagers, so please CC me explicitly on those mails=
=2E
> We'll sort out this issue, it doesn't look that bad anyway.

Roland added a xeno wrapper to the debian.org xenomai package 2.5.1-3.

I synced now the debian/ directories from debian.org and xenomai.org:
 - For debian.org I sent patches to the Debian bugtracker [1] [2].
   Another patch for dpkg-cross support [3] I sent to Roland privately.
 - For xenomai.org I attached patches to this mail (against -2.5.git).

If both parties apply the patches the debian directories are in sync,
except some minor differences in the debian/control file, see patch
do-not-commit-please.patch. I would like to keep these changes out so
that the xenomai.org packages are compatible with Debian 5.0 Lenny.
The debian.org packages are for Debian 6.0 Squeeze.

Thanks
kisda

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D571099
[2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D571104
[3] http://git.xenomai.org/?p=3Dxenomai-2.5.git;a=3Dcommitdiff;h=3D5bcd18=
f714f4cbeaaac0cc4a08e6c9f375aa3b77

--------------040309090903040105030600
Content-Type: text/plain;
 name="0001-debian-copyright-fix-typo-and-add-project-url.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-debian-copyright-fix-typo-and-add-project-url.patch"

=46rom f8bfbe147654f9eb240b0e94d774185940444b8d Mon Sep 17 00:00:00 2001
From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Tue, 23 Feb 2010 13:06:52 +0100
Subject: [PATCH] debian: copyright: fix typo and add project url

---
 debian/copyright |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/debian/copyright b/debian/copyright
index 683e276..b3980df 100644
--- a/debian/copyright
+++ b/debian/copyright
@@ -3,6 +3,8 @@ On: Sat Mar 3 12:00 GMT 2007
=20
 The primary author of the upstream package is Philippe Gerum.
=20
+It was downloaded from http://www.xenomai.org/
+
 Copyright (C) 2001,2002,2003,2004,2005,2006,2007,2008 Philippe Gerum <rp=
m@domain.hid>.
 Copyright (C) 2005 Dmitry Adamushko <dmitry.adamushko@domain.hid>
 Copyright (C) 2001,2003,2004,2005,2006,2008 Gilles Chanteperdrix <gilles=
=2Echanteperdrix@domain.hid>
@@ -11,7 +13,7 @@ Copyright (C) 2006 Wolfgang Grandegger <wg@domain.hid=
om>
=20
 License:
=20
-Xenmai is licensed under GPL version 2, the user space libraries are LGP=
L
+Xenomai is licensed under GPL version 2, the user space libraries are LG=
PL
 version 2.1.
 On Debian systems, the complete texts of the GNU General Public License =
v2
 and the GNU Lesser General Public License v2 can be found in the file
--=20
1.5.6.5


--------------040309090903040105030600
Content-Type: text/plain;
 name="0002-debian-libxenomai1-sync-from-debian.org.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0002-debian-libxenomai1-sync-from-debian.org.patch"

=46rom d3827b9eda17d8332748767b2ae5282f5fcb283d Mon Sep 17 00:00:00 2001
From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Tue, 23 Feb 2010 16:21:23 +0100
Subject: [PATCH] debian: libxenomai1: sync from debian.org

---
 debian/libxenomai1.lintian  |    2 +-
 debian/libxenomai1.postinst |    2 +-
 debian/libxenomai1.postrm   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/debian/libxenomai1.lintian b/debian/libxenomai1.lintian
index 42a4149..0f6a514 100644
--- a/debian/libxenomai1.lintian
+++ b/debian/libxenomai1.lintian
@@ -1,2 +1,2 @@
 # no contained shared library names refer to "xenomai", therefore own na=
me
-libxenomai1: package-name-doesnt-match-sonames libnative1 libpsos0 libpt=
hread-rt1 librtai0 librtdk0 librtdm1 libuitron0 libvrtx0 libvxworks1
+libxenomai1: package-name-doesnt-match-sonames libanalogy1 libnative3 li=
bpsos0 libpthread-rt1 librtai0 librtdk0 librtdm1 libuitron0 libvrtx0 libv=
xworks1
diff --git a/debian/libxenomai1.postinst b/debian/libxenomai1.postinst
index dfdaa46..8afc6fc 100644
--- a/debian/libxenomai1.postinst
+++ b/debian/libxenomai1.postinst
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/sh -e
=20
 rm -f /etc/udev/rules.d/xenomai.rules
 ln -sf ../xenomai.rules /etc/udev/rules.d/xenomai.rules
diff --git a/debian/libxenomai1.postrm b/debian/libxenomai1.postrm
index a269ef5..3559eb5 100644
--- a/debian/libxenomai1.postrm
+++ b/debian/libxenomai1.postrm
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/sh -e
=20
 case "$1" in
   purge | remove)
--=20
1.5.6.5


--------------040309090903040105030600
Content-Type: text/plain;
 name="0003-debian-linux-patch-xenomai.README.Debian-sync-from.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0003-debian-linux-patch-xenomai.README.Debian-sync-from.patc";
 filename*1="h"

=46rom c05d1fbfdd9360785b82be3d4437fe2b0e39b647 Mon Sep 17 00:00:00 2001
From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Tue, 23 Feb 2010 16:28:39 +0100
Subject: [PATCH] debian: linux-patch-xenomai.README.Debian: sync from deb=
ian.org

---
 debian/linux-patch-xenomai.README.Debian |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/debian/linux-patch-xenomai.README.Debian b/debian/linux-patc=
h-xenomai.README.Debian
index a6aaa6b..3304bf5 100644
--- a/debian/linux-patch-xenomai.README.Debian
+++ b/debian/linux-patch-xenomai.README.Debian
@@ -4,12 +4,14 @@ Xenomai kernel patches in Debian
 With this package, you can patch and build kernels suitable for usage wi=
th
 Xenomai. This can be done with, e.g.:
=20
-# cd /usr/src/linux-source-2.6.24
-# fakeroot make-kpkg --initrd --added-patches xenomai kernel_image
+# cd /usr/src/linux-source-2.6.32
+# /usr/src/kernel-patches/i386/apply/xenomai
+# make config
+# make-kpkg --rootcmd fakeroot --initrd kernel_image
=20
 This is intended for vanilla and Debian kernel sources.
=20
 NOTE: In the kernel config, PARAVIRT should be turned off for Xenomai ke=
rnels
       to compile successfully.
=20
- -- Roland Stigge <stigge@domain.hid>, Fri, 11 Apr 2008 09:02:28 +0200
+ -- Roland Stigge <stigge@domain.hid>, Sun, 14 Feb 2010 15:14:40 +0100
--=20
1.5.6.5


--------------040309090903040105030600
Content-Type: text/plain;
 name="0004-debian-Build-Depends-debhelper-7.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0004-debian-Build-Depends-debhelper-7.patch"

=46rom 4b0484a5d7c20f13276b8d609f5bc4dd55b7563e Mon Sep 17 00:00:00 2001
From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Tue, 23 Feb 2010 16:42:40 +0100
Subject: [PATCH] debian: Build-Depends: debhelper (>=3D 7)

---
 debian/compat  |    2 +-
 debian/control |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/debian/compat b/debian/compat
index 7ed6ff8..7f8f011 100644
--- a/debian/compat
+++ b/debian/compat
@@ -1 +1 @@
-5
+7
diff --git a/debian/control b/debian/control
index e7fdfef..ab4636d 100644
--- a/debian/control
+++ b/debian/control
@@ -2,7 +2,7 @@ Source: xenomai
 Section: devel
 Priority: extra
 Maintainer: Roland Stigge <stigge@domain.hid>
-Build-Depends: debhelper (>=3D 5), dh-kpatches, findutils (>=3D 4.2.28)
+Build-Depends: debhelper (>=3D 7), dh-kpatches, findutils (>=3D 4.2.28)
 Standards-Version: 3.8.0
 Homepage: http://www.xenomai.org/
=20
--=20
1.5.6.5


--------------040309090903040105030600
Content-Type: text/plain;
 name="0005-debian-wrapper-script-usr-bin-xeno-to-call-executa.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0005-debian-wrapper-script-usr-bin-xeno-to-call-executa.patc";
 filename*1="h"

=46rom 3f67cba6b3789ec1bbcda2678f28fe47dee7e9de Mon Sep 17 00:00:00 2001
From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Tue, 23 Feb 2010 17:07:13 +0100
Subject: [PATCH] debian: wrapper script /usr/bin/xeno to call executables=
 in /usr/lib/xenomai/

---
 debian/rules                    |    9 ++++++---
 debian/xeno                     |   10 ++++++++++
 debian/xeno.1                   |   17 +++++++++++++++++
 debian/xenomai-runtime.dirs     |    1 +
 debian/xenomai-runtime.manpages |    1 +
 5 files changed, 35 insertions(+), 3 deletions(-)
 create mode 100644 debian/xeno
 create mode 100644 debian/xeno.1
 create mode 100644 debian/xenomai-runtime.dirs
 create mode 100644 debian/xenomai-runtime.manpages

diff --git a/debian/rules b/debian/rules
index fa93f62..ee6cde7 100755
--- a/debian/rules
+++ b/debian/rules
@@ -87,13 +87,16 @@ clean:
 install: build
 	dh_testdir
 	dh_testroot
-	dh_clean -k
+	dh_prep
 	dh_installdirs
 	$(MAKE) install DESTDIR=3D$(CURDIR)/debian/tmp/
 	dh_install --sourcedir=3D$(CURDIR)/debian/tmp
 	# xeno-config should be only in libxenomai-dev
 	rm -f $(CURDIR)/debian/xenomai-runtime/usr/bin/xeno-config
 	rm -f $(CURDIR)/debian/xenomai-runtime/usr/share/man/man1/xeno-config.1=

+	mv $(CURDIR)/debian/xenomai-runtime/usr/bin/* \
+		$(CURDIR)/debian/xenomai-runtime/usr/lib/xenomai/
+	install -m 755 debian/xeno $(CURDIR)/debian/xenomai-runtime/usr/bin/xen=
o
 	for f in $(CURDIR)/ksrc/nucleus/udev/*.rules ; do \
 	    cat $$f >> $(CURDIR)/debian/libxenomai1/etc/udev/xenomai.rules ; \
 	done
@@ -108,8 +111,8 @@ binary-indep: build install
 	dh_testdir -i
 	dh_testroot -i
 	dh_installdocs -i -A CREDITS README.INSTALL TROUBLESHOOTING
-	dh_installchangelogs -i
 	dh_link -i
+	dh_installchangelogs -i
 	dh_strip -i
 	dh_compress -i -X.pdf
 	dh_fixperms -i
@@ -131,8 +134,8 @@ binary-arch: build install
 	dh_testroot -s
 	dh_installman -s
 	dh_installdocs -s -A CREDITS README.INSTALL TROUBLESHOOTING
-	dh_installchangelogs -s
 	dh_link -s
+	dh_installchangelogs -s
 	dh_strip -s
 	dh_compress -s
 	dh_fixperms -s
diff --git a/debian/xeno b/debian/xeno
new file mode 100644
index 0000000..721914e
--- /dev/null
+++ b/debian/xeno
@@ -0,0 +1,10 @@
+#!/bin/sh
+#
+# Wrapper script to call original /usr/bin executables from /usr/lib/xen=
omai
+#
+# e.g. "xeno latency"
+#
+
+BINDIR=3D/usr/lib/xenomai
+
+"$BINDIR/$@"
diff --git a/debian/xeno.1 b/debian/xeno.1
new file mode 100644
index 0000000..cec55b1
--- /dev/null
+++ b/debian/xeno.1
@@ -0,0 +1,17 @@
+.TH xeno 1 "14 February 2010" "Version 1" "Xeno Manual"
+
+.SH NAME
+xeno \- Wrapper for Xenomai executables
+
+.SH SYNOPSIS
+xeno [xenomai command]
+
+.SH DESCRIPTION
+.B xeno
+is a wrapper script that makes the common Xenomai userland executables
+available to the user because they don't reside in /usr/bin anymore to p=
revent
+filename collisions.
+
+.SH AUTHOR
+The wrapper script xeno and this manpage were initially written by Rolan=
d
+Stigge <stigge@domain.hid> for the Debian project but may be used elsewhe=
re.
diff --git a/debian/xenomai-runtime.dirs b/debian/xenomai-runtime.dirs
new file mode 100644
index 0000000..6bea564
--- /dev/null
+++ b/debian/xenomai-runtime.dirs
@@ -0,0 +1 @@
+usr/lib/xenomai
diff --git a/debian/xenomai-runtime.manpages b/debian/xenomai-runtime.man=
pages
new file mode 100644
index 0000000..9555541
--- /dev/null
+++ b/debian/xenomai-runtime.manpages
@@ -0,0 +1 @@
+debian/xeno.1
--=20
1.5.6.5


--------------040309090903040105030600
Content-Type: text/plain;
 name="0006-debian-changelog-sync-from-debian.org.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0006-debian-changelog-sync-from-debian.org.patch"

=46rom 43b82d769fc78a7d397eb80ff7c90dfd9f10db96 Mon Sep 17 00:00:00 2001
From: Stefan Kisdaroczi <kisda@domain.hid>
Date: Tue, 23 Feb 2010 17:12:23 +0100
Subject: [PATCH] debian: changelog: sync from debian.org

---
 debian/changelog |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/debian/changelog b/debian/changelog
index b43955d..45736a4 100644
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,3 +1,43 @@
+xenomai (2.5.1-3) unstable; urgency=3Dlow
+
+  * xenomai-runtime: Replaced "xenomai-" prefixed executables with
+    wrapper script /usr/bin/xeno to call original executables from
+    /usr/lib/xenomai/, e.g. "xeno latency"
+  * debian/prepare-patch.sh: Synchronized from upstream (Closes: #569721=
)
+  * Removed 2.6.24 adeos-ipipe patches
+  * Enabled patching/use of Debian's kernel (2.6.32)
+
+ -- Roland Stigge <stigge@domain.hid>  Sun, 14 Feb 2010 13:35:15 +0100
+
+xenomai (2.5.1-2) unstable; urgency=3Dlow
+
+  * xenomai-runtime: Renamed /usr/bin/* to /usr/bin/xenomai-* (Closes: #=
569357)
+
+ -- Roland Stigge <stigge@domain.hid>  Fri, 12 Feb 2010 21:18:00 +0100
+
+xenomai (2.5.1-1) unstable; urgency=3Dlow
+
+  * New upstream release (Closes: #553334, #566566, #536731)
+  * debian/control: Standards-Version: 3.8.4
+
+ -- Roland Stigge <stigge@domain.hid>  Sat, 06 Feb 2010 11:05:50 +0100
+
+xenomai (2.4.8-2) unstable; urgency=3Dlow
+
+  * debian/libxenomai1.{postinst,postrm}: "set -e"
+  * debian/control: linux-patch-xenomai: Section: kernel
+
+ -- Roland Stigge <stigge@domain.hid>  Wed, 24 Jun 2009 17:47:41 +0200
+
+xenomai (2.4.8-1) unstable; urgency=3Dlow
+
+  * New upstream release
+    - includes limits.h include as in patch from Peter Green (Closes: #5=
27654)
+  * debian/control:
+    - Standards-Version: 3.8.2
+
+ -- Roland Stigge <stigge@domain.hid>  Mon, 22 Jun 2009 22:50:23 +0200
+
 xenomai (2.4.4-3) unstable; urgency=3Dlow
=20
   * debian/rules: Fixed concurrent ./configure + make runs, thanks to Al=
bin
--=20
1.5.6.5


--------------040309090903040105030600
Content-Type: text/plain;
 name="do-not-commit-please.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="do-not-commit-please.patch"

--- xenomai-2.5.1.orig/debian/control	2010-02-23 16:40:07.000000000 +0100=

+++ xenomai-2.5.1/debian/control	2010-02-23 14:34:06.000000000 +0100
@@ -3,13 +3,13 @@ Section: devel
 Priority: extra
 Maintainer: Roland Stigge <stigge@domain.hid>
 Build-Depends: debhelper (>=3D 7), dh-kpatches, findutils (>=3D 4.2.28)
-Standards-Version: 3.8.0
+Standards-Version: 3.8.4
 Homepage: http://www.xenomai.org/
=20
 Package: xenomai-runtime
 Section: devel
 Architecture: amd64 arm armeb armel i386 powerpc
-Depends: ${shlibs:Depends}
+Depends: ${shlibs:Depends}, ${misc:Depends}
 Suggests: linux-patch-xenomai, xenomai-doc
 Replaces: xenomai
 Conflicts: xenomai
@@ -25,9 +25,9 @@ Description: Xenomai runtime utilities
  realtime system.
=20
 Package: linux-patch-xenomai
-Section: devel
+Section: kernel
 Architecture: all
-Depends: ${kpatch:Depends}
+Depends: ${kpatch:Depends}, ${misc:Depends}
 Suggests: xenomai, linux-source-2.6, kernel-package
 Description: Linux kernel patches for Xenomai
  Xenomai is a real-time development framework cooperating with the Linux=

@@ -48,7 +48,7 @@ Description: Linux kernel patches for Xe
 Package: libxenomai1
 Section: libs
 Architecture: amd64 arm armeb armel i386 powerpc
-Depends: ${shlibs:Depends}
+Depends: ${shlibs:Depends}, ${misc:Depends}
 Suggests: linux-patch-xenomai, xenomai-doc
 Replaces: xenomai
 Conflicts: xenomai
@@ -65,7 +65,7 @@ Description: Shared libraries for Xenoma
 Package: libxenomai-dev
 Section: libdevel
 Architecture: amd64 arm armeb armel i386 powerpc
-Depends: libxenomai1 (=3D ${binary:Version})
+Depends: libxenomai1 (=3D ${binary:Version}), ${misc:Depends}
 Suggests: linux-patch-xenomai, xenomai-doc
 Replaces: xenomai
 Conflicts: xenomai
@@ -83,7 +83,7 @@ Description: Headers and static libs for
 Package: xenomai-doc
 Section: doc
 Architecture: all
-Depends:
+Depends: ${misc:Depends}
 Suggests: xenomai
 Conflicts: xenomai-docs
 Replaces: xenomai-docs

--------------040309090903040105030600--

--------------enigE3FAB4B7873AA9F7AB61BC6A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLhAe1IPTw9rIdn6oRAgIcAJ9oOnRM1qYwuMCznpLrb7xNyFuA2QCdGcLW
L04ezu9bsH2Sz2unKDYCWQU=
=DnKD
-----END PGP SIGNATURE-----

--------------enigE3FAB4B7873AA9F7AB61BC6A--

