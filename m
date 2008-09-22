Message-ID: <48D80630.4020500@domain.hid>
Date: Mon, 22 Sep 2008 22:55:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <420196.99125.qm@domain.hid>
	<48C3F4F2.5030208@domain.hid>
In-Reply-To: <48C3F4F2.5030208@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RT_HEAP Problem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: yasser_kashfi@domain.hid
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Yasser Kashfi wrote:
>> Hi
>> Thanks Gilles for your notes. The problem is solved.
> 
> Well... not exactly, it shows that the problem is using highmem, but we
> should now modify xenomai so that it supports using highmem.
> 


Hi Yasser,

here is a patch which is supposed to fix this issue with highmem. Could 
you apply it and use the same kernel configuration as you used initially
? 

Thanks in advance.

Index: include/asm-generic/wrappers.h
===================================================================
--- include/asm-generic/wrappers.h	(revision 4175)
+++ include/asm-generic/wrappers.h	(working copy)
@@ -64,12 +64,9 @@
 
 /* VM */
 
-/* We don't support MMU-less architectures over 2.4 */
-unsigned long __va_to_kva(unsigned long va);
-
 #define wrap_remap_vm_page(vma,from,to) ({ \
     vma->vm_flags |= VM_RESERVED; \
-    remap_page_range(from,virt_to_phys((void *)__va_to_kva(to)),PAGE_SIZE,vma->vm_page_prot); \
+    remap_page_range(from,page_to_phys(vmalloc_to_page((void *)to)),PAGE_SIZE,vma->vm_page_prot); \
 })
 #define wrap_remap_io_page_range(vma,from,to,size,prot) ({ \
     vma->vm_flags |= VM_RESERVED; \
@@ -344,10 +341,7 @@ unsigned long find_next_bit(const unsign
 
 /* VM */
 
-#ifdef CONFIG_MMU
-unsigned long __va_to_kva(unsigned long va);
-#else /* !CONFIG_MMU */
-#define __va_to_kva(va) (va)
+#ifndef CONFIG_MMU
 #define pgprot_noncached(p) (p)
 #endif /* CONFIG_MMU */
 
@@ -372,7 +366,7 @@ unsigned long __va_to_kva(unsigned long 
  * memory. Anyway, this legacy would only hit setups using pre-2.6.11
  * kernel revisions. */
 #define wrap_remap_vm_page(vma,from,to) \
-    remap_pfn_range(vma,from,virt_to_phys((void *)__va_to_kva(to)) >> PAGE_SHIFT,PAGE_SHIFT,vma->vm_page_prot)
+    remap_pfn_range(vma,from,page_to_pfn(vmalloc_to_page((void *)to)),PAGE_SHIFT,vma->vm_page_prot)
 #define wrap_remap_io_page_range(vma,from,to,size,prot)  ({		\
     (vma)->vm_page_prot = pgprot_noncached((vma)->vm_page_prot);	\
     /* Sets VM_RESERVED | VM_IO | VM_PFNMAP on the vma. */		\
@@ -385,7 +379,7 @@ unsigned long __va_to_kva(unsigned long 
 #else /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10) */
 #define wrap_remap_vm_page(vma,from,to) ({ \
     vma->vm_flags |= VM_RESERVED; \
-    remap_page_range(from,virt_to_phys((void *)__va_to_kva(to)),PAGE_SIZE,vma->vm_page_prot); \
+    remap_page_range(from,page_to_phys(vmalloc_to_page((void *)to)),PAGE_SIZE,vma->vm_page_prot); \
 })
 #define wrap_remap_io_page_range(vma,from,to,size,prot) ({	\
       vma->vm_flags |= VM_RESERVED;				\
Index: ksrc/nucleus/heap.c
===================================================================
--- ksrc/nucleus/heap.c	(revision 4175)
+++ ksrc/nucleus/heap.c	(working copy)
@@ -1010,44 +1010,6 @@ static int xnheap_ioctl(struct inode *in
 	return err;
 }
 
-#ifdef CONFIG_MMU
-
-unsigned long __va_to_kva(unsigned long va)
-{
-	pgd_t *pgd;
-	pmd_t *pmd;
-	pte_t *ptep, pte;
-	unsigned long kva = 0;
-
-	pgd = pgd_offset_k(va);	/* Page directory in kernel map. */
-
-	if (!pgd_none(*pgd) && !pgd_bad(*pgd)) {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 11)
-		/* Page middle directory -- account for PAE. */
-		pmd = pmd_offset(pud_offset(pgd, va), va);
-#else
-		/* Page middle directory. */
-		pmd = pmd_offset(pgd, va);
-#endif
-
-		if (!pmd_none(*pmd)) {
-			ptep = pte_offset_kernel(pmd, va);	/* Page table entry. */
-			pte = *ptep;
-
-			if (pte_present(pte)) {	/* Valid? */
-				kva = (unsigned long)page_address(pte_page(pte));	/* Page address. */
-				kva |= (va & (PAGE_SIZE - 1));	/* Add offset within page. */
-			}
-		}
-	}
-
-	return kva;
-}
-
-EXPORT_SYMBOL(__va_to_kva);
-
-#endif /* CONFIG_MMU */
-
 static int xnheap_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	unsigned long offset, size, vaddr;
@@ -1175,7 +1137,7 @@ static inline void *__alloc_and_reserve_
 		vabase = (unsigned long)ptr;
 
 		for (vaddr = vabase; vaddr < vabase + size; vaddr += PAGE_SIZE)
-			SetPageReserved(virt_to_page(__va_to_kva(vaddr)));
+			SetPageReserved(vmalloc_to_page((void *)vaddr));
 	} else {
 		/*
 		 * Otherwise, we have been asked for some kmalloc()
@@ -1211,7 +1173,7 @@ static inline void __unreserve_and_free_
 
 	if (!kmflags  || kmflags == XNHEAP_GFP_NONCACHED) {
 		for (vaddr = vabase; vaddr < vabase + size; vaddr += PAGE_SIZE)
-			ClearPageReserved(virt_to_page(__va_to_kva(vaddr)));
+			ClearPageReserved(vmalloc_to_page((void *)vaddr));
 
 		vfree(ptr);
 	} else {


-- 
					    Gilles.

