Message-ID: <480A4FB1.6050506@domain.hid>
Date: Sat, 19 Apr 2008 22:01:53 +0200
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060701090601030109080101"
Subject: [Xenomai-core] klatency run script
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
--------------060701090601030109080101
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

for the creation of the run script for klatency, I propose the attached
change to make it a proper executable (script).

Thanks for considering,

Roland

--------------060701090601030109080101
Content-Type: text/x-diff;
 name="klatency-run.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="klatency-run.patch"

--- src/testsuite/klatency/Makefile.am.orig	2008-04-19 21:33:42.000000000 +0200
+++ src/testsuite/klatency/Makefile.am	2008-04-19 21:34:16.000000000 +0200
@@ -13,7 +13,8 @@
 install-data-local:
 	$(mkinstalldirs) $(DESTDIR)$(testdir)
 	@sed -e's,@exec_prefix\@,$(exec_prefix),g' $(srcdir)/runinfo.in > $(DESTDIR)$(testdir)/.runinfo
-	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" > $(DESTDIR)$(testdir)/run
+	@echo "#!/bin/sh" > $(DESTDIR)$(testdir)/run
+	@echo "\$${DESTDIR}$(exec_prefix)/bin/xeno-load \`dirname \$$0\` \$$*" >> $(DESTDIR)$(testdir)/run
 	@chmod +x $(DESTDIR)$(testdir)/run
 
 uninstall-local:

--------------060701090601030109080101--

