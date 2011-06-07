From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue,  7 Jun 2011 16:17:55 +0200
Message-Id: <da3b15637621ec5b887db5c72dff969b3d7ae0da.1307456218.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1307456217.git.jan.kiszka@domain.hid>
References: <cover.1307456217.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1307456217.git.jan.kiszka@domain.hid>
References: <cover.1307456217.git.jan.kiszka@domain.hid>
Subject: [Adeos-main] [PATCH 5/5] ipipe: x86: Avoid trashing
	vector_irq[IRQ_MOVE_CLEANUP_VECTOR] on migration
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

smp_irq_move_cleanup_interrupt walks all vectors starting at
FIRST_EXTERNAL_VECTOR, checking for vectors on the move. Unfortunately,
FIRST_EXTERNAL_VECTOR equals IRQ_MOVE_CLEANUP_VECTOR and is incorrectly
identified as a migrating one because we set its vector_irq to something
else than -1. The result is that smp_irq_move_cleanup_interrupt sets
vector_irq to -1 again, and __ipipe_handle_irq will BUG on the next
migration IRQ.

Fix this by starting the vector walk above FIRST_EXTERNAL_VECTOR.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/kernel/apic/io_apic.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index db1e9f3..2c0f203 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2337,7 +2337,8 @@ asmlinkage void smp_irq_move_cleanup_interrupt(void)
 	irq_enter();
 
 	me = smp_processor_id();
-	for (vector = FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
+	for (vector = FIRST_EXTERNAL_VECTOR + 1; vector < NR_VECTORS;
+	     vector++) {
 		unsigned int irq;
 		unsigned int irr;
 		struct irq_desc *desc;
-- 
1.7.1


