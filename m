From: Henning Schild <henning.schild@siemens.com>
Date: Tue, 13 Feb 2018 13:38:19 +0100
Message-Id: <9bdeb501796a2e2f0ca5666b69cd7256df90453d.1518525088.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518525088.git.henning.schild@siemens.com>
References: <cover.1518525088.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518525088.git.henning.schild@siemens.com>
References: <cover.1518525088.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 1/3] debian: drop prebuild docs from packages
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

commit 65e1b75629 dropped the prebuild documentation, as a result the
debian package build will fail trying to include it into packages
We could actually build the docs to package them, this patch just drops
them as well.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 debian/control                 | 22 +++-------------------
 debian/xenomai-doc.install     |  1 -
 debian/xenomai-runtime.install |  1 -
 3 files changed, 3 insertions(+), 21 deletions(-)
 delete mode 100644 debian/xenomai-doc.install

diff --git a/debian/control b/debian/control
index 86e8e37e3..425f00741 100644
--- a/debian/control
+++ b/debian/control
@@ -11,7 +11,7 @@ Package: xenomai-runtime
 Section: devel
 Architecture: amd64 arm armeb armel armhf i386 powerpc powerpcspe
 Depends: ${shlibs:Depends}, ${misc:Depends}
-Suggests: xenomai-kernel-source, xenomai-doc
+Suggests: xenomai-kernel-source
 Replaces: xenomai
 Conflicts: xenomai
 Description: Xenomai runtime utilities
@@ -48,7 +48,7 @@ Package: libxenomai1
 Section: libs
 Architecture: amd64 arm armeb armel armhf i386 powerpc powerpcspe
 Depends: ${shlibs:Depends}, ${misc:Depends}
-Suggests: xenomai-kernel-source, xenomai-doc
+Suggests: xenomai-kernel-source
 Replaces: xenomai
 Conflicts: xenomai
 Description: Shared libraries for Xenomai
@@ -64,7 +64,7 @@ Package: libxenomai-dev
 Section: libdevel
 Architecture: amd64 arm armeb armel armhf i386 powerpc powerpcspe
 Depends: libxenomai1 (= ${binary:Version}), ${misc:Depends}
-Suggests: xenomai-kernel-source, xenomai-doc
+Suggests: xenomai-kernel-source
 Replaces: xenomai
 Conflicts: xenomai
 Description: Headers and static libs for Xenomai
@@ -76,19 +76,3 @@ Description: Headers and static libs for Xenomai
  .
  This package contains development files (header files), the static libraries
  and scripts used to compile realtime applications.
-
-Package: xenomai-doc
-Section: doc
-Architecture: all
-Depends: ${misc:Depends}
-Suggests: xenomai
-Conflicts: xenomai-docs
-Replaces: xenomai-docs
-Description: Xenomai documentation
- Xenomai is a real-time development framework cooperating with the Linux
- kernel in order to provide a pervasive, interface-agnostic, hard real-time
- support to user-space applications, seamlessly integrated into the GNU/Linux
- environment. Xenomai provides its own API and emulation layers ("skins") to
- make migration from other RTOS easier. Examples are: pSOS+, VxWorks, POSIX.
- .
- Documentation for Xenomai realtime API.
diff --git a/debian/xenomai-doc.install b/debian/xenomai-doc.install
deleted file mode 100644
index f8521db50..000000000
--- a/debian/xenomai-doc.install
+++ /dev/null
@@ -1 +0,0 @@
-usr/share/doc/xenomai/* usr/share/doc/xenomai-doc
diff --git a/debian/xenomai-runtime.install b/debian/xenomai-runtime.install
index e5f1cd6ad..372b0e402 100644
--- a/debian/xenomai-runtime.install
+++ b/debian/xenomai-runtime.install
@@ -1,4 +1,3 @@
 usr/bin
 usr/sbin
-usr/share/man
 usr/lib/xenomai
-- 
2.13.6


