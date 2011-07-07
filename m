Message-ID: <4E160578.5020405@domain.hid>
Date: Thu, 07 Jul 2011 21:14:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] ipipe: Prevent unwritable pages after mprotect
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

Page protection changes issued via mprotect, e.g. to enable executable
stacks, cause spurious minor faults as they remove the write permission
from the modified range again. Avoid this by faking shared pages so that
vm_get_page_prot returns the desired page permissions.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 mm/mprotect.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 5a688a2..3f234b3 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -147,6 +147,7 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long oldflags = vma->vm_flags;
+	unsigned long protflags;
 	long nrpages = (end - start) >> PAGE_SHIFT;
 	unsigned long charged = 0;
 	pgoff_t pgoff;
@@ -205,8 +206,17 @@ success:
 	 * held in write mode.
 	 */
 	vma->vm_flags = newflags;
+	protflags = newflags;
+#ifdef CONFIG_IPIPE
+	/*
+	 * Enforce non-COW vm_page_prot by faking VM_SHARED on locked regions.
+	 */
+	if (test_bit(MMF_VM_PINNED, &mm->flags) &&
+	    ((vma->vm_flags | mm->def_flags) & VM_LOCKED))
+		protflags |= VM_SHARED;
+#endif
 	vma->vm_page_prot = pgprot_modify(vma->vm_page_prot,
-					  vm_get_page_prot(newflags));
+					  vm_get_page_prot(protflags));
 
 	if (vma_wants_writenotify(vma)) {
 		vma->vm_page_prot = vm_get_page_prot(newflags & ~VM_SHARED);
-- 
1.7.1

