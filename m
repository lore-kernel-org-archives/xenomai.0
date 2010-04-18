From: Jan Kiszka <Jan Kiszka jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 15:12:38 +0200
Message-Id: <f52f79b5c80fa09fe861a3b2833746b513986238.1271596367.git.Jan
	Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH v3 14/24] irqbench: Fix x86-64 build
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 configure.in                       |    2 +-
 src/testsuite/irqbench/Makefile.am |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.in b/configure.in
index 0228f51..9d6fe35 100644
--- a/configure.in
+++ b/configure.in
@@ -127,7 +127,7 @@ case "$build_for" in
 esac
 
 AC_MSG_RESULT([$XENO_TARGET_ARCH])
-AM_CONDITIONAL(XENO_LINUX_ARCH_I386,[test $XENO_LINUX_ARCH = i386])
+AM_CONDITIONAL(XENO_TARGET_ARCH_X86,[test $XENO_TARGET_ARCH = x86])
 
 case "$XENO_TARGET_ARCH" in
  nios2)
diff --git a/src/testsuite/irqbench/Makefile.am b/src/testsuite/irqbench/Makefile.am
index 27c5ddb..3e531c7 100644
--- a/src/testsuite/irqbench/Makefile.am
+++ b/src/testsuite/irqbench/Makefile.am
@@ -5,7 +5,7 @@ CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
 
 test_PROGRAMS = irqloop
 
-if XENO_LINUX_ARCH_I386
+if XENO_TARGET_ARCH_X86
 test_PROGRAMS += irqbench
 endif
 
-- 
1.6.0.2


