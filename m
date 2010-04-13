Message-ID: <4BC4AC9D.9070001@domain.hid>
Date: Tue, 13 Apr 2010 19:40:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] x86: Virtualize cr2
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Ensure that we always call the Linux page fault handler with the correct
cr2 value set. So far this is not the case if a second fault happens
while we execute the domain fault handler (which may, e.g., perform a
sleepy migration before returning).

Instead of re-writing cr2 directly in hardware, make use of the paravirt
capabilities of Linux and simply overload read/write_cr2 for this
purpose.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/include/asm/ipipe.h  |    2 ++
 arch/x86/include/asm/system.h |    5 +++++
 arch/x86/kernel/ipipe.c       |   10 ++++++++++
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/ipipe.h b/arch/x86/include/asm/ipipe.h
index 32b2ece..baec016 100644
--- a/arch/x86/include/asm/ipipe.h
+++ b/arch/x86/include/asm/ipipe.h
@@ -33,6 +33,8 @@
 
 DECLARE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
 
+DECLARE_PER_CPU(unsigned long, __ipipe_cr2);
+
 static inline unsigned __ipipe_get_irq_vector(int irq)
 {
 #ifdef CONFIG_X86_IO_APIC
diff --git a/arch/x86/include/asm/system.h b/arch/x86/include/asm/system.h
index 2760033..093687e 100644
--- a/arch/x86/include/asm/system.h
+++ b/arch/x86/include/asm/system.h
@@ -308,8 +308,13 @@ static inline void native_wbinvd(void)
 #else
 #define read_cr0()	(native_read_cr0())
 #define write_cr0(x)	(native_write_cr0(x))
+#ifdef CONFIG_IPIPE
+#define read_cr2()	__raw_get_cpu_var(__ipipe_cr2)
+#define write_cr2(x)	__raw_get_cpu_var(__ipipe_cr2) = (x)
+#else /* !CONFIG_IPIPE */
 #define read_cr2()	(native_read_cr2())
 #define write_cr2(x)	(native_write_cr2(x))
+#endif /* !CONFIG_IPIPE */
 #define read_cr3()	(native_read_cr3())
 #define write_cr3(x)	(native_write_cr3(x))
 #define read_cr4()	(native_read_cr4())
diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index b1b6912..9425fbd 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -53,6 +53,9 @@ int __ipipe_tick_irq = 0;	/* Legacy timer */
 
 DEFINE_PER_CPU(struct pt_regs, __ipipe_tick_regs);
 
+DEFINE_PER_CPU(unsigned long, __ipipe_cr2);
+EXPORT_PER_CPU_SYMBOL_GPL(__ipipe_cr2);
+
 #ifdef CONFIG_SMP
 
 static cpumask_t __ipipe_cpu_sync_map;
@@ -712,6 +715,7 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 {
 	bool root_entry = false;
 	unsigned long flags = 0;
+	unsigned long cr2 = 0;
 
 	if (ipipe_root_domain_p) {
 		root_entry = true;
@@ -734,6 +738,9 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 		return 1;
 #endif /* CONFIG_KGDB */
 
+	if (vector == ex_do_page_fault)
+		cr2 = native_read_cr2();
+
 	if (unlikely(ipipe_trap_notify(vector, regs))) {
 		if (root_entry)
 			local_irq_restore_nosync(flags);
@@ -779,6 +786,9 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 		}
 	}
 
+	if (vector == ex_do_page_fault)
+		write_cr2(cr2);
+
 	__ipipe_std_extable[vector](regs, error_code);
 
 	/*


