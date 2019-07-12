From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] libcobalt: Drop ignored version info from arch libs
Message-ID: <58a10f03-7501-5023-10fa-0d55601ce17f@siemens.com>
Date: Fri, 12 Jul 2019 14:10:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Fixes libtool warning

libtool: warning: '-version-info/-version-number' is ignored for convenience libraries

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/cobalt/arch/arm/Makefile.am     | 2 +-
 lib/cobalt/arch/arm64/Makefile.am   | 2 +-
 lib/cobalt/arch/powerpc/Makefile.am | 2 +-
 lib/cobalt/arch/x86/Makefile.am     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/cobalt/arch/arm/Makefile.am b/lib/cobalt/arch/arm/Makefile.am
index 0aa02d6c73..a5095be3d0 100644
--- a/lib/cobalt/arch/arm/Makefile.am
+++ b/lib/cobalt/arch/arm/Makefile.am
@@ -1,6 +1,6 @@
 noinst_LTLIBRARIES = libarch.la
 
-libarch_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
+libarch_la_LDFLAGS = @XENO_LIB_LDFLAGS@
 
 libarch_la_SOURCES = features.c
 
diff --git a/lib/cobalt/arch/arm64/Makefile.am b/lib/cobalt/arch/arm64/Makefile.am
index 0aa02d6c73..a5095be3d0 100644
--- a/lib/cobalt/arch/arm64/Makefile.am
+++ b/lib/cobalt/arch/arm64/Makefile.am
@@ -1,6 +1,6 @@
 noinst_LTLIBRARIES = libarch.la
 
-libarch_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
+libarch_la_LDFLAGS = @XENO_LIB_LDFLAGS@
 
 libarch_la_SOURCES = features.c
 
diff --git a/lib/cobalt/arch/powerpc/Makefile.am b/lib/cobalt/arch/powerpc/Makefile.am
index 0aa02d6c73..a5095be3d0 100644
--- a/lib/cobalt/arch/powerpc/Makefile.am
+++ b/lib/cobalt/arch/powerpc/Makefile.am
@@ -1,6 +1,6 @@
 noinst_LTLIBRARIES = libarch.la
 
-libarch_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
+libarch_la_LDFLAGS = @XENO_LIB_LDFLAGS@
 
 libarch_la_SOURCES = features.c
 
diff --git a/lib/cobalt/arch/x86/Makefile.am b/lib/cobalt/arch/x86/Makefile.am
index 0aa02d6c73..a5095be3d0 100644
--- a/lib/cobalt/arch/x86/Makefile.am
+++ b/lib/cobalt/arch/x86/Makefile.am
@@ -1,6 +1,6 @@
 noinst_LTLIBRARIES = libarch.la
 
-libarch_la_LDFLAGS = @XENO_LIB_LDFLAGS@ -version-info 0:0:0
+libarch_la_LDFLAGS = @XENO_LIB_LDFLAGS@
 
 libarch_la_SOURCES = features.c
 
-- 
2.16.4

