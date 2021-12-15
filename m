From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/4] Drop PowerPC architecture support
Date: Wed, 15 Dec 2021 19:04:22 +0100
Message-ID: <b184e36ca5489eac624ea6be5e503edc618221d1.1639591464.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1639591464.git.jan.kiszka@siemens.com>
References: <cover.1639591464.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

While this architecture served well in many use cases over a long time,
it's time is over, new chip chips are no longer being released.

As Xenomai is moving its core completely over Dovetail, there is no
support in Dovetail for PowerPC and that is not going to change, it's
time to drop this arch from the core in order to move forward.

This addresses the majority of artifacts, just few traces in drivers and
documentations are left for later cleanups.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml                                |  27 +--
 configure.ac                                  |   9 -
 debian/control                                |   6 +-
 doc/asciidoc/README.INSTALL.adoc              |  50 +----
 doc/asciidoc/man1/xeno-config.adoc            |   2 +-
 kernel/cobalt/arch/powerpc/Kconfig            |   8 -
 .../powerpc/include/asm/xenomai/uapi/arith.h  |  34 ----
 .../include/asm/xenomai/uapi/features.h       |  40 ----
 .../powerpc/include/asm/xenomai/uapi/fptest.h | 127 -------------
 .../include/asm/xenomai/uapi/syscall.h        |  23 ---
 kernel/cobalt/arch/powerpc/ipipe/Makefile     |   8 -
 kernel/cobalt/arch/powerpc/ipipe/README       |   3 -
 kernel/cobalt/arch/powerpc/ipipe/fpu.S        |  87 ---------
 .../ipipe/include/asm/xenomai/calibration.h   | 106 -----------
 .../ipipe/include/asm/xenomai/features.h      |  27 ---
 .../ipipe/include/asm/xenomai/fptest.h        |  58 ------
 .../ipipe/include/asm/xenomai/machine.h       |  39 ----
 .../ipipe/include/asm/xenomai/syscall.h       |  83 ---------
 .../ipipe/include/asm/xenomai/syscall32.h     |  24 ---
 .../ipipe/include/asm/xenomai/thread.h        |  92 ---------
 .../ipipe/include/asm/xenomai/wrappers.h      |  24 ---
 kernel/cobalt/arch/powerpc/ipipe/machine.c    |  67 -------
 kernel/cobalt/arch/powerpc/ipipe/thread.c     | 174 ------------------
 lib/cobalt/arch/Makefile.am                   |   2 +-
 lib/cobalt/arch/powerpc/Makefile.am           |  13 --
 lib/cobalt/arch/powerpc/features.c            |  24 ---
 lib/cobalt/arch/powerpc/include/Makefile.am   |   2 -
 .../arch/powerpc/include/asm/Makefile.am      |   2 -
 .../powerpc/include/asm/xenomai/Makefile.am   |   5 -
 .../powerpc/include/asm/xenomai/features.h    |  30 ---
 .../powerpc/include/asm/xenomai/syscall.h     |  82 ---------
 .../arch/powerpc/include/asm/xenomai/time.h   |  16 --
 .../arch/powerpc/include/asm/xenomai/tsc.h    |  38 ----
 scripts/prepare-kernel.sh                     |   3 -
 34 files changed, 18 insertions(+), 1317 deletions(-)
 delete mode 100644 kernel/cobalt/arch/powerpc/Kconfig
 delete mode 100644 kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/arith.h
 delete mode 100644 kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
 delete mode 100644 kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/fptest.h
 delete mode 100644 kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/syscall.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/Makefile
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/README
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/fpu.S
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/calibration.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/features.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/fptest.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/machine.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/syscall.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/syscall32.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/thread.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/wrappers.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/machine.c
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/thread.c
 delete mode 100644 lib/cobalt/arch/powerpc/Makefile.am
 delete mode 100644 lib/cobalt/arch/powerpc/features.c
 delete mode 100644 lib/cobalt/arch/powerpc/include/Makefile.am
 delete mode 100644 lib/cobalt/arch/powerpc/include/asm/Makefile.am
 delete mode 100644 lib/cobalt/arch/powerpc/include/asm/xenomai/Makefile.am
 delete mode 100644 lib/cobalt/arch/powerpc/include/asm/xenomai/features.h
 delete mode 100644 lib/cobalt/arch/powerpc/include/asm/xenomai/syscall.h
 delete mode 100644 lib/cobalt/arch/powerpc/include/asm/xenomai/time.h
 delete mode 100644 lib/cobalt/arch/powerpc/include/asm/xenomai/tsc.h

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 602a7682ac..76daad792e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -24,12 +24,12 @@ variables:
   DOVETAIL_URL: "https://source.denx.de/Xenomai/linux-dovetail.git"
   GCC_VERSION: "10"
   PACKAGES: "u-boot-tools git make bc bison libelf-dev autotools-dev \
-             autoconf autogen libtool pkg-config ccache flex libssl-dev"
-  PACKAGES_arm: "gcc-${GCC_VERSION} gcc-${GCC_VERSION}-arm-linux-gnueabihf libc6-dev-armhf-cross"
-  PACKAGES_arm64: "gcc-${GCC_VERSION} gcc-${GCC_VERSION}-aarch64-linux-gnu libc6-dev-arm64-cross"
-  PACKAGES_i386: "gcc-${GCC_VERSION} gcc-${GCC_VERSION}-i686-linux-gnu libc6-dev-i386-cross"
-  PACKAGES_powerpc: "gcc-8 gcc-8-powerpc-linux-gnu libc6-dev-powerpc-cross"
-  PACKAGES_x86: "gcc-${GCC_VERSION}"
+             autoconf autogen libtool pkg-config ccache flex libssl-dev \
+             gcc-${GCC_VERSION}"
+  PACKAGES_arm: "gcc-${GCC_VERSION}-arm-linux-gnueabihf libc6-dev-armhf-cross"
+  PACKAGES_arm64: "gcc-${GCC_VERSION}-aarch64-linux-gnu libc6-dev-arm64-cross"
+  PACKAGES_i386: "gcc-${GCC_VERSION}-i686-linux-gnu libc6-dev-i386-cross"
+  PACKAGES_x86: ""
   XENOMAI_IMAGES_BRANCH: "master"
 
 .build:
@@ -57,12 +57,6 @@ variables:
       export CONFIGURE_OPTS="--host=i686-linux-gnu --with-cc=i686-linux-gnu-gcc";
       update-alternatives --install /usr/bin/i686-linux-gnu-gcc i686-linux-gnu-gcc /usr/bin/i686-linux-gnu-gcc-${GCC_VERSION} 800;
       ;;
-      "powerpc")
-      export GCC_VERSION=8
-      export CROSS_COMPILE=powerpc-linux-gnu-;
-      export CONFIGURE_OPTS="--host=powerpc-linux-gnu --with-cc=powerpc-linux-gnu-gcc";
-      update-alternatives --install /usr/bin/powerpc-linux-gnu-gcc powerpc-linux-gnu-gcc /usr/bin/powerpc-linux-gnu-gcc-${GCC_VERSION} 800;
-      ;;
       "x86")
       export CROSS_COMPILE=;
       export CONFIGURE_OPTS="--enable-dlopen-libs --enable-lazy-setsched";
@@ -276,15 +270,6 @@ i386-userland:
     - make -j $(nproc)
     - ccache -s
 
-powerpc-4.19-release:
-  extends: .build
-  image: debian:buster
-  variables:
-    ARCH: powerpc
-    PIPELINE_REV: ipipe-core-4.19..*-ppc32-.*
-    PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-ppc32.git
-    KERNEL_DEFCONFIG: mpc5200_defconfig
-
 trigger-xenomai-images:
   stage: test
   image: curlimages/curl
