From: Gunter Grau <guntgrau@bbl.ma.philips.com>
Subject: [PATCH] rtdm/drvlib: Prevent pagefaults on arm on io mapping
Date: Mon, 23 May 2022 16:04:44 +0200
Message-Id: <20220523140444.2632658-1-guntgrau@bbl.ma.philips.com>
Reply-To: Gunter Grau <gunter.grau@philips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Gunter Grau <gunter.grau@philips.com>

When mapping io memory into userspace an extra simulated pagefault for all
pages is added to prevent later pagefaults because of copy on write
mechanisms. This happens only on architectures that have defined the
needed cobalt_machine.prefault function.

Signed-off-by: Gunter Grau <gunter.grau@philips.com>
---
 kernel/cobalt/rtdm/drvlib.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 4eaf3a57c..db8431ee1 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -1761,6 +1761,7 @@ static int mmap_iomem_helper(struct vm_area_struct *vma, phys_addr_t pa)
 {
 	pgprot_t prot = PAGE_SHARED;
 	unsigned long len;
+	int ret;
 
 	len = vma->vm_end - vma->vm_start;
 #ifndef CONFIG_MMU
@@ -1774,8 +1775,15 @@ static int mmap_iomem_helper(struct vm_area_struct *vma, phys_addr_t pa)
 #endif
 	vma->vm_page_prot = pgprot_noncached(prot);
 
-	return remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
+	ret = remap_pfn_range(vma, vma->vm_start, pa >> PAGE_SHIFT,
 			       len, vma->vm_page_prot);
+	if (ret)
+		return ret;
+
+	if (cobalt_machine.prefault)
+		cobalt_machine.prefault(vma);
+
+	return ret;
 }
 
 static int mmap_buffer_helper(struct rtdm_fd *fd, struct vm_area_struct *vma)
-- 
2.25.1


