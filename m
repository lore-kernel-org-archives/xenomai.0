From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue,  7 Jun 2011 16:17:51 +0200
Message-Id: <1622352fd8c7fec68b8b2c687c7ea1483095d6ac.1307456217.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1307456217.git.jan.kiszka@domain.hid>
References: <cover.1307456217.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1307456217.git.jan.kiszka@domain.hid>
References: <cover.1307456217.git.jan.kiszka@domain.hid>
Subject: [Adeos-main] [PATCH 1/5] ipipe: x86: Fix irq->vector lookup for
	IRQ_MOVE_CLEANUP_VECTOR
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

The IRQ migration IRQ has no irq_cfg and is outside of the range
ipipe_apic_irq_vector can handle. This causes oopses when
__ipipe_get_ioapic_irq_vector is processing it.

Reported-by: Franz Engel <franz_lambert_engel@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/kernel/apic/io_apic.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 9b84f05..db1e9f3 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3967,8 +3967,12 @@ int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity)
 #ifdef CONFIG_IPIPE
 unsigned __ipipe_get_ioapic_irq_vector(int irq)
 {
-	return irq >= IPIPE_FIRST_APIC_IRQ && irq < IPIPE_NR_XIRQS ?
-		ipipe_apic_irq_vector(irq) : irq_cfg(irq)->vector;
+	if (irq >= IPIPE_FIRST_APIC_IRQ && irq < IPIPE_NR_XIRQS)
+		return ipipe_apic_irq_vector(irq);
+	else if (irq == IRQ_MOVE_CLEANUP_VECTOR)
+		return irq;
+	else
+		return irq_cfg(irq)->vector;
 }
 #endif /* CONFIG_IPIPE */
 
-- 
1.7.1


