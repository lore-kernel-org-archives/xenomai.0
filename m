From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] Replace sigset_to/from_compat with post 4.14 versions
Message-ID: <2e30cb96-bab7-caa8-5244-b0cd7aa01caf@siemens.com>
Date: Fri, 31 May 2019 20:01:06 +0200
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

...while wrapping for 4.14 and earlier.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../cobalt/include/asm-generic/xenomai/wrappers.h  | 21 ++++++++++++++++++++
 kernel/cobalt/posix/compat.c                       | 23 ++--------------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 23993dcc15..c4cad114c2 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -38,6 +38,27 @@
  *   symbol, so that obsolete wrappers can be spotted.
  */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,15,0)
+#define get_compat_sigset(set, compat)					\
+({									\
+	compat_sigset_t set32;						\
+	int ret;							\
+									\
+	ret = cobalt_copy_from_user(&set32, compat, sizeof(compat_sigset_t)); \
+	if (!ret)							\
+		sigset_from_compat(set, &set32);			\
+	ret;								\
+})
+
+#define put_compat_sigset(compat, set, size)				\
+({									\
+	compat_sigset_t set32;						\
+									\
+	sigset_to_compat(&set32, set);					\
+	cobalt_copy_to_user(compat, &set32, size);			\
+})
+#endif /* < 4.15 */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4,11,0)
 #define raw_copy_to_user(__to, __from, __n)	__copy_to_user_inatomic(__to, __from, __n)
 #define raw_copy_from_user(__to, __from, __n)	__copy_from_user_inatomic(__to, __from, __n)
diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
index d7195be541..dfc194ab7a 100644
--- a/kernel/cobalt/posix/compat.c
+++ b/kernel/cobalt/posix/compat.c
@@ -313,32 +313,13 @@ EXPORT_SYMBOL_GPL(sys32_get_sigevent);
 
 int sys32_get_sigset(sigset_t *set, const compat_sigset_t *u_cset)
 {
-	compat_sigset_t cset;
-	int ret;
-
-	if (u_cset == NULL)
-		return -EFAULT;
-
-	ret = cobalt_copy_from_user(&cset, u_cset, sizeof(cset));
-	if (ret)
-		return ret;
-
-	sigset_from_compat(set, &cset);
-
-	return 0;
+	return get_compat_sigset(set, u_cset);
 }
 EXPORT_SYMBOL_GPL(sys32_get_sigset);
 
 int sys32_put_sigset(compat_sigset_t *u_cset, const sigset_t *set)
 {
-	compat_sigset_t cset;
-
-	if (u_cset == NULL)
-		return -EFAULT;
-
-	sigset_to_compat(&cset, set);
-
-	return cobalt_copy_to_user(u_cset, &cset, sizeof(cset));
+	return put_compat_sigset(u_cset, set, sizeof(*u_cset));
 }
 EXPORT_SYMBOL_GPL(sys32_put_sigset);
 
-- 
2.16.4

