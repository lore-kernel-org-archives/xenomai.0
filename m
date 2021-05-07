From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH wip/dovetail 1/1] cobalt: Remove duplicate timespec/itimerspec
 copy helpers
Date: Fri,  7 May 2021 17:18:30 +0200
Message-Id: <20210507151830.1260775-2-florian.bezdeka@siemens.com>
In-Reply-To: <20210507151830.1260775-1-florian.bezdeka@siemens.com>
References: <20210507151830.1260775-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The variant of such helpers which are using a temporary element on the
stack work in both worlds, so on systems with 4 and 8 byte time_t.
To keep the code as simple as possible we can remove the
__BITS_PER_LONG == 64 implementation.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 .../include/asm-generic/xenomai/syscall.h     | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index 194583c18..117bb3ff8 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -75,41 +75,12 @@ static inline int cobalt_strncpy_from_user(char *dst, const char __user *src,
 	return __xn_strncpy_from_user(dst, src, count);
 }
 
-#if __BITS_PER_LONG == 64
 
 /*
  * NOTE: those copy helpers won't work in compat mode: use
  * sys32_get_*(), sys32_put_*() instead.
  */
 
-static inline int cobalt_get_u_timespec(struct timespec64 *dst,
-			const struct __user_old_timespec __user *src)
-{
-	return cobalt_copy_from_user(dst, src, sizeof(*dst));
-}
-
-static inline int cobalt_put_u_timespec(
-	struct __user_old_timespec __user *dst,
-	const struct timespec64 *src)
-{
-	return cobalt_copy_to_user(dst, src, sizeof(*dst));
-}
-
-static inline int cobalt_get_u_itimerspec(struct itimerspec64 *dst,
-			const struct __user_old_itimerspec __user *src)
-{
-	return cobalt_copy_from_user(dst, src, sizeof(*dst));
-}
-
-static inline int cobalt_put_u_itimerspec(
-	struct __user_old_itimerspec __user *dst,
-	const struct itimerspec64 *src)
-{
-	return cobalt_copy_to_user(dst, src, sizeof(*dst));
-}
-
-#else /* __BITS_PER_LONG == 32 */
-
 static inline int cobalt_get_u_timespec(struct timespec64 *dst,
 			const struct __user_old_timespec __user *src)
 {
@@ -175,8 +146,6 @@ static inline int cobalt_put_u_itimerspec(
 	return cobalt_copy_to_user(dst, &u_its, sizeof(*dst));
 }
 
-#endif
-
 /* 32bit syscall emulation */
 #define __COBALT_COMPAT_BIT	0x1
 /* 32bit syscall emulation - extended form */
-- 
2.31.1


