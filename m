From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue,  7 Jun 2011 16:17:54 +0200
Message-Id: <08cff920efedd0eaed4e22df9d2d80a8b25d2456.1307456218.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1307456217.git.jan.kiszka@domain.hid>
References: <cover.1307456217.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1307456217.git.jan.kiszka@domain.hid>
References: <cover.1307456217.git.jan.kiszka@domain.hid>
Subject: [Adeos-main] [PATCH 4/5] ipipe: x86: Unbreak !CONFIG_SPARSE_IRQ
	build
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/kernel/ipipe.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index b34cce9..bc6e23f 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -835,7 +835,9 @@ void update_vsyscall_tz(void)
 
 EXPORT_SYMBOL(__ipipe_tick_irq);
 
+#ifdef CONFIG_SPARSE_IRQ
 EXPORT_SYMBOL_GPL(irq_to_desc);
+#endif
 struct task_struct *__switch_to(struct task_struct *prev_p,
 				struct task_struct *next_p);
 EXPORT_SYMBOL_GPL(__switch_to);
-- 
1.7.1


