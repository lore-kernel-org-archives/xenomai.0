From: Henning Schild <henning.schild@siemens.com>
Date: Wed, 29 Apr 2015 11:32:42 +0200
Message-Id: <5c789beff3ff2c2ef88fbe1a53342cb7ebc714b8.1430299655.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 1/2] debian: add autoreconf to build rules
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Add autoreconf steps to debian/rules and add required tools to build deps.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 debian/control | 2 +-
 debian/rules   | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/debian/control b/debian/control
index 2225648..54fc898 100644
--- a/debian/control
+++ b/debian/control
@@ -2,7 +2,7 @@ Source: xenomai
 Section: devel
 Priority: extra
 Maintainer: Xenomai <xenomai@xenomai.org>
-Build-Depends: debhelper (>= 8), findutils (>= 4.2.28), autotools-dev, autoconf, automake, libtool
+Build-Depends: debhelper (>= 8), findutils (>= 4.2.28), autotools-dev, autoconf, automake, dh-autoreconf
 Standards-Version: 3.9.3
 Homepage: http://www.xenomai.org/
 
diff --git a/debian/rules b/debian/rules
index f91a621..a5d2e32 100755
--- a/debian/rules
+++ b/debian/rules
@@ -39,11 +39,13 @@ build-indep-stamp: config.status
 
 config.status: configure-stamp
 configure-stamp:
+	dh_autoreconf
 	dh_testdir
 	./configure $(CONFIG_OPTS)
 	touch configure-stamp
 
 clean:
+	dh_autoreconf_clean
 	dh_testdir
 	dh_testroot
 	rm -f configure-stamp build-indep-stamp build-arch-stamp
-- 
1.9.1


