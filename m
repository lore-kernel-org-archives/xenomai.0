Message-ID: <48E48A06.70408@domain.hid>
Date: Thu, 02 Oct 2008 10:44:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <899865CA54E4444DAF2E3639C04C5F48E4DA6A@trillian.at.omicron.at>	<48D66DC4.8030706@domain.hid>	<48D9364B.70505@domain.hid>
	<48DE72FE.4070809@domain.hid>
In-Reply-To: <48DE72FE.4070809@domain.hid>
Content-Type: multipart/mixed; boundary="------------020106000202020203080208"
Subject: Re: [Adeos-main] FW: [PATCH] repost: ARM FCSE
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>
Cc: adeos-main@gna.org

This is a multi-part message in MIME format.
--------------020106000202020203080208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Gilles Chanteperdrix wrote:
>>> Richard Cochran wrote:
>>>> I posted this patch today on linux-arm-kernel, but I repeat it
>>>> here because there does not seem to be too much interest on that
>>>> list for the ARM FCSE.
>>>>
>>>> I also tried to combine this patch with ipipe for kernel 2.6.20
>>>> running on the Intel IXDP465, but after booting I soon get a BUG.
>>>>
>>>> Anyhow, perhaps the ARM people might take a look at combining
>>>> ipipe with FCSE...
>>> Ok. Six monthes later, I finally gave a try to your patch on at91rm9200,
>>> which supports FCSE as well.
>>>
>>> When booting, I get random segmentation faults (either with or without
>>> the I-pipe), assertion which fails in glibc, and such things.
>> A small update: I get the same random failures with a vanilla kernel
>> (without I-pipe patch at all).
>>
>> I will now investigate pmd_populate.
> 
> Hi Richard,
> 
> I changed a few bits here and there in your patch, but I believe the
> biggest problem was that Linux seem to recycle pids faster than it
> recycles mm_struct, so we ended up with processes sharing the same
> space, and since the pid allocation mechanism was a bit too naive for
> multi-threaded applications, I changed it to a bitfield based solution.
> I now have an FCSE kernel which seems much more stable (and without the
> double mapping either). This is the good news.
> 
> The bad news is that I still get mysterious crashes. So, will now
> investigate.

Hi,

found the reason for the crash. The system seems to run stable now.
Here comes the patch.

Could you test it and confirm that there is no problem for you ?
Bosko: could you test it for arm926 ? I made the needed change in
arch/arm/mm/proc-arm926.S, but did not check it yet.
The patch is for vanilla Linux, I did not retest it with Xenomai yet
(though I tested the previous version with the random crashes, and
observed a 200us user-space latency instead of the usual 300us).

Regards.

-- 
                                                 Gilles.

--------------020106000202020203080208
Content-Type: text/plain;
 name="fcse.2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fcse.2.diff"

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index ad455ff..4481a30 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -10,6 +10,7 @@ obj-y		:= compat.o entry-armv.o entry-common.o irq.o \
 		   process.o ptrace.o setup.o signal.o \
 		   sys_arm.o stacktrace.o time.o traps.o
 
+obj-$(CONFIG_ARM_FCSE)		+= fcse.o
 obj-$(CONFIG_ISA_DMA_API)	+= dma.o
 obj-$(CONFIG_ARCH_ACORN)	+= ecard.o 
 obj-$(CONFIG_FIQ)		+= fiq.o
diff --git a/arch/arm/kernel/fcse.c b/arch/arm/kernel/fcse.c
new file mode 100644
index 0000000..1900a79
--- /dev/null
+++ b/arch/arm/kernel/fcse.c
@@ -0,0 +1,37 @@
+#include <linux/bitops.h>
+#include <linux/memory.h>
+#include <linux/spinlock.h>
+#include <linux/bitops.h>
+#include <asm/fcse.h>
+
+#define MAX_PID (MODULE_START / FCSE_PID_TASK_SIZE)
+#define PIDS_LONGS (MAX_PID + 8 * sizeof(long) - 1) / (8 * sizeof(long))
+
+static spinlock_t fcse_lock = SPIN_LOCK_UNLOCKED;
+static unsigned long fcse_pids_bits[PIDS_LONGS];
+
+int fcse_pid_alloc(void)
+{
+	unsigned long flags;
+	unsigned bit;
+
+	spin_lock_irqsave(&fcse_lock, flags);
+	bit = find_first_zero_bit(fcse_pids_bits, MAX_PID);
+	if (bit == MAX_PID) {
+		spin_unlock(&fcse_lock);
+		return -1;
+	}
+	set_bit(bit, fcse_pids_bits);
+	spin_unlock_irqrestore(&fcse_lock, flags);
+
+	return bit;
+}
+
+void fcse_pid_free(unsigned pid)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcse_lock, flags);
+	pid = test_and_clear_bit(pid, fcse_pids_bits);
+	spin_unlock_irqrestore(&fcse_lock, flags);
+}
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index eefae1d..b13d8a5 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -32,6 +32,7 @@
 #include <asm/processor.h>
 #include <asm/tlbflush.h>
 #include <asm/ptrace.h>
