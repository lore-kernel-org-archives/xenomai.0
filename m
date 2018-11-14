From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 2/3] copperplate/heapmem: fix private heap inits
Date: Wed, 14 Nov 2018 11:41:51 +0100
Message-Id: <20181114104152.11627-2-rpm@xenomai.org>
In-Reply-To: <20181114104152.11627-1-rpm@xenomai.org>
References: <20181114104152.11627-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

This is a general fix for properly initializing private copperplate
heaps managed by the heapmem allocator:

- the heapmem descriptor must be allocated separately, not to consume
  space from the heap memory. At this chance, heapmem_init() must be
  given the right descriptor address, not NULL.

- heaps must account for the size of the meta data the allocator
  needs. Make sure to allocate this extra-space when no specific heap
  memory has been given.

- upon array allocation, align the item size used in calculating the
  overall heap size on the next power-of-two boundary, so that the
  required number of items can be obtained from the pool (as the
  caller may rightfully assume).

Without these changes, the private copperplate allocator simply cannot
work on top of heapmem, so keep them grouped.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/copperplate/heapobj.h     |  5 +++-
 lib/copperplate/heapobj-heapmem.c | 39 ++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/include/copperplate/heapobj.h b/include/copperplate/heapobj.h
index ade7e7565..f8d14a3aa 100644
--- a/include/copperplate/heapobj.h
+++ b/include/copperplate/heapobj.h
@@ -141,6 +141,7 @@ static inline char *pvstrdup(const char *ptr)
 
 #elif defined(CONFIG_XENO_HEAPMEM)
 
+#include <stdlib.h>
 #include <boilerplate/heapmem.h>
 
 extern struct heap_memory heapmem_main;
@@ -149,6 +150,8 @@ static inline
 void pvheapobj_destroy(struct heapobj *hobj)
 {
 	heapmem_destroy((struct heap_memory *)hobj->pool);
+	if (hobj->pool != (void *)&heapmem_main)
+		__STD(free(hobj->pool));
 }
 
 static inline
@@ -206,7 +209,7 @@ static inline char *pvstrdup(const char *ptr)
 
 #else /* !CONFIG_XENO_HEAPMEM, i.e. malloc */
 
-#include <malloc.h>
+#include <stdlib.h>
 
 static inline void *pvmalloc(size_t size)
 {
diff --git a/lib/copperplate/heapobj-heapmem.c b/lib/copperplate/heapobj-heapmem.c
index 5c0ce9b2d..2b99b3d39 100644
--- a/lib/copperplate/heapobj-heapmem.c
+++ b/lib/copperplate/heapobj-heapmem.c
@@ -29,13 +29,21 @@ struct heap_memory heapmem_main;
 int __heapobj_init_private(struct heapobj *hobj, const char *name,
 			   size_t size, void *mem)
 {
+	struct heap_memory *heap;
 	void *_mem = mem;
 	int ret;
 
+	heap = __STD(malloc(sizeof(*heap)));
+	if (heap == NULL)
+		return -ENOMEM;
+
 	if (mem == NULL) {
-		_mem = __STD(malloc(size));
-		if (_mem == NULL)
+		size = HEAPMEM_ARENA_SIZE(size); /* Count meta-data in. */
+		mem = __STD(malloc(size));
+		if (mem == NULL) {
+			__STD(free(heap));
 			return -ENOMEM;
+		}
 	}
 	
 	if (name)
@@ -43,24 +51,37 @@ int __heapobj_init_private(struct heapobj *hobj, const char *name,
 	else
 		snprintf(hobj->name, sizeof(hobj->name), "%p", hobj);
 
-	ret = heapmem_init(hobj->pool, _mem, size);
+	hobj->pool = heap;
+	hobj->size = size;
+
+	ret = heapmem_init(hobj->pool, mem, size);
 	if (ret) {
-		if (mem == NULL)
-			__STD(free(_mem));
+		if (_mem == NULL)
+			__STD(free(mem));
+		__STD(free(heap));
 		return ret;
 	}
 
-	hobj->pool = _mem;
-	hobj->size = size;
-
 	return 0;
 }
 
 int heapobj_init_array_private(struct heapobj *hobj, const char *name,
 			       size_t size, int elems)
 {
+	size_t log2 = sizeof(size) * CHAR_BIT - 1 - __clz(size);
+
+	/*
+	 * Heapmem aligns individual object sizes on the next ^2
+	 * boundary, do likewise when determining the overall heap
+	 * size, so that we can allocate as many as @elems items.
+	 */
+	if (size & (size - 1))
+		log2++;
+
+	size = 1 << log2;
+
 	return __bt(__heapobj_init_private(hobj, name,
-			   HEAPMEM_ARENA_SIZE(size * elems), NULL));
+					   size * elems, NULL));
 }
 
 int heapobj_pkg_init_private(void)
-- 
2.17.2


