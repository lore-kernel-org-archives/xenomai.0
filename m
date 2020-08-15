Sender: pintu=codeaurora.org@mg.codeaurora.org
From: Pintu Kumar <pintu@codeaurora.org>
Subject: [PATCH v2] kernel:cobalt:heap: replace kzalloc with vmalloc
Date: Sat, 15 Aug 2020 15:59:29 +0530
Message-Id: <1597487369-20838-1-git-send-email-pintu@codeaurora.org>
In-Reply-To: <1596218699-15537-1-git-send-email-pintu@codeaurora.org>
References: <1596218699-15537-1-git-send-email-pintu@codeaurora.org>
In-Reply-To: <1596218699-15537-1-git-send-email-pintu@codeaurora.org>
References: <1596218699-15537-1-git-send-email-pintu@codeaurora.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, rpm@xenomai.org, sunshilong369@gmail.com, pintu@codeaurora.org, jan.kiszka@siemens.com
Cc: pintu.ping@gmail.com

With CONFIG_XENO_OPT_PRIVATE_HEAPSZ, user can request any heap size
based on their needs. For some application needs, this can grow as large
as 4MB that is, 2^10 order pages, which is unlikely to succeed with
kzalloc. Even the default (256KB) may fail on highly fragmented system.

Moreover, for this heap allocation, we don't need physical contiguous
memory. Thus vmalloc may be sufficient here.

Note, we may also use kvzalloc/kvmalloc, but unfortunately these are not
available in all kernel versions. Thus for backward compatibility we stick
to vmalloc at least till we support 4.x kernel.

Signed-off-by: Pintu Kumar <pintu@codeaurora.org>
Signed-off-by: sunshilong <sunshilong369@gmail.com>
Tested-by: sunshilong <sunshilong369@gmail.com>
---
 kernel/cobalt/heap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/heap.c b/kernel/cobalt/heap.c
index d01a2e0..17b392b 100644
--- a/kernel/cobalt/heap.c
+++ b/kernel/cobalt/heap.c
@@ -749,8 +749,7 @@ int xnheap_init(struct xnheap *heap, void *membase, size_t size)
 	xnlock_init(&heap->lock);
 
 	nrpages = size >> XNHEAP_PAGE_SHIFT;
-	heap->pagemap = kzalloc(sizeof(struct xnheap_pgentry) * nrpages,
-				GFP_KERNEL);
+	heap->pagemap = vmalloc(sizeof(struct xnheap_pgentry) * nrpages);
 	if (heap->pagemap == NULL)
 		return -ENOMEM;
 
@@ -804,7 +803,7 @@ void xnheap_destroy(struct xnheap *heap)
 	nrheaps--;
 	xnvfile_touch_tag(&vfile_tag);
 	xnlock_put_irqrestore(&nklock, s);
-	kfree(heap->pagemap);
+	vfree(heap->pagemap);
 }
 EXPORT_SYMBOL_GPL(xnheap_destroy);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


