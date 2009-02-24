Message-ID: <49A4375F.1090809@domain.hid>
Date: Tue, 24 Feb 2009 19:07:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Adjust stack size for x86 and tune default
	pool size
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

Given that x86-64 pushes quad words on the stack, we should better
double its default size (just like PowerPC does). And as 64-bit archs
uses larger task stacks, doubling their default stack pool size is a
good idea, too.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 include/asm-x86/system_64.h |    2 +-
 ksrc/nucleus/Kconfig        |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/asm-x86/system_64.h b/include/asm-x86/system_64.h
index b02faa3..18310a4 100644
--- a/include/asm-x86/system_64.h
+++ b/include/asm-x86/system_64.h
@@ -28,7 +28,7 @@
 #include <linux/ptrace.h>
 #include <asm-generic/xenomai/system.h>
 
-#define XNARCH_THREAD_STACKSZ	4096
+#define XNARCH_THREAD_STACKSZ	8192
 
 #define xnarch_stack_size(tcb)  ((tcb)->stacksize)
 #define xnarch_stack_base(tcb)	((tcb)->stackbase)
diff --git a/ksrc/nucleus/Kconfig b/ksrc/nucleus/Kconfig
index eb262ce..1d6a566 100644
--- a/ksrc/nucleus/Kconfig
+++ b/ksrc/nucleus/Kconfig
@@ -186,16 +186,16 @@ config XENO_OPT_SYS_HEAPSZ
 config XENO_OPT_SYS_STACKPOOLSZ
         depends on XENO_GENERIC_STACKPOOL
 	int "Size of the private stack pool (Kb)"
-	default 32
-	range 0 128
+	default 32 if !64BIT && !BLACKFIN
+	default 64 if 64BIT || BLACKFIN
 	help
 
 	On this architecture, kernel-based Xenomai threads get the
 	stack space they need from a private memory pool.  If you
 	don't start any kernel-based thread (i.e. no RTDM driver
-	thread, and no real-time task created from an application
-	embodied into a kernel module), you may leave a zero value for
-	this option. The size is expressed in Kilobytes.
+	thread, no real-time task created from an application embodied
+	into a kernel module, no switchtest driver), you may leave a
+	zero value for this option. The size is expressed in Kilobytes.
 
 if !XENO_GENERIC_STACKPOOL
 config XENO_OPT_SYS_STACKPOOLSZ

