From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] posix/compat: Avoid get/put_compat_sigset
Message-ID: <57478282-e4f3-3343-623f-60e9eb1c974e@siemens.com>
Date: Tue, 14 Apr 2020 08:15:08 +0200
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

Those functions will use plain copy_from/to_user, rather than the atomic
variant needed over real-time contexts. So just copy the kernel logic
into sys32_get/put_sigset.

Fixes: 6ec708e163cb ("Replace sigset_to/from_compat with post 4.14 versions")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../cobalt/include/asm-generic/xenomai/wrappers.h  | 21 ---------------
 kernel/cobalt/posix/compat.c                       | 30 ++++++++++++++++++++--
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index c4cad114c2..23993dcc15 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -38,27 +38,6 @@
  *   symbol, so that obsolete wrappers can be spotted.
  */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,15,0)
-#define get_compat_sigset(set, compat)					\
-({									\
-	compat_sigset_t set32;						\
-	int ret;							\
-									\
-	ret = cobalt_copy_from_user(&set32, compat, sizeof(compat_sigset_t)); \
-	if (!ret)							\
-		sigset_from_compat(set, &set32);			\
-	ret;								\
-})
-
-#define put_compat_sigset(compat, set, size)				\
-({									\
-	compat_sigset_t set32;						\
-									\
-	sigset_to_compat(&set32, set);					\
-	cobalt_copy_to_user(compat, &set32, size);			\
-})
-#endif /* < 4.15 */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,11,0)
 #define raw_copy_to_user(__to, __from, __n)	__copy_to_user_inatomic(__to, __from, __n)
 #define raw_copy_from_user(__to, __from, __n)	__copy_from_user_inatomic(__to, __from, __n)
diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
index dfc194ab7a..17968bff1d 100644
--- a/kernel/cobalt/posix/compat.c
+++ b/kernel/cobalt/posix/compat.c
@@ -313,13 +313,39 @@ EXPORT_SYMBOL_GPL(sys32_get_sigevent);
 
 int sys32_get_sigset(sigset_t *set, const compat_sigset_t *u_cset)
 {
-	return get_compat_sigset(set, u_cset);
+#ifdef __BIG_ENDIAN
+	compat_sigset_t v;
+
+	if (cobalt_copy_from_user(&v, u_cset, sizeof(compat_sigset_t)))
+		return -EFAULT;
+	switch (_NSIG_WORDS) {
+	case 4: set->sig[3] = v.sig[6] | (((long)v.sig[7]) << 32 );
+	case 3: set->sig[2] = v.sig[4] | (((long)v.sig[5]) << 32 );
+	case 2: set->sig[1] = v.sig[2] | (((long)v.sig[3]) << 32 );
+	case 1: set->sig[0] = v.sig[0] | (((long)v.sig[1]) << 32 );
+	}
+#else
+	if (cobalt_copy_from_user(set, u_cset, sizeof(compat_sigset_t)))
+		return -EFAULT;
+#endif
+	return 0;
 }
 EXPORT_SYMBOL_GPL(sys32_get_sigset);
 
 int sys32_put_sigset(compat_sigset_t *u_cset, const sigset_t *set)
 {
-	return put_compat_sigset(u_cset, set, sizeof(*u_cset));
+#ifdef __BIG_ENDIAN
+	compat_sigset_t v;
+	switch (_NSIG_WORDS) {
+	case 4: v.sig[7] = (set->sig[3] >> 32); v.sig[6] = set->sig[3];
+	case 3: v.sig[5] = (set->sig[2] >> 32); v.sig[4] = set->sig[2];
+	case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
+	case 1: v.sig[1] = (set->sig[0] >> 32); v.sig[0] = set->sig[0];
+	}
+	return cobalt_copy_to_user(u_cset, &v, sizeof(*u_cset)) ? -EFAULT : 0;
+#else
+	return cobalt_copy_to_user(u_cset, set, sizeof(*u_cset)) ? -EFAULT : 0;
+#endif
 }
 EXPORT_SYMBOL_GPL(sys32_put_sigset);
 
-- 
2.16.4