+#include <asm/fcse.h>
 
 /*
  * bitmask of present and online CPUs.
@@ -736,14 +737,14 @@ void flush_tlb_all(void)
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	cpumask_t mask = mm->cpu_vm_mask;
+	cpumask_t mask = fcse_tlb_mask(mm);
 
 	on_each_cpu_mask(ipi_flush_tlb_mm, mm, 1, 1, mask);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 {
-	cpumask_t mask = vma->vm_mm->cpu_vm_mask;
+	cpumask_t mask = fcse_tlb_mask(vma->vm_mm);
 	struct tlb_args ta;
 
 	ta.ta_vma = vma;
@@ -764,7 +765,7 @@ void flush_tlb_kernel_page(unsigned long kaddr)
 void flush_tlb_range(struct vm_area_struct *vma,
                      unsigned long start, unsigned long end)
 {
-	cpumask_t mask = vma->vm_mm->cpu_vm_mask;
+	cpumask_t mask = fcse_tlb_mask(vma->vm_mm);
 	struct tlb_args ta;
 
 	ta.ta_vma = vma;
diff --git a/arch/arm/kernel/sys_arm.c b/arch/arm/kernel/sys_arm.c
index 0128687..732f442 100644
--- a/arch/arm/kernel/sys_arm.c
+++ b/arch/arm/kernel/sys_arm.c
@@ -61,7 +61,18 @@ inline long do_mmap2(
 
 	if (file)
 		fput(file);
+#ifdef CONFIG_ARM_FCSE
+	/* FIXME, this really sucks, and we should really recheck in mremap and
+	   munmap */
+	if (likely((unsigned) error < (unsigned)(-4096))
+	    && (flags & MAP_SHARED) && (prot & PROT_WRITE)) {
+		struct vm_area_struct *vma = find_vma(current->mm, error);
+		if (vma->vm_page_prot & (L_PTE_CACHEABLE | L_PTE_BUFFERABLE))
+			++current->mm->context.mappings_needing_flush;
+	}
+#endif
 out:
+
 	return error;
 }
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 5595fdd..466e230 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -35,7 +35,7 @@
 static const char *handler[]= { "prefetch abort", "data abort", "address exception", "interrupt" };
 
 #ifdef CONFIG_DEBUG_USER
-unsigned int user_debug;
+unsigned int user_debug = 0;
 
 static int __init user_debug_setup(char *str)
 {
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 33ed048..6c40ac0 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -716,3 +716,10 @@ config CACHE_L2X0
 	select OUTER_CACHE
 	help
 	  This option enables the L2x0 PrimeCell.
+
+config ARM_FCSE
+	bool "Fast Context Switch Extension (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	default n
+	help
+	  Say Y here to enable the ARM FCSE. If unsure, say N.
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 28ad7ab..2235ab8 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -13,11 +13,13 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/kprobes.h>
+#include <linux/kallsyms.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/uaccess.h>
+#include <asm/fcse.h>
 
 #include "fault.h"
 
@@ -44,6 +46,65 @@ static inline int notify_page_fault(struct pt_regs *regs, unsigned int fsr)
 }
 #endif
 
