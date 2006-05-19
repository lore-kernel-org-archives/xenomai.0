Message-ID: <446D92F2.6000706@domain.hid>
Date: Fri, 19 May 2006 11:42:10 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020301040004010903040007"
Subject: [Xenomai-core] rtdm_safe_copy_from_user...
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
--------------020301040004010903040007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I propose to add the following commonly used RTDM inline functions to
rtdm_driver.h:

    static inline int rtdm_safe_copy_from_user()
    static inline int rtdm_safe_copy_to_user()

The attached patch also fixes a bug in rtdm_strncpy_from_user(). I think
__xn_access_ok() returns a non-zero value if the access is safe. Has it
ever worked? I don't care about the real name.

Wolfgang.


--------------020301040004010903040007
Content-Type: text/x-patch;
 name="rtdm-safe-copy-user.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtdm-safe-copy-user.patch"

+ diff -u xenomai/include/rtdm/rtdm_driver.h.ORIG xenomai/include/rtdm/rtdm_driver.h
--- xenomai/include/rtdm/rtdm_driver.h.ORIG	2006-04-23 09:40:39.000000000 +0200
+++ xenomai/include/rtdm/rtdm_driver.h	2006-05-19 10:38:20.654561392 +0200
@@ -1047,12 +1047,30 @@
     return __xn_copy_to_user(user_info, dst, src, size);
 }
 
+static inline int rtdm_safe_copy_from_user(rtdm_user_info_t *user_info,
+					   void *dst, const void __user *src,
+					   size_t size)
+{
+    if (unlikely(!__xn_access_ok(user_info, VERIFY_READ, src, 1)))
+        return -EFAULT;
+    return __xn_copy_from_user(user_info, dst, src, size);
+}
+
+static inline int rtdm_safe_copy_to_user(rtdm_user_info_t *user_info,
+					 void __user *dst, const void *src,
+					 size_t size)
+{
+    if (unlikely(!__xn_access_ok(user_info, VERIFY_WRITE, src, 1)))
+        return -EFAULT;
+    return __xn_copy_to_user(user_info, dst, src, size);
+}
+
 static inline int rtdm_strncpy_from_user(rtdm_user_info_t *user_info,
                                          char *dst,
                                          const char __user *src,
                                          size_t count)
 {
-    if (unlikely(__xn_access_ok(user_info, VERIFY_READ, src, 1)))
+    if (unlikely(!__xn_access_ok(user_info, VERIFY_READ, src, 1)))
         return -EFAULT;
     return __xn_strncpy_from_user(user_info, dst, src, count);
 }


--------------020301040004010903040007--

