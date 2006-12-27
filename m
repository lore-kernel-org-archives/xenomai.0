From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45923BEE.6020302@domain.hid>
References: <1166786437.4960.180.camel@domain.hid>
	<458BB057.9090009@domain.hid> <458ACFDA.8070300@domain.hid>
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>
	<1166710393.4960.13.camel@domain.hid>
	<12420573.1166713240349.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210717u4b8f0505m65d01bc2824a144a@domain.hid>
	<8403506.1166715370788.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210743m2b208cb2w6e9054336fd68028@domain.hid>
	<9212697.1166778373331.JavaMail.ngmail@domain.hid>
	<458BA432.2000205@domain.hid>
	<b647ffbd0612220140m504db8e4x52ca45477e425d44@domain.hid>
	<9386881.1166783234553.JavaMail.ngmail@domain.hid>
	<28348634.1166787644219.JavaMail.ngmail@domain.hid>
	<45923BEE.6020302@domain.hid>
Content-Type: text/plain
Date: Wed, 27 Dec 2006 18:32:05 +0100
Message-Id: <1167240725.32420.37.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] COW-disable patch
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Wed, 2006-12-27 at 10:25 +0100, Gilles Chanteperdrix wrote:
> M. Koehrer wrote:
> > Hi Philippe, 
> > 
> > I agree. To fix the root cause is actually the very best to do!
> > This eases the life of users and developers.
> > 
> > Regards
> > 
> > Mathias
> 
> Hi Mathias,
> 
> here comes a workaround for the COW issue on Linux 2.6.19. The patch
> relies on a new VM_NOCOW flag which should be set for real-time
> application if you use Xenomai trunk.
> 
> It would be nice if you could test it.
> 

Here is the same patch backported to 2.6.14 for the ppc people who
experienced the same kind of issues. When enabling the nucleus debug
option (full, with queue checks), no more warning should appear in the
kernel log about threads being switched to secondary mode while the
latency test runs. The last patch is to be applied against a Xenomai
2.3.x tree to activate the feature. Feedback highly recommended if you
want this patch to be merged in. TIA,

--- 2.6.14/include/linux/mm.h	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.14-ipipe/include/linux/mm.h	2006-12-26 19:38:10.000000000 +0100
@@ -162,6 +162,7 @@
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
+#define VM_NOCOW	0x10000000	/* Disable COW mapping for the vma */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
--- 2.6.14/mm/memory.c	2006-12-26 19:46:40.000000000 +0100
+++ 2.6.14-ipipe/mm/memory.c	2006-12-26 19:46:54.000000000 +0100
@@ -341,10 +341,10 @@
  * but may be dropped within p[mg]d_alloc() and pte_alloc_map().
  */
 
-static inline void
+static inline int
 copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-		pte_t *dst_pte, pte_t *src_pte, unsigned long vm_flags,
-		unsigned long addr)
+	     pte_t *dst_pte, pte_t *src_pte, unsigned long vm_flags,
+	     unsigned long addr, struct vm_area_struct *vma)
 {
 	pte_t pte = *src_pte;
 	struct page *page;
@@ -362,7 +362,7 @@
 			}
 		}
 		set_pte_at(dst_mm, addr, dst_pte, pte);
-		return;
+		return 0;
 	}
 
 	pfn = pte_pfn(pte);
@@ -377,7 +377,7 @@
 
 	if (!page || PageReserved(page)) {
 		set_pte_at(dst_mm, addr, dst_pte, pte);
-		return;
+		return 0;
 	}
 
 	/*
@@ -385,6 +385,27 @@
 	 * in the parent and the child
 	 */
 	if ((vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE) {
+#ifdef CONFIG_IPIPE
+		if (((vm_flags|src_mm->def_flags) & (VM_NOCOW|VM_LOCKED)) == (VM_NOCOW|VM_LOCKED)) {
+			struct page *old_page = page;
+			page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
+			if (!page)
+				return -ENOMEM;
+
+			copy_user_highpage(page, old_page, addr);
+			pte = mk_pte(page, vma->vm_page_prot);
+
+			if (vm_flags & VM_SHARED)
+			    pte = pte_mkclean(pte);
+			pte = pte_mkold(pte);
+			inc_mm_counter(dst_mm, rss);
+			if (PageAnon(page))
+				inc_mm_counter(dst_mm, anon_rss);
+			set_pte_at(dst_mm, addr, dst_pte, pte);
+			page_dup_rmap(page);
+			return 0;
+		}
+#endif /* CONFIG_IPIPE */
 		ptep_set_wrprotect(src_mm, addr, src_pte);
 		pte = *src_pte;
 	}
@@ -402,6 +423,8 @@
 		inc_mm_counter(dst_mm, anon_rss);
 	set_pte_at(dst_mm, addr, dst_pte, pte);
 	page_dup_rmap(page);
+
+	return 0;
 }
 
 static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -433,7 +456,8 @@
 			progress++;
 			continue;
 		}
-		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vm_flags, addr);
+		if (copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vm_flags, addr, vma))
+			return -ENOMEM;
 		progress += 8;
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 	spin_unlock(&src_mm->page_table_lock);

--- ksrc/nucleus/shadow.c.orig  2006-12-27 11:42:50.000000000 +0100
+++ ksrc/nucleus/shadow.c       2006-12-27 11:42:55.000000000 +0100
@@ -839,6 +839,8 @@
 #ifdef CONFIG_MMU
        if (!(current->mm->def_flags & VM_LOCKED))
                send_sig(SIGXCPU, current, 1);
+       else
+           current->mm->def_flags |= VM_NOCOW;
 #endif /* CONFIG_MMU */
 
        current->cap_effective |=

-- 
Philippe.



