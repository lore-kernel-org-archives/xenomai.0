Message-ID: <4580312F.1000907@domain.hid>
Date: Wed, 13 Dec 2006 17:58:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] consolidate testsuite installation
References: <457BDF99.1020405@domain.hid>
	<1165778549.8255.17.camel@domain.hid>		<457CA36C.5060805@domain.hid>
	<1165828053.5025.8.camel@domain.hid> <457D23CA.0@domain.hid>
	<457E6A01.4090500@domain.hid> <457EA179.5070606@domain.hid>
	<457EAACF.3060307@domain.hid> <457EAD7F.2040902@domain.hid>
	<457EC0CE.5040307@domain.hid>
In-Reply-To: <457EC0CE.5040307@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig27BD3A34642BC557EEF56A9A"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig27BD3A34642BC557EEF56A9A
Content-Type: multipart/mixed; boundary="------------090303030508000506010201"

This is a multi-part message in MIME format.
--------------090303030508000506010201
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> At some point in time:
>>> https://mail.gna.org/public/xenomai-help/2006-09/msg00181.html
>>>
>>> I started to use exec_prefix and prefix for separating the binaries,
>>> libraries and script that need to be installed on the target from the=

>>> include files, documentation and xeno-config script that need to be
>>> installed on the host.
>>>
>>
>> OK, appears reasonable, though I cannot asses if it's a standard usage=
=2E
>=20
> Do not know either if it is standard, but it may be useful to some user=
s.
>=20
>> What do you suggest as a replacement for $(pkgdatadir) then?
>> $(exec_prefix)/share/xenomai? Or where to put the testsuite start scri=
pts?
>=20
> I am Ok with anything under $(exec_prefix)...
>=20

Then you should like -v3: now exec_prefix-based.

Jan

--------------090303030508000506010201
Content-Type: text/plain;
 name="reorder-installation-v3.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="reorder-installation-v3.patch"

 scripts/xeno-test.in                  |   13 ++++++++-----
 src/testsuite/cyclic/Makefile.am      |    8 ++++----
 src/testsuite/cyclic/runinfo          |    1 -
 src/testsuite/cyclic/runinfo.in       |    2 +-
 src/testsuite/irqbench/Makefile.am    |   10 +++++-----
 src/testsuite/irqbench/runinfo        |    1 -
 src/testsuite/irqbench/runinfo.in     |    2 +-
 src/testsuite/latency/Makefile.am     |    8 ++++----
 src/testsuite/latency/runinfo         |    1 -
 src/testsuite/latency/runinfo.in      |    2 +-
 src/testsuite/switchbench/Makefile.am |    8 ++++----
 src/testsuite/switchbench/runinfo     |    1 -
 src/testsuite/switchbench/runinfo.in  |    2 +-
 src/testsuite/switchtest/Makefile.am  |    8 ++++----
 src/testsuite/switchtest/runinfo      |    1 -
 src/testsuite/switchtest/runinfo.in   |    2 +-
 16 files changed, 34 insertions(+), 36 deletions(-)
Index: src/testsuite/latency/runinfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/latency/runinfo	(Revision 1947)
+++ src/testsuite/latency/runinfo	(Arbeitskopie)
@@ -1 +0,0 @@
-latency:native+rtdm+timerbench:!./latency;popall:control_c
Index: src/testsuite/latency/runinfo.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/latency/runinfo.in	(Revision 1941)
+++ src/testsuite/latency/runinfo.in	(Arbeitskopie)
@@ -1 +1 @@
-latency:native+rtdm+timerbench:!./latency;popall:control_c
+latency:native+rtdm+timerbench:!@exec_prefix@domain.hid=
_c
Index: src/testsuite/latency/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/latency/Makefile.am	(Revision 1947)
+++ src/testsuite/latency/Makefile.am	(Arbeitskopie)
@@ -1,6 +1,6 @@
-testdir =3D $(exec_prefix)/testsuite/latency
+testdir =3D $(exec_prefix)/share/xenomai/testsuite/latency
=20
-test_PROGRAMS =3D latency
+bin_PROGRAMS =3D latency
=20
 latency_SOURCES =3D latency.c
