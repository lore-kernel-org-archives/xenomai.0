Message-ID: <527BCB0B.1010609@siemens.com>
Date: Thu, 07 Nov 2013 18:16:59 +0100
From: Gernot Hillier <gernot.hillier@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [Xenomai-forge PATCH] testsuite: fix clocktest invocation
	in xeno-test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

As there are two testdir occurences in one line, we need global regex replace.

Signed-off-by: Gernot Hillier <gernot.hillier@siemens.com>
---
 testsuite/xeno-test/Makefile.am | 2 +-
 testsuite/xeno-test/Makefile.in | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testsuite/xeno-test/Makefile.am b/testsuite/xeno-test/Makefile.am
index cd809ab..ce51b29 100644
--- a/testsuite/xeno-test/Makefile.am
+++ b/testsuite/xeno-test/Makefile.am
@@ -9,7 +9,7 @@ xeno_test_run_CPPFLAGS = -DTESTDIR=\"$(testdir)\" -D_GNU_SOURCE
 xeno_test_run_LDADD = -lpthread -lrt
 
 xeno-test: $(srcdir)/xeno-test.in Makefile
-	sed "s,@testdir@,$(testdir),;s,@pkgdir@,$(pkgdir)," $< > $@
+	sed "s,@testdir@,$(testdir),g;s,@pkgdir@,$(pkgdir)," $< > $@
 
 EXTRA_DIST = $(test_SCRIPTS) xeno-test.in
 
diff --git a/testsuite/xeno-test/Makefile.in b/testsuite/xeno-test/Makefile.in
index b3225e3..1a19dca 100644
--- a/testsuite/xeno-test/Makefile.in
+++ b/testsuite/xeno-test/Makefile.in
@@ -791,7 +791,7 @@ uninstall-am: uninstall-binSCRIPTS uninstall-testPROGRAMS \
 
 
 xeno-test: $(srcdir)/xeno-test.in Makefile
-	sed "s,@testdir@,$(testdir),;s,@pkgdir@,$(pkgdir)," $< > $@
+	sed "s,@testdir@,$(testdir),g;s,@pkgdir@,$(pkgdir)," $< > $@
 
 # Tell versions [3.59,3.63) of GNU make to not export all variables.
 # Otherwise a system limit (for SysV at least) may be exceeded.
-- 
1.8.1.2

-- 
Gernot Hillier

Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

