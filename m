Message-ID: <45AB5BE6.8070309@domain.hid>
Date: Mon, 15 Jan 2007 11:48:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Nocow patch.
References: <45A52B04.1010706@domain.hid> <45A6554D.2060900@domain.hid>
	<1168714673.21854.17.camel@domain.hid>
In-Reply-To: <1168714673.21854.17.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------080308020509030701000001"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------080308020509030701000001
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> On Thu, 2007-01-11 at 16:18 +0100, Gilles Chanteperdrix wrote:
> 
>>Gilles Chanteperdrix wrote:
>>
>>>This was run on x86, but need further testing before inclusion.
>>
>>Here is a new version, after testing. It appears to run fine. I tested
>>forking in real-time applications both before and after calling
>>rt_task_shadow, and vmallocing areas of 256 Mo, and memseting them both
>>from a non-realtime or real-time context and it works.
>>
>>The next step is to clean up the patch, but I have to admit that I need
>>some help: should I keep the functions in the files where I put them ?
>>in what headers should I declare them ? Should I define an empty
>>ipipe_update_nofault_mms when CONFIG_IPIPE is not set in order to avoid
>>a few #ifdefs ?
> 
> 
>>diff -Naurdp -x '*~' ipipe-2.6.19/arch/i386/mm/fault.c ipipe-2.6.19-nocow/arch/i386/mm/fault.c
>>--- ipipe-2.6.19/arch/i386/mm/fault.c	2007-01-10 09:44:52.000000000 +0100
>>+++ ipipe-2.6.19-nocow/arch/i386/mm/fault.c	2007-01-11 09:58:49.000000000 +0100
>>@@ -654,3 +654,19 @@ void vmalloc_sync_all(void)
>> 	}
>> }
>> #endif
>>+
>>+#ifdef CONFIG_IPIPE
>>+int ipipe_arch_map_vm_area_to_mm(struct mm_struct *mm,
>>+				 unsigned long start,
>>+				 unsigned long end)
>>+{
> 
> 
> __ipipe_pin_range_mapping() would better identify an internal routine
> which somehow wires the mapping of a virtual address range into a
> memory context.
> 
> [...]
> 
> 
>>+
>>+#if CONFIG_IPIPE
>>+	struct list_head nofault;
> 
> 
> s,nofault,pinned, ?  The point is that the NOFAULT feature does not
> really disable all faults, but only faults leading to lazy/ondemand
> mappings. E.g. pathological faults would still raise exceptions.
> 
> 
>>+#endif /* CONFIG_IPIPE */
>> };
>> 
>> struct sighand_struct {
>>diff -Naurdp -x '*~' ipipe-2.6.19/kernel/fork.c ipipe-2.6.19-nocow/kernel/fork.c
>>--- ipipe-2.6.19/kernel/fork.c	2007-01-10 09:44:53.000000000 +0100
>>+++ ipipe-2.6.19-nocow/kernel/fork.c	2007-01-11 15:32:25.000000000 +0100
>>@@ -385,6 +385,7 @@ void mmput(struct mm_struct *mm)
>> 
>> 	if (atomic_dec_and_test(&mm->mm_users)) {
>> 		ipipe_cleanup_notify(mm);
>>+		ipipe_destroy_nofault_mm(mm);
> 
> 
> We may want to merge both into the notification trigger. Those
> nitty-gritty I-pipe details ought to be gathered; after all, removing
> the mm from the pinned mm queue is also a cleanup operation. This
> would also remove the need for adding a placeholder in the
> !CONFIG_IPIPE case.
> 
> [...]
> 
> 
>>-
>>+#ifdef CONFIG_IPIPE
>>+	ipipe_update_nofault_mms(start, end);
> 
> 
> I'd suggest something like __ipipe_update_all_pinned_mm().
> 
> [...]
> 
> 
>>+#ifdef CONFIG_IPIPE
>>+#include <linux/vmalloc.h>	/* For vmlist */
>>+#endif /* CONFIG_IPIPE */
> 
> 
> No need for noisy conditional here. Including linux/vmalloc.h has no
> undesirable side-effect in the !CONFIG_IPIPE case anyway.
> 
> [...]
> 
> 
>>+
>>+#ifdef CONFIG_IPIPE
>>+static LIST_HEAD(nofault_mms);
>>+static DEFINE_RWLOCK(nofault_mms_lock);
>>+
>>+static int ipipe_fault_pte_range(struct mm_struct *mm, pmd_t *pmd,
>>+				 struct vm_area_struct *vma,
>>+				 unsigned long addr, unsigned long
> 
> 
> [...]
> 
> 
>>+static int ipipe_fault_pmd_range(struct mm_struct *mm, pud_t *pud,
>>+				 struct vm_area_struct *vma,
>>+				 unsigned long addr, unsigned long end)
> 
> 
> [...]
> 
> 
>>+static int ipipe_fault_pud_range(struct mm_struct *mm, pgd_t *pgd,
>>+				 struct vm_area_struct *vma,
>>+				 unsigned long addr, unsigned long end)
> 
> 
> [...]
> 
> Those routines are good candidates for inlining.
> 
> 
>>+int ipipe_disable_task_faults(struct task_struct *tsk)
>>+{
> 
> 
> ipipe_disable_ondemand_mappings() would be more accurate.
> 
> [...]
> 
> 
>>+#ifdef CONFIG_IPIPE
>>+	ipipe_update_nofault_mms((unsigned long) area->addr, end);
>>+#endif /* CONFIG_IPIPE */
> 
> 
> Better define a nop placeholder for __ipipe_update_all_pinned_mm()
> in the !CONFIG_IPIPE case instead of the conditional.
> 

Here is an updated version, following your advices.

However, after looking at the ARM patch, I am not so sure
__ipipe_update_all_pinned_mm() is the way to go on all architectures.
The ARM I-pipe handles vmalloc and ioremap faults without causing a mode
switch, I wonder if it is not better than having
__ipipe_update_all_pinned_mm() updating page directories all over the
place.

-- 
                                                 Gilles Chanteperdrix

--------------080308020509030701000001
Content-Type: text/x-patch;
 name="vm-nocow-2.6.19.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-nocow-2.6.19.4.patch"

diff -Naurdp -x '*~' ipipe-2.6.19/arch/i386/mm/fault.c ipipe-2.6.19-nocow/arch/i386/mm/fault.c
--- ipipe-2.6.19/arch/i386/mm/fault.c	2007-01-10 09:44:52.000000000 +0100
+++ ipipe-2.6.19-nocow/arch/i386/mm/fault.c	2007-01-15 09:57:02.000000000 +0100
@@ -654,3 +654,18 @@ void vmalloc_sync_all(void)
 	}
 }
 #endif
+
+#ifdef CONFIG_IPIPE
+int __ipipe_pin_range_mapping(struct mm_struct *mm,
+			      unsigned long start, unsigned long end)
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
+++ ipipe-2.6.19-nocow/include/asm-i386/pgalloc.h	2007-01-11 09:58:49.000000000 +0100
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
diff -Naurdp -x '*~' ipipe-2.6.19/include/linux/ipipe.h ipipe-2.6.19-nocow/include/linux/ipipe.h
--- ipipe-2.6.19/include/linux/ipipe.h	2007-01-10 09:44:53.000000000 +0100
+++ ipipe-2.6.19-nocow/include/linux/ipipe.h	2007-01-15 10:52:06.000000000 +0100
@@ -337,6 +337,15 @@ int fastcall __ipipe_dispatch_wired(stru
 
 void fastcall __ipipe_sync_stage(unsigned long syncmask);
 
+int __ipipe_update_all_pinned_mm(unsigned long start, unsigned long end);
+
+struct mm_struct;
+
+void __ipipe_unlink_pinned_mm(struct mm_struct *mm);
+
+int __ipipe_pin_range_mapping(struct mm_struct *mm,
+			      unsigned long start, unsigned long end);
+
 #ifndef __ipipe_sync_pipeline
 #define __ipipe_sync_pipeline(syncmask) __ipipe_sync_stage(syncmask)
 #endif
@@ -434,12 +443,11 @@ static inline void ipipe_init_notify(str
 		__ipipe_dispatch_event(IPIPE_EVENT_INIT,p);
 }
 
-struct mm_struct;
-
 static inline void ipipe_cleanup_notify(struct mm_struct *mm)
 {
 	if (__ipipe_event_monitored_p(IPIPE_EVENT_CLEANUP))
 		__ipipe_dispatch_event(IPIPE_EVENT_CLEANUP,mm);
+	__ipipe_unlink_pinned_mm(mm);
 }
 
 /* Public interface */
@@ -643,6 +651,8 @@ int fastcall ipipe_set_ptd(int key,
 
 void fastcall *ipipe_get_ptd(int key);
 
+int ipipe_disable_ondemand_mappings(struct task_struct *tsk);
+
 #define local_irq_enable_hw_cond()		local_irq_enable_hw()
 #define local_irq_disable_hw_cond()		local_irq_disable_hw()
 #define local_irq_save_hw_cond(flags)	local_irq_save_hw(flags)
@@ -690,6 +700,7 @@ void fastcall *ipipe_get_ptd(int key);
 #define ipipe_cleanup_notify(mm)	do { } while(0)
 #define ipipe_trap_notify(t,r)	0
 #define ipipe_init_proc()		do { } while(0)
+#define __ipipe_update_all_pinned_mm(start, end) 0
 
 #define local_irq_enable_hw_cond()		do { } while(0)
 #define local_irq_disable_hw_cond()		do { } while(0)
diff -Naurdp -x '*~' ipipe-2.6.19/include/linux/mm.h ipipe-2.6.19-nocow/include/linux/mm.h
--- ipipe-2.6.19/include/linux/mm.h	2007-01-04 10:10:33.000000000 +0100
+++ ipipe-2.6.19-nocow/include/linux/mm.h	2007-01-15 10:06:44.000000000 +0100
@@ -166,6 +166,7 @@ extern unsigned int kobjsize(const void 
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
 #define VM_INSERTPAGE	0x02000000	/* The vma has had "vm_insert_page()" done on it */
+#define VM_PINNED	0x10000000	/* Disable faults for the vma */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
diff -Naurdp -x '*~' ipipe-2.6.19/include/linux/sched.h ipipe-2.6.19-nocow/include/linux/sched.h
--- ipipe-2.6.19/include/linux/sched.h	2007-01-10 09:44:53.000000000 +0100
+++ ipipe-2.6.19-nocow/include/linux/sched.h	2007-01-15 10:07:45.000000000 +0100
@@ -363,6 +363,10 @@ struct mm_struct {
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
 	struct kioctx		*ioctx_list;
+
+#if CONFIG_IPIPE
+	struct list_head pinned;
+#endif /* CONFIG_IPIPE */
 };
 
 struct sighand_struct {
diff -Naurdp -x '*~' ipipe-2.6.19/lib/ioremap.c ipipe-2.6.19-nocow/lib/ioremap.c
--- ipipe-2.6.19/lib/ioremap.c	2007-01-10 09:44:53.000000000 +0100
+++ ipipe-2.6.19-nocow/lib/ioremap.c	2007-01-15 11:23:54.000000000 +0100
@@ -85,10 +85,9 @@ int ioremap_page_range(unsigned long add
 		err = ioremap_pud_range(pgd, addr, next, phys_addr+addr, prot);
 		if (err)
 			break;
-		set_pgdir(addr, *pgd);
 	} while (pgd++, addr = next, addr != end);
-
-	flush_cache_vmap(start, end);
+	__ipipe_update_all_pinned_mm(start, end);
+ 	flush_cache_vmap(start, end);
 
 	return err;
 }
diff -Naurdp -x '*~' ipipe-2.6.19/mm/memory.c ipipe-2.6.19-nocow/mm/memory.c
--- ipipe-2.6.19/mm/memory.c	2007-01-04 10:10:35.000000000 +0100
+++ ipipe-2.6.19-nocow/mm/memory.c	2007-01-15 10:58:36.000000000 +0100
@@ -50,6 +50,7 @@
 #include <linux/delayacct.h>
 #include <linux/init.h>
 #include <linux/writeback.h>
+#include <linux/vmalloc.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -418,13 +419,41 @@ struct page *vm_normal_page(struct vm_ar
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
@@ -466,6 +495,25 @@ copy_one_pte(struct mm_struct *dst_mm, s
 	 * in the parent and the child
 	 */
 	if (is_cow_mapping(vm_flags)) {
+#ifdef CONFIG_IPIPE
+		if (((vm_flags|src_mm->def_flags) & (VM_LOCKED|VM_PINNED)) == (VM_LOCKED|VM_PINNED)) {
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
@@ -487,6 +535,7 @@ copy_one_pte(struct mm_struct *dst_mm, s
 
 out_set_pte:
 	set_pte_at(dst_mm, addr, dst_pte, pte);
+	return 0;
 }
 
 static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -524,7 +573,9 @@ again:
 			progress++;
 			continue;
 		}
-		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vma, addr, rss);
+		if (copy_one_pte(dst_mm, src_mm, dst_pte,
+				 src_pte, vma, addr, rss))
+			return -ENOMEM;
 		progress += 8;
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 
@@ -1431,34 +1482,6 @@ static inline pte_t maybe_mkwrite(pte_t 
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
@@ -2676,3 +2699,150 @@ int access_process_vm(struct task_struct
 
 	return buf - old_buf;
 }
+
+#ifdef CONFIG_IPIPE
+static LIST_HEAD(pinned_mms);
+static DEFINE_RWLOCK(pinned_mms_lock);
+
+static inline int ipipe_pin_pte_range(struct mm_struct *mm, pmd_t *pmd,
+				      struct vm_area_struct *vma,
+				      unsigned long addr, unsigned long end)
+{
+	spinlock_t *ptl;
+	pte_t *pte;
+	
+	do {
+		pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+
+		if (do_wp_page(mm, vma, addr, pte, pmd, ptl, *pte) == VM_FAULT_OOM)
+			return -ENOMEM;
+	} while (addr += PAGE_SIZE, addr != end);
+	return 0;
+}
+
+static inline int ipipe_pin_pmd_range(struct mm_struct *mm, pud_t *pud,
+				      struct vm_area_struct *vma,
+				      unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	pmd_t *pmd;
+
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (ipipe_pin_pte_range(mm, pmd, vma, addr, end))
+			return -ENOMEM;
+	} while (pmd++, addr = next, addr != end);
+	return 0;
+}
+
+static inline int ipipe_pin_pud_range(struct mm_struct *mm, pgd_t *pgd,
+				      struct vm_area_struct *vma,
+				      unsigned long addr, unsigned long end)
+{
+	unsigned long next;
+	pud_t *pud;
+
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (ipipe_pin_pmd_range(mm, pud, vma, addr, end))
+			return -ENOMEM;
+	} while (pud++, addr = next, addr != end);
+	return 0;
+}
+
+int ipipe_disable_ondemand_mappings(struct task_struct *tsk)
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
+	if (mm->def_flags & VM_PINNED)
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
+			if (ipipe_pin_pud_range(mm, pgd, vma, addr, next)) {
+				result = -ENOMEM;
+			  up_mmap_sem_done:
+				up_write(&mm->mmap_sem);
+				goto done_mm;
+			}
+		} while (pgd++, addr = next, addr != end);
+	}
+	mm->def_flags |= VM_PINNED;
+	up_write(&mm->mmap_sem);
+
+	read_lock(&vmlist_lock);
+	down_write(&mm->mmap_sem);
+	for (area = vmlist; area; area = area->next) {
+		result =  __ipipe_pin_range_mapping(mm,
+						    (unsigned long) area->addr,
+						    (unsigned long) area->addr
+						    + area->size);
+		if (result) {
+			mm->def_flags &= ~VM_PINNED;
+			up_write(&mm->mmap_sem);
+			goto done_vmlist;
+		}
+	}
+	up_write(&mm->mmap_sem);
+
+	write_lock(&pinned_mms_lock);
+	list_add(&mm->pinned, &pinned_mms);
+	write_unlock(&pinned_mms_lock);
+
+  done_vmlist:
+	read_unlock(&vmlist_lock);	
+  done_mm:
+	mmput(mm);
+	return result;
+}
+
+EXPORT_SYMBOL(ipipe_disable_ondemand_mappings);
+
+int __ipipe_update_all_pinned_mm(unsigned long start, unsigned long end)
+{
+	struct mm_struct *mm;
+	int result = 0;
+
+	read_lock(&pinned_mms_lock);
+	list_for_each_entry(mm, &pinned_mms, pinned) {
+		down_write(&mm->mmap_sem);
+		result = __ipipe_pin_range_mapping(mm, start, end);
+		up_write(&mm->mmap_sem);
+
+		if (result)
+			break;
+	}
+	read_unlock(&pinned_mms_lock);
+
+	return result;
+}
+
+void __ipipe_unlink_pinned_mm(struct mm_struct *mm)
+{
+	if (mm->def_flags & VM_PINNED) {
+		write_lock(&pinned_mms_lock);
+		list_del(&mm->pinned);
+		write_unlock(&pinned_mms_lock);
+	}
+}
+#endif
diff -Naurdp -x '*~' ipipe-2.6.19/mm/mlock.c ipipe-2.6.19-nocow/mm/mlock.c
--- ipipe-2.6.19/mm/mlock.c	2007-01-02 10:59:48.000000000 +0100
+++ ipipe-2.6.19-nocow/mm/mlock.c	2007-01-11 15:32:09.000000000 +0100
@@ -166,7 +166,7 @@ static int do_mlockall(int flags)
 
 	if (flags & MCL_FUTURE)
 		def_flags = VM_LOCKED;
-	current->mm->def_flags = def_flags;
+	current->mm->def_flags |= def_flags;
 	if (flags == MCL_FUTURE)
 		goto out;
 
diff -Naurdp -x '*~' ipipe-2.6.19/mm/vmalloc.c ipipe-2.6.19-nocow/mm/vmalloc.c
--- ipipe-2.6.19/mm/vmalloc.c	2007-01-10 11:22:05.000000000 +0100
+++ ipipe-2.6.19-nocow/mm/vmalloc.c	2007-01-15 10:05:57.000000000 +0100
@@ -152,15 +152,12 @@ int map_vm_area(struct vm_struct *area, 
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
+	__ipipe_update_all_pinned_mm((unsigned long) area->addr, end);
 	flush_cache_vmap((unsigned long) area->addr, end);
 	return err;
 }

--------------080308020509030701000001--

