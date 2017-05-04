From: Henning Schild <henning.schild@siemens.com>
Date: Thu,  4 May 2017 18:52:57 +0200
Message-Id: <20170504165257.6915-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH] x86/ipipe: fix compilation for x86_32
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Michael Smith <2michael.smith@gmail.com>

AMD MCE is just relevant for the 64Bit case and causes linking problems
for 32.

Reported-by: Michael Smith <2michael.smith@gmail.com>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 arch/x86/kernel/ipipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index b207502..e3f5dc0 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -134,7 +134,7 @@ void __init __ipipe_enable_pipeline(void)
 			  __ipipe_ack_apic);
 #endif
 
-#ifdef CONFIG_X86_MCE_AMD
+#if defined(CONFIG_X86_MCE_AMD) && defined(CONFIG_X86_64)
 	ipipe_request_irq(ipipe_root_domain,
 			  ipipe_apic_vector_irq(DEFERRED_ERROR_VECTOR),
 			  __ipipe_do_IRQ, smp_deferred_error_interrupt,
-- 
2.10.2


