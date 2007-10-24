Message-ID: <471F6533.2090603@domain.hid>
Date: Wed, 24 Oct 2007 17:30:59 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <FDBBB5CC70676540B3EF7CFE83FD94E0B47622@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0B47622@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Xenomai on Xscale (Linux 2.6.20)
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
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

ROSSIER Daniel wrote:
> Hi all,
> 
> I've found a bug in arch/arm/xenomai/switch.S which solved the problem below. It actually comes from the iWMMXT (Intel Wireless MMX) coprocessor which is an extension of the ARM core in Xscale processor (and of course which is not available in the AT91 series ;-).
> 
> When a thread switch occurs, rthal_thread_switch(in arch/arm/xenomai/switch.S) is called to perform switching of registers and stacks between threads. The PXA version must also perform a switch of MMX registers by invoking iwmmxt_task_switch(in arch/arm/kernel/iwmmxt.S). This is done in rthal_task_switch() as well.
> 
> However, between Linux 2.6.15 and Linux 2.6.20, the general scheme of low-level task switching procedure changed a little bit: it is now relying on a call chain notifier-based mechanism. Therefore, the iwmmxt_task_switch() function has been updated since the function is called now from the notifier, and not directly from  __switch_to() as in 2.6.15. And the ipipe (ARM) patch did not take into account that.. and it fails. 
> 
> So, as a first workaround, I simply duplicated the iwmmxt_task_switch() function making the version (from 2.6.15) proprietary to ipipe by renaming to iwmmxt_task_switch_from_ipipe(), and modified arch/arm/xenomai/switch.S accordingly (be careful, switch.S is a symlink and actually belongs to Xenomai tree (ksrc/arch/arm).
> 
> It seems to work so far, but further tests are needed (and will be done).
> 
> I attached a patch to be applied in the (xenomai-patched) Linux tree.
> (Linux 2.6.20, xenomai from today svn). 
> 

Task switching is not I-pipe's business, and we should refrain from
recycling code from older kernel versions into recent ones. AFAICS, we
only need to conform to some new internal API. Food for thought below:

--- ksrc/arch/arm/switch.S	(revision 3095)
+++ ksrc/arch/arm/switch.S	(working copy)
@@ -18,6 +18,7 @@
  */

 #include <linux/linkage.h>
+#include <linux/version.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>

@@ -86,7 +87,13 @@
     VFPFMXR FPEXC, r4
 #endif
 #if defined(CONFIG_IWMMXT)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,18)
+    mr      r0, r2
     bl      iwmmxt_task_switch
+    mr      r2, r0
+#else
+    bl      iwmmxt_task_switch
+#endif
 #elif defined(CONFIG_CPU_XSCALE)
     add     r4, r2, #40                     @ cpu_context_save->extra
     ldmib   r4, {r4, r5}
-- 
Philippe.

