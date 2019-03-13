From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH 1/2] Rename __ctz to xenomai_count_trailing_zeros
Date: Wed, 13 Mar 2019 18:16:31 +0100
Message-Id: <20190313171632.5276-2-norbert.lange@andritz.com>
In-Reply-To: <20190313171632.5276-1-norbert.lange@andritz.com>
References: <20190313171632.5276-1-norbert.lange@andritz.com>
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

Because of conflicts with libc++ (v1/bit include file).
Simplify the macro as there shouldnt be any bad cornercases

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 include/boilerplate/compiler.h    | 23 +++++------------------
 lib/boilerplate/heapmem.c         |  2 +-
 lib/copperplate/heapobj-pshared.c |  2 +-
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/include/boilerplate/compiler.h b/include/boilerplate/compiler.h
index 0fcc17be1..e25ab5d2c 100644
--- a/include/boilerplate/compiler.h
+++ b/include/boilerplate/compiler.h
@@ -74,24 +74,11 @@ extern "C" {
 	
 void __invalid_operand_size(void);
 
-#define __ctz(__v)							\
-	({								\
-		int __ret;						\
-		if (!__v)						\
-			__ret = sizeof(__v) * 8;			\
-		else							\
-			switch (sizeof(__v)) {				\
-			case sizeof(int):				\
-				__ret = __builtin_ctz((unsigned int)__v); \
-				break;					\
-			case sizeof(long long):				\
-				__ret = __builtin_ctzll(__v);		\
-				break;					\
-			default:					\
-				__invalid_operand_size();		\
-			}						\
-		__ret;							\
-	})
+#define xenomai_count_trailing_zeros(x)					\
+	( (x) == 0 ? (int)(sizeof(x) * __CHAR_BIT__)			\
+	: sizeof(x) <= sizeof(unsigned) ? __builtin_ctz(x)		\
+	: sizeof(x) <= sizeof(unsigned long) ? __builtin_ctzl(x)	\
+	: __builtin_ctzll(x))
 
 #define xenomai_count_leading_zeros(__v)				\
 	({								\
diff --git a/lib/boilerplate/heapmem.c b/lib/boilerplate/heapmem.c
index 8728e0d15..e6369c715 100644
--- a/lib/boilerplate/heapmem.c
+++ b/lib/boilerplate/heapmem.c
@@ -476,7 +476,7 @@ void *heapmem_alloc(struct heap_memory *heap, size_t size)
 			bmask = ext->pagemap[pg].map;
 			if (bmask == -1U)
 				break;
-			b = __ctz(~bmask);
+			b = xenomai_count_trailing_zeros(~bmask);
 
 			/*
 			 * Got one block from the heading per-bucket
diff --git a/lib/copperplate/heapobj-pshared.c b/lib/copperplate/heapobj-pshared.c
index 5310d9092..d6cc51ae9 100644
--- a/lib/copperplate/heapobj-pshared.c
+++ b/lib/copperplate/heapobj-pshared.c
@@ -529,7 +529,7 @@ static void *sheapmem_alloc(struct shared_heap_memory *heap, size_t size)
 			bmask = ext->pagemap[pg].map;
 			if (bmask == -1U)
 				break;
-			b = __ctz(~bmask);
+			b = xenomai_count_trailing_zeros(~bmask);
 
 			/*
 			 * Got one block from the heading per-bucket
-- 
2.20.1


