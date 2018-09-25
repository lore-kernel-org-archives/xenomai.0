From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:38:08 +0200
Message-Id: <20180925103809.4932-32-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 31/32] x86: ipipe: drop (obsolete) declarations
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 arch/x86/kernel/ipipe.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index c9a8104d359f..e9cd4d923af8 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -88,13 +88,6 @@ int ipipe_get_sysinfo(struct ipipe_sysinfo *info)
 }
 EXPORT_SYMBOL_GPL(ipipe_get_sysinfo);
 
-#ifdef CONFIG_X86_UV
-asmlinkage void uv_bau_message_interrupt(struct pt_regs *regs);
-#endif
-#ifdef CONFIG_X86_MCE_THRESHOLD
-asmlinkage void smp_threshold_interrupt(void);
-#endif
-
 static void __ipipe_do_IRQ(unsigned int irq, void *cookie)
 {
 	void (*handler)(struct pt_regs *regs);
-- 
2.14.4


