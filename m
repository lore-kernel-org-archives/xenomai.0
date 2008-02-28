Message-ID: <47C71CF6.1040701@domain.hid>
Date: Thu, 28 Feb 2008 21:43:34 +0100
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020705080800040702060402"
Subject: [Xenomai-core] Script marking
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

This is a multi-part message in MIME format.
--------------020705080800040702060402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

at Debian, I noticed that the "run" scripts are not marked as such and
therefore produce "lintian errors". Consider the attached patch that I
propose.

Besides, the documentation seems to be installed under
/usr/share/doc/xenomai-2.4.2. Shouldn't /usr/share/doc/xenomai be more
appropriate? (I implemented the latter in Debian.)

Further, I updated the package in Debian with the suggested changes.

bye,
  Roland

--------------020705080800040702060402
Content-Type: text/x-patch;
 name="xenomai.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai.patch"

diff -ruN xenomai-2.4.2/src/testsuite/clocktest/Makefile.am xenomai-2.4.2.new/src/testsuite/clocktest/Makefile.am
--- xenomai-2.4.2/src/testsuite/clocktest/Makefile.am	2007-12-09 11:46:39.000000000 +0100
+++ xenomai-2.4.2.new/src/testsuite/clocktest/Makefile.am	2008-02-28 21:29:24.000000000 +0100
@@ -14,7 +14,8 @@
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
 	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" > $(DESTDIR)$(testdir)/run
+	@echo "#!/bin/sh" > $(DESTDIR)$(testdir)/run
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" >> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
 
 uninstall-local:
diff -ruN xenomai-2.4.2/src/testsuite/cyclic/Makefile.am xenomai-2.4.2.new/src/testsuite/cyclic/Makefile.am
--- xenomai-2.4.2/src/testsuite/cyclic/Makefile.am	2007-12-09 11:46:39.000000000 +0100
+++ xenomai-2.4.2.new/src/testsuite/cyclic/Makefile.am	2008-02-28 21:34:34.000000000 +0100
@@ -14,7 +14,8 @@
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
 	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" > $(DESTDIR)$(testdir)/run
+	@echo "#!/bin/sh" > $(DESTDIR)$(testdir)/run
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" >> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
 
 uninstall-local:
diff -ruN xenomai-2.4.2/src/testsuite/irqbench/Makefile.am xenomai-2.4.2.new/src/testsuite/irqbench/Makefile.am
--- xenomai-2.4.2/src/testsuite/irqbench/Makefile.am	2007-12-09 11:46:39.000000000 +0100
+++ xenomai-2.4.2.new/src/testsuite/irqbench/Makefile.am	2008-02-28 21:31:22.000000000 +0100
@@ -34,7 +34,8 @@
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
 	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" > $(DESTDIR)$(testdir)/run
+	@echo "#!/bin/sh" > $(DESTDIR)$(testdir)/run
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" >> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
 
 uninstall-local:
diff -ruN xenomai-2.4.2/src/testsuite/latency/Makefile.am xenomai-2.4.2.new/src/testsuite/latency/Makefile.am
--- xenomai-2.4.2/src/testsuite/latency/Makefile.am	2007-12-09 11:46:39.000000000 +0100
+++ xenomai-2.4.2.new/src/testsuite/latency/Makefile.am	2008-02-28 21:32:02.000000000 +0100
@@ -18,7 +18,8 @@
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
 	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" > $(DESTDIR)$(testdir)/run
+	@echo "#!/bin/sh" > $(DESTDIR)$(testdir)/run
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" >> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
 
 uninstall-local:
diff -ruN xenomai-2.4.2/src/testsuite/switchbench/Makefile.am xenomai-2.4.2.new/src/testsuite/switchbench/Makefile.am
--- xenomai-2.4.2/src/testsuite/switchbench/Makefile.am	2007-12-09 11:46:39.000000000 +0100
+++ xenomai-2.4.2.new/src/testsuite/switchbench/Makefile.am	2008-02-28 21:32:38.000000000 +0100
@@ -17,7 +17,8 @@
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
 	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" > $(DESTDIR)$(testdir)/run
+	@echo "#!/bin/sh" > $(DESTDIR)$(testdir)/run
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" >> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
 
 uninstall-local:
diff -ruN xenomai-2.4.2/src/testsuite/switchtest/Makefile.am xenomai-2.4.2.new/src/testsuite/switchtest/Makefile.am
--- xenomai-2.4.2/src/testsuite/switchtest/Makefile.am	2007-12-09 11:46:39.000000000 +0100
+++ xenomai-2.4.2.new/src/testsuite/switchtest/Makefile.am	2008-02-28 21:30:41.000000000 +0100
@@ -14,7 +14,8 @@
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
 	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" > $(DESTDIR)$(testdir)/run
+	@echo "#!/bin/sh" > $(DESTDIR)$(testdir)/run
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" >> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
 
 uninstall-local:

--------------020705080800040702060402--

