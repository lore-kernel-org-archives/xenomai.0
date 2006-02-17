Message-ID: <43F5F4CE.2000501@domain.hid>
Date: Fri, 17 Feb 2006 17:07:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
References: <43F447AF.4020604@domain.hid>	
	<000a01c63304$94ee5190$1e01a8c0@domain.hid>	
	<fd6a47a90602170454q1cc93f23h@domain.hid>	
	<43F5CAE8.9010905@domain.hid>
	<fd6a47a90602170757q15fed14x@domain.hid>
In-Reply-To: <fd6a47a90602170757q15fed14x@domain.hid>
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
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jeroen Van den Keybus wrote:
>     Could you post the patch you are successfully using to boot your
>     box? TIA,
> 
> 
> 
> --- linux-2.6.15/drivers/pci/msi.c      2006-01-03 04:21:10.000000000 +0100
> +++ linux-2.6.15-ipipe/drivers/pci/msi.c        2006-02-17 
> 16:48:21.000000000 +0100
> @@ -185,10 +185,20 @@
>         spin_unlock_irqrestore(&msi_lock, flags);
>  }
> 
> +#if defined(CONFIG_IPIPE)
> +/* Attention: only MSI without maskbits is currently fixed for I-PIPE */
> +static void ack_msi_irq_wo_maskbit(unsigned int vector)
> +{
> +       __ack_APIC_irq();
> +}
> +#endif /* CONFIG_IPIPE */
> +
>  static void end_msi_irq_wo_maskbit(unsigned int vector)
>  {
>         move_native_irq(vector);
> +#if !defined(CONFIG_IPIPE)
>         ack_APIC_irq();
> +#endif /* !CONFIG_IPIPE */

ack_APIC_irq() is nullified when CONFIG_IPIPE is enabled, and __ack_APIC_irq() 
stands for the actual APIC acknowledging code. So the change above is not needed.

>  }
> 
>  static void end_msi_irq_w_maskbit(unsigned int vector)
> @@ -244,7 +254,11 @@
>         .shutdown       = shutdown_msi_irq,
>         .enable         = do_nothing,
>         .disable        = do_nothing,
> +#if defined(CONFIG_IPIPE)
> +       .ack            = ack_msi_irq_wo_maskbit,
> +#else /* CONFIG_IPIPE */
>         .ack            = do_nothing,
> +#endif /* !CONFIG_IPIPE */
>         .end            = end_msi_irq_wo_maskbit,
>         .set_affinity   = set_msi_irq_affinity
>  };
> 

Ok; unless my brain is completely toast, the last patch I recently posted does the 
same, but extends the support to the "MSI and MSI-X with masking bit" cases. Could 
you test in on your box with a vanilla 2.6.15 when time allows? If it works, then 
I will roll out a new Adeos/x86 patch including this fix. TIA,

--- 2.6.15/drivers/pci/msi.c    2006-01-03 04:21:10.000000000 +0100
+++ 2.6.15-ipipe/drivers/pci/msi.c    2006-02-16 10:30:27.000000000 +0100
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
      .shutdown    = shutdown_msi_irq,
      .enable        = unmask_MSI_irq,
      .disable    = mask_MSI_irq,
-    .ack        = mask_MSI_irq,
+    .ack        = ack_MSI_irq_w_maskbits,
      .end        = end_msi_irq_w_maskbit,
      .set_affinity    = set_msi_irq_affinity
  };
@@ -228,7 +243,7 @@
      .shutdown    = shutdown_msi_irq,
      .enable        = unmask_MSI_irq,
      .disable    = mask_MSI_irq,
-    .ack        = mask_MSI_irq,
+    .ack        = ack_MSI_irq_w_maskbits,
      .end        = end_msi_irq_w_maskbit,
      .set_affinity    = set_msi_irq_affinity
  };
@@ -244,7 +259,7 @@
      .shutdown    = shutdown_msi_irq,
      .enable        = do_nothing,
      .disable    = do_nothing,
-    .ack        = do_nothing,
+    .ack        = ack_MSI_irq_wo_maskbits,
      .end        = end_msi_irq_wo_maskbit,
      .set_affinity    = set_msi_irq_affinity
  };
-- 

Philippe.

