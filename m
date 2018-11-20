From: Giulio Moro <g.moro@qmul.ac.uk>
Subject: [PATCH] Rename __clz to xenomai_count_leading_zeros to avoid
 namespace conflicts (e.g.: with Clang's arm_acle.h)
Date: Tue, 20 Nov 2018 22:34:07 +0000
Message-ID: <VI1PR0701MB21263CB2A981011DCA7BEA7BB5D90@VI1PR0701MB2126.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

>From de7bf8033570f15b68b00b6386097ceb8a402d6b Mon Sep 17 00:00:00 2001
From: Giulio Moro <giuliomoro@yahoo.it>
Date: Tue, 20 Nov 2018 22:32:00 +0000
Subject: [PATCH] Rename __clz to xenomai_count_leading_zeros to avoid
 namespace conflicts (e.g.: with Clang's arm_acle.h)

Signed-off-by: Giulio Moro <giuliomoro@yahoo.it>
---
 include/boilerplate/compiler.h    | 2 +-
 lib/boilerplate/heapmem.c         | 2 +-
 lib/copperplate/heapobj-heapmem.c | 2 +-
 lib/copperplate/heapobj-pshared.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/boilerplate/compiler.h b/include/boilerplate/compiler.=
h
index ffeb6a4db..0fcc17be1 100644
--- a/include/boilerplate/compiler.h
+++ b/include/boilerplate/compiler.h
@@ -93,7 +93,7 @@ void __invalid_operand_size(void);
 		__ret;							\
 	})

-#define __clz(__v)							\
+#define xenomai_count_leading_zeros(__v)				\
 	({								\
 		int __ret;						\
 		if (!__v)						\
diff --git a/lib/boilerplate/heapmem.c b/lib/boilerplate/heapmem.c
index 9b5e1a636..81702d6db 100644
--- a/lib/boilerplate/heapmem.c
+++ b/lib/boilerplate/heapmem.c
@@ -435,7 +435,7 @@ void *heapmem_alloc(struct heap_memory *heap, size_t si=
ze)
 		bsize =3D size =3D HEAPMEM_MIN_ALIGN;
 		log2size =3D HEAPMEM_MIN_LOG2;
 	} else {
-		log2size =3D sizeof(size) * CHAR_BIT - 1 - __clz(size);
+		log2size =3D sizeof(size) * CHAR_BIT - 1 - xenomai_count_leading_zeros(s=
ize);
 		if (log2size < HEAPMEM_PAGE_SHIFT) {
 			if (size & (size - 1))
 				log2size++;
diff --git a/lib/copperplate/heapobj-heapmem.c b/lib/copperplate/heapobj-he=
apmem.c
index 2b99b3d39..60f16f95d 100644
--- a/lib/copperplate/heapobj-heapmem.c
+++ b/lib/copperplate/heapobj-heapmem.c
@@ -68,7 +68,7 @@ int __heapobj_init_private(struct heapobj *hobj, const ch=
ar *name,
 int heapobj_init_array_private(struct heapobj *hobj, const char *name,
 			       size_t size, int elems)
 {
-	size_t log2 =3D sizeof(size) * CHAR_BIT - 1 - __clz(size);
+	size_t log2 =3D sizeof(size) * CHAR_BIT - 1 - xenomai_count_leading_zeros=
(size);

 	/*
 	 * Heapmem aligns individual object sizes on the next ^2
diff --git a/lib/copperplate/heapobj-pshared.c b/lib/copperplate/heapobj-ps=
hared.c
index 77b45844f..5f17e6198 100644
--- a/lib/copperplate/heapobj-pshared.c
+++ b/lib/copperplate/heapobj-pshared.c
@@ -488,7 +488,7 @@ static void *sheapmem_alloc(struct shared_heap_memory *=
heap, size_t size)
 		bsize =3D size =3D SHEAPMEM_MIN_ALIGN;
 		log2size =3D SHEAPMEM_MIN_LOG2;
 	} else {
-		log2size =3D sizeof(size) * CHAR_BIT - 1 - __clz(size);
+		log2size =3D sizeof(size) * CHAR_BIT - 1 - xenomai_count_leading_zeros(s=
ize);
 		if (log2size < SHEAPMEM_PAGE_SHIFT) {
 			if (size & (size - 1))
 				log2size++;
--
2.11.0

