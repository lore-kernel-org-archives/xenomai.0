Message-ID: <4838622E.4020108@domain.hid>
Date: Sat, 24 May 2008 20:45:02 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Some issues with Xenomai 2.4.x on DENX Linux 2.4.25
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

Hello,

the patch below fixes some issues with cross compiling the 
DENX linuxppc_2_4_devel tree (2.4.25) for the MPC5200. I
think they are present on Xenomai trunk as well (and even
a few more).

Wolfgang.

Index: include/asm-generic/wrappers.h
===================================================================
--- include/asm-generic/wrappers.h	(revision 3869)
+++ include/asm-generic/wrappers.h	(working copy)
@@ -34,6 +34,7 @@
 #include <linux/wrapper.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/bitops.h>
 #include <linux/moduleparam.h>	/* Use the backport. */
 
 /* Compiler */
@@ -186,6 +187,10 @@ void show_stack(struct task_struct *task
 #define __deprecated  __attribute__((deprecated))
 #endif
 
+#ifndef BITOP_WORD
+#define BITOP_WORD(nr)	((nr) / BITS_PER_LONG)
+#endif
+
 #else /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0) */
 
 #define compat_module_param_array(name, type, count, perm) \
Index: ksrc/arch/generic/compat.c
===================================================================
--- ksrc/arch/generic/compat.c	(revision 3869)
+++ ksrc/arch/generic/compat.c	(working copy)
@@ -1,3 +1,4 @@
+#include <asm/xenomai/wrappers.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
 #include <linux/unistd.h>
@@ -108,7 +109,7 @@ EXPORT_SYMBOL(kthread_create);
 EXPORT_SYMBOL(kthread_should_stop);
 EXPORT_SYMBOL(kthread_stop);
 
-static inline unsigned long __ffs(unsigned long word)
+static inline unsigned long __ffs_compat(unsigned long word)
 {
 	if ((unsigned)(word))
 		return ffs(word) - 1;
@@ -157,5 +158,5 @@ found_first:
         if (tmp == 0UL)         /* Are any bits set? */
                 return result + size;   /* Nope. */
 found_middle:
-        return result + __ffs(tmp);
+        return result + __ffs_compat(tmp);
 }

