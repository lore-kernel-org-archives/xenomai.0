Message-ID: <1166352114.45851ef2b1652@domain.hid>
Date: Sun, 17 Dec 2006 11:41:54 +0100
From: barbalace@domain.hid
Subject: RE: [Xenomai-help] Re: RTAI porting to ppc
References: <B4D14EA407C38B4DAF92B8EAC9249D7F02D0F8AB@mspex01.go.mts.com>
In-Reply-To: <B4D14EA407C38B4DAF92B8EAC9249D7F02D0F8AB@mspex01.go.mts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Rosenow, Jim" <Jim.Rosenow@domain.hid>
Cc: xenomai@xenomai.org

Quoting "Rosenow, Jim" <Jim.Rosenow@domain.hid>:
> Hi Antonio,
>
> I tried to use the MVME5500 with Xenomai and wound up having to return
> the board to Motorola for repair after the first test run.  I see you
> had the same problem, yet you must have figured out how to make this
> combination work.
>
> May I ask what combination of patches you used to get this combination
> running?

For all that use the MVME5500 I suggest to:

Disable the write enable on the board with the on-board jumper.
For a MVME5500 v5500a_ih revision the jumper are to be:

J9 without jumper
J15 without jumper
J30 without jumper

This configuration is the one I use, I don't have much time to test if wi=
th
jumpers after the patch all work well.

Now how to patch the kernel:

1. extract a vanilla kernel 2.6.14:
bash-3.00# tar -xvf linux-2.6.14.tar.bz2 cd linux-2.6.14
2. patch with the Motorola patch:
bash-3.00# patch -Np1 <../patch-2.6.14-ecc.11012006

3. there are some patch that resolve some problems... apply there

4. From Xenomai base directory
scripts/prepare-kernel.sh --linux=3D/usr/src/linux-2.6.14/
--adeos=3D/usr/src/xenomai-2.2.0/ksrc/arch/powerpc/patches/adeos-ipipe-2.=
6.14-ppc-1.3-05.patch
--arch=3Dppc
5. From Linux base directory
patch -Np1 < ../patch-2.6.14-ecc.11012006-rfx01-1.3-05.ipipe-01
6. configure and make the kernel kernel
make xconfig

I'm not sure at 100% that this patch resolve the problem of the non contr=
elled
write on the flashes and eeproms.

I write to the community too, see:
https://mail.gna.org/public/adeos-main/2006-12/msg00043.html

Wolfgang suggest me to make a different change for patching the problem (=
see
adeos mailing list). Feel free to use one or the other. Mine could improv=
e
system speed.

> Thanks and regards,
>
> Jim Rosenow
> MTS Systems Corp.

Here is my patch: (for ipipe, the Wolfgang one is called like mv64x60)


--START---------------- patch-2.6.14-ecc.11012006-rfx01-1.3-05.ipipe-01--=
-------
diff -u -r linux-2.6.14-ecc.11012006-rfx01-ipipe/.config~
linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/.config~
--- linux-2.6.14-ecc.11012006-rfx01-ipipe/.config~	2006-11-29 17:18:42.00=
0000000
+0100
+++ linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/.config~	2006-11-30
21:47:54.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.14
-# Wed Nov 29 17:18:42 2006
+# Thu Nov 30 21:47:54 2006
 #
 CONFIG_MMU=3Dy
 CONFIG_GENERIC_HARDIRQS=3Dy
@@ -132,6 +132,7 @@
 CONFIG_MV64X60_NEW_BASE=3D0xf1000000
 # CONFIG_MV64X60_USE_SRAM is not set
 # CONFIG_SMP is not set
+CONFIG_IPIPE=3Dy
 # CONFIG_HIGHMEM is not set
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=3Dy
diff -u -r linux-2.6.14-ecc.11012006-rfx01-ipipe/arch/ppc/platforms/mvme5=
500.c
linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/arch/ppc/platforms/mvme5500.c
---
linux-2.6.14-ecc.11012006-rfx01-ipipe/arch/ppc/platforms/mvme5500.c	2006-=
11-29
16:05:25.000000000 +0100
+++
linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/arch/ppc/platforms/mvme5500.c=
	2006-12-06
