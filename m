Message-ID: <499D9164.1010600@domain.hid>
Date: Thu, 19 Feb 2009 18:05:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH] x86-2.6.28: fix NR_syscalls defines
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

I bet this is also broken in older kernels, but it should be mostly
harmless, may just add unneeded overhead to newer syscalls.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

---
 arch/x86/include/asm/unistd_32.h |    2 +-
 arch/x86/include/asm/unistd_64.h |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

Index: b/arch/x86/include/asm/unistd_32.h
===================================================================
--- a/arch/x86/include/asm/unistd_32.h
+++ b/arch/x86/include/asm/unistd_32.h
@@ -339,7 +339,7 @@
 #define __NR_pipe2		331
 #define __NR_inotify_init1	332

-#define NR_syscalls		327
+#define NR_syscalls		333

 #ifdef __KERNEL__

Index: b/arch/x86/include/asm/unistd_64.h
===================================================================
--- a/arch/x86/include/asm/unistd_64.h
+++ b/arch/x86/include/asm/unistd_64.h
@@ -654,8 +654,7 @@ __SYSCALL(__NR_pipe2, sys_pipe2)
 #define __NR_inotify_init1			294
 __SYSCALL(__NR_inotify_init1, sys_inotify_init1)

-
-#define NR_syscalls		286
+#define NR_syscalls		295

 #ifndef __NO_STUBS
 #define __ARCH_WANT_OLD_READDIR

