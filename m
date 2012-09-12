From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Wed, 12 Sep 2012 19:00:33 +0200
Message-Id: <1347469235-17712-2-git-send-email-wolfgang.mauerer@siemens.com>
In-Reply-To: <1347469235-17712-1-git-send-email-wolfgang.mauerer@siemens.com>
References: <1347469235-17712-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PATCH 1/3] ipipe: Remove superfluous symbol export of
	irq_to_desc
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

It's exported in mainline from 3911ff30f5 onwards.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
---
 arch/x86/kernel/ipipe.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 30515a2..1a56b5f 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -645,9 +645,6 @@ void update_vsyscall_tz(void)
 }
 #endif /* CONFIG_X86_32 */
 
-#ifdef CONFIG_SPARSE_IRQ
-EXPORT_SYMBOL_GPL(irq_to_desc);
-#endif
 struct task_struct *__switch_to(struct task_struct *prev_p,
 				struct task_struct *next_p);
 EXPORT_SYMBOL_GPL(__switch_to);
-- 
1.7.6.4


