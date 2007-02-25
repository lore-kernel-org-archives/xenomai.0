From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-core] Re: [Adeos-main] Re: Heads up: Xenomai port over
	x86_64 has started
Date: Sun, 25 Feb 2007 00:15:35 +0000
References: <1170205077.21219.67.camel@domain.hid>
	<17888.41453.933445.213344@domain.hid>
	<1172357204.2161.67.camel@domain.hid>
In-Reply-To: <1172357204.2161.67.camel@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nUN4F6tBpzb0Sju"
Message-Id: <200702250015.35735.paul_c@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, rpm@xenomai.org

--Boundary-00=_nUN4F6tBpzb0Sju
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi Philippe

On Saturday 24 February 2007 22:46, Philippe Gerum wrote:
> Added to the fact that I've just fixed the CONFIG_SMP
> +CONFIG_PREEMPT issue [1], what remains to get a fully functional
> preliminary x86_64 port is to solve the CONFIG_SMP+CONFIG_IPIPE_TRACE,
> and we should be done.

If CONFIG_PREEMPT is not enabled, the kernel compile fails with:

arch/x86_64/kernel/built-in.o: In function `__ipipe_preempt_schedule_irq':
arch/x86_64/kernel/ipipe.c:471: undefined reference to `preempt_schedule_irq'
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Leaving directory `/var/tmp/linux-2.6.19.3'
make: *** [debian/stamp-build-kernel] Error 2

The attached patch addresses the problem..


Regards, Paul.





--Boundary-00=_nUN4F6tBpzb0Sju
Content-Type: text/x-diff;
  charset="us-ascii";
  name="config_preempt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config_preempt.diff"

diff -uwpr linux-2.6.19.3-orig/arch/x86_64/kernel/ipipe.c linux-2.6.19.3/arch/x86_64/kernel/ipipe.c
--- linux-2.6.19.3-orig/arch/x86_64/kernel/ipipe.c	2007-02-24 23:36:04.000000000 +0000
+++ linux-2.6.19.3/arch/x86_64/kernel/ipipe.c	2007-02-24 23:58:07.000000000 +0000
@@ -44,7 +44,9 @@
 #include <asm/ipi.h>
 #include <asm/mach_apic.h>
 
+#ifdef CONFIG_PREEMPT
 asmlinkage void preempt_schedule_irq(void);
+#endif
 
 struct pt_regs __ipipe_tick_regs[IPIPE_NR_CPUS];
 
@@ -450,6 +452,7 @@ static inline void __fixup_if(struct pt_
 	ipipe_put_cpu(flags);
 }
 
+#ifdef CONFIG_PREEMPT
 /*  Check the stall bit of the root domain to make sure the existing
     preemption opportunity upon in-kernel resumption could be
     exploited. In case a rescheduling could take place, the root stage
@@ -475,6 +478,7 @@ asmlinkage int __ipipe_preempt_schedule_
 
 	return 1;
 }
+#endif /* CONFIG_PREEMPT */
 
 asmlinkage int __ipipe_syscall_root(struct pt_regs *regs)
 {

--Boundary-00=_nUN4F6tBpzb0Sju--