+#ifdef CONFIG_ARM_FCSE
+void check_pgd(struct mm_struct *mm)
+{
+	pgd_t *pgd = mm->pgd;
+	unsigned i, start = 0, end = 0;
+
+	for (i = 0; i < (mm->context.pid >> PGDIR_SHIFT); i++)
+		if (((unsigned long *)(pgd + i))[0]
+		    || ((unsigned long *)(pgd + i))[1]) {
+			if (!start)
+				start = i;
+			end = i + 1;
+		} else {
+			if (start) {
+				printk("\nError pgd not null at 0x%08x - 0x%08x,"
+				       " pid: 0x%08lx\n",
+				       start << PGDIR_SHIFT,
+				       end << PGDIR_SHIFT,
+				       mm->context.pid);
+				start = 0;
+			}
+		}
+
+	if (start) {
+		printk("\nError pgd not null at 0x%08x - 0x%08x,"
+				       " pid: 0x%08lx\n",
+		       start << PGDIR_SHIFT,
+		       end << PGDIR_SHIFT,
+		       mm->context.pid);
+		start = 0;
+	}
+	for (i = ((mm->context.pid + 0x2000000) >> PGDIR_SHIFT);
+	     i < (MODULE_START >> PGDIR_SHIFT); i++)
+		if (((unsigned long *)(pgd + i))[0]
+		    || ((unsigned long *)(pgd + i))[1]) {
+			if (!start)
+				start = i;
+			end = i + 1;
+		} else {
+			if (start) {
+				printk("\nError pgd not null at 0x%08x - 0x%08x,"
+				       " pid: 0x%08lx\n",
+				       start << PGDIR_SHIFT,
+				       end << PGDIR_SHIFT,
+				       mm->context.pid);
+				start = 0;
+			}
+		}
+	if (start) {
+		printk("\nError pgd not null at 0x%08x - 0x%08x,"
+				       " pid: 0x%08lx\n",
+		       start << PGDIR_SHIFT,
+		       end << PGDIR_SHIFT,
+		       mm->context.pid);
+		start = 0;
+	}
+}
+#endif /* CONFIG_ARM_FCSE */
+
 /*
  * This is useful to dump out the page tables associated with
  * 'addr' in mm 'mm'.
@@ -55,6 +116,10 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 	if (!mm)
 		mm = &init_mm;
 
+#ifdef CONFIG_ARM_FCSE
+	printk(KERN_ALERT "fcse pid: %ld, 0x%08lx\n",
+	       mm->context.pid >> FCSE_PID_SHIFT, mm->context.pid);
+#endif /* CONFIG_ARM_FCSE */
 	printk(KERN_ALERT "pgd = %p\n", mm->pgd);
 	pgd = pgd_offset(mm, addr);
 	printk(KERN_ALERT "[%08lx] *pgd=%08lx", addr, pgd_val(*pgd));
@@ -466,6 +531,8 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	const struct fsr_info *inf = fsr_info + (fsr & 15) + ((fsr & (1 << 10)) >> 6);
 	struct siginfo info;
 
+	addr = fcse_mva_to_va(addr);
+
 	if (!inf->fn(addr, fsr, regs))
 		return;
 
@@ -484,4 +551,3 @@ do_PrefetchAbort(unsigned long addr, struct pt_regs *regs)
 {
 	do_translation_fault(addr, 0, regs);
 }
-
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 9df507d..412a10a 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -14,6 +14,7 @@
 #include <asm/cacheflush.h>
 #include <asm/system.h>
 #include <asm/tlbflush.h>
+#include <asm/fcse.h>
 
 #include "mm.h"
 
