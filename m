Message-ID: <471F47E4.7060908@domain.hid>
Date: Wed, 24 Oct 2007 15:25:56 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <fd6a47a90710240611l76b68672g1af78f8cb5784753@domain.hid>
In-Reply-To: <fd6a47a90710240611l76b68672g1af78f8cb5784753@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] I-pipe fasteoi interrupt handling issue
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jeroen Van den Keybus wrote:
> On my Linux 2.6.23 with latest I-pipe patch (1.10-10), interrupts are
> dispatched twice if they are of the fasteoi type.
>  
> I have the impression that the I-pipe does the eoi() acknowledgement (in
> kernel/irq/chip.c: __ipipe_ack_fasteoi_irq) without first masking off
> the IRQ. As the interrupt line hasn't been cleared at this time, the
> interrupt is immediately reissued.

Does this help?

--- arch/i386/kernel/io_apic.c~	2007-10-22 16:43:21.000000000 +0200
+++ arch/i386/kernel/io_apic.c	2007-10-24 15:24:16.000000000 +0200
@@ -1985,6 +1985,17 @@
  * operation to prevent an edge-triggered interrupt escaping meanwhile.
  * The idea is from Manfred Spraul.  --macro
  */
+
+#ifdef CONFIG_IPIPE
+/*
+ * Prevent low priority IRQs grabbed by high priority domains from
+ * being delayed, waiting for a high priority interrupt handler
+ * running in a low priority domain to complete.
+ */
+	spin_lock(&ioapic_lock);
+	__mask_IO_APIC_irq(irq);
+	spin_unlock(&ioapic_lock);
+#endif
 	i = irq_vector[irq];

 	v = apic_read(APIC_TMR + ((i & ~0x1f) >> 1));
@@ -1998,17 +2009,6 @@
 		__unmask_and_level_IO_APIC_irq(irq);
 		spin_unlock(&ioapic_lock);
 	}
-
-#ifdef CONFIG_IPIPE
-/*
- * Prevent low priority IRQs grabbed by high priority domains from
- * being delayed, waiting for a high priority interrupt handler
- * running in a low priority domain to complete.
- */
-	spin_lock(&ioapic_lock);
-	__mask_IO_APIC_irq(irq);
-	spin_unlock(&ioapic_lock);
-#endif
 }

-- 
Philippe.

