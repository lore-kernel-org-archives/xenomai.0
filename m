From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH] mm: dovetail: rename page_needs_cow_for_dma() to
 page_needs_cow()
Date: Sun,  9 Jan 2022 19:13:59 +0100
Message-Id: <20220109181359.811425-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

With the addition of the Dovetail COW-breaking logic,
page_needs_cow_for_dma() does not exclusively apply to pinned memory
for DMA anymore. Give it a more generic name.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/linux/mm.h | 4 ++--
 mm/huge_memory.c   | 4 ++--
 mm/hugetlb.c       | 2 +-
 mm/memory.c        | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6bb27a008ce8f..d3a51989ad89f93 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1340,8 +1340,8 @@ static inline bool is_cow_mapping(vm_flags_t flags)
  * This should most likely only be called during fork() to see whether we
  * should break the cow immediately for a page on the src mm.
  */
-static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
-					  struct page *page)
+static inline bool page_needs_cow(struct vm_area_struct *vma,
+				struct page *page)
 {
 	if (!is_cow_mapping(vma->vm_flags))
 		return false;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c5142d237e482fe..c7bba75945e97c9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1104,7 +1104,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	 * best effort that the pinned pages won't be replaced by another
 	 * random page during the coming copy-on-write.
 	 */
-	if (unlikely(page_needs_cow_for_dma(src_vma, src_page))) {
+	if (unlikely(page_needs_cow(src_vma, src_page))) {
 		pte_free(dst_mm, pgtable);
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
@@ -1218,7 +1218,7 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 
 	/* Please refer to comments in copy_huge_pmd() */
-	if (unlikely(page_needs_cow_for_dma(vma, pud_page(pud)))) {
+	if (unlikely(page_needs_cow(vma, pud_page(pud)))) {
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
 		__split_huge_pud(vma, src_pud, addr);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f5ed98843557b74..c8fc2462a7faf02 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4363,7 +4363,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * need to be without the pgtable locks since we could
 			 * sleep during the process.
 			 */
-			if (unlikely(page_needs_cow_for_dma(vma, ptepage))) {
+			if (unlikely(page_needs_cow(vma, ptepage))) {
 				pte_t src_pte_old = entry;
 				struct page *new;
 
diff --git a/mm/memory.c b/mm/memory.c
index c0d89177e2c359d..c1721f751d542b5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -900,7 +900,7 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	 * the page count. That might give false positives for
 	 * for pinning, but it will work correctly.
 	 */
-	if (likely(!page_needs_cow_for_dma(src_vma, page)))
+	if (likely(!page_needs_cow(src_vma, page)))
 		return 1;
 
 	new_page = *prealloc;
-- 
2.31.1


