Message-ID: <46924A1A.4010909@domain.hid>
Date: Mon, 09 Jul 2007 16:45:46 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030808090402080709070407"
Subject: [Xenomai-core] [PATCH] __deprecated not defined for Linux 2.4
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
--------------030808090402080709070407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the attached patch changes:

   2007-07-09  Wolfgang Grandegger  <wg@domain.hid>

  * include/asm-generic/wrappers.h: add  __deprecated for Linux 2.4.

Wolfgang.



--------------030808090402080709070407
Content-Type: text/x-patch;
 name="xenomai__deprecated.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai__deprecated.patch"

Index: include/asm-generic/wrappers.h
===================================================================
--- include/asm-generic/wrappers.h	(revision 2758)
+++ include/asm-generic/wrappers.h	(working copy)
@@ -179,6 +179,8 @@ void show_stack(struct task_struct *task
 
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
 
+#define __deprecated  __attribute__((deprecated))
+
 #else /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0) */
 
 #define compat_module_param_array(name, type, count, perm) \
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 2758)
+++ ChangeLog	(working copy)
@@ -1,3 +1,7 @@
+2007-07-09  Wolfgang Grandegger  <wg@domain.hid>
+
+	* include/asm-generic/wrappers.h: add  __deprecated for Linux 2.4.
+
 2007-07-08  Philippe Gerum  <rpm@xenomai.org>
 
 	* xenomai: Upgrade to autoconf 2.61, automake 1.10, libtool

--------------030808090402080709070407--

