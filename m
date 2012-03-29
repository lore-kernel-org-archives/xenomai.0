Message-ID: <4F74900F.6030707@domain.hid>
Date: Thu, 29 Mar 2012 18:38:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 2/2] ipipe: Pin potential COW pages before
 applying mprotect changes
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>

mprotect may make a region writable that wasn't so far. But non-writable
regions are not subject to COW resolution done via
ipipe_disable_ondemand_mappings. Thus, enabling write may make pages
writable that are not supposed to (e.g. the zero page) as we enforce
write access for writable regions to avoid minor faults.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

This applies on core-3.2, but should be backported to maintained
versions as well (just leave out the "__").

 mm/mprotect.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 3f234b3..9981d19 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -224,6 +224,24 @@ success:
 	}
 
 	mmu_notifier_invalidate_range_start(mm, start, end);
+#ifdef CONFIG_IPIPE
+	/*
+	 * Privatize potential COW pages
+	 */
+	if (test_bit(MMF_VM_PINNED, &mm->flags) &&
+	    (((vma->vm_flags | mm->def_flags) & (VM_LOCKED | VM_WRITE)) ==
+	     (VM_LOCKED | VM_WRITE))) {
+		error = __ipipe_pin_vma(mm, vma);
+		if (error)
+			/*
+			 * OOM. Just revert the fake VM_SHARED so that the
+			 * zero page cannot be overwritten.
+			 */
+			vma->vm_page_prot =
+				pgprot_modify(vma->vm_page_prot,
+					      vm_get_page_prot(newflags));
+	}
+#endif
 	if (is_vm_hugetlb_page(vma))
 		hugetlb_change_protection(vma, start, end, vma->vm_page_prot);
 	else
-- 
1.7.3.4

