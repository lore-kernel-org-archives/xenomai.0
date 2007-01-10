Message-ID: <45A52B04.1010706@domain.hid>
Date: Wed, 10 Jan 2007 19:05:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000509030301090208040504"
Subject: [Xenomai-core] Nocow patch.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------000509030301090208040504
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit


Hi,

I continued working on the idea of nocow patch, here is a beefed up version.
When setting the NOCOW flag for the first time:
- it faults any COW mapping of the target process, this is to handle the
case where a process would call fork (for example, in order to become a
daemon) before shadowing any thread;
- all vmalloc and ioremap areas are added to the target process vm.

A list of the mm structs of the processes which have the NOCOW flag is
maintained and used when calling vmalloc or ioremap to update only the
mapping of the processes in this list. This allows firstly to workaround
vmalloc and ioremap faults on architectures that do not have pgd_list,
and secondly should improve the overhead added by the I-pipe patch to
the ioremap and vmalloc calls.

Since the VM_NOCOW flag now really means "no page fault", the NOCOW flag
was renamed "NOFAULT".

This was run on x86, but need further testing before inclusion.


-- 
                                                 Gilles Chanteperdrix

--------------000509030301090208040504
Content-Type: text/x-patch;
 name="vm-nocow-2.6.19.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-nocow-2.6.19.2.patch"

diff -Naurdp -x '*~' ipipe-2.6.19/arch/i386/mm/fault.c ipipe-2.6.19-nocow/arch/i386/mm/fault.c
--- ipipe-2.6.19/arch/i386/mm/fault.c	2007-01-10 09:44:52.000000000 +0100
+++ ipipe-2.6.19-nocow/arch/i386/mm/fault.c	2007-01-10 18:08:18.000000000 +0100
@@ -654,3 +654,19 @@ void vmalloc_sync_all(void)
 	}
 }
 #endif
