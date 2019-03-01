From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ARM/ARM64: ipipe: Enable access to arch timer from user-space
Message-ID: <3f7612eb-07a0-166b-0ce6-dd6d4bfd8ee2@siemens.com>
Date: Fri, 1 Mar 2019 13:03:16 +0100
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to expose the timer as clocksource directly to user-space by
memory-mapping its registers.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

To be applied when splitting b597d0dec360 or after importing the partial
revert of it from noarch.

 arch/arm/include/asm/arch_timer.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 9327e3a101dc..e9e7656bc137 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -106,6 +106,10 @@ static inline u32 arch_timer_get_cntkctl(void)
 
 static inline void arch_timer_set_cntkctl(u32 cntkctl)
 {
+#ifdef CONFIG_IPIPE
+	/* Enable access to user-space (may not be needed) */
+	cntkctl |= ARCH_TIMER_USR_PCT_ACCESS_EN;
+#endif
 	asm volatile("mcr p15, 0, %0, c14, c1, 0" : : "r" (cntkctl));
 }
 
-- 
2.16.4

