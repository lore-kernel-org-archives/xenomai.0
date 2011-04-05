From: Sebastian Smolorz <smolorz@domain.hid>
Date: Tue, 5 Apr 2011 16:03:53 +0200
MIME-Version: 1.0
Message-Id: <201104051603.53977.smolorz@domain.hid>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] x86: fix ipipe tracer
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

The ipipe tracer was broken when CONFIG_IPIPE_TRACE_IRQSOFF was
enabled. The reason was that in local_irq_restore_hw(flags)
native irqs were not enabled again.

Signed-off-by: Sebastian Smolorz <smolorz@domain.hid>
---
 arch/x86/include/asm/irqflags.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h 
b/arch/x86/include/asm/irqflags.h
index ddfd8cc..6e316c0 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -283,7 +283,7 @@ static inline int irqs_disabled_hw(void)
 #define local_irq_restore_hw(flags) do {		\
 		if ((flags) & X86_EFLAGS_IF)		\
 			ipipe_trace_end(0x80000001);	\
-		native_irq_disable();			\
+		native_restore_fl(flags);		\
 	} while (0)
 
 #else /* !CONFIG_IPIPE_TRACE_IRQSOFF */
-- 
1.5.2.4


