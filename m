From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4.19-arm64 only] ipipe: mm: Sync with noarch
Message-ID: <67ecfe44-f4e2-6362-6b0b-9a2192a8338f@siemens.com>
Date: Fri, 5 Mar 2021 19:31:14 +0100
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

With this applied, my uncow fix fits for 4.19-arm64 as well.

 mm/memory.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f466aebf0fb9..4cc7c72a0b7e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -141,10 +141,6 @@ EXPORT_SYMBOL(zero_pfn);
 
 unsigned long highest_memmap_pfn __read_mostly;
 
-static inline bool cow_user_page(struct page *dst,
-				 struct page *src,
-				 struct vm_fault *vmf);
-
 /*
  * CONFIG_MMU architectures set up ZERO_PAGE in their paging_init()
  */
@@ -961,8 +957,8 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 static inline unsigned long
 copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
-	     pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
-	     unsigned long addr, int *rss, struct page *uncow_page)
+		pte_t *dst_pte, pte_t *src_pte, struct vm_area_struct *vma,
+		unsigned long addr, int *rss)
 {
 	unsigned long vm_flags = vma->vm_flags;
 	pte_t pte = *src_pte;
@@ -1087,17 +1083,13 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	int progress = 0;
 	int rss[NR_MM_COUNTERS];
 	swp_entry_t entry = (swp_entry_t){0};
-	struct page *uncow_page = NULL;
 
 again:
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
@@ -1121,8 +1113,7 @@ static int copy_pte_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			continue;
 		}
 		entry.val = copy_one_pte(dst_mm, src_mm, dst_pte, src_pte,
-					 vma, addr, rss, uncow_page);
-		uncow_page = NULL;
+							vma, addr, rss);
 		if (entry.val)
 			break;
 		progress += 8;
-- 
2.26.2

