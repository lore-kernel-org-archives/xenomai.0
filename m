From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri,  7 Dec 2012 18:09:44 +0100
Message-Id: <bccbecd725a84b0e556f488fd5442b7e6d1ed2e2.1354900184.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1354900184.git.jan.kiszka@siemens.com>
References: <cover.1354900184.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1354900184.git.jan.kiszka@siemens.com>
References: <cover.1354900184.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 1/3] ipipe: Factor out ipipe_pin_vma
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Will be used for pinning during mprotect as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/linux/ipipe.h |    1 +
 mm/memory.c           |   43 +++++++++++++++++++++++++------------------
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
index fb0789e..48f93bd 100644
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -647,6 +647,7 @@ int ipipe_set_ptd(int key,
 void *ipipe_get_ptd(int key);
 
 int ipipe_disable_ondemand_mappings(struct task_struct *tsk);
+int ipipe_pin_vma(struct mm_struct *mm, struct vm_area_struct *vma);
 
 static inline void ipipe_nmi_enter(void)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 949d965..18a59619 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3903,13 +3903,31 @@ static inline int ipipe_pin_pud_range(struct mm_struct *mm, pgd_t *pgd,
 	return 0;
 }
 
-int ipipe_disable_ondemand_mappings(struct task_struct *tsk)
+int ipipe_pin_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	unsigned long addr, next, end;
+	pgd_t *pgd;
+
+	addr = vma->vm_start;
+	end = vma->vm_end;
+
+	pgd = pgd_offset(mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		if (ipipe_pin_pud_range(mm, pgd, vma, addr, next))
+			return -ENOMEM;
+	} while (pgd++, addr = next, addr != end);
+
+	return 0;
+}
+
+int ipipe_disable_ondemand_mappings(struct task_struct *tsk)
+{
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	int result = 0;
-	pgd_t *pgd;
 
 	mm = get_task_mm(tsk);
 	if (!mm)
@@ -3920,23 +3938,12 @@ int ipipe_disable_ondemand_mappings(struct task_struct *tsk)
 		goto done_mm;
 
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		if (!is_cow_mapping(vma->vm_flags)
-		    || !(vma->vm_flags & VM_WRITE))
-			continue;
-
-		addr = vma->vm_start;
-		end = vma->vm_end;
-
-		pgd = pgd_offset(mm, addr);
-		do {
-			next = pgd_addr_end(addr, end);
-			if (pgd_none_or_clear_bad(pgd))
-				continue;
-			if (ipipe_pin_pud_range(mm, pgd, vma, addr, next)) {
-				result = -ENOMEM;
+		if (is_cow_mapping(vma->vm_flags) &&
+		    (vma->vm_flags & VM_WRITE)) {
+			result = ipipe_pin_vma(mm, vma);
+			if (result < 0)
 				goto done_mm;
-			}
-		} while (pgd++, addr = next, addr != end);
+		}
 	}
 	set_bit(MMF_VM_PINNED, &mm->flags);
 
-- 
1.7.3.4