14:07:29.000000000 +0100
@@ -26,7 +26,7 @@
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
-#include <linux/seq_file.h>
+#include <linux/seq_file.h>  /* IPIPE: other ppc arch file remove this l=
ine */
 #include <linux/root_dev.h>
 #include <linux/serial.h>
 #include <linux/tty.h>
diff -u -r linux-2.6.14-ecc.11012006-rfx01-ipipe/arch/ppc/syslib/gt64260_=
pic.c
linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/arch/ppc/syslib/gt64260_pic.c
---
linux-2.6.14-ecc.11012006-rfx01-ipipe/arch/ppc/syslib/gt64260_pic.c	2005-=
10-28
02:02:08.000000000 +0200
+++
linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/arch/ppc/syslib/gt64260_pic.c=
	2006-12-06
13:50:42.000000000 +0100
@@ -32,6 +32,11 @@
  *    input.
  */

+/*
+ * Modified by: A. Barbalace <barbalac@domain.hid> CNR Consorzio RFX P=
adova
+ *
+*/
+
 #include <linux/stddef.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -52,8 +57,19 @@

 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D forward declaration =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */

+static inline void gt64260pic_write(struct mv64x60_handle *bh, u32 offse=
t, u32
val)
+{
+	out_le32(bh->v_base + offset, val);
+}
+
+static inline u32 gt64260pic_read(struct mv64x60_handle *bh, u32 offset)
+{
+	return in_le32(bh->v_base + offset);
+}
+
 static void gt64260_unmask_irq(unsigned int);
 static void gt64260_mask_irq(unsigned int);
+/* static void gt64260_end_irq(unsigned int); */

 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D local declarations =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */

@@ -63,6 +79,7 @@
 	.disable  =3D gt64260_mask_irq,
 	.ack      =3D gt64260_mask_irq,
 	.end      =3D gt64260_unmask_irq,
+	/* .end      =3D gt64260_end_irq */
 };

 u32 gt64260_irq_base =3D 0;	/* GT64260 handles the next 96 IRQs from her=
e */
@@ -92,10 +109,10 @@
 	ppc_cached_irq_mask[2] =3D 0;

 	/* disable all interrupts and clear current interrupts */
-	mv64x60_write(&bh, MV64x60_GPP_INTR_MASK, ppc_cached_irq_mask[2]);
-	mv64x60_write(&bh, MV64x60_GPP_INTR_CAUSE, 0);
-	mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_LO, ppc_cached_irq_mask[0])=
;
-	mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_HI, ppc_cached_irq_mask[1])=
;
+	gt64260pic_write(&bh, MV64x60_GPP_INTR_MASK, ppc_cached_irq_mask[2]);
+	gt64260pic_write(&bh, MV64x60_GPP_INTR_CAUSE, 0);
+	gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_LO, ppc_cached_irq_mask[=
0]);
+	gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_HI, ppc_cached_irq_mask[=
1]);

 	/* use the gt64260 for all (possible) interrupt sources */
 	for (i =3D gt64260_irq_base; i < (gt64260_irq_base + 96); i++)
@@ -126,18 +143,18 @@
 	int irq;
 	int irq_gpp;

