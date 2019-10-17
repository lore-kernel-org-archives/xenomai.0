From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] copperplate: heapmem: Handle size == 0 cleanly for
 heapobj_init_array_private
Message-ID: <a671814f-93a9-9ca7-2c8a-cf12e55156bd@siemens.com>
Date: Thu, 17 Oct 2019 20:00:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Reported by clang-9 scan-build: When size is 0, we will shift 1 beyond
the size of 'size'. That's undefined behavior.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/copperplate/heapobj-heapmem.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/copperplate/heapobj-heapmem.c b/lib/copperplate/heapobj-heapmem.c
index bc6e5f236b..3e1a1d926a 100644
--- a/lib/copperplate/heapobj-heapmem.c
+++ b/lib/copperplate/heapobj-heapmem.c
@@ -68,19 +68,19 @@ int __heapobj_init_private(struct heapobj *hobj, const char *name,
 int heapobj_init_array_private(struct heapobj *hobj, const char *name,
 			       size_t size, int elems)
 {
-	size_t log2 = sizeof(size) * CHAR_BIT - 1 -
-		xenomai_count_leading_zeros(size);
-
-	/*
-	 * Heapmem aligns individual object sizes on the next ^2
-	 * boundary, do likewise when determining the overall heap
-	 * size, so that we can allocate as many as @elems items.
-	 */
-	if (size & (size - 1))
-		log2++;
-
-	size = 1 << log2;
-
+	if (size != 0) {
+		size_t log2 = sizeof(size) * CHAR_BIT - 1 -
+			xenomai_count_leading_zeros(size);
+		/*
+		 * Heapmem aligns individual object sizes on the next ^2
+		 * boundary, do likewise when determining the overall heap
+		 * size, so that we can allocate as many as @elems items.
+		 */
+		if (size & (size - 1))
+			log2++;
+
+		size = 1 << log2;
+	}
 	return __bt(__heapobj_init_private(hobj, name,
 					   size * elems, NULL));
 }
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

