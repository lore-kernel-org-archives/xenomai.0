From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Thu,  8 Jul 2010 12:18:16 +0200
Message-Id: <1278584301-8064-3-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1278584301-8064-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1278584301-8064-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH 2/7] nucleus: Add userland cpu_relax()
	definition for x86
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

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-x86/atomic.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/asm-x86/atomic.h b/include/asm-x86/atomic.h
index bb3ce46..16bc990 100644
--- a/include/asm-x86/atomic.h
+++ b/include/asm-x86/atomic.h
@@ -71,6 +71,11 @@ typedef struct { unsigned long counter; } xnarch_atomic_t;
 
 #define xnarch_write_memory_barrier()	xnarch_memory_barrier()
 
+static inline void cpu_relax(void)
+{
+	asm volatile("rep; nop" ::: "memory");
+}
+
 #ifdef __i386__
 
 struct __xeno_xchg_dummy { unsigned long a[100]; };
-- 
1.6.4


