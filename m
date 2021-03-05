From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 5.4-arm/arm64 only] ipipe: mm: Sync with noarch
Message-ID: <74e3f89f-3a2d-b512-1140-48d3a3d64050@siemens.com>
Date: Fri, 5 Mar 2021 19:31:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Remove remainders of a previous, incomplete update.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

With this applied, my uncow fix fits for arm/arm64 as well.

 mm/memory.c | 41 +++++------------------------------------
 1 file changed, 5 insertions(+), 36 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3958f20409f9..64206f1b0546 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -691,8 +691,8 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 static inline unsigned long
 copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-	     pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
-	     unsigned long addr, int *rss, struct page *uncow_page)
+		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
+		unsigned long addr, int *rss)
 {
 	unsigned long vm_flags = vma->vm_flags;
 	pte_t pte = *src_pte;
@@ -806,27 +806,13 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	int progress = 0;
 	int rss[NR_MM_COUNTERS];
 	swp_entry_t entry = (swp_entry_t){0};
-	struct page *uncow_page = NULL;
-#ifdef CONFIG_IPIPE
-	int do_cow_break = 0;
-again:
-	if (do_cow_break) {
-		uncow_page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
-		if (uncow_page == NULL)
-			return -ENOMEM;
-		do_cow_break = 0;
-	}
-#else
+
 again:
-#endif
 	init_rss_vec(rss);
 
 	dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
-	if (!dst_pte) {
-		if (uncow_page)
-			put_page(uncow_page);
+	if (!dst_pte)
 		return -ENOMEM;
-	}
 	src_pte = pte_offset_map(src_pmd, addr);
 	src_ptl = pte_lockptr(src_mm, src_pmd);
 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
@@ -849,25 +835,8 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			progress++;
 			continue;
 		}
-#ifdef CONFIG_IPIPE
-		if (likely(uncow_page == NULL) && likely(pte_present(*src_pte))) {
-			if (is_cow_mapping(vma->vm_flags) &&
-			    test_bit(MMF_VM_PINNED, &src_mm->flags) &&
-			    ((vma->vm_flags|src_mm->def_flags) & VM_LOCKED)) {
-				arch_leave_lazy_mmu_mode();
-				spin_unlock(src_ptl);
-				pte_unmap(src_pte);
-				add_mm_rss_vec(dst_mm, rss);
-				pte_unmap_unlock(dst_pte, dst_ptl);
-				cond_resched();
-				do_cow_break = 1;
-				goto again;
-			}
-		}
-#endif
 		entry.val = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
-					 vma, addr, rss, uncow_page);
-		uncow_page = NULL;
+							vma, addr, rss);
 		if (entry.val)
 			break;
 		progress += 8;
-- 
2.26.2