+
+#ifdef CONFIG_IPIPE
+int ipipe_arch_map_vm_area_to_mm(struct mm_struct *mm,
+				 unsigned long start,
+				 unsigned long end)
+{
+	unsigned long next, addr = start;
+
+	do {
+		next = pgd_addr_end(addr, end);
+		vmalloc_sync_one(mm->pgd, addr);
+	} while (addr = next, addr != end);
+
+	return 0;
+}
+#endif /* CONFIG_IPIPE */
diff -Naurdp -x '*~' ipipe-2.6.19/include/asm-i386/pgalloc.h ipipe-2.6.19-nocow/include/asm-i386/pgalloc.h
--- ipipe-2.6.19/include/asm-i386/pgalloc.h	2007-01-10 09:44:53.000000000 +0100
+++ ipipe-2.6.19-nocow/include/asm-i386/pgalloc.h	2007-01-10 12:09:27.000000000 +0100
@@ -46,27 +46,4 @@ static inline void pte_free(struct page 
 
 #define check_pgt_cache()	do { } while (0)
 
-static inline void set_pgdir(unsigned long address, pgd_t entry)
-{
-#ifdef CONFIG_IPIPE
-	struct task_struct * p;
-	struct page *page;
-	pgd_t *pgd;
-
-	read_lock(&tasklist_lock);
-
-	for_each_process(p) {
-		if(p->mm)
-		    *pgd_offset(p->mm,address) = entry;
-	}
-
-	read_unlock(&tasklist_lock);
-
-	for (page = pgd_list; page; page = (struct page *)page->index) {
-		pgd = (pgd_t *)page_address(page);
-		pgd[address >> PGDIR_SHIFT] = entry;
-	}
-#endif /* CONFIG_IPIPE */
-}
-
 #endif /* _I386_PGALLOC_H */
diff -Naurdp -x '*~' ipipe-2.6.19/include/linux/mm.h ipipe-2.6.19-nocow/include/linux/mm.h
--- ipipe-2.6.19/include/linux/mm.h	2007-01-04 10:10:33.000000000 +0100
+++ ipipe-2.6.19-nocow/include/linux/mm.h	2007-01-10 18:49:24.000000000 +0100
@@ -166,6 +166,7 @@ extern unsigned int kobjsize(const void 
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
 #define VM_INSERTPAGE	0x02000000	/* The vma has had "vm_insert_page()" done on it */
+#define VM_NOFAULT	0x10000000	/* Disable faults for the vma */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
diff -Naurdp -x '*~' ipipe-2.6.19/include/linux/sched.h ipipe-2.6.19-nocow/include/linux/sched.h
--- ipipe-2.6.19/include/linux/sched.h	2007-01-10 09:44:53.000000000 +0100
+++ ipipe-2.6.19-nocow/include/linux/sched.h	2007-01-10 11:08:20.000000000 +0100
@@ -363,6 +363,10 @@ struct mm_struct {
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
 	struct kioctx		*ioctx_list;
+
+#if CONFIG_IPIPE
+	struct list_head nofault;
+#endif /* CONFIG_IPIPE */
 };
 
 struct sighand_struct {
diff -Naurdp -x '*~' ipipe-2.6.19/kernel/fork.c ipipe-2.6.19-nocow/kernel/fork.c
--- ipipe-2.6.19/kernel/fork.c	2007-01-10 09:44:53.000000000 +0100
+++ ipipe-2.6.19-nocow/kernel/fork.c	2007-01-10 12:24:36.000000000 +0100
@@ -385,6 +385,7 @@ void mmput(struct mm_struct *mm)
 
 	if (atomic_dec_and_test(&mm->mm_users)) {
 		ipipe_cleanup_notify(mm);
+		ipipe_destroy_nofault_mm(mm);
 		exit_aio(mm);
 		exit_mmap(mm);
 		if (!list_empty(&mm->mmlist)) {
diff -Naurdp -x '*~' ipipe-2.6.19/lib/ioremap.c ipipe-2.6.19-nocow/lib/ioremap.c
--- ipipe-2.6.19/lib/ioremap.c	2007-01-10 09:44:53.000000000 +0100
+++ ipipe-2.6.19-nocow/lib/ioremap.c	2007-01-10 17:10:00.000000000 +0100
@@ -85,9 +85,10 @@ int ioremap_page_range(unsigned long add
 		err = ioremap_pud_range(pgd, addr, next, phys_addr+addr, prot);
 		if (err)
 			break;
-		set_pgdir(addr, *pgd);
 	} while (pgd++, addr = next, addr != end);
-
+#ifdef CONFIG_IPIPE
+	ipipe_update_nofault_mms(start, end);
+#endif /* CONFIG_IPIPE */
 	flush_cache_vmap(start, end);
 
 	return err;
diff -Naurdp -x '*~' ipipe-2.6.19/mm/memory.c ipipe-2.6.19-nocow/mm/memory.c
--- ipipe-2.6.19/mm/memory.c	2007-01-04 10:10:35.000000000 +0100
+++ ipipe-2.6.19-nocow/mm/memory.c	2007-01-10 18:41:10.000000000 +0100
@@ -50,6 +50,9 @@
 #include <linux/delayacct.h>
 #include <linux/init.h>
 #include <linux/writeback.h>
+#ifdef CONFIG_IPIPE
+#include <linux/vmalloc.h>	/* For vmlist */
+#endif /* CONFIG_IPIPE */
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -418,13 +421,41 @@ struct page *vm_normal_page(struct vm_ar
 	return pfn_to_page(pfn);
 }
 
+static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va)
+{
+	/*
+	 * If the source page was a PFN mapping, we don't have
+	 * a "struct page" for it. We do a best-effort copy by
+	 * just copying from the original user address. If that
+	 * fails, we just zero-fill it. Live with it.
+	 */
+	if (unlikely(!src)) {
+		void *kaddr = kmap_atomic(dst, KM_USER0);
+		void __user *uaddr = (void __user *)(va & PAGE_MASK);
+
+		/*
+		 * This really shouldn't fail, because the page is there
+		 * in the page tables. But it might just be unreadable,
+		 * in which case we just give up and fill the result with
+		 * zeroes.
+		 */
+		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
+			memset(kaddr, 0, PAGE_SIZE);
+		kunmap_atomic(kaddr, KM_USER0);
+		flush_dcache_page(dst);
+		return;
+		
+	}
+	copy_user_highpage(dst, src, va);
+}
+
 /*
  * copy one vm_area from one task to the other. Assumes the page tables
  * already present in the new task to be cleared in the whole range
  * covered by this vma.
  */
 
-static inline void
+static inline int
 copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
 		unsigned long addr, int *rss)
@@ -466,6 +497,25 @@ copy_one_pte(struct mm_struct *dst_mm, s
 	 * in the parent and the child
 	 */
 	if (is_cow_mapping(vm_flags)) {
+#ifdef CONFIG_IPIPE
+		if (((vm_flags|src_mm->def_flags) & (VM_LOCKED|VM_NOFAULT)) == (VM_LOCKED|VM_NOFAULT)) {
+			struct page *old_page = vm_normal_page(vma, addr, pte);
+			page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+			if (!page)
+				return -ENOMEM;
+
+			cow_user_page(page, old_page, addr);
+			pte = mk_pte(page, vma->vm_page_prot);
+			
+			if (vm_flags & VM_SHARED)
+				pte = pte_mkclean(pte);
+			pte = pte_mkold(pte);
+
+			page_dup_rmap(page);
+			rss[!!PageAnon(page)]++;
+			goto out_set_pte;
+		}
+#endif /* CONFIG_IPIPE */
 		ptep_set_wrprotect(src_mm, addr, src_pte);
 		pte = pte_wrprotect(pte);
 	}
@@ -487,6 +537,7 @@ copy_one_pte(struct mm_struct *dst_mm, s
 
 out_set_pte:
 	set_pte_at(dst_mm, addr, dst_pte, pte);
+	return 0;
 }
 
 static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -524,7 +575,9 @@ again:
 			progress++;
 			continue;
 		}
-		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vma, addr, rss);
+		if (copy_one_pte(dst_mm, src_mm, dst_pte,
+				 src_pte, vma, addr, rss))
+			return -ENOMEM;
 		progress += 8;
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 
@@ -1431,34 +1484,6 @@ static inline pte_t maybe_mkwrite(pte_t 
 	return pte;
 }
 
-static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va)
-{
-	/*
-	 * If the source page was a PFN mapping, we don't have
-	 * a "struct page" for it. We do a best-effort copy by
-	 * just copying from the original user address. If that
-	 * fails, we just zero-fill it. Live with it.
-	 */
-	if (unlikely(!src)) {
-		void *kaddr = kmap_atomic(dst, KM_USER0);
-		void __user *uaddr = (void __user *)(va & PAGE_MASK);
-
-		/*
-		 * This really shouldn't fail, because the page is there
-		 * in the page tables. But it might just be unreadable,
-		 * in which case we just give up and fill the result with
-		 * zeroes.
-		 */
-		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
-			memset(kaddr, 0, PAGE_SIZE);
-		kunmap_atomic(kaddr, KM_USER0);
-		flush_dcache_page(dst);
-		return;
-		
-	}
-	copy_user_highpage(dst, src, va);
-}
-
 /*
  * This routine handles present pages, when users try to write
  * to a shared page. It is done by copying the page to a new address
@@ -2676,3 +2701,163 @@ int access_process_vm(struct task_struct
 
 	return buf - old_buf;
 }
+
+#ifdef CONFIG_IPIPE
+static LIST_HEAD(nofault_mms);
+static DEFINE_RWLOCK(nofault_mms_lock);
+
+static int ipipe_fault_pte_range(struct mm_struct *mm, pmd_t *pmd,
+				 struct vm_area_struct *vma,
+				 unsigned long addr, unsigned long end)
+{
+	int progress = 0;
+	spinlock_t *ptl;
+	pte_t *pte;
+	
+  again:
+	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	do {
+		if (progress >= 32) {
+			progress = 0;
+			if (need_resched() ||
+			    need_lockbreak(ptl))
+				break;
+		}
+
+		if (do_wp_page(mm, vma, addr, pte, pmd, ptl, *pte) == VM_FAULT_OOM)
+			return -ENOMEM;
+
+	} while (pte++, addr += PAGE_SIZE, addr != end);
+	pte_unmap_unlock(pte - 1, ptl);
+	cond_resched();
+	if (addr != end)
+		goto again;
+	return 0;
+}
+
+static int ipipe_fault_pmd_range(struct mm_struct *mm, pud_t *pud,
+				 struct vm_area_struct *vma,
+				 unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	pmd_t *pmd;
+
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (ipipe_fault_pte_range(mm, pmd, vma, addr, end))
+			return -ENOMEM;
+	} while (pmd++, addr = next, addr != end);
+	return 0;
+}
+
+static int ipipe_fault_pud_range(struct mm_struct *mm, pgd_t *pgd,
+				 struct vm_area_struct *vma,
+				 unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	pud_t *pud;
+
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (ipipe_fault_pmd_range(mm, pud, vma, addr, end))
+			return -ENOMEM;
+	} while (pud++, addr = next, addr != end);
+	return 0;
+}
+
+int ipipe_disable_task_faults(struct task_struct *tsk)
+{
+	unsigned long addr, next, end;
+	struct vm_area_struct *vma;
+	struct vm_struct *area;
+	struct mm_struct *mm;
+	int result = 0;
+	pgd_t *pgd;
+	
+	mm = get_task_mm(tsk);
+	if (!mm)
+		return -EPERM;
+
+	down_write(&mm->mmap_sem);
+	if (mm->def_flags & VM_NOFAULT)
+		goto up_mmap_sem_done;
+	
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		if (!is_cow_mapping(vma->vm_flags))
+			continue;
+
+		addr = vma->vm_start;
+		end = vma->vm_end;
+		
+		pgd = pgd_offset(mm, addr);
+		do {
+			next = pgd_addr_end(addr, end);
+			if (ipipe_fault_pud_range(mm, pgd, vma, addr, next)) {
+				result = -ENOMEM;
+			  up_mmap_sem_done:
+				up_write(&mm->mmap_sem);
+				goto done_mm;
+			}
+		} while (pgd++, addr = next, addr != end);
+	}
+	mm->def_flags |= VM_NOFAULT;
+	up_write(&mm->mmap_sem);
+
+	read_lock(&vmlist_lock);
+	down_write(&mm->mmap_sem);
+	for (area = vmlist; area; area = area->next) {
+		result = ipipe_arch_map_vm_area_to_mm(mm,
+						      (unsigned long) area->addr,
+						      (unsigned long) area->addr
+						      + area->size);
+		if (result) {
+			mm->def_flags &= ~VM_NOFAULT;
+			up_write(&mm->mmap_sem);
+			goto done_vmlist;
+		}
+	}
+	up_write(&mm->mmap_sem);
+
+	write_lock(&nofault_mms_lock);
+	list_add(&mm->nofault, &nofault_mms);
+	write_unlock(&nofault_mms_lock);
+
+  done_vmlist:
+	read_unlock(&vmlist_lock);
+  done_mm:
+	mmput(mm);
+	return result;
+}
+
+EXPORT_SYMBOL(ipipe_disable_task_faults);
+
+int ipipe_update_nofault_mms(unsigned long start, unsigned long end)
+{
+	struct mm_struct *mm;
+	int result = 0;
+
+	read_lock(&nofault_mms_lock);
+	list_for_each_entry(mm, &nofault_mms, nofault) {
+		down_write(&mm->mmap_sem);
+		result = ipipe_arch_map_vm_area_to_mm(mm, start, end);
+		up_write(&mm->mmap_sem);
+
+		if (result)
+			break;
+	}
+	read_unlock(&nofault_mms_lock);
+
+	return result;
+}
+
+void ipipe_destroy_nofault_mm(struct mm_struct *mm)
+{
+	if (mm->def_flags & VM_NOFAULT) {
+		write_lock(&nofault_mms_lock);
+		list_del(&mm->nofault);
+		write_unlock(&nofault_mms_lock);
+	}
+}
+#endif
diff -Naurdp -x '*~' ipipe-2.6.19/mm/vmalloc.c ipipe-2.6.19-nocow/mm/vmalloc.c
--- ipipe-2.6.19/mm/vmalloc.c	2007-01-10 11:22:05.000000000 +0100
+++ ipipe-2.6.19-nocow/mm/vmalloc.c	2007-01-10 17:09:46.000000000 +0100
@@ -152,15 +152,14 @@ int map_vm_area(struct vm_struct *area, 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset_k(addr);
 	do {
-		pgd_t oldpgd;
-		memcpy(&oldpgd,pgd,sizeof(pgd_t));
 		next = pgd_addr_end(addr, end);
 		err = vmap_pud_range(pgd, addr, next, prot, pages);
 		if (err)
 			break;
-		if (pgd_val(oldpgd) != pgd_val(*pgd))
-			set_pgdir(addr, *pgd);
 	} while (pgd++, addr = next, addr != end);
+#ifdef CONFIG_IPIPE
+	ipipe_update_nofault_mms((unsigned long) area->addr, end);
+#endif /* CONFIG_IPIPE */
 	flush_cache_vmap((unsigned long) area->addr, end);
 	return err;
 }

--------------000509030301090208040504--

