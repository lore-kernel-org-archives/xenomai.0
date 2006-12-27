Message-ID: <45923BEE.6020302@domain.hid>
Date: Wed, 27 Dec 2006 10:25:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1166786437.4960.180.camel@domain.hid> <458BB057.9090009@domain.hid>
	<458ACFDA.8070300@domain.hid>	
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
In-Reply-To: <28348634.1166787644219.JavaMail.ngmail@domain.hid>
Content-Type: multipart/mixed; boundary="------------070903000003020503080603"
Subject: [Xenomai-help] Re: A fairly small rtnet/Xenomai...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070903000003020503080603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

M. Koehrer wrote:
> Hi Philippe, 
> 
> I agree. To fix the root cause is actually the very best to do!
> This eases the life of users and developers.
> 
> Regards
> 
> Mathias

Hi Mathias,

here comes a workaround for the COW issue on Linux 2.6.19. The patch
relies on a new VM_NOCOW flag which should be set for real-time
application if you use Xenomai trunk.

It would be nice if you could test it.

Thanks in advance.

-- 
                                                 Gilles Chanteperdrix


--------------070903000003020503080603
Content-Type: text/x-patch;
 name="vm-nocow-2.6.19.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-nocow-2.6.19.patch"

diff -x '*~' -Naurdp linux-2.6.19/include/linux/mm.h linux-2.6.19-nocow/include/linux/mm.h
--- linux-2.6.19/include/linux/mm.h	2006-11-30 11:04:08.000000000 +0100
+++ linux-2.6.19-nocow/include/linux/mm.h	2006-12-27 10:03:09.000000000 +0100
@@ -166,6 +166,7 @@ extern unsigned int kobjsize(const void 
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
 #define VM_INSERTPAGE	0x02000000	/* The vma has had "vm_insert_page()" done on it */
+#define VM_NOCOW	0x10000000	/* Disable COW mapping for the vma */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
diff -x '*~' -Naurdp linux-2.6.19/mm/memory.c linux-2.6.19-nocow/mm/memory.c
--- linux-2.6.19/mm/memory.c	2006-11-30 11:04:14.000000000 +0100
+++ linux-2.6.19-nocow/mm/memory.c	2006-12-27 10:06:37.000000000 +0100
@@ -418,13 +418,41 @@ struct page *vm_normal_page(struct vm_ar
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
@@ -466,6 +494,25 @@ copy_one_pte(struct mm_struct *dst_mm, s
 	 * in the parent and the child
 	 */
 	if (is_cow_mapping(vm_flags)) {
+#ifdef CONFIG_IPIPE
+		if (((vm_flags|src_mm->def_flags) & (VM_LOCKED|VM_NOCOW)) == (VM_LOCKED|VM_NOCOW)) {
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
@@ -487,6 +534,7 @@ copy_one_pte(struct mm_struct *dst_mm, s
 
 out_set_pte:
 	set_pte_at(dst_mm, addr, dst_pte, pte);
+	return 0;
 }
 
 static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -524,7 +572,9 @@ again:
 			progress++;
 			continue;
 		}
-		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vma, addr, rss);
+		if (copy_one_pte(dst_mm, src_mm, dst_pte,
+				 src_pte, vma, addr, rss))
+			return -ENOMEM;
 		progress += 8;
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 
@@ -1431,34 +1481,6 @@ static inline pte_t maybe_mkwrite(pte_t 
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

--------------070903000003020503080603--

