Message-ID: <4C07BABA.6050302@domain.hid>
Date: Thu, 03 Jun 2010 16:22:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] x86: Clean up mm/fault.c patching
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

This moves vmalloc_sync_all back to its original place, removes a stray
newline, adds __kprobes to vmalloc_fault and removes a redundant
assignment.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/mm/fault.c |   66 ++++++++++++++++++++++----------------------------
 1 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 1f3e5a3..f4f18e7 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1,4 +1,3 @@
-
 /*
  *  Copyright (C) 1995  Linus Torvalds
  *  Copyright (C) 2001, 2002 Andi Kleen, SuSE Labs.
@@ -325,6 +324,33 @@ out:
 
 #else /* CONFIG_X86_64: */
 
+void vmalloc_sync_all(void)
+{
+	unsigned long address;
+
+	for (address = VMALLOC_START & PGDIR_MASK; address <= VMALLOC_END;
+	     address += PGDIR_SIZE) {
+
+		const pgd_t *pgd_ref = pgd_offset_k(address);
+		unsigned long flags;
+		struct page *page;
+
+		if (pgd_none(*pgd_ref))
+			continue;
+
+		spin_lock_irqsave(&pgd_lock, flags);
+		list_for_each_entry(page, &pgd_list, lru) {
+			pgd_t *pgd;
+			pgd = (pgd_t *)page_address(page) + pgd_index(address);
+			if (pgd_none(*pgd))
+				set_pgd(pgd, *pgd_ref);
+			else
+				BUG_ON(pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_ref));
+		}
+		spin_unlock_irqrestore(&pgd_lock, flags);
+	}
+}
+
 /*
  * 64-bit:
  *
@@ -395,43 +421,9 @@ static inline int vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 	return 0;
 }
 
-void vmalloc_sync_all(void)
-{
-	unsigned long address;
-
-	for (address = VMALLOC_START & PGDIR_MASK; address <= VMALLOC_END;
-	     address += PGDIR_SIZE) {
-
-		const pgd_t *pgd_ref = pgd_offset_k(address);
-		unsigned long flags;
-		struct page *page;
-
-		if (pgd_none(*pgd_ref))
-			continue;
-
-		spin_lock_irqsave(&pgd_lock, flags);
-		list_for_each_entry(page, &pgd_list, lru) {
-			pgd_t *pgd;
-			pgd = (pgd_t *)page_address(page) + pgd_index(address);
-			if (pgd_none(*pgd))
-				set_pgd(pgd, *pgd_ref);
-			else
-				BUG_ON(pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_ref));
-		}
-		spin_unlock_irqrestore(&pgd_lock, flags);
-	}
-}
-
-/*
- * 64-bit:
- *
- *   Handle a fault on the vmalloc area
- *
- * This assumes no large pages in there.
- */
-static noinline int vmalloc_fault(unsigned long address)
+static noinline __kprobes int vmalloc_fault(unsigned long address)
 {
-	pgd_t *pgd = pgd = pgd_offset(current->active_mm, address);
+	pgd_t *pgd = pgd_offset(current->active_mm, address);
 	return vmalloc_sync_one(pgd, address);
 }
 

