Message-ID: <43F447AF.4020604@domain.hid>
Date: Thu, 16 Feb 2006 10:36:47 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
References: <008501c63284$ef549ed0$1e01a8c0@domain.hid>
In-Reply-To: <008501c63284$ef549ed0$1e01a8c0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Russell Johnson <rjohnson@domain.hid>
Cc: 'xenomai-core' <xenomai@xenomai.org>

Russell Johnson wrote:
> 
>>It's definitely an Adeos issue and msi.c needs fixing. What 
>>about this patch, do 
>>things improve with it (against 2.6.15-ipipe-1.2-00)?
> 
> 
> I'm currently patching my setup which started with ipipe-2.6.14-i386-1.0-12.
> I've been having no luck with any MSI devices in the system even if they
> have supposedly had MSI disabled.  I'll post my testing results in the next
> day or so.

The latest patch was incomplete; you might be luckier with this one. I've merged 
Jeroen's last observations on this issue and mine.

--- 2.6.15/drivers/pci/msi.c	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.15-ipipe/drivers/pci/msi.c	2006-02-16 10:30:27.000000000 +0100
@@ -149,6 +149,21 @@
  	msi_set_mask_bit(vector, 0);
  }

+#ifdef CONFIG_IPIPE
+static void ack_MSI_irq_w_maskbits(unsigned int vector)
+{
+    mask_MSI_irq(vector);
+    __ack_APIC_irq();
+}
+static void ack_MSI_irq_wo_maskbits(unsigned int vector)
+{
+    __ack_APIC_irq();
+}
+#else /* !CONFIG_IPIPE */
+#define ack_MSI_irq_wo_maskbits  do_nothing
+#define ack_MSI_irq_w_maskbits   mask_MSI_irq
+#endif /* CONFIG_IPIPE */
+
  static unsigned int startup_msi_irq_wo_maskbit(unsigned int vector)
  {
  	struct msi_desc *entry;
@@ -212,7 +227,7 @@
  	.shutdown	= shutdown_msi_irq,
  	.enable		= unmask_MSI_irq,
  	.disable	= mask_MSI_irq,
-	.ack		= mask_MSI_irq,
+	.ack		= ack_MSI_irq_w_maskbits,
  	.end		= end_msi_irq_w_maskbit,
  	.set_affinity	= set_msi_irq_affinity
  };
@@ -228,7 +243,7 @@
  	.shutdown	= shutdown_msi_irq,
  	.enable		= unmask_MSI_irq,
  	.disable	= mask_MSI_irq,
-	.ack		= mask_MSI_irq,
+	.ack		= ack_MSI_irq_w_maskbits,
  	.end		= end_msi_irq_w_maskbit,
  	.set_affinity	= set_msi_irq_affinity
  };
@@ -244,7 +259,7 @@
  	.shutdown	= shutdown_msi_irq,
  	.enable		= do_nothing,
  	.disable	= do_nothing,
-	.ack		= do_nothing,
+	.ack		= ack_MSI_irq_wo_maskbits,
  	.end		= end_msi_irq_wo_maskbit,
  	.set_affinity	= set_msi_irq_affinity
  };

-- 

Philippe.

