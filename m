From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH v2 1/7] cobalt/memory: fix __vmalloc() calls
Date: Sat, 27 Mar 2021 11:19:06 +0100
Message-Id: <20210327101912.2291474-2-rpm@xenomai.org>
In-Reply-To: <20210327101912.2291474-1-rpm@xenomai.org>
References: <20210327101912.2291474-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Since kernel v5.8, __vmalloc() does not take protection bits as
PROT_KERNEL is now wired in. Therefore we cannot disable the cache for
the UMM segment via the allocation call directly anymore.

This said, we don't support any CPU architecture exhibiting cache
aliasing braindamage anymore either (was armv4/v5), so let's convert
to the new __vmalloc() call format without bothering for cache
settings.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/cobalt/heap.c                                 | 3 ++-
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 6 ++++++
 kernel/cobalt/posix/memory.c                         | 7 ++++---
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/cobalt/heap.c b/kernel/cobalt/heap.c
index 9e184d4c3..d3f43729e 100644
--- a/kernel/cobalt/heap.c
+++ b/kernel/cobalt/heap.c
@@ -28,6 +28,7 @@
 #include <cobalt/kernel/heap.h>
 #include <cobalt/kernel/vfile.h>
 #include <cobalt/kernel/ancillaries.h>
+#include <asm/xenomai/wrappers.h>
 
 /**
  * @ingroup cobalt_core
@@ -849,7 +850,7 @@ void *xnheap_vmalloc(size_t size)
 	 * software on a 32bit system had to be wrong in the first
 	 * place anyway.
 	 */
-	return __vmalloc(size, GFP_KERNEL, PAGE_KERNEL);
+	return vmalloc_kernel(size, 0);
 }
 EXPORT_SYMBOL_GPL(xnheap_vmalloc);
 
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 9e8733b47..ac4e95aa0 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -176,4 +176,10 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #define old_timeval32     compat_timeval
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,8,0)
+#define vmalloc_kernel(__size, __flags)	__vmalloc(__size, GFP_KERNEL|__flags, PAGE_KERNEL)
+#else
+#define vmalloc_kernel(__size, __flags)	__vmalloc(__size, GFP_KERNEL|__flags)
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
diff --git a/kernel/cobalt/posix/memory.c b/kernel/cobalt/posix/memory.c
index 1d888a219..fc88e264c 100644
--- a/kernel/cobalt/posix/memory.c
+++ b/kernel/cobalt/posix/memory.c
@@ -320,10 +320,11 @@ int cobalt_umm_init(struct cobalt_umm *umm, u32 size,
 
 	secondary_mode_only();
 
+	/* We don't support CPUs with VIVT caches and the like. */
+	BUG_ON(xnarch_cache_aliasing());
+
 	size = PAGE_ALIGN(size);
-	basemem = __vmalloc(size, GFP_KERNEL|__GFP_ZERO,
-			    xnarch_cache_aliasing() ?
-			    pgprot_noncached(PAGE_KERNEL) : PAGE_KERNEL);
+	basemem = vmalloc_kernel(size, __GFP_ZERO);
 	if (basemem == NULL)
 		return -ENOMEM;
 
-- 
2.29.2


