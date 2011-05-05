Message-ID: <4DC2B804.9070604@domain.hid>
Date: Thu, 05 May 2011 16:45:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <505044.35954.qm@domain.hid>
	<4DC2908C.2020501@domain.hid> <4DC29BB9.1090709@domain.hid>
In-Reply-To: <4DC29BB9.1090709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] [PATCH] ipipe: x86: Fix irq->vector lookup for
	IRQ_MOVE_CLEANUP_VECTOR
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Franz Engel <franz_lambert_engel@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

The IRQ migration IRQ has no irq_cfg and is outside of the range
ipipe_apic_irq_vector can handle. This causes oopses when
__ipipe_get_ioapic_irq_vector is processing it.

Reported-by: Franz Engel <franz_lambert_engel@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/kernel/apic/io_apic.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 8eaaadc..52f9686 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3985,8 +3985,12 @@ int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity)
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

