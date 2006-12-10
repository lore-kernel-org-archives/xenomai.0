Message-ID: <457BDF99.1020405@domain.hid>
Date: Sun, 10 Dec 2006 11:21:13 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig26A31922390F26491CA3FD4E"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] consolidate testsuite installation
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig26A31922390F26491CA3FD4E
Content-Type: multipart/mixed; boundary="------------050909020202090802070700"

This is a multi-part message in MIME format.
--------------050909020202090802070700
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The only part of the Xenomai user-space package not yet following
standard installation rules is the testsuite. It gets installed to
$prefix/testsuite, by default /usr/testsuite. The attached patch is an
approach to overcome this unusual layout.

My suggestion, realised by this patch, is to push run scripts and
=2Eruninfo files to $prefix/share/xenomai/testsuite/<test>/ while
installing the binaries now also to $prefix/bin. This allows both the
invocation and cleanup via run scripts (i.e. xeno-load) and the simple
direct call of the tests if all required modules are already loaded.
Additionally, the patch also enables run script invocation without prior
cd to the containing directory.

Unless no objections arise, I would like to have this in upcoming 2.3
already (can make life of package builders easier).

Jan

--------------050909020202090802070700
Content-Type: text/plain;
 name="reorder-installation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="reorder-installation.patch"

Index: src/testsuite/latency/runinfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/latency/runinfo	(Revision 1941)
+++ src/testsuite/latency/runinfo	(Arbeitskopie)
@@ -1 +1 @@
-latency:native+rtdm+timerbench:!./latency;popall:control_c
+latency:native+rtdm+timerbench:!latency;popall:control_c
Index: src/testsuite/latency/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/latency/Makefile.am	(Revision 1941)
+++ src/testsuite/latency/Makefile.am	(Arbeitskopie)
@@ -1,6 +1,6 @@
-testdir =3D $(exec_prefix)/testsuite/latency
+testdir =3D $(pkgdatadir)/testsuite/latency
=20
-test_PROGRAMS =3D latency
+bin_PROGRAMS =3D latency
=20
 latency_SOURCES =3D latency.c
=20
@@ -18,7 +18,7 @@ latency_LDADD =3D \
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
 	$(INSTALL_DATA) $(srcdir)/runinfo $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \$$*" > $(DESTDIR)$(tes=
tdir)/run
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" =
> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
=20
 uninstall-local:
Index: src/testsuite/switchbench/runinfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/switchbench/runinfo	(Revision 1941)
+++ src/testsuite/switchbench/runinfo	(Arbeitskopie)
@@ -1 +1 @@
-switchbench:native:!./switchbench;popall:control_c
+switchbench:native:!switchbench;popall:control_c
Index: src/testsuite/switchbench/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/switchbench/Makefile.am	(Revision 1941)
+++ src/testsuite/switchbench/Makefile.am	(Arbeitskopie)
@@ -1,6 +1,6 @@
-testdir =3D $(exec_prefix)/testsuite/switchbench
+testdir =3D $(pkgdatadir)/testsuite/switchbench
=20
-test_PROGRAMS =3D switchbench
+bin_PROGRAMS =3D switchbench
=20
 switchbench_SOURCES =3D switchbench.c
=20
@@ -17,7 +17,7 @@ switchbench_LDADD =3D \
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
 	$(INSTALL_DATA) $(srcdir)/runinfo $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \$$*" > $(DESTDIR)$(tes=
tdir)/run
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" =
> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
=20
 uninstall-local:
Index: src/testsuite/switchtest/runinfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/switchtest/runinfo	(Revision 1941)
+++ src/testsuite/switchtest/runinfo	(Arbeitskopie)
@@ -1 +1 @@
-switchtest:posix+rtdm+switchtest:!./switchtest;popall:control_c
+switchtest:posix+rtdm+switchtest:!switchtest;popall:control_c
Index: src/testsuite/switchtest/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/switchtest/Makefile.am	(Revision 1941)
+++ src/testsuite/switchtest/Makefile.am	(Arbeitskopie)
@@ -1,6 +1,6 @@
-testdir =3D $(exec_prefix)/testsuite/switchtest
+testdir =3D $(pkgdatadir)/testsuite/switchtest
=20
-test_PROGRAMS =3D switchtest
+bin_PROGRAMS =3D switchtest
=20
 switchtest_SOURCES =3D switchtest.c
=20
@@ -14,7 +14,7 @@ switchtest_LDADD =3D \
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
 	$(INSTALL_DATA) $(srcdir)/runinfo $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \$$*" > $(DESTDIR)$(tes=
tdir)/run
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" =
> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
=20
 uninstall-local:
Index: src/testsuite/cyclic/runinfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/cyclic/runinfo	(Revision 1941)
+++ src/testsuite/cyclic/runinfo	(Arbeitskopie)
@@ -1 +1 @@
-cyclictest:posix:!./cyclictest -p 99 -n;popall:control_c
+cyclictest:posix:!cyclictest -p 99 -n;popall:control_c
Index: src/testsuite/cyclic/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/cyclic/Makefile.am	(Revision 1941)
+++ src/testsuite/cyclic/Makefile.am	(Arbeitskopie)
@@ -1,6 +1,6 @@
-testdir =3D $(exec_prefix)/testsuite/cyclic
+testdir =3D $(pkgdatadir)/testsuite/cyclic
=20
-test_PROGRAMS =3D cyclictest
+bin_PROGRAMS =3D cyclictest
=20
 cyclictest_SOURCES =3D cyclictest.c
