Message-ID: <4F79B7B5.7060902@domain.hid>
Date: Mon, 02 Apr 2012 16:29:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4F749006.8060804@domain.hid> <4F775BD0.4070109@domain.hid>
In-Reply-To: <4F775BD0.4070109@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH v2 1/2] ipipe: Factor out ipipe_pin_vma
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

Will be used for pinning during mprotect as well.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/linux/ipipe.h |    1 +
 mm/memory.c           |   38 +++++++++++++++++++++++---------------
 2 files changed, 24 insertions(+), 15 deletions(-)

Changes in v2:
 - Refactored __ipipe_disable_ondemand_mappings according to request

diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
index 9f07346..29051c7 100644
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -68,6 +68,7 @@ int __ipipe_migrate_head(void);
 void __ipipe_reenter_root(void);
 
 int __ipipe_disable_ondemand_mappings(struct task_struct *p);
+int __ipipe_pin_vma(struct mm_struct *mm, struct vm_area_struct *vma);
 
 #ifdef CONFIG_IPIPE_WANT_PREEMPTIBLE_SWITCH
 
diff --git a/mm/memory.c b/mm/memory.c
index ef04820..58b7f38 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4092,13 +4092,31 @@ static inline int ipipe_pin_pud_range(struct mm_struct *mm, pgd_t *pgd,
 	return 0;
 }
 
-int __ipipe_disable_ondemand_mappings(struct task_struct *tsk)
+int __ipipe_pin_vma(struct mm_struct *mm, struct vm_area_struct *vma)
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
+int __ipipe_disable_ondemand_mappings(struct task_struct *tsk)
+{
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	int result = 0;
-	pgd_t *pgd;
 
 	mm = get_task_mm(tsk);
 	if (!mm)
@@ -4113,19 +4131,9 @@ int __ipipe_disable_ondemand_mappings(struct task_struct *tsk)
 		    || !(vma->vm_flags & VM_WRITE))
 			continue;
 
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
-				goto done_mm;
-			}
-		} while (pgd++, addr = next, addr != end);
+		result = __ipipe_pin_vma(mm, vma);
+		if (result < 0)
+			goto done_mm;
 	}
 	set_bit(MMF_VM_PINNED, &mm->flags);
 
-- 
1.7.3.4

