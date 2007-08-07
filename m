From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <2ff1a98a0708070809h2ac1a0b7q2178297d5a824bb9@domain.hid>
References: <46B86E53.1030803@domain.hid> <46B86FE4.3040209@domain.hid>
	<46B87B85.1080304@domain.hid>
	<2ff1a98a0708070711n5e97ca03y18aef78ececc7e0d@domain.hid>
	<46B87F93.9020308@domain.hid>
	<2ff1a98a0708070724j5afecf20q22994d053553ed57@domain.hid>
	<46B885E3.6060605@domain.hid>
	<2ff1a98a0708070756q60794718wb1bc55675ea05ba4@domain.hid>
	<46B888B4.2070301@domain.hid>
	<2ff1a98a0708070809h2ac1a0b7q2178297d5a824bb9@domain.hid>
Content-Type: multipart/mixed; boundary="=-TUkkNUnzeerP1j+z5mZD"
Date: Tue, 07 Aug 2007 18:55:23 +0200
Message-Id: <1186505723.5408.8.camel@domain.hid>
Mime-Version: 1.0
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] [COW-BUG] __alloc_pages called from
	atomic context
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>


--=-TUkkNUnzeerP1j+z5mZD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-08-07 at 17:09 +0200, Gilles Chanteperdrix wrote:
> On 8/7/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> > Gilles Chanteperdrix wrote:
> > > The fact that you are in a hurry should not be an excuse to propose a
> > > fix which is much worse than the bug itself.
> >
> > Please explain.
> 
> Using GFP_ATOMIC is not a good idea, because the kernel needs the
> GFP_ATOMIC pools for allocation that take place from really atomic
> contexts such as interruption handlers for instance. fork should not
> be an atomic context.
> 
> So the only reason I see why you propose this patch is because you are
> in a hurry. Ok, before we fix this properly, you can use GFP_ATOMIC
> locally, but please do not make
> this an official patch.
> 

I'm afraid you are both right. Draining pages from the atomic pool might
starve truely atomic contexts, and releasing the lock guarding the
pagetable pages for the source mm seems contradictory with what the
current code tries to achieve in holding it.

Here is a patch preallocating the page for the cow-breaking code, which
relies on the lock breaking pattern already in place. Not exactly
pretty, slightly tested here (UP, spinlock debug), but looks ok so far.
Needs SMP testing before any attempt is made to merge it.

-- 
Philippe.


--=-TUkkNUnzeerP1j+z5mZD
Content-Disposition: attachment; filename=breaking-cow-might-sleep.patch
Content-Type: text/x-patch; name=breaking-cow-might-sleep.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- 2.6.23-rc2/mm/memory.c	2007-08-05 17:51:09.000000000 +0200
+++ 2.6.23-rc2-x86/mm/memory.c	2007-08-07 18:44:19.000000000 +0200
@@ -453,8 +453,8 @@
 
 static inline int
 copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
-		unsigned long addr, int *rss)
+	     pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
+	     unsigned long addr, int *rss, struct page *uncow_page)
 {
 	unsigned long vm_flags = vma->vm_flags;
 	pte_t pte = *src_pte;
@@ -494,21 +494,17 @@
 	 */
 	if (is_cow_mapping(vm_flags)) {
 #ifdef CONFIG_IPIPE
-		if (((vm_flags|src_mm->def_flags) & (VM_LOCKED|VM_PINNED)) == (VM_LOCKED|VM_PINNED)) {
+		if (uncow_page) {
 			struct page *old_page = vm_normal_page(vma, addr, pte);
-			page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
-			if (!page)
-				return -ENOMEM;
-
-			cow_user_page(page, old_page, addr, vma);
-			pte = mk_pte(page, vma->vm_page_prot);
+			cow_user_page(uncow_page, old_page, addr, vma);
+			pte = mk_pte(uncow_page, vma->vm_page_prot);
 			
 			if (vm_flags & VM_SHARED)
 				pte = pte_mkclean(pte);
 			pte = pte_mkold(pte);
 
-			page_dup_rmap(page, vma, addr);
-			rss[!!PageAnon(page)]++;
+			page_dup_rmap(uncow_page, vma, addr);
+			rss[!!PageAnon(uncow_page)]++;
 			goto out_set_pte;
 		}
 #endif /* CONFIG_IPIPE */
@@ -542,14 +538,26 @@
 {
 	pte_t *src_pte, *dst_pte;
 	spinlock_t *src_ptl, *dst_ptl;
-	int progress = 0;
+	int progress = 0, do_cow_break = 0;
+	struct page *uncow_page = NULL;
 	int rss[2];
 
 again:
+#ifdef CONFIG_IPIPE
+	if (do_cow_break) {
+		uncow_page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+		if (!uncow_page)
+			return -ENOMEM;
+		do_cow_break = 0;
+	}
+#endif
 	rss[1] = rss[0] = 0;
 	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
-	if (!dst_pte)
+	if (!dst_pte) {
+		if (uncow_page)
+			page_cache_release(uncow_page);
 		return -ENOMEM;
+	}
 	src_pte = pte_offset_map_nested(src_pmd, addr);
 	src_ptl = pte_lockptr(src_mm, src_pmd);
 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
@@ -571,9 +579,21 @@
 			progress++;
 			continue;
 		}
+#ifdef CONFIG_IPIPE
+		if (likely(uncow_page == NULL) && likely(pte_present(*src_pte))) {
+			if (is_cow_mapping(vma->vm_flags)) {
+				if (((vma->vm_flags|src_mm->def_flags) & (VM_LOCKED|VM_PINNED))
+				    == (VM_LOCKED|VM_PINNED)) {
+					do_cow_break = 1;
+					break;
+				}
+			}
+		}
+#endif
 		if (copy_one_pte(dst_mm, src_mm, dst_pte,
-				 src_pte, vma, addr, rss))
+				 src_pte, vma, addr, rss, uncow_page))
 			return -ENOMEM;
+		uncow_page = NULL;
 		progress += 8;
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 

--=-TUkkNUnzeerP1j+z5mZD--


