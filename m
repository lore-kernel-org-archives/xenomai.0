From: Fabian Godehardt <fg@domain.hid>
Date: Wed, 11 Nov 2009 12:41:49 +0100
Message-Id: <1257939709-28983-1-git-send-email-fg@domain.hid>
Subject: [Xenomai-core] [PATCH] scripts: use new 'head -n' syntax.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Executing configure on a chroot which uses a modern equivalent of
_POSIX_VERSION breaks on scripts/prepare-kernel.sh:

  patching file mm/vmalloc.c
  head: `-1' option is obsolete; use `-n 1'
  Try `head --help' for more information.

This patch converts prepare-kernel.sh to the new 'head -n' syntax.

Signed-off-by: Fabian Godehardt <fg@domain.hid>
---
 scripts/prepare-kernel.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index d499563..b052ec3 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -408,10 +408,10 @@ if test -r $linux_tree/arch/$linux_arch/include/asm/ipipe.h; then
    asm_ipipe_h=$linux_tree/$linux_include_asm/ipipe.h
 else
    linux_include_asm=include/asm-$linux_arch
-   asm_ipipe_h=`ls $linux_tree/include/asm-{$linux_arch,$xenomai_arch}/ipipe.h 2>/dev/null|head -1`
+   asm_ipipe_h=`ls $linux_tree/include/asm-{$linux_arch,$xenomai_arch}/ipipe.h 2>/dev/null|head -n1`
 fi
 
-adeos_version=`grep '^#define.*IPIPE_ARCH_STRING.*"' $asm_ipipe_h 2>/dev/null|head -1|sed -e 's,.*"\(.*\)"$,\1,'`
+adeos_version=`grep '^#define.*IPIPE_ARCH_STRING.*"' $asm_ipipe_h 2>/dev/null|head -n1|sed -e 's,.*"\(.*\)"$,\1,'`
 
 if test \! "x$adeos_version" = x; then
    if test x$verbose = x1; then
-- 
1.5.3.7


