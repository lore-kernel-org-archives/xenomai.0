From: Paul <paul_c@domain.hid>
Date: Thu, 1 Jan 2009 15:06:59 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TwNXJvQ3cWi0SIm"
Message-Id: <200901011506.59095.paul_c@domain.hid>
Subject: [Xenomai-core] [PATCH] Allow Debian tools to cross compile
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

--Boundary-00=_TwNXJvQ3cWi0SIm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Attached, a small patch for debian/rules to allow dpkg-cross to cross-compile 
binary packages. Tested on a AMD64 host compiling powerpc packages, and no 
unpleasant suprises found.


Regards, Paul.



--Boundary-00=_TwNXJvQ3cWi0SIm
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="debian_rules.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="debian_rules.diff"

Index: debian/rules
===================================================================
--- debian/rules	(revision 4519)
+++ debian/rules	(working copy)
@@ -8,6 +8,8 @@
 
 DEB_HOST_GNU_CPU ?= $(shell dpkg-architecture -qDEB_HOST_GNU_CPU)
 DEB_HOST_ARCH ?= $(shell dpkg-architecture -qDEB_HOST_ARCH)
+DEB_HOST_GNU_TYPE=$(shell dpkg-architecture -qDEB_HOST_GNU_TYPE)
+DEB_BUILD_GNU_TYPE=$(shell dpkg-architecture -qDEB_BUILD_GNU_TYPE)
 
 ifeq ($(DEB_HOST_ARCH), i386)
 # Note: Would like to use --includedir=/usr/include/xenomai, but
@@ -35,7 +37,13 @@ ifeq ($(DEB_HOST_ARCH), arm)
 endif
 	CONFIG_OPTS += --prefix=/usr \
 	            --includedir=/usr/include/xenomai \
-	            --mandir=/usr/share/man
+	            --mandir=/usr/share/man \
+
+ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
+	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE) --host $(DEB_HOST_GNU_TYPE)
+else
+	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE)
+endif
 
 build: build-arch build-indep
 

--Boundary-00=_TwNXJvQ3cWi0SIm--