diff --git a/configure.ac b/configure.ac
index e7a170161b..cd1e9b1501 100644
--- a/configure.ac
+++ b/configure.ac
@@ -125,11 +125,6 @@ case "$build_for" in
 	target_cpu_arch=x86
 	CONFIG_XENO_DEFAULT_PERIOD=100000
 	;;
- ppc-*|powerpc-*)
-	use_tls=yes
-	target_cpu_arch=powerpc
-	CONFIG_XENO_DEFAULT_PERIOD=100000
-	;;
  arm*-*)
 	target_cpu_arch=arm
 	CONFIG_XENO_DEFAULT_PERIOD=1000000
@@ -949,10 +944,6 @@ AC_CONFIG_FILES([ \
 	lib/cobalt/arch/arm64/include/Makefile \
 	lib/cobalt/arch/arm64/include/asm/Makefile \
 	lib/cobalt/arch/arm64/include/asm/xenomai/Makefile \
-	lib/cobalt/arch/powerpc/Makefile \
-	lib/cobalt/arch/powerpc/include/Makefile \
-	lib/cobalt/arch/powerpc/include/asm/Makefile \
-	lib/cobalt/arch/powerpc/include/asm/xenomai/Makefile \
 	lib/cobalt/arch/x86/Makefile \
 	lib/cobalt/arch/x86/include/Makefile \
 	lib/cobalt/arch/x86/include/asm/Makefile \
diff --git a/debian/control b/debian/control
index 2fda4e961b..857d8ff8f1 100644
--- a/debian/control
+++ b/debian/control
@@ -8,7 +8,7 @@ Homepage: http://www.xenomai.org/
 
 Package: xenomai-runtime
 Section: devel
-Architecture: amd64 arm armeb armel armhf arm64 i386 powerpc powerpcspe
+Architecture: amd64 arm armeb armel armhf arm64 i386
 Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat
 Suggests: xenomai-kernel-source
 Replaces: xenomai
@@ -45,7 +45,7 @@ Description: Source for Xenomai kernel-space support
 
 Package: libxenomai1
 Section: libs
-Architecture: amd64 arm armeb armel armhf arm64 i386 powerpc powerpcspe
+Architecture: amd64 arm armeb armel armhf arm64 i386
 Depends: ${shlibs:Depends}, ${misc:Depends}
 Suggests: xenomai-kernel-source
 Replaces: xenomai
@@ -61,7 +61,7 @@ Description: Shared libraries for Xenomai
 
 Package: libxenomai-dev
 Section: libdevel
-Architecture: amd64 arm armeb armel armhf arm64 i386 powerpc powerpcspe
+Architecture: amd64 arm armeb armel armhf arm64 i386
 Depends: libxenomai1 (= ${binary:Version}), ${misc:Depends}
 Suggests: xenomai-kernel-source
 Replaces: xenomai
diff --git a/doc/asciidoc/README.INSTALL.adoc b/doc/asciidoc/README.INSTALL.adoc
index da96686b4f..c22f563712 100644
--- a/doc/asciidoc/README.INSTALL.adoc
+++ b/doc/asciidoc/README.INSTALL.adoc
@@ -118,7 +118,6 @@ invocation.
 In order to cross-compile the Linux kernel, pass an ARCH and
 CROSS_COMPILE variable on make command line. See sections
 <<cobalt-core-arm,"Building a _Cobalt/arm_ kernel">>,
-<<cobalt-core-powerpc,"Building a _Cobalt/powerpc_ kernel">>,
 <<cobalt-core-x86,"Building a _Cobalt/x86_ kernel">>,
 for examples.
 
@@ -233,26 +232,6 @@ _Cobalt_-enabled kernel for various architectures. Of course, you would
 have to install the proper cross-compilation toolchain for the target
 system first.
 
-[[cobalt-core-powerpc]]
-Building a _Cobalt/powerpc_ kernel
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-A typical cross-compilation setup, in order to build Xenomai for a
-ppc-6xx architecture running a 3.10.32 kernel. We use the DENX ELDK
-cross-compiler:
-
-------------------------------------------------------------------------------
-$ cd $linux_tree
-$ $xenomai_root/scripts/prepare-kernel.sh --arch=powerpc \
-  --ipipe=ipipe-core-3.10.32-powerpc-1.patch
-$ make ARCH=powerpc CROSS_COMPILE=ppc_6xx- xconfig/gconfig/menuconfig
-------------------------------------------------------------------------------
-...select the kernel and Xenomai options, save the configuration
-------------------------------------------------------------------------------
-$ make ARCH=powerpc CROSS_COMPILE=powerpc-linux- uImage modules
-------------------------------------------------------------------------------
-...manually install the kernel image and modules to the proper location
-
 [[cobalt-core-arm]]
 Building  _Cobalt/arm_ kernel
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -515,9 +494,9 @@ does exist on the target kernel.
 	Due to GCC bugs regarding this feature with some
 	release,architecture combinations, whether TLS is turned on by
 	default is a per-architecture decision. Currently, this
-	feature is enabled for x86 and powerpc by default, other
-	architectures will require `--enable-tls` to be passed to the
-	_configure_ script explicitly.
+	feature is enabled for x86 by default, other architectures will
+	require `--enable-tls` to be passed to the _configure_ script
+	explicitly.
 
 [normal]
 	Unless `--enable-dlopen-libs` is present, the _initial-exec_
@@ -649,11 +628,11 @@ i.e. the system running the _configure_ script.
 
 Since cross-compiling requires specific tools, such tools are
 generally prefixed with the host architecture name; for example, a
-compiler for the PowerPC architecture may be named
-`powerpc-linux-gcc`.
+compiler for the 64-bit ARM architecture may be named
+`aarch64-linux-gcc`.
 
-When passing `--host=powerpc-linux` to configure, it will
-automatically use `powerpc-linux-` as a prefix to all
+When passing `--host=aarch64-linux` to configure, it will
+automatically use `aarch64-linux-` as a prefix to all
 compilation tools names and infer the host architecture name from this
 prefix. If configure is unable to infer the architecture name from the
 cross-compilation tools prefix, you will have to manually pass the
@@ -729,21 +708,6 @@ The remaining examples illustrate how to cross-compile Xenomai for
 various architectures. Of course, you would have to install the proper
 cross-compilation toolchain for the target system first.
 
-Building the PPC32 libraries
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-A typical cross-compilation setup, in order to build the _Cobalt_
-libraries for a ppc-6xx architecture. In that example, we want the
-debug symbols to be generated for the executable, with no runtime
-overhead though. We use the DENX ELDK cross-compiler:
-
-------------------------------------------------------------------------------
-$ cd $build_root
-$ $xenomai_root/configure --host=powerpc-linux --with-core=cobalt \
-  --enable-debug=symbols
-$ make DESTDIR=$staging_dir install
-------------------------------------------------------------------------------
-
 Building the ARM libraries
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/doc/asciidoc/man1/xeno-config.adoc b/doc/asciidoc/man1/xeno-config.adoc
index 81f67ad4e0..a537e189b1 100644
--- a/doc/asciidoc/man1/xeno-config.adoc
+++ b/doc/asciidoc/man1/xeno-config.adoc
@@ -72,7 +72,7 @@ application.
 
 *--arch*::
 Output the target CPU architecture Xenomai was compiled for, e.g. arm,
-x86, powerpc etc.  This may differ from the CPU architecture of the
+arm64, x86, etc.  This may differ from the CPU architecture of the
 current system, if cross-compiling.
 
 *--prefix*::
diff --git a/kernel/cobalt/arch/powerpc/Kconfig b/kernel/cobalt/arch/powerpc/Kconfig
deleted file mode 100644
index 6ce3440ede..0000000000
--- a/kernel/cobalt/arch/powerpc/Kconfig
+++ /dev/null
@@ -1,8 +0,0 @@
-source "kernel/xenomai/Kconfig"
-source "drivers/xenomai/Kconfig"
-
-config XENO_ARCH_FPU
-	def_bool PPC_FPU
-
-config XENO_ARCH_SYS3264
-        def_bool n
diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/arith.h b/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/arith.h
deleted file mode 100644
index 160a7d8ce5..0000000000
--- a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/arith.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * Copyright (C) 2008 Philippe Gerum <rpm@xenomai.org>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
-
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-#ifndef _COBALT_POWERPC_ASM_UAPI_ARITH_H
-#define _COBALT_POWERPC_ASM_UAPI_ARITH_H
-
-#include <asm/xenomai/uapi/features.h>
-
-#define xnarch_add96and64(l0, l1, l2, s0, s1)		\
-	do {						\
-		__asm__ ("addc %2, %2, %4\n\t"		\
-			 "adde %1, %1, %3\n\t"		\
-			 "addze %0, %0\n\t"		\
-			 : "+r"(l0), "+r"(l1), "+r"(l2)	\
-			 : "r"(s0), "r"(s1) : "cc");	\
-	} while (0)
-
-#include <cobalt/uapi/asm-generic/arith.h>
-
-#endif /* _COBALT_POWERPC_ASM_UAPI_ARITH_H */
diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h b/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
deleted file mode 100644
index ed54882105..0000000000
--- a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/features.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
-
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-#ifndef _COBALT_POWERPC_ASM_UAPI_FEATURES_H
-#define _COBALT_POWERPC_ASM_UAPI_FEATURES_H
-
-/* The ABI revision level we use on this arch. */
-#define XENOMAI_ABI_REV   18UL
-
-#define XENOMAI_FEAT_DEP  __xn_feat_generic_mask
-
-#define XENOMAI_FEAT_MAN  __xn_feat_generic_man_mask
-
-#define XNARCH_HAVE_LLMULSHFT    1
-#define XNARCH_HAVE_NODIV_LLIMD  1
-
-struct cobalt_featinfo_archdep { /* no arch-specific feature */ };
-
-#include <cobalt/uapi/asm-generic/features.h>
-
-static inline const char *get_feature_label(unsigned feature)
-{
-	return get_generic_feature_label(feature);
-}
-
-#endif /* !_COBALT_POWERPC_ASM_UAPI_FEATURES_H */
diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/fptest.h b/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/fptest.h
deleted file mode 100644
index e6f89c9ba5..0000000000
--- a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/fptest.h
+++ /dev/null
@@ -1,127 +0,0 @@
-/*
- * Copyright (C) 2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
-
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-#ifndef _COBALT_POWERPC_ASM_UAPI_FPTEST_H
-#define _COBALT_POWERPC_ASM_UAPI_FPTEST_H
-
-#ifndef __NO_FPRS__		/* i.e. has FPU, not SPE */
-
-static inline void fp_regs_set(int features, unsigned int val)
-{
-	unsigned long long fpval = val;
-
-	__asm__ __volatile__("lfd	0, %0\n"
-			     "	fmr	1, 0\n"
-			     "	fmr	2, 0\n"
-			     "	fmr	3, 0\n"
-			     "	fmr	4, 0\n"
-			     "	fmr	5, 0\n"
-			     "	fmr	6, 0\n"
-			     "	fmr	7, 0\n"
-			     "	fmr	8, 0\n"
-			     "	fmr	9, 0\n"
-			     "	fmr	10, 0\n"
-			     "	fmr	11, 0\n"
-			     "	fmr	12, 0\n"
-			     "	fmr	13, 0\n"
-			     "	fmr	14, 0\n"
-			     "	fmr	15, 0\n"
-			     "	fmr	16, 0\n"
-			     "	fmr	17, 0\n"
-			     "	fmr	18, 0\n"
-			     "	fmr	19, 0\n"
-			     "	fmr	20, 0\n"
-			     "	fmr	21, 0\n"
-			     "	fmr	22, 0\n"
-			     "	fmr	23, 0\n"
-			     "	fmr	24, 0\n"
-			     "	fmr	25, 0\n"
-			     "	fmr	26, 0\n"
-			     "	fmr	27, 0\n"
-			     "	fmr	28, 0\n"
-			     "	fmr	29, 0\n"
-			     "	fmr	30, 0\n"
-			     "	fmr	31, 0\n"::"m"(fpval));
-}
-
-#define FPTEST_REGVAL(n) {						\
-    	unsigned long long t;						\
-	__asm__ __volatile__("	stfd	" #n ", %0" : "=m" (t));	\
-	e[n] = (unsigned)t;						\
-	}
-
-static inline unsigned int fp_regs_check(int features, unsigned int val,
-					 int (*report)(const char *fmt, ...))
-{
-	unsigned int i, result = val;
-	unsigned int e[32];
-
-	FPTEST_REGVAL(0);
-	FPTEST_REGVAL(1);
-	FPTEST_REGVAL(2);
-	FPTEST_REGVAL(3);
-	FPTEST_REGVAL(4);
-	FPTEST_REGVAL(5);
-	FPTEST_REGVAL(6);
-	FPTEST_REGVAL(7);
-	FPTEST_REGVAL(8);
-	FPTEST_REGVAL(9);
-	FPTEST_REGVAL(10);
-	FPTEST_REGVAL(11);
-	FPTEST_REGVAL(12);
-	FPTEST_REGVAL(13);
-	FPTEST_REGVAL(14);
-	FPTEST_REGVAL(15);
-	FPTEST_REGVAL(16);
-	FPTEST_REGVAL(17);
-	FPTEST_REGVAL(18);
-	FPTEST_REGVAL(19);
-	FPTEST_REGVAL(20);
-	FPTEST_REGVAL(21);
-	FPTEST_REGVAL(22);
-	FPTEST_REGVAL(23);
-	FPTEST_REGVAL(24);
-	FPTEST_REGVAL(25);
-	FPTEST_REGVAL(26);
-	FPTEST_REGVAL(27);
-	FPTEST_REGVAL(28);
-	FPTEST_REGVAL(29);
-	FPTEST_REGVAL(30);
-	FPTEST_REGVAL(31);
-
-	for (i = 0; i < 32; i++)
-		if (e[i] != val) {
-			report("r%d: %u != %u\n", i, e[i], val);
-			result = e[i];
-		}
-
-	return result;
-}
-
-#else	/* __NO_FPRS__ */
-
-static inline void fp_regs_set(int features, unsigned int val) { }
-
-static inline unsigned int fp_regs_check(int features, unsigned int val,
-					 int (*report)(const char *fmt, ...))
-{
-	return val;
-}
-
-#endif	/* __NO_FPRS__ */
-
-#endif /* !_COBALT_POWERPC_ASM_UAPI_FPTEST_H */
diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/syscall.h b/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/syscall.h
deleted file mode 100644
index 243aeabe81..0000000000
--- a/kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/syscall.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * Copyright (C) 2001-2013 Philippe Gerum <rpm@xenomai.org>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-#ifndef _COBALT_POWERPC_ASM_UAPI_SYSCALL_H
-#define _COBALT_POWERPC_ASM_UAPI_SYSCALL_H
-
-#define __xn_syscode(__nr)	(__COBALT_SYSCALL_BIT | (__nr))
-
-#endif /* !_COBALT_POWERPC_ASM_UAPI_SYSCALL_H */
diff --git a/kernel/cobalt/arch/powerpc/ipipe/Makefile b/kernel/cobalt/arch/powerpc/ipipe/Makefile
deleted file mode 100644
index e175d0a3af..0000000000
--- a/kernel/cobalt/arch/powerpc/ipipe/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-
-obj-$(CONFIG_XENOMAI) += xenomai.o
-
-xenomai-y := machine.o thread.o
-
-xenomai-$(CONFIG_XENO_ARCH_FPU) += fpu.o
-
-ccflags-y := -I$(srctree)/arch/powerpc/xenomai/include -I$(srctree)/include/xenomai
diff --git a/kernel/cobalt/arch/powerpc/ipipe/README b/kernel/cobalt/arch/powerpc/ipipe/README
deleted file mode 100644
index 80f954aef6..0000000000
--- a/kernel/cobalt/arch/powerpc/ipipe/README
+++ /dev/null
@@ -1,3 +0,0 @@
-Get the interrupt pipeline code for the target kernel from
-http://xenomai.org/downloads/ipipe/, or
-git://git.xenomai.org/ipipe.git
diff --git a/kernel/cobalt/arch/powerpc/ipipe/fpu.S b/kernel/cobalt/arch/powerpc/ipipe/fpu.S
deleted file mode 100644
index 186e9226db..0000000000
--- a/kernel/cobalt/arch/powerpc/ipipe/fpu.S
+++ /dev/null
@@ -1,87 +0,0 @@
-/*
- * Copyright (C) 2004-2009 Philippe Gerum.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
- * USA; either version 2 of the License, or (at your option) any later
- * version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-
-#include <linux/version.h>
-#include <asm/processor.h>
-#include <asm/cputable.h>
-#include <asm/ppc_asm.h>
-#include <asm/asm-offsets.h>
-
-#ifdef THREAD_FPSTATE
-#define FIXUP_REG_FPSTATE(__reg)	addi	__reg, __reg, THREAD_FPSTATE
-#else
-/*
- * v3.10 -> v3.13 do not have THREAD_FPSTATE yet, but still
- * define THREAD_FPSCR.
- */
-#define FIXUP_REG_FPSTATE(__reg)
-#define	FPSTATE_FPSCR(__base)		THREAD_FPSCR(__base)
-#endif
-
-/* r3 = &thread_struct (tcb->fpup) */
-_GLOBAL(__asm_save_fpu)
-	mfmsr	r5
-	ori	r5,r5,MSR_FP
-	SYNC
-	MTMSRD(r5)
-	isync
-	FIXUP_REG_FPSTATE(r3)
-	SAVE_32FPRS(0,r3)
-	mffs	fr0
-	stfd	fr0,FPSTATE_FPSCR(r3)
-	blr
-
-/* r3 = &thread_struct */
-_GLOBAL(__asm_init_fpu)
-	mfmsr	r5
-	ori	r5,r5,MSR_FP|MSR_FE0|MSR_FE1
-	SYNC
-	MTMSRD(r5)
-
-	/* Fallback wanted. */
-	
-/* r3 = &thread_struct (tcb->fpup) */
-_GLOBAL(__asm_restore_fpu)
-	mfmsr	r5
-	ori	r5,r5,MSR_FP
-	SYNC
-	MTMSRD(r5)
-	isync
-	FIXUP_REG_FPSTATE(r3)
-	lfd	fr0,FPSTATE_FPSCR(r3)
-	MTFSF_L(fr0)
-	REST_32FPRS(0,r3)
-	blr
-
-_GLOBAL(__asm_disable_fpu)
-	mfmsr	r5
-	li	r3,MSR_FP
-	andc	r5,r5,r3
-	SYNC
-	MTMSRD(r5)
-	isync
-	blr
-
-_GLOBAL(__asm_enable_fpu)
-	mfmsr	r5
-	ori	r5,r5,MSR_FP
-	SYNC
-	MTMSRD(r5)
-	isync
-	blr
diff --git a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/calibration.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/calibration.h
deleted file mode 100644
index 9f06c3f053..0000000000
--- a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/calibration.h
+++ /dev/null
@@ -1,106 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004,2005 Philippe Gerum <rpm@xenomai.org>.
- *
- * 64-bit PowerPC adoption
- *   copyright (C) 2005 Taneli Vähäkangas and Heikki Lindholm
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_POWERPC_ASM_CALIBRATION_H
-#define _COBALT_POWERPC_ASM_CALIBRATION_H
-
-static inline void xnarch_get_latencies(struct xnclock_gravity *p)
-{
-#if CONFIG_XENO_OPT_TIMING_SCHEDLAT != 0
-#define __sched_latency CONFIG_XENO_OPT_TIMING_SCHEDLAT
-#elif defined(CONFIG_PPC_PASEMI)
-#define __sched_latency 1000
-#elif defined(CONFIG_WALNUT)
-#define __sched_latency 11000
-#elif defined(CONFIG_YOSEMITE)
-#define __sched_latency 2000
-#elif defined(CONFIG_BUBINGA)
-#define __sched_latency 8000
-#elif defined(CONFIG_SYCAMORE)
-#define __sched_latency 8000
-#elif defined(CONFIG_SEQUOIA)
-#define __sched_latency 3000
-#elif defined(CONFIG_LWMON5)
-#define __sched_latency 2800
-#elif defined(CONFIG_OCOTEA)
-#define __sched_latency 2700
-#elif defined(CONFIG_BAMBOO)
-#define __sched_latency 4000
-#elif defined(CONFIG_TAISHAN)
-#define __sched_latency 1800
-#elif defined(CONFIG_RAINIER)
-#define __sched_latency 2300
-#elif defined(CONFIG_YUCCA)
-#define __sched_latency 2780
-#elif defined(CONFIG_YELLOWSTONE)
-#define __sched_latency 2700
-#elif defined(CONFIG_YOSEMITE)
-#define __sched_latency 2500
-#elif defined(CONFIG_MPC8349_ITX)
-#define __sched_latency 2500
-#elif defined(CONFIG_MPC836x_MDS)
-#define __sched_latency 2900
-#elif defined(CONFIG_MPC5121_ADS)
-#define __sched_latency 4000
-#elif defined(CONFIG_MPC8272_ADS)
-#define __sched_latency 5500
-#elif defined(CONFIG_MPC85xx_RDB)
-#define __sched_latency 2000
-#elif defined(CONFIG_MVME7100)
-#define __sched_latency 1500
-#elif defined(CONFIG_TQM8548)
-#define __sched_latency 500
-#elif defined(CONFIG_TQM8560)
-#define __sched_latency 1000
-#elif defined(CONFIG_TQM8555)
-#define __sched_latency 2000
-#elif defined(CONFIG_KUP4K)
-#define __sched_latency 22000
-#elif defined(CONFIG_P1022_DS)
-#define __sched_latency 3000
-/*
- * Check for the most generic configs at the bottom of this list, so
- * that the most specific choices available are picked first.
- */
-#elif defined(CONFIG_CORENET_GENERIC)
-#define __sched_latency 2800
-#elif defined(CONFIG_MPC85xx) || defined(CONFIG_PPC_85xx)
-#define __sched_latency 1000
-#elif defined(CONFIG_405GPR)
-#define __sched_latency 9000
-#elif defined(CONFIG_PPC_MPC52xx)
-#define __sched_latency 4500
-#elif defined(CONFIG_PPC_8xx)
-#define __sched_latency 25000
-#endif
-
-#ifndef __sched_latency
-/* Platform is unknown: pick a default value. */
-#define __sched_latency 4000
-#endif
-	p->user = xnclock_ns_to_ticks(&nkclock, __sched_latency);
-	p->kernel = xnclock_ns_to_ticks(&nkclock, CONFIG_XENO_OPT_TIMING_KSCHEDLAT);
-	p->irq = xnclock_ns_to_ticks(&nkclock, CONFIG_XENO_OPT_TIMING_IRQLAT);
-}
-
-#undef __sched_latency
-
-#endif /* !_COBALT_POWERPC_ASM_CALIBRATION_H */
diff --git a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/features.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/features.h
deleted file mode 100644
index 03f93a26da..0000000000
--- a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/features.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_POWERPC_ASM_FEATURES_H
-#define _COBALT_POWERPC_ASM_FEATURES_H
-
-struct cobalt_featinfo;
-static inline void collect_arch_features(struct cobalt_featinfo *p) { }
-
-#include <asm/xenomai/uapi/features.h>
-
-#endif /* !_COBALT_POWERPC_ASM_FEATURES_H */
diff --git a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/fptest.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/fptest.h
deleted file mode 100644
index e09ca2c3be..0000000000
--- a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/fptest.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- * Copyright (C) 2006 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_POWERPC_ASM_FPTEST_H
-#define _COBALT_POWERPC_ASM_FPTEST_H
-
-#include <linux/errno.h>
-#include <linux/printk.h>
-#include <asm/xenomai/uapi/fptest.h>
-
-static inline int fp_kernel_supported(void)
-{
-/*
- * CAUTION: some architectures have a hardware FP unit, but a
- * restricted set of supported FP instructions. Those may enable
- * CONFIG_MATH_EMULATION and MATH_EMULATION_HW_UNIMPLEMENTED at the
- * same time to provide an emulation of the missing instruction set.
- */
-#ifdef CONFIG_PPC_FPU
-	return 1;
-#else
-#ifdef CONFIG_MATH_EMULATION
-	printk_once(XENO_WARNING "kernel-based FPU support is disabled\n");
-#endif	/* !CONFIG_MATH_EMULATION */
-	return 0;
-#endif	/* !CONFIG_PPC_FPU */
-}
-
-static inline int fp_linux_begin(void)
-{
-	return -ENOSYS;
-}
-
-static inline void fp_linux_end(void)
-{
-}
-
-static inline int fp_detect(void)
-{
-	return 0;
-}
-
-#endif /* !_COBALT_POWERPC_ASM_FPTEST_H */
diff --git a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/machine.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/machine.h
deleted file mode 100644
index 0e41fd6c9e..0000000000
--- a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/machine.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/**
- *   Copyright &copy; 2002-2004 Philippe Gerum.
- *
- *   64-bit PowerPC adoption
- *     copyright (C) 2005 Taneli Vähäkangas and Heikki Lindholm
- *
- *   Xenomai is free software; you can redistribute it and/or
- *   modify it under the terms of the GNU General Public License as
- *   published by the Free Software Foundation, Inc., 675 Mass Ave,
- *   Cambridge MA 02139, USA; either version 2 of the License, or (at
- *   your option) any later version.
- *
- *   Xenomai is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *   General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with Xenomai; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- *   02111-1307, USA.
- */
-#ifndef _COBALT_POWERPC_ASM_MACHINE_H
-#define _COBALT_POWERPC_ASM_MACHINE_H
-
-#include <linux/compiler.h>
-
-#define XNARCH_HOST_TICK_IRQ	__ipipe_hrtimer_irq
-
-static inline __attribute_const__ unsigned long ffnz(unsigned long ul)
-{
-	__asm__ ("cntlzw %0, %1":"=r"(ul):"r"(ul & (-ul)));
-	return 31 - ul;
-}
-
-/* Read this last to enable default settings. */
-#include <asm-generic/xenomai/machine.h>
-
-#endif /* !_COBALT_POWERPC_ASM_MACHINE_H */
diff --git a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/syscall.h
deleted file mode 100644
index 9b166ad1b6..0000000000
--- a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/syscall.h
+++ /dev/null
@@ -1,83 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
- *
- * 64-bit PowerPC adoption
- *   copyright (C) 2005 Taneli Vähäkangas and Heikki Lindholm
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_POWERPC_ASM_SYSCALL_H
-#define _COBALT_POWERPC_ASM_SYSCALL_H
-
-#include <linux/errno.h>
-#include <linux/ptrace.h>
-#include <asm-generic/xenomai/syscall.h>
-
-/*
- * Cobalt and Linux syscall numbers can be fetched from GPR0, masking
- * out the __COBALT_SYSCALL_BIT marker.
- */
-#define __xn_reg_sys(__regs)	((__regs)->gpr[0])
-#define __xn_syscall_p(__regs)	(__xn_reg_sys(__regs) & __COBALT_SYSCALL_BIT)
-#define __xn_syscall(__regs)	(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT)
-
-#define __xn_reg_rval(__regs)	((__regs)->gpr[3])
-#define __xn_reg_arg1(__regs)	((__regs)->gpr[3])
-#define __xn_reg_arg2(__regs)	((__regs)->gpr[4])
-#define __xn_reg_arg3(__regs)	((__regs)->gpr[5])
-#define __xn_reg_arg4(__regs)	((__regs)->gpr[6])
-#define __xn_reg_arg5(__regs)	((__regs)->gpr[7])
-#define __xn_reg_pc(__regs)	((__regs)->nip)
-#define __xn_reg_sp(__regs)	((__regs)->gpr[1])
-
-/*
- * Root syscall number with predicate (valid only if
- * !__xn_syscall_p(__regs)).
- */
-#define __xn_rootcall_p(__regs, __code)			\
-	({						\
-		*(__code) = __xn_syscall(__regs);	\
-		*(__code) < NR_syscalls;		\
-	})
-
-static inline void __xn_error_return(struct pt_regs *regs, int v)
-{
-	/*
-	 * We currently never set the SO bit for marking errors, even
-	 * if we always test it upon syscall return.
-	 */
-	__xn_reg_rval(regs) = v;
-}
-
-static inline void __xn_status_return(struct pt_regs *regs, long v)
-{
-	__xn_reg_rval(regs) = v;
-}
-
-static inline int __xn_interrupted_p(struct pt_regs *regs)
-{
-	return __xn_reg_rval(regs) == -EINTR;
-}
-
-static inline
-int xnarch_local_syscall(unsigned long a1, unsigned long a2,
-			 unsigned long a3, unsigned long a4,
-			 unsigned long a5)
-{
-	return -ENOSYS;
-}
-
-#endif /* !_COBALT_POWERPC_ASM_SYSCALL_H */
diff --git a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/syscall32.h
deleted file mode 100644
index 15c977c316..0000000000
--- a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/syscall32.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright (C) 2014 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_POWERPC_ASM_SYSCALL32_H
-#define _COBALT_POWERPC_ASM_SYSCALL32_H
-
-#include <asm-generic/xenomai/syscall32.h>
-
-#endif /* !_COBALT_POWERPC_ASM_SYSCALL32_H */
diff --git a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/thread.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/thread.h
deleted file mode 100644
index f91e26b367..0000000000
--- a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/thread.h
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- * Copyright (C) 2004-2013 Philippe Gerum.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_POWERPC_ASM_THREAD_H
-#define _COBALT_POWERPC_ASM_THREAD_H
-
-#include <asm-generic/xenomai/ipipe/thread.h>
-
-struct xnarchtcb {
-	struct xntcb core;
-#ifdef CONFIG_XENO_ARCH_FPU
-	struct thread_struct *fpup;
-#define xnarch_fpu_ptr(tcb)     ((tcb)->fpup)
-#else
-#define xnarch_fpu_ptr(tcb)     NULL
-#endif
-};
-
-#define xnarch_fault_regs(d)	((d)->regs)
-#define xnarch_fault_trap(d)    ((unsigned int)(d)->regs->trap)
-#define xnarch_fault_code(d)    ((d)->regs->dar)
-#define xnarch_fault_pc(d)      ((d)->regs->nip)
-#define xnarch_fault_pc(d)      ((d)->regs->nip)
-#define xnarch_fault_fpu_p(d)   0
-#define xnarch_fault_pf_p(d)   ((d)->exception == IPIPE_TRAP_ACCESS)
-#define xnarch_fault_bp_p(d)   ((current->ptrace & PT_PTRACED) &&	\
-				((d)->exception == IPIPE_TRAP_IABR ||	\
-				 (d)->exception == IPIPE_TRAP_SSTEP ||	\
-				 (d)->exception == IPIPE_TRAP_DEBUG))
-#define xnarch_fault_notify(d) (xnarch_fault_bp_p(d) == 0)
-
-static inline
-struct task_struct *xnarch_host_task(struct xnarchtcb *tcb)
-{
-	return tcb->core.host_task;
-}
-
-static inline void xnarch_enter_root(struct xnthread *root) { }
-
-#ifdef CONFIG_XENO_ARCH_FPU
-
-void xnarch_init_root_tcb(struct xnthread *thread);
-
-void xnarch_init_shadow_tcb(struct xnthread *thread);
-
-void xnarch_leave_root(struct xnthread *root);
-
-#else  /* !CONFIG_XENO_ARCH_FPU */
-
-static inline void xnarch_init_root_tcb(struct xnthread *thread) { }
-static inline void xnarch_init_shadow_tcb(struct xnthread *thread) { }
-static inline void xnarch_leave_root(struct xnthread *root) { }
-
-#endif  /* !CONFIG_XENO_ARCH_FPU */
-
-static inline int 
-xnarch_handle_fpu_fault(struct xnthread *from, 
-			struct xnthread *to, struct ipipe_trap_data *d)
-{
-	return 0;
-}
-
-static inline int xnarch_escalate(void)
-{
-	if (ipipe_root_p) {
-		ipipe_raise_irq(cobalt_pipeline.escalate_virq);
-		return 1;
-	}
-
-	return 0;
-}
-
-void xnarch_switch_to(struct xnthread *out, struct xnthread *in);
-
-void xnarch_switch_fpu(struct xnthread *from, struct xnthread *thread);
-
-#endif /* !_COBALT_POWERPC_ASM_THREAD_H */
diff --git a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/wrappers.h b/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/wrappers.h
deleted file mode 100644
index f0ae0e4d30..0000000000
--- a/kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/wrappers.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright (C) 2005 Philippe Gerum <rpm@xenomai.org>.
- *
- * Xenomai is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published
- * by the Free Software Foundation; either version 2 of the License,
- * or (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-#ifndef _COBALT_POWERPC_ASM_WRAPPERS_H
-#define _COBALT_POWERPC_ASM_WRAPPERS_H
-
-#include <asm-generic/xenomai/wrappers.h>	/* Read the generic portion. */
-
-#endif /* _COBALT_POWERPC_ASM_WRAPPERS_H */
diff --git a/kernel/cobalt/arch/powerpc/ipipe/machine.c b/kernel/cobalt/arch/powerpc/ipipe/machine.c
deleted file mode 100644
index 14e2c4f90a..0000000000
--- a/kernel/cobalt/arch/powerpc/ipipe/machine.c
+++ /dev/null
@@ -1,67 +0,0 @@
-/**
- *   Copyright (C) 2004-2006 Philippe Gerum.
- *
- *   64-bit PowerPC adoption
- *     copyright (C) 2005 Taneli Vähäkangas and Heikki Lindholm
- *
- *   Xenomai is free software; you can redistribute it and/or
- *   modify it under the terms of the GNU General Public License as
- *   published by the Free Software Foundation, Inc., 675 Mass Ave,
- *   Cambridge MA 02139, USA; either version 2 of the License, or (at
- *   your option) any later version.
- *
- *   Xenomai is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *   General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- *   02111-1307, USA.
- */
-#include <linux/stddef.h>
-#include <asm/cputable.h>
-#include <asm/xenomai/machine.h>
-
-static int mach_powerpc_init(void)
-{
-#ifdef CONFIG_ALTIVEC
-	if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
-		printk("Xenomai: ALTIVEC support enabled in kernel but no hardware found.\n"
-		       "         Disable CONFIG_ALTIVEC in the kernel configuration.\n");
-		return -ENODEV;
-	}
-#endif /* CONFIG_ALTIVEC */
-
-	return 0;
-}
-
-static const char *const fault_labels[] = {
-	[0] = "Data or instruction access",
-	[1] = "Alignment",
-	[2] = "Altivec unavailable",
-	[3] = "Program check exception",
-	[4] = "Machine check exception",
-	[5] = "Unknown",
-	[6] = "Instruction breakpoint",
-	[7] = "Run mode exception",
-	[8] = "Single-step exception",
-	[9] = "Non-recoverable exception",
-	[10] = "Software emulation",
-	[11] = "Debug",
-	[12] = "SPE",
-	[13] = "Altivec assist",
-	[14] = "Cache-locking exception",
-	[15] = "Kernel FP unavailable",
-	[16] = NULL
-};
-
-struct cobalt_machine cobalt_machine = {
-	.name = "powerpc",
-	.init = mach_powerpc_init,
-	.late_init = NULL,
-	.cleanup = NULL,
-	.prefault = NULL,
-	.fault_labels = fault_labels,
-};
diff --git a/kernel/cobalt/arch/powerpc/ipipe/thread.c b/kernel/cobalt/arch/powerpc/ipipe/thread.c
deleted file mode 100644
index 6ce2787577..0000000000
--- a/kernel/cobalt/arch/powerpc/ipipe/thread.c
+++ /dev/null
@@ -1,174 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
- *
- * 64-bit PowerPC adoption
- *   copyright (C) 2005 Taneli Vähäkangas and Heikki Lindholm
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
- * 02111-1307, USA.
- */
-
-#include <linux/sched.h>
-#include <linux/ipipe.h>
-#include <linux/mm.h>
-#include <asm/mmu_context.h>
-#include <cobalt/kernel/thread.h>
-
-asmlinkage struct task_struct *
-_switch(struct thread_struct *prev, struct thread_struct *next);
-
-void xnarch_switch_to(struct xnthread *out, struct xnthread *in)
-{
-	struct xnarchtcb *out_tcb = &out->tcb, *in_tcb = &in->tcb;
-	struct mm_struct *prev_mm, *next_mm;
-	struct task_struct *next;
-
-	next = in_tcb->core.host_task;
-	prev_mm = out_tcb->core.active_mm;
-
-	next_mm = in_tcb->core.mm;
-	if (next_mm == NULL) {
-		in_tcb->core.active_mm = prev_mm;
-		enter_lazy_tlb(prev_mm, next);
-	} else {
-		ipipe_switch_mm_head(prev_mm, next_mm, next);
-		/*
-		 * We might be switching back to the root thread,
-		 * which we preempted earlier, shortly after "current"
-		 * dropped its mm context in the do_exit() path
-		 * (next->mm == NULL). In that particular case, the
-		 * kernel expects a lazy TLB state for leaving the mm.
-		 */
-		if (next->mm == NULL)
-			enter_lazy_tlb(prev_mm, next);
-	}
-
-	hard_local_irq_disable();
-	_switch(out_tcb->core.tsp, in_tcb->core.tsp);
-}
-
-#ifdef CONFIG_XENO_ARCH_FPU
-
-asmlinkage void __asm_init_fpu(struct thread_struct *ts);
-
-asmlinkage void __asm_save_fpu(struct thread_struct *ts);
-
-asmlinkage void __asm_restore_fpu(struct thread_struct *ts);
-
-asmlinkage void __asm_disable_fpu(void);
-
-asmlinkage void __asm_enable_fpu(void);
-
-#if !defined(CONFIG_SMP) && LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
-#define get_fpu_owner(cur) last_task_used_math
-#else /* CONFIG_SMP */
-#define get_fpu_owner(cur) ({					\
-    struct task_struct * _cur = (cur);                          \
-    ((_cur->thread.regs && (_cur->thread.regs->msr & MSR_FP))   \
-     ? _cur : NULL);                                            \
-})
-#endif /* CONFIG_SMP */
-
-static void xnarch_enable_fpu(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-	struct task_struct *task = tcb->core.host_task;
-
-	if (task && task != tcb->core.user_fpu_owner)
-		__asm_disable_fpu();
-	else
-		__asm_enable_fpu();
-}
-
-static void do_save_fpu(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-
-	if (tcb->fpup) {
-		__asm_save_fpu(tcb->fpup);
-
-		if (tcb->core.user_fpu_owner &&
-		    tcb->core.user_fpu_owner->thread.regs)
-			tcb->core.user_fpu_owner->thread.regs->msr &= ~(MSR_FP|MSR_FE0|MSR_FE1);
-	}
-}
-
-static void xnarch_restore_fpu(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = xnthread_archtcb(thread);
-	struct thread_struct *ts;
-	struct pt_regs *regs;
-
-	if (tcb->fpup) {
-		__asm_restore_fpu(tcb->fpup);
-		/*
-		 * Note: Only enable FP in MSR, if it was enabled when
-		 * we saved the fpu state.
-		 */
-		if (tcb->core.user_fpu_owner) {
-			ts = &tcb->core.user_fpu_owner->thread;
-			regs = ts->regs;
-			if (regs) {
-				regs->msr &= ~(MSR_FE0|MSR_FE1);
-				regs->msr |= (MSR_FP|ts->fpexc_mode);
-			}
-		}
-	}
-	/*
-	 * FIXME: We restore FPU "as it was" when Xenomai preempted Linux,
-	 * whereas we could be much lazier.
-	 */
-	if (tcb->core.host_task &&
-	    tcb->core.host_task != tcb->core.user_fpu_owner)
-		__asm_disable_fpu();
-}
-
-void xnarch_switch_fpu(struct xnthread *from, struct xnthread *to)
-{
-	if (from == to || 
-		xnarch_fpu_ptr(xnthread_archtcb(from)) == 
-		xnarch_fpu_ptr(xnthread_archtcb(to))) {
-		xnarch_enable_fpu(to);
-		return;
-	}
-	
-	if (from)
-		do_save_fpu(from);
-	
-	xnarch_restore_fpu(to);
-}
-
-void xnarch_leave_root(struct xnthread *root)
-{
-	struct xnarchtcb *rootcb = xnthread_archtcb(root);
-	rootcb->core.user_fpu_owner = get_fpu_owner(rootcb->core.host_task);
-	/* So that do_save_fpu() operates on the right FPU area. */
-	rootcb->fpup = rootcb->core.user_fpu_owner ?
-		&rootcb->core.user_fpu_owner->thread : NULL;
-}
-
-void xnarch_init_root_tcb(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = &thread->tcb;
-	tcb->fpup = NULL;
-}
-
-void xnarch_init_shadow_tcb(struct xnthread *thread)
-{
-	struct xnarchtcb *tcb = &thread->tcb;
-	tcb->fpup = &tcb->core.host_task->thread;
-}
-
-#endif /* CONFIG_XENO_ARCH_FPU */
diff --git a/lib/cobalt/arch/Makefile.am b/lib/cobalt/arch/Makefile.am
index e0244f9345..0fd99f3531 100644
--- a/lib/cobalt/arch/Makefile.am
+++ b/lib/cobalt/arch/Makefile.am
@@ -1,4 +1,4 @@
 
 SUBDIRS = @XENO_TARGET_ARCH@
 
