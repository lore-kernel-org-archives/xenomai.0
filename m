From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH v2 1/2] Rename __ctz to xenomai_count_trailing_zeros
Date: Wed, 10 Apr 2019 13:17:36 +0200
Message-Id: <20190410111737.19098-2-norbert.lange@andritz.com>
In-Reply-To: <20190410111737.19098-1-norbert.lange@andritz.com>
References: <20190410111737.19098-1-norbert.lange@andritz.com>
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
Simplify the macro as there shouldn't be any bad cornercases

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 include/boilerplate/compiler.h    | 31 ++++++++++---------------------
 lib/boilerplate/heapmem.c         |  2 +-
 lib/copperplate/heapobj-pshared.c |  2 +-
 3 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/include/boilerplate/compiler.h b/include/boilerplate/compiler.h
index 0fcc17be1..0cd71b80a 100644
--- a/include/boilerplate/compiler.h
+++ b/include/boilerplate/compiler.h
@@ -71,27 +71,16 @@
 #ifdef __cplusplus
 extern "C" {
 #endif
-	
+
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
+	((x) == 0 ? (int)(sizeof(x) * __CHAR_BIT__)			\
+	: sizeof(x) <= sizeof(unsigned int) ?				\
+		__builtin_ctz((unsigned int)x)				\
+	: sizeof(x) <= sizeof(unsigned long) ?				\
+		__builtin_ctzl((unsigned long)x)			\
+	: __builtin_ctzll(x))
 
 #define xenomai_count_leading_zeros(__v)				\
 	({								\
@@ -111,9 +100,9 @@ void __invalid_operand_size(void);
 			}						\
 		__ret;							\
 	})
-	
+
 #ifdef __cplusplus
 }
 #endif
-	
+
 #endif /* _BOILERPLATE_COMPILER_H */
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


