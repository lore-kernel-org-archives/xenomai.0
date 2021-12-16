From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/5] cobalt: Drop vmalloc_kernel wrapper
Date: Thu, 16 Dec 2021 16:48:23 +0100
Message-ID: <cd9f423f0f18a474b0db843c4cbecd498dffe14a.1639669704.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1639669704.git.jan.kiszka@siemens.com>
References: <cover.1639669704.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

vmalloc_kernel() without extra flags is just vmalloc. And for requesting
__GFP_ZERO, there vzalloc since 2.6.37.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/heap.c                                 |  2 +-
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 12 ------------
 kernel/cobalt/posix/memory.c                         |  2 +-
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/kernel/cobalt/heap.c b/kernel/cobalt/heap.c
index f106d5d071..28fe78a78e 100644
--- a/kernel/cobalt/heap.c
+++ b/kernel/cobalt/heap.c
@@ -850,7 +850,7 @@ void *xnheap_vmalloc(size_t size)
 	 * software on a 32bit system had to be wrong in the first
 	 * place anyway.
 	 */
-	return vmalloc_kernel(size, 0);
+	return vmalloc(size);
 }
 EXPORT_SYMBOL_GPL(xnheap_vmalloc);
 
diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 87ceeda800..414469c3a5 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -197,12 +197,6 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,8,0)
-#define vmalloc_kernel(__size, __flags)	__vmalloc(__size, GFP_KERNEL|__flags, PAGE_KERNEL)
-#else
-#define vmalloc_kernel(__size, __flags)	__vmalloc(__size, GFP_KERNEL|__flags)
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(5,7,0)
 #define pci_aer_clear_nonfatal_status	pci_cleanup_aer_uncorrect_error_status
 #define old_timespec32    compat_timespec
@@ -210,12 +204,6 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 #define old_timeval32     compat_timeval
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,8,0)
-#define vmalloc_kernel(__size, __flags)	__vmalloc(__size, GFP_KERNEL|__flags, PAGE_KERNEL)
-#else
-#define vmalloc_kernel(__size, __flags)	__vmalloc(__size, GFP_KERNEL|__flags)
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(5,9,0)
 #define read_file_from_kernel(__file, __buf, __buf_size, __file_size, __id) \
 	({								\
diff --git a/kernel/cobalt/posix/memory.c b/kernel/cobalt/posix/memory.c
index fc88e264c6..25cc784ea9 100644
--- a/kernel/cobalt/posix/memory.c
+++ b/kernel/cobalt/posix/memory.c
@@ -324,7 +324,7 @@ int cobalt_umm_init(struct cobalt_umm *umm, u32 size,
 	BUG_ON(xnarch_cache_aliasing());
 
 	size = PAGE_ALIGN(size);
-	basemem = vmalloc_kernel(size, __GFP_ZERO);
+	basemem = vzalloc(size);
 	if (basemem == NULL)
 		return -ENOMEM;
 
-- 
2.31.1