-DIST_SUBDIRS = arm arm64 powerpc x86
+DIST_SUBDIRS = arm arm64 x86
diff --git a/lib/cobalt/arch/powerpc/Makefile.am b/lib/cobalt/arch/powerpc/Makefile.am
deleted file mode 100644
index a5095be3d0..0000000000
--- a/lib/cobalt/arch/powerpc/Makefile.am
+++ /dev/null
@@ -1,13 +0,0 @@
-noinst_LTLIBRARIES = libarch.la
-
-libarch_la_LDFLAGS = @XENO_LIB_LDFLAGS@
-
-libarch_la_SOURCES = features.c
-
-libarch_la_CPPFLAGS =			\
-	@XENO_COBALT_CFLAGS@ 		\
-	-I$(srcdir)/../..		\
-	-I$(top_srcdir)/include/cobalt	\
-	-I$(top_srcdir)/include
-
-SUBDIRS = include
diff --git a/lib/cobalt/arch/powerpc/features.c b/lib/cobalt/arch/powerpc/features.c
deleted file mode 100644
index d795a198a8..0000000000
--- a/lib/cobalt/arch/powerpc/features.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Copyright (C) 2013 Philippe Gerum <rpm@xenomai.org>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
-
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-
-#include <asm/xenomai/syscall.h>
-#include "internal.h"
-
-void cobalt_arch_check_features(struct cobalt_featinfo *finfo)
-{
-}
diff --git a/lib/cobalt/arch/powerpc/include/Makefile.am b/lib/cobalt/arch/powerpc/include/Makefile.am
deleted file mode 100644
index 5cac5d2da1..0000000000
--- a/lib/cobalt/arch/powerpc/include/Makefile.am
+++ /dev/null
@@ -1,2 +0,0 @@
-
-SUBDIRS = asm
diff --git a/lib/cobalt/arch/powerpc/include/asm/Makefile.am b/lib/cobalt/arch/powerpc/include/asm/Makefile.am
deleted file mode 100644
index 55ea661244..0000000000
--- a/lib/cobalt/arch/powerpc/include/asm/Makefile.am
+++ /dev/null
@@ -1,2 +0,0 @@
-
-SUBDIRS = xenomai
diff --git a/lib/cobalt/arch/powerpc/include/asm/xenomai/Makefile.am b/lib/cobalt/arch/powerpc/include/asm/xenomai/Makefile.am
deleted file mode 100644
index d308b06e62..0000000000
--- a/lib/cobalt/arch/powerpc/include/asm/xenomai/Makefile.am
+++ /dev/null
@@ -1,5 +0,0 @@
-
-noinst_HEADERS =	\
-	features.h	\
-	syscall.h	\
-	tsc.h
diff --git a/lib/cobalt/arch/powerpc/include/asm/xenomai/features.h b/lib/cobalt/arch/powerpc/include/asm/xenomai/features.h
deleted file mode 100644
index 4b75707902..0000000000
--- a/lib/cobalt/arch/powerpc/include/asm/xenomai/features.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2013 Philippe Gerum <rpm@xenomai.org>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-#ifndef _LIB_COBALT_POWERPC_FEATURES_H
-#define _LIB_COBALT_POWERPC_FEATURES_H
-
-#include_next <features.h>
-#include <xeno_config.h>
-#include <asm/xenomai/uapi/features.h>
-
-static inline int cobalt_fp_detect(void)
-{
-	return 0;
-}
-
-#endif /* !_LIB_COBALT_POWERPC_FEATURES_H */
diff --git a/lib/cobalt/arch/powerpc/include/asm/xenomai/syscall.h b/lib/cobalt/arch/powerpc/include/asm/xenomai/syscall.h
deleted file mode 100644
index 1330c5d0b6..0000000000
--- a/lib/cobalt/arch/powerpc/include/asm/xenomai/syscall.h
+++ /dev/null
@@ -1,82 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
-
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-
-#ifndef _LIB_COBALT_POWERPC_SYSCALL_H
-#define _LIB_COBALT_POWERPC_SYSCALL_H
-
-#include <cobalt/uapi/syscall.h>
-
-/* Some code pulled from glibc's inline syscalls. */
-
-#define LOADARGS_0(syscode, dummy...)			\
-	__sc_0 = (unsigned long)(syscode)
-#define LOADARGS_1(syscode, arg1)			\
-	LOADARGS_0(syscode);				\
-	__sc_3 = (unsigned long) (arg1)
-#define LOADARGS_2(syscode, arg1, arg2)			\
-	LOADARGS_1(syscode, arg1);			\
-	__sc_4 = (unsigned long) (arg2)
-#define LOADARGS_3(syscode, arg1, arg2, arg3)		\
-	LOADARGS_2(syscode, arg1, arg2);		\
-	__sc_5 = (unsigned long) (arg3)
-#define LOADARGS_4(syscode, arg1, arg2, arg3, arg4)	\
-	LOADARGS_3(syscode, arg1, arg2, arg3);		\
-	__sc_6 = (unsigned long) (arg4)
-#define LOADARGS_5(syscode, arg1, arg2, arg3, arg4, arg5) \
-	LOADARGS_4(syscode, arg1, arg2, arg3, arg4);	\
-	__sc_7 = (unsigned long) (arg5)
-
-#define ASM_INPUT_0 "0" (__sc_0)
-#define ASM_INPUT_1 ASM_INPUT_0, "1" (__sc_3)
-#define ASM_INPUT_2 ASM_INPUT_1, "2" (__sc_4)
-#define ASM_INPUT_3 ASM_INPUT_2, "3" (__sc_5)
-#define ASM_INPUT_4 ASM_INPUT_3, "4" (__sc_6)
-#define ASM_INPUT_5 ASM_INPUT_4, "5" (__sc_7)
-
-#define XENOMAI_DO_SYSCALL(nr, op, args...)			\
-  ({								\
-	register unsigned long __sc_0  __asm__ ("r0");		\
-	register unsigned long __sc_3  __asm__ ("r3");		\
-	register unsigned long __sc_4  __asm__ ("r4");		\
-	register unsigned long __sc_5  __asm__ ("r5");		\
-	register unsigned long __sc_6  __asm__ ("r6");		\
-	register unsigned long __sc_7  __asm__ ("r7");		\
-								\
-	LOADARGS_##nr(__xn_syscode(op), args);			\
-	__asm__ __volatile__					\
-		("sc           \n\t"				\
-		 "mfcr %0      "				\
-		: "=&r" (__sc_0),				\
-		  "=&r" (__sc_3),  "=&r" (__sc_4),		\
-		  "=&r" (__sc_5),  "=&r" (__sc_6),		\
-		  "=&r" (__sc_7)				\
-		: ASM_INPUT_##nr				\
-		: "cr0", "ctr", "memory",			\
-		  "r8", "r9", "r10","r11", "r12");		\
-	(int)((__sc_0 & (1 << 28)) ? -__sc_3 : __sc_3);		\
-  })
-
-#define XENOMAI_SYSCALL0(op)                XENOMAI_DO_SYSCALL(0,op)
-#define XENOMAI_SYSCALL1(op,a1)             XENOMAI_DO_SYSCALL(1,op,a1)
-#define XENOMAI_SYSCALL2(op,a1,a2)          XENOMAI_DO_SYSCALL(2,op,a1,a2)
-#define XENOMAI_SYSCALL3(op,a1,a2,a3)       XENOMAI_DO_SYSCALL(3,op,a1,a2,a3)
-#define XENOMAI_SYSCALL4(op,a1,a2,a3,a4)    XENOMAI_DO_SYSCALL(4,op,a1,a2,a3,a4)
-#define XENOMAI_SYSCALL5(op,a1,a2,a3,a4,a5) XENOMAI_DO_SYSCALL(5,op,a1,a2,a3,a4,a5)
-#define XENOMAI_SYSBIND(breq)               XENOMAI_DO_SYSCALL(1,sc_cobalt_bind,breq)
-
-#endif /* !_LIB_COBALT_POWERPC_SYSCALL_H */
diff --git a/lib/cobalt/arch/powerpc/include/asm/xenomai/time.h b/lib/cobalt/arch/powerpc/include/asm/xenomai/time.h
deleted file mode 100644
index 92ba44b5a1..0000000000
--- a/lib/cobalt/arch/powerpc/include/asm/xenomai/time.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Copyright (C) 2021 Philippe Gerum <rpm@xenomai.org>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- */
-
-#ifndef _LIB_COBALT_POWERPC_TIME_H
-#define _LIB_COBALT_POWERPC_TIME_H
-
-#define COBALT_VDSO_VERSION	"LINUX_2.6.15"
-#define COBALT_VDSO_GETTIME	"__kernel_clock_gettime"
-
-#endif /* !_LIB_COBALT_POWERPC_TIME_H */
diff --git a/lib/cobalt/arch/powerpc/include/asm/xenomai/tsc.h b/lib/cobalt/arch/powerpc/include/asm/xenomai/tsc.h
deleted file mode 100644
index b4ff852185..0000000000
--- a/lib/cobalt/arch/powerpc/include/asm/xenomai/tsc.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * Copyright (C) 2001,2002,2003,2004 Philippe Gerum <rpm@xenomai.org>.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
- */
-#ifndef _LIB_COBALT_POWERPC_TSC_H
-#define _LIB_COBALT_POWERPC_TSC_H
-
-static inline unsigned long long cobalt_read_legacy_tsc(void)
-{
-	union {
-		unsigned long long t;
-		unsigned long v[2];
-	} u;
-	unsigned long __tbu;
-
-	__asm__ __volatile__("1: mfspr %0,269\n"
-			     "mfspr %1,268\n"
-			     "mfspr %2,269\n"
-			     "cmpw %2,%0\n"
-			     "bne- 1b\n":"=r"(u.v[0]),
-			     "=r"(u.v[1]), "=r"(__tbu));
-	return u.t;
-}
-
-#endif /* !_LIB_COBALT_POWERPC_TSC_H */
diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 64e2484e16..11aa72fc41 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -285,9 +285,6 @@ while : ; do
    x86*|i*86|amd*)
       linux_arch=x86
       ;;
-   powerpc*|ppc*)
-      linux_arch=powerpc
-      ;;
    arm)
       linux_arch=arm
       ;;
-- 
2.31.1


