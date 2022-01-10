From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH] dovetail: mm: fix logic of COW-disabling check
Date: Mon, 10 Jan 2022 08:55:45 +0100
Message-Id: <20220110075545.912566-1-rpm@xenomai.org>
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

COW-disabling for a dovetailed process does not depend on the pinning
status of the source mm considered by copy_present_page(). Decouple
both checks, which fixes the following kernel splat on fork() from a
dovetailed task:

[   18.376448] ------------[ cut here ]------------
[   18.376915] kernel BUG at mm/rmap.c:1049!
[   18.377259] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI IRQ_PIPELINE
[   18.377262] CPU: 0 PID: 121 Comm: smokey Not tainted 5.15.9+ #12
[   18.377264] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
[   18.377265] IRQ stage: Linux
[   18.377266] RIP: 0010:__page_set_anon_rmap+0x59/0x70
[   18.377271] Code: c9 74 22 48 83 c0 01 48 89 43 18 f6 47 52 40 75 1b 48 2b 17 48 c1 ea 0c 48 03 97 98 00 00 00 48 89 53 20 5b c3 48 8b 00 eb d9 <0f> 0b 48 89 d6 e8 ad c6 01 00 48 89 c2 eb e6 0f 1f 84 00 00 00 00
[   18.377273] RSP: 0018:ffffc90000b0bb50 EFLAGS: 00010246
[   18.377275] RAX: 0000000000000000 RBX: 000000010498f000 RCX: 0000000000000001
[   18.377276] RDX: 00007fe623795000 RSI: ffff888102ab5398 RDI: ffffea00041263c0
[   18.377277] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8881029da958
[   18.377277] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888102aa3ca8
[   18.377278] R13: ffff888102abaca8 R14: ffffea00041263c0 R15: 00007fe623795000
[   18.377281] FS:  00007fe623815740(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
[   18.377284] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.377285] CR2: 00007ffef0186000 CR3: 0000000102320000 CR4: 00000000000406f0
[   18.377286] Call Trace:
[   18.377287]  <TASK>
[   18.377287]  copy_pte_range+0x646/0x8c0
[   18.377292]  copy_pud_range+0x20a/0x2b0
[   18.377294]  copy_page_range+0x10f/0x2e0
[   18.377297]  ? dup_mmap+0x232/0x4e0
[   18.377300]  dup_mmap+0x3a6/0x4e0
[   18.377303]  dup_mm.isra.0+0x52/0xf0
[   18.377304]  copy_process+0x169e/0x1920
[   18.377307]  kernel_clone+0x4f/0x3e0
[   18.377309]  ? cobalt_thread_setschedparam_ex+0x200/0x200
[   18.377312]  ? rcu_read_lock_sched_held+0x57/0x80
[   18.377315]  ? handle_root_syscall+0x269/0x440
[   18.377319]  __do_sys_clone+0x52/0x60
[   18.377321]  do_syscall_64+0x4d/0xa0
[   18.377324]  entry_SYSCALL_64_after_hwframe+0x44/0xae

As a result of this change, other callers of page_needs_cow_for_dma()
are now influenced by the Dovetail pinning status of the mm,
specifically the huge page management.

Finally, since page_needs_cow_for_dma() does not exclusively apply to
pinned memory for DMA anymore, rename it to page_needs_cow().

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/linux/mm.h | 13 +++++++++++--
 mm/huge_memory.c   |  4 ++--
 mm/hugetlb.c       |  2 +-
 mm/memory.c        |  8 +-------
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a4cfbaef94635ce..d3a51989ad89f93 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1340,12 +1340,21 @@ static inline bool is_cow_mapping(vm_flags_t flags)
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
 
+	/*
+	 * Dovetail: If the source mm belongs to a dovetailed process,
+	 * we don't want to impose the COW-induced latency on it: make
+	 * sure the child gets its own copy of the page.
+	 */
+	if (IS_ENABLED(CONFIG_DOVETAIL) &&
+	    test_bit(MMF_DOVETAILED, &vma->vm_mm->flags))
+		return true;
+
 	if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
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
index 0e3e2228f67ff8f..c1721f751d542b5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -899,14 +899,8 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	 * seen pinning", along with the (inexact) check of
 	 * the page count. That might give false positives for
 	 * for pinning, but it will work correctly.
-	 *
-	 * Dovetail: if the source mm belongs to a Dovetail-enabled
-	 * process, we don't want to impose the COW-induced latency on
-	 * it: make sure the child gets its own copy of the page.
 	 */
-	if (likely(!page_needs_cow_for_dma(src_vma, page) &&
-			(!dovetailing() || !test_bit(MMF_DOVETAILED,
-						&src_vma->vm_mm->flags))))
+	if (likely(!page_needs_cow(src_vma, page)))
 		return 1;
 
 	new_page = *prealloc;
-- 
2.31.1