=20
@@ -17,8 +17,8 @@ latency_LDADD =3D \
=20
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
-	$(INSTALL_DATA) $(srcdir)/runinfo $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \$$*" > $(DESTDIR)$(tes=
tdir)/run
+	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DES=
TDIR)$(testdir)/.runinfo
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" =
> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
=20
 uninstall-local:
Index: src/testsuite/switchbench/runinfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/switchbench/runinfo	(Revision 1947)
+++ src/testsuite/switchbench/runinfo	(Arbeitskopie)
@@ -1 +0,0 @@
-switchbench:native:!./switchbench;popall:control_c
Index: src/testsuite/switchbench/runinfo.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/switchbench/runinfo.in	(Revision 1941)
+++ src/testsuite/switchbench/runinfo.in	(Arbeitskopie)
@@ -1 +1 @@
-switchbench:native:!./switchbench;popall:control_c
+switchbench:native:!@exec_prefix@domain.hid
Index: src/testsuite/switchbench/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/switchbench/Makefile.am	(Revision 1947)
+++ src/testsuite/switchbench/Makefile.am	(Arbeitskopie)
@@ -1,6 +1,6 @@
-testdir =3D $(exec_prefix)/testsuite/switchbench
+testdir =3D $(exec_prefix)/share/xenomai/testsuite/switchbench
=20
-test_PROGRAMS =3D switchbench
+bin_PROGRAMS =3D switchbench
=20
 switchbench_SOURCES =3D switchbench.c
=20
@@ -16,8 +16,8 @@ switchbench_LDADD =3D \
=20
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
-	$(INSTALL_DATA) $(srcdir)/runinfo $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \$$*" > $(DESTDIR)$(tes=
tdir)/run
+	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DES=
TDIR)$(testdir)/.runinfo
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" =
> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
=20
 uninstall-local:
Index: src/testsuite/switchtest/runinfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/switchtest/runinfo	(Revision 1947)
+++ src/testsuite/switchtest/runinfo	(Arbeitskopie)
@@ -1 +0,0 @@
-switchtest:posix+rtdm+switchtest:!./switchtest;popall:control_c
Index: src/testsuite/switchtest/runinfo.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/switchtest/runinfo.in	(Revision 1941)
+++ src/testsuite/switchtest/runinfo.in	(Arbeitskopie)
@@ -1 +1 @@
-switchtest:posix+rtdm+switchtest:!./switchtest;popall:control_c
+switchtest:posix+rtdm+switchtest:!@exec_prefix@domain.hid=
ntrol_c
Index: src/testsuite/switchtest/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/switchtest/Makefile.am	(Revision 1947)
+++ src/testsuite/switchtest/Makefile.am	(Arbeitskopie)
@@ -1,6 +1,6 @@
-testdir =3D $(exec_prefix)/testsuite/switchtest
+testdir =3D $(exec_prefix)/share/xenomai/testsuite/switchtest
=20
-test_PROGRAMS =3D switchtest
+bin_PROGRAMS =3D switchtest
=20
 switchtest_SOURCES =3D switchtest.c
=20
@@ -13,8 +13,8 @@ switchtest_LDADD =3D \
=20
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
-	$(INSTALL_DATA) $(srcdir)/runinfo $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \$$*" > $(DESTDIR)$(tes=
tdir)/run
+	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DES=
TDIR)$(testdir)/.runinfo
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" =
> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
=20
 uninstall-local:
