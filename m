From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Wed, 12 Sep 2012 19:00:34 +0200
Message-Id: <1347469235-17712-3-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1347469235-17712-1-git-send-email-wolfgang.mauerer@siemens.com>
References: <1347469235-17712-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PATCH 2/3] ipipe, x86: Introduce hard_irqs_disabled_flags
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: wolfgang.mauerer@siemens.com

The function is required by the ipipe tracer.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 arch/x86/include/asm/irqflags.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index cb58e32..65567b6 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -256,6 +256,8 @@ static inline int hard_irqs_disabled(void)
 	return native_irqs_disabled();
 }
 
+#define hard_irqs_disabled_flags(flags)	arch_irqs_disabled_flags(flags)
+
 #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
 
 static inline void hard_local_irq_disable(void)
-- 
1.7.6.4


