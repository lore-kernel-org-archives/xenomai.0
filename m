From: gernot.hillier@siemens.com
Date: Fri,  8 Nov 2013 10:34:20 +0100
Message-Id: <1383903263-10441-5-git-send-email-gernot.hillier@siemens.com>
In-Reply-To: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
References: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
Subject: [Xenomai] [Xenomai-forge PATCH 4/7] debian: remove now useless
	configure options (cherry picked from commit
	c581878158605578792f88ced09f02ad34c092de)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

---
 debian/rules | 35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/debian/rules b/debian/rules
index 650c419..643173c 100755
--- a/debian/rules
+++ b/debian/rules
@@ -11,34 +11,10 @@ DEB_HOST_ARCH ?= $(shell dpkg-architecture -qDEB_HOST_ARCH)
 DEB_HOST_GNU_TYPE=$(shell dpkg-architecture -qDEB_HOST_GNU_TYPE)
 DEB_BUILD_GNU_TYPE=$(shell dpkg-architecture -qDEB_BUILD_GNU_TYPE)
 
-ifeq ($(DEB_HOST_ARCH), i386)
-# Note: Would like to use --includedir=/usr/include/xenomai, but
-# there appears to be a `make install` problem.
-	CONFIG_OPTS = \
-	            --enable-x86-tsc
-endif
-ifeq ($(DEB_HOST_ARCH), amd64)
-	CONFIG_OPTS = \
-	            --enable-smp \
-	            --enable-x86-tsc \
-	            --enable-x86-sep
-endif
-ifeq ($(DEB_HOST_ARCH), powerpc)
-	CONFIG_OPTS =
-endif
-ifeq ($(DEB_HOST_ARCH), armeb)
-	CONFIG_OPTS = --enable-arm-mach=generic --enable-arm-eabi
-endif
-ifeq ($(DEB_HOST_ARCH), armel)
-	CONFIG_OPTS = --enable-arm-mach=generic --enable-arm-eabi
-endif
-ifeq ($(DEB_HOST_ARCH), arm)
-	CONFIG_OPTS = --enable-arm-mach=generic
-endif
-	CONFIG_OPTS += --prefix=/usr \
-	            --includedir=/usr/include/xenomai \
-	            --mandir=/usr/share/man \
-		    --with-testdir=/usr/lib/xenomai
+CONFIG_OPTS = --prefix=/usr \
+            --includedir=/usr/include/xenomai \
+            --mandir=/usr/share/man \
+	    --with-testdir=/usr/lib/xenomai
 
 ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
 	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE) --host $(DEB_HOST_GNU_TYPE)
@@ -46,9 +22,6 @@ else
 	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE)
 endif
 
-# necessary from GCC 4.6 on
-CFLAGS += -fno-omit-frame-pointer
-
 build: build-arch build-indep
 
 build-arch: build-arch-stamp
-- 
1.8.1.2


