Subject: [PATCH][stable/v3.0.x] Rename __clz to xenomai_count_leading_zeros
References: <VI1PR0701MB21260355274B872433DC1B60B5DA0@VI1PR0701MB2126.eurprd07.prod.outlook.com>
 <b4ce6760-78c2-e6ca-ca5b-e7e30a1006e9@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <72fff697-1d69-fd39-8a30-d5eb1794650a@siemens.com>
Date: Fri, 23 Nov 2018 14:51:56 +0100
MIME-Version: 1.0
In-Reply-To: <b4ce6760-78c2-e6ca-ca5b-e7e30a1006e9@siemens.com>
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
To: Giulio Moro <g.moro@qmul.ac.uk>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

From: Giulio Moro <giuliomoro@yahoo.it>

This is to avoid namespace conflicts (e.g.: with Clang's arm_acle.h)

Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
[Jan: back-ported to 3.0.x]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/boilerplate/compiler.h    | 2 +-
 lib/copperplate/heapobj-pshared.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/boilerplate/compiler.h b/include/boilerplate/compiler.h
index bcef7d4cc8..846cd79e82 100644
--- a/include/boilerplate/compiler.h
+++ b/include/boilerplate/compiler.h
@@ -83,7 +83,7 @@ void __invalid_operand_size(void);
 		__ret;							\
 	})
 
-#define __clz(__v)							\
+#define xenomai_count_leading_zeros(__v)				\
 	({								\
 		int __ret;						\
 		if (!__v)						\
diff --git a/lib/copperplate/heapobj-pshared.c b/lib/copperplate/heapobj-pshared.c
index d4324dfd11..0d640ca5b5 100644
--- a/lib/copperplate/heapobj-pshared.c
+++ b/lib/copperplate/heapobj-pshared.c
@@ -439,7 +439,8 @@ static void *alloc_block(struct shared_heap *heap, size_t size)
 	 */
 	if (size <= HOBJ_PAGE_SIZE * 2) {
 		/* Find log2(size). */
-		log2size = sizeof(size) * 8 - 1 - __clz(size);
+		log2size = sizeof(size) * 8 - 1 -
+			xenomai_count_leading_zeros(size);
 		if (size & (size - 1))
 			log2size++;
 		/* That is the actual block size we need. */
-- 
2.16.4

