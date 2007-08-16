Message-ID: <46C3FFD8.7010105@domain.hid>
Date: Thu, 16 Aug 2007 09:42:16 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050503090005040300040402"
Subject: [Xenomai-core] [PATCH] fls() not available in Linux 2.4
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
--------------050503090005040300040402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the attached patch fixes the following compilation error with Xenomai's 
head of trunk under Linux 2.4:

kernel/kernel.o(.text+0x135a4): In function `__rthal_generic_full_divmod64':
/temp/rtcan/devel/linuxppc_2_4_devel-xenomai/kernel/xenomai/arch/generic/hal.c:918: 
undefined reference to `fls'
kernel/kernel.o(.text+0x135b4):/temp/rtcan/devel/linuxppc_2_4_devel-xenomai/kernel/xenomai/arch/generic/hal.c:918: 
undefined reference to `fls'

Wolfgang.

--------------050503090005040300040402
Content-Type: text/x-patch;
 name="xenomai-fls.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-fls.patch"

Index: include/asm-generic/wrappers.h
===================================================================
--- include/asm-generic/wrappers.h	(revision 2922)
+++ include/asm-generic/wrappers.h	(working copy)
@@ -183,6 +183,18 @@ void show_stack(struct task_struct *task
 #define __deprecated  __attribute__((deprecated))
 #endif
 
+/*
+ * fls: find last (most-significant) bit set.
+ * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
+ */
+static __inline__ int fls(unsigned int x)
+{
+        int lz;
+
+        asm ("cntlzw %0,%1" : "=r" (lz) : "r" (x));
+        return 32 - lz;
+}
+
 #else /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0) */
 
 #define compat_module_param_array(name, type, count, perm) \

--------------050503090005040300040402--