-	irq =3D mv64x60_read(&bh, GT64260_IC_MAIN_CAUSE_LO);
+	irq =3D gt64260pic_read(&bh, GT64260_IC_MAIN_CAUSE_LO);
 	irq =3D __ilog2((irq & 0x3dfffffe) & ppc_cached_irq_mask[0]);

 	if (irq =3D=3D -1) {
-		irq =3D mv64x60_read(&bh, GT64260_IC_MAIN_CAUSE_HI);
+		irq =3D gt64260pic_read(&bh, GT64260_IC_MAIN_CAUSE_HI);
 		irq =3D __ilog2((irq & 0x0f000db7) & ppc_cached_irq_mask[1]);

 		if (irq =3D=3D -1)
 			irq =3D -2; /* bogus interrupt, should never happen */
 		else {
 			if (irq >=3D 24) {
-				irq_gpp =3D mv64x60_read(&bh,
+				irq_gpp =3D gt64260pic_read(&bh,
 					MV64x60_GPP_INTR_CAUSE);
 				irq_gpp =3D __ilog2(irq_gpp &
 					ppc_cached_irq_mask[2]);
@@ -146,7 +163,7 @@
 					irq =3D -2;
 				else {
 					irq =3D irq_gpp + 64;
-					mv64x60_write(&bh,
+					gt64260pic_write(&bh,
 						MV64x60_GPP_INTR_CAUSE,
 						~(1 << (irq - 64)));
 				}
@@ -155,7 +172,7 @@
 		}
 	}

-	(void)mv64x60_read(&bh, MV64x60_GPP_INTR_CAUSE);
+	(void)gt64260pic_read(&bh, MV64x60_GPP_INTR_CAUSE);

 	if (irq < 0)
 		return (irq);
@@ -183,19 +200,23 @@

 	if (irq > 31)
 		if (irq > 63) /* unmask GPP irq */
-			mv64x60_write(&bh, MV64x60_GPP_INTR_MASK,
-				ppc_cached_irq_mask[2] |=3D (1 << (irq - 64)));
+			gt64260pic_write(&bh, MV64x60_GPP_INTR_MASK, ppc_cached_irq_mask[2] |=
=3D (1 <<
(irq - 64)));
 		else /* mask high interrupt register */
-			mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_HI,
-				ppc_cached_irq_mask[1] |=3D (1 << (irq - 32)));
+			gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_HI, ppc_cached_irq_mas=
k[1] |=3D
(1 << (irq - 32)));
 	else /* mask low interrupt register */
-		mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_LO,
-			ppc_cached_irq_mask[0] |=3D (1 << irq));
+		gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_LO, ppc_cached_irq_mask=
[0] |=3D
(1 << irq));

-	(void)mv64x60_read(&bh, MV64x60_GPP_INTR_MASK);
+	(void)gt64260pic_read(&bh, MV64x60_GPP_INTR_MASK);
 	return;
 }
+/*static void
+gt64260_end_irq(unsigned int irq)
+{
+	if (!ipipe_root_domain_p || (!irq_desc[irq].status & (IRQ_DISABLED |
IRQ_INPROGRESS)))
+		gt64260_unmask_irq(irq);

+	return;
+}*/
 /* gt64260_mask_irq()
  *
  *  This function disables the requested interrupt.
@@ -216,16 +237,16 @@

 	if (irq > 31)
 		if (irq > 63) /* mask GPP irq */
-			mv64x60_write(&bh, MV64x60_GPP_INTR_MASK,
+			gt64260pic_write(&bh, MV64x60_GPP_INTR_MASK,
 				ppc_cached_irq_mask[2] &=3D ~(1 << (irq - 64)));
 		else /* mask high interrupt register */
-			mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_HI,
+			gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_HI,
 				ppc_cached_irq_mask[1] &=3D ~(1 << (irq - 32)));
 	else /* mask low interrupt register */
-		mv64x60_write(&bh, GT64260_IC_CPU_INTR_MASK_LO,
+		gt64260pic_write(&bh, GT64260_IC_CPU_INTR_MASK_LO,
 			ppc_cached_irq_mask[0] &=3D ~(1 << irq));

-	(void)mv64x60_read(&bh, MV64x60_GPP_INTR_MASK);
+	(void)gt64260pic_read(&bh, MV64x60_GPP_INTR_MASK);
 	return;
 }