@@ -58,9 +59,11 @@ void flush_cache_mm(struct mm_struct *mm)
 void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
 {
 	if (cache_is_vivt()) {
-		if (cpu_isset(smp_processor_id(), vma->vm_mm->cpu_vm_mask))
-			__cpuc_flush_user_range(start & PAGE_MASK, PAGE_ALIGN(end),
-						vma->vm_flags);
+		if (cpu_isset(smp_processor_id(), vma->vm_mm->cpu_vm_mask)) {
+			start = fcse_va_to_mva(vma->vm_mm, start) & PAGE_MASK;
+			end = PAGE_ALIGN(fcse_va_to_mva(vma->vm_mm, end));
+			__cpuc_flush_user_range(start, end, vma->vm_flags);
+		}
 		return;
 	}
 
@@ -78,7 +81,8 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 {
 	if (cache_is_vivt()) {
 		if (cpu_isset(smp_processor_id(), vma->vm_mm->cpu_vm_mask)) {
-			unsigned long addr = user_addr & PAGE_MASK;
+			unsigned long addr;
+			addr = fcse_va_to_mva(vma->vm_mm, user_addr) & PAGE_MASK;
 			__cpuc_flush_user_range(addr, addr + PAGE_SIZE, vma->vm_flags);
 		}
 		return;
diff --git a/arch/arm/mm/pgd.c b/arch/arm/mm/pgd.c
index e0f19ab..4da5e30 100644
--- a/arch/arm/mm/pgd.c
+++ b/arch/arm/mm/pgd.c
@@ -16,7 +16,11 @@
 
 #include "mm.h"
 
+#ifndef CONFIG_ARM_FCSE
 #define FIRST_KERNEL_PGD_NR	(FIRST_USER_PGD_NR + USER_PTRS_PER_PGD)
+#else /* CONFIG_ARM_FCSE */
+#define FIRST_KERNEL_PGD_NR	(MODULE_START / PGDIR_SIZE)
+#endif /* CONFIG_ARM_FCSE */
 
 /*
  * need to get a 16k page for level 1
@@ -26,6 +30,15 @@ pgd_t *get_pgd_slow(struct mm_struct *mm)
 	pgd_t *new_pgd, *init_pgd;
 	pmd_t *new_pmd, *init_pmd;
 	pte_t *new_pte, *init_pte;
+#ifdef CONFIG_ARM_FCSE
+	int pid;
+
+	pid = fcse_pid_alloc();
+	if (pid == -1)
+		goto no_pgd;
+
+	mm->context.pid = pid << FCSE_PID_SHIFT;
+#endif /* CONFIG_ARM_FCSE */
 
 	new_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, 2);
 	if (!new_pgd)
@@ -43,11 +56,15 @@ pgd_t *get_pgd_slow(struct mm_struct *mm)
 	clean_dcache_area(new_pgd, PTRS_PER_PGD * sizeof(pgd_t));
 
 	if (!vectors_high()) {
+		/* We can not use pgd_offset here since mm->pgd is not yet
+		   initialized. */
+		pgd_t *pgd = new_pgd + pgd_index(fcse_va_to_mva(mm, 0));
+
 		/*
 		 * On ARM, first page must always be allocated since it
 		 * contains the machine vectors.
 		 */
-		new_pmd = pmd_alloc(mm, new_pgd, 0);
+		new_pmd = pmd_alloc(mm, pgd, 0);
 		if (!new_pmd)
 			goto no_pmd;
 
@@ -96,4 +113,7 @@ void free_pgd_slow(struct mm_struct *mm, pgd_t *pgd)
 	pmd_free(mm, pmd);
 free:
 	free_pages((unsigned long) pgd, 2);
+#ifdef CONFIG_ARM_FCSE
+	fcse_pid_free(mm->context.pid >> FCSE_PID_SHIFT);
+#endif /* CONFIG_ARM_FCSE */
 }
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 28cdb06..1f16a58 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -321,6 +321,10 @@ ENTRY(cpu_arm920_dcache_clean_area)
 ENTRY(cpu_arm920_switch_mm)
 #ifdef CONFIG_MMU
 	mov	ip, #0
+#ifdef CONFIG_ARM_FCSE
+	cmp	r1, #0
+	beq	.LCnoflush
+#endif
 #ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
 	mcr	p15, 0, ip, c7, c6, 0		@ invalidate D cache
 #else
@@ -338,6 +342,9 @@ ENTRY(cpu_arm920_switch_mm)
 #endif
 	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
 	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
+#ifdef CONFIG_ARM_FCSE
+.LCnoflush:
+#endif
 	mcr	p15, 0, r0, c2, c0, 0		@ load page table pointer
 	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I & D TLBs
 #endif
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 4cd3316..edec79b 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -337,6 +337,10 @@ ENTRY(cpu_arm926_dcache_clean_area)
 ENTRY(cpu_arm926_switch_mm)
 #ifdef CONFIG_MMU
 	mov	ip, #0
+#ifdef CONFIG_ARM_FCSE
+	cmp	r1, #0
+	beq	.LCnoflush
+#endif
 #ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
 	mcr	p15, 0, ip, c7, c6, 0		@ invalidate D cache
 #else
@@ -346,6 +350,9 @@ ENTRY(cpu_arm926_switch_mm)
 #endif
 	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
 	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
+#ifdef CONFIG_ARM_FCSE
+.LCnoflush:
+#endif
 	mcr	p15, 0, r0, c2, c0, 0		@ load page table pointer
 	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I & D TLBs
 #endif
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 2dd8527..2841857 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -417,9 +417,16 @@ ENTRY(cpu_xscale_dcache_clean_area)
  */
 	.align	5
 ENTRY(cpu_xscale_switch_mm)
+#ifdef CONFIG_ARM_FCSE
+	cmp	r1, #0
+	beq	.LCnoflush
+#endif
 	clean_d_cache r1, r2
 	mcr	p15, 0, ip, c7, c5, 0		@ Invalidate I cache & BTB
 	mcr	p15, 0, ip, c7, c10, 4		@ Drain Write (& Fill) Buffer
+#ifdef CONFIG_ARM_FCSE
+.LCnoflush:
+#endif
 	mcr	p15, 0, r0, c2, c0, 0		@ load page table pointer
 	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I & D TLBs
 	cpwait_ret lr, ip
diff --git a/include/asm-arm/cacheflush.h b/include/asm-arm/cacheflush.h
index 759a97b..b4b3b08 100644
--- a/include/asm-arm/cacheflush.h
+++ b/include/asm-arm/cacheflush.h
@@ -15,6 +15,7 @@
 
 #include <asm/glue.h>
 #include <asm/shmparam.h>
+#include <asm/fcse.h>
 
 #define CACHE_COLOUR(vaddr)	((vaddr & (SHMLBA - 1)) >> PAGE_SHIFT)
 
@@ -339,16 +340,20 @@ static inline void flush_cache_mm(struct mm_struct *mm)
 static inline void
 flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
 {
-	if (cpu_isset(smp_processor_id(), vma->vm_mm->cpu_vm_mask))
+	if (cpu_isset(smp_processor_id(), vma->vm_mm->cpu_vm_mask)) {
+		start = fcse_va_to_mva(vma->vm_mm,start);
+		end = fcse_va_to_mva(vma->vm_mm,end);
 		__cpuc_flush_user_range(start & PAGE_MASK, PAGE_ALIGN(end),
 					vma->vm_flags);
+	}
 }
 
 static inline void
 flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn)
 {
 	if (cpu_isset(smp_processor_id(), vma->vm_mm->cpu_vm_mask)) {
-		unsigned long addr = user_addr & PAGE_MASK;
+		unsigned long addr;
+		addr = fcse_va_to_mva(vma->vm_mm,user_addr) & PAGE_MASK;
 		__cpuc_flush_user_range(addr, addr + PAGE_SIZE, vma->vm_flags);
 	}
 }
@@ -379,8 +384,14 @@ extern void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
  * Harvard caches are synchronised for the user space address range.
  * This is used for the ARM private sys_cacheflush system call.
  */
-#define flush_cache_user_range(vma,start,end) \
-	__cpuc_coherent_user_range((start) & PAGE_MASK, PAGE_ALIGN(end))
+#define flush_cache_user_range(vma,start,end)			\
+	({							\
+		struct mm_struct *_mm = (vma)->vm_mm;		\
+		unsigned long _start, _end;			\
+		_start = fcse_va_to_mva(_mm,start) & PAGE_MASK;	\
+		_end = PAGE_ALIGN(fcse_va_to_mva(_mm,end));	\
+		__cpuc_coherent_user_range(_start, _end);	\
+	})
 
 /*
  * Perform necessary cache operations to ensure that data previously
@@ -417,7 +428,7 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 	extern void __flush_anon_page(struct vm_area_struct *vma,
 				struct page *, unsigned long);
 	if (PageAnon(page))
-		__flush_anon_page(vma, page, vmaddr);
+		__flush_anon_page(vma, page, fcse_va_to_mva(vma->vm_mm,vmaddr));
 }
 
 #define flush_dcache_mmap_lock(mapping) \
diff --git a/include/asm-arm/cpu-multi32.h b/include/asm-arm/cpu-multi32.h
index 3479de9..627daf3 100644
--- a/include/asm-arm/cpu-multi32.h
+++ b/include/asm-arm/cpu-multi32.h
@@ -52,7 +52,7 @@ extern struct processor {
 	/*
 	 * Set the page table
 	 */
-	void (*switch_mm)(unsigned long pgd_phys, struct mm_struct *mm);
+	void (*switch_mm)(unsigned long pgd_phys, struct mm_struct *mm, unsigned cacheflush);
 	/*
 	 * Set a possibly extended PTE.  Non-extended PTEs should
 	 * ignore 'ext'.
@@ -66,4 +66,4 @@ extern struct processor {
 #define cpu_do_idle()			processor._do_idle()
 #define cpu_dcache_clean_area(addr,sz)	processor.dcache_clean_area(addr,sz)
 #define cpu_set_pte_ext(ptep,pte,ext)	processor.set_pte_ext(ptep,pte,ext)
-#define cpu_do_switch_mm(pgd,mm)	processor.switch_mm(pgd,mm)
+#define cpu_do_switch_mm(pgd,mm,flush)	processor.switch_mm(pgd,mm,flush)
diff --git a/include/asm-arm/cpu-single.h b/include/asm-arm/cpu-single.h
index 0b120ee..e3a59f7 100644
--- a/include/asm-arm/cpu-single.h
+++ b/include/asm-arm/cpu-single.h
@@ -39,6 +39,6 @@ extern void cpu_proc_init(void);
 extern void cpu_proc_fin(void);
 extern int cpu_do_idle(void);
 extern void cpu_dcache_clean_area(void *, int);
-extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
+extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm, unsigned cacheflush);
 extern void cpu_set_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext);
 extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
diff --git a/include/asm-arm/fcse.h b/include/asm-arm/fcse.h
new file mode 100644
index 0000000..bfcd6ba
--- /dev/null
+++ b/include/asm-arm/fcse.h
@@ -0,0 +1,79 @@
+/*
+ * Filename:    include/asm-arm/pid.h                                 
+ * Description: ARM Porcess ID (PID) includes for Fast Address Space Switching
+ *              (FASS) in ARM Linux.
+ * Created:     14/10/2001
+ * Changes:     19/02/2002 - Macros added.
+ *              03/08/2007 - Adapted to kernel 2.6.21 (ssm)
+ *              Feb 2008   - Simplified a bit (rco)
+ *
+ * Copyright:   (C) 2001, 2002 Adam Wiggins <awiggins@domain.hid>
+ *              (C) 2007 Sebastian Smolorz <ssm@domain.hid>
+ *              (C) 2008 Richard Co		if (next)
+chran
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of teh GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_PROC_PID_H
+#define __ASM_PROC_PID_H
+
+#ifdef CONFIG_ARM_FCSE
+
+#define FCSE_PID_SHIFT 25
+
+/* Size of PID relocation area */
+#define FCSE_PID_TASK_SIZE (1UL << FCSE_PID_SHIFT)
+
+/* Mask to get rid of PID from relocated address */
+#define FCSE_PID_MASK (FCSE_PID_TASK_SIZE - 1)
+
+#define fcse_tlb_mask(mm) ((mm)->context.cpu_tlb_mask)
+#define fcse_cpu_set_vm_mask(cpu, mm) cpu_set(cpu, (mm)->cpu_vm_mask)
+#define fcse_needs_flush(mm) ((mm)->context.mappings_needing_flush)
+
+/* Sets the CPU's PID Register */
+static inline void fcse_pid_set(unsigned long pid)
+{
+	__asm__ __volatile__("mcr p15, 0, %0, c13, c0, 0": /* */: "r" (pid));
+}
+
+/* Returns the state of the CPU's PID Register */
+static inline unsigned long fcse_pid_get(void)
+{
+	unsigned long pid;
+	__asm__ __volatile__("mrc p15, 0, %0, c13, c0, 0" : "=&r" (pid));
+	return (pid & (~FCSE_PID_MASK));
+}
+
+static inline unsigned long fcse_mva_to_va(unsigned long mva)
+{
+	unsigned long pid = fcse_pid_get();
+	if (pid && (pid == (mva & ~FCSE_PID_MASK))) {
+		return mva & FCSE_PID_MASK;
+	}
+	return mva;
+}
+
+static inline unsigned long fcse_va_to_mva(struct mm_struct *mm, unsigned long va)
+{
+	if (va < FCSE_PID_TASK_SIZE) {
+		return mm->context.pid | va;
+	}
+	return va;
+}
+
+int fcse_pid_alloc(void);
+void fcse_pid_free(unsigned pid);
+
+#else /* CONFIG_ARM_FCSE */
+#define fcse_pid_set(pid) do { } while(0)
+#define fcse_mva_to_va(x) (x)
+#define fcse_va_to_mva(vma,x) (x)
+#define fcse_tlb_mask(mm) ((mm)->cpu_vm_mask)
+#define fcse_cpu_set_vm_mask(cpu, mm) do { } while(0)
+#define fcse_needs_flush(mm) (1)
+#endif
+
+#endif
diff --git a/include/asm-arm/memory.h b/include/asm-arm/memory.h
index 9ba4d71..bda4e74 100644
--- a/include/asm-arm/memory.h
+++ b/include/asm-arm/memory.h
@@ -34,14 +34,23 @@
  * TASK_SIZE - the maximum size of a user space task.
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area
  */
+#ifdef CONFIG_ARM_FCSE
+#define TASK_SIZE		UL(0x02000000)
+#define TASK_UNMAPPED_BASE	UL(0x01000000)
+#else
 #define TASK_SIZE		UL(0xbf000000)
 #define TASK_UNMAPPED_BASE	UL(0x40000000)
 #endif
+#endif
 
 /*
  * The maximum size of a 26-bit user space task.
  */
+#ifdef CONFIG_ARM_FCSE
+#define TASK_SIZE_26		UL(0x02000000)
+#else
 #define TASK_SIZE_26		UL(0x04000000)
+#endif
 
 /*
  * Page offset: 3GB
diff --git a/include/asm-arm/mmu.h b/include/asm-arm/mmu.h
index 53099d4..b74d736 100644
--- a/include/asm-arm/mmu.h
+++ b/include/asm-arm/mmu.h
@@ -7,6 +7,11 @@ typedef struct {
 #ifdef CONFIG_CPU_HAS_ASID
 	unsigned int id;
 #endif
+#ifdef CONFIG_ARM_FCSE
+	unsigned long pid;
+	unsigned mappings_needing_flush;
+	cpumask_t cpu_tlb_mask;
+#endif
 	unsigned int kvm_seq;
 } mm_context_t;
 
diff --git a/include/asm-arm/mmu_context.h b/include/asm-arm/mmu_context.h
index 6913d02..47339c2 100644
--- a/include/asm-arm/mmu_context.h
+++ b/include/asm-arm/mmu_context.h
@@ -17,6 +17,7 @@
 #include <asm/cacheflush.h>
 #include <asm/proc-fns.h>
 #include <asm-generic/mm_hooks.h>
+#include <asm/fcse.h>
 
 void __check_kvm_seq(struct mm_struct *mm);
 
@@ -64,7 +65,15 @@ static inline void check_context(struct mm_struct *mm)
 		__check_kvm_seq(mm);
 }
 
-#define init_new_context(tsk,mm)	0
+
+static inline int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+#ifdef CONFIG_ARM_FCSE
+	cpus_clear(mm->context.cpu_tlb_mask);
+	mm->context.mappings_needing_flush = 0;
+#endif /* CONFIG_ARM_FCSE */
+	return 0;
+}
 
 #endif
 
