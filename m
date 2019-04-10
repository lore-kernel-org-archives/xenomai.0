From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH v2 2/2] Simplify xenomai_count_leading_zeros
Date: Wed, 10 Apr 2019 13:17:37 +0200
Message-Id: <20190410111737.19098-3-norbert.lange@andritz.com>
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

Covers now all standard integer types,
no need for corner cases.

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 include/boilerplate/compiler.h | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/include/boilerplate/compiler.h b/include/boilerplate/compiler.h
index 0cd71b80a..94b9f8cad 100644
--- a/include/boilerplate/compiler.h
+++ b/include/boilerplate/compiler.h
@@ -72,8 +72,6 @@
 extern "C" {
 #endif
 
-void __invalid_operand_size(void);
-
 #define xenomai_count_trailing_zeros(x)					\
 	((x) == 0 ? (int)(sizeof(x) * __CHAR_BIT__)			\
 	: sizeof(x) <= sizeof(unsigned int) ?				\
@@ -82,24 +80,14 @@ void __invalid_operand_size(void);
 		__builtin_ctzl((unsigned long)x)			\
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
+	((x) == 0 ? (int)(sizeof(x) * __CHAR_BIT__)			\
+	: sizeof(x) <= sizeof(unsigned int) ?				\
+		__builtin_clz((unsigned int)x) +			\
+			(int)(sizeof(unsigned int) - sizeof(x))		\
+	: sizeof(x) <= sizeof(unsigned long) ?				\
+		__builtin_clzl((unsigned long)x)			\
+	: __builtin_clzll(x))
 
 #ifdef __cplusplus
 }
-- 
2.20.1


