Message-ID: <4537DF47.8040800@domain.hid>
Date: Thu, 19 Oct 2006 22:25:43 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080508050701030908020403"
Subject: [Xenomai-core] [PATCH] fixing __xn_put_user and __xn_get_user for
	PowerPC
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------080508050701030908020403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the attached patch fixes the problem described in the mail 
https://mail.gna.org/public/xenomai-core/2006-10/msg00037.html. Here is 
the ChangeLog entry:

       * include/asm-powerpc/wrappers.h, include/asm-powerpc/syscall.h:
       Since Linux 2.4.15, __put_user and __get_user call migth_sleep.
       To avoid that, wrapper functions have been added.

Wolfgang.

--------------080508050701030908020403
Content-Type: text/x-patch;
 name="xenomai-powerpc-put-get-user.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-powerpc-put-get-user.patch"

Index: include/asm-powerpc/syscall.h
===================================================================
--- include/asm-powerpc/syscall.h	(revision 1733)
+++ include/asm-powerpc/syscall.h	(working copy)
@@ -57,8 +57,8 @@
     ({ int __err__ = __copy_from_user_inatomic(dstP,srcP,n); __err__; })
 #define __xn_copy_to_user(task,dstP,srcP,n)  \
     ({ int __err__ = __copy_to_user_inatomic(dstP,srcP,n); __err__; })
-#define __xn_put_user(task,src,dstP)           __put_user(src,dstP)
-#define __xn_get_user(task,dst,srcP)           __get_user(dst,srcP)
+#define __xn_put_user(task,src,dstP)           wrap_put_user(src,dstP)
+#define __xn_get_user(task,dst,srcP)           wrap_get_user(dst,srcP)
 #define __xn_strncpy_from_user(task,dstP,srcP,n)    __strncpy_from_user(dstP,srcP,n)
 
 #define __xn_access_ok(task,type,addr,size)  wrap_range_ok(task,addr,size)
Index: include/asm-powerpc/wrappers.h
===================================================================
--- include/asm-powerpc/wrappers.h	(revision 1733)
+++ include/asm-powerpc/wrappers.h	(working copy)
@@ -49,4 +49,38 @@
 
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,15)
+
+#define wrap_put_user(src,dstP)           __put_user(src,dstP)
+#define wrap_get_user(dst,srcP)           __get_user(dst,srcP)
+
+#else /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,15) */
+
+/* from linux/include/asm-powerpc/uaccess.h */
+#define wrap_get_user(x, ptr)					\
+({								\
+	int __gu_size = sizeof(*(ptr));				\
+	long __gu_err;						\
+	unsigned long __gu_val;					\
+	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
+	__chk_user_ptr(ptr);					\
+	__get_user_size(__gu_val, __gu_addr, gu_size, __gu_err);\
+	(x) = (__typeof__(*(ptr)))__gu_val;			\
+	__gu_err;						\
+})
+
+#define wrap_put_user(x, ptr)					\
+({								\
+	int __pu_size = sizeof(*(ptr));				\
+	long __pu_err;						\
+	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
+	__chk_user_ptr(ptr);					\
+	__put_user_size((__typeof__(*(ptr)))(x),		\
+			__pu_addr, __pu_size, __pu_err);	\
+	__pu_err;						\
+})
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,15) */
+
+
 #endif /* _XENO_ASM_POWERPC_WRAPPERS_H */
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 1733)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2006-10-19  Wolfgang Grandegger  <wg@domain.hid>
+
+	* include/asm-powerpc/wrappers.h, include/asm-powerpc/syscall.h:
+	Since Linux 2.4.15, __put_user and __get_user call migth_sleep.
+	To avoid that, wrapper functions have been added.
+
 2006-10-18  Jan Kiszka  <jan.kiszka@domain.hid>
 
 	* configure.in, scripts/xeno-config.in: Reducing CFLAGS and LDFLAGS

--------------080508050701030908020403--

