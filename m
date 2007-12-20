Message-ID: <476A529B.1040006@domain.hid>
Date: Thu, 20 Dec 2007 12:31:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000303080705090004080305"
Subject: [Adeos-main] [RFC][PATCH] x86-64: catch too large NR_CPUS
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

This is a multi-part message in MIME format.
--------------000303080705090004080305
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

building Xenomai for an 8-way box and deriving its setup from an
existing .config, I fortunately noticed some warning in ipipe.c. It
pointed out an overflow in IPIPE_IRQMASK_VIRT when NR_CPUS gets too
large. This causes NR_IRQS to explode, which then lets the virtual IRQ
mask overflow.

I bet no one currently wants to run Xenomai on such large systems, but
the problem is that the dependency above may nevertheless slip through
some setups unnoticed. Therefore, the attached patch catches this
invalid setup and bails out at compile time (does anyone have a nicer
idea for a config-time safety bag?).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------000303080705090004080305
Content-Type: text/x-patch;
 name="catch-too-many-cpus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="catch-too-many-cpus.patch"

---
 arch/x86_64/kernel/ipipe.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6.23.12-xeno/arch/x86_64/kernel/ipipe.c
===================================================================
--- linux-2.6.23.12-xeno.orig/arch/x86_64/kernel/ipipe.c
+++ linux-2.6.23.12-xeno/arch/x86_64/kernel/ipipe.c
@@ -44,6 +44,12 @@
 #include <asm/ipi.h>
 #include <asm/mach_apic.h>
 
+/* Sanity check: IPIPE_VIRQ_BASE depends on CONFIG_NR_CPUS, and if this
+   gets too large, we run into troubles with the ipipe IRQ log. */
+#if IPIPE_VIRQ_BASE / BITS_PER_LONG > BITS_PER_LONG
+# error CONFIG_NR_CPUS is too large, please lower it.
+#endif
+
 asmlinkage void preempt_schedule_irq(void);
 
 int __ipipe_tick_irq;		/* =0: 8254 */

--------------000303080705090004080305--