Index: src/testsuite/cyclic/runinfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/cyclic/runinfo	(Revision 1947)
+++ src/testsuite/cyclic/runinfo	(Arbeitskopie)
@@ -1 +0,0 @@
-cyclictest:posix:!./cyclictest -p 99 -n;popall:control_c
Index: src/testsuite/cyclic/runinfo.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/cyclic/runinfo.in	(Revision 1941)
+++ src/testsuite/cyclic/runinfo.in	(Arbeitskopie)
@@ -1 +1 @@
-cyclictest:posix:!./cyclictest -p 99 -n;popall:control_c
+cyclictest:posix:!@exec_prefix@domain.hid -p 99 -n;popall:control_c=

Index: src/testsuite/cyclic/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/cyclic/Makefile.am	(Revision 1947)
+++ src/testsuite/cyclic/Makefile.am	(Arbeitskopie)
@@ -1,6 +1,6 @@
-testdir =3D $(exec_prefix)/testsuite/cyclic
+testdir =3D $(exec_prefix)/share/xenomai/testsuite/cyclic
=20
-test_PROGRAMS =3D cyclictest
+bin_PROGRAMS =3D cyclictest
=20
 cyclictest_SOURCES =3D cyclictest.c
=20
@@ -13,8 +13,8 @@ cyclictest_LDADD =3D \
=20
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
-	$(INSTALL_DATA) $(srcdir)/runinfo $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \$$*" > $(DESTDIR)$(tes=
tdir)/run
+	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DES=
TDIR)$(testdir)/.runinfo
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" =
> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
=20
 uninstall-local:
Index: src/testsuite/irqbench/runinfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/irqbench/runinfo	(Revision 1947)
+++ src/testsuite/irqbench/runinfo	(Arbeitskopie)
@@ -1 +0,0 @@
-irqloop:posix+rtdm+irqbench:!./irqloop;popall:control_c
Index: src/testsuite/irqbench/runinfo.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/irqbench/runinfo.in	(Revision 1941)
+++ src/testsuite/irqbench/runinfo.in	(Arbeitskopie)
@@ -1 +1 @@
-irqloop:posix+rtdm+irqbench:!./irqloop;popall:control_c
+irqloop:posix+rtdm+irqbench:!@exec_prefix@domain.hid
Index: src/testsuite/irqbench/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/testsuite/irqbench/Makefile.am	(Revision 1947)
+++ src/testsuite/irqbench/Makefile.am	(Arbeitskopie)
@@ -1,9 +1,9 @@
-testdir =3D $(exec_prefix)/testsuite/irqbench
+testdir =3D $(exec_prefix)/share/xenomai/testsuite/irqbench
 
-test_PROGRAMS =3D irqloop
+bin_PROGRAMS =3D irqloop
=20
 if XENO_TARGET_ARCH_I386
-test_PROGRAMS +=3D irqbench
+bin_PROGRAMS +=3D irqbench
 endif
=20
=20
@@ -33,8 +33,8 @@ irqbench_LDFLAGS =3D $(XENO_USER_LDFLAGS)
=20
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
-	$(INSTALL_DATA) $(srcdir)/runinfo $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \$$*" > $(DESTDIR)$(tes=
tdir)/run
+	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DES=
TDIR)$(testdir)/.runinfo
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" =
> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
=20
 uninstall-local:
Index: scripts/xeno-test.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- scripts/xeno-test.in	(Revision 1947)
+++ scripts/xeno-test.in	(Arbeitskopie)
@@ -4,6 +4,9 @@
 # If you want to test it this way, do: sh xeno-test
 # BusyBox >=3D 1.1.3 with a make defconfig should provide all needed app=
lets.
=20
+prefix=3D"@prefix@"
+pkgdatadir=3D"@exec_prefix@domain.hid"
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

--------------090303030508000506010201--

--------------enig27BD3A34642BC557EEF56A9A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgDEvniDOoMHTA+kRAsobAJ9l7d6otq1w2c/cVxQ4JsVPrArpxACeI7ra
o7JwIFnM30ZAlXIPx3P2c2o=
=3cTN
-----END PGP SIGNATURE-----

--------------enig27BD3A34642BC557EEF56A9A--

