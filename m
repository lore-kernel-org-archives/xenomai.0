From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH 2/2] Simplify xenomai_count_leading_zeros
Date: Wed, 13 Mar 2019 18:16:32 +0100
Message-Id: <20190313171632.5276-3-norbert.lange@andritz.com>
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

Covers now all standard integer types,
no need for corner cases.

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 include/boilerplate/compiler.h | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/include/boilerplate/compiler.h b/include/boilerplate/compiler.h
index e25ab5d2c..828755cc1 100644
--- a/include/boilerplate/compiler.h
+++ b/include/boilerplate/compiler.h
@@ -72,32 +72,19 @@
 extern "C" {
 #endif
 
-void __invalid_operand_size(void);
-
 #define xenomai_count_trailing_zeros(x)					\
 	( (x) == 0 ? (int)(sizeof(x) * __CHAR_BIT__)			\
 	: sizeof(x) <= sizeof(unsigned) ? __builtin_ctz(x)		\
 	: sizeof(x) <= sizeof(unsigned long) ? __builtin_ctzl(x)	\
 	: __builtin_ctzll(x))
 
-#define xenomai_count_leading_zeros(__v)				\
-	({								\
-		int __ret;						\
-		if (!__v)						\
-			__ret = sizeof(__v) * 8;			\
-		else							\
-			switch (sizeof(__v)) {				\
-			case sizeof(int):				\
-				__ret = __builtin_clz((unsigned int)__v); \
-				break;					\
-			case sizeof(long long):				\
-				__ret = __builtin_clzll(__v);		\
-				break;					\
-			default:					\
-				__invalid_operand_size();		\
-			}						\
-		__ret;							\
-	})
+#define xenomai_count_leading_zeros(x)					\
+	(int)( (x) == 0 ? sizeof(x) * __CHAR_BIT__			\
+	: ( sizeof(x) <= sizeof(unsigned) ?				\
+			__builtin_clz(x) + sizeof(unsigned) - sizeof(x)	\
+		: sizeof(x) <= sizeof(unsigned long) ?			\
+			__builtin_clzl(x) + sizeof(unsigned long) - sizeof(x) \
+		: __builtin_clzll(x) + sizeof(unsigned long long) - sizeof(x)))
 
 #ifdef __cplusplus
 }
-- 
2.20.1


