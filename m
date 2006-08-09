From: Ulrich Schwab <schwab@domain.hid>
Date: Wed, 9 Aug 2006 18:37:54 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_j9g2EpS1c+rmdYc"
Message-Id: <200608091837.55424.schwab@domain.hid>
Subject: [Xenomai-core] SMI update
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

--Boundary-00=_j9g2EpS1c+rmdYc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


I saw some bad latency behaviour on a new system, it is a
P4 with ICH7 chipset. It showed  more than 300 us max. latency without any 
load.
This chipset was not detected as SMI generating and SMI disable was not done.

Finally I figured out where to add this DEVICE_ID
to the SMI detection in smi.c
It is done in the attached patch.

Now, the max. latency values on this new system are below 10 us.
Although, not tested very long.

Regards,
Ulrich Schwab

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

--Boundary-00=_j9g2EpS1c+rmdYc
Content-Type: text/x-diff;
  charset="us-ascii";
  name="smi-ICH7-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="smi-ICH7-patch"

diff -urp xenomai-2.2.0/ksrc/arch/i386/smi.c xenomai-2.2-patched/ksrc/arch/i386/smi.c
--- xenomai-2.2.0/ksrc/arch/i386/smi.c	2006-07-03 08:44:33.000000000 +0200
+++ xenomai-2.2-patched/ksrc/arch/i386/smi.c	2006-08-09 18:20:57.000000000 +0200
@@ -45,6 +45,7 @@ static struct pci_device_id rthal_smi_pc
 { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0) },
 { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1) },
 { PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2) },
+{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0) },
 { 0, },
 };
 

--Boundary-00=_j9g2EpS1c+rmdYc--