@@ -234,19 +255,19 @@
 {
 	printk(KERN_ERR "gt64260_cpu_error_int_handler: %s 0x%08x\n",
 		"Error on CPU interface - Cause regiser",
-		mv64x60_read(&bh, MV64x60_CPU_ERR_CAUSE));
+		gt64260pic_read(&bh, MV64x60_CPU_ERR_CAUSE));
 	printk(KERN_ERR "\tCPU error register dump:\n");
 	printk(KERN_ERR "\tAddress low  0x%08x\n",
-	       mv64x60_read(&bh, MV64x60_CPU_ERR_ADDR_LO));
+	       gt64260pic_read(&bh, MV64x60_CPU_ERR_ADDR_LO));
 	printk(KERN_ERR "\tAddress high 0x%08x\n",
-	       mv64x60_read(&bh, MV64x60_CPU_ERR_ADDR_HI));
+	       gt64260pic_read(&bh, MV64x60_CPU_ERR_ADDR_HI));
 	printk(KERN_ERR "\tData low     0x%08x\n",
-	       mv64x60_read(&bh, MV64x60_CPU_ERR_DATA_LO));
+	       gt64260pic_read(&bh, MV64x60_CPU_ERR_DATA_LO));
 	printk(KERN_ERR "\tData high    0x%08x\n",
-	       mv64x60_read(&bh, MV64x60_CPU_ERR_DATA_HI));
+	       gt64260pic_read(&bh, MV64x60_CPU_ERR_DATA_HI));
 	printk(KERN_ERR "\tParity       0x%08x\n",
-	       mv64x60_read(&bh, MV64x60_CPU_ERR_PARITY));
-	mv64x60_write(&bh, MV64x60_CPU_ERR_CAUSE, 0);
+	       gt64260pic_read(&bh, MV64x60_CPU_ERR_PARITY));
+	gt64260pic_write(&bh, MV64x60_CPU_ERR_CAUSE, 0);
 	return IRQ_HANDLED;
 }

@@ -257,36 +278,36 @@
 	unsigned int pci_bus =3D (unsigned int)dev_id;

 	if (pci_bus =3D=3D 0) {	/* Error on PCI 0 */
-		val =3D mv64x60_read(&bh, MV64x60_PCI0_ERR_CAUSE);
+		val =3D gt64260pic_read(&bh, MV64x60_PCI0_ERR_CAUSE);
 		printk(KERN_ERR "%s: Error in PCI %d Interface\n",
 			"gt64260_pci_error_int_handler", pci_bus);
 		printk(KERN_ERR "\tPCI %d error register dump:\n", pci_bus);
 		printk(KERN_ERR "\tCause register 0x%08x\n", val);
 		printk(KERN_ERR "\tAddress Low    0x%08x\n",
-		       mv64x60_read(&bh, MV64x60_PCI0_ERR_ADDR_LO));
+		       gt64260pic_read(&bh, MV64x60_PCI0_ERR_ADDR_LO));
 		printk(KERN_ERR "\tAddress High   0x%08x\n",
-		       mv64x60_read(&bh, MV64x60_PCI0_ERR_ADDR_HI));
+		       gt64260pic_read(&bh, MV64x60_PCI0_ERR_ADDR_HI));
 		printk(KERN_ERR "\tAttribute      0x%08x\n",
-		       mv64x60_read(&bh, MV64x60_PCI0_ERR_DATA_LO));
+		       gt64260pic_read(&bh, MV64x60_PCI0_ERR_DATA_LO));
 		printk(KERN_ERR "\tCommand        0x%08x\n",
-		       mv64x60_read(&bh, MV64x60_PCI0_ERR_CMD));
-		mv64x60_write(&bh, MV64x60_PCI0_ERR_CAUSE, ~val);
+		       gt64260pic_read(&bh, MV64x60_PCI0_ERR_CMD));
+		gt64260pic_write(&bh, MV64x60_PCI0_ERR_CAUSE, ~val);
 	}
 	if (pci_bus =3D=3D 1) {	/* Error on PCI 1 */
-		val =3D mv64x60_read(&bh, MV64x60_PCI1_ERR_CAUSE);
+		val =3D gt64260pic_read(&bh, MV64x60_PCI1_ERR_CAUSE);
 		printk(KERN_ERR "%s: Error in PCI %d Interface\n",
 			"gt64260_pci_error_int_handler", pci_bus);
 		printk(KERN_ERR "\tPCI %d error register dump:\n", pci_bus);
 		printk(KERN_ERR "\tCause register 0x%08x\n", val);
 		printk(KERN_ERR "\tAddress Low    0x%08x\n",
-		       mv64x60_read(&bh, MV64x60_PCI1_ERR_ADDR_LO));
+		       gt64260pic_read(&bh, MV64x60_PCI1_ERR_ADDR_LO));
 		printk(KERN_ERR "\tAddress High   0x%08x\n",
-		       mv64x60_read(&bh, MV64x60_PCI1_ERR_ADDR_HI));
+		       gt64260pic_read(&bh, MV64x60_PCI1_ERR_ADDR_HI));
 		printk(KERN_ERR "\tAttribute      0x%08x\n",
-		       mv64x60_read(&bh, MV64x60_PCI1_ERR_DATA_LO));
+		       gt64260pic_read(&bh, MV64x60_PCI1_ERR_DATA_LO));
 		printk(KERN_ERR "\tCommand        0x%08x\n",
-		       mv64x60_read(&bh, MV64x60_PCI1_ERR_CMD));
-		mv64x60_write(&bh, MV64x60_PCI1_ERR_CAUSE, ~val);
+		       gt64260pic_read(&bh, MV64x60_PCI1_ERR_CMD));
+		gt64260pic_write(&bh, MV64x60_PCI1_ERR_CAUSE, ~val);
 	}
 	return IRQ_HANDLED;
 }
