Message-ID: <472220AD.6080402@domain.hid>
Date: Fri, 26 Oct 2007 19:15:25 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <47220255.4040309@domain.hid>
In-Reply-To: <47220255.4040309@domain.hid>
Content-Type: multipart/mixed; boundary="------------010306060906050107040505"
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] clocktest and cyclictest work but irqloop crashes
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
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010306060906050107040505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Steven A. Falco wrote:
> I am testing kernel 2.6.23 ARCH=powerpc with Xenomai 2.4-rc4.  The 
> clocktest and cyclictest work perfectly with the uic/spinlock patches.  
> However, the irqloop test fails with the Oops shown below.
>

Please try the patch below. It looks like the chip descriptor does not implement
any unmask handler, which seems odd. This patch should tell us a bit more about
this issue.

-- 
Philippe.

--------------010306060906050107040505
Content-Type: text/x-patch;
 name="uic-unmask.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uic-unmask.patch"

Index: ksrc/arch/powerpc/hal.c
===================================================================
--- ksrc/arch/powerpc/hal.c	(revision 3095)
+++ ksrc/arch/powerpc/hal.c	(working copy)
@@ -245,6 +245,11 @@
 
     rthal_irq_desc_status(irq) &= ~IRQ_DISABLED;
 
+    if (rthal_irq_handlerp(irq)->unmask == NULL) {
+      printk("NULL ->unmask handler, IRQ %d, chip %s\n", irq, rthal_irq_handlerp(irq)->typename);
+      return 0;
+    }
+
     return rthal_irq_chip_enable(irq);
 }
 

--------------010306060906050107040505--

