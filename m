From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:37:45 +0200
Message-Id: <20180925103809.4932-9-rpm@xenomai.org>
In-Reply-To: <20180925103809.4932-1-rpm@xenomai.org>
References: <20180925103809.4932-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 08/32] x86/mm: enable PTE pinning
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Ask the generic pipeline core to call us for pre-loading page table
entries upon ioremap/vmalloc, for preventing further minor faults
accessing such memory due to PTE misses.

Revisit: a better way may be to make the code handling minor faults
runnable safely and quickly from the head domain, by reorganizing a
couple of code paths in the fault handler. All other I-pipe ports
actually do just that.
---
 arch/x86/Kconfig    |  1 +
 arch/x86/mm/fault.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 400864c3c932..e09fdf5025e0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -148,6 +148,7 @@ config X86
 	select HAVE_IPIPE_SUPPORT
 	select HAVE_IPIPE_TRACER_SUPPORT
 	select IPIPE_HAVE_SAFE_THREAD_INFO if IPIPE
+	select IPIPE_WANT_PTE_PINNING if IPIPE
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZ4
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 794c35c4ca73..cac86d740686 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1501,3 +1501,50 @@ do_page_fault(struct pt_regs *regs, unsigned long error_code)
 	exception_exit(prev_state);
 }
 NOKPROBE_SYMBOL(do_page_fault);
+
+#ifdef CONFIG_IPIPE
+
+void __ipipe_pin_mapping_globally(unsigned long start, unsigned long end)
+{
+#ifdef CONFIG_X86_32
+	unsigned long next, addr = start;
+
+	do {
+		unsigned long flags;
+		struct page *page;
+
+		next = pgd_addr_end(addr, end);
+		spin_lock_irqsave(&pgd_lock, flags);
+		list_for_each_entry(page, &pgd_list, lru)
+			vmalloc_sync_one(page_address(page), addr);
+		spin_unlock_irqrestore(&pgd_lock, flags);
+
+	} while (addr = next, addr != end);
+#else
+	unsigned long next, addr = start;
+	pgd_t *pgd, *pgd_ref;
+	struct page *page;
+
+	if (!(start >= VMALLOC_START && start < VMALLOC_END))
+		return;
+
+	do {
+		next = pgd_addr_end(addr, end);
+		pgd_ref = pgd_offset_k(addr);
+		if (pgd_none(*pgd_ref))
+			continue;
+		spin_lock(&pgd_lock);
+		list_for_each_entry(page, &pgd_list, lru) {
+			pgd = page_address(page) + pgd_index(addr);
+			if (pgd_none(*pgd))
+				set_pgd(pgd, *pgd_ref);
+		}
+		spin_unlock(&pgd_lock);
+		addr = next;
+	} while (addr != end);
+
+	arch_flush_lazy_mmu_mode();
+#endif
+}
+
+#endif /* CONFIG_IPIPE */
-- 
2.14.4


