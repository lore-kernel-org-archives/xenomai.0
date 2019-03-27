From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 1/8] ipipe: Revert changes to ARM arch_timer_set_cntkctl
Date: Wed, 27 Mar 2019 14:18:00 +0100
Message-Id: <f2da022eceaa995be3dab347235954ad637144e4.1553692686.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1553692686.git.jan.kiszka@siemens.com>
References: <cover.1553692686.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1553692686.git.jan.kiszka@siemens.com>
References: <cover.1553692686.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This belongs into the ARM tree.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/include/asm/arch_timer.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index e9e7656bc137..9327e3a101dc 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -106,10 +106,6 @@ static inline u32 arch_timer_get_cntkctl(void)
 
 static inline void arch_timer_set_cntkctl(u32 cntkctl)
 {
-#ifdef CONFIG_IPIPE
-	/* Enable access to user-space (may not be needed) */
-	cntkctl |= ARCH_TIMER_USR_PCT_ACCESS_EN;
-#endif
 	asm volatile("mcr p15, 0, %0, c14, c1, 0" : : "r" (cntkctl));
 }
 
-- 
2.16.4


