From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 1/3] copperplate/heapobj-pshared: fix element size for array
 init
Date: Sun, 17 Nov 2019 12:40:58 +0100
Message-Id: <20191117114100.3473-1-rpm@xenomai.org>
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

Heapmem aligns every requested element size to the next ^2 boundary,
which must be accounted for when determining the raw size of the
sub-heap we need for storing the array.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 lib/copperplate/heapobj-pshared.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/copperplate/heapobj-pshared.c b/lib/copperplate/heapobj-pshared.c
index d6cc51ae9..5952d9f9c 100644
--- a/lib/copperplate/heapobj-pshared.c
+++ b/lib/copperplate/heapobj-pshared.c
@@ -1111,7 +1111,21 @@ int heapobj_init(struct heapobj *hobj, const char *name, size_t size)
 int heapobj_init_array(struct heapobj *hobj, const char *name,
 		       size_t size, int elems)
 {
-	size = __align_to(size, SHEAPMEM_MIN_ALIGN);
+	int log2size;
+
+	if (size < SHEAPMEM_MIN_ALIGN) {
+		size = SHEAPMEM_MIN_ALIGN;
+	} else {
+		log2size = sizeof(size) * CHAR_BIT - 1 -
+			xenomai_count_leading_zeros(size);
+		if (log2size < SHEAPMEM_PAGE_SHIFT) {
+			if (size & (size - 1))
+				log2size++;
+			size = 1 << log2size;
+		} else
+			size = __align_to(size, SHEAPMEM_PAGE_SIZE);
+	}
+
 	return __bt(heapobj_init(hobj, name, size * elems));
 }
 
-- 
2.21.0


