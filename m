Message-ID: <50EB104F.6090703@siemens.com>
Date: Mon, 07 Jan 2013 19:13:35 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH 1/2] ipipe: Rework and simplify __ipipe_pin_vma
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Implements __ipipe_pin_vma after mlock_vma_pages_range, just properly
returning errors so that __ipipe_disable_ondemand_mappings can evaluate
them. This not only simplifies the code, it also ensures that we fault
in pages under not yet existing page directory nodes. That is important
when performing access-enabling mprotect on a locked memory region of a
real-time process.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 mm/memory.c |   79 -----------------------------------------------------------
 mm/mlock.c  |   18 +++++++++++++
 2 files changed, 18 insertions(+), 79 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ab93d65..4230192 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4075,85 +4075,6 @@ void copy_user_huge_page(struct page *dst, struct page *src,
 
 #ifdef CONFIG_IPIPE
 
-static inline int ipipe_pin_pte_range(struct mm_struct *mm, pmd_t *pmd,
-				      struct vm_area_struct *vma,
-				      unsigned long addr, unsigned long end)
-{
-	spinlock_t *ptl;
-	pte_t *pte;
-
-	do {
-		pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
-		if (!pte)
-			continue;
-
-		if (!pte_present(*pte) || pte_write(*pte)) {
-			pte_unmap_unlock(pte, ptl);
-			continue;
-		}
-
-		if (do_wp_page(mm, vma, addr, pte, pmd, ptl, *pte) == VM_FAULT_OOM)
-			return -ENOMEM;
-	} while (addr += PAGE_SIZE, addr != end);
-	return 0;
-}
-
-static inline int ipipe_pin_pmd_range(struct mm_struct *mm, pud_t *pud,
-				      struct vm_area_struct *vma,
-				      unsigned long addr, unsigned long end)
-{
-	unsigned long next;
-	pmd_t *pmd;
-
-	pmd = pmd_offset(pud, addr);
-	do {
-		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_clear_bad(pmd))
-			continue;
-		if (ipipe_pin_pte_range(mm, pmd, vma, addr, next))
-			return -ENOMEM;
-	} while (pmd++, addr = next, addr != end);
-	return 0;
-}
-
-static inline int ipipe_pin_pud_range(struct mm_struct *mm, pgd_t *pgd,
-				      struct vm_area_struct *vma,
-				      unsigned long addr, unsigned long end)
-{
-	unsigned long next;
-	pud_t *pud;
-
-	pud = pud_offset(pgd, addr);
-	do {
-		next = pud_addr_end(addr, end);
-		if (pud_none_or_clear_bad(pud))
-			continue;
-		if (ipipe_pin_pmd_range(mm, pud, vma, addr, next))
-			return -ENOMEM;
-	} while (pud++, addr = next, addr != end);
-	return 0;
-}
-
-int __ipipe_pin_vma(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	unsigned long addr, next, end;
-	pgd_t *pgd;
-
-	addr = vma->vm_start;
-	end = vma->vm_end;
-
-	pgd = pgd_offset(mm, addr);
-	do {
-		next = pgd_addr_end(addr, end);
-		if (pgd_none_or_clear_bad(pgd))
-			continue;
-		if (ipipe_pin_pud_range(mm, pgd, vma, addr, next))
-			return -ENOMEM;
-	} while (pgd++, addr = next, addr != end);
-
-	return 0;
-}
-
 int __ipipe_disable_ondemand_mappings(struct task_struct *tsk)
 {
 	struct vm_area_struct *vma;
diff --git a/mm/mlock.c b/mm/mlock.c
index ef726e8..158828b 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -624,3 +624,21 @@ void user_shm_unlock(size_t size, struct user_struct *user)
 	spin_unlock(&shmlock_user_lock);
 	free_uid(user);
 }
+
+#ifdef CONFIG_IPIPE
+int __ipipe_pin_vma(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	int ret;
+
+	if (vma->vm_flags & (VM_IO | VM_PFNMAP))
+		return 0;
+
+	if (!((vma->vm_flags & (VM_DONTEXPAND | VM_RESERVED)) ||
+	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(mm))) {
+		ret = __mlock_vma_pages_range(vma, vma->vm_start, vma->vm_end,
+					      NULL);
+		return (ret < 0) ? ret : 0;
+	} else
+		return make_pages_present(vma->vm_start, vma->vm_end);
+}
+#endif
-- 
1.7.3.4

