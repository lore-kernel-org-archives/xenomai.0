From: Charles Kiorpes <ckiorpes@gmail.com>
Date: Fri,  3 Nov 2017 12:44:18 -0400
Message-Id: <1509727458-9486-1-git-send-email-ckiorpes@gmail.com>
Subject: [Xenomai] [PATCH] Fix unneeded pre-commit of memory pool when
	CONFIG_XENO_PSHARED set
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Charles Kiorpes <ckiorpes@gmail.com>

When CONFIG_XENO_PSHARED is set, heapobj_pkg_init_private() was causing unneeded pages to be locked into memory by performing a temporary allocation of the size of the entire memory pool.

This patch reduces the size of this temporary allocation to a single page when CONFIG_XENO_PSHARED is set.

Signed-off-by: Charles Kiorpes <ckiorpes@gmail.com>
---
 lib/copperplate/heapobj-tlsf.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/lib/copperplate/heapobj-tlsf.c b/lib/copperplate/heapobj-tlsf.c
index e24db15..3709852 100644
--- a/lib/copperplate/heapobj-tlsf.c
+++ b/lib/copperplate/heapobj-tlsf.c
@@ -19,6 +19,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdint.h>
+#include <unistd.h>
 #include "boilerplate/tlsf/tlsf.h"
 #include "copperplate/heapobj.h"
 #include "copperplate/debug.h"
@@ -76,7 +77,12 @@ int heapobj_init_array_private(struct heapobj *hobj, const char *name,
 
 int heapobj_pkg_init_private(void)
 {
-	size_t size;
+	#ifdef CONFIG_XENO_PSHARED
+		size_t alloc_size = sysconf(_SC_PAGE_SIZE);
+	#else
+		size_t alloc_size = __copperplate_setup_data.mem_pool;
+	#endif
+	size_t available_size;
 	void *mem;
 
 	/*
@@ -88,14 +94,21 @@ int heapobj_pkg_init_private(void)
 	 * We include 1k of additional memory to cope with the
 	 * per-block overhead for an undefined number of individual
 	 * allocation requests. Ugly.
+	 *
+	 * CAUTION: in pshared mode, private heaps are subsidiary
+	 * storage pools, so no need to pre-commit as much memory as
+	 * we will be preallocating for the main shared pool,
+	 * especially with memory locking in effect. In that case,
+	 * creating a temporary single-page pool is enough to figure
+	 * out the allocation overhead.
 	 */
-	mem = tlsf_malloc(__copperplate_setup_data.mem_pool);
-	size = init_memory_pool(__copperplate_setup_data.mem_pool, mem);
-	if (size == (size_t)-1)
+	mem = tlsf_malloc(alloc_size);
+	available_size = init_memory_pool(alloc_size, mem);
+	if (available_size == (size_t)-1)
 		panic("cannot initialize TLSF memory manager");
 
 	destroy_memory_pool(mem);
-	tlsf_pool_overhead = __copperplate_setup_data.mem_pool - size;
+	tlsf_pool_overhead = alloc_size - available_size;
 	tlsf_pool_overhead = (tlsf_pool_overhead + 1024) & ~15;
 	tlsf_free(mem);
 
-- 
2.7.4