@@ -301,8 +322,8 @@
 		gt64260_cpu_error_int_handler, SA_INTERRUPT, CPU_INTR_STR, 0)))
 		printk(KERN_WARNING "Can't register cpu error handler: %d", rc);

-	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0);
-	mv64x60_write(&bh, MV64x60_CPU_ERR_MASK, 0x000000fe);
+	gt64260pic_write(&bh, MV64x60_CPU_ERR_MASK, 0);
+	gt64260pic_write(&bh, MV64x60_CPU_ERR_MASK, 0x000000fe);

 	/* Register PCI 0 error interrupt handler */
 	if ((rc =3D request_irq(MV64360_IRQ_PCI0, gt64260_pci_error_int_handler=
,
@@ -310,8 +331,8 @@
 		printk(KERN_WARNING "Can't register pci 0 error handler: %d",
 			rc);

-	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, 0);
-	mv64x60_write(&bh, MV64x60_PCI0_ERR_MASK, 0x003c0c24);
+	gt64260pic_write(&bh, MV64x60_PCI0_ERR_MASK, 0);
+	gt64260pic_write(&bh, MV64x60_PCI0_ERR_MASK, 0x003c0c24);

 	/* Register PCI 1 error interrupt handler */
 	if ((rc =3D request_irq(MV64360_IRQ_PCI1, gt64260_pci_error_int_handler=
,
@@ -319,10 +340,11 @@
 		printk(KERN_WARNING "Can't register pci 1 error handler: %d",
 			rc);

-	mv64x60_write(&bh, MV64x60_PCI1_ERR_MASK, 0);
-	mv64x60_write(&bh, MV64x60_PCI1_ERR_MASK, 0x003c0c24);
+	gt64260pic_write(&bh, MV64x60_PCI1_ERR_MASK, 0);
+	gt64260pic_write(&bh, MV64x60_PCI1_ERR_MASK, 0x003c0c24);

 	return 0;
 }

 arch_initcall(gt64260_register_hdlrs);
+
diff -u -r linux-2.6.14-ecc.11012006-rfx01-ipipe/arch/ppc/syslib/i8259.c
linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/arch/ppc/syslib/i8259.c
--- linux-2.6.14-ecc.11012006-rfx01-ipipe/arch/ppc/syslib/i8259.c	2005-10=
-28
02:02:08.000000000 +0200
+++
linux-2.6.14-ecc.11012006-rfx01-ipipe.rfx01/arch/ppc/syslib/i8259.c	2006-=
12-06
14:06:19.000000000 +0100
@@ -157,7 +157,8 @@
 	.flags =3D IORESOURCE_BUSY,
 };

-static struct irqaction i8259_irqaction =3D {
+//static struct irqaction i8259_irqaction =3D {		// IPIPE: remove static
declaration like other IPIPE patch
+struct irqaction i8259_irqaction =3D {
 	.handler =3D no_action,
 	.flags =3D SA_INTERRUPT,
 	.mask =3D CPU_MASK_NONE,
-- END ---------------- patch-2.6.14-ecc.11012006-rfx01-1.3-05.ipipe-01--=
-------

