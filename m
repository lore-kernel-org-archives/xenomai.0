Message-ID: <50F5741A.9060404@grandegger.com>
Date: Tue, 15 Jan 2013 16:22:02 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rtdm_iomap_to_user: fix caching and page fault issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

From: Wolfgang Grandegger <wg@denx.de>

Pages mapped by rtdm_iomap_to_user() might be cached and may
page fault on the first write. At least that's the behaviour
we observed on an ARM mx6q system. This patch fixes these
issues.

Signed-off-by: Wolfgang Grandegger <wg@denx.de>
---
 include/asm-generic/wrappers.h | 2 +-
 ksrc/skins/rtdm/drvlib.c       | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/wrappers.h b/include/asm-generic/wrappers.h
index de1f0d7..e71bcc3 100644
--- a/include/asm-generic/wrappers.h
+++ b/include/asm-generic/wrappers.h
@@ -394,7 +394,7 @@ static inline void *kzalloc(size_t size, int flags)
 #define wrap_remap_io_page_range(vma,from,to,size,prot)  ({		\
     (vma)->vm_page_prot = pgprot_noncached((vma)->vm_page_prot);	\
     /* Sets VM_RESERVED | VM_IO | VM_PFNMAP on the vma. */		\
-    remap_pfn_range(vma,from,(to) >> PAGE_SHIFT,size,prot);		\
+    remap_pfn_range(vma,from,(to) >> PAGE_SHIFT,size,pgprot_noncached(prot));		\
     })
 #define wrap_remap_kmem_page_range(vma,from,to,size,prot)  ({		\
     /* Sets VM_RESERVED | VM_IO | VM_PFNMAP on the vma. */		\
diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
index e5c470c..391d45f 100644
--- a/ksrc/skins/rtdm/drvlib.c
+++ b/ksrc/skins/rtdm/drvlib.c
@@ -1858,10 +1858,12 @@ static int rtdm_mmap_buffer(struct file *filp, struct vm_area_struct *vma)
 #else
 	vma->vm_pgoff = paddr >> PAGE_SHIFT;
 #endif /* CONFIG_MMU */
-	if (mmap_data->src_paddr)
-	  	ret = xnarch_remap_io_page_range(filp, vma, maddr, paddr,
+	if (mmap_data->src_paddr) {
+		ret = xnarch_remap_io_page_range(filp, vma, maddr, paddr,
 						 size, PAGE_SHARED);
-	else {
+		if (!ret)
+			xnarch_fault_range(vma);
+	} else {
 		ret = xnarch_remap_kmem_page_range(vma, maddr, paddr,
 						   size, PAGE_SHARED);
 		if (!ret)
-- 
1.7.11.7


