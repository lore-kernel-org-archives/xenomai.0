From: Konstantin Smola <ksmola51@gmail.com>
Subject: [PATCH 1/1] Documentation improvements for rtdm_mmap_to_user(),
 rtdm_mmap_vmem(), rtdm_mmap_kmem(), rtdm_mmap_iomem()
Date: Wed, 17 Nov 2021 17:14:42 -0800
Message-Id: <20211118011442.13232-1-ksmola51@gmail.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Konstantin Smola <ksmola51@gmail.com>

kernel/cobalt/rtdm: Documentation improvements for rtdm_mmap_to_user(), rtdm_mmap_vmem(), 
 rtdm_mmap_kmem(), rtdm_mmap_iomem()
Signed-off-by: Konstantin Smola <ksmola51@gmail.com>
---
 kernel/cobalt/rtdm/drvlib.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 7b7b0830c..4ebcd3b0d 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1973,6 +1973,10 @@ int __rtdm_mmap_from_fdop(struct rtdm_fd *fd, size_t len, off_t offset,
  * vmalloc(). To map physical I/O memory to user-space use
  * rtdm_iomap_to_user() instead.
  *
+ * @note This service is provided only for use in .ioctl operation handlers. 
+ * Otherwise RTDM drivers implementing a .mmap operation should use 
+ * rtdm_mmap_kmem(), rtdm_mmap_vmem(), or rtdm_mmap_iomem().
+ *
  * @note RTDM supports two models for unmapping the memory area:
  * - manual unmapping via rtdm_munmap(), which may be issued from a
  * driver in response to an IOCTL call, or by a call to the regular
@@ -2084,7 +2088,7 @@ EXPORT_SYMBOL_GPL(rtdm_iomap_to_user);
 /**
  * Map a kernel logical memory range to a virtual user area.
  *
- * This routine is commonly used from a ->mmap() handler of a RTDM
+ * This routine is commonly used from a .mmap operation handler of a RTDM
  * driver, for mapping a virtual memory area with a direct physical
  * mapping over the user address space referred to by @a vma.
  *
@@ -2107,10 +2111,10 @@ int rtdm_mmap_kmem(struct vm_area_struct *vma, void *va)
 EXPORT_SYMBOL_GPL(rtdm_mmap_kmem);
 
 /**
- * Map a virtual memory range to a virtual user area.
+ * Map a kernel virtual memory range to a virtual user area.
  *
- * This routine is commonly used from a ->mmap() handler of a RTDM
- * driver, for mapping a purely virtual memory area over the user
+ * This routine is commonly used from a .mmap operation handler of a RTDM
+ * driver, for mapping a kernel virtual memory area over the user
  * address space referred to by @a vma.
  *
  * @param[in] vma The VMA descriptor to receive the mapping.
@@ -2138,7 +2142,7 @@ EXPORT_SYMBOL_GPL(rtdm_mmap_vmem);
 /**
  * Map an I/O memory range to a virtual user area.
  *
- * This routine is commonly used from a ->mmap() handler of a RTDM
+ * This routine is commonly used from a .mmap operation handler of a RTDM
  * driver, for mapping an I/O memory area over the user address space
  * referred to by @a vma.
  *
-- 
2.17.2


