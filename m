Message-ID: <504F8F55.9080006@xenomai.org>
Date: Tue, 11 Sep 2012 21:21:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <504EC598.7050005@ebus.com>
In-Reply-To: <504EC598.7050005@ebus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Interpreting I-pipe trace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Doug Brunner <dbrunner@ebus.com>
Cc: xenomai@xenomai.org

On 09/11/2012 07:01 AM, Doug Brunner wrote:

> While running my latency testing earlier I saw some rather high 
> worst-case latencies (~70us) compared to average case (~14us), so I ran 
> again with I-pipe tracing enabled. However, I'm not sure what to make of 
> the results.
> 
> My worst case involves an IRQ (common_interrupt appears in the trace 
> with user value 0xFFFFFFC4) and the wiki page talks about being able to 
> translate the user value 0xFFFFFFF4 into IRQ 11 but doesn't elaborate on 
> how this correspondence works. I'm not horribly concerned since it's a 
> delay of 53 us on a rather slow processor (Geode LX800) but it would be 
> nice to know what interrupt is taking so long.


You may also want to apply the following patch for SMI on Geode LX, and 
enable CONFIG_XENO_HW_SMI_WORKAROUND. You can remove the '#if 0', if you
do not use PCI.

diff --git a/ksrc/arch/x86/smi.c b/ksrc/arch/x86/smi.c
index d80b14b..6d641be 100644
--- a/ksrc/arch/x86/smi.c
+++ b/ksrc/arch/x86/smi.c
@@ -31,6 +31,7 @@
 #include <linux/reboot.h>
 #include <asm-generic/xenomai/pci_ids.h>
 #include <asm/xenomai/hal.h>
+#include <asm/geode.h>
 
 static struct pci_device_id rthal_smi_pci_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_0)},
@@ -192,6 +193,35 @@ void rthal_smi_init(void)
 	struct pci_dev *dev = NULL;
 	struct pci_device_id *id;
 
+#ifdef CONFIG_XENO_HW_SMI_WORKAROUND
+	if (is_geode_lx()) {
+		unsigned long long val;
+#define SMM_CTRL_MSR 0x00001301
+
+/* Do not clear 0x10, that is SMI_IO */
+#define SMM_CTRL_MSR_CLR 0x0000000000000020ULL
+#define GLIU0_MSR_SMI 0x10002002
+#define GLIU1_MSR_SMI 0x40002002
+#define GLIU0_ASMI 0x10000083
+#define GLIU1_ASMI 0x40000083
+#define CS5536_MSR_SMI 0x4c002002
+#define CS5536_PCI_MSR_SMI 0x50002002
+
+		printk("Geode LX found, trying SMI workaround\n");
+		rdmsrl(SMM_CTRL_MSR, val);
+		wrmsrl(SMM_CTRL_MSR, val & ~SMM_CTRL_MSR_CLR);
+		wrmsrl(GLIU0_MSR_SMI, 0x0000001800000018ULL);
+		wrmsrl(GLIU1_MSR_SMI, 0x0000001800000018ULL);
+		wrmsrl(GLIU0_ASMI, 0x000000000000ffffULL);
+		wrmsrl(GLIU1_ASMI, 0x000000000000ffffULL);
+		wrmsrl(CS5536_MSR_SMI, 0x00000000001f001fULL);
+#if 0
+	       /* PCI SMI are needed to get PCI running. */
+		wrmsrl(CS5536_PCI_MSR_SMI, 0x00000000003f003fULL);
+#endif
+	}
+#endif
+
 	/*
 	 * Do not use pci_register_driver, pci_enable_device, ...
 	 * Just register the used ports.


-- 
                                                                Gilles.

