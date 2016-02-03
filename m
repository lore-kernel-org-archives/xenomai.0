From: Henning Schild <henning.schild@siemens.com>
Date: Wed,  3 Feb 2016 13:59:25 +0100
Message-Id: <1454504365-7015-1-git-send-email-henning.schild@siemens.com>
In-Reply-To: <1453902069-18824-1-git-send-email-henning.schild@siemens.com>
References: <1453902069-18824-1-git-send-email-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH v3] ipipe x86 mm: handle huge pages in memory
	pinning
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

In 4.1 huge page mapping of io memory was introduced, enable ipipe to
handle that when pinning kernel memory.

change that introduced the feature
0f616be120c632c818faaea9adcb8f05a7a8601f

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 arch/x86/mm/fault.c | 6 ++++++
 1 file changed, 6 insertions(+)

This version has the 32bit case changed according to the problems found in
the review. That patch finally should keep the old behaviour. But we should
still discuss whether the old behaviour was correct and should be kept.
If the pinning it not required it should be removed instead of beeing made
more complex.

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fd5bbcc..e78bd09 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -211,6 +211,8 @@ static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 	pud_k = pud_offset(pgd_k, address);
 	if (!pud_present(*pud_k))
 		return NULL;
+	if (pud_large(*pud))
+		return NULL;
 
 	pmd = pmd_offset(pud, address);
 	pmd_k = pmd_offset(pud_k, address);
@@ -400,6 +402,8 @@ static inline int vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 
 	if (pud_none(*pud) || pud_page_vaddr(*pud) != pud_page_vaddr(*pud_ref))
 		BUG();
+	if (pud_large(*pud))
+		return 0;
 
 	pmd = pmd_offset(pud, address);
 	pmd_ref = pmd_offset(pud_ref, address);
@@ -408,6 +412,8 @@ static inline int vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 
 	if (pmd_none(*pmd) || pmd_page(*pmd) != pmd_page(*pmd_ref))
 		BUG();
+	if (pmd_large(*pmd))
+		return 0;
 
 	pte_ref = pte_offset_kernel(pmd_ref, address);
 	if (!pte_present(*pte_ref))
-- 
2.4.10


