Message-ID: <50EB1071.60803@siemens.com>
Date: Mon, 07 Jan 2013 19:14:09 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <50EB104F.6090703@siemens.com>
In-Reply-To: <50EB104F.6090703@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH 2/2] ipipe: Fault in locked vmas after changing
 the protection flags
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

__ipipe_pin_vma now practically removes the risk that vmas using COW are
not fully populated before we patch the protection flags, thus can take
faults later on and use that patched value on the zero page. Still, it
turned out to be safer and simpler to fault in the pages after the
protection change without touching the protection flags.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 mm/mprotect.c |   36 +++++++-----------------------------
 1 files changed, 7 insertions(+), 29 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 195b91e..057b1d8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -147,7 +147,6 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long oldflags = vma->vm_flags;
-	unsigned long protflags;
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned long charged = 0;
 	pgoff_t pgoff;
@@ -206,17 +205,8 @@ success:
 	 * held in write mode.
 	 */
 	vma->vm_flags = newflags;
-	protflags = newflags;
-#ifdef CONFIG_IPIPE
-	/*
-	 * Enforce non-COW vm_page_prot by faking VM_SHARED on locked regions.
-	 */
-	if (test_bit(MMF_VM_PINNED, &mm->flags) &&
-	    ((vma->vm_flags | mm->def_flags) & VM_LOCKED))
-		protflags |= VM_SHARED;
-#endif
 	vma->vm_page_prot = pgprot_modify(vma->vm_page_prot,
-					  vm_get_page_prot(protflags));
+					  vm_get_page_prot(newflags));
 
 	if (vma_wants_writenotify(vma)) {
 		vma->vm_page_prot = vm_get_page_prot(newflags & ~VM_SHARED);
@@ -224,28 +214,16 @@ success:
 	}
 
 	mmu_notifier_invalidate_range_start(mm, start, end);
-#ifdef CONFIG_IPIPE
-	/*
-	 * Privatize potential COW pages
-	 */
-	if (test_bit(MMF_VM_PINNED, &mm->flags) &&
-	    (((vma->vm_flags | mm->def_flags) & (VM_LOCKED | VM_WRITE)) ==
-	     (VM_LOCKED | VM_WRITE))) {
-		error = __ipipe_pin_vma(mm, vma);
-		if (error)
-			/*
-			 * OOM. Just revert the fake VM_SHARED so that the
-			 * zero page cannot be overwritten.
-			 */
-			vma->vm_page_prot =
-				pgprot_modify(vma->vm_page_prot,
-					      vm_get_page_prot(newflags));
-	}
-#endif
 	if (is_vm_hugetlb_page(vma))
 		hugetlb_change_protection(vma, start, end, vma->vm_page_prot);
 	else
 		change_protection(vma, start, end, vma->vm_page_prot, dirty_accountable);
+#ifdef CONFIG_IPIPE
+	if (test_bit(MMF_VM_PINNED, &mm->flags) &&
+	    ((vma->vm_flags | mm->def_flags) & VM_LOCKED) &&
+	    (vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC)))
+		__ipipe_pin_vma(mm, vma);
+#endif
 	mmu_notifier_invalidate_range_end(mm, start, end);
 	vm_stat_account(mm, oldflags, vma->vm_file, -nrpages);
 	vm_stat_account(mm, newflags, vma->vm_file, nrpages);
-- 
1.7.3.4

