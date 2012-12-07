From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri,  7 Dec 2012 18:09:45 +0100
Message-Id: <5da4867bd045d53b227f7a2ca659d4c54d4e7e97.1354900184.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1354900184.git.jan.kiszka@siemens.com>
References: <cover.1354900184.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1354900184.git.jan.kiszka@siemens.com>
References: <cover.1354900184.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 2/3] ipipe: Pin potential COW pages before
	applying mprotect changes
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

mprotect may make a region writable that wasn't so far. But non-writable
regions are not subject to COW resolution done via
ipipe_disable_ondemand_mappings. Thus, enabling write may make pages
writable that are not supposed to (e.g. the zero page) as we enforce
write access for writable regions to avoid minor faults.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 mm/mprotect.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 3f234b3..af5da94 100644
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
+		error = ipipe_pin_vma(mm, vma);
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