@@ -97,11 +106,13 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #ifdef CONFIG_MMU
 	unsigned int cpu = smp_processor_id();
 
-	if (!cpu_test_and_set(cpu, next->cpu_vm_mask) || prev != next) {
+	if (!cpu_test_and_set(cpu, fcse_tlb_mask(next)) || prev != next) {
+		fcse_cpu_set_vm_mask(cpu, next);
 		check_context(next);
-		cpu_switch_mm(next->pgd, next);
+		fcse_pid_set(next->context.pid);
+		cpu_switch_mm(next->pgd, next, fcse_needs_flush(next));
 		if (cache_is_vivt())
-			cpu_clear(cpu, prev->cpu_vm_mask);
+			cpu_clear(cpu, fcse_tlb_mask(prev));
 	}
 #endif
 }
diff --git a/include/asm-arm/pgtable.h b/include/asm-arm/pgtable.h
index 5571c13..701f458 100644
--- a/include/asm-arm/pgtable.h
+++ b/include/asm-arm/pgtable.h
@@ -344,10 +344,14 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 /* to find an entry in a page-table-directory */
 #define pgd_index(addr)		((addr) >> PGDIR_SHIFT)
 
-#define pgd_offset(mm, addr)	((mm)->pgd+pgd_index(addr))
+#define pgd_offset(mm, addr)						\
+	({								\
+		struct mm_struct *_mm = (mm);				\
+		(_mm->pgd + pgd_index(fcse_va_to_mva(_mm,(addr))));	\
+	})
 
 /* to find an entry in a kernel page-table-directory */
