From: Ulrich Schwab <schwab@domain.hid>
Subject: Re: [Xenomai-core] SMI update
Date: Thu, 10 Aug 2006 14:54:59 +0200
References: <200608091837.55424.schwab@domain.hid>
	<200608100944.34068.schwab@domain.hid> <44DAEDF9.8060500@domain.hid>
In-Reply-To: <44DAEDF9.8060500@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jyy2EBL+8HBhypP"
Message-Id: <200608101454.59570.schwab@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_jyy2EBL+8HBhypP
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 10 August 2006 10:27, Jan Kiszka wrote:
> Ulrich Schwab wrote:
> > On Thursday 10 August 2006 00:44, Jan Kiszka wrote:
> >> Thanks for the patch, we just need some additional define of
> >> PCI_DEVICE_ID_INTEL_ICH7_0 for kernel 2.4 compatibility. And if you
> >> additionally provide a ChangeLog fragment, your patch would be perfect!
> >> (I tend to forget the last part often too... :) )
> >
> > Where to add the new define for kernel 2.4 ?
>
> I would say to smi.c directly as there are no other users in sight.
> Otherwise, wrapping code goes to include/asm-{generic|<arch>}/wrapper.h.
I did add the new Id to smi.c directly now.

Ulrich
-- 
====================================================
  inmess GmbH
  Frankfurter Str. 74
  D - 64521 Gross-Gerau
  Phone: +49 6152 97790
  Fax  : +49 6152 977920
  mail : info@domain.hid
  web:   www.inmess.de
====================================================

--Boundary-00=_jyy2EBL+8HBhypP
Content-Type: text/x-diff;
  charset="utf-8";
  name="smi-ICH7-patch-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="smi-ICH7-patch-2"

diff -urp xenomai-2.2.0-org/ChangeLog xenomai-2.2.0-patched/ChangeLog
--- xenomai-2.2.0-org/ChangeLog	2006-07-17 18:50:17.000000000 +0200
+++ xenomai-2.2.0-patched/ChangeLog	2006-08-10 14:51:28.000000000 +0200
@@ -1,3 +1,7 @@
+2006-08-10  Ulrich Schwab  <schwab@domain.hid>
+
+	* ksrc/arch/i386/smi.c added id of Intel ICH7 to list of SMI chipsets
+	
 2006-07-17  Philippe Gerum  <rpm@xenomai.org>
 
  	* RELEASE: Xenomai 2.2 (Engines Of Creation)
diff -urp xenomai-2.2.0-org/ksrc/arch/i386/smi.c xenomai-2.2.0-patched/ksrc/arch/i386/smi.c
--- xenomai-2.2.0-org/ksrc/arch/i386/smi.c	2006-07-03 08:44:33.000000000 +0200
+++ xenomai-2.2.0-patched/ksrc/arch/i386/smi.c	2006-08-10 14:50:37.000000000 +0200
@@ -31,6 +31,13 @@
 #include <linux/reboot.h>
 #include <asm/xenomai/smi.h>
 
+/* DEVICE_IDs needed for 2.4 support */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+#ifndef PCI_DEVICE_ID_INTEL_ICH7_0
+#define PCI_DEVICE_ID_INTEL_ICH7_0 0x27b8
+#endif
+#endif
+
 static struct pci_device_id rthal_smi_pci_tbl[] = {
 { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0) },
 { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_0) },
@@ -45,6 +52,7 @@ static struct pci_device_id rthal_smi_pc
 { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0) },
 { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1) },
 { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2) },
+{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0) },
 { 0, },
 };
 

--Boundary-00=_jyy2EBL+8HBhypP--

