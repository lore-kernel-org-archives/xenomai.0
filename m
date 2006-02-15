Message-ID: <43F38A5E.9030402@domain.hid>
Date: Wed, 15 Feb 2006 21:09:02 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
References: <fd6a47a90602140744lc1d4365q@domain.hid>	
	<fd6a47a90602141007g7830d31fu@domain.hid>	
	<43F21ED7.3030501@domain.hid> <43F220D7.6040705@domain.hid>	
	<fd6a47a90602141052u1e136db8y@domain.hid>	
	<fd6a47a90602141133v6aeae6e1n@domain.hid>	
	<fd6a47a90602141341j21ce1b77l@domain.hid>	
	<43F2521E.7040200@domain.hid>	
	<fd6a47a90602150300y5e435a22i@domain.hid>	
	<fd6a47a90602151002q3f38748ep@domain.hid>
	<fd6a47a90602151034q8ed6920r@domain.hid>
In-Reply-To: <fd6a47a90602151034q8ed6920r@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
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
> Ok. I=B4ve found it. The MSI interrupt type uses its end() handler to=20
> acknowledge the interrupt using ack_APIC_irq() (drivers/pci/msi.c).=20
> Xenomai uses the ack() handler to expedite the acknowledgement of an=20
> IRQ. In case of MSI, ack() is a NOP.
>=20
> The main problem is that Xenomai redefines ack_APIC_irq() calls (they=20
> become NOPs, as defined in apic.h). Maybe the ISRs used so far never=20
> issued ack_APIC_irq() themselves, and used always the IO-APIC (which=20
> contains the correct __ack_APIC_irq() call) ?
>

Really good spot, I overlooked this issue in the MSI support; thanks for =
digging it.

> I feel a bit awkward about changing msi.c .
>=20
> Any opinions about how to change Xenomai / Linux ?
>=20

It's definitely an Adeos issue and msi.c needs fixing. What about this pa=
tch, do=20
things improve with it (against 2.6.15-ipipe-1.2-00)?

--- msi.c~	2006-01-03 04:21:10.000000000 +0100
+++ msi.c	2006-02-15 21:02:03.000000000 +0100
@@ -149,6 +149,15 @@
  	msi_set_mask_bit(vector, 0);
  }

+#ifdef CONFIG_IPIPE
+static void ack_MSI_irq(unsigned int vector)
+{
+    __ack_APIC_irq();
+}
+#else /* !CONFIG_IPIPE */
+#define ack_MSI_irq  mask_MSI_irq
+#endif /* CONFIG_IPIPE */
+
  static unsigned int startup_msi_irq_wo_maskbit(unsigned int vector)
  {
  	struct msi_desc *entry;
@@ -212,7 +221,7 @@
  	.shutdown	=3D shutdown_msi_irq,
  	.enable		=3D unmask_MSI_irq,
  	.disable	=3D mask_MSI_irq,
-	.ack		=3D mask_MSI_irq,
+	.ack		=3D ack_MSI_irq,
  	.end		=3D end_msi_irq_w_maskbit,
  	.set_affinity	=3D set_msi_irq_affinity
  };
@@ -228,7 +237,7 @@
  	.shutdown	=3D shutdown_msi_irq,
  	.enable		=3D unmask_MSI_irq,
  	.disable	=3D mask_MSI_irq,
-	.ack		=3D mask_MSI_irq,
+	.ack		=3D ack_MSI_irq,
  	.end		=3D end_msi_irq_w_maskbit,
  	.set_affinity	=3D set_msi_irq_affinity
  };

--=20

Philippe.

