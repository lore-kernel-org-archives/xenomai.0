From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] lib/copperplate: heapobj: catch invalid array-type init
 request
Date: Fri, 18 Oct 2019 10:15:55 +0200
Message-Id: <20191018081555.9690-1-rpm@xenomai.org>
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

Setting up a zero-size, zero-element array makes no sense with this
interface. Catch this early on, bailing out with -EINVAL.
---
 lib/copperplate/heapobj-heapmem.c | 7 ++++++-
 lib/copperplate/heapobj-malloc.c  | 3 +++
 lib/copperplate/heapobj-tlsf.c    | 3 +++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/copperplate/heapobj-heapmem.c b/lib/copperplate/heapobj-heapmem.c
index bc6e5f236..cc3eb0aa1 100644
--- a/lib/copperplate/heapobj-heapmem.c
+++ b/lib/copperplate/heapobj-heapmem.c
@@ -68,7 +68,12 @@ int __heapobj_init_private(struct heapobj *hobj, const char *name,
 int heapobj_init_array_private(struct heapobj *hobj, const char *name,
 			       size_t size, int elems)
 {
-	size_t log2 = sizeof(size) * CHAR_BIT - 1 -
+	size_t log2;
+
+	if (size == 0 || elems <= 0)
+		return __bt(-EINVAL);
+
+	log2 = sizeof(size) * CHAR_BIT - 1 -
 		xenomai_count_leading_zeros(size);
 
 	/*
diff --git a/lib/copperplate/heapobj-malloc.c b/lib/copperplate/heapobj-malloc.c
index a3918cc23..cde5672f5 100644
--- a/lib/copperplate/heapobj-malloc.c
+++ b/lib/copperplate/heapobj-malloc.c
@@ -84,6 +84,9 @@ int __heapobj_init_private(struct heapobj *hobj, const char *name,
 int heapobj_init_array_private(struct heapobj *hobj, const char *name,
 			       size_t size, int elems)
 {
+	if (size == 0 || elems <= 0)
+		return __bt(-EINVAL);
+
 	return __bt(__heapobj_init_private(hobj, name, size * elems, NULL));
 }
 
diff --git a/lib/copperplate/heapobj-tlsf.c b/lib/copperplate/heapobj-tlsf.c
index 2f5be4cd2..2d57e3c05 100644
--- a/lib/copperplate/heapobj-tlsf.c
+++ b/lib/copperplate/heapobj-tlsf.c
@@ -69,6 +69,9 @@ int heapobj_init_array_private(struct heapobj *hobj, const char *name,
 {
 	size_t poolsz;
 
+	if (size == 0 || elems <= 0)
+		return __bt(-EINVAL);
+
 	poolsz = (size + TLSF_BLOCK_ALIGN - 1) & ~(TLSF_BLOCK_ALIGN - 1);
 	poolsz *= elems;
 
-- 
2.21.0