=20
@@ -14,7 +14,7 @@ cyclictest_LDADD =3D \
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
 	$(INSTALL_DATA) $(srcdir)/runinfo $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \$$*" > $(DESTDIR)$(tes=
tdir)/run
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" =
> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
=20
 uninstall-local:
Index: src/testsuite/irqbench/runinfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/irqbench/runinfo	(Revision 1941)
+++ src/testsuite/irqbench/runinfo	(Arbeitskopie)
@@ -1 +1 @@
-irqloop:posix+rtdm+irqbench:!./irqloop;popall:control_c
+irqloop:posix+rtdm+irqbench:!irqloop;popall:control_c
Index: src/testsuite/irqbench/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/irqbench/Makefile.am	(Revision 1941)
+++ src/testsuite/irqbench/Makefile.am	(Arbeitskopie)
@@ -1,9 +1,9 @@
-testdir =3D $(exec_prefix)/testsuite/irqbench
+testdir =3D $(pkgdatadir)/testsuite/irqbench
=20
-test_PROGRAMS =3D irqloop
+bin_PROGRAMS =3D irqloop
=20
 if XENO_TARGET_ARCH_I386
-test_PROGRAMS +=3D irqbench
+bin_PROGRAMS +=3D irqbench
 endif
=20
=20
@@ -34,7 +34,7 @@ irqbench_LDFLAGS =3D $(XENO_USER_LDFLAGS)
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
 	$(INSTALL_DATA) $(srcdir)/runinfo $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \$$*" > $(DESTDIR)$(tes=
tdir)/run
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" =
> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
=20
 uninstall-local:
Index: scripts/xeno-load.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- scripts/xeno-load.in	(Revision 1941)
+++ scripts/xeno-load.in	(Arbeitskopie)
@@ -236,9 +236,9 @@ while test -n "$target_info" ; do
 	set -- $e
 	test $verbose =3D 1 && echo "+ spawning command ($* $cmdargs)"
 	if test $waitflag =3D 1; then
-           $suflag $* $cmdargs
+           PATH=3D$PATH:$exec_prefix/bin $suflag $* $cmdargs
         else
-           $suflag $* $cmdargs &
+           PATH=3D$PATH:$exec_prefix/bin $suflag $* $cmdargs &
 	   children_pids=3D"$! $children_pids"
 	fi
 	;;
Index: scripts/xeno-test.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- scripts/xeno-test.in	(Revision 1941)
+++ scripts/xeno-test.in	(Arbeitskopie)
@@ -4,6 +4,9 @@
 # If you want to test it this way, do: sh xeno-test
 # BusyBox >=3D 1.1.3 with a make defconfig should provide all needed app=
lets.
=20
+prefix=3D"@prefix@"
+pkgdatadir=3D"@datadir@domain.hid"
+
 myusage() {
     cat >&1 <<EOF
 xeno-test [options]
@@ -195,24 +198,24 @@ run_w_load() {
     loudly generate_loads $workload
     boxstatus
     (
-        cd `dirname $0`/../testsuite/latency
+        cd $pkgdatadir/testsuite/latency
 	loudly ./run -- $XENOT_LATENCY $opts -t0 '# latency'
 	loudly ./run -- $XENOT_LATENCY $opts -t1 '# latency'
 	loudly ./run -- $XENOT_LATENCY $opts -t2 '# latency'
     )
-    (	cd `dirname $0`/../testsuite/switchtest
+    (	cd $pkgdatadir/testsuite/switchtest
 	loudly ./run -- -T 120 $XENOT_SWITCHTEST '# switchtest'
     )
-    (	cd `dirname $0`/../testsuite/switchbench
+    (	cd $pkgdatadir/testsuite/switchbench
 	loudly ./run -- -h $XENOT_SWITCHBENCH '# switchbench'
     )
-    (	cd `dirname $0`/../testsuite/cyclic
+    (	cd $pkgdatadir/testsuite/cyclic
 	loudly ./run -- -p 10 -n -l 1000 $XENOT_CYCLIC '# cyclictest'
     )
=20
     if [ "$XENOT_IRQBENCH" !=3D "" ] ; then
 	(
-	    cd `dirname $0`/../testsuite/irqbench
+	    cd $pkgdatadir/testsuite/irqbench
 	    loudly ./run -- -P 10 $XENOT_IRQBENCH -t0 '# irqbench user'
 	    loudly ./run -- -P 10 $XENOT_IRQBENCH -t1 '# irqbench kernel'
 	    loudly ./run -- -P 10 $XENOT_IRQBENCH -t2 '# irqbench irq-handler'

--------------050909020202090802070700--

--------------enig26A31922390F26491CA3FD4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFe9+dniDOoMHTA+kRAo9oAJ47OSYlu9JSAH8IOYOXEwGnTWHLqgCeMYnP
pV3Wir88hb6JZ9qlG3apChk=
=tQqM
-----END PGP SIGNATURE-----

--------------enig26A31922390F26491CA3FD4E--