-#define pgd_offset_k(addr)	pgd_offset(&init_mm, addr)
+#define pgd_offset_k(addr)	(init_mm.pgd+pgd_index(addr))
 
 /* Find an entry in the second-level page table.. */
 #define pmd_offset(dir, addr)	((pmd_t *)(dir))
diff --git a/include/asm-arm/proc-fns.h b/include/asm-arm/proc-fns.h
index 75ec760..37ba564 100644
--- a/include/asm-arm/proc-fns.h
+++ b/include/asm-arm/proc-fns.h
@@ -223,7 +223,8 @@
 
 #ifdef CONFIG_MMU
 
-#define cpu_switch_mm(pgd,mm) cpu_do_switch_mm(virt_to_phys(pgd),mm)
+#define cpu_switch_mm(pgd,mm,cacheflush) \
+	cpu_do_switch_mm(virt_to_phys(pgd),mm,(cacheflush))
 
 #define cpu_get_pgd()	\
 	({						\
diff --git a/include/asm-arm/tlbflush.h b/include/asm-arm/tlbflush.h
index 8c6bc1b..98cd28f 100644
--- a/include/asm-arm/tlbflush.h
+++ b/include/asm-arm/tlbflush.h
@@ -158,6 +158,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/sched.h>
+#include <asm/fcse.h>
 
 struct cpu_tlb_fns {
 	void (*flush_user_range)(unsigned long, unsigned long, struct vm_area_struct *);
@@ -292,7 +293,7 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (cpu_isset(smp_processor_id(), mm->cpu_vm_mask)) {
+	if (cpu_isset(smp_processor_id(), fcse_tlb_mask(mm))) {
 		if (tlb_flag(TLB_V3_FULL))
 			asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (zero) : "cc");
 		if (tlb_flag(TLB_V4_U_FULL))
@@ -325,12 +326,13 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	const int zero = 0;
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
-	uaddr = (uaddr & PAGE_MASK) | ASID(vma->vm_mm);
+	uaddr = (fcse_va_to_mva(vma->vm_mm,uaddr) & PAGE_MASK)
+		| ASID(vma->vm_mm);
 
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (cpu_isset(smp_processor_id(), vma->vm_mm->cpu_vm_mask)) {
+	if (cpu_isset(smp_processor_id(), fcse_tlb_mask(vma->vm_mm))) {
 		if (tlb_flag(TLB_V3_PAGE))
 			asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (uaddr) : "cc");
 		if (tlb_flag(TLB_V4_U_PAGE))
@@ -437,7 +439,15 @@ static inline void clean_pmd_entry(pmd_t *pmd)
 /*
  * Convert calls to our calling convention.
  */
-#define local_flush_tlb_range(vma,start,end)	__cpu_flush_user_tlb_range(start,end,vma)
+#define local_flush_tlb_range(vma,start,end)			\
+	({							\
+		struct mm_struct *_mm = (vma)->vm_mm;		\
+		unsigned long _start, _end;			\
+		_start = fcse_va_to_mva(_mm, start);		\
+		_end = fcse_va_to_mva(_mm, end);		\
+		__cpu_flush_user_tlb_range(_start, _end, vma);	\
+	})
+
 #define local_flush_tlb_kernel_range(s,e)	__cpu_flush_kern_tlb_range(s,e)
 
 #ifndef CONFIG_SMP

--------------020106000202020203080208--

