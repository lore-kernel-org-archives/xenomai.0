From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Thu,  6 May 2010 10:08:56 +0200
Message-Id: <1273133336-9802-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH] Fix x86_64 builds with CC_STACKPROTECTOR
	enabled
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: jan.kiszka@domain.hid, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

From: Wolfgang Mauerer (none) <wolfgang@domain.hid>

The per_cpu__ prefix for per-cpu-variables in the Linux kernel
is gone since dd17c8f72993f. This patch adapts the x86_64
task switching code to cope with kernels before and after this
commit.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Acked-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-x86/switch_64.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/asm-x86/switch_64.h b/include/asm-x86/switch_64.h
index a716ad6..c2df7d8 100644
--- a/include/asm-x86/switch_64.h
+++ b/include/asm-x86/switch_64.h
@@ -37,6 +37,10 @@ struct xnarch_x8664_initstack {
 };
 
 #ifdef CONFIG_CC_STACKPROTECTOR
+#include <asm/percpu.h>
+#ifndef per_cpu_var
+#define per_cpu_var(x)	x
+#endif
 /*
  * We have an added complexity with -fstack-protector, due to the
  * hybrid scheduling between user- and kernel-based Xenomai threads,
-- 
1.7.0.4


